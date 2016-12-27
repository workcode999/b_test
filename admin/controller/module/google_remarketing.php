<?php 
class ControllerModuleGoogleRemarketing extends Controller {
	function index()
	{
		$this->load->language('module/google_remarketing');

		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('google_remarketing', $this->request->post);
			$this->session->data['success'] = $this->language->get('guardado_exito');			
			$this->response->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
		}

		if (isset($this->session->data['error']))
			$data['error'] = $this->session->data['error'];


		if (isset($this->session->data['success']))
			$data['success'] = $this->session->data['success'];

		unset($this->session->data['error']);
		unset($this->session->data['success']);
		
		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}


		$this->document->setTitle($this->language->get('heading_title'));

		if (isset($this->request->post['google_remarketing_status'])) {
			$data['google_remarketing_status'] = $this->request->post['google_remarketing_status'];
		} else {
			$data['google_remarketing_status'] = $this->config->get('google_remarketing_status');
		}

		if (isset($this->request->post['google_remarketing_code'])) {
			$data['google_remarketing_code'] = $this->request->post['google_remarketing_code'];
		} else {
			$data['google_remarketing_code'] = $this->config->get('google_remarketing_code');
		}

		if (isset($this->request->post['google_remarketing_type'])) {
			$data['google_remarketing_type'] = $this->request->post['google_remarketing_type'];
		} else {
			$data['google_remarketing_type'] = $this->config->get('google_remarketing_type');
		}

		if (isset($this->request->post['google_remarketing_code'])) {
			$data['google_remarketing_code'] = $this->request->post['google_remarketing_code'];
		} else {
			$data['google_remarketing_code'] = $this->config->get('google_remarketing_code');
		}

		if (isset($this->request->post['google_remarketing_id_suffix'])) {
			$data['google_remarketing_id_suffix'] = $this->request->post['google_remarketing_id_suffix'];
		} else {
			$data['google_remarketing_id_suffix'] = $this->config->get('google_remarketing_id_suffix');
		}

		if (isset($this->request->post['google_remarketing_id_preffix'])) {
			$data['google_remarketing_id_preffix'] = $this->request->post['google_remarketing_id_preffix'];
		} else {
			$data['google_remarketing_id_preffix'] = $this->config->get('google_remarketing_id_preffix');
		}	

		//Actions
		$data['action'] = $this->url->link('module/google_remarketing', 'token=' . $this->session->data['token'], 'SSL');
		$data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');	

		//Enviamos variables de idioma
			$array_lang = array(
				'heading_title',
				'button_save',
				'button_cancel',
				'status',
				'active',
				'disabled',
				'type',
				'type_standard',
				'type_dynamic',
				'insert_id_suffix',
				'insert_id_preffix',
				'insert_code_dynamic',
				'insert_code_standard',
				'entry_status',
				'text_edit',
				'text_enabled',
				'text_disabled',
				'insert_id_suffix_help',
				'insert_id_preffix_help',
				'insert_code_dynamic_help',
				'insert_code_standard_help',
				//Footer
				'footer1',
				'footer2',
				'footer3',
				'footer4',			
				'footer5'
			);

			foreach ($array_lang as $key => $value) {
				$data[$value] = $this->language->get($value);
			}

		//FIN Enviamos variables de idioma	

		$data['breadcrumbs'] = array();
 
        $data['breadcrumbs'][] = array(
            'text'      => $this->language->get('text_home'),
            'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => false
        );

        $data['breadcrumbs'][] = array(
            'text'      => $this->language->get('text_modules'),
            'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );
 
        $data['breadcrumbs'][] = array(
            'text'      => $this->language->get('heading_title'),
            'href'      => $this->url->link('module/google_remarketing', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('module/google_remarketing.tpl', $data));
	}
	function validate(){
		if (!$this->user->hasPermission('modify', 'module/google_remarketing')) {
			$this->session->data['error'] = $this->language->get('error_permission');
			return false;
		}
		return true;
	}
}
?>