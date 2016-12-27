<?php
class ControllerProductReviewBooster extends Controller {
	private $error = array();
	private $_url = false;
	private $i = 0;
	private $stars = array(
		'default' => array(
			1 => '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'
		),
		'yellow' => array(
			1 => 'iVBORw0KGgoAAAANSUhEUgAAAAoAAAAMCAYAAABbayygAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAATFJREFUeNpckM1Kw0AUhc/MxNQSG0jxb2VdCAVBwY0iii6MDyT4GG5c9klcCV3o2pXiUrAKpTSl2DRxkkk8KVbGDgz3zv37zlxRliXs078R5zRi47rs2nEHC0fV0IFEQvfAjsuFaafSRYvFbfpHdk5UaAYV/TXloruyhXZZAPEnnkyKkBKiWeHgFm8QEEIgWPJQ81twq8KvD+h8irg0iITEqNLY8FbRrDd/GRm7afxNuDRuEiGY9DGRRuMkGaL3XQH0/1vFWPhe5Nifa9zh+Nf1bSj7A8Meklzjkjof5+vxHQcpsZ4xRJMtuQ8pkDM3sve45yh40zFxKQaEOMt1BEqhwdwu78tsj0oizDR0EuNOa5xlGQ7p37PJkHT8N9EUuKLpUMuDJTGk9ouiwHP1+BFgALoMd0L+IWEjAAAAAElFTkSuQmCC',
			'iVBORw0KGgoAAAANSUhEUgAAABsAAAAMCAYAAACTB8Z2AAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAXlJREFUeNqcUz1LA0EQfbt7XgxnAglRU4ixEAKCgo0iBi2M/0jwR2hj6S+xUlJobScWFuIXhpgEMcnFvbuc78RADDluycKww+zMe/tmdkUYhhhd9VOxz00sHoU1TLniMKzxRJXCOSRcupvTksVhyLEbVaSNEpPL9LenVBWLIaI2MqjozysbtblllMMB0H3DbdBHla1oGZIkYojGGR4hIIRAbsZBKluCHSV+vUL7PXTDAC0h0fZ6OGbR1QSSJRJcm2BEM8s4BeTT+b9qjzfgli3C5ma7LeQ6dXToP8SI6ptiyEBj123i5TsSqv9bFGPi88DHBlU9TWJi/MMUYzizVcq8X1iBGgVqvsD1NQ4JeGMws0SM4dPPWhbb4cEJAraAPZB8p1LA51nb8CEmYgzJ1i0Fp/dJ2X00KNaaTSOnFDI8W6PdGZAlYvz+MyVR9TS028WF1tjzPGzRv2RRwNvuGH1kE4xoZu8nKNAqkT9qjB3QiuPxSWaC8SPAAGmhIlVj4bMaAAAAAElFTkSuQmCC',
			'iVBORw0KGgoAAAANSUhEUgAAACwAAAAMCAYAAAAZKF83AAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAYJJREFUeNq8VE1LQkEUPTPzeiamoPS1iGwRCEFBmyKKWmQ/KAj6E21a+ktaFS5s3apo0SLKAjGVSH0276vzJMHE4CE4A8O9zNx7zptz77siDEMMr9qFOKIRS2dhGROuaWJYo4EqgRIkHLrbk5JNE0OOvOpA2sgzuEB/d0JlpoohopbgoaK/oGyU51ZRCAOg8447v4ciS9KMSWIEQ9Qv8QwBIQSyMykkMnnYUeDXG7TXRSf00RQSLbeLcybdjCFZIUHFFEbUw+nUPHLJ3G+2y1fQZJZh09hOE9l2DW36T/8I0zOJIX2NfaeB6nckuP67ozMGvgYetqjMyzgmnn+YxBj08DrlflxcgxoGalTheBonBLyN0X9GMAZjLWNZLIuLlO+zFKyF5PyQAh7vWjF/biMYgw/etBRS3U/K30OdoluzSWSVQpp3G9wPMciMYPTnsJIouhra6eBKaxy6LnboXzPJ54v3Yg16Qxh9hf0ApzQl9khlKL/InjoOAtzHITOF8SPAADsfanuz4qDLAAAAAElFTkSuQmCC',
			'iVBORw0KGgoAAAANSUhEUgAAAD0AAAAMCAYAAADRRLXhAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAYZJREFUeNrUVk1LQkEUPTPzeiamoPS1iGwRCEFBmyKKWmQ/KAj6E21a+ktaFS5s3apo0SLKAjGVSH0276vzJMHE4OHKGRju5c695/Dux8wTYRhieNUuxBGFWDoLy5hwTTuGNeqoEihBwqG6PSnZtGPIkcwcSBt5Oheo706Y3anHEFF706ioLygb5blVFMIA6Lzjzu+hyNZoxiQxBkPUL/EMASEEsjMpJDJ52JHj1xu010Un9NEUEi23i3MG3YwhWSFBxSSMaKbTqXnkkrnfaJeZoMgsw6awnSay7Rra1J/+SW7PNAzpa+w7DVS/o8Lrvzuy0fE18LDF7L6MY6L9wzSMwUyvs+yPi2tQw0CNKhxP44SAtzFmyRiMwZOVsSy2h4uU77Ml2BOS97oU8HjWinlhGoMx+OhNSyHV/WQb9FBn8a3ZJLJKIc2zDe6HGGTGYPTfaSVRdDW008GV1jh0XexQv2aQz6ztxfoRMAijX2k/wClFif1eGYovcj6OgwD3cchMwvgRYABKg+QQIZlH7wAAAABJRU5ErkJggg==',
			'iVBORw0KGgoAAAANSUhEUgAAAE4AAAAMCAYAAADMOot6AAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAYZJREFUeNrkVk1LQkEUPTPzeiYvBaWvRWSLQAgK2hRR1CL7QUHQn2jT0l/SqnBh61ZFixZRFoipROqzeV+dJwkmBg+3MzDcy8y958CdMzNXRFGE0VG/EEc0YuksqmDKYQKGNR6oUihDwqW7PS2ZCRhyrLoH0kaBwUX6u1OekBEYIr6qXFT0F5SNytwqilEIdN9xF/RRokRbCUmMwhCNSzxDQAiB3IyDVLYAOw78eoP2e+hGAVpCou31cM6kmwkkKySomoYRv3EZZx75dP4322M1abLLsGlst4Vcp44O/ad/DqhvIoYMNPbdJmrfsQD13xmvMfA19LHFE3qZxMT1DxMxhm/cOuX3uLgGNQrUrMH1NU4IeJvgXTAKY9iOZC2LMvXgBAGlSW1K/rdSwOdeO+EnZBTGsHCbloLT+6Qc+2hQhNZsGjmlkOHeBudDAjKjMAZ9nJIoeRra7eJKaxx6HnboXzMpYOX3EjWKhmEMFBeEOKUp8+5WR/JLvOvHYYj7JGSmYfwIMADjyV200uzanAAAAABJRU5ErkJggg=='
		),
		'blue' => array(
			1 => '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'
		),
		'green' => array(
			1 => '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'
		),
		'red' => array(
			1 => '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'
		)
	);

	public function cron() {
		header('Access-Control-Allow-Origin: *');

		$this->load->model('catalog/review_booster');

		$orders = array();
		$test = false;
		$no_image = (version_compare(VERSION, '2.0') < 0) ? 'no_image.jpg' : 'no_image.png';

		//manual
		if ($this->request->server['REQUEST_METHOD'] == 'POST') {
			if (isset($this->request->post['order_id'])) {
				$filter_data = array(
					'filter_order_status'           => null,
					'filter_customer_group_exclude' => null,
					'filter_store'                  => $this->config->get('config_store_id'),
					'filter_after_day'              => null,
					'filter_order_id'               => $this->request->post['order_id'],
					'limit'                         => 1
				);

				$orders = $this->model_catalog_review_booster->getOrders($filter_data);
			}
		} else {
			//test message
			if (isset($this->request->get['test']) && $this->request->get['test'] == 1 && isset($this->request->get['email'])) {
				$filter_data = array(
					'filter_order_status'           => null,
					'filter_customer_group_exclude' => null,
					'filter_store'                  => $this->config->get('config_store_id'),
					'filter_after_day'              => null,
					'filter_order_id'               => null,
					'limit'                         => 1
				);

				$test = true;
			} else {//cron
				$filter_data = array(
					'filter_order_status'           => $this->config->get('review_booster_order_status') ? $this->config->get('review_booster_order_status') : null,
					'filter_customer_group_exclude' => $this->config->get('review_booster_exclude_customer_group') ? $this->config->get('review_booster_exclude_customer_group') : null,
					'filter_store'                  => $this->config->get('config_store_id'),
					'filter_after_day'              => $this->config->get('review_booster_day'),
					'filter_order_id'               => null,
					'limit'                         => 20
				);
			}

			$orders = $this->model_catalog_review_booster->getOrders($filter_data);
		}

		if ($orders) {
			$this->load->model('tool/image');

			$this->i = 0;

			foreach ($orders as $order_info) {
				if (!$this->config->get('review_booster_status')) {
					echo'Module disabled for ' . $order_info['store_name'] . ' store!';

					exit();
				}

				if ($test) {
					$order_info['email'] = $this->request->get['email'];
				}

				$order_info['email'] = trim($order_info['email']);

				if (!$order_info['email']) {
					continue;
				}

				if (!$order_info['store_url']) {
					$order_info['store_url'] = HTTP_SERVER;
				}

				if (substr($order_info['store_url'], -1) != '/') {
					$order_info['store_url'] .= '/';
				}

				if (!preg_match('#^http#i', $order_info['store_url'])) {
					$order_info['store_url'] = 'http://' . $order_info['store_url'];
				}

				$this->_url = new Url($order_info['store_url'], $order_info['store_url']);

				$results = $this->model_catalog_review_booster->getOrderProducts($order_info['order_id'], 0, $this->config->get('review_booster_product_limit'));

				if ($results) {
					if ($this->config->get('review_booster_type') == 'product') {
						foreach ($results as $product) {
							$products = array();

							if ($product['image']) {
								$image = $this->model_tool_image->resize($product['image'], $this->config->get('review_booster_product_image_width'), $this->config->get('review_booster_product_image_height'));
							} else {
								$image = $this->model_tool_image->resize($no_image, $this->config->get('review_booster_product_image_width'), $this->config->get('review_booster_product_image_height'));
							}

							$products[$product['product_id']] = array(
								'image' => $image,
								'name'  => $product['name'],
								'href'  => $this->_url->link('product/product', 'product_id=' . (int)$product['product_id'], 'NONSSL')
							);

							$this->send($order_info, $products, $test, $product['product_id']);
						}
					} else {
						$products = array();

						foreach ($results as $product) {
							if ($product['image']) {
								$image = $this->model_tool_image->resize($product['image'], $this->config->get('review_booster_product_image_width'), $this->config->get('review_booster_product_image_height'));
							} else {
								$image = $this->model_tool_image->resize($no_image, $this->config->get('review_booster_product_image_width'), $this->config->get('review_booster_product_image_height'));
							}

							$products[$product['product_id']] = array(
								'image' => $image,
								'name'  => $product['name'],
								'href'  => $this->_url->link('product/product', 'product_id=' . (int)$product['product_id'], 'NONSSL')
							);
						}

						$this->send($order_info, $products, $test);
					}

					if (!$test && $this->config->get('review_booster_new_order_status')) {
						$this->changeOrderStatus($order_info['order_id'], $this->config->get('review_booster_new_order_status'), '', ($this->config->get('review_booster_notify') ? true : false));
					}
				}
			}

			echo"Success! Sent notifications: " . $this->i;

			exit();
		} else {
			echo'No orders to send notifications!';

			exit();
		}
	}

	public function index() {
		$this->language->load('product/review_booster');

		$this->load->model('catalog/review_booster');

		$this->load->model('tool/image');

		$data['success'] = '';

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home'),
			'separator' => false
		);

		if (isset($this->request->get['hash'])) {
			$hash = $this->request->get['hash'];
		} else {
			$hash = 0;
		}

		if (isset($this->request->get['code'])) {
			$code = $this->request->get['code'];
		} else {
			$code = 0;
		}

		$review_info = $this->model_catalog_review_booster->getEmail($hash, $code);

		if ($review_info) {
			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('heading_title'),
				'href' => $this->url->link('product/review_booster', 'hash=' .  $hash . '&code=' . $code),
				'separator' => ' &raquo; '
			);

			$notices = $this->config->get('review_booster_notice') ? (array)$this->config->get('review_booster_notice') : array();

			$data['notices'] = array();

			foreach ($notices as $row) {
				$noticed_hash = hash('md5', $row);

				$data['notices'][$noticed_hash] = $row;
			}

			$products = array();

			$results = $this->model_catalog_review_booster->getOrderProducts($review_info['order_id'], $review_info['product_id'], $review_info['product_limit']);

			foreach ($results as $product) {
				if ($product['image']) {
					$image = $this->model_tool_image->resize($product['image'], $this->config->get('review_booster_product_image_width'), $this->config->get('review_booster_product_image_height'));
				} else {
					$image = $this->model_tool_image->resize($no_image, $this->config->get('review_booster_product_image_width'), $this->config->get('review_booster_product_image_height'));
				}

				$products[] = array(
					'product_id' => $product['product_id'],
					'image'      => $image,
					'name'       => $product['name'],
					'href'       => $this->url->link('product/product', 'product_id=' . (int)$product['product_id'], 'NONSSL')
				);
			}

			if (isset($this->request->get['review'])) {
				$this->request->post['review'] = $this->request->get['review'];
				$this->request->server['REQUEST_METHOD'] = 'POST';
			}

			if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
				if ($products) {
					foreach ($this->request->post['review'] as $product_id => $review) {
						$this->request->post['author'] = $review_info['client'];
						$this->request->post['store_id'] = $review_info['store_id'];
						$this->request->post['rating'] = $review['rating'];
						$this->request->post['text'] = $review['text'];
						$this->request->post['review_images'] = isset($review['review_images']) ? $review['review_images'] : array();

						if ($product_id == 'all') {
							foreach ($products as $product) {
								$date_review = $this->model_catalog_review_booster->addReview($product['product_id'], $this->request->post, $this->config->get('review_booster_approve_review_status'), $this->config->get('review_booster_approve_review_rating'));
							}
						} else {
							$date_review = $this->model_catalog_review_booster->addReview($product_id, $this->request->post, $this->config->get('review_booster_approve_review_status'), $this->config->get('review_booster_approve_review_rating'));
						}

						if ($this->config->get('review_booster_noticed_status') && isset($review['noticed']) && isset($data['notices'][$review['noticed']])) {
							$this->db->query("UPDATE `" . DB_PREFIX . "rb_email` SET noticed = '" . $this->db->escape($data['notices'][$review['noticed']]) . "' WHERE email_id = '" . (int)$review_info['email_id'] . "'");
						}
					}

					if ($this->config->get('review_booster_coupon_status') && !$review_info['coupon_id']) {
						$date_start = date("Y-m-d H:i:s");

						$coupon_info = array(
							'name'       => 'Review Booster #'. $review_info['email_id'],
							'discount'   => $this->config->get('review_booster_coupon_discount'),
							'type'       => $this->config->get('review_booster_coupon_status') == 'fixed' ? 'F' : 'P',
							'date_start' => $date_start,
							'date_end'   => date("Y-m-d H:i:s", strtotime("+" . (int)$this->config->get('review_booster_coupon_validity') . " days", strtotime($date_start))),
						);

						$review_info['coupon_id'] = $this->model_catalog_review_booster->addCoupon($coupon_info);
					}

					$this->model_catalog_review_booster->updateEmail($review_info['email_id'], $date_review, $review_info['coupon_id']);

					if (version_compare(VERSION, '2.0') < 0) {
						$this->redirect($this->url->link('product/review_booster', 'hash=' .  $hash . '&code=' . $code, 'NONSSL'));
					} else {
						$this->response->redirect($this->url->link('product/review_booster', 'hash=' .  $hash . '&code=' . $code, 'NONSSL'));
					}
				}
			}

			if ($review_info['date_review'] != '0000-00-00 00:00:00') {
				$coupon_info = $this->model_catalog_review_booster->getCoupon($review_info['coupon_id']);

				if ($coupon_info) {
					$discount = ($coupon_info['type'] == 'F') ? $this->currency->format($coupon_info['discount']) : (int)$coupon_info['discount'] . '%';

					$data['success'] = sprintf($this->language->get('text_success_coupon'), $coupon_info['code'], $discount, date($this->language->get('date_format_short'), strtotime($coupon_info['date_end'])));
				} else {
					$data['success'] = $this->language->get('text_success');
				}

				$data['heading_title'] = $this->language->get('heading_title_added');

				$data['button_continue'] = $this->language->get('button_continue');

				$data['continue'] = $this->url->link('common/home');
			} else {
				$this->load->model('catalog/review');

				$data['ratings'] = array();

				if ($this->config->get('review_booster_apr_status') && method_exists($this->model_catalog_review, 'getRatings')) {
					$data['ratings'] = $this->model_catalog_review->getRatings();

					if (!$data['ratings']) {
						$data['ratings'] = array();
					}
				}

				$data['action'] = $this->url->link('product/review_booster', 'hash=' .  $hash . '&code=' . $code);

				$data['heading_title'] = $this->language->get('heading_title');

				$data['text_description'] = $this->language->get('text_description');
				$data['text_product'] = $this->language->get('text_product');

				$data['entry_rating'] = $this->language->get('entry_rating');
				$data['entry_review'] = $this->language->get('entry_review');
				$data['entry_noticed'] = $this->language->get('entry_noticed');
				$data['entry_review_image'] = $this->language->get('entry_review_image');

				$data['button_submit'] = $this->language->get('button_submit');
				$data['button_upload'] = $this->language->get('button_upload');

				if (isset($this->error['rating'])) {
					$data['error_rating'] = $this->error['rating'];
				} else {
					$data['error_rating'] = array();
				}

				if (isset($this->error['review'])) {
					$data['error_review'] = $this->error['review'];
				} else {
					$data['error_review'] = array();
				}

				if (isset($this->request->post['review'])) {
					$data['review'] = $this->request->post['review'];
					$data['images'] = array();

					$this->load->model('tool/image');

					foreach ($this->request->post['review'] as $product_id => $review) {
						if (isset($review['review_images'])) {
							foreach ($review['review_images'] as $image) {
								if (isset($image) && is_file(DIR_IMAGE . 'product_review/review/' . $image)) {
									$thumb = $this->model_tool_image->resize('product_review/review/' . $image, 40, 40);


									$data['images'][$product_id][] = array(
										'image' => $image,
										'thumb' => $thumb
									);
								}
							}
						}
					}
				} else {
					$data['review'] = array();
					$data['images'] = array();
				}

				$data['products'] = $products;

				$data['stars'] = $this->stars;
			}

			$data['objConfig'] = $this->config;

			if (version_compare(VERSION, '2.0') < 0) {
				$this->toOutput('product/review_booster15x', $data);
			} else {
				$this->toOutput('product/review_booster', $data);
			}
		} else {
			$this->document->setTitle($this->language->get('text_error'));

			$data['heading_title'] = $this->language->get('text_error');

			$data['text_error'] = $this->language->get('text_error');

			$data['button_continue'] = $this->language->get('button_continue');

			$data['continue'] = $this->url->link('common/home');

			$this->toOutput('error/not_found', $data);
		}
	}

	private function send($order_info, $products, $test = false, $product_id = 0) {
		$this->language->load('product/review_booster');

		$hash = strtolower(md5($this->i . '_A' . uniqid(time(), true) . '_' . $order_info['order_id'] . $order_info['email'] . time()));
		$code = substr(hash('sha256', $hash), 0, 10);

		$link = $this->_url->link('product/review_booster', 'hash=' . $hash . '&code=' . $code, 'NONSSL');
		$link_text = $this->config->get('review_booster_link_text');

		$form = '<!--[if mso]><!-- -->';
		$form .= $this->language->get('text_outlook') . "\n";
		$form .= '<a href="' . $link . '" align="center">' . $link . '</a>' . "\n";
		$form .= '<!--<![endif]-->';
		$form .= '<!--[if !mso]><!-- -->';

		if ($this->config->get('review_booster_type') == 'product_single') {
			$i = 0;
			$count = count($products);

			foreach ($products as $key => $product) {
				++$i;

				$form .= $this->getFormReview($order_info, $link, ($i == $count ? true : false), $key, $product);
			}
		} else {
			$form .= $this->getFormReview($order_info, $link, true, 'all');
		}

		$form .= '<!--<![endif]-->';

		if ($this->config->get('review_booster_product_image_status') && $this->config->get('review_booster_type') != 'product_single') {
			$product_list = '<table border="0" cellpadding="0" cellspacing="0" style="width:100%;margin:0;padding:0;border-collapse:collapse;mso-table-lspace:0pt;mso-table-rspace:0pt">' . "\n";

			foreach ($products as $product) {
				$product_list .= '<tr>' . "\n";
				$product_list .= '  <td valign="middle" style="padding: 2px;">' . "\n";
				$product_list .= '    <img src="' . $product['image'] . '" border="0" style="vertical-align:middle;border:1px solid #dddddd;margin-left:10px;margin-right:10px;" />' . "\n";
				$product_list .= '    <a href="' . $product['href'] . '">' . $product['name'] . '</a>' . "\n";
				$product_list .= '  </td>' . "\n";
				$product_list .= '</tr>' . "\n";
			}

			$product_list .= '</table>' . "\n";
		} else {
			$product_list = implode(', ', array_map(function($product) { return '<a href="' . $product['href'] . '">' . $product['name'] . '</a>'; }, $products));
		}

		$find = array(
			'{firstname}',
			'{lastname}',
			'{order_id}',
			'{email}',
			'{date_order}',
			'{store_name}',
			'{list}',
			'{form}',
			'{link}',
		);

		$replace = array(
			'firstname'   => $order_info['firstname'],
			'lastname'    => $order_info['lastname'],
			'order_id'    => $order_info['order_id'],
			'email'       => $order_info['email'],
			'date_order'  => date($this->language->get('date_format_short'), strtotime($order_info['date_added'])),
			'store_name'  => $order_info['store_name'],
			'list'        => $product_list,
			'form'        => '<form action="' . $order_info['store_url'] . '" method="get" accept-charset="UTF-8" target="_blank" id="form-review" style="border:0;margin:0;padding:0;"><input type="hidden" name="route" value="product/review_booster"><input type="hidden" name="hash" value="' . $hash . '"><input type="hidden" name="code" value="' . $code . '">' . $form . '</form>',
			'link'        => '<a href="' . $link . '">' . (isset($link_text[$order_info['language_id']]) ? $link_text[$order_info['language_id']] : $link) . '</a>'
		);

		$message = '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"><html>' . "\n";
		$message .= '<html xmlns="http://www.w3.org/1999/xhtml">' . "\n";

		$template = $this->config->get('review_booster_email');

		if (isset($template[$order_info['language_id']]) && $template[$order_info['language_id']]) {
			$subject = str_replace($find, $replace, $template[$order_info['language_id']]['subject']);
			$message .= str_replace($find, $replace, html_entity_decode($template[$order_info['language_id']]['description'], ENT_QUOTES, 'UTF-8'));
		} else {
			$subject = str_replace($find, $replace, $template[(int)$this->config->get('config_language_id')]['subject']);
			$message .= str_replace($find, $replace, html_entity_decode($template[(int)$this->config->get('config_language_id')]['description'], ENT_QUOTES, 'UTF-8'));
		}

		$message .= '</html>';

		if (version_compare(VERSION, '2.0') < 0) {
			$reviewBoosterMail = new Mail();
			$reviewBoosterMail->protocol = $this->config->get('config_mail_protocol');
			$reviewBoosterMail->parameter = $this->config->get('config_mail_parameter');
			$reviewBoosterMail->hostname = $this->config->get('config_smtp_host');
			$reviewBoosterMail->username = $this->config->get('config_smtp_username');
			$reviewBoosterMail->password = html_entity_decode($this->config->get('config_smtp_password'), ENT_QUOTES, 'UTF-8');
			$reviewBoosterMail->port = $this->config->get('config_smtp_port');
			$reviewBoosterMail->timeout = $this->config->get('config_smtp_timeout');
		} elseif (version_compare(VERSION, '2.0.2') < 0) {
			$reviewBoosterMail = new Mail($this->config->get('config_mail'));
		} else {
			$reviewBoosterMail = new Mail();
			$reviewBoosterMail->protocol = $this->config->get('config_mail_protocol');
			$reviewBoosterMail->parameter = $this->config->get('config_mail_parameter');
			$reviewBoosterMail->smtp_hostname = $this->config->get('config_mail_smtp_host') !== null ? $this->config->get('config_mail_smtp_host') : $this->config->get('config_mail_smtp_hostname');
			$reviewBoosterMail->smtp_username = $this->config->get('config_mail_smtp_username');
			$reviewBoosterMail->smtp_password = html_entity_decode($this->config->get('config_mail_smtp_password'), ENT_QUOTES, 'UTF-8');
			$reviewBoosterMail->smtp_port = $this->config->get('config_mail_smtp_port');
			$reviewBoosterMail->smtp_timeout = $this->config->get('config_mail_smtp_timeout');
		}

		$reviewBoosterMail->setTo($order_info['email']);
		$reviewBoosterMail->setFrom($order_info['owner_email']);
		$reviewBoosterMail->setSender(html_entity_decode($order_info['store_name'], ENT_QUOTES, 'UTF-8'));
		$reviewBoosterMail->setSubject(html_entity_decode($subject, ENT_QUOTES, 'UTF-8'));
		$reviewBoosterMail->setHtml($message);
		$reviewBoosterMail->send();

		$data = array(
			'email'         => $order_info['email'],
			'hash'          => $hash,
			'code'          => $code,
			'order_id'      => $order_info['order_id'],
			'store_id'      => $order_info['store_id'],
			'product_id'    => $product_id,
			'product_limit' => $this->config->get('review_booster_product_limit'),
			'test'          => $test
		);

		$this->model_catalog_review_booster->addEmail($data);

		$this->i++;
	}

	private function getFormReview($order_info, $link, $last = false, $product_id = 'all', $product = '') {
		$this->load->model('localisation/language');

		$language_info = $this->model_localisation_language->getLanguage($order_info['language_id']);

		if ($language_info) {
			$language_code = $language_info['code'];
			$language_directory = $language_info['directory'];
		} else {
			$language_code = '';
			$language_directory = '';
		}

		$language = new Language($language_directory);
		$language->load('product/review_booster');

		$this->load->model('catalog/review');

		$html = '<table border="0" cellpadding="5" cellspacing="0" style="width:100%;margin:0;padding:0;border-collapse:collapse;mso-table-lspace:0pt;mso-table-rspace:0pt">' . "\n";
		$html .= '  <tbody>' . "\n";

		if ($this->config->get('review_booster_type') == 'product_single') {
			$html .= '<tr>' . "\n";
			$html .= '  <td valign="middle" style="padding: 2px;">' . "\n";
			
			if ($this->config->get('review_booster_product_image_status')) {
				$html .= '<img src="' . $product['image'] . '" border="0" style="vertical-align: middle; border: 1px solid #dddddd; margin-left: 10px; margin-right: 10px;" />';
			}

			$html .= '  <b>' . $product['name'] . '</b></td>' . "\n";
			$html .= '</tr>' . "\n";
		}

		$html .= '<tr>' . "\n";
		$html .= '  <td align="center">' . "\n";
		$html .= '    <table border="0" cellpadding="0" cellspacing="0" style="margin:0;padding:0;border-collapse:collapse;mso-table-lspace:0pt;mso-table-rspace:0pt">' . "\n";

		if ($this->config->get('review_booster_apr_status') && method_exists($this->model_catalog_review, 'getRatings')) {
			foreach ($this->model_catalog_review->getRatings() as $rating) {
				$html .= '<tr>' . "\n";
				$html .= '  <td>' . $rating['name'] . '<br />' . "\n";
				$html .= '    <span class="stars" style="display:inline-block">' . "\n";

				for ($j = 1; $j <= 5; $j++) {
					$html .= '  <span class="star" style="display:inline-block;float:left;margin-right:15px">' . "\n";
					$html .= '    <input type="radio" name="review[' . $product_id . '][rating][' . $rating['rating_id'] . ']" value="' . $j . '" style="margin:0;margin-right:7px;padding:0" ' . (($j == 5) ? 'checked' : '') . ' class="star_input" />' . "\n";
					$html .= '    <label for="star_image">' . "\n";
					$html .= '      <img style="border:0;margin:0;padding:0" src="' . ($this->config->get('review_booster_image_type') ? 'data:image/png;base64,' . $this->stars[$this->config->get('review_booster_star')][$j] : HTTP_SERVER . 'image/review_booster/' . $this->config->get('review_booster_star') . '-' . $j . '.png') . '" />' . "\n";
					$html .= '    </label>' . "\n";
					$html .= '  </span>' . "\n";
				}

				$html .= '    </span>' . "\n";
				$html .= '  </td>' . "\n";
				$html .= '</tr>' . "\n";
			}
		} else {
			$html .= '<tr>' . "\n";
			$html .= '  <td style="text-align:center;">' . "\n";
			$html .= '    <span class="stars" style="display:inline-block">' . "\n";

			for ($j = 1; $j <= 5; $j++) {
				$html .= '  <span class="star" style="display:inline-block;float:left;margin-right:15px">' . "\n";
				$html .= '    <input type="radio" name="review[' . $product_id . '][rating]" value="' . $j . '" style="margin:0;margin-right:7px;padding:0" ' . (($j == 5) ? 'checked' : '') . ' class="star_input" />' . "\n";
				$html .= '    <label for="star_image">' . "\n";
				$html .= '      <img style="border:0;margin:0;padding:0" src="' . ($this->config->get('review_booster_image_type') ? 'data:image/png;base64,' . $this->stars[$this->config->get('review_booster_star')][$j] : HTTP_SERVER . 'image/review_booster/' . $this->config->get('review_booster_star') . '-' . $j . '.png') . '" />' . "\n";
				$html .= '    </label>' . "\n";
				$html .= '  </span>' . "\n";
			}

			$html .= '    </span>' . "\n";
			$html .= '  <td>' . "\n";
			$html .= '</tr>' . "\n";
			$html .= '<tr>' . "\n";
		}

		$html .= '    </table>' . "\n";
		$html .= '  </td>' . "\n";
		$html .= '</tr>' . "\n";
		$html .= '<tr>' . "\n";
		$html .= '  <td>' . $language->get('entry_review') . '</td>' . "\n";
		$html .= '</tr>' . "\n";
		$html .= '<tr>' . "\n";
		$html .= '  <td>' . "\n";
		$html .= '    <textarea name="review[' . $product_id . '][text]" rows="5" style="width:100%;"></textarea>' . "\n";
		$html .= '  </td>' . "\n";
		$html .= '</tr>' . "\n";

		if ($this->config->get('review_booster_apr_image_status')) {
			$html .= '<tr>' . "\n";
			$html .= '  <td>' . $language->get('entry_review_image') . ' <a href="' . $link . '" style="display:inline-block;text-align:center;padding: 3px 5px;cursor:pointer;font-weight:normal;font-size:12px;white-space:nowrap;background-color:#1e91cf;color:#fff;border:1px solid #1978ab;text-decoration:none">' . $language->get('button_upload') . '</a></td>' . "\n";
			$html .= '</tr>' . "\n";
		}

		if ($last) {
			if ($this->config->get('review_booster_noticed_status')) {
				$html .= '<tr>' . "\n";
				$html .= '  <td>' . $language->get('entry_noticed') . ' <select name="review[' . $product_id . '][noticed]">';

				$notices = $this->config->get('review_booster_notice') ? (array)$this->config->get('review_booster_notice') : array();

				foreach ($notices as $row) {
					$html .= '  <option value="' . hash('md5', $row) . '">' . $row . '</option>';
				}

				$html .= '  </select></td>' . "\n";
				$html .= '</tr>' . "\n";
			}

			$html .= '<tr>' . "\n";
			$html .= '  <td align="right">' . "\n";
			$html .= '    <button type="submit" style="display:inline-block; text-align:center; padding: 6px 10px; cursor:pointer; font-weight:normal; white-space:nowrap; background-color:#1e91cf; color:#fff; border:1px solid #1978ab">' . $language->get('button_submit') . '</button>' . "\n";
			$html .= '  </td>' . "\n";
			$html .= '</tr>' . "\n";
		}

		$html .= '  </tbody>' . "\n";
		$html .= '</table>' . "\n";

		if (!$last && $this->config->get('review_booster_type') == 'product_single') {
			$html .= '<hr style="margin 0; padding: 0; margin-top: 17px; margin-bottom: 17px; border: 0; border-top: 1px solid #eeeeee;" />' . "\n";
		}

		return $html;
	}

	private function changeOrderStatus($order_id, $order_status_id, $comment = '', $notify = false) {
		$this->load->model('checkout/order');

		if (version_compare(VERSION, '2.0') < 0) {
			$this->model_checkout_order->update($order_id, $order_status_id, $comment, $notify);
		} else {
			$this->model_checkout_order->addOrderHistory($order_id, $order_status_id, $comment, $notify);
		}
	}

	private function toOutput($file, $data) {
		if (version_compare(VERSION, '2.0') < 0) {
			$this->data = $data;

			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/' . $file . '.tpl')) {
				$this->template = $this->config->get('config_template') . '/template/' . $file . '.tpl';
			} else {
				$this->template = 'default/template/' . $file . '.tpl';
			}

			$this->children = array(
				'common/column_left',
				'common/column_right',
				'common/content_top',
				'common/content_bottom',
				'common/footer',
				'common/header'
			);

			$this->response->setOutput($this->render());
		} elseif (version_compare(VERSION, '2.2') < 0) {
			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');

			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/' . $file . '.tpl')) {
				$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/' . $file . '.tpl', $data));
			} else {
				$this->response->setOutput($this->load->view('default/template/' . $file . '.tpl', $data));
			}
		} else {
			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');

			$this->response->setOutput($this->load->view($file, $data));
		}
	}

	protected function validate() {
		$this->load->model('catalog/review');

		foreach ($this->request->post['review'] as $product_id => $review) {
			if (isset($review['rating'])) {
				if ($this->config->get('review_booster_apr_status') && method_exists($this->model_catalog_review, 'getRatings') && is_array($review['rating'])) {
					$empty = array_filter($review['rating']);

					if (empty($review['rating']) || (count($empty) != count($this->model_catalog_review->getRatings()))) {
						$this->error['rating'][$product_id] = $this->language->get('error_rating');
					}
				} else {
					if (empty($review['rating']) || $review['rating'] < 0 || $review['rating'] > 5) {
						$this->error['rating'][$product_id] = $this->language->get('error_rating');
					}
				}
			} else {
				$this->error['rating'][$product_id] = $this->language->get('error_rating');
			}

			if ((utf8_strlen($review['text']) < 15) || (utf8_strlen($review['text']) > 1000)) {
				$this->error['review'][$product_id] = $this->language->get('error_review');
			}
		}

		return !$this->error;
	}
}
?>