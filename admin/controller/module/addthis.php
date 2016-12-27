<?php
class ControllerModuleAddThis extends Controller {
	private $moduleName = 'AddThis';
	private $moduleNameSmall = 'addthis';
	private $moduleData_module = 'addthis_module';
	private $moduleModel = 'model_module_addthis';
	private $error = array();
	private $version = '2.0.2';
	
    public function index() { 
		$data['moduleName'] = $this->moduleName;
		$data['moduleNameSmall'] = $this->moduleNameSmall;
		$data['moduleData_module'] = $this->moduleData_module;
		$data['moduleModel'] = $this->moduleModel;
	 
        $this->load->language('module/'.$this->moduleNameSmall);
        $this->load->model('module/'.$this->moduleNameSmall);
        $this->load->model('setting/store');
        $this->load->model('localisation/language');
        $this->load->model('design/layout');
		
        $catalogURL = $this->getCatalogURL();
 
        $this->document->addStyle('view/stylesheet/'.$this->moduleNameSmall.'/'.$this->moduleNameSmall.'.css');
        $this->document->setTitle($this->language->get('heading_title'));

        if(!isset($this->request->get['store_id'])) {
           $this->request->get['store_id'] = 0; 
        }
	
        $store = $this->getCurrentStore($this->request->get['store_id']);
		
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) { 	           

        	$this->{$this->moduleModel}->editSetting($this->moduleNameSmall, $this->request->post, $this->request->post['store_id']);
            $this->session->data['success'] = $this->language->get('text_success');
			
            $this->response->redirect($this->url->link('module/'.$this->moduleNameSmall, 'store_id='.$this->request->post['store_id'] . '&token=' . $this->session->data['token'], 'SSL'));
        }		
		
		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];
			unset($this->session->data['success']);
		} else {
			$data['success'] = '';
		}
		
		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}
		
		if (isset($this->error['ID'])){
			$data['error_id'] = $this->error['ID'];
		} else {
			$data['error_id'] = "";
		}
		
        $data['breadcrumbs']   = array();
        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL'),
        );
        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_module'),
            'href' => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
        );
        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('heading_title'),
            'href' => $this->url->link('module/'.$this->moduleNameSmall, 'token=' . $this->session->data['token'], 'SSL'),
        );

        $languageVariables = array(
		    // Main
			'heading_title',
			'error_permission',
			'text_success',
			'text_enabled',
			'text_disabled',
			'button_cancel',
			'save_changes',
			'text_default',
			'text_module',
			// Control panel
            'entry_code',
			'entry_code_help',
			'entry_addthis',
			'entry_addthis_help',
            'text_content_top', 
            'text_content_bottom',
            'text_column_left', 
            'text_column_right',
            'entry_layout',         
            'entry_position',       
            'entry_status',         
            'entry_sort_order',     
            'entry_layout_options',  
            'entry_position_options',
			'entry_action_options',
            'button_add_module',
            'button_remove',
			// Custom CSS
			'custom_css',
            'custom_css_help',
            'custom_css_placeholder',
			// Module depending
			'wrap_widget',
			'wrap_widget_help',
			'text_products',
			'text_products_help',
			'text_image_dimensions',
			'text_image_dimensions_help',
			'text_pixels',
			'text_inherent_design',
			'text_inherent_design_help',
			'text_enable_customization',
			'text_enable_customization_help',
			'text_id',
			'text_custom_url',
			'text_custom_url_help',
			'text_custom_title',
			'text_custom_title_help',
            'text_id_help',
			'text_id_help_two',
			'text_buttons_design',
            'text_buttons_design_help',
			'text_recommended',
			'text_recommended_help',
			'whats_next',
			'recommended_footer',
			'horizontal_content',
			'vertical_content',			
			'sharing_buttons',
			'sharing_sidebar',
			'mobile_toolbar',
			'custom_status',
			'custom_status_help',
			'custom_enabled',
			'custom_disabled',
			'original_sharing_buttons',
			'horizontal_follow_buttons',
			'vertical_follow_buttons',
			'text_products_small',
			'show_add_to_cart',
			'show_add_to_cart_help'
        );
       
        foreach ($languageVariables as $languageVariable) {
            $data[$languageVariable] = $this->language->get($languageVariable);
        }
 		$data['heading_title'] = $data['heading_title'].' '.$this->version;
        $data['stores'] = array_merge(array(0 => array('store_id' => '0', 'name' => $this->config->get('config_name') . ' (' . $data['text_default'].')', 'url' => HTTP_SERVER, 'ssl' => HTTPS_SERVER)), $this->model_setting_store->getStores());
        $data['languages']              = $this->model_localisation_language->getLanguages();
        $data['store']                  = $store;
        $data['token']                  = $this->session->data['token'];
        $data['action']                 = $this->url->link('module/'.$this->moduleNameSmall, 'token=' . $this->session->data['token'], 'SSL');
        $data['cancel']                 = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
        $data['moduleSettings']			= $this->{$this->moduleModel}->getSetting($this->moduleNameSmall, $store['store_id']);
        $data['catalog_url']			= $catalogURL;
		
		$data['moduleData']				= isset($data['moduleSettings'][$this->moduleNameSmall]) ? $data['moduleSettings'][$this->moduleNameSmall] : array ();

		if ($this->config->get('featured_status')) {
			$data['addthis_status'] = $this->config->get('addthis_status');
		} else {
			$data['addthis_status'] = '0';
		}
		
		$data['addthis_modules'] = array();
		if (isset($data['moduleSettings']['addthis_module'])) {
			foreach ($data['moduleSettings']['addthis_module'] as $key => $module) {
				$data['addthis_modules'][] = array(
					'key'    => $key,
					'limit'  => $module['limit'],
					'width'  => $module['width'],
					'height' => $module['height']
				);
			}
		}
		
		$data['header']					= $this->load->controller('common/header');
		$data['column_left']			= $this->load->controller('common/column_left');
		$data['footer']					= $this->load->controller('common/footer');
		
		$this->response->setOutput($this->load->view('module/'.$this->moduleNameSmall.'.tpl', $data));
    }
	
	protected function validateForm() {
		if (!$this->user->hasPermission('modify', 'module/'.$this->moduleNameSmall)) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		if (!$this->request->post['addthis']['ID'] && isset($this->request->post['addthis']['Enabled']) && $this->request->post['addthis']['Enabled'] == 'yes') {
			$this->error['ID'] = $this->language->get('error_id');
		}
		
		return !$this->error;
	}

    private function getCatalogURL() {
        if (isset($_SERVER['HTTPS']) && (($_SERVER['HTTPS'] == 'on') || ($_SERVER['HTTPS'] == '1'))) {
            $storeURL = HTTPS_CATALOG;
        } else {
            $storeURL = HTTP_CATALOG;
        } 
        return $storeURL;
    }

    private function getServerURL() {
        if (isset($_SERVER['HTTPS']) && (($_SERVER['HTTPS'] == 'on') || ($_SERVER['HTTPS'] == '1'))) {
            $storeURL = HTTPS_SERVER;
        } else {
            $storeURL = HTTP_SERVER;
        } 
        return $storeURL;
    }

    private function getCurrentStore($store_id) {    
        if($store_id && $store_id != 0) {
            $store = $this->model_setting_store->getStore($store_id);
        } else {
            $store['store_id'] = 0;
            $store['name'] = $this->config->get('config_name');
            $store['url'] = $this->getCatalogURL(); 
        }
        return $store;
    }
    
    public function install() {
	    $this->load->model('module/'.$this->moduleNameSmall);
	    $this->{$this->moduleModel}->install();
    }
    
    public function uninstall() {
    	$this->load->model('setting/setting');
		
		$this->load->model('setting/store');
		$this->model_setting_setting->deleteSetting($this->moduleData_module,0);
		$stores=$this->model_setting_store->getStores();
		foreach ($stores as $store) {
			$this->model_setting_setting->deleteSetting($this->moduleData_module, $store['store_id']);
		}
		
        $this->load->model('module/'.$this->moduleNameSmall);
        $this->{$this->moduleModel}->uninstall();
    }
}

?>