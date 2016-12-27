<?php
class ModelCatalogReviewBooster extends Model {
	public function getEmail($email_id) {
		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "rb_email` WHERE email_id = '" . (int)$email_id . "'");

		return $query->row;
	}

	public function deleteEmail($email_id) {
		$this->db->query("DELETE FROM `" . DB_PREFIX . "rb_email` WHERE email_id = '" . (int)$email_id . "'");
	}

	public function getEmailHistories($store_id, $start = 0, $limit = 20) {
		if ($start < 0) {
			$start = 0;
		}

		if ($limit < 1) {
			$limit = 20;
		}

		$query = $this->db->query("SELECT rbe.*, ch.date_added AS date_used, ch.order_id AS coupon_order_id FROM `" . DB_PREFIX . "rb_email` rbe LEFT JOIN `" . DB_PREFIX . "coupon_history` ch ON (rbe.coupon_id = ch.coupon_id) WHERE rbe.store_id = '" . (int)$store_id . "' ORDER BY rbe.date_added DESC LIMIT " . (int)$start . "," . (int)$limit);

		return $query->rows;
	}

	public function getTotalEmailHistories($store_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM `" . DB_PREFIX . "rb_email` WHERE store_id = '" . (int)$store_id . "'");

		return $query->row['total'];
	}

	public function getOrderProducts($order_id, $product_id = 0) {
		$sql = "SELECT * FROM `" . DB_PREFIX . "order_product` WHERE order_id = '" . (int)$order_id . "'";

		if ($product_id) {
			$sql .= " AND product_id = '" . (int)$product_id . "'";
		}

		$query = $this->db->query($sql);

		return $query->rows;
	}

	public function getCoupon($coupon_id) {
		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "coupon` WHERE coupon_id = '" . (int)$coupon_id . "'");

		return $query->row;
	}

	public function install() {
		$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "rb_email` (
			`email_id` int(11) NOT NULL AUTO_INCREMENT,
			`date_added` datetime NOT NULL,
			`date_review` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
			`email` varchar(96) NOT NULL,
			`noticed` varchar(96) NOT NULL,
			`coupon_id` int(11) NOT NULL DEFAULT '0',
			`hash` varchar(32) NOT NULL,
			`code` varchar(10) NOT NULL,
			`order_id` int(11) NOT NULL,
			`store_id` int(11) NOT NULL,
			`product_id` int(11) NOT NULL,
			`product_limit` int(11) NOT NULL DEFAULT '0',
			`test` tinyint(1) NOT NULL DEFAULT '0',
			PRIMARY KEY (`email_id`),
			KEY `order_id` (`order_id`)
		) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_bin;");

		if ($this->db->query("SHOW COLUMNS FROM `" . DB_PREFIX . "order` LIKE 'review_alert'")->row) {
			$query = $this->db->query("SELECT order_id, email FROM `" . DB_PREFIX . "order` WHERE review_alert = '1'");

			foreach ($query->rows as $row) {
				$this->db->query("INSERT INTO `" . DB_PREFIX . "rb_email` SET email = '" . $this->db->escape($row['email']) . "', order_id = '" . (int)$row['order_id'] . "'");
			}

			$this->db->query("ALTER TABLE `" . DB_PREFIX . "order` DROP COLUMN review_alert");
		}

		if (!$this->db->query("SHOW COLUMNS FROM `" . DB_PREFIX . "rb_email` LIKE 'test'")->row) {
			$this->db->query("ALTER TABLE `" . DB_PREFIX . "rb_email` ADD `test` tinyint(1) NOT NULL DEFAULT '0'");
			$this->db->query("ALTER TABLE `" . DB_PREFIX . "rb_email` ADD `noticed` varchar(96) NOT NULL");
		}

		if (!$this->db->query("SHOW COLUMNS FROM `" . DB_PREFIX . "review` LIKE 'verified_buyer'")->row) {
			$this->db->query("ALTER TABLE `" . DB_PREFIX . "review` ADD `verified_buyer` tinyint(1) NOT NULL DEFAULT '0'");
		}

		if (!$this->db->query("SHOW COLUMNS FROM `" . DB_PREFIX . "rb_email` LIKE 'product_limit'")->row) {
			$this->db->query("ALTER TABLE `" . DB_PREFIX . "rb_email` ADD `product_limit` int(11) NOT NULL DEFAULT '0'");
		}
	}

	public function uninstall() {
		$this->db->query("DROP TABLE IF EXISTS " . DB_PREFIX . "rb_email");
	}
}