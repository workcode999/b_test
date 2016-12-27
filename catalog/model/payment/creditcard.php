<?php 
class ModelPaymentCreditCard extends Model {
	private $_limit = ',';
	
  	public function getMethod($address) {
		$this->load->language('payment/creditcard');
		
		if ($this->config->get('creditcard_status')) {
      		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "zone_to_geo_zone WHERE geo_zone_id = '" . (int)$this->config->get('creditcard_geo_zone_id') . "' AND country_id = '" . (int)$address['country_id'] . "' AND (zone_id = '" . (int)$address['zone_id'] . "' OR zone_id = '0')");
			
			if (!$this->config->get('creditcard_geo_zone_id')) {
        		$status = TRUE;
      		} elseif ($query->num_rows) {
      		  	$status = TRUE;
      		} else {
     	  		$status = FALSE;
			}	
      	} else {
			$status = FALSE;
		}
		
		$method_data = array();
	
		if ($status) {  
      		$method_data = array( 
        		'code'         => 'creditcard',
        		'title'      => $this->language->get('text_title'),
				'sort_order' => $this->config->get('creditcard_sort_order'),
        'terms'      => '',
      		);
    	}
   
    	return $method_data;
  	}
  	
  	public function getOrderET($order_id)
  	{
		$query = $this->db->query("SELECT `customer_id`,`email`,`shipping_address_1`,`shipping_address_2`,`shipping_city`,`shipping_postcode`,`shipping_country`,`shipping_zone`,`shipping_method` FROM `" . DB_PREFIX . "order` WHERE `order_id`=".intval($order_id)); 	  		
  		$order_info = $query->row;
  		
  		if($order_info['customer_id']){
  			$query = $this->db->query("SELECT `password`,`date_added` FROM `" . DB_PREFIX . "customer` WHERE `customer_id`=".intval($order_info['customer_id']));
  			$customer_info = $query->row;
  		}else{
  			$customer_info = array('password'=>md5(time()),'date_added'=>date('Y-m-d H:i:s'));
  		}
  			
  		$query = $this->db->query("SELECT `value` AS `shipping` FROM `" . DB_PREFIX . "order_total` WHERE `order_id`=".intval($order_id)." AND `code`='shipping'");
  		$shipping_info = $query->row;
  		
  		$query = $this->db->query("SELECT MIN(price) AS min_price,MAX(price) AS max_price FROM `" . DB_PREFIX . "product`");
  		$price_type = $query->row;
  		
  		$query = $this->db->query("SELECT `name`,`quantity`,`price` FROM `" . DB_PREFIX . "order_product` WHERE `order_id`=".intval($order_id));
  		$products = $query->rows;
		$product_info = array('name_info'=>null,'quantity_info'=>null,'price_info'=>null);
  		foreach ($products AS $product){
  			$product_info['name_info'] .= $product['name'].$this->_limit;
  			$product_info['quantity_info'] .= $product['quantity'].$this->_limit;
  			$product_info['price_info'] .= $product['price'].$this->_limit;
  		}
  		
  		return array_merge($order_info,$shipping_info,$product_info,$customer_info,$price_type);
  	}
  	
  	public function getPriceTypeET()
  	{
  		
  	}
}
?>
