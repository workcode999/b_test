<?php
class ModelCatalogTest extends Model{
	
	public function getProductID(){
		
		$query = $this->db->query("SELECT product_id FROM `product` where product_id > 20000");
		
		return $query->rows;
	}
	public function getOrderIDByShippedTime($status,$tarttime,$endtime,$product_id){
		$query = $this->db->query("SELECT o.order_id FROM `order` as o LEFT JOIN order_product as op on op.order_id = o.order_id WHERE o.order_status_id = '".(int)$status."' AND (o.date_modified > '".$tarttime."' AND o.date_modified < '".$endtime."') AND op.product_id = '".(int)$product_id."'");
		return $query->rows;
	}
	public function  getTotalByShippedTime($order_id){
		$query = $this->db->query("SELECT SUM(total) as total FROM order_product WHERE order_id in (".$order_id.")");
		return $query->row['total'];
	}
	public function getParentID(){
		$query = $this->db->query("SELECT master_product_id FROM product_master WHERE master_product_id > 0 LIMIT 10");
		return $query->rows;
	}
	public function getZIProID($master_product_id){
		$query = $this->db->query("SELECT product_id FROM product_master WHERE master_product_id = $master_product_id");
		return $query->rows;
	}
	
	public function getOrderNumByPID($product_id){
		$query = $this->db->query("SELECT o.order_id FROM `order` as o LEFT JOIN order_product as op on op.order_id = o.order_id WHERE op.product_id = '".(int)$product_id."'");
		return $query->rows;
	}
	public function getORDTotal(){
		
		
		
	}
	
	
	
	
	
	
	
	
	
	
	
}