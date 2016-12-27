<?php
class ModelCatalogQA extends Model {
	protected static $count = 0;
	protected static $product = 0;

	public function addQuestion($product_id, $data) {
		if (!isset($data['q_name'])) {
			$data['q_name'] = '';
		}

		if (!isset($data['q_email'])) {
			$data['q_email'] = '';
		}

		if (!isset($data['q_phone'])) {
			$data['q_phone'] = '';
		}

		if (!isset($data['q_custom'])) {
			$data['q_custom'] = '';
		}

		$this->db->query("INSERT INTO " . DB_PREFIX . "qa SET question_author_name = '" . $this->db->escape($data['q_name']) . "', question_author_email = '" . $this->db->escape($data['q_email']) . "', question_author_phone = '" . $this->db->escape($data['q_phone']) . "', question_author_custom = '" . $this->db->escape($data['q_custom']) . "', customer_id = " . ($this->customer->isLogged() ? (int)$this->customer->getId() : "NULL") . ", product_id = '" . (int)$product_id . "', store_id = '" . (int)$this->config->get('config_store_id') . "', language_id = '" . (int)$this->config->get('config_language_id') . "', question = '" . $this->db->escape(strip_tags($data['q_question'])) . "', status = '" . (int)$this->config->get('qa_new_question_status') . "', date_asked = NOW(), date_modified = NOW()");

		$question_id = $this->db->getLastId();

		$this->db->query("INSERT INTO " . DB_PREFIX . "qa_to_store SET qa_id = '" . (int)$question_id . "', store_id = '" . (int)$this->config->get('config_store_id') . "'");

		$this->cache->delete('qa');

		if ($this->config->get('qa_new_question_notification')) {
			if (version_compare(VERSION, '2.2.0', '>=')) {
				$l_query = $this->db->query("SELECT language_id, code FROM " . DB_PREFIX . "language WHERE code = '" . $this->config->get('config_admin_language') . "'");
				$language = new Language($l_query->row['code']);
				$language->load($l_query->row['code']);
				$language->load('mail/new_question');
			} else if (version_compare(VERSION, '2.0.1', '<')) {
				$l_query = $this->db->query("SELECT language_id, filename, directory FROM " . DB_PREFIX . "language WHERE code = '" . $this->config->get('config_admin_language') . "'");
				$language = new Language($l_query->row['directory']);
				$language->load($l_query->row['filename']);
				$language->load('mail/new_question');
			} elseif (version_compare(VERSION, '2.0.2', '>=')) {
				$l_query = $this->db->query("SELECT language_id, directory FROM " . DB_PREFIX . "language WHERE code = '" . $this->config->get('config_admin_language') . "'");
				$language = new Language($l_query->row['directory']);
				$language->load($l_query->row['directory']);
				$language->load('mail/new_question');
			} else {
				$l_query = $this->db->query("SELECT language_id, directory FROM " . DB_PREFIX . "language WHERE code = '" . $this->config->get('config_admin_language') . "'");
				$language = new Language($l_query->row['directory']);
				$language->load('default');
				$language->load('mail/new_question');
			}

			// Get product info
			$p_query = $this->db->query("SELECT p.model AS model, pd.name AS name FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) WHERE p.product_id = '" . (int)$product_id . "' AND pd.language_id = '" . $l_query->row['language_id'] . "'");

			// Get customer info
			if ($this->customer->isLogged()) {
				$customer_name = $this->customer->getFirstName() . " " . $this->customer->getLastName();
			} else {
				$customer_name = "";
			}

			$subject = sprintf($language->get('text_subject'), $this->config->get('config_name'));

			// HTML Mail
			$html_data['title'] = sprintf($language->get('text_subject'), html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8'));

			$html_data['text_new_question'] = sprintf($language->get('text_new_question'), $this->url->link('product/product', 'product_id=' . $product_id), $p_query->row['name']);
			$html_data['text_question_detail'] = $language->get('text_question_detail');
			$html_data['text_question'] = $language->get('text_question');
			$html_data['text_related_product'] = $language->get('text_related_product');
			$html_data['text_question_author'] = $language->get('text_question_author');
			$html_data['text_email'] = $language->get('text_email');
			$html_data['text_phone'] = $language->get('text_phone');
			$custom_field_names = $this->config->get('qa_form_custom_field_name');
			$html_data['text_custom'] = (isset($custom_field_names[$this->config->get('config_language_id')])) ? $custom_field_names[$this->config->get('config_language_id')] . ':' : $language->get('text_custom');
			$html_data['text_customer_name'] = $language->get('text_customer_name');
			$html_data['text_ip'] = $language->get('text_ip');
			$html_data['text_powered_by'] = $language->get('text_powered_by');

			$html_data['store_name'] = $this->config->get('config_name');
			$html_data['store_url'] = $this->config->get('config_url');
			$html_data['logo'] = $this->config->get('config_url') . 'image/' . $this->config->get('config_logo');
			$html_data['question'] = str_replace(array("\r\n", "\r", "\n"), '<br />', strip_tags($data['q_question']));
			$html_data['question_author'] = strip_tags($data['q_name']);
			$html_data['question_author_email'] = strip_tags($data['q_email']);
			$html_data['question_author_phone'] = strip_tags($data['q_phone']);
			$html_data['question_author_custom'] = strip_tags($data['q_custom']);
			$html_data['customer_name'] = $customer_name;
			$html_data['text_anonymous'] = $language->get('text_anonymous');
			$html_data['ip_address'] = $this->request->server['REMOTE_ADDR'];

			if (version_compare(VERSION, '2.2.0', '>=')) {
				$template = 'mail/new_question';
			} else {
				if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/mail/new_question.tpl')) {
					$template = $this->config->get('config_template') . '/template/mail/new_question.tpl';
				} else {
					$template = 'default/template/mail/new_question.tpl';
				}
			}

			// Text Mail
			$text  = strip_tags(sprintf($language->get('text_new_question'), '', $p_query->row['name'])) . "\n\n";
			$text .= $language->get('text_question') . ' ' . $data['q_question'] . "\n\n";
			$text .= $language->get('text_question_author') . ' ' . ($data['q_name'] ? $data['q_name'] : $language->get('text_anonymous')) . (($customer_name) ? " ($customer_name)" : "") . "\n";
			if ($data['q_email']) {
				$text .= $language->get('text_email') . ' ' . $data['q_email'] . "\n";
			}
			if ($data['q_phone']) {
				$text .= $language->get('text_phone') . ' ' . $data['q_phone'] . "\n";
			}
			if ($data['q_custom']) {
				$text .= $html_data['text_custom'] . ' ' . $data['q_custom'] . "\n\n";
			}
			$text .= $language->get('text_ip') . ' ' . $this->request->server['REMOTE_ADDR'] . "\n";

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
			if ((int)$this->config->get('qa_notification_from') && $data['q_email']) {
				$mail->setFrom($data['q_email']);
				$mail->setSender($data['q_name']);
			} else {
				$mail->setFrom($this->config->get('config_email'));
				$mail->setSender($this->config->get('config_name'));
			}
			$mail->setSubject($subject);
			$mail->setHtml($this->load->view($template, $html_data));
			$mail->setText(html_entity_decode($text, ENT_QUOTES, 'UTF-8'));

			$emails = $this->config->get('qa_notification_emails');
			$emails = explode(',', $emails[$this->config->get('config_language_id')]);

			foreach ($emails as $email) {
				$mail->setTo($email);
				$mail->send();
			}
		}
	}

	public function getQuestionsByProductId($product_id, $start = 0, $limit = 20) {
		$sql = "SELECT SQL_CALC_FOUND_ROWS q.* FROM " . DB_PREFIX . "qa q INNER JOIN " . DB_PREFIX . "qa_to_store q2s ON (q.qa_id = q2s.qa_id) LEFT JOIN " . DB_PREFIX . "product p ON (q.product_id = p.product_id) WHERE p.product_id = '" . (int)$product_id . "' AND q2s.store_id = '" . (int)$this->config->get('config_store_id') . "' AND q.status = '1'";

		if ((int)$this->config->get('qa_display_all_languages') != 1) {
			$sql .= " AND q.language_id = '" . (int)$this->config->get('config_language_id') . "'";
		}

		$sql .= " ORDER BY q.date_asked DESC";

		if ($limit > 0) {
			$sql .= " LIMIT " . (int)$start . "," . (int)$limit;
		}

		$query = $this->db->query($sql);

		$count = $this->db->query("SELECT FOUND_ROWS() AS count");
		$this->count = ($count->num_rows) ? (int)$count->row['count'] : 0;
		$this->product = $product_id;

		return $query->rows;
	}

	public function getTotalQuestionsByProductId($product_id) {
		if ($this->product == $product_id) {
			return $this->count;
		} else {
			$sql = "SELECT COUNT(*) AS total FROM " . DB_PREFIX . "qa q INNER JOIN " . DB_PREFIX . "qa_to_store q2s ON (q.qa_id = q2s.qa_id) LEFT JOIN " . DB_PREFIX . "product p ON (q.product_id = p.product_id) WHERE p.product_id = '" . (int)$product_id . "' AND q2s.store_id = '" . (int)$this->config->get('config_store_id') . "' AND q.status = '1'";

			if ((int)$this->config->get('qa_display_all_languages') != 1) {
				$sql .= " AND q.language_id = '" . (int)$this->config->get('config_language_id') . "'";
			}

			$query = $this->db->query($sql);

			return (int)$query->row['total'];
		}
	}
}
