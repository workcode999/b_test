<?php
error_reporting(0);
class ControllerXCheckoutXFooter extends Controller {
	function getRemarketingCode ($products, $view, $categories_name = ""){
		//Comprove if google remarketing code if correct
		$google_remarketing_code = explode("'REPLACE_WITH_VALUE'", $this->config->get('google_remarketing_code'));

		if (count($google_remarketing_code) != 4)
		{
			return "<script type='text/javascript'> $( document ).ready(function() { alert('Error: The Google Dynamic Remarketing code is not correct') });</script>";
			return true;
		}

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
				$array_id = '[';

			foreach ($product_data as $product)
			{
				$array_id .= "'";
				$array_id .= $product['product_id'];
				$array_id .= '\',';
			}
			$array_id = substr($array_id, 0, -1);
			
			if (count($product_data) > 1)
				$array_id .= ']';

		}

		//Add obtained data to google remarketing code.
		$temp_google_remarketing_code_1 = explode("{", $this->config->get('google_remarketing_code'));
		$temp_google_remarketing_code_2 = explode("}", $this->config->get('google_remarketing_code'));

		$google_remarketing_code_1 = $temp_google_remarketing_code_1[0].'{';
		$google_remarketing_code_2 = '}'.$temp_google_remarketing_code_2[1];

		$params = "";

		if ($view != "category")
		{
			$params .= "\n\t"."ecomm_prodid: ".$array_id.',';
			$params .= "\n\t"."ecomm_pvalue: "."'".$total_products."',";
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
					$categories_name_temp = "[";
					foreach ($categories_name as $key=>$cat_name)
					{
						$categories_name_temp .= "'".$cat_name."'";
						if (($key+1) != count($categories_name))
							$categories_name_temp .= ",";
					}
					$categories_name_temp .= "]";
				}
			}
			$params .= "\n\t"."ecomm_prodid: ".$array_id.',';
			$params .= "\n\t"."ecomm_pcat: ".$categories_name_temp.',';
		}
		$params .= "\n\t".'ecomm_pagetype: '."'".$view."'"."\n";

		return html_entity_decode($google_remarketing_code_1.$params.$google_remarketing_code_2);
	}

	public $data=array();
	public function index() {
		$this->load->model('catalog/information');
		$this->data['informations'] = array();

		foreach ($this->model_catalog_information->getInformations() as $result) {
			if ($result['bottom']) {
				$this->data['informations'][] = array(
					'title' => $result['title'],
					'href'  => $this->url->link('information/information', 'information_id=' . $result['information_id'])
				);
			}
		}
		if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
			$server = $this->config->get('config_ssl');
		} else {
			$server = $this->config->get('config_url');
		}
		for($i=1;$i<8;$i++){
			if (file_exists(DIR_APPLICATION .'/view/theme/xtensions/image/payment/p'.$i.'.png')) {
				$this->data['payment_images'][]= array('url'=>$server .'catalog/view/theme/xtensions/image/payment/p'.$i.'.png');
			} else {
				$this->data['payment_images'][] = array('url'=>'');
			}
		}
		$this->language->load('common/footer');
		$this->data['text_contact'] = $this->language->get('text_contact');
		$this->data['contact'] = $this->url->link('information/contact');
		$this->data['telephone'] = $this->config->get('config_telephone');
		$this->data['email'] = $this->config->get('config_email');

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
					$this->data['google_remarketing_code'] = $this->getRemarketingCode('', 'home');
				}

				
				//-- CASE HOME VIEW
				elseif (isset($this->request->get["route"]) && $this->request->get["route"] == "common/home")
				{							
					$this->data['google_remarketing_code'] = $this->getRemarketingCode('', 'home');
				}


				//-- CASE PRODUCT VIEW
				elseif (isset($this->request->get["route"]) && $this->request->get["route"] == "product/product")
				{		
					$product_info = $this->model_catalog_product->getProduct($this->request->get["product_id"]);
					$product_info_temp = array();
					$product_info_temp[] = $product_info;
					$this->data['google_remarketing_code'] = $this->getRemarketingCode($product_info_temp, 'product');
				}

				//-- CASE CART VIEW
				elseif (isset($this->request->get["route"]) && $this->request->get["route"] == "checkout/checkout" || $this->request->get["route"] == "checkout/cart" || $this->request->get["route"] == "supercheckout/supercheckout")
				{		
					$this->data['google_remarketing_code'] = $this->getRemarketingCode($this->cart->getProducts(), 'cart');					
				}

				
				//-- CASE PURCHASE VIEW
				elseif (isset($this->request->get["route"]) && $this->request->get["route"] == "checkout/success")
				{
					if($this->cart->countProducts() > 0)
					{
						$this->data['google_remarketing_code'] = $this->getRemarketingCode($this->cart->getProducts(), 'purchase');
						//$this->cart->clear();
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

					$this->data['google_remarketing_code'] = $this->getRemarketingCode('', 'category', $category_names);
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
					$this->data['google_remarketing_code'] = $this->getRemarketingCode('', 'category', $manufacturers_names);
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
			
							$this->data['google_remarketing_code'] = $this->getRemarketingCode($results, 'searchresults');
						}
					//-- END GET ALL PRODUCTS FILTERED
						else
						{
							$this->data['google_remarketing_code'] = $this->getRemarketingCode('', 'searchresults');
						}
				}
				

				//-- CASE OTHER VIEWS
				else
				{
					$this->data['google_remarketing_code'] = $this->getRemarketingCode('', 'other');
				}
			
				
			} //END DYNAMIC TYPE
			else //STANDARD TYPE
			{
				$this->data['google_remarketing_code'] = html_entity_decode($this->config->get('google_remarketing_code'));
			}
			
		}

		$this->template = 'xtensions/template/checkout/xfooter.tpl';

		return $this->xtensions->renderView($this);
	}
}
?>