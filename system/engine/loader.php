<?php
final class Loader {
	private $registry;

	public function __construct($registry) {
		$this->registry = $registry;
	}

	public function controller($route, $args = array()) {
		$action = new Action($route, $args);

			$cache  = new Cache('file');
			global $config;
			$cached_children = $config->get('config_cached_routes');
			
			if (!is_array($cached_children)) {
				$cached_children = array();
			}

			$cached_name = 'wxblc.' . str_replace('/', '-', $route) . '.' . (int)$config->get('config_language_id') . '.' . (int)$config->get('config_store_id') . (!empty($args) ? '.' . md5(serialize($args)) : '');
			
			$cached_output = $cache->get($cached_name);
			if (!defined("DIR_CATALOG") && in_array($route, $cached_children) && $cached_output) {
				return $cached_output;
			} else {
				$return = $action->execute($this->registry);
				if (!defined("DIR_CATALOG") && in_array($route, $cached_children)) {
					$cache->set($cached_name, $return);
				}
				return $return;
			}
	}

	public function model($model) {
		$file = DIR_APPLICATION . 'model/' . $model . '.php';
		$class = 'Model' . preg_replace('/[^a-zA-Z0-9]/', '', $model);

		if (file_exists($file)) {
			include_once($file);

			$this->registry->set('model_' . str_replace('/', '_', $model), new $class($this->registry));
		} else {
			trigger_error('Error: Could not load model ' . $file . '!');
			exit();
		}
	}

	public function view($template, $data = array()) {
		$file = DIR_TEMPLATE . $template;

		if (file_exists($file)) {
			extract($data);

			ob_start();

			require($file);

			$output = ob_get_contents();

			ob_end_clean();

			return $output;
		} else {
			trigger_error('Error: Could not load template ' . $file . '!');
			exit();
		}
	}

	public function library($library) {
		$file = DIR_SYSTEM . 'library/' . $library . '.php';

		if (file_exists($file)) {
			include_once($file);
		} else {
			trigger_error('Error: Could not load library ' . $file . '!');
			exit();
		}
	}

	public function helper($helper) {
		$file = DIR_SYSTEM . 'helper/' . $helper . '.php';

		if (file_exists($file)) {
			include_once($file);
		} else {
			trigger_error('Error: Could not load helper ' . $file . '!');
			exit();
		}
	}

	public function config($config) {
		$this->registry->get('config')->load($config);
	}

	public function language($language) {
		return $this->registry->get('language')->load($language);
	}
}