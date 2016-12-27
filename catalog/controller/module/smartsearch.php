<?php
//==============================================================================
// Smart Search v201.2
// 
// Author: Clear Thinking, LLC
// E-mail: johnathan@getclearthinking.com
// Website: http://www.getclearthinking.com
// 
// All code within this file is copyright Clear Thinking, LLC.
// You may not copy or reuse code within this file without written permission.
//==============================================================================

class ControllerModuleSmartsearch extends Controller {
	private $type = 'module';
	private $name = 'smartsearch';
	
	public function smartsearch() {
		$settings = $this->getSettings();
		$data = $this->language->load('product/search');
		
		$filter_data = array(
			'filter_name'			=> $this->request->get['search'],
			'filter_tag'			=> $this->request->get['search'],
			'filter_description'	=> '',
			'filter_category_id'	=> 0,
			'filter_sub_category'	=> '',
			'sort'					=> 'p.sort_order',
			'order'					=> 'ASC',
			'start'					=> 0,
			'limit'					=> $settings['live_limit'],
			'ajax'					=> true
		);
		
		$this->load->model('catalog/smartsearch');
		$smartsearch_results = $this->model_catalog_smartsearch->smartsearch($filter_data);
		$results = $this->model_catalog_smartsearch->getProducts($smartsearch_results, $filter_data);
		
		$this->load->model('catalog/product');
		$this->load->model('catalog/review');
		$this->load->model('tool/image');
		
		$products = array();
		
		foreach ($results as $result) {
			if (empty($result)) continue;
			
			$image = ($settings['live_image_width']) ? $this->model_tool_image->resize(($result['image']) ? $result['image'] : 'no_image.jpg', (int)$settings['live_image_width'], (int)$settings['live_image_height']) : false;
			$options = $this->model_catalog_product->getProductOptions($result['product_id']);
			$rating = ($this->config->get('config_review_status')) ? (int)$result['rating'] : false;
			
			$result['add']			= $this->url->link(($options ? 'product/product' : 'checkout/cart'), 'product_id=' . $result['product_id']);
			$result['description']	= implode('', array_slice(preg_split("//u", strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), -1, PREG_SPLIT_NO_EMPTY), 0, (int)$settings['live_description'])) . '...';
			$result['href']			= $this->url->link('product/product', 'product_id=' . $result['product_id']);
			$result['image']		= $image;
			$result['options']		= $options;
			$result['price']		= (!$this->config->get('config_customer_price') || $this->customer->isLogged()) ? $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax'))) : false;
			$result['rating']		= $rating;
			$result['reviews']		= sprintf($data['text_reviews'], (int)$result['reviews']);
			$result['special']		= ((float)$result['special']) ? $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax'))) : false;
			$result['tax']			= ($this->config->get('config_tax')) ? $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']) : false;
			$result['thumb']		= $image;
			
			$products[] = $result;
		}
		
		$this->response->setOutput(json_encode($products));
	}
	
	private function getSettings() {
		$settings = array();
		$settings_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "setting WHERE `" . (version_compare(VERSION, '2.0.1') < 0 ? 'group' : 'code') . "` = '" . $this->db->escape($this->name) . "' ORDER BY `key` ASC");
		
		foreach ($settings_query->rows as $setting) {
			$value = (is_string($setting['value']) && strpos($setting['value'], 'a:') === 0) ? unserialize($setting['value']) : $setting['value'];
			$split_key = preg_split('/_(\d+)_?/', str_replace($this->name . '_', '', $setting['key']), -1, PREG_SPLIT_DELIM_CAPTURE | PREG_SPLIT_NO_EMPTY);
			
			if (count($split_key) == 1) {
				$settings[$split_key[0]] = $value;
			} elseif (count($split_key) == 2) {
				$settings[$split_key[0]][$split_key[1]] = $value;
			} elseif (count($split_key) == 3) {
				$settings[$split_key[0]][$split_key[1]][$split_key[2]] = $value;
			} elseif (count($split_key) == 4) {
				$settings[$split_key[0]][$split_key[1]][$split_key[2]][$split_key[3]] = $value;
			} else {
				$settings[$split_key[0]][$split_key[1]][$split_key[2]][$split_key[3]][$split_key[4]] = $value;
			}
		}
		
		return $settings;
	}
}
?>