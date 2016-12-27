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
	
	public function index() {
		$data = array(
			'type' => $this->type,
			'name' => $this->name,
		);
		
		// extension-specific
		$this->db->query("
			CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . $this->name . "` (
			`" . $this->name . "_id` int(11) NOT NULL AUTO_INCREMENT,
			`date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
			`search` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
			`phase` int(1) NOT NULL,
			`results` int(11) NOT NULL,
			`customer_id` int(11) NOT NULL,
			`ip` varchar(15) COLLATE utf8_bin NOT NULL DEFAULT '0',
			PRIMARY KEY (`" . $this->name . "_id`)
			) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin
		");
		if (isset($this->request->get['table']) && $this->request->get['table'] == 'reset') {
			$this->db->query("TRUNCATE TABLE " . DB_PREFIX . $this->name);
		}
		// end
		
		// Convert old settings
		$old_settings_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "setting WHERE `key` = '" . $this->name . "_data'");
		if ($old_settings_query->num_rows) {
			$old_settings = unserialize($old_settings_query->row['value']);
			
			// extension-specific
			$converted_settings = array();
			foreach ($old_settings as $key => $value) {
				if (strpos($key, 'ajax_') === 0) {
					$converted_settings[str_replace('ajax_', 'live_', $key)] = $value;
				} elseif ($key == 'relevance') {
					foreach ($value as $k => $v) {
						$converted_settings['search_' . $k] = $v;
					}
				} elseif ($key == 'replace_array') {
					foreach ($value as $k => $v) {
						$converted_settings['replacement_' . ($k+1) . '_replace'] = $v;
					}
				} elseif ($key == 'with_array') {
					foreach ($value as $k => $v) {
						$converted_settings['replacement_' . ($k+1) . '_with'] = $v;
					}
				} else {
					$converted_settings[$key] = $value;
				}
			}
			// end
			
			foreach ($converted_settings as $key => $value) {
				if (is_array($value)) {
					if (is_int(key($value))) {
						$this->db->query("INSERT INTO " . DB_PREFIX . "setting SET `" . (version_compare(VERSION, '2.0.1') < 0 ? 'group' : 'code') . "` = '" . $this->name . "', `key` = '" . $this->name . "_" . $key . "', `value` = '" . implode(';', $value) . "'");
					} else {
						foreach ($value as $value_key => $value_value) {
							$this->db->query("INSERT INTO " . DB_PREFIX . "setting SET `" . (version_compare(VERSION, '2.0.1') < 0 ? 'group' : 'code') . "` = '" . $this->name . "', `key` = '" . $this->name . "_" . $key . "_" . $value_key . "', `value` = '" . $value_value . "'");
						}
					}
				} else {
					$this->db->query("INSERT INTO " . DB_PREFIX . "setting SET `" . (version_compare(VERSION, '2.0.1') < 0 ? 'group' : 'code') . "` = '" . $this->name . "', `key` = '" . $this->name . "_" . $key . "', `value` = '" . $value . "'");
				}
			}
			$this->db->query("DELETE FROM " . DB_PREFIX . "setting WHERE `key` = '" . $this->name . "_data'");
		}
		
		$this->loadSettings($data);
		$data['permission'] = $this->user->hasPermission('modify', $this->type . '/' . $this->name);
		
		$token = $data['token'] = (isset($this->session->data['token'])) ? $this->session->data['token'] : '';
		$data = array_merge($data, $this->load->language($this->type . '/' . $this->name));
		$data['exit'] = $this->url->link('extension/' . $this->type, 'token=' . $token, 'SSL');
		
		$data['settings_buttons'] = false;
		$data['tooltips_button'] = false;
		
		//------------------------------------------------------------------------------
		// Data Arrays
		//------------------------------------------------------------------------------
		$this->load->model('localisation/language');
		$data['language_array'] = array($this->config->get('config_language') => '');
		$data['language_flags'] = array();
		foreach ($this->model_localisation_language->getLanguages() as $language) {
			$data['language_array'][$language['code']] = $language['name'];
			$data['language_flags'][$language['code']] = ($language['code'] == 'en') ? 'us.png' : $language['image'];
		}
		
		//------------------------------------------------------------------------------
		// Search History
		//------------------------------------------------------------------------------
		$data['settings'] = array();
		if (!empty($data['saved'])) {
			$data['settings'][] = array(
				'type'		=> 'tabs',
				'tabs'		=> array('search_history', 'search_settings', 'fields_searched', 'misspelling_settings', 'live_search', 'pre_search_replacements'),
			);
			$data['settings'][] = array(
				'type'		=> 'html',
				'content'	=> '<div class="text-info text-center" style="padding-bottom: 5px">' . $data['help_search_history'] . '</div>',
			);
			$data['settings'][] = array(
				'key'		=> 'search_history',
				'type'		=> 'heading',
				'buttons'	=> '<a class="btn btn-danger" onclick="if (confirm(\'' . $data['standard_confirm'] . '\')) go(\'' . $this->type . '/' . $this->name . '&table=reset\')">' . $data['button_reset_search_history'] . '</a>',
			);
			
			$filters = array(
				'date_start'		=> date('Y-m-d', strtotime('-1 month')),
				'date_end'			=> date('Y-m-d', time()),
				'combine_searches'	=> 0,
				'page'				=> 1,
				'limit'				=> (version_compare(VERSION, '2.0') < 0) ? $this->config->get('config_admin_limit') : $this->config->get('config_limit_admin'),
			);
			$url = '';
			foreach ($filters as $key => $value) {
				if (isset($this->request->get[$key])) {
					$url .= '&' . $key . '=' . $this->request->get[$key];
					$filters[$key] = $this->request->get[$key];
				}
			}
			
			$data['settings'][] = array(
				'type'		=> 'html',
				'content'	=> '
					<div class="alert alert-info">
						' . $data['entry_date_start'] . ' <input type="date" id="date_start" class="nosave form-control" placeholder="' . $data['placeholder_date_format'] . '" value="' . $filters['date_start'] . '" /> &nbsp; &nbsp;
						' . $data['entry_date_end'] . ' <input type="date" id="date_end" class="nosave form-control" placeholder="' . $data['placeholder_date_format'] . '" value="' . $filters['date_end'] . '" /> &nbsp; &nbsp;
						' . $data['entry_combine_same_searches'] . ' 
						<select id="combine_searches" class="nosave form-control">
							<option value="0" ' . (!$filters['combine_searches'] ? 'selected="selected"' : '') . '>' . $data['text_no'] . '</option>
							<option value="1" ' . ($filters['combine_searches'] ? 'selected="selected"' : '') . '>' . $data['text_yes'] . '</option>
						</select> &nbsp; &nbsp;
						<a class="btn btn-primary" onclick="go(\'' . $this->type . '/' . $this->name . '\')">' . $data['button_filter'] . '</a> &nbsp; &nbsp;
						<a class="btn btn-info" onclick="go(\'' . $this->type . '/' . $this->name . '/exportCSV\')">' . $data['button_export_csv'] . '</a>
					</div>
				',
			);
			
			if (empty($filters['combine_searches'])) {
				$sql = "SELECT * FROM " . DB_PREFIX . $this->name . " WHERE TRUE";
			} else {
				$sql = "SELECT MIN(date_added) AS first_time, MAX(date_added) AS last_time, LCASE(search) AS search, ROUND(AVG(results),1) AS average_results, COUNT(*) AS times_searched FROM " . DB_PREFIX . $this->name . " WHERE TRUE";
			}
			$sql .= (!empty($filters['date_start'])) ? " AND DATE(date_added) >= '" . $this->db->escape($filters['date_start']) . "'" : "";
			$sql .= (!empty($filters['date_end'])) ? " AND DATE(date_added) <= '" . $this->db->escape($filters['date_end']) . "'" : "";
			$sql .= (!empty($filters['combine_searches'])) ? " GROUP BY search ORDER BY times_searched DESC" : " ORDER BY date_added DESC";
			
			$searches = $this->db->query($sql . " LIMIT " . (int)(($filters['page'] - 1) * $filters['limit']) . "," . (int)$filters['limit'])->rows;
			$searches_total = $this->db->query($sql)->num_rows;
			
			$pagination = new Pagination();
			$pagination->total = $searches_total;
			$pagination->page = $filters['page'];
			$pagination->limit = $filters['limit'];
			$pagination->text = $data['text_pagination'];
			$pagination->url = $this->url->link($this->type . '/' . $this->name, 'token=' . $token . $url . '&page={page}', 'SSL');
			$data['settings'][] = array(
				'type'		=> 'html',
				'content'	=> '<div class="pagination" style="border: none; margin-top: -10px;">' . $pagination->render() . '</div>',
			);
			
			if ($filters['combine_searches']) {
				$data['settings'][] = array(
					'key'		=> 'search_history',
					'type'		=> 'table_start',
					'columns'	=> array('action', 'first_time', 'last_time', 'search_terms', 'average_results', 'times_searched'),
				);
				foreach ($searches as $search) {
					$data['settings'][] = array(
						'type'		=> 'row_start',
					);
					$data['settings'][] = array(
						'type'		=> 'html',
						'content'	=> '<a class="btn btn-danger" data-key="' . $search['search'] . '" onclick="deleteRecord($(this))" data-help="' . $data['button_delete'] . '"><i class="fa fa-trash-o fa-lg fa-fw"></i></a>',
					);
					$data['settings'][] = array(
						'type'		=> 'column',
					);
					$data['settings'][] = array(
						'type'		=> 'html',
						'content'	=> $search['first_time'],
					);
					$data['settings'][] = array(
						'type'		=> 'column',
					);
					$data['settings'][] = array(
						'type'		=> 'html',
						'content'	=> $search['last_time'],
					);
					$data['settings'][] = array(
						'type'		=> 'column',
					);
					$data['settings'][] = array(
						'type'		=> 'html',
						'content'	=> $search['search'],
					);
					$data['settings'][] = array(
						'type'		=> 'column',
					);
					$data['settings'][] = array(
						'type'		=> 'html',
						'content'	=> $search['average_results'],
					);
					$data['settings'][] = array(
						'type'		=> 'column',
					);
					$data['settings'][] = array(
						'type'		=> 'html',
						'content'	=> $search['times_searched'],
					);
					$data['settings'][] = array(
						'type'		=> 'row_end',
					);
				}
				$data['settings'][] = array(
					'type'		=> 'table_end',
					'buttons'	=> '',
				);					
			} else {
				$data['settings'][] = array(
					'key'		=> 'search_history',
					'type'		=> 'table_start',
					'columns'	=> array('action', 'time', 'search_terms', 'phase_reached', 'results', 'customer', 'ip_address'),
				);
				
				$this->load->model('sale/customer');
				
				foreach ($searches as $search) {
					if (empty($search['customer_id'])) {
						$customer = $data['text_guest'];
					} else {
						$customer_data = $this->model_sale_customer->getCustomer($search['customer_id']);
						$customer = '<a href="' . HTTPS_SERVER . 'index.php?route=sale/customer/' . (version_compare(VERSION, '2.0') < 0 ? 'update' : 'edit') . '&token=' . $token . '&customer_id=' . $search['customer_id'] . '" title="' . $data['text_view_customer'] . '">' . '</a>';
					}
					$data['settings'][] = array(
						'type'		=> 'row_start',
					);
					$data['settings'][] = array(
						'type'		=> 'html',
						'content'	=> '<a class="btn btn-danger" data-key="' . $search['smartsearch_id'] . '" onclick="deleteRecord($(this))" data-help="' . $data['button_delete'] . '"><i class="fa fa-trash-o fa-lg fa-fw"></i></a>',
					);
					$data['settings'][] = array(
						'type'		=> 'column',
					);
					$data['settings'][] = array(
						'type'		=> 'html',
						'content'	=> $search['date_added'],
					);
					$data['settings'][] = array(
						'type'		=> 'column',
					);
					$data['settings'][] = array(
						'type'		=> 'html',
						'content'	=> $search['search'],
					);
					$data['settings'][] = array(
						'type'		=> 'column',
					);
					$data['settings'][] = array(
						'type'		=> 'html',
						'content'	=> $search['phase'],
					);
					$data['settings'][] = array(
						'type'		=> 'column',
					);
					$data['settings'][] = array(
						'type'		=> 'html',
						'content'	=> $search['results'],
					);
					$data['settings'][] = array(
						'type'		=> 'column',
					);
					$data['settings'][] = array(
						'type'		=> 'html',
						'content'	=> $customer,
					);
					$data['settings'][] = array(
						'type'		=> 'column',
					);
					$data['settings'][] = array(
						'type'		=> 'html',
						'content'	=> $search['ip'],
					);
					$data['settings'][] = array(
						'type'		=> 'row_end',
					);
				}
				$data['settings'][] = array(
					'type'		=> 'table_end',
					'buttons'	=> '',
				);					
			}

			$data['settings'][] = array(
				'type'		=> 'html',
				'content'	=> '<div class="pagination" style="border: none; margin-top: -10px;">' . $pagination->render() . '</div>',
			);
			
			$data['settings'][] = array(
				'key'		=> 'search_settings',
				'type'		=> 'tab',
			);
		} else {
			$data['settings'][] = array(
				'type'		=> 'tabs',
				'tabs'		=> array('search_settings', 'fields_searched', 'misspelling_settings', 'live_search', 'pre_search_replacements'),
			);
		}
		
		//------------------------------------------------------------------------------
		// Search Settings
		//------------------------------------------------------------------------------
		$data['settings'][] = array(
			'type'		=> 'html',
			'content'	=> '<div class="text-info">' . $data['help_search_settings'] . '</div>',
		);
		$data['settings'][] = array(
			'key'		=> 'search_settings',
			'type'		=> 'heading',
		);
		$data['settings'][] = array(
			'key'		=> 'status',
			'type'		=> 'select',
			'options'	=> array('0' => $data['text_disabled'], '1' => $data['text_enabled']),
		);
		$data['settings'][] = array(
			'key'		=> 'testing_mode',
			'type'		=> 'select',
			'options'	=> array('0' => $data['text_disabled'], '1' => $data['text_enabled_normal'], '2' => $data['text_enabled_ignore']),
		);
		$data['settings'][] = array(
			'key'		=> 'default_sort',
			'type'		=> 'select',
			'options'	=> array(
				'date_added'		=> $data['text_date_added'],
				'date_available'	=> $data['text_date_available'],
				'date_modified'		=> $data['text_date_modified'],
				'model'				=> $data['text_model'],
				'name'				=> $data['text_name'],
				'price'				=> $data['text_price'],
				'quantity'			=> $data['text_quantity'],
				'rating'			=> $data['text_rating'],
				'sort_order'		=> $data['text_sort_order'],
				'times_purchased'	=> $data['text_times_purchased'],
				'times_viewed'		=> $data['text_times_viewed'],
			),
			'default'	=> 'sort_order',
		);
		$data['settings'][] = array(
			'key'		=> 'default_order',
			'type'		=> 'select',
			'options'	=> array(
				'ASC'	=> $data['text_ascending'],
				'DESC'	=> $data['text_descending'],
			),
		);
		$data['settings'][] = array(
			'key'		=> 'cache_keywords',
			'type'		=> 'select',
			'options'	=> array(
				'3600'		=> $data['text_hourly'],
				'86400'		=> $data['text_daily'],
				'604800'	=> $data['text_weekly'],
				'2592000'	=> $data['text_monthly'],
				'31536000'	=> $data['text_yearly'],
				'0'			=> $data['text_dont_use_cache'],
			),
			'default'	=> '86400',
			'after'		=> '<a id="keywords" class="btn btn-primary" onclick="clearCache($(this))">' . $data['button_clear_cache'] . '</a>',
		);
		$data['settings'][] = array(
			'key'		=> 'plurals',
			'type'		=> 'select',
			'options'	=> array('1' => $data['text_yes'], '0' => $data['text_no']),
			'default'	=> '1',
		);
		$data['settings'][] = array(
			'key'		=> 'partials',
			'type'		=> 'select',
			'options'	=> array('1' => $data['text_yes'], '0' => $data['text_no']),
			'default'	=> '1',
		);
		$data['settings'][] = array(
			'key'		=> 'min_results',
			'type'		=> 'text',
			'attributes'=> array('style' => 'width: 50px !important'),
			'default'	=> '1',
		);
		$data['settings'][] = array(
			'key'		=> 'single_redirect',
			'type'		=> 'select',
			'options'	=> array('1' => $data['text_yes'], '0' => $data['text_no']),
			'default'	=> '1',
		);
		$data['settings'][] = array(
			'key'		=> 'subcategories',
			'type'		=> 'select',
			'options'	=> array('1' => $data['text_yes'], '0' => $data['text_no']),
			'default'	=> '1',
		);
		$data['settings'][] = array(
			'key'		=> 'index_database_tables',
			'type'		=> 'html',
			'content'	=> '<a class="btn btn-primary" onclick="indexTables($(this))">' . $data['button_index_database_tables'] . '</a>',
		);
		
		//------------------------------------------------------------------------------
		// Fields Searched
		//------------------------------------------------------------------------------
		$data['settings'][] = array(
			'key'		=> 'fields_searched',
			'type'		=> 'tab',
		);
		$data['settings'][] = array(
			'type'		=> 'html',
			'content'	=> '<div class="text-info">' . $data['help_fields_searched'] . '</div>',
		);
		$data['settings'][] = array(
			'key'		=> 'fields_searched',
			'type'		=> 'heading',
		);
		
		$search_fields_1 = array(
			'name',
			'description',
			'description_misspelled',
			'meta_description',
			'meta_keyword',
			'tag',
			'model',
			'sku',
			'ean',
			'jan',
		);
		$search_fields_2 = array(
			'isbn',
			'mpn',
			'upc',
			'location',
			'manufacturer',
			'attribute_group',
			'attribute_name',
			'attribute_value',
			'option_name',
			'option_value',
		);
		
		$data['settings'][] = array(
			'key'		=> 'search_fields',
			'type'		=> 'table_start',
			'columns'	=> array(),
			'attributes'=> array('style' => 'max-width: 600px'),
		);
		for ($i = 0; $i < count($search_fields_1); $i++) {
			$data['settings'][] = array(
				'type'		=> 'row_start',
			);
			$data['settings'][] = array(
				'type'		=> 'html',
				'content'	=> '<div class="text-right" style="padding-top: 7px">' . $data['text_search_' . $search_fields_1[$i]] . '</div>',
			);
			$data['settings'][] = array(
				'type'		=> 'column',
			);
			$data['settings'][] = array(
				'key'		=> 'search_' . $search_fields_1[$i],
				'type'		=> 'text',
				'attributes'=> array('style' => 'width: 50px !important'),
				'default'	=> ($search_fields_1[$i] == 'name') ? '1' : '',
			);
			$data['settings'][] = array(
				'type'		=> 'column',
			);
			$data['settings'][] = array(
				'type'		=> 'html',
				'content'	=> '<div class="text-right" style="padding-top: 7px">' . $data['text_search_' . $search_fields_2[$i]] . '</div>',
			);
			$data['settings'][] = array(
				'type'		=> 'column',
			);
			$data['settings'][] = array(
				'key'		=> 'search_' . $search_fields_2[$i],
				'type'		=> 'text',
				'attributes'=> array('style' => 'width: 50px !important'),
			);
			$data['settings'][] = array(
				'type'		=> 'row_end',
			);
		}
		$data['settings'][] = array(
			'type'		=> 'table_end',
			'buttons'	=> '',
		);
		
		//------------------------------------------------------------------------------
		// Misspelling Settings
		//------------------------------------------------------------------------------
		$data['settings'][] = array(
			'key'		=> 'misspelling_settings',
			'type'		=> 'tab',
		);
		$data['settings'][] = array(
			'key'		=> 'misspelling_settings',
			'type'		=> 'heading',
		);
		$data['settings'][] = array(
			'key'		=> 'tolerance',
			'type'		=> 'text',
			'attributes'=> array('style' => 'width: 50px !important'),
			'default'	=> '75',
			'after'		=> '%',
		);
		$data['settings'][] = array(
			'key'		=> 'cache_misspelling',
			'type'		=> 'select',
			'options'	=> array(
				'3600'		=> $data['text_hourly'],
				'86400'		=> $data['text_daily'],
				'604800'	=> $data['text_weekly'],
				'2592000'	=> $data['text_monthly'],
				'31536000'	=> $data['text_yearly'],
				'0'			=> $data['text_dont_use_cache'],
			),
			'default'	=> '86400',
			'after'		=> '<a id="misspelling" class="btn btn-primary" onclick="clearCache($(this))">' . $data['button_clear_cache'] . '</a>',
		);
		$data['settings'][] = array(
			'key'		=> 'word_length',
			'type'		=> 'text',
			'attributes'=> array('style' => 'width: 50px !important'),
			'default'	=> '3',
		);
		
		//------------------------------------------------------------------------------
		// Live Search
		//------------------------------------------------------------------------------
		$data['settings'][] = array(
			'key'		=> 'live_search',
			'type'		=> 'tab',
		);
		$data['settings'][] = array(
			'key'		=> 'live_search',
			'type'		=> 'heading',
		);
		$data['settings'][] = array(
			'key'		=> 'live_search',
			'type'		=> 'select',
			'options'	=> array('0' => $data['text_disabled'], '1' => $data['text_enabled']),
		);
		$data['settings'][] = array(
			'key'		=> 'live_selector',
			'type'		=> 'text',
			'default'	=> '#search input',
		);
		$data['settings'][] = array(
			'key'		=> 'live_css',
			'type'		=> 'textarea',
		);
		
		// Colors
		$data['settings'][] = array(
			'key'		=> 'colors',
			'type'		=> 'heading',
		);
		$color_class = "color {required: false, hash: true, pickerPosition: 'bottom', pickerFaceColor: '#444', pickerBorderColor:'#000'}";
		$data['settings'][] = array(
			'key'		=> 'live_background_color',
			'type'		=> 'text',
			'class'		=> $color_class,
			'default'	=> '#FFFFFF',
		);
		$data['settings'][] = array(
			'key'		=> 'live_borders_color',
			'type'		=> 'text',
			'class'		=> $color_class,
			'default'	=> '#EEEEEE',
		);
		$data['settings'][] = array(
			'key'		=> 'live_font_color',
			'type'		=> 'text',
			'class'		=> $color_class,
			'default'	=> '#000000',
		);
		$data['settings'][] = array(
			'key'		=> 'live_highlight_color',
			'type'		=> 'text',
			'class'		=> $color_class,
			'default'	=> '#EEFFFF',
		);
		$data['settings'][] = array(
			'key'		=> 'live_price_color',
			'type'		=> 'text',
			'class'		=> $color_class,
			'default'	=> '#000000',
		);
		$data['settings'][] = array(
			'key'		=> 'live_special_color',
			'type'		=> 'text',
			'class'		=> $color_class,
			'default'	=> '#FF0000',
		);
		
		// Display
		$data['settings'][] = array(
			'key'		=> 'display',
			'type'		=> 'heading',
		);
		$data['settings'][] = array(
			'key'		=> 'live_delay',
			'type'		=> 'text',
			'attributes'=> array('style' => 'width: 50px !important'),
			'default'	=> '500',
		);
		$data['settings'][] = array(
			'key'		=> 'live_limit',
			'type'		=> 'text',
			'attributes'=> array('style' => 'width: 50px !important'),
			'default'	=> '5',
		);
		$data['settings'][] = array(
			'key'		=> 'live_price',
			'type'		=> 'select',
			'options'	=> array('1' => $data['text_show'], '0' => $data['text_hide']),
		);
		$data['settings'][] = array(
			'key'		=> 'live_model',
			'type'		=> 'select',
			'options'	=> array('1' => $data['text_show'], '0' => $data['text_hide']),
			'default'	=> '0',
		);
		$data['settings'][] = array(
			'key'		=> 'live_addtocart_button',
			'type'		=> 'select',
			'options'	=> array('0' => $data['text_hide'], 'quantity' => $data['text_show_with_quantity_field'], 'no_quantity' => $data['text_show_without_quantity_field']),
			'default'	=> '0',
		);
		$data['settings'][] = array(
			'key'		=> 'live_addtocart_class',
			'type'		=> 'text',
			'default'	=> (version_compare(VERSION, '2.0') < 0) ? 'button' : 'btn btn-primary',
		);
		$data['settings'][] = array(
			'key'		=> 'live_description',
			'type'		=> 'text',
			'attributes'=> array('style' => 'width: 50px !important'),
			'default'	=> '100',
		);
		
		// Positioning
		$data['settings'][] = array(
			'key'		=> 'positioning',
			'type'		=> 'heading',
		);
		$data['settings'][] = array(
			'key'		=> 'live_top',
			'type'		=> 'text',
			'attributes'=> array('style' => 'width: 50px !important'),
			'default'	=> (version_compare(VERSION, '2.0') < 0) ? '' : '42',
		);
		$data['settings'][] = array(
			'key'		=> 'live_left',
			'type'		=> 'text',
			'attributes'=> array('style' => 'width: 50px !important'),
		);
		$data['settings'][] = array(
			'key'		=> 'live_right',
			'type'		=> 'text',
			'attributes'=> array('style' => 'width: 50px !important'),
		);
		
		// Sizes
		$data['settings'][] = array(
			'key'		=> 'sizes',
			'type'		=> 'heading',
		);
		$data['settings'][] = array(
			'key'		=> 'live_width',
			'type'		=> 'text',
			'attributes'=> array('style' => 'width: 50px !important'),
			'default'	=> '98%',
		);
		$data['settings'][] = array(
			'key'		=> 'live_image_width',
			'type'		=> 'text',
			'attributes'=> array('style' => 'width: 50px !important'),
			'default'	=> '50',
		);
		$data['settings'][] = array(
			'key'		=> 'live_image_height',
			'type'		=> 'text',
			'attributes'=> array('style' => 'width: 50px !important'),
			'default'	=> '50',
		);
		$data['settings'][] = array(
			'key'		=> 'live_product_font',
			'type'		=> 'text',
			'attributes'=> array('style' => 'width: 50px !important'),
			'default'	=> '13',
		);
		$data['settings'][] = array(
			'key'		=> 'live_description_font',
			'type'		=> 'text',
			'attributes'=> array('style' => 'width: 50px !important'),
			'default'	=> '11',
		);
		
		// Text
		$data['settings'][] = array(
			'key'		=> 'text',
			'type'		=> 'heading',
		);
		$data['settings'][] = array(
			'key'		=> 'live_viewall',
			'type'		=> 'multilingual_text',
			'default'	=> 'View All Results',
		);
		$data['settings'][] = array(
			'key'		=> 'live_noresults',
			'type'		=> 'multilingual_text',
			'default'	=> 'No Results',
		);
		$data['settings'][] = array(
			'key'		=> 'live_addtocart_text',
			'type'		=> 'multilingual_text',
			'default'	=> 'Add to Cart',
		);
		$data['settings'][] = array(
			'key'		=> 'live_quantity_text',
			'type'		=> 'multilingual_text',
			'default'	=> 'Qty:',
		);
		
		//------------------------------------------------------------------------------
		// Pre-Search Replacements
		//------------------------------------------------------------------------------
		$data['settings'][] = array(
			'key'		=> 'pre_search_replacements',
			'type'		=> 'tab',
		);
		$data['settings'][] = array(
			'type'		=> 'html',
			'content'	=> '<div class="text-info text-center" style="padding-bottom: 5px">' . $data['help_pre_search_replacements'] . '</div>',
		);
		$data['settings'][] = array(
			'key'		=> 'pre_search_replacements',
			'type'		=> 'heading',
		);
		
		$table = 'replacement';
		$sortby = 'replace';
		$data['settings'][] = array(
			'key'		=> $table,
			'type'		=> 'table_start',
			'columns'	=> array('action', 'replace', 'with'),
		);
		foreach ($this->getTableRowNumbers($data, $table, $sortby) as $num => $rules) {
			$prefix = $table . '_' . $num . '_';
			$data['settings'][] = array(
				'type'		=> 'row_start',
			);
			$data['settings'][] = array(
				'key'		=> 'delete',
				'type'		=> 'button',
			);
			$data['settings'][] = array(
				'type'		=> 'column',
			);
			$data['settings'][] = array(
				'key'		=> $prefix . 'replace',
				'type'		=> 'text',
				'attributes'=> array('style' => 'width: 200px !important'),
			);
			$data['settings'][] = array(
				'type'		=> 'column',
			);
			$data['settings'][] = array(
				'key'		=> $prefix . 'with',
				'type'		=> 'text',
				'attributes'=> array('style' => 'width: 200px !important'),
			);
			$data['settings'][] = array(
				'type'		=> 'row_end',
			);
		}
		$data['settings'][] = array(
			'type'		=> 'table_end',
			'buttons'	=> 'add_row',
			'text'		=> 'button_add_replacement',
		);
		
		//------------------------------------------------------------------------------
		// Custom javascript functions
		//------------------------------------------------------------------------------
		$data['settings'][] = array(
			'type'		=> 'html',
			'content'	=> '
				<script>
					$("textarea").tabby();
					
					function clearCache(element) {
						if (!confirm("' . $data['standard_confirm'] . '")) return;
						element.attr("disabled", "disabled").html("' . $data['standard_please_wait'] . '");
						
						$.get("index.php?route=' . $this->type . '/' . $this->name . '/clearCache&type=" + element.attr("id") + "&token=' . $token . '",
							function(data) {
								alert(data);
								element.removeAttr("disabled").html("' . $data['button_clear_cache'] . '");
							}
						);
					}
					
					function indexTables(element) {
						element.attr("disabled", "disabled").html("' . $data['standard_please_wait'] . '");
						$.get("index.php?route=' . $this->type . '/' . $this->name . '/indexTables&token=' . $token . '",
							function(data) {
								alert(data.replace(/(<([^>]+)>)/ig,""));
								element.removeAttr("disabled").html("' . $data['button_index_database_tables'] . '");
							}
						);
					}
					
					function go(route) {
						url = "index.php?route=" + route + "&token=' . $token . '";
						url += ($("#date_start").val()) ? "&date_start=" + encodeURIComponent($("#date_start").val()) : "";
						url += ($("#date_end").val()) ? "&date_end=" + encodeURIComponent($("#date_end").val()) : "";
						url += ($("#combine_searches").val()) ? "&combine_searches=" + encodeURIComponent($("#combine_searches").val()) : "";
						location = url;
					}
					
					function deleteRecord(element) {
						if (!confirm("' . $data['standard_confirm'] . '")) return;
						$.ajax({
							type: "POST",
							url: "index.php?route=' . $this->type . '/' . $this->name . '/deleteRecord&token=' . $token . '",
							data: {key: element.attr("data-key"), combined: $("#combine_searches").val()},
							success: function(data) {
								if (data) {
									alert(data);
								} else {
									element.parent().parent().parent().remove();
								}
							}
						});
					}
				</script>
			',
		);
		
		$this->document->addScript('view/javascript/jscolor/jscolor.js');
		$this->document->addScript('view/javascript/jquery/jquery.tabby.min.js');
		
		//------------------------------------------------------------------------------
		// end settings
		//------------------------------------------------------------------------------
		
		$this->document->setTitle($data['heading_title']);
		
		if (version_compare(VERSION, '2.0') < 0) {
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
			$this->response->setOutput($this->load->view($this->type . '/' . $this->name . '.tpl', $data));
		}
	}
	
	//==============================================================================
	// Setting functions
	//==============================================================================
	private function loadSettings(&$data = array()) {
		$data['saved'] = array();
		$settings_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "setting WHERE `" . (version_compare(VERSION, '2.0.1') < 0 ? 'group' : 'code') . "` = '" . $this->db->escape($this->name) . "' ORDER BY `key` ASC");
		foreach ($settings_query->rows as $setting) {
			$data['saved'][str_replace($this->name . '_', '', $setting['key'])] = (is_string($setting['value']) && strpos($setting['value'], 'a:') === 0) ? unserialize($setting['value']) : $setting['value'];
		}
	}
	
	public function saveSetting() {
		if (!$this->user->hasPermission('modify', $this->type . '/' . $this->name)) {
			echo 'PermissionError';
			return;
		}
		
		foreach ($this->request->post as $key => $value) {
			$this->db->query("DELETE FROM " . DB_PREFIX . "setting WHERE `" . (version_compare(VERSION, '2.0.1') < 0 ? 'group' : 'code') . "` = '" . $this->db->escape($this->name) . "'AND `key` = '" . $this->db->escape($this->name . '_' . $key) . "'");
			$this->db->query("
				INSERT INTO " . DB_PREFIX . "setting SET
				`store_id` = 0,
				`" . (version_compare(VERSION, '2.0.1') < 0 ? 'group' : 'code') . "` = '" . $this->db->escape($this->name) . "',
				`key` = '" . $this->db->escape($this->name . '_' . $key) . "',
				`value` = '" . $this->db->escape(stripslashes($value)) . "'
				" . (version_compare(VERSION, '1.5.1') >= 0 ? ", `serialized` = 0" : "") . "
			");
		}
	}
	
	public function deleteSetting() {
		$this->db->query("DELETE FROM " . DB_PREFIX . "setting WHERE `" . (version_compare(VERSION, '2.0.1') < 0 ? 'group' : 'code') . "` = '" . $this->db->escape($this->name) . "' AND `key` = '" . $this->db->escape($this->name . '_' . $this->request->get['setting']) . "'");
	}
	
	private function getTableRowNumbers($data, $table, $sorting) {
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
		
		if (empty($groups)) {
			$groups = array('' => array('1'));
		}
		ksort($groups, SORT_STRING);
		
		$rows = array();
		foreach ($groups as $group) {
			foreach ($group as $num) {
				$rows[$num] = (empty($rules[$num])) ? array() : $rules[$num];
			}
		}
		
		return $rows;
	}
	
	//==============================================================================
	// Custom functions
	//==============================================================================
	public function clearCache() {
		if (!$this->user->hasPermission('modify', $this->type . '/' . $this->name)) {
			echo 'PermissionError';
			return;
		}
		
		$cache = (isset($this->request->get['type']) && $this->request->get['type'] == 'misspelling') ? $this->name : $this->name . '_hash';
		$files = glob(DIR_CACHE . $cache . '.*');
		if (!empty($files)) {
			foreach ($files as $file) {
				if (file_exists($file)) unlink($file);
			}
		}
		
		$data = $this->load->language($this->type . '/' . $this->name);
		echo $data['standard_success'];
	}
	
	public function indexTables() {
		if (!$this->user->hasPermission('modify', $this->type . '/' . $this->name)) {
			echo 'PermissionError';
			return;
		}
		
		$tables = array(
			'category'					=> array('parent_id', 'top', 'sort_order', 'status'),
			'option'					=> array('sort_order'),
			'option_description'		=> array('name'),
			'option_value'				=> array('option_id'),
			'option_value_description'	=> array('option_id'),
			'order'						=> array('customer_id'),
			'product'					=> array('model', 'sku', 'upc', 'manufacturer_id', 'sort_order', 'status'),
			'product_option'			=> array('option_id'),
			'product_option_value'		=> array('product_option_id', 'product_id', 'option_id', 'option_value_id'),
			'url_alias'					=> array('query', 'keyword'),
			'user'						=> array('username', 'password', 'email')
		);
		
		foreach ($tables as $table => $columns) {
			foreach ($columns as $column) {
				$index_query = $this->db->query("SHOW INDEX FROM `" . DB_PREFIX . $table . "` WHERE Key_name = '" . $column . "'");
				if (!$index_query->num_rows) {
					$this->db->query("ALTER TABLE `" . DB_PREFIX . $table . "` ADD INDEX (`" . $column . "`)");
				}
			}
		}
		
		$data = $this->load->language($this->type . '/' . $this->name);
		echo $data['text_indexed_success'];
	}
	
	public function exportCSV() {
		if (!$this->user->hasPermission('access', $this->type . '/' . $this->name)) {
			return;
		}
		
		header('Pragma: public');
		header('Expires: 0');
		header('Content-Description: File Transfer');
		header('Content-Type: application/octet-stream');
		header('Content-Disposition: attachment; filename=' . $this->name . '_history.csv');
		header('Content-Transfer-Encoding: binary');
		
		$filters = array(
			'date_start'		=> (!empty($this->request->get['date_start'])) ? $this->request->get['date_start'] : '',
			'date_end'			=> (!empty($this->request->get['date_end'])) ? $this->request->get['date_end'] : '',
			'combine_searches'	=> (!empty($this->request->get['combine_searches'])) ? $this->request->get['combine_searches'] : '',
		);
		
		if (empty($filters['combine_searches'])) {
			$sql = "SELECT * FROM " . DB_PREFIX . $this->name . " WHERE TRUE";
			$columns = array('smart_search_id', 'date_added', 'search', 'phase', 'results', 'customer_id', 'ip');
		} else {
			$sql = "SELECT MIN(date_added) AS first_time, MAX(date_added) AS last_time, LCASE(search) AS search, ROUND(AVG(results),1) AS average_results, COUNT(*) AS times_searched FROM " . DB_PREFIX . $this->name . " WHERE TRUE";
			$columns = array('first_time', 'last_time', 'search', 'average_results', 'times_searched');
		}
		$sql .= (!empty($filters['date_start'])) ? " AND DATE(date_added) >= '" . $this->db->escape($filters['date_start']) . "'" : "";
		$sql .= (!empty($filters['date_end'])) ? " AND DATE(date_added) <= '" . $this->db->escape($filters['date_end']) . "'" : "";
		$sql .= (!empty($filters['combine_searches'])) ? " GROUP BY search ORDER BY times_searched DESC" : " ORDER BY date_added DESC";
		
		$searches = $this->db->query($sql)->rows;
		
		echo strtoupper('" ' . implode('"," ', $columns) . '"') . "\n";
		foreach ($searches as $search) {
			echo '"' . implode('","', str_replace('"', "''", $search)) . '"' . "\n";
		}
		
		exit();
	}
	
	public function deleteRecord() {
		if (!$this->user->hasPermission('modify', $this->type . '/' . $this->name)) {
			echo 'PermissionError';
			return;
		}
		
		if (!$this->request->post['combined']) {
			$this->db->query("DELETE FROM " . DB_PREFIX . $this->name . " WHERE smartsearch_id = " . (int)$this->request->post['key']);
		} else {
			$this->db->query("DELETE FROM " . DB_PREFIX . $this->name . " WHERE search = '" . $this->db->escape($this->request->post['key']) . "'");
		}
	}
}
?>