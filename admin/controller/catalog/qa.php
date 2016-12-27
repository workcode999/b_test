<?php

if (version_compare(VERSION, '2.2.0', '>=')) {
	require_once(DIR_CATALOG . 'controller/startup/seo_url.php');
} else {
	require_once(DIR_CATALOG . 'controller/common/seo_url.php');
}

class ControllerCatalogQA extends Controller {
	protected $error = array();
	protected $alert = array(
		'error'     => array(),
		'warning'   => array(),
		'success'   => array(),
		'info'      => array()
	);

	private $columns = array(
		'selector'              => array('display' => 1, 'index' =>  0, 'align' => 'text-center', 'sort' => '',                         'class'=>          '', ),
		'id'                    => array('display' => 0, 'index' =>  1, 'align' =>   'text-left', 'sort' => 'q.qa_id',                  'class'=>          '', ),
		'product'               => array('display' => 1, 'index' =>  5, 'align' =>   'text-left', 'sort' => 'pd.name',                  'class'=>          '', ),
		'question_author_name'  => array('display' => 1, 'index' => 10, 'align' =>   'text-left', 'sort' => 'question_author_name',     'class'=>'visible-sm visible-md visible-lg', ),
		'question_author_email' => array('display' => 0, 'index' => 10, 'align' =>   'text-left', 'sort' => 'question_author_name',     'class'=>'visible-sm visible-md visible-lg', ),
		'question_author_phone' => array('display' => 0, 'index' => 10, 'align' =>   'text-left', 'sort' => 'question_author_name',     'class'=>'visible-sm visible-md visible-lg', ),
		'question_author_custom'=> array('display' => 0, 'index' => 10, 'align' =>   'text-left', 'sort' => 'question_author_name',     'class'=>'visible-sm visible-md visible-lg', ),
		'question'              => array('display' => 1, 'index' => 15, 'align' =>   'text-left', 'sort' => '',                         'class'=>           '', ),
		'answer'                => array('display' => 1, 'index' => 20, 'align' =>   'text-left', 'sort' => '',                         'class'=>'visible-md visible-lg', ),
		'answer_author_name'    => array('display' => 1, 'index' => 25, 'align' =>   'text-left', 'sort' => 'answer_author_name',       'class'=>'visible-xl', ),
		'language'              => array('display' => 0, 'index' => 30, 'align' =>   'text-left', 'sort' => 'l.name',                   'class'=>          '', ),
		'date_asked'            => array('display' => 1, 'index' => 35, 'align' =>   'text-left', 'sort' => 'date_asked',               'class'=>'visible-lg', ),
		'date_answered'         => array('display' => 1, 'index' => 40, 'align' =>   'text-left', 'sort' => 'date_answered',            'class'=>'visible-xl', ),
		'date_modified'         => array('display' => 0, 'index' => 45, 'align' =>   'text-left', 'sort' => 'date_modified',            'class'=>          '', ),
		'store'                 => array('display' => 0, 'index' => 50, 'align' =>   'text-left', 'sort' => '',                         'class'=>'visible-md visible-lg', ),
		'status'                => array('display' => 1, 'index' => 55, 'align' => 'text-center', 'sort' => 'status',                   'class'=>          '', ),
		'action'                => array('display' => 1, 'index' => 60, 'align' =>  'text-right', 'sort' => '',                         'class'=>          '', ),
	);

	public function __construct($registry) {
		parent::__construct($registry);
		$this->load->helper('qa');

		$this->load->language('catalog/qa');
		$this->load->model('catalog/qa');
	}

	public function index() {
		$this->getList();
	}

	public function delete() {
		$this->action('delete');
	}

	public function copy() {
		$this->action('copy');
	}

	public function add() {
		$this->action('add');
	}

	public function edit() {
		$this->action('edit');
	}

	public function autocomplete() {
		if ($this->request->server['REQUEST_METHOD'] == 'GET' && isset($this->request->get['type'])) {
			$resp = array();
			switch ($this->request->get['type']) {
				case 'product':
					$this->load->model('catalog/product');

					$results = array();

					if (isset($this->request->get['query'])) {
						$data = array(
							'filter_name'   => $this->request->get['query'],
							'sort'          => 'pd.name',
							'start'         => 0,
							'limit'         => 20,
						);

						$results = $this->model_catalog_product->getProducts($data);
					}

					foreach ($results as $result) {
						$result['name'] = html_entity_decode($result['name'], ENT_QUOTES, 'UTF-8');
						$resp[] = array(
							'value'     => $result['name'],
							'tokens'    => explode(' ', $result['name']),
							'id'        => $result['product_id'],
							'model'     => $result['model']
						);
					}
					break;
				case 'customer':
					if (version_compare(VERSION, '2.1.0', '<')) {
						$this->load->model('sale/customer');
					} else {
						$this->load->model('customer/customer');
					}

					$results = array();

					if (isset($this->request->get['query'])) {
						$data = array(
							'filter_name'   => $this->request->get['query'],
							'sort'          => 'name',
							'start'         => 0,
							'limit'         => 20,
						);

						if (version_compare(VERSION, '2.1.0', '<')) {
							$results = $this->model_sale_customer->getCustomers($data);
						} else {
							$results = $this->model_customer_customer->getCustomers($data);
						}
					}

					foreach ($results as $result) {
						$result['name'] = html_entity_decode($result['name'], ENT_QUOTES, 'UTF-8');
						$resp[] = array(
							'value'     => $result['name'],
							'tokens'    => explode(' ', $result['name']),
							'id'        => $result['customer_id'],
							'email'     => $result['email'],
							'phone'     => $result['telephone']
						);
					}
					break;
				default:
					break;
			}
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_enc($resp, JSON_UNESCAPED_SLASHES));
	}

	private function action($action) {
		$ajax_request = isset($this->request->server['HTTP_X_REQUESTED_WITH']) && !empty($this->request->server['HTTP_X_REQUESTED_WITH']) && strtolower($this->request->server['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest';

		$response = array('success' => false);

		switch ($action) {
			case 'delete':
			case 'copy':
				if ($this->request->server['REQUEST_METHOD'] == 'GET' && isset($this->request->get['qa_id'])) {
					$this->request->post['selected'] = array($this->request->get['qa_id']);
				}
				if (isset($this->request->post['selected'])) {
					$successful = array();
					$failed = array();
					foreach ((array)$this->request->post['selected'] as $qa_id) {
						switch ($action) {
							case 'copy':
								if ($this->validateAction($action, $qa_id)) {
									$result = $this->model_catalog_qa->copyQuestion($qa_id);
									if ($result) {
										$successful[] = $qa_id;
									} else {
										$failed[] = $qa_id;
									}
								}
								break;
							case 'delete':
								if ($this->validateAction($action, $qa_id)) {
									$this->model_catalog_qa->deleteQuestion($qa_id);
									$successful[] = $qa_id;
								} else {
									$failed[] = $qa_id;
								}
								break;
						}
					}

					if ($ajax_request) {
						if (count($successful)) {
							$response['success'] = true;
							$this->session->data['success'] = sprintf($this->language->get('text_success_' . $action), count($successful));
							$response['msg'] = sprintf($this->language->get('text_success_' . $action), count($successful));

						}
						if ($this->error && count($failed) < 5) {
							$this->alert['warning'] = array_merge($this->alert['warning'], $this->error);
						} else if (count($failed)) {
							$this->alert['warning']['failed'] = sprintf($this->language->get('text_failed_' . $action), count($failed));
						}
					} else {
						if (count($successful)) {
							$this->session->data['success'] = sprintf($this->language->get('text_success_' . $action), count($successful));
						}
						if ($this->error && count($failed) < 5) {
							$this->alert['warning'] = array_merge($this->alert['warning'], $this->error);
						} else if (count($failed)) {
							$this->alert['warning']['failed'] = sprintf($this->language->get('text_failed_' . $action), count($failed));
						}
					}
				} else {
					if ($ajax_request) {
						$response["error"] = true;
					}
				}

				if ($ajax_request) {
					$response = array_merge($response, array("errors" => $this->error), array("alerts" => $this->alert));

					$this->response->addHeader('Content-Type: application/json');
					$this->response->setOutput(json_enc($response, JSON_UNESCAPED_SLASHES));
					return;
				} else {
					$this->session->data['errors'] = $this->error;
					$this->session->data['alerts'] = $this->alert;

					$url = $this->urlParams();

					$this->response->redirect($this->url->link('catalog/qa', $url, true));
				}
				break;
			case 'add':
			case 'edit':
				if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm($this->request->post)) {
					$question_id = isset($this->request->get['qa_id']) ? $this->request->get['qa_id'] : '';
					switch ($action) {
						case 'add':
							$this->request->post['store_id'] = ((!isset($this->request->post['store_id']) || $this->request->post['store_id'] == '') && isset($this->request->post['question_stores'][0])) ? $this->request->post['question_stores'][0] : 0;

							$question_id = $this->model_catalog_qa->addQuestion($this->request->post);
							break;
						case 'edit':
							if ($question_id) {
								$this->model_catalog_qa->editQuestion($question_id, $this->request->post);
							}
							break;
					}

					$this->notify($question_id, $this->request->post);

					if ($ajax_request) {
						$response['success'] = true;

						if ($action == 'add') {
							$response['url'] = html_entity_decode($this->url->link('catalog/qa/edit', 'qa_id=' . $question_id . $this->urlParams(), true));
							$this->session->data['success'] = $this->language->get('text_success_' . $action);
						}

						$response['msg'] = $this->language->get('text_success_' . $action);

						$response = array_merge($response, array("errors" => $this->error), array("alerts" => $this->alert));

						$this->response->addHeader('Content-Type: application/json');
						$this->response->setOutput(json_enc($response, JSON_UNESCAPED_SLASHES));
						return;
					} else {
						$this->session->data['success'] = $this->language->get('text_success_' . $action);
						$this->session->data['errors'] = $this->error;
						$this->session->data['alerts'] = $this->alert;

						$url = $this->urlParams();

						$this->response->redirect($this->url->link('catalog/qa', $url, true));
					}
				}

				if ($ajax_request) {
					$response = array_merge(array("error" => true), array("errors" => $this->error), array("alerts" => $this->alert));

					$this->response->addHeader('Content-Type: application/json');
					$this->response->setOutput(json_enc($response, JSON_UNESCAPED_SLASHES));
					return;
				} else {
					$this->getForm();
				}
				break;
		}
	}

	protected function notify($question_id, $data) {
		if (isset($data['notify_customer']) && (int)$data['notify_customer'] && $data['question'] != "" && $data['answer'] != "" && $data['question_author_email'] != "") {
			if (version_compare(VERSION, '2.2.0', '>=')) {
				$l_query = $this->db->query("SELECT language_id, code FROM " . DB_PREFIX . "language WHERE language_id = '" . $data['language_id'] . "'");
				$language = new Language($l_query->row['code']);
				$language->load($l_query->row['code']);
				$language->load('mail/question_reply');
			} else if (version_compare(VERSION, '2.0.1', '<')) {
				$l_query = $this->db->query("SELECT language_id, filename, directory FROM " . DB_PREFIX . "language WHERE language_id = '" . $data['language_id'] . "'");
				$language = new Language($l_query->row['directory']);
				$language->load($l_query->row['filename']);
				$language->load('mail/question_reply');
			} elseif (version_compare(VERSION, '2.0.2', '>=')) {
				$l_query = $this->db->query("SELECT language_id, directory FROM " . DB_PREFIX . "language WHERE language_id = '" . $data['language_id'] . "'");
				$language = new Language($l_query->row['directory']);
				$language->load($l_query->row['directory']);
				$language->load('mail/question_reply');
			} else {
				$l_query = $this->db->query("SELECT language_id, directory FROM " . DB_PREFIX . "language WHERE language_id = '" . $data['language_id'] . "'");
				$language = new Language($l_query->row['directory']);
				$language->load('default');
				$language->load('mail/question_reply');
			}

			// Get product info
			$p_query = $this->db->query("SELECT p.model AS model, pd.name AS name FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) WHERE p.product_id = '" . (int)$data['product_id'] . "' AND pd.language_id = '" . $l_query->row['language_id'] . "'");

			$config = new Config();

			$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "setting WHERE store_id = '" . (int)$data['store_id'] . "'");

			foreach ($query->rows as $setting) {
				if (!$setting['serialized']) {
					$config->set($setting['key'], $setting['value']);
				} else {
					if (version_compare(VERSION, '2.1.0') < 0) {
						$config->set($setting['key'], unserialize($setting['value']));
					} else {
						$config->set($setting['key'], json_decode($setting['value'], true));
					}
				}
			}

			if ((int)$data['store_id'] == 0) {
				$config->set('config_url', HTTP_CATALOG);
				$config->set('config_ssl', HTTPS_CATALOG);
			}

			$url = new Url($config->get('config_url'), $config->get('config_secure') ? $config->get('config_ssl') : $config->get('config_url'));

			if (version_compare(VERSION, '2.2.0', '>=')) {
				// Hack to get seo URL for store front
				$current = $_SERVER['SCRIPT_NAME'];
				$_SERVER['SCRIPT_NAME'] =  str_replace($_SERVER['HTTP_HOST'], "", str_replace("https://", "", str_replace("http://", "", HTTP_CATALOG))) .'index.php';
				$product_link = $url->link('product/product', 'product_id=' . $data['product_id']);
				$_SERVER['SCRIPT_NAME'] = $current;
			} else {
				$product_link = $url->link('product/product', 'product_id=' . $data['product_id']);
			}

			if ($this->config->get('config_seo_url')) {
				if (version_compare(VERSION, '2.2.0', '>=')) {
					$seo_url = new ControllerStartupSeoUrl($this->registry);
				} else {
					$seo_url = new ControllerCommonSeoUrl($this->registry);
				}
				$product_link = $seo_url->rewrite($product_link);
			}

			$subject = sprintf($language->get('text_subject'), $config->get('config_name'));

			// HTML Mail
			$html_data['title'] = sprintf($language->get('text_subject'), html_entity_decode($config->get('config_name'), ENT_QUOTES, 'UTF-8'));

			$html_data['text_answered'] = sprintf($language->get('text_answered'), $product_link, $p_query->row['name']);
			$html_data['text_view'] = ((int)$data['status']) ? sprintf($language->get('text_view'), $product_link, $product_link) : '';
			$html_data['text_question_detail'] = $language->get('text_question_detail');
			$html_data['text_answer'] = $language->get('text_answer');
			$html_data['text_asked'] = sprintf($language->get('text_asked'), date($language->get('date_format_short'), strtotime($data['date_asked'])));
			$html_data['text_powered_by'] = $language->get('text_powered_by');
			$html_data['text_closing'] = $language->get('text_closing');
			$html_data['text_sender'] = sprintf($language->get('text_sender'), $config->get('config_name'));

			$html_data['store_name'] = $config->get('config_name');
			$html_data['store_url'] = $config->get('config_secure') ? $config->get('config_ssl') : $config->get('config_url');;
			$html_data['logo'] = $config->get('config_secure') ? $config->get('config_ssl') : $config->get('config_url') . 'image/' . $config->get('config_logo');
			$html_data['question'] = str_replace(array("\r\n", "\r", "\n"), '<br />', strip_tags($data['question']));
			$html_data['answer'] = str_replace(array("\r\n", "\r", "\n"), '<br />', html_entity_decode($data['answer'], ENT_QUOTES, 'UTF-8'));

			// Text Mail
			$text  = sprintf(strip_tags($language->get('text_answered')), $p_query->row['name']) . "\n";
			if ((int)$data['status']) {
				$text .= sprintf(strip_tags($language->get('text_view')), $product_link) . "\n\n";
			}
			$text .= sprintf($language->get('text_asked'), date($language->get('date_format_short'), strtotime($data['date_asked']))) . "\n";
			$text .= $data['question'] . "\n\n";
			$text .= $language->get('text_answer') . "\n" . strip_tags($data['answer']) . "\n\n";
			$text .= $language->get('text_closing') . "\n";
			$text .= sprintf($language->get('text_sender'), $config->get('config_name')) . "\n";

			if (version_compare(VERSION, '2.0.2', '>=')) {
				$mail = new Mail();
				$mail->protocol = $this->config->get('config_mail_protocol');
				$mail->parameter = $this->config->get('config_mail_parameter');
				if (version_compare(VERSION, '2.0.3', '>=')) {
					$mail->smtp_hostname = $this->config->get('config_mail_smtp_hostname');
				} else {
					$mail->smtp_hostname = $this->config->get('config_mail_smtp_host');
				}
				$mail->smtp_username = $this->config->get('config_mail_smtp_username');
				$mail->smtp_password = html_entity_decode($this->config->get('config_mail_smtp_password'), ENT_QUOTES, 'UTF-8');
				$mail->smtp_port = $this->config->get('config_mail_smtp_port');
				$mail->smtp_timeout = $this->config->get('config_mail_smtp_timeout');
			} else {
				$mail = new Mail($this->config->get('config_mail'));
			}
			$mail->setFrom($config->get('config_email'));
			$mail->setSender($config->get('config_name'));
			$mail->setSubject($subject);

			if (version_compare(VERSION, '2.2.0', '>=')) {
				$template = 'mail/question_reply';
			} else {
				$template = 'mail/question_reply.tpl';
			}

			$mail->setHtml($this->load->view($template, $html_data));
			$mail->setText(html_entity_decode($text, ENT_QUOTES, 'UTF-8'));

			$mail->setTo($data['question_author_email']);
			$mail->send();

			$this->model_catalog_qa->updateNotificationSent($question_id, 1);
		}
	}

	protected function getList() {
		if (isset($this->session->data['errors'])) {
			$this->error = array_merge($this->error, (array)$this->session->data['errors']);

			unset($this->session->data['errors']);
		}

		if (isset($this->session->data['alerts'])) {
			$this->alert = array_merge($this->alert, (array)$this->session->data['alerts']);

			unset($this->session->data['alerts']);
		}

		$this->document->addStyle('view/stylesheet/qa/css/custom.min.css');

		$this->document->addScript('view/javascript/qa/custom.min.js');

		$this->document->setTitle($this->language->get('heading_title'));

		$data['heading_title'] = $this->language->get('heading_title');
		$data['text_list'] = $this->language->get('text_list');
		$data['text_none'] = $this->language->get('text_none');
		$data['text_toggle_navigation'] = $this->language->get('text_toggle_navigation');
		$data['text_confirm_delete'] = $this->language->get('text_confirm_delete');
		$data['text_are_you_sure'] = $this->language->get('text_are_you_sure');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
		$data['text_filter'] = $this->language->get('text_filter');
		$data['text_search'] = $this->language->get('text_search');
		$data['text_clear_filter'] = $this->language->get('text_clear_filter');
		$data['text_clear_search'] = $this->language->get('text_clear_search');
		$data['text_autocomplete'] = $this->language->get('text_autocomplete');
		$data['text_anonymous'] = $this->language->get('text_anonymous');
		$data['text_no_results'] = $this->language->get('text_no_results');
		$data['text_all_languages'] = $this->language->get('text_all_languages');
		$data['text_display_language'] = $this->language->get('text_display_language');
		$data['error_ajax_request'] = $this->language->get('error_ajax_request');
		$data['text_no_records_found'] = $this->language->get('text_no_records_found');
		$data['text_copying'] = $this->language->get('text_copying');
		$data['text_deleting'] = $this->language->get('text_deleting');

		$data['button_add'] = $this->language->get('button_add');
		$data['button_copy'] = $this->language->get('button_copy');
		$data['button_cancel'] = $this->language->get('button_cancel');
		$data['button_delete'] = $this->language->get('button_delete');
		$data['button_edit'] = $this->language->get('button_edit');

		$data['alert_icon'] = function($type) {
			$icon = "";
			switch ($type) {
				case 'error':
					$icon = "fa-times-circle";
					break;
				case 'warning':
					$icon = "fa-exclamation-triangle";
					break;
				case 'success':
					$icon = "fa-check-circle";
					break;
				case 'info':
					$icon = "fa-info-circle";
					break;
				default:
					break;
			}
			return $icon;
		};

		$url = $this->urlParams();

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true),
			'active'    => false
		);

		$data['breadcrumbs'][] = array(
			'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('catalog/qa', 'token=' . $this->session->data['token'], true),
			'active'    => true
		);

		$data['add'] = $this->url->link('catalog/qa/add', $url, true);
		$data['copy'] = $this->url->link('catalog/qa/copy', $url, true);
		$data['delete'] = $this->url->link('catalog/qa/delete', $url, true);
		$data['filter'] = html_entity_decode($this->url->link('catalog/qa', 'token=' . $this->session->data['token'], true), ENT_QUOTES, 'UTF-8');
		$data['autocomplete'] = html_entity_decode($this->url->link('catalog/qa/autocomplete', 'token=' . $this->session->data['token'], true), ENT_QUOTES, 'UTF-8');
		$data['product'] = $this->url->link('catalog/product/edit', 'token=' . $this->session->data['token'] . '&product_id=', true);
		if (version_compare(VERSION, '2.1.0', '<')) {
			$data['customer'] = $this->url->link('sale/customer', 'token=' . $this->session->data['token'] . '&filter_name=', true);
		} else {
			$data['customer'] = $this->url->link('customer/customer', 'token=' . $this->session->data['token'] . '&filter_name=', true);
		}

		$this->load->model('setting/store');

		$multistore = $this->model_setting_store->getTotalStores();
		$data['multistore'] = $multistore;

		$this->load->model('localisation/language');

		$languages = $this->model_localisation_language->getLanguages();
		$data['languages'] = $languages;
		$data['multilingual'] = count($languages) > 1;

		$columns = $this->columns;
		$filters = array();

		foreach ($columns as $column => $attr) {
			$columns[$column]['name'] = $this->language->get('column_' . $column);

			if (isset($this->request->get['filter_' . $column])) {
				$filters[$column] = $this->request->get['filter_' . $column];
			}

			if ($column == 'store' && !$multistore) {
				unset($columns[$column]);
			}
		}

		uasort($columns, 'column_sort');

		if ($multistore) {
			$columns['store']['display'] = 1;
		}

		$columns = array_filter($columns, 'column_display');

		$displayed_columns = array_keys($columns);

		$data['columns'] = $columns;
		$data['typeahead'] = array();

		foreach (array('product') as $column) {
			if (in_array($column, $displayed_columns)) {
				$url = $this->urlParams(0, 0, 0, 0, 0);
				$data['typeahead'][$column] = array(
					'remote' => html_entity_decode($this->url->link('catalog/qa/autocomplete', 'type=' . $column . '&query=%QUERY' . $url, true))
				);
			}
		}

		if (in_array('store', $displayed_columns)) {
			$stores = $this->cache->get('store.all');

			if ($stores === false) {
				$_stores = $this->model_setting_store->getStores(array());

				$stores = array(
					'0' => array(
						'store_id'  => 0,
						'name'      => $this->config->get('config_name'),
						'url'       => HTTP_CATALOG
					)
				);

				foreach ($_stores as $store) {
					$stores[$store['store_id']] = array(
						'store_id'  => $store['store_id'],
						'name'      => $store['name'],
						'url'       => $store['url']
					);
				}

				$this->cache->set('store.all', $stores);
			}

			$data['stores'] = $stores;
		}

		if (isset($this->request->get['search'])) {
			$search = html_entity_decode($this->request->get['search'], ENT_QUOTES, 'UTF-8');
		} else {
			$search = '';
		}

		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'date_asked';
		}

		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
		} else {
			$order = 'DESC';
		}

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}

		$data['questions'] = array();

		$filter_data = array(
			'columns'   => $displayed_columns,
			'search'    => $search,
			'filter'    => $filters,
			'sort'      => $sort,
			'order'     => $order,
			'start'     => ($page - 1) * $this->config->get('config_limit_admin'),
			'limit'     => $this->config->get('config_limit_admin')
		);

		$results = $this->model_catalog_qa->getQuestions($filter_data);

		$filtered_total = $this->model_catalog_qa->getFilteredTotalQuestions();
		$total = $this->model_catalog_qa->getTotalQuestions();

		foreach ($results as $result) {
			$action = array();

			$action[] = array(
				'name'      => 'edit',
				'title'     => $this->language->get('text_edit'),
				'text'      => $this->language->get('text_edit_short'),
				'class'     => "btn-primary",
				'icon'      => 'pencil',
				'url'       => $this->url->link('catalog/qa/edit', 'qa_id=' . $result['qa_id'] . $this->urlParams(), true)
			);

			$question = array(
				'qa_id'                 => $result['qa_id'],
				'question_author_email' => $result['question_author_email'],
				'question_author_phone' => $result['question_author_phone'],
				'question_author_custom'=> $result['question_author_custom'],
				'customer_id'           => $result['customer_id'],
				'language_id'           => $result['language_id'],
				'selected'              => isset($this->request->post['selected']) && in_array($result['qa_id'], $this->request->post['selected']),
			);

			foreach ($displayed_columns as $column) {
				switch ($column) {
					case 'action':
						$value = $action;
						break;
					case 'product':
						$value = $result['product'];
						$question['product_id'] = $result['product_id'];
						break;
					case 'date_asked':
					case 'date_answered':
						if ($result[$column] != '0000-00-00 00:00:00') {
							$date = new DateTime($result[$column]);
							$value = $date->format('Y-m-d');
						} else {
							$value = '';
						}
						break;
					case 'date_modified':
						if ($result[$column] != '0000-00-00 00:00:00') {
							$date = new DateTime($result[$column]);
							$value = $date->format('Y-m-d H:i:s');
						} else {
							$value = '';
						}
						break;
					case 'store':
						$value = $result['stores'];
						break;
					case 'language':
						$value = $result['language_name'];
						break;
					case 'question':
					case 'answer':
						$value = (utf8_strlen(strip_tags(html_entity_decode($result[$column], ENT_QUOTES, 'UTF-8'))) > 50) ? mb_substr(strip_tags(html_entity_decode($result[$column], ENT_QUOTES, 'UTF-8')), 0, 50) . ' ...' : strip_tags(html_entity_decode($result[$column], ENT_QUOTES, 'UTF-8'));
						$question[$column . '_full'] = str_replace('"', '&quot;', html_entity_decode($result[$column], ENT_QUOTES, 'UTF-8'));
						break;
					case 'question_author_name':
						$value = $result[$column];
						$details = '';
						if ($result['question_author_email']) {
							$details .= "<tr><td>" . $this->language->get('entry_email') . "</td><td>" . htmlentities($result['question_author_email']) . "</td></tr>";
						}
						if ($result['question_author_phone']) {
							$details .= "<tr><td>" . $this->language->get('entry_phone') . "</td><td>" . htmlentities($result['question_author_phone']) . "</td></tr>";
						}
						if ($result['question_author_custom']) {
							$field_names = $this->config->get('qa_form_custom_field_name');
							$field_name = isset($field_names[$this->config->get('config_language_id')]) ? $field_names[$this->config->get('config_language_id')] : $this->language->get('entry_custom');
							$details .= "<tr><td>" . $field_name  . "</td><td>" . htmlentities($result['question_author_custom']) . "</td></tr>";
						}
						if ($details) {
							$details = "<table class='table-condensed details'>" . $details . '</table>';
						}
						$question['author_details'] = $details;
						$question['customer_name'] = $result['customer_name'];
						break;
					case 'status':
						$value = $result['status_text'];
						$question['status_class'] = (int)$result['status'] ? 'success' : 'danger';
						break;
					default:
						$value = isset($result[$column]) ? $result[$column] : '';
						break;
				}

				$question[$column] = $value;
			}

			$data['questions'][] = $question;
		}

		if (isset($this->error['warning'])) {
			$this->alert['warning']['warning'] = $this->error['warning'];
		}

		if (isset($this->error['error'])) {
			$this->alert['error']['error'] = $this->error['error'];
		}

		if (isset($this->session->data['success'])) {
			$this->alert['success']['success'] = $this->session->data['success'];

			unset($this->session->data['success']);
		}

		$data['token'] = $this->session->data['token'];

		$data['alerts'] = $this->alert;

		$data['sorts'] = array();

		foreach ($columns as $column => $attr) {
			if ($attr['sort']) {
				$data['sorts'][$column] = $this->url->link('catalog/qa', $this->urlParams(1, 1, $attr['sort'], $order == 'ASC' ? 'DESC' : 'ASC', '1'), true);
			} else {
				$data['sorts'][$column] = null;
			}
		}

		$limit = (int)$this->config->get('config_limit_admin');

		$pagination = new Pagination();
		$pagination->total = $filtered_total;
		$pagination->page = $page;
		$pagination->limit = $limit;
		$pagination->url = $this->url->link('catalog/qa', $this->urlParams(1, 1, 1, 1, '{page}'), true);
		$pagination->style = 'qa pagination';

		$data['pagination'] = $pagination->render_custom();

		$results_find = array(
			'{start}',
			'{end}',
			'{total}',
			'{pages}'
		);

		$results_replace = array(
			($filtered_total) ? (($page - 1) * $limit) + 1 : 0,
			((($page - 1) * $limit) > ($filtered_total - $limit)) ? $filtered_total : ((($page - 1) * $limit) + $limit),
			$filtered_total,
			$limit ? ceil($filtered_total / $limit) : 1
		);

		$data['results'] = str_replace($results_find, $results_replace, ($total != $filtered_total) ? $this->language->get('text_pagination') . ' ' . sprintf($this->language->get('text_filtered_from'), $total) : $this->language->get('text_pagination'));

		$data['search'] = $search;
		$data['filters'] = $filters;
		$data['sort'] = $sort;
		$data['order'] = $order;
		$data['page'] = $page;

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		if (version_compare(VERSION, '2.2.0', '>=')) {
			$template = 'catalog/qa_list';
		} else {
			$template = 'catalog/qa_list.tpl';
		}

		$this->response->setOutput($this->load->view($template, $data));
	}

	private function getForm() {
		$qa_id = isset($this->request->get['qa_id']) ? $this->request->get['qa_id'] : null;

		if (isset($this->session->data['errors'])) {
			$this->error = array_merge($this->error, (array)$this->session->data['errors']);

			unset($this->session->data['errors']);
		}

		if (isset($this->session->data['alerts'])) {
			$this->alert = array_merge($this->alert, (array)$this->session->data['alerts']);

			unset($this->session->data['alerts']);
		}

		$this->document->addStyle('view/stylesheet/qa/css/custom.min.css');

		$this->document->addScript('view/javascript/qa/custom.min.js');

		$this->document->setTitle($this->language->get('heading_title'));

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_form'] = is_null($qa_id) ? $this->language->get('text_add') : $this->language->get('text_edit');
		$data['text_toggle_navigation'] = $this->language->get('text_toggle_navigation');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
		$data['text_question'] = $this->language->get('text_question');
		$data['text_answer'] = $this->language->get('text_answer');
		$data['text_autocomplete'] = $this->language->get('text_autocomplete');
		$data['text_no_records_found'] = $this->language->get('text_no_records_found');
		$data['text_saving'] = $this->language->get('text_saving');
		$data['text_deleting'] = $this->language->get('text_deleting');
		$data['text_canceling'] = $this->language->get('text_canceling');

		$data['help_notify'] = $this->language->get('help_notify');

		$data['entry_id'] = $this->language->get('entry_id');
		$data['entry_product'] = $this->language->get('entry_product');
		$data['entry_language'] = $this->language->get('entry_language');
		$data['entry_author_name'] = $this->language->get('entry_author_name');
		$data['entry_customer'] = $this->language->get('entry_customer');
		$data['entry_email'] = $this->language->get('entry_email');
		$data['entry_phone'] = $this->language->get('entry_phone');
		$data['entry_custom'] = $this->language->get('entry_custom');
		$data['entry_question'] = $this->language->get('entry_question');
		$data['entry_answer'] = $this->language->get('entry_answer');
		$data['entry_status'] = $this->language->get('entry_status');
		$data['entry_date_asked'] = $this->language->get('entry_date_asked');
		$data['entry_date_answered'] = $this->language->get('entry_date_answered');
		$data['entry_date_modified'] = $this->language->get('entry_date_modified');
		$data['entry_stores'] = $this->language->get('entry_stores');
		$data['entry_notify'] = $this->language->get('entry_notify');
		$data['entry_update_date_answered'] = $this->language->get('entry_update_date_answered');

		$data['button_save'] = $this->language->get('button_save');
		$data['button_apply'] = $this->language->get('button_apply');
		$data['button_cancel'] = $this->language->get('button_cancel');
		$data['button_delete'] = $this->language->get('button_delete');

		$data['error_ajax_request'] = $this->language->get('error_ajax_request');
		$data['error_email'] = $this->language->get('error_email');

		$data['alert_icon'] = function($type) {
			$icon = "";
			switch ($type) {
				case 'error':
					$icon = "fa-times-circle";
					break;
				case 'warning':
					$icon = "fa-exclamation-triangle";
					break;
				case 'success':
					$icon = "fa-check-circle";
					break;
				case 'info':
					$icon = "fa-info-circle";
					break;
				default:
					break;
			}
			return $icon;
		};

		$url = $this->urlParams();

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true),
			'active'    => false
		);

		$data['breadcrumbs'][] = array(
			'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('catalog/qa', $url, true),
			'active'    => false
		);

		$data['breadcrumbs'][] = array(
			'text'      => $qa_id ? $this->language->get('text_edit') : $this->language->get('text_add'),
			'href'      => $this->url->link('catalog/qa/' . ($qa_id ? 'edit' : 'add'), ($qa_id ? 'qa_id=' . $qa_id : '') . $url, true),
			'active'    => true
		);

		$data['save'] = $this->url->link('catalog/qa/' . ($qa_id ? 'edit' : 'add'), ($qa_id ? 'qa_id=' . $qa_id : '') . $url, true);
		$data['delete'] = $this->url->link('catalog/qa/delete', ($qa_id ? 'qa_id=' . $qa_id : '') . $url, true);
		$data['cancel'] = $this->url->link('catalog/qa', $url, true);

		if ($qa_id) {
			$data['qa_id'] = $qa_id;
		} else {
			$data['qa_id'] = "";
		}

		if (version_compare(VERSION, '2.1.0', '<')) {
			$data['customer_link'] = $this->url->link('sale/customer', 'token=' . $this->session->data['token'] . '&filter_name=', true);
		} else {
			$data['customer_link'] = $this->url->link('customer/customer', 'token=' . $this->session->data['token'] . '&filter_name=', true);
		}

		$data['typeahead'] = array();

		foreach (array('product', 'customer') as $type) {
			$url = $this->urlParams(0, 0, 0, 0, 0);
			$data['typeahead'][$type] = array(
				'remote' => html_entity_decode($this->url->link('catalog/qa/autocomplete', 'type=' . $type . '&query=%QUERY' . $url, true))
			);
		}

		$this->load->model('localisation/language');

		$data['languages'] = $this->model_localisation_language->getLanguages();
		$data['languages'] = array_remap_key_to_id('language_id', $data['languages']);

		$stores = $this->cache->get('store.all');

		if ($stores === false) {
			$this->load->model('setting/store');

			$_stores = $this->model_setting_store->getStores(array());

			$stores = array(
				'0' => array(
					'store_id'  => 0,
					'name'      => $this->config->get('config_name'),
					'url'       => HTTP_CATALOG
				)
			);

			foreach ($_stores as $store) {
				$stores[$store['store_id']] = array(
					'store_id'  => $store['store_id'],
					'name'      => $store['name'],
					'url'       => $store['url']
				);
			}

			$this->cache->set('store.all', $stores);
		}

		$data['stores'] = $stores;
		$data['multistore'] = count($stores) > 1;

		if (isset($this->session->data['error'])) {
			$this->error = $this->session->data['error'];

			unset($this->session->data['error']);
		}

		if (isset($this->error['warning'])) {
			$this->alert['warning']['warning'] = $this->error['warning'];
		}

		if (isset($this->error['error'])) {
			$this->alert['error']['error'] = $this->error['error'];
		}

		if (isset($this->session->data['success'])) {
			$this->alert['success']['success'] = $this->session->data['success'];

			unset($this->session->data['success']);
		}

		if ($qa_id && $this->request->server['REQUEST_METHOD'] != 'POST') {
			$qa_info = $this->model_catalog_qa->getQuestion($qa_id);
			if (!$qa_info) {
				$this->response->redirect($this->url->link('catalog/qa', $url, true));
				return;
			}
		}

		$date = new DateTime();

		$form = array(
			'qa_id'                 => '',
			'product'               => '',
			'product_id'            => '',
			'customer_id'           => '',
			'customer_name'         => '',
			'language_id'           => $this->config->get('config_language_id'),
			'store_id'              => '',
			'question_author_name'  => '',
			'question_author_phone' => '',
			'question_author_email' => '',
			'question_author_custom'=> '',
			'question'              => '',
			'answer_author_name'    => '',
			'answer'                => '',
			'status'                => '0',
			'notified'              => '0',
			'date_asked'            => $date->format('Y-m-d H:i:s'),
			'date_answered'         => '',
			'date_modified'         => '',
			'update_date_answered'  => 0,
			'question_stores'       => $qa_id ? $this->model_catalog_qa->getQuestionStores($qa_id) : array(0),
		);

		foreach ($form as $key => $v) {
			if (isset($this->request->post[$key])) {
				$data[$key] = $this->request->post[$key];
			} else if (isset($qa_info[$key])) {
				$data[$key] = $qa_info[$key];
			} else {
				$data[$key] = $v;
			}

			if (in_array($key, array('date_asked', 'date_answered', 'date_modified'))) {
				if ($data[$key] != '0000-00-00 00:00:00') {
					$date = new DateTime($data[$key]);
					$formatted = $date->format('Y-m-d');
				} else {
					$formatted = "";
				}
				$data[$key . '_formatted'] = $formatted;
			}
		}

		$data['notify_customer'] = (int)$this->config->get("qa_question_reply_notification") && !(int)$data['notified'];

		if (!isset($this->request->post['update_date_answered'])) {
			$data['update_date_answered'] = $data['answer'] == '' || $data['date_answered'] == '0000-00-00 00:00:00';
		}

		$data['errors'] = $this->error;

		$data['token'] = $this->session->data['token'];

		$data['alerts'] = $this->alert;

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		if (version_compare(VERSION, '2.2.0', '>=')) {
			$template = 'catalog/qa_form';
		} else {
			$template = 'catalog/qa_form.tpl';
		}

		$this->response->setOutput($this->load->view($template, $data));
	}

	private function validateForm(&$data) {
		$errors = false;

		if (!$this->user->hasPermission('modify', 'catalog/qa')) {
			$errors = true;
			$this->alert['error']['permission'] = $this->language->get('error_permission');
		}

		if (!isset($data['product_id']) || $data['product_id'] == '') {
			$errors = true;
			$this->error['product'] = $this->language->get('error_product');
		} else {
			$this->load->model('catalog/product');

			$product = $this->model_catalog_product->getProduct($data['product_id']);

			if (!isset($product['product_id'])) {
				$errors = true;
				$data['product_id'] = '';
				$data['product'] = '';
				$this->error['product'] = $this->language->get('error_product');
			}
		}

		if (utf8_strlen($data['question_author_email']) > 0 && !validate_email(utf8_decode($data['question_author_email']))) {
			$errors = true;
			$this->error['question_author_email'] = $this->language->get('error_email');
		}

		if (utf8_strlen($data['question']) < 1) {
			$errors = true;
			$this->error['question'] = $this->language->get('error_question');
		}

		if ($errors) {
			$errors = true;
			$this->alert['warning']['warning'] = $this->language->get('error_warning');
		}

		return !$errors;
	}

	protected function validate() {
		$errors = false;

		if (!$this->user->hasPermission('modify', 'catalog/qa')) {
			$errors = true;
			$this->alert['error']['permission'] = $this->language->get('error_permission');
		}

		return !$errors;
	}

	protected function validateAction($action, $data) {
		$errors = !$this->validate();

		switch ($action) {
			case 'delete':
				break;
			default:
				break;
		}

		return !$errors;
	}

	protected function urlParams($search = true, $filters = true, $sort = true, $order = true, $page = true) {
		$url = '';

		if ($search) {
			if (is_string($search)) {
				$url .= '&search=' . urlencode($search);
			} else if (isset($this->request->get['search'])) {
				$url .= '&search=' . urlencode(html_entity_decode($this->request->get['search'], ENT_QUOTES, 'UTF-8'));
			}
		}

		if ($filters) {
			foreach($this->columns as $column => $attr) {
				if (isset($this->request->get['filter_' . $column])) {
					$url .= '&filter_' . $column . '=' . urlencode(html_entity_decode($this->request->get['filter_' . $column], ENT_QUOTES, 'UTF-8'));
				}
			}
		}

		if ($sort) {
			if (is_string($sort)) {
				$url .= '&sort=' . $sort;
			} else if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}
		}

		if ($order) {
			if (is_string($order)) {
				$url .= '&order=' . $order;
			} else if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}
		}

		if ($page) {
			if (is_string($page)) {
				$url .= '&page=' . $page;
			} else if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}
		}

		$url .= '&token=' . $this->session->data['token'];

		return $url;
	}
}
