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
	
	public function index() {
		$data = array(
			'type'				=> $this->type,
			'name'				=> $this->name,
			'autobackup'		=> false,
			'vqmod'				=> false,
			'save_type'			=> 'keepediting',
			'token'				=> $this->session->data['token'],
			'permission'		=> $this->user->hasPermission('modify', $this->type . '/' . $this->name),
			'exit'				=> $this->url->link('extension/' . $this->type . '&token=' . $this->session->data['token'], '', 'SSL'),
		);
		
		$this->loadSettings($data);
		
		// extension-specific
		$this->cache->delete('filter');
		
		//------------------------------------------------------------------------------
		// Modules
		//------------------------------------------------------------------------------
		$modules = array();
		$module_info = array();
		$module_id = 0;
		
		if (version_compare(VERSION, '2.0.1', '<')) {
			if (!empty($data['saved']['module'])) {
				if (!empty($this->request->get['module_id'])) {
					$module_info = $data['saved']['module'][$this->request->get['module_id']];
				} elseif (!isset($this->request->get['module_id'])) {
					foreach ($data['saved']['module'] as $module_id => $module) {
						$modules[$module_id] = $module['name'];
					}
				}
			}
		} else {
			$this->load->model('extension/module');
			if (isset($this->request->get['module_id'])) {
				$module_info = $this->model_extension_module->getModule($this->request->get['module_id']);
				$module_info['module_id'] = $this->request->get['module_id'];
			} else {
				foreach ($this->model_extension_module->getModulesByCode($this->name) as $module) {
					$modules[$module['module_id']] = $module['name'];
				}
			}
		}
		
		//------------------------------------------------------------------------------
		// Data Arrays
		//------------------------------------------------------------------------------
		$data['language_array'] = array($this->config->get('config_language') => '');
		$data['language_flags'] = array();
		$this->load->model('localisation/language');
		foreach ($this->model_localisation_language->getLanguages() as $language) {
			$data['language_array'][$language['code']] = $language['name'];
			$data['language_flags'][$language['code']] = (version_compare(VERSION, '2.2', '<')) ? 'view/image/flags/' . $language['image'] : 'language/' . $language['code'] . '/' . $language['code'] . '.png';
		}
		
		$data['currency_array'] = array($this->config->get('config_currency') => '');
		$this->load->model('localisation/currency');
		foreach ($this->model_localisation_currency->getCurrencies() as $currency) {
			$data['currency_array'][$currency['code']] = $currency['code'];
		}
		
		// Filters
		$data['categories'] = array();
		$this->load->model('catalog/category');
		foreach ($this->model_catalog_category->getCategories(0) as $category) {
			$data['categories'][$category['category_id']] = $category['name'];
		}
		natcasesort($data['categories']);
		
		// Layout and Positions
		$this->load->model('design/layout');
		$layouts = array();
		foreach ($this->model_design_layout->getLayouts() as $layout) {
			$layouts[$layout['layout_id']] = $layout['name'];
		}
		
		$positions = array(
			'content_top'		=> $data['text_content_top'],
			'column_left'		=> $data['text_column_left'],
			'column_right'		=> $data['text_column_right'],
			'content_bottom'	=> $data['text_content_bottom'],
		);
		
		//------------------------------------------------------------------------------
		// Extension Settings
		//------------------------------------------------------------------------------
		$data['settings'] = array();
		
		$data['settings'][] = array(
			'key'		=> 'status',
			'type'		=> 'hidden',
			'default'	=> 1,
		);
		$data['settings'][] = array(
			'key'		=> 'tooltips',
			'type'		=> 'hidden',
			'default'	=> 0,
		);
		
		if (!isset($this->request->get['module_id'])) {
			
			$data['save_type'] = 'none';
			$data['warning'] = $data['help_caching'];
			
			if (version_compare(VERSION, '2.0', '>=')) {
				$data['settings'][] = array(
					'type'		=> 'html',
					'content'	=> '<div class="text-info text-center pad-bottom">' . $data['help_module_locations'] . '  <a href="index.php?route=design/layout&token=' . $data['token'] . '">' . (version_compare(VERSION, '2.1', '<') ? ' System >' : '') . ' Design > Layouts</a></div>',
				);
			}
			$data['settings'][] = array(
				'key'		=> 'module_list',
				'type'		=> 'heading',
			);
			$data['settings'][] = array(
				'key'		=> 'module_list',
				'type'		=> 'table_start',
				'columns'	=> array('module_name', 'edit_module', 'copy_module', 'delete_module'),
			);
			foreach ($modules as $module_id => $module_name) {
				$data['settings'][] = array(
					'type'		=> 'row_start',
				);
				$data['settings'][] = array(
					'key'		=> 'module_link',
					'type'		=> 'button',
					'module_id'	=> $module_id,
					'text'		=> $module_name,
				);
				$data['settings'][] = array(
					'type'		=> 'column',
				);
				$data['settings'][] = array(
					'key'		=> 'edit_module',
					'type'		=> 'button',
					'module_id'	=> $module_id,
				);
				$data['settings'][] = array(
					'type'		=> 'column',
				);
				$data['settings'][] = array(
					'key'		=> 'copy_module',
					'type'		=> 'button',
					'module_id'	=> $module_id,
				);
				$data['settings'][] = array(
					'type'		=> 'column',
				);
				$data['settings'][] = array(
					'key'		=> 'delete_module',
					'type'		=> 'button',
					'module_id'	=> $module_id,
				);
				$data['settings'][] = array(
					'type'		=> 'row_end',
				);
			}
			$data['settings'][] = array(
				'type'		=> 'table_end',
			);
			$data['settings'][] = array(
				'type'		=> 'html',
				'content'	=> '<a class="btn btn-primary" href="index.php?route=' . $this->type . '/' . $this->name . '&module_id=0&token=' . $data['token'] . '"><i class="fa fa-plus pad-right"></i> ' . $data['button_add_module'] . '</a>',
			);
			
		} else {
			
			//------------------------------------------------------------------------------
			// Module Editing Page
			//------------------------------------------------------------------------------
			$data['exit'] = $this->url->link($this->type . '/' . $this->name . '&token=' . $this->session->data['token'], '', 'SSL');
			$data['module_id'] = $this->request->get['module_id'];
			
			$module_prefix = 'module_' . $data['module_id'] . '_';
			
			$data['settings'][] = array(
				'type'		=> 'tabs',
				'tabs'		=> array('module_settings', 'category_filter', 'manufacturer_filter', 'price_filter'),
			);
			
			$data['settings'][] = array(
				'key'		=> $module_prefix . 'module_id',
				'type'		=> 'hidden',
				'default'	=> $data['module_id'],
			);
			
			if ($data['module_id'] == 0) {
				$data['settings'][] = array(
					'key'		=> 'add_new_module',
					'type'		=> 'heading',
				);
			} else {
				$data['settings'][] = array(
					'key'		=> 'edit',
					'type'		=> 'heading',
					'text'		=> $data['heading_edit'] . ' "' . (!empty($module_info['name']) ? $module_info['name'] : '(no name)') . '"',
				);
				foreach ($module_info as $key => $value) {
					$data['saved'][$module_prefix . $key] = $value;
				}
			}
			
			//------------------------------------------------------------------------------
			// Module Settings
			//------------------------------------------------------------------------------
			$data['settings'][] = array(
				'key'		=> $module_prefix . 'status',
				'type'		=> 'select',
				'options'	=> array(1 => $data['text_enabled'], 0 => $data['text_disabled']),
				'default'	=> 1,
			);
			$data['settings'][] = array(
				'key'		=> $module_prefix . 'name',
				'type'		=> 'text',
			);
			$data['settings'][] = array(
				'key'		=> $module_prefix . 'caching',
				'type'		=> 'select',
				'options'	=> array(1 => $data['text_enabled'], 0 => $data['text_disabled']),
				'default'	=> 0,
			);
			$data['settings'][] = array(
				'key'		=> $module_prefix . 'heading',
				'type'		=> 'multilingual_text',
				'default'	=> 'Filter Products',
			);
			$data['settings'][] = array(
				'key'		=> $module_prefix . 'block_width',
				'type'		=> 'text',
				'attributes'=> array('style' => 'width: 50px !important'),
				'default'	=> '19%',
			);
			$data['settings'][] = array(
				'key'		=> $module_prefix . 'block_height',
				'type'		=> 'text',
				'attributes'=> array('style' => 'width: 50px !important'),
			);
			$data['settings'][] = array(
				'key'		=> $module_prefix . 'choice_display',
				'type'		=> 'text',
				'class'		=> 'short',
				'default'	=> 5,
			);
			$data['settings'][] = array(
				'key'		=> $module_prefix . 'automatic_filter',
				'type'		=> 'text',
				'class'		=> 'short',
			);
			$data['settings'][] = array(
				'key'		=> $module_prefix . 'page_loading',
				'type'		=> 'select',
				'options'	=> array('normal' => $data['text_normally'], 'ajax_quick' => $data['text_via_ajax_quick_method'], 'ajax_slow' => $data['text_via_ajax_slower_method']),
				'default'	=> 'normal',
			);
			
			// Location
			$data['settings'][] = array(
				'key'		=> 'location',
				'type'		=> 'heading',
			);
			if (version_compare(VERSION, '2.0', '<')) {
				$data['settings'][] = array(
					'key'		=> $module_prefix . 'layout_id',
					'type'		=> 'select',
					'options'	=> $layouts,
					'default'	=> $this->config->get('config_layout_id'),
				);
				$data['settings'][] = array(
					'key'		=> $module_prefix . 'position',
					'type'		=> 'select',
					'options'	=> $positions,
					'default'	=> 'column_left',
				);
				$data['settings'][] = array(
					'key'		=> $module_prefix . 'sort_order',
					'type'		=> 'text',
					'class'		=> 'short',
				);
			} else {
				$data['settings'][] = array(
					'type'		=> 'html',
					'title'		=> $data['entry_module_location'],
					'content'	=> '<div style="margin-top: 9px">' . $data['help_module_locations'] . ' <a href="index.php?route=design/layout&token=' . $data['token'] . '">' . (version_compare(VERSION, '2.1', '<') ? ' System >' : '') . ' Design > Layouts</a></div>',
				);
			}
			
			// Module Text
			$data['settings'][] = array(
				'key'		=> 'module_text',
				'type'		=> 'heading',
			);
			$data['settings'][] = array(
				'key'		=> $module_prefix . 'show_more_text',
				'type'		=> 'multilingual_text',
				'default'	=> 'Show More',
			);
			$data['settings'][] = array(
				'key'		=> $module_prefix . 'show_all_text',
				'type'		=> 'multilingual_text',
				'default'	=> 'Show All',
			);
			$data['settings'][] = array(
				'key'		=> $module_prefix . 'all_text',
				'type'		=> 'multilingual_text',
				'default'	=> '--- All ---',
			);
			$data['settings'][] = array(
				'key'		=> $module_prefix . 'clear_filter_text',
				'type'		=> 'multilingual_text',
				'default'	=> 'Clear',
			);
			$data['settings'][] = array(
				'key'		=> $module_prefix . 'clear_all_filters_text',
				'type'		=> 'multilingual_text',
				'default'	=> 'Clear All Filters',
			);
			$data['settings'][] = array(
				'key'		=> $module_prefix . 'filter_button',
				'type'		=> 'multilingual_text',
				'default'	=> 'Filter',
			);
			$data['settings'][] = array(
				'key'		=> $module_prefix . 'mobile_button',
				'type'		=> 'multilingual_text',
				'default'	=> 'Filter',
			);
			$data['settings'][] = array(
				'key'		=> $module_prefix . 'mobile_close',
				'type'		=> 'multilingual_text',
				'default'	=> '&amp;times;',
			);
			
			//------------------------------------------------------------------------------
			// Category Filter
			//------------------------------------------------------------------------------
			$data['settings'][] = array(
				'key'		=> 'category_filter',
				'type'		=> 'tab',
			);
			$data['settings'][] = array(
				'key'		=> 'category_filter',
				'type'		=> 'heading',
			);
			$data['settings'][] = array(
				'key'		=> $module_prefix . 'category_filter',
				'type'		=> 'select',
				'options'	=> array('hide' => $data['text_hide'], 'checkbox' => $data['text_checkboxes'], 'links' => $data['text_links'], 'radio' => $data['text_radio_buttons'], 'select' => $data['text_select_dropdown']),
				'default'	=> 'select',
			);
			$data['settings'][] = array(
				'key'		=> $module_prefix . 'category_sort_order',
				'type'		=> 'text',
				'class'		=> 'short',
				'attributes'=> array('maxlength' => 2),
			);
			$data['settings'][] = array(
				'key'		=> $module_prefix . 'category_heading',
				'type'		=> 'multilingual_text',
				'default'	=> 'Category:',
			);
			$data['settings'][] = array(
				'key'		=> $module_prefix . 'category_display',
				'type'		=> 'select',
				'options'	=> array('expanded' => $data['text_expanded'], 'collapsed' => $data['text_collapsed']),
				'default'	=> 'expanded',
			);
			$data['settings'][] = array(
				'key'		=> $module_prefix . 'category_count',
				'type'		=> 'select',
				'options'	=> array(1 => $data['text_yes'], 0 => $data['text_no']),
				'default'	=> 0,
			);
			$data['settings'][] = array(
				'key'		=> $module_prefix . 'category_choices',
				'type'		=> 'select',
				'options'	=> array('all' => $data['text_all_values'], 'relevant' => $data['text_only_relevant_values']),
				'default'	=> 'all',
			);
			$data['settings'][] = array(
				'key'		=> $module_prefix . 'category_images',
				'type'		=> 'text',
				'class'		=> 'short',
				'default'	=> 25,
			);
			$data['settings'][] = array(
				'key'		=> $module_prefix . 'category_subcategories',
				'type'		=> 'select',
				'options'	=> array(0 => $data['text_no'], 1 => $data['text_yes']),
				'default'	=> 0,
			);
			
			// Categories
			$data['settings'][] = array(
				'key'		=> 'categories',
				'type'		=> 'heading',
			);
			$data['settings'][] = array(
				'key'		=> $module_prefix . 'categories',
				'type'		=> 'checkboxes',
				'options'	=> $data['categories'],
				'default'	=> array_keys($data['categories']),
				'before'	=> '
					<a onclick="$(this).parent().find(\'input[type=checkbox]\').prop(\'checked\', \'checked\')">' . $data['text_select_all'] . '</a>
					/
					<a onclick="$(this).parent().find(\'input[type=checkbox]\').removeAttr(\'checked\')">' . $data['text_unselect_all'] . '</a>
					<br /><br />
				',
			);
			
			//------------------------------------------------------------------------------
			// Manufacturer Filter
			//------------------------------------------------------------------------------
			$data['settings'][] = array(
				'key'		=> 'manufacturer_filter',
				'type'		=> 'tab',
			);
			$data['settings'][] = array(
				'key'		=> 'manufacturer_filter',
				'type'		=> 'heading',
			);
			$data['settings'][] = array(
				'key'		=> $module_prefix . 'manufacturer_filter',
				'type'		=> 'select',
				'options'	=> array('hide' => $data['text_hide'], 'checkbox' => $data['text_checkboxes'], 'links' => $data['text_links'], 'radio' => $data['text_radio_buttons'], 'select' => $data['text_select_dropdown']),
				'default'	=> 'select',
			);
			$data['settings'][] = array(
				'key'		=> $module_prefix . 'manufacturer_sort_order',
				'type'		=> 'text',
				'class'		=> 'short',
				'attributes'=> array('maxlength' => 2),
			);
			$data['settings'][] = array(
				'key'		=> $module_prefix . 'manufacturer_heading',
				'type'		=> 'multilingual_text',
				'default'	=> 'Manufacturer:',
			);
			$data['settings'][] = array(
				'key'		=> $module_prefix . 'manufacturer_display',
				'type'		=> 'select',
				'options'	=> array('expanded' => $data['text_expanded'], 'collapsed' => $data['text_collapsed']),
				'default'	=> 'expanded',
			);
			$data['settings'][] = array(
				'key'		=> $module_prefix . 'manufacturer_count',
				'type'		=> 'select',
				'options'	=> array(1 => $data['text_yes'], 0 => $data['text_no']),
				'default'	=> 0,
			);
			$data['settings'][] = array(
				'key'		=> $module_prefix . 'manufacturer_choices',
				'type'		=> 'select',
				'options'	=> array('all' => $data['text_all_values'], 'relevant' => $data['text_only_relevant_values']),
				'default'	=> 'all',
			);
			$data['settings'][] = array(
				'key'		=> $module_prefix . 'manufacturer_images',
				'type'		=> 'text',
				'class'		=> 'short',
				'default'	=> 25,
			);
			
			//------------------------------------------------------------------------------
			// Price Filter
			//------------------------------------------------------------------------------
			$data['settings'][] = array(
				'key'		=> 'price_filter',
				'type'		=> 'tab',
			);
			$data['settings'][] = array(
				'key'		=> 'price_filter',
				'type'		=> 'heading',
			);
			$data['settings'][] = array(
				'key'		=> $module_prefix . 'price_filter',
				'type'		=> 'select',
				'options'	=> array('hide' => $data['text_hide'], 'checkbox' => $data['text_checkboxes'], 'links' => $data['text_links'], 'radio' => $data['text_radio_buttons'], 'select' => $data['text_select_dropdown']),
				'default'	=> 'checkbox',
			);
			$data['settings'][] = array(
				'key'		=> $module_prefix . 'price_sort_order',
				'type'		=> 'text',
				'class'		=> 'short',
				'attributes'=> array('maxlength' => 2),
			);
			$data['settings'][] = array(
				'key'		=> $module_prefix . 'price_heading',
				'type'		=> 'multilingual_text',
				'default'	=> 'Price Range:',
			);
			$data['settings'][] = array(
				'key'		=> $module_prefix . 'price_display',
				'type'		=> 'select',
				'options'	=> array('expanded' => $data['text_expanded'], 'collapsed' => $data['text_collapsed']),
				'default'	=> 'expanded',
			);
			$data['settings'][] = array(
				'key'		=> $module_prefix . 'price_count',
				'type'		=> 'select',
				'options'	=> array(1 => $data['text_yes'], 0 => $data['text_no']),
				'default'	=> 0,
			);
			$data['settings'][] = array(
				'key'		=> $module_prefix . 'price_flexible',
				'type'		=> 'select',
				'options'	=> array(1 => $data['text_yes'], 0 => $data['text_no']),
				'default'	=> 1,
			);
			$data['settings'][] = array(
				'key'		=> $module_prefix . 'price_bottom_text',
				'type'		=> 'multilingual_text',
				'default'	=> 'Under [price]',
			);
			$data['settings'][] = array(
				'key'		=> $module_prefix . 'price_middle_text',
				'type'		=> 'multilingual_text',
				'default'	=> '[from] to [to]',
			);
			$data['settings'][] = array(
				'key'		=> $module_prefix . 'price_top_text',
				'type'		=> 'multilingual_text',
				'default'	=> '[price] and up',
			);
			
			// Price Ranges
			$data['settings'][] = array(
				'key'		=> 'price_ranges',
				'type'		=> 'heading',
			);
			$data['settings'][] = array(
				'type'		=> 'html',
				'content'	=> '<div class="text-info text-center pad-bottom">' . $data['help_price_ranges'] . '</div>',
			);
			foreach ($data['currency_array'] as $code => $name) {
				$data['settings'][] = array(
					'key'		=> $module_prefix . 'price_range_' . $code,
					'type'		=> 'textarea',
					'title'		=> $code . ' ' . $data['entry_price_range'],
				);
			}
			
			//------------------------------------------------------------------------------
			// end module settings
			//------------------------------------------------------------------------------
			
		}
		
		//------------------------------------------------------------------------------
		// end settings
		//------------------------------------------------------------------------------
		
		$this->document->setTitle($data['heading_title']);
		
		if (version_compare(VERSION, '2.0', '<')) {
			$this->data = $data;
			$this->template = $this->type . '/' . $this->name . '.tpl';
			$this->children = array(
				'common/header',	
				'common/footer',
			);
			$this->response->setOutput($this->render());
		} else {
			$data['header'] = $this->load->controller('common/header');
			$data['column_left'] = $this->load->controller('common/column_left');
			$data['footer'] = $this->load->controller('common/footer');
			$this->response->setOutput($this->load->view($this->type . '/' . $this->name . (version_compare(VERSION, '2.2', '<') ? '.tpl' : ''), $data));
		}
	}
	
	//==============================================================================
	// Setting functions
	//==============================================================================
	private $encryption_key = '';
	private $columns = 0;
	
	private function getTableRowNumbers(&$data, $table, $sorting) {
		$groups = array();
		$rules = array();
		
		foreach ($data['saved'] as $key => $setting) {
			if (preg_match('/' . $table . '_(\d+)_' . $sorting . '/', $key, $matches)) {
				$groups[$setting][] = $matches[1];
			}
			if (preg_match('/' . $table . '_(\d+)_rule_(\d+)_type/', $key, $matches)) {
				$rules[$matches[1]][] = $matches[2];
			}
		}
		
		if (empty($groups)) $groups = array('' => array('1'));
		ksort($groups, defined('SORT_NATURAL') ? SORT_NATURAL : SORT_REGULAR);
		
		foreach ($rules as $key => $rule) {
			ksort($rules[$key], defined('SORT_NATURAL') ? SORT_NATURAL : SORT_REGULAR);
		}
		
		$rows = array();
		foreach ($groups as $group) {
			foreach ($group as $num) {
				$data['used_rows'][preg_replace('/module_(\d+)_/', '', $table)][] = $num;
				$rows[$num] = (empty($rules[$num])) ? array() : $rules[$num];
			}
		}
		sort($data['used_rows'][$table]);
		
		return $rows;
	}
	
	public function loadSettings(&$data) {
		$backup_type = (empty($data)) ? 'manual' : 'auto';
		if ($backup_type == 'manual' && !$this->user->hasPermission('modify', $this->type . '/' . $this->name)) {
			return;
		}
		
		// Load saved settings
		$data['saved'] = array();
		$settings_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "setting WHERE `" . (version_compare(VERSION, '2.0.1', '<') ? 'group' : 'code') . "` = '" . $this->db->escape($this->name) . "' ORDER BY `key` ASC");
		
		foreach ($settings_query->rows as $setting) {
			$key = str_replace($this->name . '_', '', $setting['key']);
			$value = $setting['value'];
			if ($setting['serialized']) {
				$value = (version_compare(VERSION, '2.1', '<')) ? unserialize($setting['value']) : json_decode($setting['value'], true);
			}
			
			$data['saved'][$key] = $value;
			
			if (is_array($value)) {
				foreach ($value as $num => $value_array) {
					foreach ($value_array as $k => $v) {
						$data['saved'][$key . '_' . $num . '_' . $k] = $v;
					}
				}
			}
		}
		
		// Load language and run standard checks
		$data = array_merge($data, $this->load->language($this->type . '/' . $this->name));
		
		if (ini_get('max_input_vars') && ((ini_get('max_input_vars') - count($data['saved'])) < 50)) {
			$data['warning'] = $data['standard_max_input_vars'];
		}
		
		if (!empty($data['vqmod']) && !file_exists(DIR_APPLICATION . '../vqmod/vqmod.php')) {
			$data['warning'] = $data['standard_vqmod'];
		}
		
		if ($this->type == 'total' && version_compare(VERSION, '2.2', '>=')) {
			file_put_contents(DIR_CATALOG . 'model/' . $this->type . '/' . $this->name . '.php', str_replace('public function getTotal(&$total_data, &$order_total, &$taxes) {', 'public function getTotal($total) { $total_data = &$total["totals"]; $order_total = &$total["total"]; $taxes = &$total["taxes"];', file_get_contents(DIR_CATALOG . 'model/' . $this->type . '/' . $this->name . '.php')));
		}
		
		// Set save type and skip auto-backup if not needed
		if (!empty($data['saved']['autosave'])) {
			$data['save_type'] = 'auto';
		}
		
		if ($backup_type == 'auto' && empty($data['autobackup'])) {
			return;
		}
		
		// Create settings auto-backup file
		$manual_filepath = DIR_LOGS . $this->name . $this->encryption_key . '.backup';
		$auto_filepath = DIR_LOGS . $this->name . $this->encryption_key . '.autobackup';
		$filepath = ($backup_type == 'auto') ? $auto_filepath : $manual_filepath;
		if (file_exists($filepath)) unlink($filepath);
		
		if ($this->columns == 3) {
			file_put_contents($filepath, 'EXTENSION	SETTING	VALUE' . "\n", FILE_APPEND|LOCK_EX);
		} elseif ($this->columns == 5) {
			file_put_contents($filepath, 'EXTENSION	SETTING	NUMBER	SUB-SETTING	VALUE' . "\n", FILE_APPEND|LOCK_EX);
		} else {
			file_put_contents($filepath, 'EXTENSION	SETTING	NUMBER	SUB-SETTING	SUB-NUMBER	SUB-SUB-SETTING	VALUE' . "\n", FILE_APPEND|LOCK_EX);
		}
		
		foreach ($data['saved'] as $key => $value) {
			if (is_array($value)) continue;
			
			$parts = explode('|', preg_replace(array('/_(\d+)_/', '/_(\d+)/'), array('|$1|', '|$1'), $key));
			
			$line = $this->name . "\t" . $parts[0] . "\t";
			for ($i = 1; $i < $this->columns - 2; $i++) {
				$line .= (isset($parts[$i]) ? $parts[$i] : '') . "\t";
			}
			$line .= str_replace(array("\t", "\n"), array('    ', '\n'), $value) . "\n";
			
			file_put_contents($filepath, $line, FILE_APPEND|LOCK_EX);
		}
		
		$data['autobackup_time'] = date('Y-M-d @ g:i a');
		$data['backup_time'] = (file_exists($manual_filepath)) ? date('Y-M-d @ g:i a', filemtime($manual_filepath)) : '';
		
		if ($backup_type == 'manual') {
			echo $data['autobackup_time'];
		}
	}
	
	public function saveSettings() {
		if (!$this->user->hasPermission('modify', $this->type . '/' . $this->name)) {
			echo 'PermissionError';
			return;
		}
		
		if ($this->request->get['saving'] == 'manual') {
			$this->db->query("DELETE FROM " . DB_PREFIX . "setting WHERE `" . (version_compare(VERSION, '2.0.1', '<') ? 'group' : 'code') . "` = '" . $this->db->escape($this->name) . "' AND `key` != '" . $this->db->escape($this->name . '_module') . "'");
		}
		
		$module_id = 0;
		$modules = array();
		$module_instance = false;
		
		foreach ($this->request->post as $key => $value) {
			if (strpos($key, 'module_') === 0) {
				$parts = explode('_', $key, 3);
				$module_id = $parts[1];
				$modules[$parts[1]][$parts[2]] = $value;
				if ($parts[2] == 'module_id') $module_instance = true;
			} else {
				if ($this->request->get['saving'] == 'auto') {
					$this->db->query("DELETE FROM " . DB_PREFIX . "setting WHERE `" . (version_compare(VERSION, '2.0.1', '<') ? 'group' : 'code') . "` = '" . $this->db->escape($this->name) . "' AND `key` = '" . $this->db->escape($this->name . '_' . $key) . "'");
				}
				$this->db->query("
					INSERT INTO " . DB_PREFIX . "setting SET
					`store_id` = 0,
					`" . (version_compare(VERSION, '2.0.1', '<') ? 'group' : 'code') . "` = '" . $this->db->escape($this->name) . "',
					`key` = '" . $this->db->escape($this->name . '_' . $key) . "',
					`value` = '" . $this->db->escape(stripslashes(is_array($value) ? implode(';', $value) : $value)) . "',
					`serialized` = 0
				");
			}
		}
		
		if (version_compare(VERSION, '2.0.1', '<')) {
			$module_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "setting WHERE `" . (version_compare(VERSION, '2.0.1', '<') ? 'group' : 'code') . "` = '" . $this->db->escape($this->name) . "'AND `key` = '" . $this->db->escape($this->name . '_module') . "'");
			if ($module_query->num_rows) {
				foreach (unserialize($module_query->row['value']) as $key => $value) {
					foreach ($value as $k => $v) {
						if (!isset($modules[$key][$k]) && $key != $module_id && $module_instance) {
							$modules[$key][$k] = $v;
						}
					}
				}
			}
			
			if (isset($modules[0])) {
				$index = 1;
				while (isset($modules[$index])) {
					$index++;
				}
				$modules[$index] = $modules[0];
				unset($modules[0]);
				$modules[$index]['module_id'] = $index;
			}
			
			$this->db->query("DELETE FROM " . DB_PREFIX . "setting WHERE `" . (version_compare(VERSION, '2.0.1', '<') ? 'group' : 'code') . "` = '" . $this->db->escape($this->name) . "'AND `key` = '" . $this->db->escape($this->name . '_module') . "'");
			$this->db->query("
				INSERT INTO " . DB_PREFIX . "setting SET
				`store_id` = 0,
				`" . (version_compare(VERSION, '2.0.1', '<') ? 'group' : 'code') . "` = '" . $this->db->escape($this->name) . "',
				`key` = '" . $this->db->escape($this->name . '_module') . "',
				`value` = '" . $this->db->escape(serialize($modules)) . "',
				`serialized` = 1
			");
		} else {
			foreach ($modules as $module_id => $module) {
				if (!$module_id) {
					$this->db->query("
						INSERT INTO " . DB_PREFIX . "module SET
						`name` = '" . $this->db->escape($module['name']) . "',
						`code` = '" . $this->db->escape($this->name) . "',
						`setting` = ''
					");
					$module_id = $this->db->getLastId();
					$module['module_id'] = $module_id;
				}
				$module_settings = (version_compare(VERSION, '2.1', '<')) ? serialize($module) : json_encode($module);
				$this->db->query("
					UPDATE " . DB_PREFIX . "module SET
					`name` = '" . $this->db->escape($module['name']) . "',
					`code` = '" . $this->db->escape($this->name) . "',
					`setting` = '" . $this->db->escape($module_settings) . "'
					WHERE module_id = " . (int)$module_id . "
				");
			}
		}
	}
	
	public function deleteSetting() {
		$this->db->query("DELETE FROM " . DB_PREFIX . "setting WHERE `" . (version_compare(VERSION, '2.0.1', '<') ? 'group' : 'code') . "` = '" . $this->db->escape($this->name) . "' AND `key` = '" . $this->db->escape($this->name . '_' . str_replace('[]', '', $this->request->get['setting'])) . "'");
	}
	
	//==============================================================================
	// Ajax functions
	//==============================================================================
	public function copyModule() {
		if (version_compare(VERSION, '2.0.1', '<')) {
			$module_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "setting WHERE `" . (version_compare(VERSION, '2.0.1', '<') ? 'group' : 'code') . "` = '" . $this->db->escape($this->name) . "'AND `key` = '" . $this->db->escape($this->name . '_module') . "'");
			$modules = unserialize($module_query->row['value']);
			
			$index = 1;
			while (isset($modules[$index])) {
				$index++;
			}
			
			$modules[$index] = $modules[$this->request->get['module_id']];
			$modules[$index]['module_id'] = $index;
			$modules[$index]['name'] .= ' (Copy)';
			
			$this->db->query("UPDATE " . DB_PREFIX . "setting SET `value` = '" . $this->db->escape(serialize($modules)) . "' WHERE setting_id = " . (int)$module_query->row['setting_id']);
		} else {
			$module_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "module WHERE module_id = " . (int)$this->request->get['module_id']);
			$module_settings = (version_compare(VERSION, '2.1', '<')) ? unserialize($module_query->row['setting']) : json_decode($module_query->row['setting'], true);
			$module_settings['name'] .= ' (Copy)';
			$this->db->query("INSERT INTO " . DB_PREFIX . "module SET `name` = '" . $this->db->escape($module_settings['name']) . "', `code` = '" . $this->db->escape($this->name) . "', `setting` = '" . $this->db->escape(version_compare(VERSION, '2.1', '<') ? serialize($module_settings) : json_encode($module_settings)) . "'");
		}
	}
	
	public function deleteModule() {
		if (version_compare(VERSION, '2.0.1', '<')) {
			$module_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "setting WHERE `" . (version_compare(VERSION, '2.0.1', '<') ? 'group' : 'code') . "` = '" . $this->db->escape($this->name) . "'AND `key` = '" . $this->db->escape($this->name . '_module') . "'");
			$modules = unserialize($module_query->row['value']);
			unset($modules[$this->request->get['module_id']]);
			$this->db->query("UPDATE " . DB_PREFIX . "setting SET `value` = '" . $this->db->escape(serialize($modules)) . "' WHERE setting_id = " . (int)$module_query->row['setting_id']);
		} else {
			$this->db->query("DELETE FROM " . DB_PREFIX . "module WHERE module_id = " . (int)$this->request->get['module_id']);
		}
	}
}
?>