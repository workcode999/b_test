<?php

class ModelModuleEmailTemplate extends Model {

	public function __construct($registry) {
		parent::__construct($registry);
		$this->load->library('emailtemplate/email_template');
	}

	/**
	 * Get Email Template Config
	 *
	 * @param int||array $identifier
	 * @param bool $outputFormatting
	 * @param bool $keyCleanUp
	 * @return array
	 */
	public function getConfig($data, $outputFormatting = false, $keyCleanUp = false) {
		$cond = array();

		if (is_array($data)) {
			if (isset($data['store_id'])) {
				$cond[] = "`store_id` = '".intval($data['store_id'])."'";
			}
			if (isset($data['language_id'])) {
				$cond[] = "(`language_id` = '".intval($data['language_id'])."' OR `language_id` = 0)";
			}
		} elseif (is_numeric($data)) {
			$cond[] = "`emailtemplate_config_id` = '" . intval($data) . "'";
		} else {
			return false;
		}

		$query = "SELECT * FROM " . DB_PREFIX . "emailtemplate_config";
		if (!empty($cond)) {
			$query .= " WHERE " . implode(" AND ", $cond);
		}
		$query .= " ORDER BY `language_id` DESC LIMIT 1";

		$result = $this->_fetch($query);
		if (empty($result->row)) return false;
		$row = $result->row;

		$cols = EmailTemplateConfigDAO::describe();
		foreach($cols as $col => $type) {
			if (isset($row[$col]) && $type == EmailTemplateConfigDAO::SERIALIZE) {
				if ($row[$col]) {
					$row[$col] = unserialize(base64_decode($row[$col]));
				}
			}
		}

		if ($outputFormatting) {
			$row = $this->formatConfig($row);
		}

		if ($outputFormatting) {
			foreach($row as $col => $val) {
				$key = (strpos($col, 'emailtemplate_config_') === 0 && substr($col, -3) != '_id') ? substr($col, 21) : $col;
				if (!isset($row[$key])) {
					unset($row[$col]);
					$row[$key] = $val;
				}
			}
		}

		return $row;
	}

	/**
	 * Return array of configs
	 * @param array - $data
	 */
	public function getConfigs($data = array(), $outputFormatting = false) {
		$cond = array();

		if (isset($data['language_id'])) {
			$cond[] = "AND ec.`language_id` = '".intval($data['language_id'])."'";
		} elseif (isset($data['_language_id'])) {
			$cond[] = "OR ec.`language_id` = '".intval($data['_language_id'])."'";
		}

		if (isset($data['store_id'])) {
			$cond[] = "AND ec.`store_id` = '".intval($data['store_id'])."'";
		} elseif (isset($data['_store_id'])) {
			$cond[] = "OR ec.`store_id` = '".intval($data['_store_id'])."'";
		}

		if (isset($data['customer_group_id'])) {
			$cond[] = "AND ec.`customer_group_id` = '".intval($data['customer_group_id'])."'";
		} elseif (isset($data['_customer_group_id'])) {
			$cond[] = "OR ec.`customer_group_id` = '".intval($data['_customer_group_id'])."'";
		}

		if (isset($data['emailtemplate_config_id'])) {
			if (is_array($data['emailtemplate_config_id'])) {
				$ids = array();
				foreach($data['emailtemplate_config_id'] as $id) { $ids[] = intval($id); }
				$cond[] = "AND ec.`emailtemplate_config_id` IN('".implode("', '", $ids)."')";
			} else {
				$cond[] = "AND ec.`emailtemplate_config_id` = '".intval($data['emailtemplate_config_id'])."'";
			}
		}

		if (isset($data['status']) && $data['status'] != "") {
			$cond[] = "AND ec.`emailtemplate_config_status` = '".$this->db->escape($data['status'])."'";
		} else {
			$cond[] = "AND ec.`emailtemplate_config_status` = 1";
		}

		$query = "SELECT ec.* FROM " . DB_PREFIX . "emailtemplate_config ec";
		if (!empty($cond)) {
			$query .= ' WHERE ' . ltrim(implode(' ', $cond), 'AND');
		}

		$sort_data = array(
			'ec.emailtemplate_config_id',
			'ec.emailtemplate_config_name',
			'ec.emailtemplate_config_modified',
			'ec.store_id',
			'ec.language_id',
			'ec.customer_group_id'
		);
		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$query .= " ORDER BY `" . $data['sort'] . "`";
		} else {
			$query .= " ORDER BY ec.`emailtemplate_config_name`";
		}

		if (isset($data['order']) && ($data['order'] == 'DESC')) {
			$query .= " DESC";
		} else {
			$query .= " ASC";
		}

		if (isset($data['start']) || isset($data['limit'])) {
			if ($data['start'] < 0) {
				$data['start'] = 0;
			}
			if ($data['limit'] < 1) {
				$data['limit'] = 20;
			}
			$query .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
		}

		$result = $this->_fetch($query);
		if (empty($result->rows)) return array();
		$rows = $result->rows;

		$cols = EmailTemplateConfigDAO::describe();
		foreach($rows as $key => $row) {
			foreach($cols as $col => $type) {
				if (isset($row[$col]) && $type == EmailTemplateConfigDAO::SERIALIZE) {
					if ($row[$col]) {
						$row[$col] = unserialize(base64_decode($row[$col]));
					}
				}
			}
			$rows[$key] = $row;
		}

		return $rows;
	}


	/**
	 * Return array of configs
	 *
	 * @param array - $data
	 */
	public function formatConfig($data = array()) {
		$this->load->model('tool/image');

		$data['emailtemplate_config_head_text'] = html_entity_decode($data['emailtemplate_config_head_text'], ENT_QUOTES, 'UTF-8');
		$data['emailtemplate_config_page_footer_text'] = html_entity_decode($data['emailtemplate_config_page_footer_text'], ENT_QUOTES, 'UTF-8');
		$data['emailtemplate_config_footer_text'] = html_entity_decode($data['emailtemplate_config_footer_text'], ENT_QUOTES, 'UTF-8');

		foreach(array('left', 'right') as $col) {
			if (isset($data['emailtemplate_config_shadow_top'][$col.'_img']) && file_exists(DIR_IMAGE . $data['emailtemplate_config_shadow_top'][$col.'_img'])) {
				$data['emailtemplate_config_shadow_top'][$col.'_thumb'] = $this->getImageUrl($data['emailtemplate_config_shadow_top'][$col.'_img']);
			} else {
				$data['emailtemplate_config_shadow_top'][$col.'_thumb'] = $this->model_tool_image->resize('no_image.jpg', 50, 50);
			}

			if (isset($data['emailtemplate_config_shadow_bottom'][$col.'_img']) && file_exists(DIR_IMAGE . $data['emailtemplate_config_shadow_bottom'][$col.'_img'])) {
				$data['emailtemplate_config_shadow_bottom'][$col.'_thumb'] = $this->getImageUrl($data['emailtemplate_config_shadow_bottom'][$col.'_img']);
			} else {
				$data['emailtemplate_config_shadow_bottom'][$col.'_thumb'] = $this->model_tool_image->resize('no_image.jpg', 50, 50);
			}
		}

		return $data;
	}


	/**
	 * Image Absolute URL, no resize
	 */
	public function getImageUrl($filename) {
		if (!file_exists(DIR_IMAGE . $filename) || !is_file(DIR_IMAGE . $filename)) {
			return;
		}

		if ($this->config->get('config_url')) {
			$url = $this->config->get('config_url') . 'image/';
		} else {
			$url = defined("HTTP_IMAGE") ? HTTP_IMAGE : (defined("HTTP_CATALOG") ? HTTP_CATALOG : HTTP_SERVER) . 'image/';
		}

		return $url . $filename;
	}

	/**
	 * Fetch query with caching
	 *
	 */
	private function _fetch($query) {
		$queryName = 'emailtemplate_sql_'.md5($query);
		$result = $this->cache->get($queryName);
		if (!$result) {
			$result = $this->db->query($query);
			$this->cache->set($queryName, $result);
		}
		return $result;
	}


	/**
	 * Method builds mysql for INSERT/UPDATE
	 *
	 * @param array $cols
	 * @param array $data
	 * @return array
	 */
	private function _build_query($cols, $data, $withoutCols = false) {
		if (empty($data)) return $data;
		$return = array();

		foreach ($cols as $col => $type) {
			if (!array_key_exists($col, $data)) continue;

			switch ($type) {
				case EmailTemplateAbstract::INT:
					if (strtoupper($data[$col]) == 'NULL') {
						$value = 'NULL';
					} else {
						$value = intval($data[$col]);
					}
					break;
				case EmailTemplateAbstract::FLOAT:
					$value = floatval($data[$col]);
					break;
				case EmailTemplateAbstract::DATE_NOW:
					$value = 'NOW()';
					break;
				case EmailTemplateAbstract::SERIALIZE:
					$value = "'".base64_encode(serialize($data[$col]))."'";
					break;
				default:
					$value = "'".$this->db->escape($data[$col])."'";
			}

			if ($withoutCols) {
				$return[] = "'{$value}'";
			} else {
				$return[] = " `{$col}` = {$value}";
			}
		}

		return empty($return) ? false : $return;
	}

	/**
	 * Delete all cache files that begin with emailtemplate_
	 *
	 */
	private function _delete_cache($key = 'emailtemplate_sql_') {
		$files = glob(DIR_CACHE . 'cache.' . preg_replace('/[^A-Z0-9\._-]/i', '', $key) . '*');
		if ($files) {
			foreach ($files as $file) {
				if (file_exists($file) && is_writable($file)) {
					unlink($file);
				}
			}
		}
	}
}