<?php
class ControllerCommonHeader extends Controller {
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
	public function aa(){
		
		$a = $this->request->get['width'];
		if($a < 769){
			if(file_exists('vqmod/xml/magiczoomplus_vqmod.xml')){
				rename('vqmod/xml/magiczoomplus_vqmod.xml','vqmod/xml/magiczoomplus_vqmod.xml_');
			}
			$res['status'] = 200;
			$res['info']   = 'YES';
			$res['width'] = $a;
 
		}else{
			if(file_exists('vqmod/xml/magiczoomplus_vqmod.xml_')){
				rename('vqmod/xml/magiczoomplus_vqmod.xml_','vqmod/xml/magiczoomplus_vqmod.xml');

			}
			$res['status'] = 0;
			$res['info']   = 'NO';
			
		}

	}
	
	public function index() {
		$data['title'] = $this->document->getTitle();
	
		if ($this->request->server['HTTPS']) {
			$server = $this->config->get('config_ssl');
		} else {
			$server = $this->config->get('config_url');
		}

		$data['base'] = $server;
		$data['description'] = $this->document->getDescription();
		$data['keywords'] = $this->document->getKeywords();
		$data['links'] = $this->document->getLinks();
		if ($this->config->get('config_css_defer')) {
			$this->document->addStyle('catalog/view/javascript/page_speed/css_defer.css');
		}
		$category_counts_enabled = $this->config->get('config_category_counts');
		$data['styles'] = $this->document->getStyles();
		$data['scripts'] = $this->document->getScripts();
		$data['lang'] = $this->language->get('code');
		$data['direction'] = $this->language->get('direction');
		$data['google_analytics'] = html_entity_decode($this->config->get('config_google_analytics'), ENT_QUOTES, 'UTF-8');
		$data['name'] = $this->config->get('config_name');

		if (is_file(DIR_IMAGE . $this->config->get('config_icon'))) {
			$data['icon'] = $server . 'image/' . $this->config->get('config_icon');
		} else {
			$data['icon'] = '';
		}

		if (is_file(DIR_IMAGE . $this->config->get('config_logo'))) {
			$data['logo'] = $server . 'image/' . $this->config->get('config_logo');
		} else {
			$data['logo'] = '';
		}

		$this->load->language('common/header');

		$data['text_home'] = $this->language->get('text_home');
		$data['text_wishlist'] = sprintf($this->language->get('text_wishlist'), (isset($this->session->data['wishlist']) ? count($this->session->data['wishlist']) : 0));
		$data['text_shopping_cart'] = $this->language->get('text_shopping_cart');
		$data['text_logged'] = sprintf($this->language->get('text_logged'), $this->url->link('account/account', '', 'SSL'), $this->customer->getFirstName(), $this->url->link('account/logout', '', 'SSL'));

		$data['text_account'] = $this->language->get('text_account');
		$data['text_register'] = $this->language->get('text_register');
		$data['text_login'] = $this->language->get('text_login');
		$data['text_order'] = $this->language->get('text_order');
		$data['text_transaction'] = $this->language->get('text_transaction');
		$data['text_logout'] = $this->language->get('text_logout');
		$data['text_checkout'] = $this->language->get('text_checkout');
		$data['text_category'] = $this->language->get('text_category');
		$data['text_all'] = $this->language->get('text_all');

		$data['home'] = $this->url->link('common/home');
		$data['wishlist'] = $this->url->link('account/wishlist', '', 'SSL');
		$data['logged'] = $this->customer->isLogged();
		$data['account'] = $this->url->link('account/account', '', 'SSL');
		$data['register'] = $this->url->link('account/register', '', 'SSL');
		$data['login'] = $this->url->link('account/login', '', 'SSL');
		$data['order'] = $this->url->link('account/order', '', 'SSL');
		$data['transaction'] = $this->url->link('account/transaction', '', 'SSL');
		$data['logout'] = $this->url->link('account/logout', '', 'SSL');
		$data['shopping_cart'] = $this->url->link('checkout/cart');
		$data['checkout'] = $this->url->link('checkout/checkout', '', 'SSL');
		$data['contact'] = $this->url->link('information/contact');
		$data['telephone'] = $this->config->get('config_telephone');
		$data['text_compare'] = sprintf($this->language->get('text_compare'), (isset($this->session->data['compare']) ? count($this->session->data['compare']) : 0));
		
		$status = true;

		if (isset($this->request->server['HTTP_USER_AGENT'])) {
			$robots = explode("\n", str_replace(array("\r\n", "\r"), "\n", trim($this->config->get('config_robots'))));

			foreach ($robots as $robot) {
				if ($robot && strpos($this->request->server['HTTP_USER_AGENT'], trim($robot)) !== false) {
					$status = false;

					break;
				}
			}
		}

		// Menu
		$this->load->model('catalog/category');

		$this->load->model('catalog/product');
		//customer_id
		$customer_id = $this->customer->isLogged();
		if($customer_id){
			$email = $this->model_catalog_product->getEmailByCustomerID($customer_id);
			$data['email'] = $email['email'];
		}
		
		$data['categories'] = array();

		$categories = $this->model_catalog_category->getCategories(0);

		foreach ($categories as $category) {
			if ($category['top']) {
				// Level 2
				$children_data = array();

				$children = $this->model_catalog_category->getCategories($category['category_id']);

				foreach ($children as $child) {
					$filter_data = array(
						'filter_category_id'  => $child['category_id'],
						'filter_sub_category' => true
					);

					$children_data[] = array(
						'name'  => $child['name'] . ($this->config->get('config_product_count') ? ' (' . $this->model_catalog_product->getTotalProducts($filter_data) . ')' : ''),
						'href'  => $this->url->link('product/category', 'path=' . $category['category_id'] . '_' . $child['category_id'])
					);
				}

				// Level 1
				$data['categories'][] = array(
					'name'     => $category['name'],
					'children' => $children_data,
					'column'   => $category['column'] ? $category['column'] : 1,
					'href'     => $this->url->link('product/category', 'path=' . $category['category_id'])
				);
			}
		}

		$data['language'] = $this->load->controller('common/language');
		$data['currency'] = $this->load->controller('common/currency');
		$data['search'] = $this->load->controller('common/search');
		$data['cart'] = $this->load->controller('common/cart');
		$data['sphinx_autocomplete_js'] = $this->load->controller('module/sphinxautocomplete/sphinx_autocomplete_js');

		// For page specific css
		if (isset($this->request->get['route'])) {
			if (isset($this->request->get['product_id'])) {
				$class = '-' . $this->request->get['product_id'];
			} elseif (isset($this->request->get['path'])) {
				$class = '-' . $this->request->get['path'];
			} elseif (isset($this->request->get['manufacturer_id'])) {
				$class = '-' . $this->request->get['manufacturer_id'];
			} else {
				$class = '';
			}

			$data['class'] = str_replace('/', '-', $this->request->get['route']) . $class;
		} else {
			$data['class'] = 'common-home';
		}
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
						$data['google_ga_remarketing_code'] = $this->getGaRemarketingCode('', 'home');
					}

					
					//-- CASE HOME VIEW
					elseif (isset($this->request->get["route"]) && $this->request->get["route"] == "common/home")
					{							
						$data['google_ga_remarketing_code'] = $this->getGaRemarketingCode('', 'home');
					}


					//-- CASE PRODUCT VIEW
					elseif (isset($this->request->get["route"]) && $this->request->get["route"] == "product/product")
					{		
						$product_info = $this->model_catalog_product->getProduct($this->request->get["product_id"]);
						$product_info_temp = array();
						$product_info_temp[] = $product_info;
						$data['google_ga_remarketing_code'] = $this->getGaRemarketingCode($product_info_temp, 'product');
					}

					//-- CASE CART VIEW
					elseif (isset($this->request->get["route"]) && $this->request->get["route"] == "checkout/checkout" || $this->request->get["route"] == "checkout/cart" || $this->request->get["route"] == "supercheckout/supercheckout")
					{		
						$data['google_ga_remarketing_code'] = $this->getGaRemarketingCode($this->cart->getProducts(), 'cart');					
					}

					
					//-- CASE PURCHASE VIEW
					elseif (isset($this->request->get["route"]) && $this->request->get["route"] == "checkout/success")
					{
						if($this->cart->countProducts() > 0)
						{
							$data['google_ga_remarketing_code'] = $this->getGaRemarketingCode($this->cart->getProducts(), 'purchase');
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

						$data['google_ga_remarketing_code'] = $this->getGaRemarketingCode('', 'category', $category_names);
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
						$data['google_ga_remarketing_code'] = $this->getGaRemarketingCode('', 'category', $manufacturers_names);
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
									$this->document->setTitle($this->request->get['search'] .  ' - ' . $this->language->get('heading_title'));
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
				
								$data['google_ga_remarketing_code'] = $this->getGaRemarketingCode($results, 'searchresults');
							}
						//-- END GET ALL PRODUCTS FILTERED
							else
							{
								$data['google_ga_remarketing_code'] = $this->getGaRemarketingCode('', 'searchresults');
							}
					}
					

					//-- CASE OTHER VIEWS
					else
					{
						$data['google_ga_remarketing_code'] = $this->getGaRemarketingCode('', 'other');
					}
				
					
				} //END DYNAMIC TYPE
				else //STANDARD TYPE
				{
					$data['google_ga_remarketing_code'] = html_entity_decode($this->config->get('config_google_analytics'));
				}
				
			}
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/header.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/template/common/header.tpl', $data);
		} else {
			return $this->load->view('default/template/common/header.tpl', $data);
		}
	}
}