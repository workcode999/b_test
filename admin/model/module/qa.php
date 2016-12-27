<?php
class ModelModuleQA extends Model {
	private static $alerts = array();
	private $tables = array(
		'qa' => array('qa_id', 'product_id', 'customer_id', 'language_id', 'question_author_name', 'question_author_email', 'question_author_phone', 'question_author_custom', 'answer_author_name', 'question', 'answer', 'status', 'notified', 'date_asked', 'date_answered', 'date_modified'),
		'qa_to_store' => array('qa_id', 'store_id')
	);

	public function upgradeDatabaseStructure($from_version, $alert = array()) {
		$errors = false;
		$this->alerts = array();

		switch ($from_version) {
			case '1.6.0':
				$this->db->query("ALTER TABLE `" . DB_PREFIX . "qa` CONVERT TO CHARACTER SET utf8 COLLATE utf8_unicode_ci");

				$this->db->query("ALTER TABLE `" . DB_PREFIX . "qa`
					CHANGE customer_id customer_id INT(11),
					CHANGE q_author question_author_name VARCHAR(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
					CHANGE q_author_email question_author_email VARCHAR(128) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
					CHANGE a_author answer_author_name VARCHAR(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
					CHANGE status status TINYINT(1) NOT NULL DEFAULT '0',
					ADD COLUMN `language_id` INT(11) NOT NULL DEFAULT '" . (int)$this->config->get('config_language_id') . "' AFTER `customer_id`,
					ADD COLUMN `store_id` INT(11) NOT NULL DEFAULT '0' AFTER `language_id`,
					ADD COLUMN `question_author_phone` VARCHAR(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' AFTER `question_author_email`,
					ADD COLUMN `question_author_custom` VARCHAR(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' AFTER `question_author_phone`,
					ADD COLUMN `notified` TINYINT(1) NOT NULL DEFAULT '0' AFTER `status`,
					ADD COLUMN `date_modified` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' AFTER `date_answered`,
					ADD INDEX fk_qa_language (language_id)"
				);

				$this->db->query("UPDATE `" . DB_PREFIX . "qa` q LEFT JOIN `" . DB_PREFIX . "language` l ON (q.lang_code COLLATE utf8_unicode_ci = l.code COLLATE utf8_unicode_ci) SET q.language_id = IFNULL(l.language_id, '" . (int)$this->config->get('config_language_id') . "')");
				$this->db->query("UPDATE `" . DB_PREFIX . "qa` SET date_modified = date_answered");
				$this->db->query("UPDATE `" . DB_PREFIX . "qa` SET notified = '1' WHERE status = '1' AND answer != ''");

				$this->db->query("ALTER TABLE `" . DB_PREFIX . "qa` DROP COLUMN `lang_code`");

				$this->db->query("
					CREATE TABLE IF NOT EXISTS " . DB_PREFIX . "qa_to_store (
						qa_id INT(11) NOT NULL,
						store_id INT(11) NOT NULL,
						PRIMARY KEY (qa_id, store_id),
						INDEX fk_qa2s_store (store_id)
					) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci"
				);

				// Link all Q&As with all stores
				$query = $this->db->query("INSERT INTO " . DB_PREFIX . "qa_to_store (qa_id, store_id) SELECT qa_id, s.store_id FROM " . DB_PREFIX . "qa JOIN (SELECT store_id FROM " . DB_PREFIX . "store UNION SELECT 0 AS store_id) s");
				break;
			default:
				break;
		}

		return !$errors;
	}

	public function applyDatabaseChanges() {
		$this->db->query("
			CREATE TABLE IF NOT EXISTS " . DB_PREFIX . "qa (
				qa_id INT(11) NOT NULL AUTO_INCREMENT,
				product_id INT(11) NOT NULL,
				customer_id INT(11),
				language_id INT(11) NOT NULL DEFAULT '" . (int)$this->config->get('config_language_id') . "',
				store_id INT(11) NOT NULL DEFAULT '0',
				question_author_name VARCHAR(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
				question_author_email VARCHAR(128) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
				question_author_phone VARCHAR(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
				question_author_custom VARCHAR(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
				answer_author_name VARCHAR(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
				question TEXT COLLATE utf8_unicode_ci NOT NULL,
				answer TEXT COLLATE utf8_unicode_ci NOT NULL,
				status TINYINT(1) NOT NULL DEFAULT '0',
				notified TINYINT(1) NOT NULL DEFAULT '0',
				date_asked DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
				date_answered DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
				date_modified DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
				PRIMARY KEY (qa_id),
				INDEX fk_qa_product (product_id),
				INDEX fk_qa_language (language_id)
			) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci"
		);

		$this->db->query("
			CREATE TABLE IF NOT EXISTS " . DB_PREFIX . "qa_to_store (
				qa_id INT(11) NOT NULL,
				store_id INT(11) NOT NULL,
				PRIMARY KEY (qa_id, store_id),
				INDEX fk_qa2s_store (store_id)
			) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci"
		);
	}

	public function revertDatabaseChanges() {
		$this->db->query("DROP TABLE IF EXISTS " . DB_PREFIX . "qa_to_store");
		$this->db->query("DROP TABLE IF EXISTS " . DB_PREFIX . "qa");
	}

	public function checkDatabaseStructure($alert = array()) {
		$errors = false;
		$this->alerts = array();

		foreach ($this->tables as $tbl => $fields) {
			$table_exists = $this->db->query("SHOW TABLES LIKE '" . DB_PREFIX . "{$tbl}'");
			if (!$table_exists->num_rows) {
				$errors = true;
				$this->alerts['error']["missing_table_{$tbl}"] = sprintf($this->language->get('error_missing_table'), DB_PREFIX . $tbl);
			} else { // Check for table fields
				foreach($fields as $field) {
					$column_exists = $this->db->query("SHOW COLUMNS FROM " . DB_PREFIX . "{$tbl} LIKE '{$field}'");
					if (!$column_exists->num_rows) {
						$errors = true;
						$this->alerts['error']["missing_column_{$field}"] = sprintf($this->language->get('error_missing_column'), DB_PREFIX . $tbl, $field);
					}
				}
			}
		}

		return !$errors;
	}

	public function getAlerts() {
		return $this->alerts;
	}
}
