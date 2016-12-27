<?php
class ControllerDashboardQA extends Controller {
	public function index() {
		if (!$this->config->get('qa_status')) {
			return;
		}
		$this->load->language('dashboard/qa');

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_view'] = $this->language->get('text_view');

		$data['token'] = $this->session->data['token'];

		// Total Questions
		$this->load->model('catalog/qa');

		$today = $this->model_catalog_qa->getTotalQuestions(array('filter_date_asked' => date('Y-m-d', strtotime('-1 day'))));

		$yesterday = $this->model_catalog_qa->getTotalQuestions(array('filter_date_asked' => date('Y-m-d', strtotime('-2 day'))));

		$difference = $today - $yesterday;

		if ($difference && $today) {
			$data['percentage'] = round(($difference / $today) * 100);
		} else {
			$data['percentage'] = 0;
		}

		$qa_total = $this->model_catalog_qa->getTotalQuestions();

		if ($qa_total > 1000000000000) {
			$data['total'] = round($qa_total / 1000000000000, 1) . 'T';
		} elseif ($qa_total > 1000000000) {
			$data['total'] = round($qa_total / 1000000000, 1) . 'B';
		} elseif ($qa_total > 1000000) {
			$data['total'] = round($qa_total / 1000000, 1) . 'M';
		} elseif ($qa_total > 1000) {
			$data['total'] = round($qa_total / 1000, 1) . 'K';
		} else {
			$data['total'] = $qa_total;
		}

		$data['qa'] = $this->url->link('catalog/qa', 'token=' . $this->session->data['token'], true);

		if (version_compare(VERSION, '2.2.0', '>=')) {
			$template = 'dashboard/qa';
		} else {
			$template = 'dashboard/qa.tpl';
		}
		return $this->load->view($template, $data);
	}
}
