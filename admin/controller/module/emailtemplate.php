<?php

class ControllerModuleEmailtemplate extends Controller {

	protected $data = array();

	private $error = array();

	private $_css = array('view/stylesheet/module/emailtemplate.css');
	private $_js = array();

	public function __construct($registry) {
		parent::__construct($registry);
		$this->load->library('emailtemplate/email_template');
	}

	/**
	 * Config
	 */
	public function index() {
		if (!isset($this->request->get['id'])) {
			$this->response->redirect($this->url->link('module/emailtemplate', 'token='.$this->session->data['token'] . '&id=1', 'SSL'));
		}

		$this->load->model('module/emailtemplate');

		$this->load->language('module/emailtemplate');

		if ($this->model_module_emailtemplate->checkVersion() !== false) {
			if ($this->model_module_emailtemplate->upgrade()) {
				$this->session->data['success'] = $this->language->get('upgrade_success');

				$this->response->redirect($this->url->link('module/emailtemplate', 'token='.$this->session->data['token'], 'SSL'));
			}
		}

		if (isset($this->request->get['action'])) {
			switch($this->request->get['action']) {
				case 'create':
					$newId = $this->model_module_emailtemplate->cloneConfig($this->request->get['id'], $this->request->post);
					if ($newId) {
						$this->session->data['success'] = $this->language->get('success_config');
						$this->response->redirect($this->url->link('module/emailtemplate', 'token='.$this->session->data['token'].'&id='.$newId, 'SSL'));
					}
				break;

				case 'delete':
					if ($this->model_module_emailtemplate->deleteConfig($this->request->get['id'])) {
						$this->session->data['success'] = $this->language->get('success_config_delete');
					}

					$this->response->redirect($this->url->link('module/emailtemplate', 'token='.$this->session->data['token'] . '&id=1', 'SSL'));
				break;

				case 'test_send':
					$return = array();

					$config = $this->model_module_emailtemplate->getConfig($this->request->get['id'], true);

					if ($this->_sendTestEmail($this->config->get('config_email'), $config['store_id'], $config['language_id'])) {
						$return['success'] = $this->language->get('success_send');
					}

					// Send to additional alert emails if new account email is enabled
					$emails = explode(',', $this->config->get('config_mail_alert'));

					foreach ($emails as $email) {
						if (utf8_strlen($email) > 0 && preg_match('/^[^\@]+@.*.[a-z]{2,15}$/i', $email)) {
							$this->_sendTestEmail($email, $config['store_id'], $config['language_id']);
						}
					}

					$this->response->addHeader('Content-Type: application/json');
					$this->response->setOutput(json_encode($return));

					return true;
				break;
			}
		}

		// Save
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->_validateConfig($this->request->post)) {
			$data = $this->request->post;

			if ($this->model_module_emailtemplate->updateConfig($this->request->get['id'], $data)) {
				$this->session->data['success'] = $this->language->get('success_config');
			}

			$this->response->redirect($this->url->link('module/emailtemplate', 'token='.$this->session->data['token'].'&id='.$this->request->get['id'], 'SSL'));
		}

	    $this->_messages();

	    $this->_breadcrumbs();

		$this->_config_form();

		$this->data['action_insert_config'] = $this->url->link('module/emailtemplate', 'token='.$this->session->data['token'] . '&id=' . $this->request->get['id'] . '&action=create', 'SSL');

		$this->data['action'] = $this->url->link('module/emailtemplate', 'token='.$this->session->data['token'] . '&id=' . $this->request->get['id'], 'SSL');

		$this->data['cancel'] = $this->url->link('extension/module', 'token='.$this->session->data['token'], 'SSL');

		$this->data['test_url'] = $this->url->link('module/emailtemplate/test', 'token='.$this->session->data['token'], 'SSL');

		$this->data['support_url'] = 'http://support.opencart-templates.co.uk/open.php';

		if (defined('VERSION')) {
		    $ocVer = VERSION;
		} else {
		    $ocVer = '';
		}

		$i = 1;
		foreach(array('name'=>$this->config->get("config_owner").' - '.$this->config->get("config_name"), 'email'=>$this->config->get("config_email"), 'protocol'=>$this->config->get("config_mail_protocol"), 'storeUrl'=>HTTP_CATALOG, 'version'=>EmailTemplate::$version, 'opencartVersion'=>$ocVer, 'phpVersion'=>phpversion()) as $key=>$val) {
		    $this->data['support_url'] .= (($i == 1) ? '?' : '&amp;') . $key . '=' . html_entity_decode($val,ENT_QUOTES,'UTF-8');
		    $i++;
		}

		$this->_css[] = 'view/javascript/bootstrap/css/bootstrap-colorpicker.min.css';
		$this->_js[] = 'view/javascript/bootstrap/js/bootstrap-colorpicker.min.js';
		$this->_js[] = 'view/javascript/emailtemplate/config.js';

		$this->_output('module/emailtemplate/config.tpl');
	}


	/**
	 * Opencart module install
	 */
	public function install() {
		$this->load->model('module/emailtemplate');

		$this->model_module_emailtemplate->uninstall();

		$this->model_module_emailtemplate->install();

        $file = DIR_APPLICATION . 'model/module/emailtemplate/install.xml';

        if (file_exists($file)) {
            $modification_data = array(
                'name' => "Email Templates",
                'code' => "emailtemplates",
                'author' => "opencart-templates",
                'version' => EmailTemplate::$version,
                'link' => "http://www.opencart-templates.co.uk",
                'xml' => file_get_contents($file),
                'status' => 1
            );
        }

        $this->load->model('extension/modification');

        $modification_info = $this->model_extension_modification->getModificationByCode("emailtemplates");

        if ($modification_info) {
            $this->model_extension_modification->deleteModification($modification_info['modification_id']);
        }

        $this->model_extension_modification->addModification($modification_data);

		$this->load->model('extension/event');

		$this->model_extension_event->addEvent('emailtemplate', 'post.return.add', 'module/emailtemplate_event/send_return_mail');

		$this->load->language('module/emailtemplate_install');
	}


	/**
	* Delete module settings for each store.
	*/
	public function uninstall() {
		$this->load->language('module/emailtemplate');

		if (!$this->user->hasPermission('modify', 'module/emailtemplate')) {
			$this->session->data['error'] = $this->language->get('error_permission');

			$this->response->redirect($this->url->link('extension/module', 'token='.$this->session->data['token'], 'SSL'));
		}

		$this->load->model('setting/store');
		$this->load->model('setting/setting');

		foreach ($this->model_setting_store->getStores() as $store) {
			$this->model_setting_setting->deleteSetting("emailtemplate", $store['store_id']);
		}

		$this->load->model('module/emailtemplate');

		$this->model_module_emailtemplate->uninstall();

		$this->load->model('extension/modification');

		$modification_info = $this->model_extension_modification->getModificationByCode("emailtemplates");

		if ($modification_info) {
		    $this->model_extension_modification->deleteModification($modification_info['modification_id']);
		}
	}

	/**
	 * Upgrade Extension
	 */
	public function upgrade() {
		$this->load->language('module/emailtemplate');
		$this->load->model('module/emailtemplate');

		if ($this->model_module_emailtemplate->upgrade()) {
			$this->session->data['success'] = $this->language->get('upgrade_success');
		}

		$this->response->redirect($this->url->link('module/emailtemplate', 'token='.$this->session->data['token'], 'SSL'));
	}

	/**
	 * Get Extension Form
	 */
	private function _config_form() {

		foreach(array(
			'button_cancel',
			'button_configs',
			'button_default',
			'button_delete',
			'button_restore',
			'button_save',
			'button_test',
			'button_update_preview',
			'button_withimages',
			'button_withoutimages',
			'entry_body',
			'entry_body_bg_color',
			'entry_body_font_color',
			'entry_body_heading_color',
			'entry_body_link_color',
			'entry_bottom_left',
			'entry_bottom_right',
			'entry_color',
			'entry_corner_image',
			'entry_end',
			'entry_email_width',
			'entry_footer',
			'entry_footer_text',
			'entry_head',
			'entry_head_text',
			'entry_header',
			'entry_header_bg_color',
			'entry_header_bg_image',
			'entry_header_border_color',
			'entry_height',
			'entry_label',
			'entry_language',
			'entry_log',
			'entry_logo',
			'entry_logo_resize_options',
			'entry_overlap',
			'entry_page_align',
			'entry_page_bg_color',
			'entry_page_footer_text',
			'entry_start',
			'entry_store',
			'entry_style',
			'entry_text_align',
			'entry_theme',
			'entry_top_left',
			'entry_top_right',
			'entry_width',
			'heading_config',
			'heading_footer',
			'heading_header',
			'heading_logs',
			'heading_sections',
			'heading_shadow',
			'heading_style',
			'text_align',
			'text_baseline',
			'text_bottom',
			'text_bottom_left',
			'text_bottom_right',
			'text_center',
			'text_confirm',
			'text_create_config',
			'text_default',
			'text_end',
			'text_font_size',
			'text_height',
			'text_left',
			'text_logo',
			'text_middle',
			'text_none',
			'text_right',
			'text_select',
			'text_shadow_info',
			'text_text_color',
			'text_top',
			'text_top_left',
			'text_top_right',
			'text_width'
		) as $var) {
			$this->data[$var] = $this->language->get($var);
		}

		$this->data['emailtemplate_config'] = $this->model_module_emailtemplate->getConfig($this->request->get['id']);

		if (!$this->data['emailtemplate_config']) {
			return false;
		}

		// Merge with post
		foreach(EmailTemplateConfigDAO::describe() as $col => $type) {
			if (isset($this->request->post[$col])) {
				$this->data['emailtemplate_config'][$col] = $this->request->post[$col];
			}
		}

		$this->data['emailtemplate_config'] = $this->model_module_emailtemplate->formatConfig($this->data['emailtemplate_config'], true);

		$this->data['id'] = $this->request->get['id'];

		if ($this->request->get['id'] == 1) {
			$this->_setTitle($this->language->get('heading_config') . ' - ' . $this->language->get('button_default'));
		} else {
			$this->_setTitle($this->language->get('heading_config') . ' - ' . $this->data['emailtemplate_config']['name']);

			$this->data['action_default'] = $this->url->link('module/emailtemplate', 'token='.$this->session->data['token'] . '&id=1', 'SSL');

			$this->data['action_delete'] = $this->url->link('module/emailtemplate', 'token='.$this->session->data['token'] . '&id=' . $this->request->get['id'] . '&action=delete', 'SSL');

			$this->load->model('localisation/language');
			$this->data['languages'] = $this->model_localisation_language->getLanguages();

			$this->load->model('setting/store');
			$this->data['stores'] = $this->model_module_emailtemplate->getStores();
		}

		$result = $this->db->query("SELECT emailtemplate_config_id, emailtemplate_config_name FROM " . DB_PREFIX . "emailtemplate_config WHERE emailtemplate_config_id != '" . intval($this->request->get['id']) . "' AND emailtemplate_config_id != 1");

		if ($result->rows) {
			$this->data['action_configs'] = array();

			foreach($result->rows as $row) {
				$this->data['action_configs'][] = array(
						'id' => $row['emailtemplate_config_id'],
						'name' => $row['emailtemplate_config_name'],
						'url' =>$this->url->link('module/emailtemplate', 'token='.$this->session->data['token'] . '&id=' . $row['emailtemplate_config_id'], 'SSL')
				);
			}
		}

		$this->load->model('tool/image');

		$this->data['no_image'] = $this->model_tool_image->resize('no_image.png', 100, 100);

		$this->data['no_shadow_image'] = $this->model_tool_image->resize('no_image.png', 17, 17);

		$this->data['themes'] = array();

		$directories = glob(DIR_CATALOG . 'view/theme/*', GLOB_ONLYDIR);
		foreach ($directories as $directory) {
			$this->data['themes'][] = basename($directory);
		}

		if (isset($this->data['emailtemplate_config']['language_id'])) {
			$language_id = $this->data['emailtemplate_config']['language_id'];
		} else {
			$language_id = $this->config->get('config_language_id');
		}

		if (isset($this->data['emailtemplate_config']['store_id'])) {
			$store_id = $this->data['emailtemplate_config']['store_id'];
		} else {
			$store_id = 0;
		}
	}

	/**
	 * Send Test Email with demo template
	 */
	private function _sendTestEmail($toAddress, $store_id = 0, $language_id = 1) {

	    $this->load->language('module/emailtemplate');

	    $template = new EmailTemplate($this->request, $this->registry);

	    $load = array('language_id' => $language_id, 'store_id' => $store_id);

	    if ($template->load($load) && $template->build()) {
	    	if(version_compare(VERSION, '2.0.0.0', '>=') && version_compare(VERSION, '2.0.2.0', '<')) {
	    		$mail = new Mail($this->config->get('config_mail'));
	    	} else {
	    		$mail = new Mail();
	    		$mail->protocol = $this->config->get('config_mail_protocol');
	    		$mail->parameter = $this->config->get('config_mail_parameter');
	    		if($this->config->get('config_mail_smtp_host')){
	    			$mail->smtp_hostname = $this->config->get('config_mail_smtp_host');
	    		} else {
	    			$mail->smtp_hostname = $this->config->get('config_mail_smtp_hostname');
	    		}
	    		$mail->smtp_username = $this->config->get('config_mail_smtp_username');
	    		$mail->smtp_password = html_entity_decode($this->config->get('config_mail_smtp_password'), ENT_QUOTES, 'UTF-8');
	    		$mail->smtp_port = $this->config->get('config_mail_smtp_port');
	    		$mail->smtp_timeout = $this->config->get('config_mail_smtp_timeout');
	    	}
	        $mail->setTo($toAddress);
	        $mail->setFrom($this->config->get('config_email'));
	        $mail->setSender($this->config->get('config_name'));
	        $mail->setSubject($this->config->get('config_name'));
	        $mail->setText($template->getPlainText());
	        $mail->setHtml($template->fetch(null, $this->language->get('text_example')));
	        $mail->send();
	    }

	    return true;
	}

	/**
	 * Populates $this->data with error_* keys using data from $this->error
	 */
	private function _messages() {
		if (isset($this->session->data['attention'])) {
			$this->data['error_attention'] = $this->session->data['attention'];
			unset($this->session->data['attention']);
		} else {
			$this->data['error_attention'] = '';
		}

		if (isset($this->session->data['error'])) {
			$this->data['error_warning'] = $this->session->data['error'];
			unset($this->session->data['error']);
		} else {
			$this->data['error_warning'] = '';
		}
		foreach ($this->error as $key => $val) {
			$this->data["error_{$key}"] = $val;
		}

		if (isset($this->session->data['success'])) {
			$this->data['success'] = $this->session->data['success'];
			unset($this->session->data['success']);
		} else {
			$this->data['success'] = '';
		}
	}

	/**
	 * Populates breadcrumbs array for $this->data
	 */
	private function _breadcrumbs($crumbs = array(), $home = true) {
		$bc = array();
		$bc_map = array(
			'text_home' => array('link' => 'common/home', 'params' => ''),
			'text_modules' => array('link' => 'extension/module', 'params' => '')
		);

		if ($home) {
			$bc_map = array_merge($bc_map, array('text_module' => array('link' => 'module/emailtemplate')));
		}
		$bc_map = array_merge($bc_map, $crumbs);

		foreach ($bc_map as $name => $item) {
			$bc[]= array(
				'text'      => $this->language->get($name),
				'href'      => $this->url->link($item['link'], 'token='.$this->session->data['token'] . (isset($item['params']) ? $item['params'] : ''), 'SSL')
			);
		}
   		$this->data['breadcrumbs'] = $bc;
	}

	/**
	 * Validate form data
	 */
	private function _validateConfig($data) {
		if (!$this->user->hasPermission('modify', 'module/emailtemplate')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (!isset($data['emailtemplate_config_name']) || $data['emailtemplate_config_name'] == '') {
			$this->error['emailtemplate_config_name'] = $this->language->get('error_required');
		}

		# Check directory and images exist
		if (!empty($data['emailtemplate_config_theme'])) {
			$dir = DIR_CATALOG . 'view/theme/' . $data['emailtemplate_config_theme'] . '/template/mail/_main.tpl';
			if (!file_exists($dir)) {
				$this->error['emailtemplate_config_theme'] = sprintf($this->language->get('error_theme'), $dir);
			}
		}

		# Validate logo contains space or special character
		if ($data['emailtemplate_config_logo']) {
			$logo = $data['emailtemplate_config_logo'];
			if ($logo && preg_match('/[^\w.-]/', basename($logo))) {
				$this->error['emailtemplate_config_logo'] = sprintf($this->language->get('error_logo_filename'), $logo);
			}
		}

		if ($this->error) {
			if (!isset($this->error['warning'])) {
				$this->error['warning'] = $this->language->get('error_warning');
			}
			return false;
		} else {
			return true;
		}
	}

	/**
	 * Format Address
	 *
	 * @param Array data eg array(firstname=>'', shipping_firstname=>'', payment_firstname=>'')
	 * @param String prefix of address: '' or 'shipping' or 'payment'
	 * @param String address formatting e.g '{firstname}...'
	 */
	private function _formatAddress($address, $address_prefix = '', $format = null) {
		$find = array();
		$replace = array();
		if ($address_prefix != "") {
			$address_prefix = trim($address_prefix, '_') . '_';
		}
		if (is_null($format) || $format == '') {
			$format = '{firstname} {lastname}' . "\n" . '{company}' . "\n" . '{address_1}' . "\n" . '{address_2}' . "\n" . '{city} {postcode}' . "\n" . '{zone}' . "\n" . '{country}';
		}
		$vars = array(
				'firstname',
				'lastname',
				'company',
				'address_1',
				'address_2',
				'city',
				'postcode',
				'zone',
				'zone_code',
				'country'
		);
		foreach($vars as $var) {
			$find[$var] = '{'.$var.'}';
			if ($address_prefix && isset($address[$address_prefix.$var])) {
				$replace[$var] =  $address[$address_prefix.$var];
			} elseif (isset($address[$var])) {
				$replace[$var] =  $address[$var];
			} else {
				$replace[$var] =  '';
			}
		}
		return str_replace(array("\r\n", "\r", "\n"), '<br />', preg_replace(array("/\s\s+/", "/\r\r+/", "/\n\n+/"), '<br />', trim(str_replace($find, $replace, $format))));
	}

	/**
	 * Output Page
	 *
	 * @param string $template - template file path
	 * @param array $children
	 */
	private function _setTitle($title = '') {
		if ($title == '') {
			$title = $this->language->get('heading_title');
		} else {
			$title .= ' - ' . $this->language->get('heading_title');
		}

		$this->data['title'] = $title;

		$this->document->setTitle(strip_tags($title));

		return $this;
	}

	/**
	 * Output Page
	 *
	 * @param string $template - template file path
	 */
	private function _output($tpl) {
		if ($this->_css) {
			foreach($this->_css as $file) {
				$this->document->addStyle($file);
			}
		}

		if ($this->_js) {
			foreach($this->_js as $file) {
				$this->document->addScript($file);
			}
		}

		$this->data['header'] = $this->load->controller('common/header');
		$this->data['column_left'] = $this->load->controller('common/column_left');
		$this->data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view($tpl, $this->data));
	}

	/**
	 * Pagination
	 *
	 * @param string $url
	 * @param int $page - current page number
	 * @param int $total - total rows count
	 */
	private function _renderPagination($url, $page, $total, $limit = null, $style = '') {
		$pagination = new Pagination();
		$pagination->total = $total;
		$pagination->paging_style = $style;
		$pagination->page = $page;
		$pagination->limit = ($limit == null) ? $this->config->get('config_limit_admin') : $limit;
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $url;

		$this->data['pagination'] = $pagination->render();

		$this->data['pagination_results'] = sprintf($this->language->get('text_pagination'), ($pagination->total) ? (($page - 1) * $pagination->limit) + 1 : 0, ((($page - 1) * $pagination->limit) > ($pagination->total - $pagination->limit)) ? $pagination->total : ((($page - 1) * $pagination->limit) + $pagination->limit), $pagination->total, ceil($pagination->total / $pagination->limit));
	}

	private function _link($link, $isAdmin = false) {
		if ($isAdmin) {
			return $this->url->link($link, 'token='.$this->session->data['token'], 'SSL');
		} else {
			if ($this->config->get('config_secure') && defined('HTTPS_SERVER') && defined('HTTPS_CATALOG')) {
				return str_replace(HTTPS_SERVER, HTTPS_CATALOG, $this->url->link($link, '', 'SSL'));
			} else {
				return str_replace(HTTP_SERVER, HTTP_CATALOG, $this->url->link($link, '', 'SSL'));
			}
		}
	}

}
?>