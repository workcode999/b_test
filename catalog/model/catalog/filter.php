<?php
//==============================================================================
// Filter Model v2016-8-24
// 
// Author: Clear Thinking, LLC
// E-mail: johnathan@getclearthinking.com
// Website: http://www.getclearthinking.com
// 
// All code within this file is copyright Clear Thinking, LLC.
// You may not copy or reuse code within this file without written permission.
//==============================================================================

class ModelCatalogFilter extends Model {
	private $type = 'catalog';
	private $name = 'filter';
	
	//==============================================================================
	// getProducts()
	//==============================================================================
	public function getProducts($data = array()) {
		// Check cache
		$hash = md5(http_build_query($data));
		$cache = $this->cache->get($this->name . '.products.' . $hash);
		if ($cache && $data['caching']) {
			return $cache;
		}
		
		// Set up data
		if ($this->customer->isLogged()) {
			$customer_group_id = (version_compare(VERSION, '2.0', '<')) ? (int)$this->customer->getCustomerGroupId() : (int)$this->customer->getGroupId();
		} else {
			$customer_group_id = (int)$this->config->get('config_customer_group_id');
		}
		$language_id = (int)$this->config->get('config_language_id');
		$list = (isset($data['list'])) ? $data['list'] : '';
		$store_id = (int)$this->config->get('config_store_id');
		
		if (empty($data['sort'])) $data['sort'] = '';
		
		// Reused SQL
		$rating_sql = "
			SELECT AVG(rating) AS total
			FROM " . DB_PREFIX . "review r
			WHERE r.product_id = p.product_id
			AND r.status = 1
			GROUP BY r.product_id
		";
		
		$discount_sql = "
			SELECT price FROM " . DB_PREFIX . "product_discount pd2
			WHERE pd2.product_id = p.product_id
			AND pd2.customer_group_id = " . $customer_group_id . "
			AND pd2.quantity = 1
			AND ((pd2.date_start = '0000-00-00' OR pd2.date_start < NOW()) AND (pd2.date_end = '0000-00-00' OR pd2.date_end > NOW()))
			ORDER BY pd2.priority ASC, pd2.price ASC LIMIT 1
		";
		
		$special_sql = "
			SELECT price FROM " . DB_PREFIX . "product_special ps
			WHERE ps.product_id = p.product_id
			AND ps.customer_group_id = " . $customer_group_id . "
			AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW()))
			ORDER BY ps.priority ASC, ps.price ASC LIMIT 1
		";
		
		if ($list == 'bestseller' || $data['sort'] == 'bestseller') {
			$bestseller_sql = "
				SELECT SUM(op.quantity) AS total FROM " . DB_PREFIX . "order_product op
				LEFT JOIN `" . DB_PREFIX . "order` o ON (op.order_id = o.order_id)
				WHERE op.product_id = p.product_id
				AND o.order_status_id > 0
				GROUP BY op.product_id
				ORDER BY total DESC
			";
		}
		
		// Start building query
		$sql = "";
		
		if (isset($data['return_total'])) {
			$sql .= "SELECT COUNT(*) AS total FROM (";
		}
		
		$sql .= "
			SELECT (" . $rating_sql . ") AS rating, (" . $discount_sql . ") AS discount, (" . $special_sql . ") AS special, " . (isset($bestseller_sql) ? "(" . $bestseller_sql . ") AS bestseller," : "") . "
			p.product_id FROM " . DB_PREFIX . "product p
			LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id AND pd.language_id = " . $language_id . ")
			LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id)
 			WHERE " . ($list != 'coming' ? "p.status = 1 AND " : "") . "p.date_available <= NOW() AND p2s.store_id = " . $store_id . "
 		";
		
		// Check attributes
		if (isset($data['attribute'])) {
			foreach ($data['attribute'] as $attribute_id => $values) {
				$values = explode(';', html_entity_decode($values, ENT_QUOTES, 'UTF-8'));
				foreach ($values as &$value) {
					$value = $this->db->escape(htmlentities($value));
				}
				$sql .= " AND p.product_id IN (SELECT product_id FROM " . DB_PREFIX . "product_attribute WHERE attribute_id = " . (int)$attribute_id . " AND (`text` LIKE '%" . implode("%' OR `text` LIKE '%", $values) . "%'))";
			}
		}
		
		// Check categories
		if (isset($data['path']) || isset($data['category_id'])) {
			if (isset($data['path'])) {
				$paths = explode('_', $data['path']);
				$data['category_id'] = array_pop($paths);
			}
			
			$sql .= " AND p.product_id IN (SELECT p2c.product_id FROM " . DB_PREFIX . "product_to_category p2c";
			if (!empty($data['sub_category']) && version_compare(VERSION, '1.5.5', '>=')) {
				$sql .= " LEFT JOIN " . DB_PREFIX . "category_path cp ON (cp.category_id = p2c.category_id) WHERE p2c.category_id = " . (int)$data['category_id'] . " OR cp.path_id = " . (int)$data['category_id'] . ")";
			} else {
				$sql .= " WHERE p2c.category_id = " . (int)$data['category_id'] . ")";
			}
		}
		
		// Check filters
		if (isset($data['filter'])) {
			foreach ($data['filter'] as $filter_group_id => $values) {
				$values = explode(';', $values);
				foreach ($values as &$value) {
					$value = (int)$value;
				}
				$sql .= " AND p.product_id IN (SELECT product_id FROM " . DB_PREFIX . "product_filter WHERE (filter_id = " . implode(" OR filter_id = ", $values) . "))";
			}
		}
		
		// Check manufacturers
		if (isset($data['manufacturer_id'])) {
			$sql .= " AND p.manufacturer_id = " . (int)$data['manufacturer_id'];
		}
		
		// Check options
		if (isset($data['option'])) {
			foreach ($data['option'] as $option_id => $values) {
				$values = explode(';', $values);
				foreach ($values as &$value) {
					$value = (int)$value;
				}
				$sql .= " AND p.product_id IN (SELECT product_id FROM " . DB_PREFIX . "product_option_value WHERE (option_value_id = " . implode(" OR option_value_id = ", $values) . "))";
			}
		}
		
		// Check prices
		if (isset($data['price'])) {
			$tax_multiplier = "";
			
			if ($this->config->get('config_tax')) {
				$country_id = (isset($this->session->data['country_id'])) ? $this->session->data['country_id'] : $this->config->get('config_country_id');
				$zone_id = (isset($this->session->data['zone_id'])) ? $this->session->data['zone_id'] : $this->config->get('config_zone_id');
				
				$tax_multiplier = "
					IFNULL(((
					SELECT IFNULL(SUM(tr.rate), 0) FROM " . DB_PREFIX . "tax_rate tr
					LEFT JOIN " . DB_PREFIX . "zone_to_geo_zone z2gz ON (tr.geo_zone_id = z2gz.geo_zone_id)
					LEFT JOIN " . DB_PREFIX . "tax_rate_to_customer_group tr2cg ON (tr.tax_rate_id = tr2cg.tax_rate_id)
					LEFT JOIN " . DB_PREFIX . "tax_rule tru ON (tr.tax_rate_id = tru.tax_rate_id)
					WHERE (z2gz.country_id = '0' OR z2gz.country_id = " . (int)$country_id . ")
					AND (z2gz.zone_id = '0' OR z2gz.zone_id = " . (int)$zone_id . ")
					AND tr2cg.customer_group_id = " . (int)$customer_group_id . "
					AND p.tax_class_id = tru.tax_class_id
					AND tr.type = 'P'
					ORDER BY tru.priority ASC
					LIMIT 1) / 100 + 1), 1) *
				";
			}
			
			$ifnull_special_sql = $tax_multiplier . "IFNULL((" . $special_sql . "), p.price)";
			
			$price_sqls = array();
			
			foreach (explode(';', $data['price']) as $range) {
				$price = explode('-', $range);
				$price_sql = $ifnull_special_sql . " >= " . $price[0];
				if (!empty($price[1])) {
					$price_sql .= " AND " . $ifnull_special_sql . " < " . $price[1];
				}
				$price_sqls[] = $price_sql;
			}
			
			$sql .= " AND ((" . implode(") OR (", $price_sqls) . "))";
		}
		
		// Check ratings
		if (isset($data['rating'])) {
			$ratings = explode(';', $data['rating']);
			$rating = array_pop($ratings);
			$sql .= " AND (" . $rating_sql . ") >= " . (int)$rating;
		}
		
		// Check search data
		if (isset($data['search'])) {
			$sql .= " AND (";
			
			$words = explode(' ', trim(preg_replace('/\s+/', ' ', $data['search'])));
			foreach ($words as &$word) {
				$word = $this->db->escape($word);
			}
			$sql .= "(pd.name LIKE '%" . implode("%' AND pd.name LIKE '%", $words) . "%')";
			
			if (!empty($data['description'])) {
				$sql .= " OR (pd.description LIKE '%" . $this->db->escape(implode("%' AND pd.description LIKE '%", $words)) . "%')";
			}
			
			$sql .= "
				OR LCASE(p.model) = '" . $this->db->escape(utf8_strtolower($data['search'])) . "'
				OR LCASE(p.sku) = '" . $this->db->escape(utf8_strtolower($data['search'])) . "'
				OR LCASE(p.upc) = '" . $this->db->escape(utf8_strtolower($data['search'])) . "'
			";
			if (version_compare(VERSION, '1.5.4', '>=')) {
				$sql .= "
					OR LCASE(p.ean) = '" . $this->db->escape(utf8_strtolower($data['search'])) . "'
					OR LCASE(p.jan) = '" . $this->db->escape(utf8_strtolower($data['search'])) . "'
					OR LCASE(p.isbn) = '" . $this->db->escape(utf8_strtolower($data['search'])) . "'
					OR LCASE(p.mpn) = '" . $this->db->escape(utf8_strtolower($data['search'])) . "'
				";
			}
			
			$sql .= ")";
		}
		
		// Check stock statuses
		if (isset($data['stock_status'])) {
			$stock_sqls = array();
			foreach (explode(';', $data['stock_status']) as $status) {
				if ($status == 'in') {
					$stock_sqls[] = "p.quantity > 0";
				} elseif ($status == 'out') {
					$stock_sqls[] = "p.quantity <= 0";
				} else {
					$stock_sqls[] = "p.quantity <= 0 AND p.stock_status_id = " . (int)$status;
				}
			}
			$sql .= " AND ((" . implode(") OR (", $stock_sqls) . "))";
		}
		
		// Check Extra Product Pages
		if ($list == 'bestseller') {
			
			$sql .= " AND EXISTS (" . $bestseller_sql . ")";
			
		} elseif ($list == 'coming' || $data['sort'] == 'coming') {
			
			$sql .= " AND p.date_available > NOW()";
			
		} elseif ($list == 'featured') {
			
			$product_ids = array();
			if (version_compare(VERSION, '2.0', '<') && $this->config->get('featured_product')) {
				$product_ids = explode(',', $this->config->get('featured_product'));
			} elseif (version_compare(VERSION, '2.0', '>=')) {
				$featured_query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "module` WHERE `code` = 'featured'");
				foreach ($featured_query->rows as $row) {
					$module_settings = (version_compare(VERSION, '2.1', '<')) ? unserialize($row['setting']) : json_decode($row['setting'], true);
					$product_ids = array_unique(array_merge($product_ids, $module_settings['product']));
				}
			}
			if ($product_ids) {
				$sql .= " AND (p.product_id = " . implode(" OR p.product_id = ", $product_ids) . ")";
			}
			
		} elseif ($list == 'special') {
			
			$sql .= " AND EXISTS (" . $special_sql . ")";
			
		}
		
		// Return total or products
		$sql .= " GROUP BY p.product_id";
		
		if (isset($data['return_total'])) {
			$sql .= ") total_products";
			$query = $this->db->query($sql);
			$this->cache->set($this->name . '.products.' . $hash, $query->row['total']);
			return $query->row['total'];
		} else {
			// Set relevant values
			$get = $data;
			unset($get['sort']);
			unset($get['order']);
			unset($get['page']);
			unset($get['limit']);
			
			$product_ids = array();
			$query = $this->db->query($sql);
			foreach ($query->rows as $row) {
				$product_ids[] = $row['product_id'];
			}
			
			$this->getRelevantValues($get, $product_ids);
			
			// Set sort and order
			$sort_data = array(
				'price',
				'name',
				'rating',
				'model'
			);
			
			$sql .= " ORDER BY ";
			if ($data['sort'] == 'name') {
				$sql .= "LCASE(pd.name)";
			} elseif ($data['sort'] == 'rating') {
				$sql .= "rating";
			} elseif ($data['sort'] == 'model') {
				$sql .= "LCASE(p.model)";
			} elseif ($data['sort'] == 'price') {
				$sql .= " (CASE WHEN special IS NOT NULL THEN special WHEN discount IS NOT NULL THEN discount ELSE p.price END)";
			} elseif ($data['sort'] == 'bestseller') {
				$sql .= "bestseller";
			} elseif ($data['sort'] == 'coming') {
				$sql .= "p.date_available";
			} elseif ($data['sort'] == 'latest') {
				$sql .= "p.date_added";
			} elseif ($data['sort'] == 'popular') {
				$sql .= "p.viewed"; 
			} else {
				$sql .= "p.sort_order";
			}
			
			if (empty($data['order']) || $data['order'] == 'desc') {
				$sql .= " DESC";
			} else {
				$sql .= " ASC";
			}
			
			$sql .= ", LCASE(pd.name) ASC LIMIT " . (int)(($data['page'] - 1) * $data['limit']) . "," . (int)$data['limit'];
			
			// Execute query
			$query = $this->db->query($sql);
			
			$product_data = array();
			$this->load->model('catalog/product');
			
			foreach ($query->rows as $result) {
				$product = $this->model_catalog_product->getProduct($result['product_id']);
				if (empty($product['name'])) continue;
				$product_data[$result['product_id']] = $product;
			}
			
			$this->cache->set($this->name . '.products.' . $hash, $product_data);
			return $product_data;
		}
	}
	
	//==============================================================================
	// getRelevantValues()
	//==============================================================================
	public function getRelevantValues($get, $product_ids = array()) {
		// Check cache
		$hash = md5(http_build_query($get));
		$cache = $this->cache->get($this->name . '.relevant_values.' . $hash);
		if ($cache && $get['caching']) {
			$this->session->data['relevant_values'] = $cache;
			return $cache;
		}
		
		// Get Extra Product Pages limit
		$theme = (version_compare(VERSION, '2.2', '<')) ? $this->config->get('config_template') : $this->config->get('config_theme');
		
		if (version_compare(VERSION, '2.0', '<')) {
			$pagination_limit = $this->config->get('config_catalog_limit');
		} elseif (version_compare(VERSION, '2.2', '<')) {
			$pagination_limit = $this->config->get('config_product_limit');
		} else {
			$pagination_limit = $this->config->get($theme . '_product_limit');
		}
		
		$total_limit = $pagination_limit * 10;
		
		// Get relevant products
		if (empty($product_ids)) {
			$results = array();
			$this->load->model('catalog/product');
			
			if (empty($get['route']) || $get['route'] == 'common/home') {
				
				return array();
				
			} elseif ($get['route'] == 'product/category') {
				
				$paths = (!empty($get['path'])) ? explode('_', $get['path']) : array(0);
				$category_data = array(
					'filter_category_id'	=> array_pop($paths),
					'filter_sub_category'	=> isset($get['sub_category']),
				);
				$results = $this->model_catalog_product->getProducts($category_data);
				
			} elseif ($get['route'] == 'product/manufacturer/info') {
				
				$manufacturer_id = (isset($get['manufacturer_id'])) ? $get['manufacturer_id'] : 0;
				$results = $this->model_catalog_product->getProducts(array('filter_manufacturer_id' => $manufacturer_id));
				
			} elseif ($get['route'] == 'product/search') {
				
				$search = '';
				$tag = '';
				$description = '';
				$category_id = 0;
				$sub_category = '';
				
				if (isset($get['search'])) {
					$search = $get['search'];
				} elseif (isset($get['filter_name'])) {
					$search = $get['filter_name'];
				}
				if (isset($get['filter_tag'])) {
					$tag = $get['filter_tag'];
				} elseif (isset($get['filter_name'])) {
					$tag = $get['filter_name'];
				}
				if (isset($get['filter_description'])) $description = $get['filter_description'];
				if (isset($get['filter_category_id'])) $category_id = $get['filter_category_id'];
				if (isset($get['filter_sub_category'])) $sub_category = $get['filter_sub_category'];
				
				$filter_data = array(
					'filter_name'         => $search,
					'filter_tag'          => $tag,
					'filter_description'  => $description,
					'filter_category_id'  => $category_id,
					'filter_sub_category' => $sub_category,
				);
				$results = $this->model_catalog_product->getProducts($filter_data);
				
			} elseif ($get['route'] == 'product/special') {
				
				$results = $this->model_catalog_product->getProductSpecials();
				
			} elseif ($get['route'] == 'product/list/all') {
				
				$results = $this->model_catalog_product->getProducts();
				
			} elseif ($get['route'] == 'product/list/bestseller') {
				
				$results = $this->model_catalog_product->getBestSellerProducts($total_limit);
				
			} elseif ($get['route'] == 'product/list/coming') {
				
				$results = $this->db->query("SELECT * FROM " . DB_PREFIX . "product WHERE date_available > NOW()")->rows;
				
			} elseif ($get['route'] == 'product/list/featured') {
				
				$ids = array();
				if (version_compare(VERSION, '2.0', '<') && $this->config->get('featured_product')) {
					$ids = explode(',', $this->config->get('featured_product'));
				} elseif (version_compare(VERSION, '2.0', '>=')) {
					$featured_query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "module` WHERE `code` = 'featured'" . (isset($get['module_id']) ? " AND module_id = " . (int)$get['module_id'] : ""));
					foreach ($featured_query->rows as $row) {
						$module_settings = (version_compare(VERSION, '2.1', '<')) ? unserialize($row['setting']) : json_decode($row['setting'], true);
						$ids = array_unique(array_merge($ids, $module_settings['product']));
					}
				}
				$results = array();
				foreach ($ids as $id) {
					$results[] = array('product_id' => $id);
				}
				
			} elseif ($get['route'] == 'product/list/latest') {
				
				$results = $this->model_catalog_product->getLatestProducts($total_limit);
				
			} elseif ($get['route'] == 'product/list/popular') {
				
				$results = $this->model_catalog_product->getPopularProducts($total_limit);
				
			}
			
			foreach ($results as $result) {
				$product_ids[] = (int)$result['product_id'];
			}
		}
		
		if (empty($product_ids)) {
			return (isset($this->session->data['relevant_values'])) ? $this->session->data['relevant_values'] : array();
		}
		
		// Find relevant values
		$relevant_values = array();
		
		if (isset($get['attribute_choices']) && $get['attribute_choices'] == 'relevant') {
			$relevant_values['attribute'] = array();
			$product_attributes = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_attribute WHERE language_id = " . (int)$this->config->get('config_language_id') . " AND (product_id = " . implode(" OR product_id = ", $product_ids) . ") ORDER BY attribute_id, text")->rows;
			foreach ($product_attributes as $attribute) {
				foreach (explode(',', $attribute['text']) as $attribute_value) {
					$relevant_values['attribute'][$attribute['attribute_id']][] = trim($attribute_value);
				}
			}
		}
		
		if (isset($get['category_choices']) && $get['category_choices'] == 'relevant') {
			$relevant_values['category'] = array();
			$product_categories = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_to_category WHERE (product_id = " . implode(" OR product_id = ", $product_ids) . ")")->rows;
			foreach ($product_categories as $category) {
				$relevant_values['category'][] = $category['category_id'];
			}
		}
		
		if (isset($get['filter_choices']) && $get['filter_choices'] == 'relevant') {
			$relevant_values['filter'] = array();
			$product_filters = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_filter WHERE (product_id = " . implode(" OR product_id = ", $product_ids) . ")")->rows;
			foreach ($product_filters as $filter) {
				$relevant_values['filter'][] = $filter['filter_id'];
			}
		}
		
		if (isset($get['manufacturer_choices']) && $get['manufacturer_choices'] == 'relevant') {
			$relevant_values['manufacturer'] = array();
			$product_manufacturers = $this->db->query("SELECT * FROM " . DB_PREFIX . "product WHERE (product_id = " . implode(" OR product_id = ", $product_ids) . ")")->rows;
			foreach ($product_manufacturers as $manufacturer) {
				$relevant_values['manufacturer'][] = $manufacturer['manufacturer_id'];
			}
		}
		
		if (isset($get['option_choices']) && $get['option_choices'] == 'relevant') {
			$relevant_values['option'] = array();
			$product_options = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_option_value WHERE (product_id = " . implode(" OR product_id = ", $product_ids) . ")")->rows;
			foreach ($product_options as $option) {
				$relevant_values['option'][$option['option_id']][] = $option['option_value_id'];
			}
		}
		
		// Set cache and return relevant values
		$this->cache->set($this->name . '.relevant_values.' . $hash, $relevant_values);
		$this->session->data['relevant_values'] = $relevant_values;
		
		return $relevant_values;
	}
}
?>