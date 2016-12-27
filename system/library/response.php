<?php
class Response {
	private $headers = array();
	private $level = 0;
	private $output;

	public function addHeader($header) {
		$this->headers[] = $header;
	}

	public function redirect($url, $status = 302) {
		header('Location: ' . str_replace(array('&amp;', "\n", "\r"), array('&', '', ''), $url), true, $status);
		exit();
	}

	public function setCompression($level) {
		$this->level = $level;
	}

	public function setOutput($output) {
		global $config;
		global $db;
		$min = new OC_Minify;

		if ($config->get('config_minify_javascript') && !defined('DIR_CATALOG')) {
			$output = $min->minifyJavascript($output);
		}

		if ($config->get('config_minify_css') && !defined('DIR_CATALOG')) {
			$output = $min->minifyCSS($output);
		}

		if ($config->get('config_cdn_status') && !defined('DIR_CATALOG')) {
			$cdn_domain = (isset($_SERVER['HTTPS']) && (($_SERVER['HTTPS'] == 'on') || ($_SERVER['HTTPS'] == '1'))) ? $config->get('config_cdn_https') : $config->get('config_cdn_http');
			$http_image = (isset($_SERVER['HTTPS']) && (($_SERVER['HTTPS'] == 'on') || ($_SERVER['HTTPS'] == '1'))) ? HTTPS_SERVER . 'image/' : HTTP_SERVER . 'image/';
			if ($config->get('config_cdn_images')) {
				$output = str_replace($http_image, $cdn_domain . '/image/', $output);
				$output = str_replace('src="image/', 'src="' . $cdn_domain . '/image/', $output);
				if ($config->get('config_store_id')) {
					if ($config->get('config_ssl')) {
						$output = str_replace($config->get('config_ssl') . 'image/', $cdn_domain . '/image/', $output);
						$output = str_replace('src="image/', 'src="' . $cdn_domain . '/image/', $output);
					}
					if ($config->get('config_url')) {
						$output = str_replace($config->get('config_url') . 'image/', $cdn_domain . '/image/', $output);
						$output = str_replace('src="image/', 'src="' . $cdn_domain . '/image/', $output);
					}
				}
				$output = str_replace('src="/image/data', 'src="' . $cdn_domain . '/image/data', $output);
				$output = str_replace('src="catalog/view/theme/' . $config->get("config_template") . '/image/', 'src="' . $cdn_domain . '/catalog/view/theme/' . $config->get("config_template") . '/image/', $output);
				$output = str_replace('src="catalog/view/theme/default/image/', 'src="' . $cdn_domain . '/catalog/view/theme/default/image/', $output);
			}
			if ($config->get('config_cdn_js')) {
				$output = str_replace('src="catalog/view/javascript/', 'src="' . $cdn_domain . '/catalog/view/javascript/', $output);
			}
			if ($config->get('config_cdn_css')) {
				$output = str_replace('href="catalog/view/theme/' . $config->get("config_template") . '/stylesheet/', 'href="' . $cdn_domain . '/catalog/view/theme/' . $config->get("config_template") . '/stylesheet/', $output);
				$output = str_replace('href="catalog/view/theme/default/stylesheet/', 'href="' . $cdn_domain . '/catalog/view/theme/default/stylesheet/', $output);
			}
		}
		
		if ($config->get('config_javascript_defer') && !defined('DIR_CATALOG') && strpos($output, '</body>') !== FALSE) {
			$output = preg_replace('~type="text\/javascript"~', 'type="text/psajs" pagespeed_orig_type="text/javascript"', $output);
			$output = str_replace('<script>', '<script type="text/psajs">', $output);
			$output = str_replace('text/psa-donotdefer', 'text/javascript', $output);
			$output = str_replace('</body>', '<script type="text/javascript" src="catalog/view/javascript/page_speed/js_defer.js" async defer></script></body>',$output);
		}

		if ($config->get('config_minify_html') && !defined('DIR_CATALOG') && json_decode($output) == null) {
			preg_match_all('!(<script.*?>.*?</script>)!is',$output,$pre);
			$output = preg_replace('!(<script.*?>.*?</script>)!is', '#pre#', $output);
			$output = preg_replace('/[\r\n\t]+/', ' ', $output);
			$output = preg_replace('/>\s+</', '><', $output);
			$output = preg_replace('/\s+/', ' ', $output);
			if (!empty($pre[0])) {
				foreach ($pre[0] as $original) {
					$output = preg_replace('!#pre#!', $original, $output,1);
				}
			}
		}
		$this->output = $output;
	}
	
	public function getOutput() {
		return $this->output;
	}

	private function compress($data, $level = 0) {
		if (isset($_SERVER['HTTP_ACCEPT_ENCODING']) && (strpos($_SERVER['HTTP_ACCEPT_ENCODING'], 'gzip') !== false)) {
			$encoding = 'gzip';
		}

		if (isset($_SERVER['HTTP_ACCEPT_ENCODING']) && (strpos($_SERVER['HTTP_ACCEPT_ENCODING'], 'x-gzip') !== false)) {
			$encoding = 'x-gzip';
		}

		if (!isset($encoding) || ($level < -1 || $level > 9)) {
			return $data;
		}

		if (!extension_loaded('zlib') || ini_get('zlib.output_compression')) {
			return $data;
		}

		if (headers_sent()) {
			return $data;
		}

		if (connection_status()) {
			return $data;
		}

		$this->addHeader('Content-Encoding: ' . $encoding);

		return gzencode($data, (int)$level);
	}

	public function output() {
		if ($this->output) {
			if ($this->level) {
				$output = $this->compress($this->output, $this->level);
			} else {
				$output = $this->output;
			}

			if (!headers_sent()) {
				foreach ($this->headers as $header) {
					header($header, true);
				}
			}

			echo $output;
		}
	}
}