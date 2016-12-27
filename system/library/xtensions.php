<?php
class Xtensions extends Controller {
	private $active;
	private $modData = array();
	private $single_box;
	private $isOpencartTwo;
	private $customFieldPrefix;
	private $viewVersion;
	private $newCustomerPath = false;

	/* Constructor */
	public function __construct($registry) {
		parent::__construct($registry);
		$this->db = $registry->get('db');
		$this->install();
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "signupkw LIMIT 1");
		$this->active = $query->row['enablemod'];
		$this->single_box = $query->row['single_box'];
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "signupkw_attributes LIMIT 1");
		$this->modData = $query->row;
		if(version_compare(VERSION, '2.0.0.0')>=0){
			$this->isOpencartTwo = true;
			$this->customFieldPrefix = DB_PREFIX;
			$this->viewVersion = '2.x.x.x';
			if(version_compare(VERSION, '2.1.0.1')>=0){
				$this->newCustomerPath = true;
			}
		}else{
			$this->isOpencartTwo = false;
			$this->customFieldPrefix = DB_PREFIX.'x';
			$this->viewVersion = '1.5.x.x';
		}
	} 
	/* Getters*/
	public function getXData(){
		return array(
		'isActive' => $this->active,
		'single_box' => $this->single_box,
		'modData' => $this->modData,
		'isOpencartTwo'=>$this->isOpencartTwo,
		);
	}

	public function isActive(){
		return $this->active;
	}

	public function getModData(){
		return $this->modData;
	}

	public function isOpencartTwo(){
		return $this->isOpencartTwo;
	}


	public function isNewCustomerPath(){
		return $this->newCustomerPath;
	}

	public function customFieldPrefix(){
		return $this->customFieldPrefix;
	}

	public function viewVersion(){
		return $this->viewVersion;
	}

	/* address getters with formatting- formatting includes custom fields- start*/
	public function getAddresses($obj){
		$address_data = array();

		$query = $obj->db->query("SELECT * FROM " . DB_PREFIX . "address WHERE customer_id = '" . (int)$obj->customer->getId() . "'");

		foreach ($query->rows as $result) {
			$country_query = $obj->db->query("SELECT * FROM `" . DB_PREFIX . "country` WHERE country_id = '" . (int)$result['country_id'] . "'");

			if ($country_query->num_rows) {
				$country = $country_query->row['name'];
				$iso_code_2 = $country_query->row['iso_code_2'];
				$iso_code_3 = $country_query->row['iso_code_3'];
				$address_format = $country_query->row['address_format'];
			} else {
				$country = '';
				$iso_code_2 = '';
				$iso_code_3 = '';
				$address_format = '';
			}

			$zone_query = $obj->db->query("SELECT * FROM `" . DB_PREFIX . "zone` WHERE zone_id = '" . (int)$result['zone_id'] . "'");

			if ($zone_query->num_rows) {
				$zone = $zone_query->row['name'];
				$zone_code = $zone_query->row['code'];
			} else {
				$zone = '';
				$zone_code = '';
			}


			$obj->load->model('account/xcustom_field');
			$identified_data = $obj->model_account_xcustom_field->getCustomFieldByIdentifier($this->unserialize($result['custom_field']),'address');

			$address_data[$result['address_id']] = array(
				'address_id'     => $result['address_id'],
				'identified_data'=> $identified_data,
				'firstname'      => $result['firstname'],
				'lastname'       => $result['lastname'],
				'company'        => $result['company'],
				'company_id'     => isset($result['company_id'])?$result['company_id']:"",
				'tax_id'         => isset($result['tax_id'])?$result['tax_id']:"",
				'address_1'      => $result['address_1'],
				'address_2'      => $result['address_2'],
				'postcode'       => $result['postcode'],
				'city'           => $result['city'],
				'zone_id'        => $result['zone_id'],
				'zone'           => $zone,
				'zone_code'      => $zone_code,
				'country_id'     => $result['country_id'],
				'country'        => $country,
				'iso_code_2'     => $iso_code_2,
				'iso_code_3'     => $iso_code_3,
				'address_format' => $address_format,
				'custom_field'   => $this->unserialize($result['custom_field'])
			);
		}


		foreach ($address_data as $result){
			$formatted_address = $obj->model_account_xcustom_field->getFormattedAddress($address_data[$result['address_id']]);
			$address_data[$result['address_id']] = array_merge($address_data[$result['address_id']],array('formatted_address'=>$formatted_address));
		}

		return $address_data;
	}

	public function getAddress($obj,$address_id){
		$address_query = $obj->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "address WHERE address_id = '" . (int)$address_id . "' AND customer_id = '" . (int)$obj->customer->getId() . "'");

		if ($address_query->num_rows) {
			$country_query = $obj->db->query("SELECT * FROM `" . DB_PREFIX . "country` WHERE country_id = '" . (int)$address_query->row['country_id'] . "'");

			if ($country_query->num_rows) {
				$country = $country_query->row['name'];
				$iso_code_2 = $country_query->row['iso_code_2'];
				$iso_code_3 = $country_query->row['iso_code_3'];
				$address_format = $country_query->row['address_format'];
			} else {
				$country = '';
				$iso_code_2 = '';
				$iso_code_3 = '';
				$address_format = '';
			}

			$zone_query = $obj->db->query("SELECT * FROM `" . DB_PREFIX . "zone` WHERE zone_id = '" . (int)$address_query->row['zone_id'] . "'");

			if ($zone_query->num_rows) {
				$zone = $zone_query->row['name'];
				$zone_code = $zone_query->row['code'];
			} else {
				$zone = '';
				$zone_code = '';
			}

			$obj->load->model('account/xcustom_field');
			$identified_data = $obj->model_account_xcustom_field->getCustomFieldByIdentifier($this->unserialize($address_query->row['custom_field']),'address');
			$address_data = array(
				'address_id'     => $address_query->row['address_id'],
				'identified_data'=> $identified_data,				
				'firstname'      => $address_query->row['firstname'],
				'lastname'       => $address_query->row['lastname'],
				'company'        => $address_query->row['company'],
				'company_id'     => isset($address_query->row['company_id'])?$address_query->row['company_id']:"",
				'tax_id'         => isset($address_query->row['tax_id'])?$address_query->row['tax_id']:"",
				'address_1'      => $address_query->row['address_1'],
				'address_2'      => $address_query->row['address_2'],
				'postcode'       => $address_query->row['postcode'],
				'city'           => $address_query->row['city'],
				'zone_id'        => $address_query->row['zone_id'],
				'zone'           => $zone,
				'zone_code'      => $zone_code,
				'country_id'     => $address_query->row['country_id'],
				'country'        => $country,
				'iso_code_2'     => $iso_code_2,
				'iso_code_3'     => $iso_code_3,
				'address_format' => $address_format,
				'custom_field'   => $this->unserialize($address_query->row['custom_field'])
			);
			$formatted_address = $obj->model_account_xcustom_field->getFormattedAddress($address_data);
			$address_data = array_merge($address_data,array('formatted_address'=>$formatted_address));
			return $address_data;
		} else {
			return false;
		}
	}
	/* address getters with formatting- formatting includes custom fields- end*/

	/* Fill up the missing fields for register page with blank data if fields are hidden- start*/
	public function getRegisterPostData($data,$page='r'){
		$fields = array('firstname','lastname','email','telephone','fax','company','company_id','tax_id','address_1','address_2','city','postcode','zone_id','country_id', 'newsletter');
		foreach ($fields as $field){
			$defaults[$field] = '';
		}
		if($page!='r'){
			$defaults['custom_field']['account'] = isset($data['custom_field'])?$data['custom_field']:array();
			$defaults['noaddress'] = true;
		}else{
			if($this->modData['show_address']){
				$defaults['noaddress'] = true;
			}
		}
		$defaults = array_merge($defaults,$data);
		return $defaults;
	}
	/* Fill up the missing fields for register page with blank data if fields are hidden- end*/

	/* Engine functions for data rendering- start*/
	public function getChildren($children){
		foreach ($children as $child){
			if($this->isOpencartTwo){
				$data[basename($child)] = $this->load->controller($child);
			}else{
				$data[basename($child)] = $this->getChild($child);
			}
		}
		return $data;
	}

	public function redirect($url,$status = 302){
		if($this->isOpencartTwo){
			$this->response->redirect($url);
		}else{
			parent::redirect($url);
		}
	}

	public function renderView($obj){
		if($this->isOpencartTwo){
			return $this->load->view($obj->template,$obj->data);
		}else{
			return $obj->render();
		}
	}
	
	public function unserialize($data=array()){
		if($this->newCustomerPath){
			return json_decode($data,true);
		}else{
			return unserialize($data);
		}			
	}
	/* Engine functions for data rendering- end*/

	/* Admin related and installation functions - start*/
	public function validate(&$obj) {
		if (!$obj->user->hasPermission('modify', 'module/signup')) {
			$obj->error['warning'] = $obj->language->get('error_permission');
			return false;
		}
		$this->editSetting($obj->request->post);
		$obj->session->data['success'] = $obj->language->get('text_success');
		$this->redirect($obj->url->link('module/signup', 'token=' . $obj->session->data['token'], 'SSL'));
	}

	private function install() {
		$sql = " SHOW TABLES LIKE '".DB_PREFIX."signupkw'";
		$query = $this->db->query( $sql );
		if( count($query->rows) <=0 ){
			$sql = array();
			$sql[]  = "create table if not exists ".DB_PREFIX."signupkw (
                                   enablemod tinyint(0) not null default 0,
                                     single_box tinyint(0) not null default 0
                                   )";
			$sql[]  = "create table if not exists ".DB_PREFIX."signupkw_attributes(
                                    f_name_show tinyint(0) not null default 1 ,f_name_req tinyint(0)  not null default 1,f_name_cstm varchar(255) not null default '',
                                    l_name_show tinyint(0) not null default 1 ,l_name_req tinyint(0)  not null default 1,l_name_cstm varchar(255) not null default '',
                                    mob_show tinyint(0) not null default 1 ,mob_req tinyint(0)  not null default 1,mob_cstm varchar(255) not null default '',
                                    fax_show tinyint(0) not null default 1 ,fax_req tinyint(0)  not null default 1,fax_cstm varchar(255) not null default '',
                                    company_show tinyint(0) not null default 1 ,company_req tinyint(0)  not null default 1,company_cstm varchar(255) not null default '',
                                    companyId_show tinyint(0) not null default 1 ,companyId_req tinyint(0)  not null default 1,companyId_cstm varchar(255) not null default '',
                                    address1_show tinyint(0) not null default 1 ,address1_req tinyint(0)  not null default 1,address1_cstm varchar(255) not null default '',
                                    address2_show tinyint(0) not null default 1 ,address2_req tinyint(0)  not null default 1,address2_cstm varchar(255) not null default '',
                                    city_show tinyint(0) not null default 1 ,city_req tinyint(0)  not null default 1,city_cstm varchar(255) not null default '',
                                    pin_show tinyint(0) not null default 1 ,pin_req tinyint(0)  not null default 1,pin_cstm varchar(255) not null default '',
                                    state_show tinyint(0) not null default 1 ,state_req tinyint(0)  not null default 1,state_cstm varchar(255) not null default '',
                                    country_show tinyint(0) not null default 1 ,country_req tinyint(0)  not null default 1,country_cstm varchar(255) not null default '',
                                    passconf_show tinyint(0) not null default 1 ,passconf_req tinyint(0)  not null default 1,passconf_cstm varchar(255) not null default '',
                                    subsribe_show tinyint(0) not null default 1 ,subsribe_req tinyint(0)  not null default 1,subsribe_cstm varchar(255) not null default '',
									f_name_show_edit tinyint(0) not null default 1 ,f_name_req_edit tinyint(0)  not null default 1,
									l_name_show_edit tinyint(0) not null default 1 ,l_name_req_edit tinyint(0)  not null default 1,
                                    mob_show_edit tinyint(0) not null default 1 ,mob_req_edit tinyint(0)  not null default 1,
                                    fax_show_edit tinyint(0) not null default 1 ,fax_req_edit tinyint(0)  not null default 1,
                                    company_show_edit tinyint(0) not null default 1 ,company_req_edit tinyint(0)  not null default 1,
                                    companyId_show_edit tinyint(0) not null default 1 ,companyId_req_edit tinyint(0)  not null default 1,
                                    address1_show_edit tinyint(0) not null default 1 ,address1_req_edit tinyint(0)  not null default 1,
                                    address2_show_edit tinyint(0) not null default 1 ,address2_req_edit tinyint(0)  not null default 1,
                                    city_show_edit tinyint(0) not null default 1 ,city_req_edit tinyint(0)  not null default 1,
                                    pin_show_edit tinyint(0) not null default 1 ,pin_req_edit tinyint(0)  not null default 1,
                                    state_show_edit tinyint(0) not null default 1 ,state_req_edit tinyint(0)  not null default 1,
                                    country_show_edit tinyint(0) not null default 1 ,country_req_edit tinyint(0)  not null default 1,
                                    passconf_show_edit tinyint(0) not null default 1 ,passconf_req_edit tinyint(0)  not null default 1,
                                    subsribe_show_edit tinyint(0) not null default 1 ,subsribe_req_edit tinyint(0)  not null default 1,
									f_name_show_checkout tinyint(0) not null default 1 ,f_name_req_checkout tinyint(0)  not null default 1,
									l_name_show_checkout tinyint(0) not null default 1 ,l_name_req_checkout tinyint(0)  not null default 1,
                                    mob_show_checkout tinyint(0) not null default 1 ,mob_req_checkout tinyint(0)  not null default 1,
                                    fax_show_checkout tinyint(0) not null default 1 ,fax_req_checkout tinyint(0)  not null default 1,
                                    company_show_checkout tinyint(0) not null default 1 ,company_req_checkout tinyint(0)  not null default 1,
                                    companyId_show_checkout tinyint(0) not null default 1 ,companyId_req_checkout tinyint(0)  not null default 1,
                                    address1_show_checkout tinyint(0) not null default 1 ,address1_req_checkout tinyint(0)  not null default 1,
                                    address2_show_checkout tinyint(0) not null default 1 ,address2_req_checkout tinyint(0)  not null default 1,
                                    city_show_checkout tinyint(0) not null default 1 ,city_req_checkout tinyint(0)  not null default 1,
                                    pin_show_checkout tinyint(0) not null default 1 ,pin_req_checkout tinyint(0)  not null default 1,
                                    state_show_checkout tinyint(0) not null default 1 ,state_req_checkout tinyint(0)  not null default 1,
                                    country_show_checkout tinyint(0) not null default 1 ,country_req_checkout tinyint(0)  not null default 1,
                                    passconf_show_checkout tinyint(0) not null default 1 ,passconf_req_checkout tinyint(0)  not null default 1,
                                    subsribe_show_checkout tinyint(0) not null default 1 ,subsribe_req_checkout tinyint(0)  not null default 1,
                                    mob_min int  not null default 0,mob_max int  not null default 0,mob_fix int  not null default 0,
                                    pass_min int  not null default 0,pass_max int  not null default 0,pass_fix int  not null default 0,
                                     mob_numeric tinyint(0) not null default 0,mob_masking tinyint(0) not null default 0,
                                     companyId_numeric tinyint(0) not null default 0,
                                     fax_numeric tinyint(0) not null default 0,
                                     pin_numeric tinyint(0) not null default 0,pin_masking tinyint(0) not null default 0,
                                     def_state  int  not null default 0 ,
                                     def_country  int  not null default 0,
                                     show_address tinyint(0) not null default 0,
                                     is_responsive tinyint(0) not null default 0,
                                     show_p_method_comment tinyint(0) not null default 1,
                                     show_s_method_comment tinyint(0) not null default 0                                      
                                    )	";
			$sql[]  = "insert into ".DB_PREFIX."signupkw set enablemod =0";
			$sql[]  = "insert into ".DB_PREFIX."signupkw_attributes set f_name_show =1";

			foreach( $sql as $q ){
				$query = $this->db->query( $q );
			}

		}
		$this->upgrade();

	}

	private function upgrade(){
		$result = $this->db->query("Select * FROM ".DB_PREFIX."signupkw ");
		if(!isset($result->row['kw_version_mod'])){
			$this->db->query('Alter table '.DB_PREFIX.'signupkw ADD COLUMN
				kw_version_mod tinyint(4) not null default 1
			' );
		}
		$query = $this->db->query('select kw_version_mod from '.DB_PREFIX.'signupkw LIMIT 1' );
		if($query->row['kw_version_mod']<2){
			$this->db->query('ALTER TABLE '.DB_PREFIX.'signupkw_attributes ADD COLUMN
			   	 (f_name_sort tinyint(3) not null default 10 ,
									 l_name_sort tinyint(3) not null default 15 ,
									email_sort tinyint(3) not null default 20 ,
									mob_sort tinyint(3) not null default 25 ,
									fax_sort tinyint(3) not null default 30 ,
									company_sort tinyint(3) not null default 35 ,
									cgroup_sort tinyint(3) not null default 40 ,
									companyId_sort tinyint(3) not null default 45 ,
									taxId_sort tinyint(3) not null default 50 ,
									address1_sort tinyint(3) not null default 55 ,
									address2_sort tinyint(3) not null default 60 ,
									city_sort tinyint(3) not null default 65 ,
									pin_sort tinyint(3) not null default 80 ,
									state_sort tinyint(3) not null default 85 ,
									country_sort tinyint(3) not null default 90 ,
									pass_sort tinyint(3) not null default 95 ,
									passconf_sort tinyint(3) not null default 96 ,
									subscribe_sort tinyint(3) not null default 97) 
			   	');

			$this->setVersion(2);
		}
		$query = $this->db->query('select kw_version_mod from '.DB_PREFIX.'signupkw LIMIT 1' );
		if($query->row['kw_version_mod']<3){
			$this->db->query('ALTER TABLE '.DB_PREFIX.'signupkw_attributes ADD COLUMN
			   	 (cv_show tinyint(0) not null default 1,
                                     c_show tinyint(0) not null default 1,
                                     v_show tinyint(0) not null default 1 ) 
			   	');

			$this->setVersion(3);
		}
		$query = $this->db->query('select kw_version_mod from '.DB_PREFIX.'signupkw LIMIT 1' );
		if($query->row['kw_version_mod']<4){
			$this->db->query('ALTER TABLE '.DB_PREFIX.'signupkw_attributes ADD COLUMN
			   	 (same_shipping tinyint(0) not null default 0
                                    ) 
			   	');

			$this->setVersion(4);
		}

		if($query->row['kw_version_mod']<5){
			if(version_compare(VERSION, '2.0.0.0')>=0){
				$this->installCustomFields2();
			}else{
				$this->installCustomFields1();
			}
		}
		if($query->row['kw_version_mod']<6){
			$this->db->query('ALTER TABLE '.DB_PREFIX.'signupkw_attributes ADD COLUMN
                 (
                 company_numeric tinyint(0) not null default 0,
                 tax_id_numeric tinyint(0) not null default 0,
                 mob_mask varchar(32) NOT NULL,
                 fax_mask varchar(32) NOT NULL,
                 company_mask varchar(32) NOT NULL,
                 company_id_mask varchar(32) NOT NULL,
                 tax_id_mask varchar(32) NOT NULL,
                 postcode_mask varchar(32) NOT NULL,
                 address_format text NOT NULL,
                 css text NOT NULL,
                 js text NOT NULL 
                 )
                 ');
			$this->setVersion(6);
		}
		if($query->row['kw_version_mod']<7){
			$this->db->query('ALTER TABLE '.DB_PREFIX.'signupkw_attributes ADD COLUMN
                 (
                 override_format tinyint(0) not null default 0                 
                 )
                 ');
			$this->setVersion(7);
		}
	}
	private function setVersion($version){
		$this->db->query("Update  ".DB_PREFIX."signupkw Set kw_version_mod='".(int)$version."'");
	}
	private function installCustomFields1(){
		$this->db->query("
                 ALTER TABLE `".DB_PREFIX."address`
                 ADD COLUMN `custom_field` text NOT NULL;
            ");
			
		$this->db->query("
                 ALTER TABLE `".DB_PREFIX."customer`
                 ADD COLUMN `custom_field` text NOT NULL;
            ");
		$this->db->query("
                 ALTER TABLE `".DB_PREFIX."order`
                 ADD COLUMN `custom_field` text NOT NULL,
                 ADD COLUMN `payment_custom_field` text NOT NULL,
                 ADD COLUMN `shipping_custom_field` text NOT NULL;
            ");
		$this->db->query("
            	  CREATE TABLE IF NOT EXISTS `".DB_PREFIX."xcustom_field` (
                   `custom_field_id` int(11) NOT NULL AUTO_INCREMENT,
                   `type` varchar(32) NOT NULL,
                   `value` text NOT NULL,
                   `location` varchar(7) NOT NULL,
                   `status` tinyint(1) NOT NULL,
                   `sort_order` int(3) NOT NULL,
                   `minimum` int(11) NOT NULL DEFAULT '0',
                   `maximum` int(11) NOT NULL DEFAULT '0',
                   `mask` varchar(32) NOT NULL,
                   `identifier` varchar(32) NOT NULL,
                   `isnumeric` tinyint(4) NOT NULL DEFAULT '0',
                   `email_display` tinyint(4) NOT NULL DEFAULT '0' ,
                   `order_display` tinyint(4) NOT NULL DEFAULT '0' ,
                   `list_display` tinyint(4) NOT NULL DEFAULT '0' ,
                   `invoice` tinyint(4) NOT NULL DEFAULT '0',
                   PRIMARY KEY (`custom_field_id`)
                 ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
              ");
		$this->db->query("
                 CREATE TABLE IF NOT EXISTS `".DB_PREFIX."xcustom_field_customer_group` (
                   `custom_field_id` int(11) NOT NULL,
                   `customer_group_id` int(11) NOT NULL,
                   `required` tinyint(1) NOT NULL,
                   PRIMARY KEY (`custom_field_id`,`customer_group_id`)
                 ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
              ");
		$this->db->query("
              	CREATE TABLE IF NOT EXISTS `".DB_PREFIX."xcustom_field_description` (
                   `custom_field_id` int(11) NOT NULL,
                   `language_id` int(11) NOT NULL,
                   `name` varchar(128) NOT NULL,
                   `error` text NOT NULL,
                   `tips` text NOT NULL,
                   PRIMARY KEY (`custom_field_id`,`language_id`)
                 ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
              ");
		$this->db->query("
                 CREATE TABLE IF NOT EXISTS `".DB_PREFIX."xcustom_field_value` (
                   `custom_field_value_id` int(11) NOT NULL AUTO_INCREMENT,
                   `custom_field_id` int(11) NOT NULL,
                   `sort_order` int(3) NOT NULL,
                   PRIMARY KEY (`custom_field_value_id`)
                 ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
              ");
		$this->db->query("
              	 CREATE TABLE IF NOT EXISTS `".DB_PREFIX."xcustom_field_value_description` (
                   `custom_field_value_id` int(11) NOT NULL,
                   `language_id` int(11) NOT NULL,
                   `custom_field_id` int(11) NOT NULL,
                   `name` varchar(128) NOT NULL,
                   PRIMARY KEY (`custom_field_value_id`,`language_id`)
                 ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;                 
               ");			 
		$this->setVersion(5);
	}
	private function installCustomFields2(){

		$this->db->query("
            	  ALTER TABLE `".DB_PREFIX."custom_field` ADD COLUMN (                   
                   `minimum` int(11) NOT NULL DEFAULT '0',
                   `maximum` int(11) NOT NULL DEFAULT '0',
                   `mask` varchar(32) NOT NULL,
                   `identifier` varchar(32) NOT NULL,
                   `isnumeric` tinyint(4) NOT NULL DEFAULT '0',
                   `email_display` tinyint(4) NOT NULL DEFAULT '0' ,
                   `order_display` tinyint(4) NOT NULL DEFAULT '0' ,
                   `list_display` tinyint(4) NOT NULL DEFAULT '0' ,
                   `invoice` tinyint(4) NOT NULL DEFAULT '0'                   
                 ) 
              ");		
		$this->db->query("
              	ALTER TABLE `".DB_PREFIX."custom_field_description` ADD COLUMN (                   
                   `error` text NOT NULL,
                   `tips` text NOT NULL                   
                 )
              ");				 
		$this->setVersion(5);

	}

	private function editSetting($data) {


		$this->db->query("update " . DB_PREFIX . "signupkw_attributes  set
                     f_name_show = " . (isset($data['f_name_show']) ? (int)$data['f_name_show'] : 0) . 
                       ", f_name_req = " . (isset($data['f_name_req']) ? (int)$data['f_name_req'] : 0) . 
", l_name_show = " . (isset($data['l_name_show']) ? (int)$data['l_name_show'] : 0) . 
", l_name_req = " . (isset($data['l_name_req']) ? (int)$data['l_name_req'] : 0) . 
", mob_show = " . (isset($data['mob_show']) ? (int)$data['mob_show'] : 0) . 
", mob_req = " . (isset($data['mob_req']) ? (int)$data['mob_req'] : 0) . 
", fax_show = " . (isset($data['fax_show']) ? (int)$data['fax_show'] : 0) . 
", fax_req = " . (isset($data['fax_req']) ? (int)$data['fax_req'] : 0) . 
", company_show = " . (isset($data['company_show']) ? (int)$data['company_show'] : 0) . 
", company_req = " . (isset($data['company_req']) ? (int)$data['company_req'] : 0) . 
", companyId_show = " . (isset($data['companyId_show']) ? (int)$data['companyId_show'] : 0) . 
", companyId_req = " . (isset($data['companyId_req']) ? (int)$data['companyId_req'] : 0) . 
", address1_show = " . (isset($data['address1_show']) ? (int)$data['address1_show'] : 0) . 
", address1_req = " . (isset($data['address1_req']) ? (int)$data['address1_req'] : 0) . 
", address2_show = " . (isset($data['address2_show']) ? (int)$data['address2_show'] : 0) . 
", address2_req = " . (isset($data['address2_req']) ? (int)$data['address2_req'] : 0) . 
", city_show = " . (isset($data['city_show']) ? (int)$data['city_show'] : 0) . 
", city_req = " . (isset($data['city_req']) ? (int)$data['city_req'] : 0) . 
", pin_show = " . (isset($data['pin_show']) ? (int)$data['pin_show'] : 0) . 
", pin_req = " . (isset($data['pin_req']) ? (int)$data['pin_req'] : 0) . 
", state_show = " . (isset($data['state_show']) ? (int)$data['state_show'] : 0) . 
", state_req = " . (isset($data['state_req']) ? (int)$data['state_req'] : 0) . 
", country_show = " . (isset($data['country_show']) ? (int)$data['country_show'] : 0) . 
", country_req = " . (isset($data['country_req']) ? (int)$data['country_req'] : 0) . 
", passconf_show = " . (isset($data['passconf_show']) ? (int)$data['passconf_show'] : 0) . 
", passconf_req = " . (isset($data['passconf_req']) ? (int)$data['passconf_req'] : 0) . 
", subsribe_show = " . (isset($data['subsribe_show']) ? (int)$data['subsribe_show'] : 0) . 
", subsribe_req = " . (isset($data['subsribe_req']) ? (int)$data['subsribe_req'] : 0).
", show_address = " . (isset($data['show_address']) ? (int)$data['show_address'] : 0).		


", is_responsive = " . (isset($data['is_responsive']) ? (int)$data['is_responsive'] : 0).
", show_p_method_comment = " . (isset($data['show_p_method_comment']) ? (int)$data['show_p_method_comment'] : 0).
", show_s_method_comment = " . (isset($data['show_s_method_comment']) ? (int)$data['show_s_method_comment'] : 0).						
", company_numeric = " . (isset($data['company_numeric']) ? (int)$data['company_numeric'] : 0).
", tax_id_numeric = " . (isset($data['tax_id_numeric']) ? (int)$data['tax_id_numeric'] : 0).

", mob_numeric = " . (isset($data['mob_numeric']) ? (int)$data['mob_numeric'] : 0).
", fax_numeric = " . (isset($data['fax_numeric']) ? (int)$data['fax_numeric'] : 0).
", pin_numeric = " . (isset($data['pin_numeric']) ? (int)$data['pin_numeric'] : 0).
", companyId_numeric = " . (isset($data['companyId_numeric']) ? (int)$data['companyId_numeric'] : 0).
		//", mob_masking = " . (isset($data['mob_masking']) ? (int)$data['mob_masking'] : 0).
		//", pin_masking = " . (isset($data['pin_masking']) ? (int)$data['pin_masking'] : 0).

", f_name_show_edit = " . (isset($data['f_name_show_edit']) ? (int)$data['f_name_show_edit'] : 0) . 
", f_name_req_edit = " . (isset($data['f_name_req_edit']) ? (int)$data['f_name_req_edit'] : 0) . 
", l_name_show_edit = " . (isset($data['l_name_show_edit']) ? (int)$data['l_name_show_edit'] : 0) . 
", l_name_req_edit = " . (isset($data['l_name_req_edit']) ? (int)$data['l_name_req_edit'] : 0) . 
", mob_show_edit = " . (isset($data['mob_show_edit']) ? (int)$data['mob_show_edit'] : 0) . 
", mob_req_edit = " . (isset($data['mob_req_edit']) ? (int)$data['mob_req_edit'] : 0) . 
", fax_show_edit = " . (isset($data['fax_show_edit']) ? (int)$data['fax_show_edit'] : 0) . 
", fax_req_edit = " . (isset($data['fax_req_edit']) ? (int)$data['fax_req_edit'] : 0) . 
", company_show_edit = " . (isset($data['company_show_edit']) ? (int)$data['company_show_edit'] : 0) . 
", company_req_edit = " . (isset($data['company_req_edit']) ? (int)$data['company_req_edit'] : 0) . 
", companyId_show_edit = " . (isset($data['companyId_show_edit']) ? (int)$data['companyId_show_edit'] : 0) . 
", companyId_req_edit = " . (isset($data['companyId_req_edit']) ? (int)$data['companyId_req_edit'] : 0) . 
", address1_show_edit = " . (isset($data['address1_show_edit']) ? (int)$data['address1_show_edit'] : 0) . 
", address1_req_edit = " . (isset($data['address1_req_edit']) ? (int)$data['address1_req_edit'] : 0) . 
", address2_show_edit = " . (isset($data['address2_show_edit']) ? (int)$data['address2_show_edit'] : 0) . 
", address2_req_edit = " . (isset($data['address2_req_edit']) ? (int)$data['address2_req_edit'] : 0) . 
", city_show_edit = " . (isset($data['city_show_edit']) ? (int)$data['city_show_edit'] : 0) . 
", city_req_edit = " . (isset($data['city_req_edit']) ? (int)$data['city_req_edit'] : 0) . 
", pin_show_edit = " . (isset($data['pin_show_edit']) ? (int)$data['pin_show_edit'] : 0) . 
", pin_req_edit = " . (isset($data['pin_req_edit']) ? (int)$data['pin_req_edit'] : 0) . 
", state_show_edit = " . (isset($data['state_show_edit']) ? (int)$data['state_show_edit'] : 0) . 
", state_req_edit = " . (isset($data['state_req_edit']) ? (int)$data['state_req_edit'] : 0) . 
", country_show_edit = " . (isset($data['country_show_edit']) ? (int)$data['country_show_edit'] : 0) . 
", country_req_edit = " . (isset($data['country_req_edit']) ? (int)$data['country_req_edit'] : 0) .

", f_name_show_checkout = " . (isset($data['f_name_show_checkout']) ? (int)$data['f_name_show_checkout'] : 0) . 
", f_name_req_checkout = " . (isset($data['f_name_req_checkout']) ? (int)$data['f_name_req_checkout'] : 0) . 
", l_name_show_checkout = " . (isset($data['l_name_show_checkout']) ? (int)$data['l_name_show_checkout'] : 0) . 
", l_name_req_checkout = " . (isset($data['l_name_req_checkout']) ? (int)$data['l_name_req_checkout'] : 0) . 
", mob_show_checkout = " . (isset($data['mob_show_checkout']) ? (int)$data['mob_show_checkout'] : 0) . 
", mob_req_checkout = " . (isset($data['mob_req_checkout']) ? (int)$data['mob_req_checkout'] : 0) . 
", fax_show_checkout = " . (isset($data['fax_show_checkout']) ? (int)$data['fax_show_checkout'] : 0) . 
", fax_req_checkout = " . (isset($data['fax_req_checkout']) ? (int)$data['fax_req_checkout'] : 0) . 
", company_show_checkout = " . (isset($data['company_show_checkout']) ? (int)$data['company_show_checkout'] : 0) . 
", company_req_checkout = " . (isset($data['company_req_checkout']) ? (int)$data['company_req_checkout'] : 0) . 
", companyId_show_checkout = " . (isset($data['companyId_show_checkout']) ? (int)$data['companyId_show_checkout'] : 0) . 
", companyId_req_checkout = " . (isset($data['companyId_req_checkout']) ? (int)$data['companyId_req_checkout'] : 0) . 
", address1_show_checkout = " . (isset($data['address1_show_checkout']) ? (int)$data['address1_show_checkout'] : 0) . 
", address1_req_checkout = " . (isset($data['address1_req_checkout']) ? (int)$data['address1_req_checkout'] : 0) . 
", address2_show_checkout = " . (isset($data['address2_show_checkout']) ? (int)$data['address2_show_checkout'] : 0) . 
", address2_req_checkout = " . (isset($data['address2_req_checkout']) ? (int)$data['address2_req_checkout'] : 0) . 
", city_show_checkout = " . (isset($data['city_show_checkout']) ? (int)$data['city_show_checkout'] : 0) . 
", city_req_checkout = " . (isset($data['city_req_checkout']) ? (int)$data['city_req_checkout'] : 0) . 
", pin_show_checkout = " . (isset($data['pin_show_checkout']) ? (int)$data['pin_show_checkout'] : 0) . 
", pin_req_checkout = " . (isset($data['pin_req_checkout']) ? (int)$data['pin_req_checkout'] : 0) . 
", state_show_checkout = " . (isset($data['state_show_checkout']) ? (int)$data['state_show_checkout'] : 0) . 
", state_req_checkout = " . (isset($data['state_req_checkout']) ? (int)$data['state_req_checkout'] : 0) . 
", country_show_checkout = " . (isset($data['country_show_checkout']) ? (int)$data['country_show_checkout'] : 0) . 
", country_req_checkout = " . (isset($data['country_req_checkout']) ? (int)$data['country_req_checkout'] : 0).

", cv_show = " . (isset($data['cv_show']) ? (int)$data['cv_show'] : 0) . 
", c_show = " . (isset($data['c_show']) ? (int)$data['c_show'] : 0) . 
", v_show = " . (isset($data['v_show']) ? (int)$data['v_show'] : 0).
", same_shipping = " . (isset($data['same_shipping']) ? (int)$data['same_shipping'] : 0).		

" , mob_min = '" . $this->db->escape($data['mob_min']) .
"', mob_max = '" . $this->db->escape($data['mob_max']) .
"', mob_fix = '" . $this->db->escape($data['mob_fix']) .
"', pass_min = '" . $this->db->escape($data['pass_min']) .
"', pass_max = '" . $this->db->escape($data['pass_max']) .
"', pass_fix = '" . $this->db->escape($data['pass_fix']) .
"' , def_country = " . $this->db->escape($data['country_id']) .
", def_state = " . $this->db->escape($data['zone_id']) .
" , f_name_sort = '" . $this->db->escape($data['f_name_sort']) .
"', l_name_sort = '" . $this->db->escape($data['l_name_sort']) .
"', email_sort = '" . $this->db->escape($data['email_sort']) .
"', mob_sort = '" . $this->db->escape($data['mob_sort']) .
"', fax_sort = '" . $this->db->escape($data['fax_sort']) .
"', company_sort = '" . $this->db->escape($data['company_sort']) .	
"', cgroup_sort = '" . $this->db->escape($data['cgroup_sort']) .
"', companyId_sort = '" . $this->db->escape($data['companyId_sort']) .
"', taxId_sort = '" . $this->db->escape($data['taxId_sort']) .
"', address1_sort = '" . $this->db->escape($data['address1_sort']) .
"', address2_sort = '" . $this->db->escape($data['address2_sort']) .
"', city_sort = '" . $this->db->escape($data['city_sort']) .	
"', pin_sort = '" . $this->db->escape($data['pin_sort']) .
"', state_sort = '" . $this->db->escape($data['state_sort']) .
"', country_sort = '" . $this->db->escape($data['country_sort']) .
"', pass_sort = '" . $this->db->escape($data['pass_sort']) .
"', passconf_sort = '" . $this->db->escape($data['passconf_sort']) .
"', subscribe_sort = '" . $this->db->escape($data['subscribe_sort']) .
"', mob_mask = '" . $this->db->escape($data['mob_mask']) .
"', fax_mask = '" . $this->db->escape($data['fax_mask']) .
"', company_mask = '" . $this->db->escape($data['company_mask']) .
"', company_id_mask = '" . $this->db->escape($data['company_id_mask']) .
"', tax_id_mask = '" . $this->db->escape($data['tax_id_mask']) .
"', postcode_mask = '" . $this->db->escape($data['postcode_mask']) .
"', css = '" . $this->db->escape($data['css']) .
"', js = '" . $this->db->escape($data['js']) .
"', override_format = " . (isset($data['override_format']) ? (int)$data['override_format'] : 0) 


		/*", f_name_cstm = '" . $this->db->escape($data['f_name_cstm']) .
		 "', l_name_cstm = '" . $this->db->escape($data['l_name_cstm']) .
		 "', mob_cstm = '" . $this->db->escape($data['mob_cstm']) .
		 "', fax_cstm = '" . $this->db->escape($data['fax_cstm']) .
		 "', company_cstm = '" . $this->db->escape($data['company_cstm']) .
		 "', companyId_cstm = '" . $this->db->escape($data['companyId_cstm']) .
		 "', address1_cstm = '" . $this->db->escape($data['address1_cstm']) .
		 "', address2_cstm = '" . $this->db->escape($data['address2_cstm']) .
		 "', city_cstm = '" . $this->db->escape($data['city_cstm']) .
		 "', pin_cstm = '" . $this->db->escape($data['pin_cstm']) .
		 "', state_cstm = '" . $this->db->escape($data['state_cstm']) .
		 "', country_cstm = '" . $this->db->escape($data['country_cstm']) .
		 "', passconf_cstm = '" . $this->db->escape($data['passconf_cstm']) .
		 "', subsribe_cstm = '" . $this->db->escape($data['subsribe_cstm']) .
		 */
		);

		$this->db->query("update " . DB_PREFIX . "signupkw  set
    enablemod = " . (isset($data['mod_enable']) ? (int)$data['mod_enable'] : 0).
       " , single_box = " . (isset($data['single_box']) ? (int)$data['single_box'] : 0)
		);
		$this->db->query("update " . DB_PREFIX . "signupkw_attributes  set address_format ='" . $this->db->escape($data['address_format']) ."'");

		if(isset($data['override_format'])){
			$this->db->query("update " . DB_PREFIX . "country  set address_format ='" . $this->db->escape($data['address_format']) ."'");
		}
	}
	/* Admin related and installation functions- end*/
}