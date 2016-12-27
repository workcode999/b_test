<?php
class ControllerProductProduct extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('product/product');

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);

		$this->load->model('catalog/category');

		if (isset($this->request->get['path'])) {
			$path = '';

			$parts = explode('_', (string)$this->request->get['path']);

			$category_id = (int)array_pop($parts);

			foreach ($parts as $path_id) {
				if (!$path) {
					$path = $path_id;
				} else {
					$path .= '_' . $path_id;
				}

				$category_info = $this->model_catalog_category->getCategory($path_id);

				if ($category_info) {
					$data['breadcrumbs'][] = array(
						'text' => $category_info['name'],
						'href' => $this->url->link('product/category', 'path=' . $path)
					);
				}
			}

			// Set the last category breadcrumb
			$category_info = $this->model_catalog_category->getCategory($category_id);

			if ($category_info) {
				$url = '';

				if (isset($this->request->get['sort'])) {
					$url .= '&sort=' . $this->request->get['sort'];
				}

				if (isset($this->request->get['order'])) {
					$url .= '&order=' . $this->request->get['order'];
				}

				if (isset($this->request->get['page'])) {
					$url .= '&page=' . $this->request->get['page'];
				}

				if (isset($this->request->get['limit'])) {
					$url .= '&limit=' . $this->request->get['limit'];
				}

				$data['breadcrumbs'][] = array(
					'text' => $category_info['name'],
					'href' => $this->url->link('product/category', 'path=' . $this->request->get['path'] . $url)
				);
			}
		}

		$this->load->model('catalog/manufacturer');

		if (isset($this->request->get['manufacturer_id'])) {
			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('text_brand'),
				'href' => $this->url->link('product/manufacturer')
			);

			$url = '';

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$manufacturer_info = $this->model_catalog_manufacturer->getManufacturer($this->request->get['manufacturer_id']);

			if ($manufacturer_info) {
				$data['breadcrumbs'][] = array(
					'text' => $manufacturer_info['name'],
					'href' => $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $this->request->get['manufacturer_id'] . $url)
				);
			}
		}

		if (isset($this->request->get['search']) || isset($this->request->get['tag'])) {
			$url = '';

			if (isset($this->request->get['search'])) {
				$url .= '&search=' . $this->request->get['search'];
			}

			if (isset($this->request->get['tag'])) {
				$url .= '&tag=' . $this->request->get['tag'];
			}

			if (isset($this->request->get['description'])) {
				$url .= '&description=' . $this->request->get['description'];
			}

			if (isset($this->request->get['category_id'])) {
				$url .= '&category_id=' . $this->request->get['category_id'];
			}

			if (isset($this->request->get['sub_category'])) {
				$url .= '&sub_category=' . $this->request->get['sub_category'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('text_search'),
				'href' => $this->url->link('product/search', $url)
			);
		}

		if (isset($this->request->get['product_id'])) {
			$product_id = (int)$this->request->get['product_id'];
		} else {
			$product_id = 0;
		}

		$this->load->model('catalog/product');

		$product_info = $this->model_catalog_product->getProduct($product_id);
//echo '<pre>';print_r($product_info);die;
		if ($product_info) {
						$this->load->helper('qa');
			$data['qa_status'] = $this->config->get('qa_status') && in_array($this->config->get('config_store_id'), bdecode($this->config->get('qa_as')));
			if ($data['qa_status']) {
				if (file_exists('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/qa.css')) {
					$this->document->addStyle('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/qa.css');
				} else {
					$this->document->addStyle('catalog/view/theme/default/stylesheet/qa.css');
				}

				$data['tab_qa'] = $this->language->get('tab_qa');

				$data['text_ask'] = $this->language->get('text_ask');

				$data['entry_question'] = $this->language->get('entry_question');
				$data['entry_email'] = $this->language->get('entry_email');
				$data['entry_phone'] = $this->language->get('entry_phone');
				$custom_field_names = $this->config->get('qa_form_custom_field_name');
				$data['entry_custom'] = $custom_field_names[$this->config->get('config_language_id')] . ':';
				$data['entry_captcha'] = $this->language->get('entry_captcha');

				$this->load->model('catalog/qa');

				$data['qa_display_questions'] = $this->config->get('qa_display_questions');
				$data['qa_form_display_name'] = $this->config->get('qa_form_display_name');
				$data['qa_form_require_name'] = $this->config->get('qa_form_require_name');
				$data['qa_form_display_email'] = $this->config->get('qa_form_display_email');
				$data['qa_form_require_email'] = $this->config->get('qa_form_require_email');
				$data['qa_form_display_phone'] = $this->config->get('qa_form_display_phone');
				$data['qa_form_require_phone'] = $this->config->get('qa_form_require_phone');
				$data['qa_form_display_custom_field'] = $this->config->get('qa_form_display_custom_field');
				$data['qa_form_require_custom_field'] = $this->config->get('qa_form_require_custom_field');

				$data['captcha_route'] = '';
				if (version_compare(VERSION, '2.1.0', '>=')) {
					$data['qa_form_display_captcha'] = (int)$this->config->get('qa_form_display_captcha') && (int)$this->config->get($this->config->get('config_captcha') . '_status');
					$data['recaptcha'] = $data['qa_form_display_captcha'] && $this->config->get('config_captcha') == "google_captcha";
					if ($data['recaptcha']) {
						$this->document->addScript('https://www.google.com/recaptcha/api.js');

						$data['site_key'] = $this->config->get('google_captcha_key');
					} else {
						$data['captcha_img'] = $this->url->link('captcha/basic_captcha/captcha', '', true);
						$data['captcha_route'] = 'captcha/basic_captcha/captcha';
					}
				} else if (version_compare(VERSION, '2.0.2', '>=')) {
					$data['qa_form_display_captcha'] = (int)$this->config->get('qa_form_display_captcha') && (int)$this->config->get('config_google_captcha_status');
					$data['recaptcha'] = true;
				} else {
					$data['qa_form_display_captcha'] = $this->config->get('qa_form_display_captcha');
					$data['recaptcha'] = false;
					//$data['captcha_route'] = 'tool/captcha';
				}
				$data['qa_form_require_captcha'] = $this->config->get('qa_form_require_captcha');
				$data['preload'] = (int)$this->config->get("qa_preload");

				$data['q_name'] = ($this->customer->isLogged()) ? $this->customer->getFirstName() . " " . $this->customer->getLastName() : "";
				$data['q_email'] = ($this->customer->isLogged()) ? $this->customer->getEmail() : "";

				if ($data['preload'] == 1) {
					$data['qas'] =  $this->question($product_id, 1, false);
				} else if ($data['preload'] == 2) {
					$data['qas'] =  $this->question($product_id, 1, false, 0);
				} else {
					$data['qas'] =  '';
				}

				$data['qa_count'] = $this->model_catalog_qa->getTotalQuestionsByProductId($this->request->get['product_id']);
			}
			
			
			$url = '';

			if (isset($this->request->get['path'])) {
				$url .= '&path=' . $this->request->get['path'];
			}

			if (isset($this->request->get['filter'])) {
				$url .= '&filter=' . $this->request->get['filter'];
			}

			if (isset($this->request->get['manufacturer_id'])) {
				$url .= '&manufacturer_id=' . $this->request->get['manufacturer_id'];
			}

			if (isset($this->request->get['search'])) {
				$url .= '&search=' . $this->request->get['search'];
			}

			if (isset($this->request->get['tag'])) {
				$url .= '&tag=' . $this->request->get['tag'];
			}

			if (isset($this->request->get['description'])) {
				$url .= '&description=' . $this->request->get['description'];
			}

			if (isset($this->request->get['category_id'])) {
				$url .= '&category_id=' . $this->request->get['category_id'];
			}

			if (isset($this->request->get['sub_category'])) {
				$url .= '&sub_category=' . $this->request->get['sub_category'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

		

			$this->document->setTitle($product_info['meta_title']);
			$this->document->setDescription($product_info['meta_description']);
			$this->document->setKeywords($product_info['meta_keyword']);
			$this->document->addLink($this->url->link('product/product', 'product_id=' . $this->request->get['product_id']), 'canonical');
			$this->document->addScript('catalog/view/javascript/jquery/magnific/jquery.magnific-popup.min.js');
			$this->document->addStyle('catalog/view/javascript/jquery/magnific/magnific-popup.css');
			$this->document->addScript('catalog/view/javascript/jquery/datetimepicker/moment.js');
			$this->document->addScript('catalog/view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.js');
			$this->document->addStyle('catalog/view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.css');
			
			$data['heading_title'] = $product_info['name'];

			$data['text_select'] = $this->language->get('text_select');
			$data['text_manufacturer'] = $this->language->get('text_manufacturer');
			$data['text_model'] = $this->language->get('text_model');
			$data['text_reward'] = $this->language->get('text_reward');
			$data['text_points'] = $this->language->get('text_points');
			$data['text_stock'] = $this->language->get('text_stock');
			$data['text_discount'] = $this->language->get('text_discount');
			$data['text_tax'] = $this->language->get('text_tax');
			$data['text_option'] = $this->language->get('text_option');
			$data['text_minimum'] = sprintf($this->language->get('text_minimum'), $product_info['minimum']);
			$data['text_write'] = $this->language->get('text_write');
			$data['text_login'] = sprintf($this->language->get('text_login'), $this->url->link('account/login', '', 'SSL'), $this->url->link('account/register', '', 'SSL'));
			$data['text_note'] = $this->language->get('text_note');
			$data['text_tags'] = $this->language->get('text_tags');
			$data['text_related'] = $this->language->get('text_related');
			$data['text_loading'] = $this->language->get('text_loading');
			$data['text_bust'] = $this->language->get('text_bust');
			$data['text_waist'] = $this->language->get('text_waist');
			$data['text_hip'] = $this->language->get('text_hip');
			$data['text_hollow'] = $this->language->get('text_hollow');
			$data['text_height'] = $this->language->get('text_height');
		    $data['text_size_selected'] = $this->language->get('text_size_selected');
			$data['text_size_details'] = $this->language->get('text_size_details');
			$data['text_item_remarks'] = $this->language->get('text_item_remarks');
			$data['text_submit'] = $this->language->get('text_submit');
			$data['text_inch'] = $this->language->get('text_inch');
			$data['text_free'] = $this->language->get('text_free');
			$data['text_cancel'] = $this->language->get('text_cancel');
			
			$data['entry_qty'] = $this->language->get('entry_qty');
			$data['entry_name'] = $this->language->get('entry_name');
			$data['entry_review'] = $this->language->get('entry_review');
			$data['entry_rating'] = $this->language->get('entry_rating');
			$data['entry_good'] = $this->language->get('entry_good');
			$data['entry_bad'] = $this->language->get('entry_bad');
			$data['entry_captcha'] = $this->language->get('entry_captcha');
			$data['entry_email'] = $this->language->get('entry_email');

			$data['button_cart'] = $this->language->get('button_cart');
			
			$data['button_wishlist'] = $this->language->get('button_wishlist');
			$data['button_compare'] = $this->language->get('button_compare');
			$data['button_upload'] = $this->language->get('button_upload');
			$data['button_continue'] = $this->language->get('button_continue');

			$this->load->model('catalog/review');

			$data['tab_description'] = $this->language->get('tab_description');
			$data['tab_attribute'] = $this->language->get('tab_attribute');
			$data['tab_review'] = $this->language->get('tab_review');

			$data['product_id'] = (int)$this->request->get['product_id'];
			$data['product_link'] = $this->url->link('product/product', 'product_id=' . $this->request->get['product_id']);
			$data['manufacturer'] = $product_info['manufacturer'];
			$data['manufacturers'] = $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $product_info['manufacturer_id']);
			$data['model'] = $product_info['model'];
			$data['reward'] = $product_info['reward'];
			$data['extra_field'] = html_entity_decode($product_info['extra_field'], ENT_QUOTES, 'UTF-8');
			$data['points'] = $product_info['points'];
			//$data['image_name'] = ucwords(str_replace("-"," ",substr($product_info['image'],22,strlen($product_info['image'])-strlen(strstr($product_info['image'],'-dress'))-22)));

			$data['color'] = substr($product_info['image'],22,strlen($product_info['image'])-strlen(strstr($product_info['image'],'-dress'))-22);

			
			$Product_Id = $this->model_catalog_product->getTotalProductIDByPID($data['product_id']);
			
			$pds = array();
		
			
			if($Product_Id['master_product_id'] == -1){//无系列的产品（单个产品）
				$product_id = $Product_Id['product_id'];
			}else{
				if($Product_Id['master_product_id'] == 0){//系列产品  

					unset($Product_Id['master_product_id']);
					$product_id = $Product_Id['product_id'];
				
				}else{
					unset($Product_Id['product_id']);
					$product_id = $Product_Id['master_product_id'];

				}
				//$product_id = 44369;//23650
				
				
				$product_color = $this->model_catalog_product->getProductIDByProductID($product_id);
				
				if(empty($product_color)){
					$product_id = $Product_Id['product_id'];

				}else{

					if(is_array($product_color)){
						foreach($product_color as $key=>$val){
							$pro_id[$key] = $val['product_id'];
						}
						if(!empty($product_color)){
							array_push($pro_id,$product_id);
						}
					
						$product_id = $pro_id;
					}
				}			
			}
			$pds = $this->model_catalog_product->getColorByProductID($product_id);

			
			foreach($pds as $k=>$v){
				$pds[$k]['product_pds_image'] = 'image/catalog/color/'.str_replace(' ','-',strtolower(trim($v['product_name']))).'-24x24.jpg';
				$pds[$k]['product_link'] = $this->url->link('product/product', $url . '&product_id=' . $v['product_id']);
			}
			$data['pds'] = $pds;
			if ($product_info['quantity'] <= 0) {
				$data['stock'] = $product_info['stock_status'];
			} elseif ($this->config->get('config_stock_display')) {
				$data['stock'] = $product_info['quantity'];
			} else {
				$data['stock'] = $this->language->get('text_instock');
			}

			$this->load->model('tool/image');

			if ($product_info['image']) {
				$data['popup'] = $this->model_tool_image->resize($product_info['image'], $this->config->get('config_image_popup_width'), $this->config->get('config_image_popup_height'));
			} else {
				$data['popup'] = '';
			}

			if ($product_info['image']) {
				$data['thumb'] = $this->model_tool_image->resize($product_info['image'], $this->config->get('config_image_thumb_width'), $this->config->get('config_image_thumb_height'));
			} else {
				$data['thumb'] = '';
			}

			$data['images'] = array();

			$results = $this->model_catalog_product->getProductImages($this->request->get['product_id']);

			foreach ($results as $result) {
				$data['images'][] = array(
					'popup' => $this->model_tool_image->resize($result['image'], $this->config->get('config_image_popup_width'), $this->config->get('config_image_popup_height')),
					'thumb' => $this->model_tool_image->resize($result['image'], $this->config->get('config_image_additional_width'), $this->config->get('config_image_additional_height'))
				);
			}

			if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
				$data['price'] = $this->currency->format($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')));
			} else {
				$data['price'] = false;
			}

			if ((float)$product_info['special']) {
				$data['special'] = $this->currency->format($this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax')));
				$data['special_microdata_price'] = $this->currency->format_microdata($this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax')));
				$data['special_microdata_code'] = $this->currency->getCode();
			} else {
				$data['special'] = false;
				$data['special_microdata_price'] = false;
				$data['special_microdata_code'] = false;
			}
			if ((float)$product_info['off']) {
               $data['off'] = $product_info['off'];
            } else {
               $data['off'] = false;
            }

			if ((float)$product_info['save']) {
               $data['save'] = $this->currency->format($product_info['save']);
            } else {
               $data['save'] = false;
            }
			if ($this->config->get('config_tax')) {
				$data['tax'] = $this->currency->format((float)$product_info['special'] ? $product_info['special'] : $product_info['price']);
			} else {
				$data['tax'] = false;
			}

			$discounts = $this->model_catalog_product->getProductDiscounts($this->request->get['product_id']);

			$data['discounts'] = array();

			foreach ($discounts as $discount) {
				$data['discounts'][] = array(
					'quantity' => $discount['quantity'],
					'price'    => $this->currency->format($this->tax->calculate($discount['price'], $product_info['tax_class_id'], $this->config->get('config_tax')))
				);
			}

			$data['options'] = array();

			foreach ($this->model_catalog_product->getProductOptions($this->request->get['product_id']) as $option) {
				$product_option_value_data = array();
				if($option['type']=='size_option')
				{
					foreach ($option['product_option_value'] as $option_value) {
					if (!$option_value['subtract'] || ($option_value['quantity'] > 0)) {
						if ((($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) && (float)$option_value['price']) {
							$price = $this->currency->format($this->tax->calculate($option_value['price'], $product_info['tax_class_id'], $this->config->get('config_tax') ? 'P' : false));
						} else {
							$price = false;
						}
						
						$value_type = $this->model_catalog_product->getoptionvaluetype($option_value['option_value_id']);

						$product_option_value_data[] = array(
							'product_option_value_id' => $option_value['product_option_value_id'],
							'option_value_id'         => $option_value['option_value_id'],
							'name'                    => $option_value['name'],
							'value_type'              => $value_type,
							'image'                   => $this->model_tool_image->resize($option_value['image'], 50, 50),
							'custom_option'           => $option_value['extras'],
							'price'                   => $price,
							'price_prefix'            => $option_value['price_prefix']
						);
					}
				}
					
				} else {

					foreach ($option['product_option_value'] as $option_value) {
						if (!$option_value['subtract'] || ($option_value['quantity'] > 0)) {
							if ((($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) && (float)$option_value['price']) {
								$price = $this->currency->format($this->tax->calculate($option_value['price'], $product_info['tax_class_id'], $this->config->get('config_tax') ? 'P' : false));
							} else {
								$price = false;
							}
	
							$product_option_value_data[] = array(
								'product_option_value_id' => $option_value['product_option_value_id'],
								'option_value_id'         => $option_value['option_value_id'],
								'name'                    => $option_value['name'],
								'image'                   => $this->model_tool_image->resize($option_value['image'], 50, 50),
								'price'                   => $price,
								'price_prefix'            => $option_value['price_prefix']
							);
						}
					}
				}
				$data['options'][] = array(
					'product_option_id'    => $option['product_option_id'],
					'product_option_value' => $product_option_value_data,
					'option_id'            => $option['option_id'],
					'name'                 => $option['name'],
					'type'                 => $option['type'],
					'value'                => $option['value'],
					'required'             => $option['required']
				);
			}

			if ($product_info['minimum']) {
				$data['minimum'] = $product_info['minimum'];
			} else {
				$data['minimum'] = 1;
			}

			$data['review_status'] = $this->config->get('config_review_status');

			if ($this->config->get('config_review_guest') || $this->customer->isLogged()) {
				$data['review_guest'] = true;
			} else {
				$data['review_guest'] = false;
			}

			if ($this->customer->isLogged()) {
				$data['customer_name'] = $this->customer->getFirstName() . '&nbsp;' . $this->customer->getLastName();
			} else {
				$data['customer_name'] = '';
			}

			$data['reviews'] = sprintf($this->language->get('text_reviews'), (int)$product_info['reviews']);
			$data['rating'] = (int)$product_info['rating'];
			$data['description'] = html_entity_decode($product_info['description'], ENT_QUOTES, 'UTF-8');
			$data['attribute_groups'] = $this->model_catalog_product->getProductAttributes($this->request->get['product_id']);
			
			foreach($data['attribute_groups'] as $k=>$attribute){
					foreach($attribute['attribute'] as $key=>$val){
					
						$text = strpos($val['text'],',');
						if($text){
							if ($val['attribute_id'] != 19){
								$exp = explode(',',$val['text']);
								foreach($exp as $key1=>$val1){
										$value = trim($val1);
										$exp[$key1] = '<a href ="index.php?route=product/search&search='.$value.'">'.$value.'</a>';
								}
								$txt = implode($exp,',');
							}else{
								$txt = $val['text'];
							}
						}else{
							if($val['text'] == 'Yes'){
								$txt = $val['text'];			
							}else if($val['text'] == 'No'){
								$txt = $val['text'];	
							}else if(strpos($val['text'],'kg') || strpos($val['text'],'Kg')){
								$txt = $val['text'];
							}else{
								
								if ($val['attribute_id'] == '19'){
									$txt = $val['text'];
								}else{
									$txt = '<a href ="index.php?route=product/search&search='.$val['text'].'">'.$val['text'].'</a>';
								}
								
							}
						}
					
					$data['attribute_groups'][$k]['attribute'][$key]['text'] = $txt;
				}
			}
			
			$data['products'] = array();

			//$results = $this->model_catalog_product->getProductRelated($this->request->get['product_id']);
			
			if(empty($category_id)){
				$category_id = '';
			}
			$res = $this->model_catalog_product->getRelatedProducts($category_id,$this->request->get['product_id']);
			
			$keys = array_rand($res,6);
			foreach ($keys as $key=>$val){
				 $infos[] = $res[$val];
			}
		
			foreach ($infos as $result) {
				unset($pids);
				$PID = $this->model_catalog_product->getTotalProductIDByPID($result['product_id']);
				
				if ($PID['master_product_id'] == -1){
					$pids = $PID['product_id'];
					$colors = $this->model_catalog_product->getColorByProductID($pids);
				}else{
					if($PID['master_product_id'] == 0){
						$parentid = $PID['product_id'];
					}else{
						$parentid = $PID['master_product_id'];
					}
					
					$ids = $this->model_catalog_product->getProductIDByProductID($parentid);
					if(!empty($ids)){
						foreach($ids as $key=>$val){
							$pids[] = $val['product_id'];
						}
						$colors = $this->model_catalog_product->getColorByProductID($pids);
					}else{
						$colors = '';
					}
				}
				$num = count($colors);
				if ($result['image']) {
					$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_related_width'), $this->config->get('config_image_related_height'));
				} else {
					$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_related_width'), $this->config->get('config_image_related_height'));
				}

				if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
					$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
				} else {
					$price = false;
				}

				if ((float)$result['special']) {
					$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
				} else {
					$special = false;
				}

				if ($this->config->get('config_tax')) {
					$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
				} else {
					$tax = false;
				}

				if ($this->config->get('config_review_status')) {
					$rating = (int)$result['rating'];
				} else {
					$rating = false;
				}

				$data['products'][] = array(
					'product_id'  => $result['product_id'],
					'thumb'       => $image,
					'name'        => $result['name'],
					'model'		  => $result['model'],
					'off'         => 100 * round(1 - ($result['special'] / $result['price']),2),
					'num'		  => $num,
					'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
					'price'       => $price,
					'special'     => $special,
					'tax'         => $tax,
					'rating'      => $rating,
					'href'        => $this->url->link('product/product', 'product_id=' . $result['product_id'])
				);
			}
			
			$data['tags'] = array();

			if ($product_info['tag']) {
				$tags = explode(',', $product_info['tag']);

				foreach ($tags as $tag) {
					$data['tags'][] = array(
						'tag'  => trim($tag),
						'href' => $this->url->link('product/search', 'tag=' . trim($tag))
					);
				}
			}

			$data['text_payment_recurring'] = $this->language->get('text_payment_recurring');
			$data['recurrings'] = $this->model_catalog_product->getProfiles($this->request->get['product_id']);
			$this->model_catalog_product->updateViewed($this->request->get['product_id']);

			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');
		 	$this->load->model('module/addthis');
	        $moduleSettingAddthis = $this->model_module_addthis->getSetting('addthis', $this->config->get('config_store_id'));
	        $data['addthisData'] = isset($moduleSettingAddthis['addthis']) ? $moduleSettingAddthis['addthis'] : array();

			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/product/product.tpl')) {
				$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/product/product.tpl', $data));
			} else {
				$this->response->setOutput($this->load->view('default/template/product/product.tpl', $data));
			}
		} else {
			$url = '';

			if (isset($this->request->get['path'])) {
				$url .= '&path=' . $this->request->get['path'];
			}

			if (isset($this->request->get['filter'])) {
				$url .= '&filter=' . $this->request->get['filter'];
			}

			if (isset($this->request->get['manufacturer_id'])) {
				$url .= '&manufacturer_id=' . $this->request->get['manufacturer_id'];
			}

			if (isset($this->request->get['search'])) {
				$url .= '&search=' . $this->request->get['search'];
			}

			if (isset($this->request->get['tag'])) {
				$url .= '&tag=' . $this->request->get['tag'];
			}

			if (isset($this->request->get['description'])) {
				$url .= '&description=' . $this->request->get['description'];
			}

			if (isset($this->request->get['category_id'])) {
				$url .= '&category_id=' . $this->request->get['category_id'];
			}

			if (isset($this->request->get['sub_category'])) {
				$url .= '&sub_category=' . $this->request->get['sub_category'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('text_error'),
				'href' => $this->url->link('product/product', $url . '&product_id=' . $product_id)
			);

			$this->document->setTitle($this->language->get('text_error'));

			$data['heading_title'] = $this->language->get('text_error');

			$data['text_error'] = $this->language->get('text_error');

			$data['button_continue'] = $this->language->get('button_continue');

			$data['continue'] = $this->url->link('common/home');

			$this->response->addHeader($this->request->server['SERVER_PROTOCOL'] . ' 404 Not Found');

			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');

			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/error/not_found.tpl')) {
				$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/error/not_found.tpl', $data));
			} else {
				$this->response->setOutput($this->load->view('default/template/error/not_found.tpl', $data));
			}
		}
	}

	public function review() {
		$this->language->load('product/review_booster');
		
		$this->load->language('product/product');

		$this->load->model('catalog/review');

		$data['text_no_reviews'] = $this->language->get('text_no_reviews');

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}

		$data['reviews'] = array();

		$review_total = $this->model_catalog_review->getTotalReviewsByProductId($this->request->get['product_id']);

		$results = $this->model_catalog_review->getReviewsByProductId($this->request->get['product_id'], ($page - 1) * 5, 5);

		foreach ($results as $result) {
			if ($this->config->get('review_booster_status') && $this->config->get('review_booster_verified_buyer_status')) {
				$review_query = $this->db->query("SELECT customer_id, verified_buyer FROM " . DB_PREFIX . "review WHERE review_id = '" . (int)$result['review_id'] . "'");

				if (($review_query->row['customer_id'] || $review_query->row['verified_buyer'])) {
					$result['author'] .= ' <span class="verified_buyer">' . $this->language->get('text_verified_buyer') . '</span>';
				}
			}
			
			$data['reviews'][] = array(
				'author'     => $result['author'],
				'text'       => nl2br($result['text']),
				'rating'     => (int)$result['rating'],
				'date_added' => date($this->language->get('date_format_short'), strtotime($result['date_added']))
			);
		}

		$pagination = new Pagination();
		$pagination->total = $review_total;
		$pagination->page = $page;
		$pagination->limit = 5;
		$pagination->url = $this->url->link('product/product/review', 'product_id=' . $this->request->get['product_id'] . '&page={page}');

		$data['pagination'] = $pagination->render();

		$data['results'] = sprintf($this->language->get('text_pagination'), ($review_total) ? (($page - 1) * 3) + 1 : 0, ((($page - 1) * 3) > ($review_total - 3)) ? $review_total : ((($page - 1) * 3) + 3), $review_total, ceil($review_total / 3));

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/product/review.tpl')) {
			$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/product/review.tpl', $data));
		} else {
			$this->response->setOutput($this->load->view('default/template/product/review.tpl', $data));
		}
	}

	public function getRecurringDescription() {
		$this->language->load('product/product');
		$this->load->model('catalog/product');

		if (isset($this->request->post['product_id'])) {
			$product_id = $this->request->post['product_id'];
		} else {
			$product_id = 0;
		}

		if (isset($this->request->post['recurring_id'])) {
			$recurring_id = $this->request->post['recurring_id'];
		} else {
			$recurring_id = 0;
		}

		if (isset($this->request->post['quantity'])) {
			$quantity = $this->request->post['quantity'];
		} else {
			$quantity = 1;
		}

		$product_info = $this->model_catalog_product->getProduct($product_id);
		$recurring_info = $this->model_catalog_product->getProfile($product_id, $recurring_id);

		$json = array();

		if ($product_info && $recurring_info) {
			if (!$json) {
				$frequencies = array(
					'day'        => $this->language->get('text_day'),
					'week'       => $this->language->get('text_week'),
					'semi_month' => $this->language->get('text_semi_month'),
					'month'      => $this->language->get('text_month'),
					'year'       => $this->language->get('text_year'),
				);

				if ($recurring_info['trial_status'] == 1) {
					$price = $this->currency->format($this->tax->calculate($recurring_info['trial_price'] * $quantity, $product_info['tax_class_id'], $this->config->get('config_tax')));
					$trial_text = sprintf($this->language->get('text_trial_description'), $price, $recurring_info['trial_cycle'], $frequencies[$recurring_info['trial_frequency']], $recurring_info['trial_duration']) . ' ';
				} else {
					$trial_text = '';
				}

				$price = $this->currency->format($this->tax->calculate($recurring_info['price'] * $quantity, $product_info['tax_class_id'], $this->config->get('config_tax')));

				if ($recurring_info['duration']) {
					$text = $trial_text . sprintf($this->language->get('text_payment_description'), $price, $recurring_info['cycle'], $frequencies[$recurring_info['frequency']], $recurring_info['duration']);
				} else {
					$text = $trial_text . sprintf($this->language->get('text_payment_cancel'), $price, $recurring_info['cycle'], $frequencies[$recurring_info['frequency']], $recurring_info['duration']);
				}

				$json['success'] = $text;
			}
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

				public function question($product_id = null, $page = 1, $ajax = true, $per_page = null) {
		$this->load->helper('qa');
		if (!(int)$this->config->get('qa_display_questions') || !in_array($this->config->get('config_store_id'), bdecode($this->config->get('qa_as')))) {
			return;
		}

		$this->language->load('product/product');

		$this->load->model('catalog/qa');

		$data['text_no_questions'] = $this->language->get('text_no_questions');
		$data['text_no_answer'] = $this->language->get('text_no_answer');

		$data['qa_display_question_author'] = $this->config->get('qa_display_question_author');
		$data['qa_display_question_date'] = $this->config->get('qa_display_question_date');
		$data['qa_display_answer_author'] = $this->config->get('qa_display_answer_author');
		$data['qa_display_answer_date'] = $this->config->get('qa_display_answer_date');

		if ($ajax) {
			if (isset($this->request->get['page'])) {
				$page = $this->request->get['page'];
			} else {
				$page = 1;
			}

			$product_id = $this->request->get['product_id'];
		}

		$data['qas'] = array();
		if (is_null($per_page)) {
			$per_page = (int)$this->config->get('qa_items_per_page');
		}

		$results = $this->model_catalog_qa->getQuestionsByProductId($product_id, ($page - 1) * $per_page, $per_page);

		foreach ($results as $result) {
			$data['qas'][] = array(
				'q_author'   => $result['question_author_name'],
				'a_author'   => $result['answer_author_name'],
				'question'   => html_entity_decode($result['question']),
				'answer'     => html_entity_decode($result['answer']),
				'date_asked' => date($this->language->get('date_format_short'), strtotime($result['date_asked'])),
				'date_answered' => date($this->language->get('date_format_short'), strtotime($result['date_answered']))
			);
		  }

		$qa_total = $this->model_catalog_qa->getTotalQuestionsByProductId($product_id);

		$limit = ($per_page) ? $per_page : $qa_total;

		$pagination = new Pagination();
		$pagination->total = $qa_total;
		$pagination->page = $page;
		$pagination->limit = $limit;
		$pagination->url = $this->url->link('product/product/question', 'product_id=' . $product_id . '&page={page}');

		$data['pagination'] = $pagination->render();

		$data['results'] = sprintf($this->language->get('text_pagination'), ($qa_total) ? (($page - 1) * $limit) + 1 : 0, ((($page - 1) * $limit) > ($qa_total - $limit)) ? $qa_total : ((($page - 1) * $limit) + $limit), $qa_total, ($limit > 0) ? ceil($qa_total / $limit) : 0);

		if (version_compare(VERSION, '2.2.0', '>=')) {
			$template = 'product/qa';
		} else {
			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/product/qa.tpl')) {
				$template = $this->config->get('config_template') . '/template/product/qa.tpl';
			} else {
				$template = 'default/template/product/qa.tpl';
			}
		}
		if ($ajax) {
			$this->response->setOutput($this->load->view($template, $data));
		} else {
			return $this->load->view($template, $data);
		}
	}

	public function ask() {
		$this->load->helper('qa');

		if (!in_array($this->config->get('config_store_id'), bdecode($this->config->get('qa_as')))) {
			return;
		}

		$this->language->load('product/product');

		$this->load->helper('qa');
		$this->load->model('catalog/qa');

		$json = array();

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateQuestion($this->request->post)) {
			$this->model_catalog_qa->addQuestion($this->request->get['product_id'], $this->request->post);

			$json['success'] = $this->language->get('text_success_question');
		} else {
			$json['error'] = $this->error['message'];
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_enc($json));
	}

	private function validateQuestion($data) {
		if ((int)$this->config->get('qa_form_display_name') && (int)$this->config->get('qa_form_require_name') && (!isset($data['q_name']) || utf8_strlen($data['q_name']) < 1)) {
			$this->error['message'] = $this->language->get('error_q_author');
		}

		if ((int)$this->config->get('qa_form_display_email') && (int)$this->config->get('qa_form_require_email') && (!isset($data['q_email']) || !validate_email(utf8_decode($data['q_email']))) || (!empty($data['q_email']) && !validate_email(utf8_decode($data['q_email'])))) {
			$this->error['message'] = $this->language->get('error_q_email');
		}

		if ((int)$this->config->get('qa_form_display_phone') && (int)$this->config->get('qa_form_require_phone') && (!isset($data['q_phone']) || utf8_strlen($data['q_phone']) < 5)) {
			$this->error['message'] = $this->language->get('error_q_phone');
		}

		if ((int)$this->config->get('qa_form_display_custom_field') && (int)$this->config->get('qa_form_require_custom_field') && (!isset($data['q_custom']) || utf8_strlen($data['q_custom']) < 1)) {
			$custom_field_names = $this->config->get('qa_form_custom_field_name');
			$this->error['message'] = sprintf($this->language->get('error_q_custom'), $custom_field_names[$this->config->get('config_language_id')]);
		}

		if (!isset($data['q_question']) || (utf8_strlen($data['q_question']) < 15) || (utf8_strlen($data['q_question']) > 1000)) {
			$this->error['message'] = $this->language->get('error_q_question');
		}

		/*if (version_compare(VERSION, '2.1.0', '>=')) {
			if ((int)$this->config->get('qa_form_display_captcha') && (int)$this->config->get('qa_form_require_captcha') && (int)$this->config->get($this->config->get('config_captcha') . '_status')) {
				$this->request->post['captcha'] = isset($data['q_captcha']) ? $data['q_captcha'] : '';
				$captcha = $this->load->controller('captcha/' . $this->config->get('config_captcha') . '/validate');

				if ($captcha) {
					$errors = true;
					if ($this->config->get('config_captcha') == "google_captcha") {
						$this->error['message'] = $this->language->get('error_q_recaptcha');
					} else {
						$this->error['message'] = $captcha;
					}
				}
			}
		} else if (version_compare(VERSION, '2.0.2', '>=') && $this->config->get('config_google_captcha_status') && isset($data['g-recaptcha-response'])) {
			$recaptcha = file_get_contents('https://www.google.com/recaptcha/api/siteverify?secret=' . urlencode($this->config->get('config_google_captcha_secret')) . '&response=' . $data['g-recaptcha-response'] . '&remoteip=' . $this->request->server['REMOTE_ADDR']);

			$recaptcha = json_decode($recaptcha, true);

			if ((int)$this->config->get('qa_form_display_captcha') && (int)$this->config->get('qa_form_require_captcha') && (!isset($data['g-recaptcha-response']) || !$recaptcha['success'])) {
				$this->error['message'] = $this->language->get('error_q_recaptcha');
			}
		} else {
			if ((int)$this->config->get('qa_form_display_captcha') && (int)$this->config->get('qa_form_require_captcha') && (!isset($this->session->data['captcha']) || !isset($data['q_captcha']) || ($this->session->data['captcha'] != $data['q_captcha']))) {
				$this->error['message'] = $this->language->get('error_q_captcha');
			}
		}*/

		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}
	
	
	public function write() {
		
		$this->load->language('product/product');

		$json = array();

		if ($this->request->server['REQUEST_METHOD'] == 'POST') {
			
			if ((utf8_strlen($this->request->post['text']) < 25) || (utf8_strlen($this->request->post['text']) > 1000)) {
				$json['error'] = $this->language->get('error_text');
			}

			if (empty($this->request->post['rating']) || $this->request->post['rating'] < 0 || $this->request->post['rating'] > 5) {
				$json['error'] = $this->language->get('error_rating');
			}

			if (empty($this->request->post['email']) || !preg_match('/^[^\@]+@.*.[a-z]{2,15}$/i', $this->request->post['email'])) {
				
				$json['error'] = $this->language->get('error_email');
			}
			unset($this->session->data['captcha']);

			if (!isset($json['error'])) {
				$this->load->model('catalog/review');

				$this->model_catalog_review->addReview($this->request->get['product_id'], $this->request->post);

				$json['success'] = $this->language->get('text_success');
			}
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
	public function custom_size(){
		$json = array();
		
		if (isset($this->request->post['option_id'])) {
			$option_id = $this->request->post['option_id'];
		} else {
			$option_id = '';
		}
		if (isset($this->request->post['option_value_id'])) {
			$option_value_id = $this->request->post['option_value_id'];
		} else {
			$option_value_id = '';
		}
		$this->load->model('catalog/product');
		
		if($option_value_id=='custom')
		{
			
            $option_descriptions = $this->model_catalog_product->getdescription($option_id);	
		
		    if($option_descriptions)
		    {
			      $img = '';
		          $json['success'] = 'yes';
		          foreach($option_descriptions as $option_description)
		          {
				  if($option_description['image']=='no_image.png') {
				    $img = 'sizeoption.jpg';
				  }else{
				    $img = $option_description['image'];
				  }
		          $json['option_value_id'] = 'custom';
		          $json['value_name'] = 'Free';
		          $json['bust'] = '';
		          $json['waist'] = '';
		          $json['hip'] = '';
		          $json['hollow'] = '';
		          $json['height'] = '';
		          $json['option_id']     =  $option_description['option_id'];
				  $json['product_option_id'] = $option_id;
		          $json['name']         =  $option_description['name'];
		          $json['image']        =  $img;
		          $json['description']   =  $option_description['description'];
		          $json['remarks']     = $option_description['remarks'];
		          }
			
		    }else{
			
		          $json['error'] = 'yes';
			
		    }
			
		}else{
		

		          $option_descriptions = $this->model_catalog_product->getOptiondescription($option_id,$option_value_id);	
		          if($option_descriptions)
		          {
				  $img ='';
		          $json['success'] = 'yes';
		          foreach($option_descriptions as $option_description)
		          {
				  if($option_description['image']=='no_image.png') {
				    $img = 'sizeoption.jpg';
				  }else{
				    $img = $option_description['image'];
				  }
		          foreach($option_description['product_option_value'] as $option_description_value)
		          {
		          $json['option_value_id'] = $option_description_value['option_value_id'];
		          $json['value_name'] = $option_description_value['name'];
		          $json['bust'] = $option_description_value['bust'];
		          $json['waist'] = $option_description_value['waist'];
		          $json['hip'] = $option_description_value['hip'];
		          $json['hollow'] = $option_description_value['hollow'];
		          $json['height'] = $option_description_value['height'];
		          }
		          $json['option_id']     =  $option_description['option_id'];
				  $json['product_option_id'] = $option_id;
		          $json['name']         =  $option_description['name'];
		          $json['image']        =  $img;
		          $json['description']   =  $option_description['description'];
		          $json['remarks']     = $option_description['remarks'];
		          }
			
		          } else{
			
		          $json['error'] = 'yes';
			
		          }
		
		}
		
		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));		
	}	

    public function check_size(){
		$json = array();
		
		if (isset($this->request->post['option_value_id'])) {
			$option_value_id = $this->request->post['option_value_id'];
		} else {
			$option_value_id = '';
		}
		if (isset($this->request->post['bust'])  && !empty($this->request->post['bust'])) {
			$bust = $this->request->post['bust'];
			$json['error_bust'] = false;
		} else {
			$bust = '';
			$json['error_bust'] = 'Bust';
		}
		if (isset($this->request->post['waist']) && !empty($this->request->post['waist'])) {
			$waist = $this->request->post['waist'];
			$json['error_waist'] = false;
		} else {
			$waist = '';
			$json['error_waist'] = 'waist';
		}
		if (isset($this->request->post['hip']) && !empty($this->request->post['hip'])) {
			$hip = $this->request->post['hip'];
			$json['error_hip'] = false;
		} else {
			$hip = '';
			$json['error_hip'] = 'hip';
		}
		if (isset($this->request->post['hollow']) && !empty($this->request->post['hollow'])) {
			$hollow = $this->request->post['hollow'];
			$json['error_hollow'] = false;
		} else {
			$hollow = '';
			$json['error_hollow'] = 'hollow';
		}
		if (isset($this->request->post['height'])) {
			$height = $this->request->post['height'];
		} else {
			$height = '';
		}
        if(!$json['error_bust'] && !$json['error_waist'] && !$json['error_hip'] && !$json['error_hollow']) {
		$this->load->model('catalog/product');
		$custom_values = $this->model_catalog_product->getcustom_values($option_value_id);
		if($custom_values)
		{
			foreach($custom_values as $custom_value)
			{
				$coption_value_id = $custom_value['option_value_id'];
				$cvaluetype = $this->model_catalog_product->getoptionvaluetype($custom_value['option_value_id']);
				$cname = $custom_value['name'];
				$cbust = $custom_value['bust'];
				$cwaist = $custom_value['waist'];
				$chip = $custom_value['hip'];
				$chollow = $custom_value['hollow'];
				$cheight = $custom_value['height'];
				
			}

			if($cbust==$bust && $cwaist==$waist && $chip==$hip && $chollow==$hollow && $cheight==$height)
				{
					if($cvaluetype=='Free_Customize') { $cname='Free_Customize'; } else {$cname='size'.$coption_value_id; }
					$json['success'] = $cname;
					$json['custom']  = false;
					$json['size']    = $cname;
					$json['bust']    = $cbust;
					$json['waist']   = $cwaist;
					$json['hip']     = $chip;
					$json['hollow']  = $chollow;
					$json['height']  = $cheight;
				
				}else{
					
					$json['success'] = $cname;
					$json['custom']  = true;
					$json['size']    = 'Free_Customize';
					$json['bust']    = $cbust;
					$json['waist']   = $cwaist;
					$json['hip']     = $chip;
					$json['hollow']  = $chollow;
					$json['height']  = $cheight;
					
				}
		}
	}
		
		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));		
	}
}
