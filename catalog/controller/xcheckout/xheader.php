<?php
error_reporting(0);
class ControllerXCheckoutXHeader extends Controller {
	function getGaRemarketingCode ($products, $view, $categories_name = ""){
		$product_data = array();
		$total_products = "";
		if ($products != "")
		{
			//-- GETS ALL INFO PRODUCTS IN CART
			foreach ($products as $product) 
			{
				$option_data = array();
				if (isset($product['option']))
				{
					foreach ($product['option'] as $option) {
						if ($option['type'] != 'file') {
							$value = $option['value'];	
						} else {
							$value = $this->encryption->decrypt($option['value']);
						}	
						
						$option_data[] = array(
							'product_option_id'       => $option['product_option_id'],
							'product_option_value_id' => $option['product_option_value_id'],
							'option_id'               => $option['option_id'],
							'option_value_id'         => $option['option_value_id'],								   
							'name'                    => $option['name'],
							'value'                   => $value,
							'type'                    => $option['type']
						);					
					}
				}

				//Fix to undefined variables 2014/09/29
					if (!isset($product['download'])) $product['download'] = '';
					if (!isset($product['price'])) $product['price'] = 0;
					if (!isset($product['tax_class_id'])) $product['tax_class_id'] = '';

				if (!isset($product['total']))
				{
					if (!empty($product['special']))
						$product['total'] = $this->tax->calculate($product['special'], $product['tax_class_id'], $this->config->get('config_tax'));
					else
						$product['total'] = $this->tax->calculate($product['price'], $product['tax_class_id'], $this->config->get('config_tax'));
				}
				else
				{
					if (!empty($product['special']))
						$product['total'] = $this->tax->calculate($product['special'], $product['tax_class_id'], $this->config->get('config_tax'));
					else
						$product['total'] = $this->tax->calculate($product['price'], $product['tax_class_id'], $this->config->get('config_tax'));
				}

				if (!isset($product['product_id']))
					$product['product_id'] = '';
				if (!isset($product['name']))
					$product['name'] = '';
				if (!isset($product['model']))
					$product['model'] = '';
				if (!isset($product['download']))
					$product['download'] = '';
				if (!isset($product['quantity']))
					$product['quantity'] = '';
				if (!isset($product['subtract']))
					$product['subtract'] = '';
				if (!isset($product['price']))
					$product['price'] = '';
				if (!isset($product['total']))
					$product['total'] = '';
				if (!isset($product['tax_class_id']))
					$product['tax_class_id'] = '';
				if (!isset($product['reward']))
					$product['reward'] = '';

				$product_data[] = array(
					'product_id' => $this->config->get('google_remarketing_id_preffix').$product['product_id'].$this->config->get('google_remarketing_id_suffix'),
					'name'       => $product['name'],
					'model'      => $product['model'],
					'option'     => $option_data,
					'download'   => $product['download'],
					'quantity'   => $product['quantity'],
					'subtract'   => $product['subtract'],
					'price'      => $product['price'],
					'total'      => $product['total'],
					'tax'        => $this->tax->getTax($product['price'], $product['tax_class_id']),
					'reward'     => $product['reward']
				); 
			}
			$total_price = 0;
			foreach ($product_data as $key => $product)
			{
				if ($key == 0) $total_price = 0;
				$total_price += $product['total'];
			}
			if ($total_price == 0) $total_price = '';
			else $total_products = number_format($total_price, 2, '.', '');
		}				

		//-- GETS STRING JQUERY ARRAY ID TO GOOGLE CODE
		$array_id = "''";
		if (!empty($product_data))
		{
			$array_id = '';
			if (count($product_data) > 1)
				$array_id = "'";

			foreach ($product_data as $product)
			{
				$array_id .= $product['product_id'];
				$array_id .= ', ';
			}
			$array_id = substr($array_id, 0, -2);
			
			if (count($product_data) > 1)
				$array_id .= "'";

		}

		//Add obtained data to google Ga remarketing code.
		$temp_google_ga_remarketing_code = explode("+", $this->config->get('config_google_analytics'));

		$google_ga_remarketing_code_1 = $temp_google_ga_remarketing_code[0];
		$google_ga_remarketing_code_2 = $temp_google_ga_remarketing_code[2];

		$params_ga = "";

		if ($view != "category")
		{
			$params_ga .= "\t"."var ecomm_prodid = ".$array_id.";"."\n\t"."ga('set', 'dimension1', ecomm_prodid".');';
			$params_ga .= "\n\t"."var ecomm_totalvalue = '".$total_products."';"."\n\t"."ga('set', 'dimension3', ecomm_totalvalue".');';
		}
		else
		{
			$categories_name_temp = '""';
			if (!empty($categories_name))
			{
				if (count($categories_name) == 1)
					$categories_name_temp = "'".$categories_name[0]."'";
				else
				{
					$categories_name_temp = "'";
					foreach ($categories_name as $key=>$cat_name)
					{
						$categories_name_temp .= $cat_name;
						if (($key+1) != count($categories_name))
							$categories_name_temp .= ", ";
					}
					$categories_name_temp .= "'";
				}
			}
			$params_ga .= "\t"."var ecomm_prodid = ".$array_id.";"."\n\t"."ga('set', 'dimension1', ecomm_prodid".');';
			$params_ga .= "\n\t"."var ecomm_pcat = ".$categories_name_temp.";"."\n\t"."ga('set', 'dimension4', ecomm_pcat".');';
			
		}
		$params_ga .= "\n\t"."var ecomm_pagetype = '".$view."';"."\n\t"."ga('set', 'dimension2', ecomm_pagetype".');';

		return html_entity_decode($google_ga_remarketing_code_1.$params_ga.$google_ga_remarketing_code_2, ENT_QUOTES, 'UTF-8');
	}

	public $data=array();
	public function index() {
		$this->data['title'] = $this->document->getTitle();

		if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
			$server = $this->config->get('config_ssl');
		} else {
			$server = $this->config->get('config_url');
		}

		if (isset($this->session->data['error']) && !empty($this->session->data['error'])) {
			$this->data['error'] = $this->session->data['error'];

			unset($this->session->data['error']);
		} else {
			$this->data['error'] = '';
		}

		$this->data['base'] = $server;
		$this->data['description'] = $this->document->getDescription();
		$this->data['keywords'] = $this->document->getKeywords();
		$this->data['links'] = $this->document->getLinks();
		$this->data['styles'] = $this->document->getStyles();
		$this->data['scripts'] = $this->document->getScripts();
		$this->data['lang'] = $this->language->get('code');
		$this->data['direction'] = $this->language->get('direction');
		$this->data['google_analytics'] = html_entity_decode($this->config->get('config_google_analytics'), ENT_QUOTES, 'UTF-8');
		$this->data['name'] = $this->config->get('config_name');

		if ($this->config->get('config_icon') && file_exists(DIR_IMAGE . $this->config->get('config_icon'))) {
			$this->data['icon'] = $server . 'image/' . $this->config->get('config_icon');
		} else {
			$this->data['icon'] = '';
		}

		if ($this->config->get('config_logo') && file_exists(DIR_IMAGE . $this->config->get('config_logo'))) {
			$this->data['logo'] = $server . 'image/' . $this->config->get('config_logo');
		} else {
			$this->data['logo'] = '';
		}

		$this->language->load('common/header');
		$this->language->load('account/xtensions');

		$this->data['text_home'] = $this->language->get('text_home');
		$this->data['text_shopping_cart'] = $this->language->get('text_shopping_cart');
		if($this->customer->isLogged()){
			if($this->customer->getFirstName()){
				$display_name=$this->customer->getFirstName();
			}
			else{
				$display_name=substr($this->customer->getEmail(),0,strpos($this->customer->getEmail(),'@'));
			}
			$this->data['text_logged'] = sprintf('<span class=""><a href="%s"><i class="fa fa-user"></i> %s</a> | <a href="%s">'.$this->language->get('text_logout').' <i class="fa fa-sign-out fa-lg"></i></a></span>', $this->url->link('account/account', '', 'SSL'), $display_name, $this->url->link('account/logout', '', 'SSL'));
		}else{
			$this->data['text_logged'] = '<i class="fa fa-user"></i> '.$this->language->get('text_guest_header');
		}

		$this->data['text_ssl_msg'] =$this->language->get('text_ssl_header');

		$this->data['home'] = $this->url->link('common/home');
		$this->data['logged'] = $this->customer->isLogged();
		$this->data['shopping_cart'] = $this->url->link('checkout/cart');
		$isOpencartTwo = $this->xtensions->isOpencartTwo();
		$modData = $this->xtensions->getModData();
		$this->data['custom_css'] = html_entity_decode($modData['css'], ENT_QUOTES, 'UTF-8');
		if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
			$connection = 'SSL';
		} else {
			$connection = 'NONSSL';
		}
		if (!isset($this->request->get['route'])) {
			$this->data['redirect'] = $this->url->link('common/home');
		} else {
			$url_data = $this->request->get;

			unset($url_data['_route_']);

			$route = $url_data['route'];

			unset($url_data['route']);

			$url = '';

			if ($url_data) {
				$url = '&' . urldecode(http_build_query($url_data, '', '&'));
			}

			$this->data['redirect'] = $this->url->link($route, $url, $connection);
		}

		//currency starts
		if($isOpencartTwo){
			$this->language->load('common/currency');
		}else{
			$this->language->load('module/currency');
		}

		$this->data['text_currency'] = $this->language->get('text_currency');

		$this->data['action'] = $this->url->link('xcheckout/xheader/currency', '', $connection);

		$this->data['currency_code'] = $this->currency->getCode();

		$this->load->model('localisation/currency');

		$this->data['currencies'] = array();

		$results = $this->model_localisation_currency->getCurrencies();

		foreach ($results as $result) {
			if ($result['status']) {
				$this->data['currencies'][] = array(
					'title'        => $result['title'],
					'code'         => $result['code'],
					'symbol_left'  => $result['symbol_left'],
					'symbol_right' => $result['symbol_right']				
				);
			}
		}


		//currency ends

		//language starts


		if($isOpencartTwo){
			$this->language->load('common/language');
		}else{
			$this->language->load('module/language');
		}

		$this->data['text_language'] = $this->language->get('text_language');

		$this->data['action_lang'] = $this->url->link('xcheckout/xheader/language', '', $connection);

		$this->data['language_code'] = $this->session->data['language'];

		$this->load->model('localisation/language');

		$this->data['languages'] = array();

		$results = $this->model_localisation_language->getLanguages();

		foreach ($results as $result) {
			if ($result['status']) {
				$this->data['languages'][] = array(
					'name'  => $result['name'],
					'code'  => $result['code'],
					'image' => $result['image']
				);
			}
		}
		//language ends

		// Daniel's robot detector
		$status = true;

		if (isset($this->request->server['HTTP_USER_AGENT'])) {
			$robots = explode("\n", trim($this->config->get('config_robots')));

			foreach ($robots as $robot) {
				if ($robot && strpos($this->request->server['HTTP_USER_AGENT'], trim($robot)) !== false) {
					$status = false;

					break;
				}
			}
		}

		// A dirty hack to try to set a cookie for the multi-store feature
//		$this->load->model('setting/store');

//		$this->data['stores'] = array();

//		if ($this->config->get('config_shared') && $status) {
//			$this->data['stores'][] = $server . 'catalog/view/javascript/crossdomain.php?session_id=' . $this->session->getId();

//			$stores = $this->model_setting_store->getStores();

//			foreach ($stores as $store) {
//				$this->data['stores'][] = $store['url'] . 'catalog/view/javascript/crossdomain.php?session_id=' . $this->session->getId();
//			}
//		}

		//$this->load->library('lessc.inc'); // Load LessPHP
		$styleFolder = 'catalog/view/theme/xtensions/stylesheet/less/';
			
		$style_setting = array ( // Setting to overide LessPHP variable
				'bordercolor'		=> '#ccc',
				'color'	=> '#ccc',
				'border-pixel' =>'1px',
				'border-style' => 'dashed'
				//'bgcolor'	=> '#e3eff2'
		);

		$lessFile	= $styleFolder . 'xtensions.less'; // Input Less stylesheet
		$cssFile 	= $styleFolder . 'xtensions.css'; // Output stylesheet
			
		if(false && file_exists($lessFile) && is_writable($styleFolder)){ // Check does .less file is available and stylesheet folder is writable
			$lessNew		= new lessc($lessFile);
			$lessParse	= $lessNew->parse(null, $style_setting); // Parse variable

			$hashCss = file_exists($cssFile) ? sha1_file($cssFile) : '';
			$hashLess = sha1($lessParse);

			if ($hashCss != $hashLess) { // Check does the Hash above is different. If yes, generate new stylesheet.
				file_put_contents($cssFile, $lessParse);
			}

			$this->document->addStyle($cssFile);
		}else{
			$this->document->addStyle($cssFile);
		}
		$this->data['styles'] = $this->document->getStyles();
		$this->language->load('checkout/checkout');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->data['breadcrumbs'] = array();

		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home'),
			'separator' => false
		);

		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_cart'),
			'href'      => $this->url->link('checkout/cart'),
			'separator' => $this->language->get('text_separator')
		);

		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('checkout/checkout', '', 'SSL'),
			'separator' => $this->language->get('text_separator')
		);

		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_checkout_option'] = $this->language->get('text_checkout_option');
		$this->data['text_checkout_account'] = $this->language->get('text_checkout_account');
		$this->data['text_checkout_confirm'] = $this->language->get('text_checkout_confirm');

		$this->data['logged'] = $this->customer->isLogged();

		$this->load->model('setting/setting');

		//IS ENABLED??

		if($this->config->get('google_remarketing_status'))
		{
			//DYNAMIC TYPE 
			if($this->config->get('google_remarketing_type') == 0)
			{
				//-- CASE HOME VIEW
				if (!isset($this->request->get["route"]))
				{					
					$this->data['google_ga_remarketing_code'] = $this->getGaRemarketingCode('', 'home');
				}

				
				//-- CASE HOME VIEW
				elseif (isset($this->request->get["route"]) && $this->request->get["route"] == "common/home")
				{							
					$this->data['google_ga_remarketing_code'] = $this->getGaRemarketingCode('', 'home');
				}


				//-- CASE PRODUCT VIEW
				elseif (isset($this->request->get["route"]) && $this->request->get["route"] == "product/product")
				{		
					$product_info = $this->model_catalog_product->getProduct($this->request->get["product_id"]);
					$product_info_temp = array();
					$product_info_temp[] = $product_info;
					$this->data['google_ga_remarketing_code'] = $this->getGaRemarketingCode($product_info_temp, 'product');
				}

				//-- CASE CART VIEW
				elseif (isset($this->request->get["route"]) && $this->request->get["route"] == "checkout/checkout" || $this->request->get["route"] == "checkout/cart" || $this->request->get["route"] == "supercheckout/supercheckout")
				{		
					$this->data['google_ga_remarketing_code'] = $this->getGaRemarketingCode($this->cart->getProducts(), 'cart');					
				}

				
				//-- CASE PURCHASE VIEW
				elseif (isset($this->request->get["route"]) && $this->request->get["route"] == "checkout/success")
				{
					if($this->cart->countProducts() > 0)
					{
						$this->data['google_ga_remarketing_code'] = $this->getGaRemarketingCode($this->cart->getProducts(), 'purchase');
						$this->cart->clear();
					}
				}
				

				//-- CASE CATEGORY VIEW
				elseif (isset($this->request->get["route"]) && $this->request->get["route"] == "product/category")
				{
					$category_names = array();
					if (isset($this->request->get['path'])) {

						$path = '';

						$parts = explode('_', (string)$this->request->get['path']);

						foreach ($parts as $path_id) {
							if (!$path) {
								$path = $path_id;
							} else {
								$path .= '_' . $path_id;
							}

							$category_info = $this->model_catalog_category->getCategory($path_id);

							if ($category_info) {
								$category_names[] = $category_info['name'];
							}
						}
					}

					$this->data['google_ga_remarketing_code'] = $this->getGaRemarketingCode('', 'category', $category_names);
				}

				//-- CASE MANUFACTURER VIEW
				elseif (isset($this->request->get["route"]) && $this->request->get["route"] == "product/manufacturer/info")
				{
					$manufacturers_names = array();
					if (isset($this->request->get['manufacturer_id'])) {
						$manufacturer_info = $this->model_catalog_manufacturer->getManufacturer($this->request->get['manufacturer_id']);
					
						if(!empty($manufacturer_info)) {
						  $manufacturers_names[] = $manufacturer_info['name'];
						}
					}
					$this->data['google_ga_remarketing_code'] = $this->getGaRemarketingCode('', 'category', $manufacturers_names);
				}

				//-- CASE SEARCHRESULT VIEW
				elseif (isset($this->request->get["route"]) && $this->request->get["route"] == "product/search")
				{
					
					//-- GET ALL PRODUCTS FILTERED
						if (isset($this->request->get['search']) || isset($this->request->get['tag'])) {
							if (isset($this->request->get['search'])) {
								$search = $this->request->get['search'];
							} else {
								$search = '';
							} 

							if (isset($this->request->get['tag'])) {
								$tag = $this->request->get['tag'];
							} elseif (isset($this->request->get['search'])) {
								$tag = $this->request->get['search'];
							} else {
								$tag = '';
							} 

							if (isset($this->request->get['description'])) {
								$description = $this->request->get['description'];
							} else {
								$description = '';
							} 

							if (isset($this->request->get['category_id'])) {
								$category_id = $this->request->get['category_id'];
							} else {
								$category_id = 0;
							} 

							if (isset($this->request->get['sub_category'])) {
								$sub_category = $this->request->get['sub_category'];
							} else {
								$sub_category = '';
							} 

							if (isset($this->request->get['sort'])) {
								$sort = $this->request->get['sort'];
							} else {
								$sort = 'p.sort_order';
							} 

							if (isset($this->request->get['order'])) {
								$order = $this->request->get['order'];
							} else {
								$order = 'ASC';
							}

							if (isset($this->request->get['page'])) {
								$page = $this->request->get['page'];
							} else {
								$page = 1;
							}

							if (isset($this->request->get['limit'])) {
								$limit = $this->request->get['limit'];
							} else {
								$limit = $this->config->get('config_catalog_limit');
							}

							if (isset($this->request->get['search'])) {
								$this->document->setTitle($this->language->get('heading_title') .  ' - ' . $this->request->get['search']);
							} else {
								$this->document->setTitle($this->language->get('heading_title'));
							}
							$data_filter = array(
								'filter_name'         => $search, 
								'filter_tag'          => $tag, 
								'filter_description'  => $description,
								'filter_category_id'  => $category_id, 
								'filter_sub_category' => $sub_category, 
								'sort'                => $sort,
								'order'               => $order,
								'start'               => ($page - 1) * $limit,
								'limit'               => $limit
							);

							$results = $this->model_catalog_product->getProducts($data_filter);
			
							$this->data['google_ga_remarketing_code'] = $this->getGaRemarketingCode($results, 'searchresults');
						}
					//-- END GET ALL PRODUCTS FILTERED
						else
						{
							$this->data['google_ga_remarketing_code'] = $this->getGaRemarketingCode('', 'searchresults');
						}
				}
				

				//-- CASE OTHER VIEWS
				else
				{
					$this->data['google_ga_remarketing_code'] = $this->getGaRemarketingCode('', 'other');
				}
			
				
			} //END DYNAMIC TYPE
			else //STANDARD TYPE
			{
				$this->data['google_ga_remarketing_code'] = html_entity_decode($this->config->get('config_google_analytics'));
			}
			
		}

		$this->template = 'xtensions/template/checkout/xheader.tpl';
		
		return $this->xtensions->renderView($this);
	}

	public function currency(){

		if (isset($this->request->post['currency_code'])) {
			$this->currency->set($this->request->post['currency_code']);

			unset($this->session->data['shipping_method']);
			unset($this->session->data['shipping_methods']);

			if (isset($this->request->post['redirect'])) {
				$this->xtensions->redirect($this->request->post['redirect']);
			} else {
				$this->xtensions->redirect($this->url->link('common/home'));
			}
		}
	}

	public function language(){
		if (isset($this->request->post['language_code'])) {
			$this->session->data['language'] = $this->request->post['language_code'];
			unset($this->session->data['shipping_method']);
			unset($this->session->data['shipping_methods']);
			if (isset($this->request->post['redirect_language'])) {
				$this->xtensions->redirect($this->request->post['redirect_language']);
			} else {
				$this->xtensions->redirect($this->url->link('checkout/home'));
			}
		}
	}
}
?>