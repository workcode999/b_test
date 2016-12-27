<?php
//==============================================================================
// Filter by Price Module v230.1
// 
// Author: Clear Thinking, LLC
// E-mail: johnathan@getclearthinking.com
// Website: http://www.getclearthinking.com
// 
// All code within this file is copyright Clear Thinking, LLC.
// You may not copy or reuse code within this file without written permission.
//==============================================================================

class ControllerModuleFilterByPrice extends Controller {
	private $type = 'module';
	private $name = 'filter_by_price';
	
	public function index($settings) {
		if (empty($settings) || empty($settings['status'])) {
			return;
		}
		
		// Load general data
		$data['type'] = $this->type;
		$data['name'] = $this->name;
		$data['settings'] = $settings;
		$data['language'] = $this->session->data['language'];
		$currency = $this->session->data['currency'];
		
		$data = array_merge($data, $this->load->language('product/search'));
		$data['heading_title'] = strip_tags(html_entity_decode($settings['heading_' . $data['language']], ENT_QUOTES, 'UTF-8'));
		$data['smartsearch'] = (int)$this->config->get('smartsearch_status');
		
		$this->load->model('tool/image');
		
		// Set Clear Filters return page
		if (empty($this->request->get['module_id'])) {
			$this->session->data['clear_filters'] = $this->request->server['REQUEST_URI'];
		}
		$data['clear_filters'] = (isset($this->session->data['clear_filters'])) ? $this->session->data['clear_filters'] : '';
		
		// Create cache hash
		$data['get'] = $this->request->get;
		unset($data['get']['sort']);
		unset($data['get']['order']);
		unset($data['get']['page']);
		unset($data['get']['limit']);
		$hash = md5(http_build_query($data['get']));
		
		if (isset($data['get']['path'])) {
			$paths = explode('_', $this->request->get['path']);
			$data['get']['category_id'] = ($settings['category_filter'] == 'checkbox' || $settings['category_filter'] == 'radio') ? implode(';', $paths) : array_pop($paths);
		}
		
		if ($settings['category_subcategories']) {
			$data['get']['sub_category'] = 1;
		}
		
		$data['get']['caching'] = $settings['caching'];
		
		// Get relevant values
		$data['check_relevant_values'] = false;
		
		foreach (array('category', 'manufacturer') as $filter_type) {
			if ($settings[$filter_type . '_choices'] == 'relevant') {
				$data['check_relevant_values'] = true;
			}
			$data['get'][$filter_type . '_choices'] = $settings[$filter_type . '_choices'];
		}
		
		$this->load->model('catalog/filter');
		$relevant_values = ($data['check_relevant_values']) ? $this->model_catalog_filter->getRelevantValues($data['get']) : array();
		
		$get = array_merge(array('return_total' => true), $data['get']);
		
		// Get filter sort order
		$data['filter_sorting'] = array();
		
		foreach (array('category', 'manufacturer', 'price') as $filter_type) {
			if ($settings[$filter_type . '_filter'] && $settings[$filter_type . '_filter'] != 'hide') {
				$data['filter_sorting'][$settings[$filter_type . '_sort_order'] . '.' . $filter_type] = $filter_type;
			}
		}
		ksort($data['filter_sorting']);
		
		// Check cache	
		$cached_data = $this->cache->get('filter.choices.' . $hash);
		
		if (!$cached_data || !$settings['caching']) {
			$cached_data = array();
			
			// Load categories
			if ($settings['category_filter'] != 'hide') {
				$this->load->model('catalog/category');
				$cached_data['categories'] = array();
				$non_relevants = array();
				$non_links = array();
				
				// note: at some point, rewrite this to use a recursive function
				foreach ($this->model_catalog_category->getCategories(0) as $category_1) {
					if (isset($relevant_values['category'])) {
						if (empty($relevant_values['category']) || !in_array($category_1['category_id'], $relevant_values['category'])) {
							$non_relevants[$category_1['category_id']] = $category_1['category_id'];
						}
					}
					if ($settings['category_filter'] == 'links') {
						if (!empty($data['get']['category_id']) && !in_array($category_1['category_id'], explode(';', $data['get']['category_id']))) {
							$non_links[$category_1['category_id']] = $category_1['category_id'];
						}
					}
					if (!empty($category_1['image']) && $settings['category_images'] && $settings['category_filter'] != 'select') {
						$category_1['name'] = '<img src="' . $this->model_tool_image->resize($category_1['image'], $settings['category_images'], $settings['category_images']) . '" width="' . $settings['category_images'] . '" height="' . $settings['category_images'] . '" /> ' . $category_1['name'];
					}
					$cached_data['categories'][] = array(
						'category_id'	=> $category_1['category_id'],
						'name'			=> $category_1['name'],
					);
					foreach ($this->model_catalog_category->getCategories($category_1['category_id']) as $category_2) {
						if (isset($relevant_values['category'])) {
							if (empty($relevant_values['category']) || !in_array($category_2['category_id'], $relevant_values['category'])) {
								$non_relevants[$category_2['category_id']] = $category_2['category_id'];
							} else {
								unset($non_relevants[$category_1['category_id']]);
							}
						}
						if ($settings['category_filter'] == 'links') {
							if (empty($data['get']['category_id']) || ($data['get']['category_id'] != $category_1['category_id'] && !in_array($category_2['category_id'], explode(';', $data['get']['category_id'])))) {
								$non_links[$category_2['category_id']] = $category_2['category_id'];
							} else {
								unset($non_links[$category_1['category_id']]);
							}
						}
						if (!empty($category_2['image']) && $settings['category_images'] && $settings['category_filter'] != 'select') {
							$category_2['name'] = '<img src="' . $this->model_tool_image->resize($category_2['image'], $settings['category_images'], $settings['category_images']) . '" width="' . $settings['category_images'] . '" height="' . $settings['category_images'] . '" /> ' . $category_2['name'];
						}
						$cached_data['categories'][] = array(
							'category_id'	=> $category_2['category_id'],
							'name'			=> ' &nbsp; &nbsp; ' . $category_2['name'],
						);
						foreach ($this->model_catalog_category->getCategories($category_2['category_id']) as $category_3) {
							if (isset($relevant_values['category'])) {
								if (empty($relevant_values['category']) || !in_array($category_3['category_id'], $relevant_values['category'])) {
									$non_relevants[$category_3['category_id']] = $category_3['category_id'];
								} else {
									unset($non_relevants[$category_1['category_id']]);
									unset($non_relevants[$category_2['category_id']]);
								}
							}
							if ($settings['category_filter'] == 'links') {
								if (empty($data['get']['category_id']) || ($data['get']['category_id'] != $category_2['category_id'] && !in_array($category_3['category_id'], explode(';', $data['get']['category_id'])))) {
									$non_links[$category_3['category_id']] = $category_3['category_id'];
								} else {
									unset($non_links[$category_1['category_id']]);
									unset($non_links[$category_2['category_id']]);
								}
							}
							if (!empty($category_3['image']) && $settings['category_images'] && $settings['category_filter'] != 'select') {
								$category_3['name'] = '<img src="' . $this->model_tool_image->resize($category_3['image'], $settings['category_images'], $settings['category_images']) . '" width="' . $settings['category_images'] . '" height="' . $settings['category_images'] . '" /> ' . $category_3['name'];
							}
							$cached_data['categories'][] = array(
								'category_id'	=> $category_3['category_id'],
								'name'			=> ' &nbsp; &nbsp; &nbsp; &nbsp; ' . $category_3['name'],
							);
							foreach ($this->model_catalog_category->getCategories($category_3['category_id']) as $category_4) {
								if (isset($relevant_values['category'])) {
									if (empty($relevant_values['category']) || !in_array($category_4['category_id'], $relevant_values['category'])) {
										$non_relevants[$category_4['category_id']] = $category_4['category_id'];
									} else {
										unset($non_relevants[$category_1['category_id']]);
										unset($non_relevants[$category_2['category_id']]);
										unset($non_relevants[$category_3['category_id']]);
									}
								}
								if ($settings['category_filter'] == 'links') {
									if (empty($data['get']['category_id']) || ($data['get']['category_id'] != $category_3['category_id'] && !in_array($category_4['category_id'], explode(';', $data['get']['category_id'])))) {
										$non_links[$category_4['category_id']] = $category_4['category_id'];
									} else {
										unset($non_links[$category_1['category_id']]);
										unset($non_links[$category_2['category_id']]);
										unset($non_links[$category_3['category_id']]);
									}
								}
								if (!empty($category_4['image']) && $settings['category_images'] && $settings['category_filter'] != 'select') {
									$category_4['name'] = '<img src="' . $this->model_tool_image->resize($category_4['image'], $settings['category_images'], $settings['category_images']) . '" width="' . $settings['category_images'] . '" height="' . $settings['category_images'] . '" /> ' . $category_4['name'];
								}
								$cached_data['categories'][] = array(
									'category_id'	=> $category_4['category_id'],
									'name'			=> ' &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ' . $category_4['name'],
								);
								foreach ($this->model_catalog_category->getCategories($category_4['category_id']) as $category_5) {
									if (isset($relevant_values['category'])) {
										if (empty($relevant_values['category']) || !in_array($category_5['category_id'], $relevant_values['category'])) {
											$non_relevants[$category_5['category_id']] = $category_5['category_id'];
										} else {
											unset($non_relevants[$category_1['category_id']]);
											unset($non_relevants[$category_2['category_id']]);
											unset($non_relevants[$category_3['category_id']]);
											unset($non_relevants[$category_4['category_id']]);
										}
									}
									if ($settings['category_filter'] == 'links') {
										if (empty($data['get']['category_id']) || ($data['get']['category_id'] != $category_4['category_id'] && !in_array($category_5['category_id'], explode(';', $data['get']['category_id'])))) {
											$non_links[$category_5['category_id']] = $category_5['category_id'];
										} else {
											unset($non_links[$category_1['category_id']]);
											unset($non_links[$category_2['category_id']]);
											unset($non_links[$category_3['category_id']]);
											unset($non_links[$category_4['category_id']]);
										}
									}
									if (!empty($category_5['image']) && $settings['category_images'] && $settings['category_filter'] != 'select') {
										$category_5['name'] = '<img src="' . $this->model_tool_image->resize($category_5['image'], $settings['category_images'], $settings['category_images']) . '" width="' . $settings['category_images'] . '" height="' . $settings['category_images'] . '" /> ' . $category_5['name'];
									}
									$cached_data['categories'][] = array(
										'category_id'	=> $category_5['category_id'],
										'name'			=> ' &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ' . $category_5['name'],
									);
								}
							}
						}
					}
				}
				
				foreach ($cached_data['categories'] as $key => $value) {
					if (in_array($value['category_id'], $non_relevants) || in_array($value['category_id'], $non_links) || !in_array($value['category_id'], $settings['categories'])) {
						unset($cached_data['categories'][$key]);
					} elseif (!empty($settings['category_count'])) {
						$temp_get = array_merge($get, array('category_id' => $value['category_id']));
						$product_count = $this->model_catalog_filter->getProducts($temp_get);
						$cached_data['categories'][$key]['name'] .= ' (' . $product_count . ')';
					}
				}
			}
			
			// Load manufacturers
			if ($settings['manufacturer_filter'] != 'hide') {
				$this->load->model('catalog/manufacturer');
				$cached_data['manufacturers'] = array();
				
				foreach ($this->model_catalog_manufacturer->getManufacturers() as $manufacturer) {
					if (isset($relevant_values['manufacturer'])) {
						if (empty($relevant_values['manufacturer']) || !in_array($manufacturer['manufacturer_id'], $relevant_values['manufacturer'])) {
							continue;
						}
					}
					if (!empty($manufacturer['image']) && $settings['manufacturer_images'] && $settings['manufacturer_filter'] != 'select') {
						$manufacturer['name'] = '<img src="' . $this->model_tool_image->resize($manufacturer['image'], $settings['manufacturer_images'], $settings['manufacturer_images']) . '" width="' . $settings['manufacturer_images'] . '" height="' . $settings['manufacturer_images'] . '" /> ' . $manufacturer['name'];
					}
					if (!empty($settings['manufacturer_count'])) {
						$temp_get = array_merge($get, array('manufacturer_id' => $manufacturer['manufacturer_id']));
						$product_count = $this->model_catalog_filter->getProducts($temp_get);
						$manufacturer['name'] .= ' (' . $product_count . ')';
					}
					$cached_data['manufacturers'][] = array(
						'manufacturer_id'	=> $manufacturer['manufacturer_id'],
						'name'				=> $manufacturer['name'],
					);
				}
			}
			
			// Load price ranges
			if ($settings['price_filter'] != 'hide') {
				$cached_data['price_ranges'] = array();
				$price_points = explode(',', preg_replace('/\s+/', '', $settings['price_range_' . $currency]));
				
				if ($price_points[0] != '') {
					$i = 0;
					foreach ($price_points as $price) {
						$text = $this->currency->format($price, $currency, 1, true);
						if ($i == 0) {
							$cached_data['price_ranges']['0-' . $price] = str_replace('[price]', $text, $settings['price_bottom_text_' . $data['language']]);
						} elseif ($i < count($price_points)) {
							$cached_data['price_ranges'][$last_price . '-' . $price] = str_replace(array('[from]', '[to]'), array($last_text, $text), $settings['price_middle_text_' . $data['language']]);
						}
						$last_price = $price;
						$last_text = $text;
						$i++;
					}
					$cached_data['price_ranges'][$last_price . '-'] = str_replace('[price]', $last_text, $settings['price_top_text_' . $data['language']]);
				}
				
				if (!empty($settings['price_count'])) {
					foreach ($cached_data['price_ranges'] as $price_range => &$price_text) {
						$temp_get = $get;
						$temp_get['price'] = $price_range;
						$product_count = $this->model_catalog_filter->getProducts($temp_get);
						$price_text .= ' (' . $product_count . ')';
					}
				}
				
				$cached_data['lower'] = '';
				$cached_data['upper'] = '';
				if (!empty($this->request->get['price'])) {
					$price_ranges = explode(';', $this->request->get['price']);
					$last_price_range = array_pop($price_ranges);
					$price_range = explode('-', $last_price_range);
					
					$lower = $price_range[0];
					$upper = (isset($price_range[1])) ? $price_range[1] : '';
					
					if (!in_array($lower . '-' . $upper, array_keys($cached_data['price_ranges']))) {
						$cached_data['lower'] = $lower;
						$cached_data['upper'] = $upper;
					}
				}
				
				$cached_data['left_symbol'] = $this->currency->getSymbolLeft($currency);
				$cached_data['right_symbol'] = $this->currency->getSymbolRight($currency);
			}
			
			$this->cache->set('filter.choices.' . $hash, $cached_data);
		}
		
		// Merge cached data
		$data = array_merge($data, $cached_data);
		
		// Load page type
		if (isset($this->request->get['route'])) {
			$route = explode('/', $this->request->get['route']);
			if (isset($this->request->get['list'])) {
				$data['list'] = $this->request->get['list'];
			} elseif ($route[1] == 'list' && $route[2] != 'all') {
				$data['list'] = $route[2];
			} elseif ($route[1] == 'special') {
				$data['list'] = 'special';
			}
		}
		
		// Render
		$theme = (version_compare(VERSION, '2.2', '<')) ? $this->config->get('config_template') : $this->config->get('config_theme');
		$template = (file_exists(DIR_TEMPLATE . $theme . '/template/' . $this->type . '/' . $this->name . '.tpl')) ? $theme : 'default';
		$template_file = (version_compare(VERSION, '2.2', '<')) ? $template . '/template/' . $this->type . '/' . $this->name . '.tpl' : $this->type . '/' . $this->name;
		
		$data['template'] = $template;
		
		if (version_compare(VERSION, '2.0', '<')) {
			$this->data = $data;
			$this->template = $template_file;
			$this->render();
		} else {
			return $this->load->view($template_file, $data);
		}
	}
}
?>