<?php
//==============================================================================
// Filter Controller v2016-7-08
// 
// Author: Clear Thinking, LLC
// E-mail: johnathan@getclearthinking.com
// Website: http://www.getclearthinking.com
// 
// All code within this file is copyright Clear Thinking, LLC.
// You may not copy or reuse code within this file without written permission.
//==============================================================================

class ControllerProductFilter extends Controller { 	
	private $type = 'product';
	private $name = 'filter';
	private $copy = 'special';
	
	public function index() {
		$get = $this->request->get;
		$data = $this->load->language($this->type . '/search');
		
		// Set variables
		$currency = $this->session->data['currency'];
		$language = (isset($this->session->data['language'])) ? $this->session->data['language'] : $this->config->get('config_language');
		$theme = (version_compare(VERSION, '2.2', '<')) ? $this->config->get('config_template') : $this->config->get('config_theme');
		$image_width = (version_compare(VERSION, '2.2', '<')) ? $this->config->get('config_image_product_width') : $this->config->get($theme . '_image_product_width');
		$image_height = (version_compare(VERSION, '2.2', '<')) ? $this->config->get('config_image_product_height') : $this->config->get($theme . '_image_product_height');
		$placeholder = (version_compare(VERSION, '2.0', '<')) ? 'no_image.jpg' : 'placeholder.png';
		
		if (version_compare(VERSION, '2.0', '<')) {
			$description_limit = 100;
			$pagination_limit = $this->config->get('config_catalog_limit');
		} elseif (version_compare(VERSION, '2.2', '<')) {
			$description_limit = $this->config->get('config_product_description_length');
			$pagination_limit = $this->config->get('config_product_limit');
		} else {
			$description_limit = $this->config->get($theme . '_product_description_length');
			$pagination_limit = $this->config->get($theme . '_product_limit');
		}
		
		// Get module settings
		if (!empty($get['module_id'])) {
			if (version_compare(VERSION, '2.0.1', '<')) {
				if ($this->config->get('ultimate_filters_module')) {
					$settings = $this->config->get('ultimate_filters_module');
				} elseif ($this->config->get('filter_by_attribute_module')) {
					$settings = $this->config->get('filter_by_attribute_module');
				} else {
					$settings = $this->config->get('filter_by_price_module');
				}
				$settings = $settings[$get['module_id']];
			} else {
				$this->load->model('extension/module');
				$settings = $this->model_extension_module->getModule($get['module_id']);
			}
			
			$data['heading_title'] = $settings['heading_' . $language];
			
			/*
			if (isset($get['category_id'])) {
				$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "category_description WHERE category_id = " . (int)$get['category_id']);
			} elseif (isset($get['manufacturer_id'])) {
				$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "manufacturer WHERE manufacturer_id = " . (int)$get['manufacturer_id']);
			}
			if (isset($query) && $query->num_rows) {
				$data['heading_title'] = $query->row['name'];
			}
			*/
			
			if ($settings['default_sorting']) {
				$sorting = explode('_', $settings['default_sorting']);
				$get['sort'] = $sorting[0];
				$get['order'] = (isset($sorting[1])) ? $sorting[1] : 'desc';
			}
			if ($settings['category_subcategories']) {
				$get['sub_category'] = 1;
			}
			$get['caching'] = $settings['caching'];
			
			foreach (array('attribute', 'category', 'filter', 'manufacturer', 'option') as $filter_type) {
				if (isset($settings[$filter_type . '_choices'])) {
					$get[$filter_type . '_choices'] = $settings[$filter_type . '_choices'];
				}
			}
		}
		
		// Determine sorting if not set
		if (empty($get['sort'])) {
			if (isset($get['price'])) {
				$get['sort'] = 'price';
				$get['order'] = 'asc';
			} elseif (isset($get['rating'])) {
				$get['sort'] = 'rating';
				$get['order'] = 'desc';
			} else {
				$get['sort'] = '';
				$get['order'] = '';
			}
		}
		if (empty($get['limit'])) {
			$get['limit'] = $pagination_limit;
		}
		if (empty($get['page'])) {
			$get['page'] = 1;
		}
		
		// Build URL
		$url = array();
		foreach (array('sort', 'order', 'limit', 'page') as $filter) {
			if (empty($this->request->get[$filter])) {
				$url[$filter] = '';
				if ($filter == 'sort') $data[$filter] = '';
				if ($filter == 'order') $data[$filter] = '';
				if ($filter == 'limit') $data[$filter] = $pagination_limit;
				if ($filter == 'page') $data[$filter] = 1;
			} else {
				$data[$filter] = $this->request->get[$filter];
				$url[$filter] = '&' . $filter . '=' . $data[$filter];
			}
			unset($this->request->get[$filter]);
		}
		$url['url'] = str_replace('route=' . $this->type . '/' . $this->name, '', urldecode(http_build_query($this->request->get)));
		
		// Set breadcrumbs
		$data['breadcrumbs'] = array();
		$data['breadcrumbs'][] = array(
			'href'		=> $this->url->link('common/home'),
			'text'		=> $data['text_home'],
			'separator' => false,
		);
		$data['breadcrumbs'][] = array(
			'href'		=> $this->url->link($this->type . '/' . $this->name, $url['url'] . $url['sort'] . $url['order'] . $url['limit'] . $url['page']),
			'text'			=> $data['heading_title'],
			'separator' => (!empty($data['text_separator'])) ? $data['text_separator'] : false,
		);
		
		// Get products
		$this->load->model('catalog/filter');
		$results = $this->model_catalog_filter->getProducts($get);
		
		$get['return_total'] = true;
		$product_total = $this->model_catalog_filter->getProducts($get);
		
		// Set product data
		if (!$product_total) {
			$data['text_error'] = $data['text_empty'];
			$data['continue'] = $this->url->link('common/home');
			
			$template = (file_exists(DIR_TEMPLATE . $theme . '/template/error/not_found.tpl')) ? $theme : 'default';
			$template_file = (version_compare(VERSION, '2.2', '<')) ? $template . '/template/error/not_found.tpl' : 'error/not_found';
		} else {
			$this->load->model('tool/image');
			$this->load->model('catalog/product');
		
			$data['products'] = array();
			foreach ($results as $result) {
				$options = $this->model_catalog_product->getProductOptions($result['product_id']);
				
				$product = $result;
				$product['add']			= $this->url->link($options ? 'product/product' : 'checkout/cart', 'product_id=' . $result['product_id']);
				$product['description']	= substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $description_limit) . '...';
				$product['href']		= $this->url->link('product/product', 'product_id=' . $result['product_id']);
				$product['options']		= $options;
				$product['price']		= (!$this->config->get('config_customer_price') || $this->customer->isLogged()) ? $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')), $currency) : false;
				$product['rating']		= ($this->config->get('config_review_status')) ? (int)$result['rating'] : false;
				$product['reviews']		= (version_compare(VERSION, '2.0', '<')) ? sprintf($data['text_reviews'], (int)$result['reviews']) : '';
				$product['special']		= ((float)$result['special']) ? $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')), $currency) : false;
				$product['tax']			= ($this->config->get('config_tax')) ? $this->currency->format((float)$result['special'] ? $result['special'] : $result['price'], $currency) : false;
				$product['thumb']		= $this->model_tool_image->resize($result['image'] ? $result['image'] : $placeholder, $image_width, $image_height);
				
				$data['products'][] = $product;
			}
			
			// Create sorts
			$data['sorts'] = array();
			$data['sorts'][] = array(
				'text'	=> $data['text_default'],
				'value' => '',
				'href'	=> $this->url->link($this->type . '/' . $this->name, $url['url'] . $url['limit']),
			);
			
			$sort_array = array(
				'name',
				'price',
				'rating',
				'model',
			);
			$order_array = array(
				'asc',
				'desc',
			);
			
			foreach ($sort_array as $sort) {
				if ($sort == 'rating' && !$this->config->get('config_review_status')) continue;
				foreach ($order_array as $order) {
					$data['sorts'][] = array(
						'text'	=> $data['text_' . $sort . '_' . $order],
						'value' => $sort . '-' . $order,
						'href'	=> $this->url->link($this->type . '/' . $this->name, $url['url'] . '&sort=' . $sort . '&order=' . $order . $url['limit'])
					);
				}
			}
			
			// Create limits
			$limit_array = array(
				$pagination_limit,
				$pagination_limit * 2,
				$pagination_limit * 3,
				$pagination_limit * 4,
				$pagination_limit * 5,
			);
			
			foreach ($limit_array as $limit) {
				$data['limits'][] = array(
					'text'	=> $limit,
					'value' => $limit,
					'href'	=> $this->url->link($this->type . '/' . $this->name, $url['url'] . $url['sort'] . $url['order'] . '&limit=' . $limit),
				);
			}
			
			// Create pagination
			$pagination = new Pagination();
			$pagination->total = $product_total;
			$pagination->page = $data['page'];
			$pagination->limit = $data['limit'];
			$pagination->text = $data['text_pagination'];
			$pagination->url = $this->url->link($this->type . '/' . $this->name, $url['url'] . $url['sort'] . $url['order'] . $url['limit'] . '&page={page}');
			
			$data['pagination'] = $pagination->render();
			$data['results'] = sprintf($data['text_pagination'], ($product_total) ? (($data['page'] - 1) * $data['limit']) + 1 : 0, ((($data['page'] - 1) * $data['limit']) > ($product_total - $data['limit'])) ? $product_total : ((($data['page'] - 1) * $data['limit']) + $data['limit']), $product_total, ceil($product_total / $data['limit']));
			
			// Set other data
			$data['display_price'] = (!$this->config->get('config_customer_price') || $this->customer->isLogged());
			$data['text_compare'] = sprintf($data['text_compare'], (isset($this->session->data['compare']) ? count($this->session->data['compare']) : 0));
			$data['compare'] = $this->url->link('product/compare');
			
			$template = (file_exists(DIR_TEMPLATE . $theme . '/template/' . $this->type . '/' . $this->copy . '.tpl')) ? $theme : 'default';
			$template_file = (version_compare(VERSION, '2.2', '<')) ? $template . '/template/' . $this->type . '/' . $this->copy . '.tpl' : $this->type . '/' . $this->copy;
		}
		
		// Render
		$this->document->setTitle($data['heading_title']);
		$data['heading_title'] .= "<script>$('body').removeClass('product-filter')</script>";
		
		if (version_compare(VERSION, '2.0', '<')) {
			if (version_compare(VERSION, '1.5.5') >= 0) {
				$this->document->addScript('catalog/view/javascript/jquery/jquery.total-storage.min.js');
			}
			$this->children = array(
				'common/column_left',
				'common/column_right',
				'common/content_top',
				'common/content_bottom',
				'common/footer',
				'common/header',
			);
			$this->data = $data;
			$this->template = $template_file;
			$this->response->setOutput($this->render());
		} else {
			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');
			$this->response->setOutput($this->load->view($template_file, $data));
		}
	}
}
?>
