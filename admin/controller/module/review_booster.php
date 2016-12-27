<?php
include DIR_APPLICATION . '/view/javascript/ReviewBooster/compatibility.php';

class ControllerModuleReviewBooster extends CompatibilityAdmin {
	const MODULE_VERSION = "v2.7";

	private $error = array();
	private $fields = array(
		'status' => array('default' => '0', 'decode' => false, 'required' => true),
		'order_status' => array('default' => array(), 'decode' => false, 'required' => true),
		'new_order_status' => array('default' => '0', 'decode' => false, 'required' => false),
		'notify' => array('default' => '', 'decode' => false, 'required' => false),
		'exclude_customer_group' => array('default' => array(), 'decode' => false, 'required' => false),
		'day' => array('default' => '5', 'decode' => false, 'required' => true),
		'previous' => array('default' => '1', 'decode' => false, 'required' => false),
		'type' => array('default' => 'order', 'decode' => false, 'required' => true),
		'link_text' => array('default' => 'click here', 'decode' => false, 'required' => true),
		'coupon_status' => array('default' => '0', 'decode' => false, 'required' => false),
		'coupon_discount' => array('default' => '5', 'decode' => false, 'required' => false),
		'coupon_validity' => array('default' => '10', 'decode' => false, 'required' => false),
		'star' => array('default' => 'default', 'decode' => false, 'required' => false),
		'image_type' => array('default' => '0', 'decode' => false, 'required' => false),
		'noticed_status' => array('default' => '0', 'decode' => false, 'required' => false),
		'product_image_status' => array('default' => '0', 'decode' => false, 'required' => false),
		'product_image_width' => array('default' => '60', 'decode' => false, 'required' => false),
		'product_image_height' => array('default' => '60', 'decode' => false, 'required' => false),
		'product_limit' => array('default' => '', 'decode' => false, 'required' => false),
		'verified_buyer_status' => array('default' => '0', 'decode' => false, 'required' => false),
		'notice' => array('default' => array(), 'decode' => false, 'required' => false),
		'approve_review_status' => array('default' => '0', 'decode' => false, 'required' => false),
		'approve_review_rating' => array('default' => '4', 'decode' => false, 'required' => false),
		'apr_status' => array('default' => '0', 'decode' => false, 'required' => false),
		'apr_image_status' => array('default' => '0', 'decode' => false, 'required' => false),
		'email' => array('default' => array('subject' => 'V3JpdGUgcmV2aWV3IGZvciBvcmRlcnM=', 'description' => 'PHRpdGxlPjwvdGl0bGU+DQo8bWV0YSBodHRwLWVxdWl2PSJDb250ZW50LVR5cGUiIGNvbnRlbnQ9InRleHQvaHRtbDsgY2hhcnNldD1VVEYtOCI+DQo8bWV0YSBjb250ZW50PSJ3aWR0aD1kZXZpY2Utd2lkdGgsIGluaXRpYWwtc2NhbGU9MSwgbWF4aW11bS1zY2FsZT0xLCB1c2VyLXNjYWxhYmxlPTAiIG5hbWU9InZpZXdwb3J0Ij4NCjxzdHlsZSB0eXBlPSJ0ZXh0L2NzcyI+Ym9keSB7LXdlYmtpdC10ZXh0LXNpemUtYWRqdXN0Om5vbmU7IC1tcy10ZXh0LXNpemUtYWRqdXN0Om5vbmU7fWJvZHkge21hcmdpbjowOyBwYWRkaW5nOjA7fXRhYmxlIHtib3JkZXItc3BhY2luZzowOyBib3JkZXItY29sbGFwc2U6Y29sbGFwc2U7IG1zby10YWJsZS1sc3BhY2U6MHB0OyBtc28tdGFibGUtcnNwYWNlOjBwdDt9dGFibGUgdGQge2JvcmRlci1jb2xsYXBzZTpjb2xsYXBzZTt9aW1nIHtib3JkZXI6MDt9aHRtbCB7d2lkdGg6MTAwJTsgaGVpZ2h0OjEwMCU7fTwvc3R5bGU+DQo8dGFibGUgc3R5bGU9IndpZHRoOjEwMCU7IGJvcmRlcjowOyBtYXJnaW46MDsgcGFkZGluZzowOyBtYXJnaW4tdG9wOjMwcHg7IGZvbnQtZmFtaWx5OlZlcmRhbmE7Ij4NCgk8dGJvZHk+DQoJCTx0cj4NCgkJCTx0ZCBhbGlnbj0iY2VudGVyIj4NCgkJCQk8dGFibGUgc3R5bGU9IndpZHRoOjEwMCU7bWF4LXdpZHRoOjY4MHB4O21hcmdpbjowIGF1dG87Ym9yZGVyOjFweCBzb2xpZCAjZThlOGU4O21hcmdpbjowO3BhZGRpbmc6MDtsaW5lLWhlaWdodDoxLjg7Zm9udC1zaXplOjEuMGVtO2ZvbnQtZmFtaWx5OlZlcmRhbmE7Ij4NCgkJCQkJPHRib2R5Pg0KCQkJCQkJPHRyPg0KCQkJCQkJCTx0ZCBzdHlsZT0iYmFja2dyb3VuZDojMDE5MWFjO2NvbG9yOiNmZmZmZmY7IiBhbGlnbj0iY2VudGVyIj5BZGQgcmV2aWV3PC90ZD4NCgkJCQkJCTwvdHI+DQoJCQkJCQk8dHI+DQoJCQkJCQkJPHRkIGFsaWduPSJsZWZ0IiBzdHlsZT0iZm9udC1mYW1pbHk6aW5oZXJpdDsgcGFkZGluZzoxMHB4OyI+DQoJCQkJCQkJCTxwIHN0eWxlPSJjb2xvcjojYmJiYmJiO2ZvbnQtc2l6ZTowLjllbSI+SWYgdGhpcyBlbWFpbCBpcyBub3QgZGlzcGxheWluZyBjb3JyZWN0bHksIHBsZWFzZSB7bGlua308L3A+DQoJCQkJCQkJCTxwPjxzcGFuIHN0eWxlPSJmb250LWZhbWlseTogaW5oZXJpdDsgZm9udC1zaXplOiAxZW07IGxpbmUtaGVpZ2h0OiAxLjg7Ij5EZWFyIHtmaXJzdG5hbWV9IHtsYXN0bmFtZX0sPC9zcGFuPjwvcD4NCgkJCQkJCQkJPHA+VGhhbmsgeW91IGZvciByZWNlbnQgcHVyY2hhc2UgZnJvbSBvdXIgc3RvcmUuPGJyPkl04oCZcyBiZWVuIGEgY291cGxlIG9mIGRheXMvd2Vla3Mgc2luY2UgeW91IHBsYWNlcyB5b3VyIG9yZGVyIHdpdGggdXMgYW5kIHdlIHdlcmUgaG9waW5nIHlvdSB3b3VsZCBsZXQgdXMsIGFuZCBldmVyeW9uZSBlbHNlLCBrbm93IHdoYXQgeW91IGFyZSB0aGlua2luZyBvZiBvdXQgcHJvZHVjdHMge2xpc3R9PC9wPg0KCQkJCQkJCQk8cD57Zm9ybX08L3A+DQoJCQkJCQkJCTxwPktpbmQgUmVnYXJkcyw8YnI+bXlTdG9yZTwvcD4NCgkJCQkJCQk8L3RkPg0KCQkJCQkJPC90cj4NCgkJCQkJCTx0cj4NCgkJCQkJCQk8dGQgc3R5bGU9ImJhY2tncm91bmQ6IzAxOTFhYzsgaGVpZ2h0OjRweDsgZm9udC1zaXplOjFweCI+Jm5ic3A7PC90ZD4NCgkJCQkJCTwvdHI+DQoJCQkJCTwvdGJvZHk+DQoJCQkJPC90YWJsZT4NCgkJCTwvdGQ+DQoJCTwvdHI+DQoJPC90Ym9keT4NCjwvdGFibGU+'), 'decode' => true, 'required' => true),
		'license_key' => array('default' => '', 'decode' => false, 'required' => false),
		'license' => array('default' => '', 'decode' => false, 'required' => false)
	);

	public function index() {
		$this->install();

		$data = array_merge(array(), $this->language->load('module/review_booster'));

		$this->loadStyles('ReviewBooster');

		$this->document->setTitle($this->language->get('heading_title'));
		$data['heading_title'] = $this->language->get('heading_title') . ' ' . self::MODULE_VERSION;

		if (isset($this->request->get['filter_store_id'])) {
			$filter_store_id = (int)$this->request->get['filter_store_id'];
		} else {
			$filter_store_id = 0;
		}

		$url = '&filter_store_id=' . (int)$filter_store_id;

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateSetting()) {
			$this->editSetting('review_booster', $this->request->post['review_booster'], $filter_store_id);

			$this->session->data['success'] = $this->language->get('text_success');

			$this->redirectTo($this->link('module/review_booster', $url));
		}

 		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->error['error'])) {
			$data['error'] = $this->error['error'];
		} else {
			$data['error'] = array();
		}

		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];

			unset($this->session->data['success']);
		} else {
			$data['success'] = '';
		}

		$this->load->model('tool/image');

		$data['action'] = $this->link('module/review_booster', $url);

		if (version_compare(VERSION, '2.3') < 0) {
			$data['cancel'] = $this->link('extension/module');
		} else {
			$data['cancel'] = $this->link('extension/extension');
		}

		$config_store = $this->getSetting('review_booster', $filter_store_id);

		foreach ($this->fields as $key => $value) {
			if (isset($this->request->post['review_booster'][$key])) {
				$data[$key] = $this->request->post['review_booster'][$key];
			} elseif (isset($config_store[$key])) {
				$data[$key] = $config_store[$key];
			} else {
				if ($value['decode']) {
					if (is_array($value['default'])) {
						$_tmp = $value['default'];

						foreach ($_tmp as $key2 => $result) {
							$value['default'][$key2] = base64_decode($result);
						}
					} else {
						$value['default'] = base64_decode($value['default']);
					}
				}

				$data[$key] = $value['default'];
			}

			if (isset($value['image'])) {
				if ($data[$key] && is_file(DIR_IMAGE . $data[$key])) {
					$data[$key. '_thumb'] = $this->model_tool_image->resize($data[$key], 100, 100);
				} else {
					$data[$key. '_thumb'] = $this->model_tool_image->resize('no_image.png', 100, 100);
				}
			}
		}

		if (file_exists(DIR_IMAGE . 'no_image.jpg')) {
			$data['placeholder'] = $this->model_tool_image->resize('no_image.jpg', 100, 100);
		} else {
			$data['placeholder'] = $this->model_tool_image->resize('no_image.png', 100, 100);
		}

		$stores = $this->getStores('module/review_booster');

		$data['stores'] = $stores;

		if (isset($stores[$filter_store_id])) {
			$cron = (substr($stores[$filter_store_id]['url'], -1) == '/') ? $stores[$filter_store_id]['url'] : $stores[$filter_store_id]['url'] . '/';

			if ($this->isHttps()) {
				$data['cron'] = str_replace('http://', 'https://', $cron) . 'index.php?route=product/review_booster/cron&format=raw';
			} else {
				$data['cron'] = $cron . 'index.php?route=product/review_booster/cron&format=raw';
			}
		} else {
			$data['cron'] = '';
		}

		$this->load->model('localisation/order_status');

		$data['order_statuses'] = $this->model_localisation_order_status->getOrderStatuses();

		if (version_compare(VERSION, '2.1') < 0) {
			$this->load->model('sale/customer_group');

			$data['customer_groups'] = $this->model_sale_customer_group->getCustomerGroups();
		} else {
			$this->load->model('customer/customer_group');

			$data['customer_groups'] = $this->model_customer_customer_group->getCustomerGroups();
		}

		$data['stars'] = array('default' => 'Default', 'yellow' => 'Yellow', 'blue' => 'Blue', 'green' => 'Green', 'red' => 'Red');

		$data['ratings'] = range(1, 5);

		$data['languages'] = $this->getLanguages();

		$data['filter_store_id'] = $filter_store_id;

		$data['token'] = $this->session->data['token'];

		$this->toOutput('module/review_booster', $data);
	}

	public function history() {
		$data = array_merge(array(), $this->language->load('module/review_booster'));

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}

		if (isset($this->request->get['store_id'])) {
			$filter_store_id = (int)$this->request->get['store_id'];
		} else {
			$filter_store_id = 0;
		}

		$stores = $this->getStores('module/review_booster');

		$data['histories'] = array();

		$this->load->model('catalog/review_booster');

		$results = $this->model_catalog_review_booster->getEmailHistories($filter_store_id, ($page - 1) * 20, 20);

		foreach ($results as $result) {
			$products = array();

			if ($result['product_id']) {
				$products_info = $this->model_catalog_review_booster->getOrderProducts($result['order_id'], $result['product_id']);
			} else {
				$products_info = $this->model_catalog_review_booster->getOrderProducts($result['order_id']);
			}

			foreach ($products_info as $product) {
				$products[] = array('name' => $product['name']);
			}

			$coupon_info = $this->model_catalog_review_booster->getCoupon($result['coupon_id']);

			if ($coupon_info) {
				$coupon = sprintf($this->language->get('text_coupon'), $coupon_info['code'], date($this->language->get('date_format_short'), strtotime($coupon_info['date_end'])), $this->url->link('sale/order/info', 'token=' . $this->session->data['token'] . '&order_id=' . (int)$result['coupon_order_id'] , 'SSL'), (($result['date_used']) ? $result['date_used'] : 'N/A'));
			} else {
				$coupon = '<span class="label label-warning">' . $this->language->get('text_no_coupon') . '</span>';
			}

			if (isset($stores[$filter_store_id])) {
				$link = (substr($stores[$filter_store_id]['url'], -1) == '/') ? $stores[$filter_store_id]['url'] : $stores[$filter_store_id]['url'] . '/';

				$view = $link . 'index.php?route=product/review_booster&hash=' . $result['hash']. '&code=' . $result['code'];
			} else {
				$view = '';
			}

			if ($result['date_review'] != '0000-00-00 00:00:00') {
				$date_review = date($this->language->get('datetime_format'), strtotime($result['date_review']));
				$date_review .= $result['noticed'] ? '<br />' . $this->language->get('entry_noticed_status') . ': ' . $result['noticed'] : '';
			} else {
				$date_review = '<span class="label label-warning">' . $this->language->get('text_no_review') . '</span>';
			}

			$data['histories'][] = array(
				'email_id'    => $result['email_id'],
				'email'       => $result['email'],
				'date_added'  => date($this->language->get('date_format_short'), strtotime($result['date_added'])),
				'order_id'    => $result['order_id'],
				'product'     => $products,
				'coupon'      => $coupon,
				'date_review' => $date_review,
				'test'        => $result['test'] ? '<br /><span class="label label-primary">' . $this->language->get('text_test') . '</span>' : '',
				'view'        => $view
			);
		}

		$history_total = $this->model_catalog_review_booster->getTotalEmailHistories($filter_store_id);

		$pagination = new Pagination();
		$pagination->total = $history_total;
		$pagination->page = $page;
		$pagination->limit = 20;
		$pagination->url = $this->link('module/review_booster/history', 'store_id=' . (int)$filter_store_id . '&format=raw&page={page}');

		$data['pagination'] = $pagination->render();

		$data['results'] = $this->paginationText($page, 20, $history_total);

		$this->toOutput('module/review_booster/history_list', $data);
	}

	public function remove() {
		$this->load->language('module/review_booster');

		$json = array();

		if (!$this->user->hasPermission('modify', 'module/review_booster')) {
			$json['error'] = $this->language->get('error_permission');
		} else {
			if (isset($this->request->get['email_id'])) {
				$email_id = $this->request->get['email_id'];
			} else {
				$email_id = 0;
			}

			$this->load->model('catalog/review_booster');

			$email_info = $this->model_catalog_review_booster->getEmail($email_id);

			if ($email_info) {
				$this->model_catalog_review_booster->deleteEmail($email_id);
			}

			$json['success'] = $this->language->get('text_email_removed');
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	private function validateSetting() {
		if (!$this->user->hasPermission('modify', 'module/review_booster')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		if ($this->request->post['review_booster']) {
			foreach ($this->fields as $key => $value) {
				if ($value['required']) {
					if (isset($this->request->post['review_booster'][$key]) && is_array($this->request->post['review_booster'][$key])) {
						foreach ($this->request->post['review_booster'][$key] as $key2 => $setting) {
							if (is_array($setting)) {
								foreach ($setting as $key3 => $value2) {
									if (is_array($value2)) {
										foreach ($value2 as $value3) {
											if (!$value3) {
												$this->error['error'][$key] = $this->language->get('error_' . $key);
											}
										}
									} elseif (!isset($value2) || empty($value2)) {
										$this->error['error'][$key] = $this->language->get('error_' . $key);
									}
								}
							} elseif (!isset($setting) || $setting === null || $setting == '') {
								$this->error['error'][$key] = $this->language->get('error_' . $key);
							}
						}
					} elseif (!isset($this->request->post['review_booster'][$key]) || $this->request->post['review_booster'][$key] === null || $this->request->post['review_booster'][$key] == '') {
						$this->error['error'][$key] = $this->language->get('error_' . $key);
					}
				}
			}

			if (isset($this->error['error'])) {
				$this->error['warning'] = $this->language->get('error_required');
			}
		} else {
			$this->error['warning'] = $this->language->get('error_module');
		}

		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}

	public function install() {
		$this->load->model('catalog/review_booster');

		$this->model_catalog_review_booster->install();
	}

	public function uninstall() {
		$this->load->model('catalog/review_booster');

		$this->model_catalog_review_booster->uninstall();
	}
}
?>