<?php
define('VQMOD_WORKING',             true);
define('EXTENSION_NAME',            'Product Questions &amp; Answers');
define('EXTENSION_VERSION',         '1.8.6');
define('EXTENSION_ID',              '1328');
define('EXTENSION_COMPATIBILITY',   'OpenCart 2.x.x.x');
define('EXTENSION_STORE_URL',       'http://www.opencart.com/index.php?route=extension/extension/info&extension_id=' . EXTENSION_ID);
define('EXTENSION_PURCHASE_URL',    'http://www.opencart.com/index.php?route=extension/purchase&extension_id=' . EXTENSION_ID);
define('EXTENSION_SUPPORT_EMAIL',   'support@opencart.ee');
define('EXTENSION_SUPPORT_FORUM',   'http://forum.opencart.com/viewtopic.php?f=123&t=25969');
define('OTHER_EXTENSIONS',          'http://www.opencart.com/index.php?route=extension/extension&filter_username=bull5-i');

class ControllerModuleQA extends Controller {
	private $error = array();
	protected $alert = array(
		'error'     => array(),
		'warning'   => array(),
		'success'   => array(),
		'info'      => array()
	);

	private $defaults = array(
		// (General)
		'qa_installed'                      => 1,
		'qa_installed_version'              => EXTENSION_VERSION,
		'qa_status'                         => 0,
		'qa_dashboard_widget'               => 0,
		'qa_new_question_notification'      => 1,
		'qa_question_reply_notification'    => 1,
		'qa_notification_emails'            => array(),
		'qa_notification_from'              => 0,
		'qa_remove_sql_changes'             => 0,
		'qa_services'                       => "W10=",
		'qa_as'                             => "WyIwIl0=",
		// Question form (Form)
		'qa_form_display_name'              => 1,
		'qa_form_require_name'              => 1,
		'qa_form_display_email'             => 1,
		'qa_form_require_email'             => 0,
		'qa_form_display_phone'             => 0,
		'qa_form_require_phone'             => 0,
		'qa_form_display_custom_field'      => 0,
		'qa_form_require_custom_field'      => 0,
		'qa_form_custom_field_name'         => array(),
		'qa_form_display_captcha'           => 1,
		'qa_form_require_captcha'           => 1,
		// Questions & answers (Q&A)
		'qa_display_questions'              => 1,
		'qa_display_all_languages'          => 1,
		'qa_new_question_status'            => 0,
		'qa_items_per_page'                 => 5,
		'qa_preload'                        => 0,
		'qa_display_question_author'        => 1,
		'qa_display_question_date'          => 1,
		'qa_display_answer_author'          => 0,
		'qa_display_answer_date'            => 0,
	);

	private static $language_texts = array(
		// Texts
		'text_enabled', 'text_disabled', 'text_yes', 'text_no', 'text_toggle_navigation', 'text_legal_notice', 'text_license', 'text_extension_information',
		'text_terms', 'text_license_text', 'text_support_subject', 'text_faq', 'text_none', 'text_first_page', 'text_all', 'text_store_email_address',
		'text_customer_email_address', 'text_saving', 'text_upgrading', 'text_loading', 'text_canceling',
		// Tabs
		'tab_settings', 'tab_form', 'tab_qa', 'tab_support', 'tab_about', 'tab_general', 'tab_faq', 'tab_services', 'tab_changelog', 'tab_extension',
		// Buttons
		'button_save', 'button_apply', 'button_cancel', 'button_close', 'button_upgrade', 'button_refresh', 'button_purchase_license',
		// Help texts
		'help_dashboard_widget', 'help_new_question_notification', 'help_question_reply_notification', 'help_notification_emails',
		'help_notification_email_from', 'help_display_questions', 'help_items_per_page', 'help_preload', 'help_display_all_languages',
		'help_remove_sql_changes', 'help_purchase_additional_licenses',
		// Entries
		'entry_installed_version', 'entry_extension_status', 'entry_dashboard_widget', 'entry_new_question_notification', 'entry_notification_emails',
		'entry_notification_email_from', 'entry_question_reply_notification', 'entry_display_all_languages', 'entry_remove_sql_changes',
		'entry_form_display_name', 'entry_form_require_name', 'entry_form_display_email', 'entry_form_require_email', 'entry_form_display_phone',
		'entry_form_require_phone', 'entry_form_display_custom', 'entry_form_require_custom', 'entry_form_custom_field_name', 'entry_form_display_captcha',
		'entry_form_require_captcha', 'entry_display_questions', 'entry_new_questions_status', 'entry_items_per_page', 'entry_preload',
		'entry_display_question_author', 'entry_display_question_date', 'entry_display_answer_author', 'entry_display_answer_date', 'entry_extension_name',
		'entry_extension_compatibility', 'entry_extension_store_url', 'entry_copyright_notice', 'entry_active_on', 'entry_inactive_on',
		// Errors
		'error_ajax_request', 'error_email', 'error_custom_field_name', 'error_positive_integer',
	);

	public function __construct($registry) {
		parent::__construct($registry);
		$this->load->helper('qa');

		$this->load->language('module/qa');
		$this->load->model('module/qa');
	}

	public function index() {
		$this->document->addStyle('view/stylesheet/qa/css/custom.min.css');

		$this->document->addScript('view/javascript/qa/custom.min.js');

		$this->document->setTitle($this->language->get('extension_name'));

		$this->load->model('setting/setting');

		$ajax_request = isset($this->request->server['HTTP_X_REQUESTED_WITH']) && !empty($this->request->server['HTTP_X_REQUESTED_WITH']) && strtolower($this->request->server['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest';

		if ($this->request->server['REQUEST_METHOD'] == 'POST' && !$ajax_request && $this->validateForm($this->request->post)) {
			$original_settings = $this->model_setting_setting->getSetting('qa');

			foreach ($this->defaults as $setting => $default) {
				$value = $this->config->get($setting);
				if ($value === null) {
					$original_settings[$setting] = $default;
				}
			}

			$settings = array_merge($original_settings, $this->request->post);
			$settings['qa_installed_version'] = $original_settings['qa_installed_version'];

			$this->model_setting_setting->editSetting('qa', $settings);

			$this->session->data['success'] = $this->language->get('text_success_update');

			$this->response->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], true));
		} else if ($this->request->server['REQUEST_METHOD'] == 'POST' && $ajax_request) {
			$response = array();

			if ($this->validateForm($this->request->post)) {
				$original_settings = $this->model_setting_setting->getSetting('qa');

				foreach ($this->defaults as $setting => $default) {
					$value = $this->config->get($setting);
					if ($value === null) {
						$original_settings[$setting] = $default;
					}
				}

				if ((int)$original_settings['qa_status'] != (int)$this->request->post['qa_status']) {
					$response['reload'] = true;
					$this->session->data['success'] = $this->language->get('text_success_update');
				}

				$settings = array_merge($original_settings, $this->request->post);
				$settings['qa_installed_version'] = $original_settings['qa_installed_version'];

				$this->model_setting_setting->editSetting('qa', $settings);

				$this->alert['success']['updated'] = $this->language->get('text_success_update');
			} else {
				if (!$this->checkVersion()) {
					$response['reload'] = true;
				}
			}

			$response = array_merge($response, array("errors" => $this->error), array("alerts" => $this->alert));

			$this->response->addHeader('Content-Type: application/json');
			$this->response->setOutput(json_enc($response, JSON_UNESCAPED_SLASHES));
			return;
		}

		$this->checkVersion() && $this->model_module_qa->checkDatabaseStructure($this->alert);

		$this->alert = array_merge($this->alert, $this->model_module_qa->getAlerts());

		$this->checkPrerequisites();

		$this->checkVersion();

		$data['heading_title'] = $this->language->get('extension_name');
		$data['text_other_extensions'] = sprintf($this->language->get('text_other_extensions'), OTHER_EXTENSIONS);

		foreach (self::$language_texts as $text) {
			$data[$text] = $this->language->get($text);
		}

		$data['ext_name'] = EXTENSION_NAME;
		$data['ext_version'] = EXTENSION_VERSION;
		$data['ext_id'] = EXTENSION_ID;
		$data['ext_compatibility'] = EXTENSION_COMPATIBILITY;
		$data['ext_store_url'] = EXTENSION_STORE_URL;
		$data['ext_purchase_url'] = EXTENSION_PURCHASE_URL;
		$data['ext_support_email'] = EXTENSION_SUPPORT_EMAIL;
		$data['ext_support_forum'] = EXTENSION_SUPPORT_FORUM;
		$data['other_extensions_url'] = OTHER_EXTENSIONS;

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

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true),
			'active'    => false
		);

		$data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_module'),
			'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], true),
			'active'    => false
		);

		$data['breadcrumbs'][] = array(
			'text'      => $this->language->get('extension_name'),
			'href'      => $this->url->link('module/qa', 'token=' . $this->session->data['token'], true),
			'active'    => true
		);

		$data['save'] = $this->url->link('module/qa', 'token=' . $this->session->data['token'], true);
		$data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], true);
		$data['upgrade'] = $this->url->link('module/qa/upgrade', 'token=' . $this->session->data['token'], true);
		$data['extension_installer'] = $this->url->link('extension/installer', 'token=' . $this->session->data['token'], true);
		$data['services'] = html_entity_decode($this->url->link('module/qa/services', 'token=' . $this->session->data['token'], true));

		$data['update_pending'] = !$this->checkVersion();

		if (!$data['update_pending']) {
			$this->updateEventHooks();
		}

		$data['ssl'] = (
				(int)$this->config->get('config_secure') ||
				isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] == 'on' ||
				!empty($_SERVER['HTTP_X_FORWARDED_PROTO']) && $_SERVER['HTTP_X_FORWARDED_PROTO'] == 'https' ||
				!empty($_SERVER['HTTP_X_FORWARDED_SSL']) && $_SERVER['HTTP_X_FORWARDED_SSL'] == 'on'
			) ? 's' : '';

		$this->load->model('localisation/language');

		$languages = $this->model_localisation_language->getLanguages();

		$data['multilingual'] = count($languages) > 1;
		$data['languages'] = array_remap_key_to_id('language_id', $languages);
		$data['default_language'] = $this->config->get('config_language_id');

		$data['installed_version'] = $this->installedVersion();

		# Loop through all settings for the post/config values
		foreach (array_keys($this->defaults) as $setting) {
			if (isset($this->request->post[$setting])) {
				$data[$setting] = $this->request->post[$setting];
			} else {
				$data[$setting] = $this->config->get($setting);
				if ($data[$setting] === null) {
					if (!isset($this->alert['warning']['unsaved']) && $this->checkVersion())  {
						$this->alert['warning']['unsaved'] = $this->language->get('error_unsaved_settings');
					}
					if (isset($this->defaults[$setting])) {
						$data[$setting] = $this->defaults[$setting];
					}
				}
			}
		}

		$this->load->model('setting/store');

		$stores = $this->model_setting_store->getStores();

		$data['stores'] = array();

		$data['stores'][0] = array(
			'name' => $this->config->get('config_name'),
			'url'  => HTTP_CATALOG
		);

		foreach ($stores as $store) {
			$data['stores'][$store['store_id']] = array(
				'name' => $store['name'],
				'url'  => $store['url']
			);
		}

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

		$data['errors'] = $this->error;

		$data['token'] = $this->session->data['token'];

		$data['alerts'] = $this->alert;

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		if (version_compare(VERSION, '2.2.0', '>=')) {
			$template = 'module/qa';
		} else {
			$template = 'module/qa.tpl';
		}

		$this->response->setOutput($this->load->view($template, $data));
	}

	public function install() {
		$this->model_module_qa->applyDatabaseChanges();

		$this->registerEventHooks();

		$this->load->model('localisation/language');

		$languages = $this->model_localisation_language->getLanguages();
		$languages = array_remap_key_to_id('language_id', $languages);
		foreach ($languages as $language_id => $language) {
			$this->defaults['qa_notification_emails'][$language_id] = $this->config->get('config_email');
		}

		$this->load->model('setting/setting');
		$this->model_setting_setting->editSetting('qa', $this->defaults);
	}

	public function uninstall() {
		$this->removeEventHooks();

		if ($this->config->get("qa_remove_sql_changes")) {
			$this->model_module_qa->revertDatabaseChanges();
		}

		$this->load->model('setting/setting');
		$this->model_setting_setting->deleteSetting('qa');
	}

	public function upgrade() {
		$ajax_request = isset($this->request->server['HTTP_X_REQUESTED_WITH']) && !empty($this->request->server['HTTP_X_REQUESTED_WITH']) && strtolower($this->request->server['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest';

		$response = array();

		if ($this->request->server['REQUEST_METHOD'] == 'POST' && $this->validateUpgrade()) {
			$this->load->model('setting/setting');

			if ($this->model_module_qa->upgradeDatabaseStructure($this->installedVersion(), $this->alert)) {
				$settings = array();

				// Go over all settings, add new values and remove old ones
				foreach ($this->defaults as $setting => $default) {
					$value = $this->config->get($setting);
					if ($value === null) {
						$settings[$setting] = $default;
					} else {
						$settings[$setting] = $value;
					}
				}

				if (!is_array($settings['qa_notification_emails'])) {
					$email = $settings['qa_notification_emails'];
					$settings['qa_notification_emails'] = array();

					$this->load->model('localisation/language');

					$languages = $this->model_localisation_language->getLanguages();
					$languages = array_remap_key_to_id('language_id', $languages);

					foreach ($languages as $language_id => $language) {
						$settings['qa_notification_emails'][$language_id] = $email ? $email : $this->config->get('config_email');
					}
				}

				$settings['qa_installed_version'] = EXTENSION_VERSION;

				$this->model_setting_setting->editSetting('qa', $settings);

				$this->session->data['success'] = sprintf($this->language->get('text_success_upgrade'), EXTENSION_VERSION);
				$this->alert['success']['upgrade'] = sprintf($this->language->get('text_success_upgrade'), EXTENSION_VERSION);

				$response['success'] = true;
				$response['reload'] = true;
			} else {
				$this->alert = array_merge($this->alert, $this->model_module_qa->getAlerts());
				$this->alert['error']['database_upgrade'] = $this->language->get('error_upgrade_database');
			}
		}

		$response = array_merge($response, array("errors" => $this->error), array("alerts" => $this->alert));

		if (!$ajax_request) {
			$this->session->data['errors'] = $this->error;
			$this->session->data['alerts'] = $this->alert;
			$this->response->redirect($this->url->link('module/qa', 'token=' . $this->session->data['token'], true));
		} else {
			$this->response->addHeader('Content-Type: application/json');
			$this->response->setOutput(json_enc($response, JSON_UNESCAPED_SLASHES));
			return;
		}
	}

	public function services() {
		$services = base64_decode($this->config->get('qa_services'));
		$response = json_decode($services, true);
		$force = isset($this->request->get['force']) && (int)$this->request->get['force'];

		if ($response && isset($response['expires']) && $response['expires'] >= strtotime("now") && !$force) {
			$response['cached'] = true;
		} else {
			$url = "http://www.opencart.ee/services/?eid=" . EXTENSION_ID . "&info=true&general=true";
			$hostname = (!empty($_SERVER['HTTP_HOST'])) ? $_SERVER['HTTP_HOST'] : '' ;

			if (function_exists('curl_init')) {
				$ch = curl_init();
				curl_setopt($ch, CURLOPT_URL, $url);
				curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
				curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
				curl_setopt($ch, CURLOPT_HEADER, false);
				curl_setopt($ch, CURLOPT_MAXREDIRS, 3);
				curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 5);
				curl_setopt($ch, CURLOPT_TIMEOUT, 60);
				curl_setopt($ch, CURLOPT_USERAGENT, base64_encode("curl " . EXTENSION_ID));
				curl_setopt($ch, CURLOPT_REFERER, $hostname);
				$json = curl_exec($ch);
			} else {
				$json = false;
			}

			if ($json !== false) {
				$this->load->model('setting/setting');
				$settings = $this->model_setting_setting->getSetting('qa');
				$settings['qa_services'] = base64_encode($json);
				$this->model_setting_setting->editSetting('qa', $settings);
				$response = json_decode($json, true);
			} else {
				$response = array();
			}
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_enc($response, JSON_UNESCAPED_SLASHES));
	}

	private function registerEventHooks() {
		if (version_compare(VERSION, '2.0.1', '<')) {
			// $this->load->model('tool/event');
			// $this->model_tool_event->addEvent('qa.product.delete', 'pre.admin.product.delete', 'module/qa/hook');
		} else {
			// $this->load->model('extension/event');
			// $this->model_extension_event->addEvent('qa.product.delete', 'pre.admin.product.delete', 'module/qa/hook');
		}
	}

	private function removeEventHooks() {
		if (version_compare(VERSION, '2.0.1', '<')) {
			// $this->load->model('tool/event');
			// $this->model_tool_event->deleteEvent('qa.product.delete');
		} else {
			// $this->load->model('extension/event');
			// $this->model_extension_event->deleteEvent('qa.product.delete');
		}
	}

	private function updateEventHooks() {
		if (version_compare(VERSION, '2.0.1', '<')) {
			$this->load->model('tool/event');
		} else {
			$this->load->model('extension/event');
		}

		$event_hooks = array(
			// 'qa.product.delete'         => array('trigger' => 'pre.admin.product.delete',           'action' => 'module/qa/hook'),
		);

		foreach ($event_hooks as $code => $hook) {
			if (version_compare(VERSION, '2.0.1', '<')) {
				$event = $this->model_tool_event->getEvent($code);
			} else {
				$event = $this->model_extension_event->getEvent($code);
			}

			if (!$event || $event['trigger'] != $hook['trigger'] || $event['action'] != $hook['action']) {
				if (version_compare(VERSION, '2.0.1', '<')) {
					$this->model_tool_event->addEvent($code, $hook['trigger'], $hook['action']);
				} else {
					$this->model_extension_event->addEvent($code, $hook['trigger'], $hook['action']);
				}

				if (empty($this->alert['success']['hooks_updated'])) {
					$this->alert['success']['hooks_updated'] = $this->language->get('text_success_hooks_update');
				}
			}
		}

		// Delete old triggers
		$query = $this->db->query("SELECT `code` FROM " . DB_PREFIX . "event WHERE `code` LIKE 'fd.%'");
		$events = array_keys($event_hooks);

		foreach ($query->rows as $row) {
			if (!in_array($row['code'], $events)) {
				if (version_compare(VERSION, '2.0.1', '<')) {
					$this->model_tool_event->deleteEvent($row['code']);
				} else {
					$this->model_extension_event->deleteEvent($row['code']);
				}

				if (empty($this->alert['success']['hooks_updated'])) {
					$this->alert['success']['hooks_updated'] = $this->language->get('text_success_hooks_update');
				}
			}
		}
	}

	private function checkPrerequisites() {
		$errors = false;

		if (!defined('VQMOD_WORKING')) {
			if (!class_exists('VQMod')) {
				$this->alert['warning']['vqmod'] = $this->language->get('error_vqmod');
			} else {
				$this->alert['warning']['vqmod'] = $this->language->get('error_vqmod_script');
			}
		}

		return !$errors;
	}

	private function checkVersion() {
		$errors = false;

		$installed_version = $this->installedVersion();

		if ($installed_version != EXTENSION_VERSION) {
			$errors = true;
			$this->alert['info']['version'] = sprintf($this->language->get('error_version'), EXTENSION_VERSION);
		}

		return !$errors;
	}

	private function validate() {
		$errors = false;

		if (!$this->user->hasPermission('modify', 'module/qa')) {
			$errors = true;
			$this->alert['error']['permission'] = $this->language->get('error_permission');
		}

		if (!$errors) {
			$result = $this->checkVersion() && $this->model_module_qa->checkDatabaseStructure($this->alert) && $this->checkPrerequisites();
			$this->alert = array_merge($this->alert, $this->model_module_qa->getAlerts());
			return $result;
		} else {
			return false;
		}
	}

	private function validateForm(&$data) {
		$errors = !$this->validate();

		if ((int)$data['qa_new_question_notification']) {
			foreach ((array)$data['qa_notification_emails'] as $language_id => $value) {
				if (empty($value)) {
					$errors = true;
					$this->error["notification_emails"][$language_id]['email'] = $this->language->get('error_missing_email');
				} else {
					$emails = explode(',', $value);

					foreach ($emails as $email) {
						if (!validate_email($email)) {
							$errors = true;
							$this->error["notification_emails"][$language_id]['email'] = $this->language->get('error_email');
						}
					}
				}
			}
		}

		if ((int)$data['qa_form_display_custom_field']) {
			foreach ((array)$data['qa_form_custom_field_name'] as $language_id => $value) {
				if (utf8_strlen(trim($value)) == 0) {
					$errors = true;
					$this->error["form_custom_field_name"][$language_id]['name'] = $this->language->get('error_custom_field_name');
				}
			}
		}

		if (!is_numeric($data['qa_items_per_page']) || (int)$data['qa_items_per_page'] != $data['qa_items_per_page'] || (int)$data['qa_items_per_page'] < 0) {
			$errors = true;
			$this->error['items_per_page'] = $this->language->get('error_items_per_page');
		}

		if ($errors) {
			$this->alert['warning']['warning'] = $this->language->get('error_warning');
		}

		return !$errors;
	}

	private function validateUpgrade() {
		$errors = false;

		if (!$this->user->hasPermission('modify', 'module/qa')) {
			$errors = true;
			$this->alert['error']['permission'] = $this->language->get('error_permission');
		}

		return !$errors;
	}

	private function installedVersion() {
		$installed_version = $this->config->get('qa_installed_version');
		return $installed_version ? $installed_version : '1.6.0';
	}
}
