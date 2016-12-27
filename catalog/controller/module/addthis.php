<?php 
class ControllerModuleAddThis extends Controller  {
	private $moduleName = 'AddThis';
	private $moduleNameSmall = 'addthis';
	private $moduleData_module = 'addthis_module';
	private $moduleModel = 'model_module_addthis';
	
    public function index() {
        $this->load->model('module/'.$this->moduleNameSmall);
       
        $languageVariables= array('heading_title', 'add_to_cart');

        foreach ($languageVariables as $variable) {
            $data[$variable] = $this->language->get($variable);
        }
		
		$data['button_cart'] = $this->language->get('button_cart');
		$data['button_wishlist'] = $this->language->get('button_wishlist');
		$data['button_compare'] = $this->language->get('button_compare');
		$data['text_tax'] = $this->language->get('text_tax');
		
		$this->load->model('catalog/product');
		$this->load->model('tool/image');
		
		$data['products'] = array();
		
		$moduleSetting = $this->{$this->moduleModel}->getSetting($this->moduleNameSmall, $this->config->get('config_store_id'));
        $data['moduleData'] = isset($moduleSetting[$this->moduleNameSmall]) ? $moduleSetting[$this->moduleNameSmall] : array();
		
		if(!isset($data['moduleData']['PanelName'][$this->config->get('config_language')])){
			$data['PanelName'] = $data['heading_title'];
		} else {
			$data['PanelName'] = $data['moduleData']['PanelName'][$this->config->get('config_language')];
		}
		
		if(isset($this->session->data['addthis_products']))
		{
			$reversed = array_reverse($this->session->data['addthis_products']);
			if (isset($this->request->get['product_id'])) {
				if (($key = array_search($this->request->get['product_id'], $reversed)) !== false) unset($reversed[$key]);
			}
		}			

		$ajaxrequest = !empty($_SERVER['HTTP_X_REQUESTED_WITH']) && strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest';
		if(isset($data['product_id'])) {
				$data['product_id'] = $this->request->get['product_id'];
			} else {
				$data['product_id'] = '';
			}
			
			if(version_compare(VERSION, '2.2.0.0', "<")) {
				if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/'.$this->moduleNameSmall.'.tpl')) {
					
					return $this->load->view($this->config->get('config_template') . '/template/module/'.$this->moduleNameSmall.'.tpl', $data);
				 } else {
					 
					 return $this->load->view('default/template/module/'.$this->moduleNameSmall.'.tpl', $data);
				 }
			} else {
				   return $this->load->view('module/'.$this->moduleNameSmall, $data);
			}
	
    }

	public function getindex() {
		$this->response->setOutput($this->index());
	}
	
	public function loglv() {
		// Session variable create
		if(!isset($this->session->data['addthis_products'])) {
			$this->session->data['addthis_products'] = array();
		}
		
		if (isset($this->request->get['product_id'])) {
			if (!in_array($this->request->get['product_id'], $_SESSION['addthis_products'])) {
				$_SESSION['addthis_products'][] = $this->request->get['product_id'];
			} else {
				foreach ($_SESSION['addthis_products'] as $k=>$v) {
					if($v == $this->request->get['product_id']) {
						unset($_SESSION['addthis_products'][$k]);
						$_SESSION['addthis_products'][] = $this->request->get['product_id'];
						$_SESSION['addthis_products'] = array_values($_SESSION['addthis_products']);
					}
				}
			}
		}
		
	}
    
    public function getCatalogURL($store_id){
        if(isset($store_id) && $store_id){
            $storeURL = $this->db->query('SELECT url FROM `'.DB_PREFIX.'store` WHERE store_id=' . $store_id)->row['url'];
        }elseif (isset($_SERVER['HTTPS']) && (($_SERVER['HTTPS'] == 'on') || ($_SERVER['HTTPS'] == '1'))) {
            $storeURL = HTTPS_SERVER;
        } else {
            $storeURL = HTTP_SERVER;
        } 
        return $storeURL;
    }
}
?>