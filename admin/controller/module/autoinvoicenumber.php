<?php
class ControllerModuleAutoInvoiceNumber extends Controller {
	private $error = array();
	
    public function install() {
        $this->load->model('extension/event');
        $this->model_extension_event->addEvent('autoinvoicenumber', 'post.order.add', 'module/autoinvoicenumber/on_order_add');
    }
    
    public function uninstall() {
        $this->load->model('extension/event');
        $this->model_extension_event->deleteEvent('autoinvoicenumber');
    }
    
    public function on_order_add($order_id) {
		$this->load->model('sale/order');
		$invoice_no = $this->model_sale_order->createInvoiceNo($order_id);
		
		if ($invoice_no) {
 			// successful generation of invoice number
		} else {
			$log->write('AutoInvoiceNumber - Failed to generate invoice number for order Id : ' .$order_id );		
		}
    }
	
	public function index() {
		$this->load->language('module/autoinvoicenumber');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('autoinvoicenumber', $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
		}

		$data['heading_title'] = $this->language->get('heading_title');
		
		$data['text_edit'] = $this->language->get('text_edit');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
		
		$data['entry_status'] = $this->language->get('entry_status');

		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_module'),
			'href' => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('module/autoinvoicenumber', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['action'] = $this->url->link('module/autoinvoicenumber', 'token=' . $this->session->data['token'], 'SSL');

		$data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

		if (isset($this->request->post['autoinvoicenumber_status'])) {
			$data['autoinvoicenumber_status'] = $this->request->post['autoinvoicenumber_status'];
		} else {
			$data['autoinvoicenumber_status'] = $this->config->get('autoinvoicenumber_status');
		}
		
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('module/autoinvoicenumber.tpl', $data));
	}

	protected function validate() {
		if (!$this->user->hasPermission('modify', 'module/autoinvoicenumber')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		return !$this->error;
	}
	
}
