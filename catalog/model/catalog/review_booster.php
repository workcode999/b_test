<?php
class ModelCatalogReviewBooster extends Model {
	public function addEmail($data = array()) {
		$this->db->query("INSERT INTO `" . DB_PREFIX . "rb_email` SET email = '" . $this->db->escape($data['email']) . "', hash = '" . $this->db->escape($data['hash']) . "', code = '" . $this->db->escape($data['code']) . "', order_id = '" . (int)$data['order_id'] . "', store_id = '" . (int)$data['store_id'] . "', product_id = '" . (int)$data['product_id'] . "', product_limit = '" . (int)$data['product_limit'] . "', test = '" . ($data['test'] ? 1 : 0) . "', date_added = NOW()");
	}

	public function updateEmail($email_id, $date_review, $coupon_id) {
		$this->db->query("UPDATE `" . DB_PREFIX . "rb_email` SET date_review = '" . $this->db->escape($date_review) . "', coupon_id = '" . (int)$coupon_id . "' WHERE email_id = '" . (int)$email_id . "'");
	}

	public function getEmail($hash, $code) {
		$query = $this->db->query("SELECT rbe.*, (SELECT CONCAT(o.firstname, ' ', o.lastname) AS client FROM `" . DB_PREFIX . "order` o WHERE o.order_id = rbe.order_id LIMIT 1) AS client FROM `" . DB_PREFIX . "rb_email` rbe WHERE rbe.hash = '" . $this->db->escape($hash) . "' AND rbe.code = '" . $this->db->escape($code) . "' AND rbe.store_id = '" . (int)$this->config->get('config_store_id') . "'");

		return $query->row;
	}

	public function getOrders($data = array()) {
		$sql = "SELECT o.email, o.date_added, o.firstname, o.lastname, o.language_id, o.order_id, o.store_id, o.store_name, o.store_url, (SELECT s.value FROM `" . DB_PREFIX . "setting` s WHERE s.key = 'config_email' AND s.store_id = o.store_id LIMIT 1) AS owner_email FROM `" . DB_PREFIX . "order` o";

		if (isset($data['filter_order_status'])) {
			$implode = array();

			foreach ($data['filter_order_status'] as $order_status_id) {
				$implode[] = "o.order_status_id = '" . (int)$order_status_id . "'";
			}

			if ($implode) {
				$sql .= " WHERE (" . implode(" OR ", $implode) . ")";
			}
		} else {
			$sql .= " WHERE o.order_status_id > '0'";
		}

		if (!empty($data['filter_customer_group_exclude'])) {
			$implode = array();

			foreach ($data['filter_customer_group_exclude'] as $customer_group_id) {
				$implode[] = "o.customer_group_id = '" . (int)$customer_group_id . "'";
			}

			if ($implode) {
				$sql .= " AND (" . implode(" AND ", $implode) . ")";
			}
		}

		if (!empty($data['filter_store'])) {
			$sql .= " AND o.store_id = '" . (int)$data['filter_store'] . "'";
		}

		if (!empty($data['filter_after_day'])) {
			if ($this->config->get('review_booster_previous') == '<=') {
				$sql .= " AND DATE(o.date_modified) <= (CURDATE() - INTERVAL " . (int)$data['filter_after_day'] . " DAY)";
			} else {
				$sql .= " AND DATE(o.date_modified) = (CURDATE() - INTERVAL " . (int)$data['filter_after_day'] . " DAY)";
			}
		}

		if (!empty($data['filter_order_id'])) {
			$sql .= " AND o.order_id = '" . (int)$data['filter_order_id'] . "'";
		}

		if (empty($data['filter_order_id']) && !empty($data['filter_after_day'])) {
			$sql .= " AND NOT EXISTS (SELECT rbe.order_id FROM `" . DB_PREFIX . "rb_email` rbe WHERE o.order_id = rbe.order_id AND rbe.test = '0')";
		}

		$sql .= " LIMIT " . (int)$data['limit'];

		$query = $this->db->query($sql);

		return $query->rows;
	}

	public function getOrderProducts($order_id, $product_id = 0, $limit = 0) {
		$sql = "SELECT *, (SELECT p.image FROM `" . DB_PREFIX . "product` p WHERE p.product_id = op.product_id) AS image FROM `" . DB_PREFIX . "order_product` op WHERE op.order_id = '" . (int)$order_id . "'";

		if ($product_id) {
			$sql .= " AND op.product_id = '" . (int)$product_id . "'";
		}

		if ($limit) {
			$sql .= " LIMIT " . (int)$limit;
		}

		$query = $this->db->query($sql);

		return $query->rows;
	}

	public function addCoupon($data = array()) {
		$code = strtoupper(substr(md5(uniqid(time(), true)), 0, 8));

		$this->db->query("INSERT INTO `" . DB_PREFIX . "coupon` SET name = '" . $this->db->escape($data['name']) . "', code = '" . $this->db->escape($code) . "', discount = '" . (float)$data['discount'] . "', type = '" . $this->db->escape($data['type']) . "', total = '0.1', logged = '0', shipping = '0', date_start = '" . $this->db->escape($data['date_start']) . "', date_end = '" . $this->db->escape($data['date_end']) . "', uses_total = '1', uses_customer = '1', status = '1', date_added = NOW()");

		return $this->db->getLastId();
	}

	public function getCoupon($coupon_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM `" . DB_PREFIX . "coupon` WHERE coupon_id = '" . (int)$coupon_id . "' AND status = '1'");

		return $query->row;
	}

	public function addReview($product_id, $data, $approve, $auto_approve_rating) {
		$date_added = date("Y-m-d H:i:s");

		$this->db->query("INSERT INTO `" . DB_PREFIX . "review` SET author = '" . $this->db->escape($data['author']) . "', customer_id = '" . (int)$this->customer->getId() . "', product_id = '" . (int)$product_id . "', text = '" . $this->db->escape($data['text']) . "', rating = '" . (int)$data['rating'] . "', verified_buyer = '1', status = '0', date_added = '" . $this->db->escape($date_added) . "'");

		$review_id = $this->db->getLastId();

		if (is_array($data['rating'])) {
			foreach ($data['rating'] as $key => $rating) {
				$this->db->query("INSERT INTO `" . DB_PREFIX . "pr_rating_review` SET review_id = '" . (int)$review_id . "', rating_id = '" . (int)$key . "', rating = '" . (int)$rating . "'");
			}

			$avg = round(array_sum($this->request->post['rating']) / count($this->request->post['rating']));

			$sql = "UPDATE `" . DB_PREFIX . "review` SET rating = '" . $avg . "'";

			if ($this->db->query("SHOW COLUMNS FROM `" . DB_PREFIX . "review` LIKE 'store_id'")->row) {
				$sql .= ", store_id = '" . (int)$data['store_id'] . "' ";
			}

			if ($avg >= $auto_approve_rating) {
				$sql .= ", status = '" . ($approve ? '1' : '0') . "' ";
			}

			$sql .= "WHERE review_id = '" . (int)$review_id . "'";

			$this->db->query($sql);
		} else {
			if ((int)$data['rating'] >= $auto_approve_rating) {
				$this->db->query("UPDATE `" . DB_PREFIX . "review` SET status = '" . ($approve ? '1' : '0') . "' WHERE review_id = '" . (int)$review_id . "'");
			}
		}

		if (isset($data['review_images'])) {
			$k = 0;

			foreach ($data['review_images'] as $image) {
				if ($k >= (int)$this->config->get('product_reviews_image_limit')) break;

				$this->db->query("INSERT INTO `" . DB_PREFIX . "pr_review_image` SET image = '" . $this->db->escape($image) . "', review_id = '" . (int)$review_id . "'");

				$k++;
			}
		}

		return $date_added;
	}
}
?>