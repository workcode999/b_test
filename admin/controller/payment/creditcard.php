<?php 
class ControllerPaymentCreditCard extends Controller {
	private $error = array(); 

	public function index() {
		$this->load->language('payment/creditcard');
		
		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('setting/setting');
			
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && ($this->validate())) {
			$this->load->model('setting/setting');
			
			$this->model_setting_setting->editSetting('creditcard', $this->request->post);				
			
			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('extension/payment', 'token=' . $this->session->data['token'], 'SSL'));
		}

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
		$data['text_all_zones'] = $this->language->get('text_all_zones');

		$data['text_really'] = $this->language->get('text_really');
		$data['text_test'] = $this->language->get('text_test');
		
		$data['entry_merchantid'] = $this->language->get('entry_merchantid');
		$data['entry_gatewayno'] = $this->language->get('entry_gatewayno');
		$data['entry_signkey'] = $this->language->get('entry_signkey');
		$data['entry_gateway'] = $this->language->get('entry_gateway');

		$data['entry_order_status'] = $this->language->get('entry_order_status');	

		$data['entry_success_order_status']=$this->language->get('entry_success_order_status');
		$data['entry_failed_order_status']=$this->language->get('entry_failed_order_status');
		
		
		$data['entry_geo_zone'] = $this->language->get('entry_geo_zone');
		$data['entry_status'] = $this->language->get('entry_status');
		$data['entry_sort_order'] = $this->language->get('entry_sort_order');

		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');



 		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

 		if (isset($this->error['merchant'])) {
			$data['error_merchant'] = $this->error['merchant'];
		} else {
			$data['error_merchant'] = '';
		}

		if (isset($this->error['gatewayno'])) {
			$data['error_gatewayno'] = $this->error['gatewayno'];
		} else {
			$data['error_gatewayno'] = '';
		}		
		
 		if (isset($this->error['signkey'])) {
			$data['error_signkey'] = $this->error['signkey'];
		} else {
			$data['error_signkey'] = '';
		}

  		$data['breadcrumbs'] = array();

   		$data['breadcrumbs'][] = array(
       		'href'      => HTTPS_SERVER . 'index.php?route=common/home&token='. $this->session->data['token'],
       		'text'      => $this->language->get('text_home'),
      		'separator' => FALSE
   		);

   		$data['breadcrumbs'][] = array(
       		'href'      => HTTPS_SERVER . 'index.php?route=extension/payment&token='. $this->session->data['token'],
       		'text'      => $this->language->get('text_payment'),
      		'separator' => ' :: '
   		);

   		$data['breadcrumbs'][] = array(
       		'href'      => HTTPS_SERVER . 'index.php?route=payment/creditcard&token='. $this->session->data['token'],
       		'text'      => $this->language->get('heading_title'),
      		'separator' => ' :: '
   		);
				
		$data['action'] = HTTPS_SERVER . 'index.php?route=payment/creditcard&token='. $this->session->data['token'];
		
		$data['cancel'] = HTTPS_SERVER . 'index.php?route=extension/payment&token='. $this->session->data['token'];
		
		if (isset($this->request->post['creditcard_merchant'])) {
			$data['creditcard_merchant'] = $this->request->post['creditcard_merchant'];
		} else {
			$data['creditcard_merchant'] = $this->config->get('creditcard_merchant');
		}
		
		if (isset($this->request->post['creditcard_gatewayno'])) {
			$data['creditcard_gatewayno'] = $this->request->post['creditcard_gatewayno'];
		} else {
			$data['creditcard_gatewayno'] = $this->config->get('creditcard_gatewayno');
		}
		
		if (isset($this->request->post['creditcard_signkey'])) {
			$data['creditcard_signkey'] = $this->request->post['creditcard_signkey'];
		} else {
			$data['creditcard_signkey'] = $this->config->get('creditcard_signkey');
		}
		
		$data['callback'] = HTTP_CATALOG . 'index.php?route=payment/creditcard/callback';

		
		if (isset($this->request->post['creditcard_gateway'])) {
			$data['creditcard_gatewaycurrency'] = $this->request->post['creditcard_gateway'];
		} else {
			$data['creditcard_gateway'] = $this->config->get('creditcard_gateway');
		}
		
		if (isset($this->request->post['creditcard_order_status_id'])) {
			$data['creditcard_order_status_id'] = $this->request->post['creditcard_order_status_id'];
		} else {
			$data['creditcard_order_status_id'] = $this->config->get('creditcard_order_status_id'); 
		} 
		/* add status */
		if (isset($this->request->post['creditcard_success_order_status_id'])) {
			$data['creditcard_success_order_status_id'] = $this->request->post['creditcard_success_order_status_id'];
		} else {
			$data['creditcard_success_order_status_id'] = $this->config->get('creditcard_success_order_status_id'); 
		} 
		if (isset($this->request->post['creditcard_failed_order_status_id'])) {
			$data['creditcard_failed_order_status_id'] = $this->request->post['creditcard_failed_order_status_id'];
		} else {
			$data['creditcard_failed_order_status_id'] = $this->config->get('creditcard_failed_order_status_id'); 
		} 

		
		
		$this->load->model('localisation/order_status');
		
		$data['order_statuses'] = $this->model_localisation_order_status->getOrderStatuses();
		
		if (isset($this->request->post['creditcard_geo_zone_id'])) {
			$data['creditcard_geo_zone_id'] = $this->request->post['creditcard_geo_zone_id'];
		} else {
			$data['creditcard_geo_zone_id'] = $this->config->get('creditcard_geo_zone_id'); 
		} 

		$this->load->model('localisation/geo_zone');
										
		$data['geo_zones'] = $this->model_localisation_geo_zone->getGeoZones();
		
		if (isset($this->request->post['creditcard_status'])) {
			$data['creditcard_status'] = $this->request->post['creditcard_status'];
		} else {
			$data['creditcard_status'] = $this->config->get('creditcard_status');
		}
		
		if (isset($this->request->post['creditcard_sort_order'])) {
			$data['creditcard_sort_order'] = $this->request->post['creditcard_sort_order'];
		} else {
			$data['creditcard_sort_order'] = $this->config->get('creditcard_sort_order');
		}
		
		$this->template = 'payment/creditcard.tpl';
		$this->children = array(
			'common/header',	
			'common/footer'	
		);
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');
		$this->response->setOutput($this->load->view('payment/creditcard.tpl', $data), $this->config->get('config_compression'));
	}

	private function validate() {
		if (!$this->user->hasPermission('modify', 'payment/creditcard')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		if (!$this->request->post['creditcard_merchant']) {
			$this->error['merchant'] = $this->language->get('error_merchant');
		}

		if (!$this->request->post['creditcard_gatewayno']) {
			$this->error['gatewayno'] = $this->language->get('error_gatewayno');
		}		
		
		if (!$this->request->post['creditcard_signkey']) {
			$this->error['signkey'] = $this->language->get('error_signkey');
		}
		
		if (!$this->error) {
			return TRUE;
		} else {
			return FALSE;
		}	
	}
}
?>
