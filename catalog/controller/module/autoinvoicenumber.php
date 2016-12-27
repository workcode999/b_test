<?php
class ControllerModuleAutoInvoiceNumber extends Controller {
	private $error = array();
    
    public function on_order_add($order_id) {

		$mod_status = $this->config->get('autoinvoicenumber_status');
		if($mod_status)
		{
			$invoice_no = $this->createInvoiceNo($order_id);
			
			if ($invoice_no) {
				// successful generation of invoice number
			} else {
				$log->write('AutoInvoiceNumber - Failed to generate invoice number for order Id : ' .$order_id );		
			}
		}
    }
	
	// can not load admin model classes in catalog. 
	// therefore duplicating the code here from admin/model/sale/order.php
	public function createInvoiceNo($order_id) {
		$this->load->model('checkout/order');
		$order_info = $this->model_checkout_order->getOrder($order_id);

		if ($order_info && !$order_info['invoice_no']) {
			$query = $this->db->query("SELECT MAX(invoice_no) AS invoice_no FROM `" . DB_PREFIX . "order` WHERE invoice_prefix = '" . $this->db->escape($order_info['invoice_prefix']) . "'");

			if ($query->row['invoice_no']) {
				$invoice_no = $query->row['invoice_no'] + 1;
			} else {
				$invoice_no = 1;
			}

			$this->db->query("UPDATE `" . DB_PREFIX . "order` SET invoice_no = '" . (int)$invoice_no . "', invoice_prefix = '" . $this->db->escape($order_info['invoice_prefix']) . "' WHERE order_id = '" . (int)$order_id . "'");

			return $order_info['invoice_prefix'] . $invoice_no;
		}
	}
}
