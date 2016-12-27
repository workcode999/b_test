<?php 

class ControllerFeedStoreya extends Controller {

	private $error = array(); 

	

	public function index() {

		$this->load->language('feed/storeya');



		$this->document->setTitle($this->language->get('heading_title'));

		

		$this->load->model('setting/setting');

			

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {

			$this->model_setting_setting->editSetting('storeya', $this->request->post);				

			

			$this->session->data['success'] = $this->language->get('text_success');



			$this->response->redirect($this->url->link('extension/feed', 'token=' . $this->session->data['token'], 'SSL'));

		}



		$data['heading_title'] = $this->language->get('heading_title');

		

		$data['text_enabled'] = $this->language->get('text_enabled');

		$data['text_disabled'] = $this->language->get('text_disabled');

		

		$data['entry_status'] = $this->language->get('entry_status');

		$data['entry_data_feed'] = $this->language->get('entry_data_feed');

		

		$data['button_save'] = $this->language->get('button_save');

		$data['button_cancel'] = $this->language->get('button_cancel');



		$data['tab_general'] = $this->language->get('tab_general');



 		if (isset($this->error['warning'])) {

			$data['error_warning'] = $this->error['warning'];

		} else {

			$data['error_warning'] = '';

		}

		

  		$data['breadcrumbs'] = array();



   		$data['breadcrumbs'][] = array(

       		'text'      => $this->language->get('text_home'),

			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),

      		'separator' => false

   		);



   		$data['breadcrumbs'][] = array(

       		'text'      => $this->language->get('text_feed'),

			'href'      => $this->url->link('extension/feed', 'token=' . $this->session->data['token'], 'SSL'),

      		'separator' => ' :: '

   		);



   		$data['breadcrumbs'][] = array(

       		'text'      => $this->language->get('heading_title'),

			'href'      => $this->url->link('feed/storeya', 'token=' . $this->session->data['token'], 'SSL'),

      		'separator' => ' :: '

   		);

				
		
		$data['action'] = $this->url->link('feed/storeya', 'token=' . $this->session->data['token'], 'SSL');

		

		$data['cancel'] = $this->url->link('extension/feed', 'token=' . $this->session->data['token'], 'SSL');

		

		if (isset($this->request->post['storeya_status'])) {

			$data['storeya_status'] = $this->request->post['storeya_status'];

			$data['storeya_fromcount'] = $this->request->post['storeya_fromcount'];

			$data['storeya_tocount'] = $this->request->post['storeya_tocount'];

			$data['storeya_currency'] = $this->request->post['storeya_currency'];

			$data['storeya_language'] = $this->request->post['storeya_language'];

		} else {

			$data['storeya_status'] = $this->config->get('storeya_status');

			$data['storeya_fromcount'] = $this->config->get('storeya_fromcount');

			$data['storeya_tocount'] = $this->config->get('storeya_tocount');

			$data['storeya_currency'] = $this->config->get('storeya_currency');

			$data['storeya_language'] = $this->config->get('storeya_language');

		}

		

		$this->load->model('localisation/currency');

		$mydata=array();

		$currencies = $this->model_localisation_currency->getCurrencies($mydata);

		foreach ($currencies as $result) {

				

			$data['currencies'][] = array(

				'currency_id'   => $result['currency_id'],

				'title'         => $result['title'],

				'code'          => $result['code'],

				'value'         => $result['value']								

			);

		}	

		

		$this->load->model('localisation/language');

		$languages = $this->model_localisation_language->getLanguages($data);



		foreach ($languages as $result) {

								

			$data['languages'][] = array(

				'language_id' => $result['language_id'],

				'name'        => $result['name'] ,

				'code'        => $result['code']				

			);		

		}

		
		$data['text_edit'] = 'Edit';
		$data['data_feed'] = HTTP_CATALOG . 'index.php?route=feed/storeya';



		$data['header'] = $this->load->controller('common/header');

		$data['column_left'] = $this->load->controller('common/column_left');

		$data['footer'] = $this->load->controller('common/footer');



		$this->response->setOutput($this->load->view('feed/storeya.tpl', $data));

	} 

	

	protected function validate() {

		if (!$this->user->hasPermission('modify', 'feed/storeya')) {

			$this->error['warning'] = $this->language->get('error_permission');

		}



		return !$this->error;

	}

}

?>