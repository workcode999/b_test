<?php 
class ControllerAccountGuest extends Controller {
	private $error = array();
		
	public function index() {
 
    	$this->language->load('account/guest');

    	$this->document->setTitle($this->language->get('heading_title'));

      	$data['breadcrumbs'] = array();

      	$data['breadcrumbs'][] = array(
        	'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home')
      	); 
	
      	$data['breadcrumbs'][] = array(
        	'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('account/guest', '', 'SSL')
      	);

		$data['heading_title'] = $this->language->get('heading_title');
		
    	$data['entry_email'] = $this->language->get('entry_email');
    	$data['entry_ip'] = $this->language->get('entry_ip');
    	$data['text_ip'] = $this->language->get('text_ip');
    	$data['entry_order_number'] = $this->language->get('entry_order_number');
    	$data['text_order_number'] = $this->language->get('text_order_number');

		$data['button_continue'] = $this->language->get('button_continue');
		
		$data['action'] = $this->url->link('account/guest/info', '', 'SSL');
		
		$data['continue'] = $this->url->link('account/guest', '', 'SSL');

		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/account/guest_login.tpl')) {
			$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/account/guest_login.tpl', $data));
		} else {
			$this->response->setOutput($this->load->view('default/template/account/guest_login.tpl', $data));
		}
	}
	
	public function info() { 
		if (isset($this->request->post['order_number'])) {
    		$order_id = $this->request->post['order_number'];
		} else {
			$order_id = '0';
		}
		
		if (isset($this->request->post['email'])) {
    		$email = $this->request->post['email'];
		} else {
			$email = '';
		}
		
		if (isset($this->request->post['ip'])) {
    		$ip = $this->request->post['ip'];
		} else {
			$ip = '0';
		}
		
		$this->language->load('account/guest_history');
				
		$this->load->model('account/guest');
		$this->load->model('account/order');

		$order_info = $this->model_account_guest->getOrder($order_id, $email, $ip);
		if(!empty($order_info['order_status_id'])){
				$order_info['order_status_name'] = $this->model_account_guest->order_status($order_info['order_status_id']);
		}
		if ($order_info) {
			
			$this->document->setTitle($this->language->get('text_order'));
			
			$data['breadcrumbs'] = array();
		
			$data['breadcrumbs'][] = array(
				'text'      => $this->language->get('text_home'),
				'href'      => $this->url->link('common/home')
			); 
		
					
      		$data['heading_title'] = $this->language->get('text_order');
			
			$data['text_order_detail'] = $this->language->get('text_order_detail');
			$data['text_invoice_no'] = $this->language->get('text_invoice_no');
    		$data['text_order_id'] = $this->language->get('text_order_id');
			$data['text_date_added'] = $this->language->get('text_date_added');
      		$data['text_shipping_method'] = $this->language->get('text_shipping_method');
			$data['text_shipping_address'] = $this->language->get('text_shipping_address');
      		$data['text_payment_method'] = $this->language->get('text_payment_method');
      		$data['text_payment_address'] = $this->language->get('text_payment_address');
      		$data['text_history'] = $this->language->get('text_history');
			$data['text_comment'] = $this->language->get('text_comment');
			$data['text_order_status'] = $this->language->get('text_order_status');
			
      		$data['column_name'] = $this->language->get('column_name');
      		$data['column_model'] = $this->language->get('column_model');
      		$data['column_quantity'] = $this->language->get('column_quantity');
      		$data['column_price'] = $this->language->get('column_price');
      		$data['column_total'] = $this->language->get('column_total');
			$data['column_action'] = $this->language->get('column_action');
			$data['column_date_added'] = $this->language->get('column_date_added');
      		$data['column_status'] = $this->language->get('column_status');
      		$data['column_comment'] = $this->language->get('column_comment');
			
			$data['button_reorder'] = $this->language->get('button_reorder');
			$data['button_return'] = $this->language->get('button_return');
      		$data['button_continue'] = $this->language->get('button_continue');
		
			$data['action'] = $this->url->link('account/order/info', 'order_id=' . $order_id , 'SSL');
			
			if ($order_info['invoice_no']) {
				$data['invoice_no'] = $order_info['invoice_prefix'] . $order_info['invoice_no'];
			} else {
				$data['invoice_no'] = '';
			}
			
			$data['order_id'] = $order_id ;
			$data['date_added'] = date($this->language->get('date_format_short'), strtotime($order_info['date_added']));
			
			if ($order_info['shipping_address_format']) {
      			$format = $order_info['shipping_address_format'];
    		} else {
				$format = '{firstname} {lastname}' . "\n" . '{company}' . "\n" . '{address_1}' . "\n" . '{address_2}' . "\n" . '{city} {postcode}' . "\n" . '{zone}' . "\n" . '{country}';
			}
		
    		$find = array(
	  			'{firstname}',
	  			'{lastname}',
	  			'{company}',
      			'{address_1}',
      			'{address_2}',
     			'{city}',
      			'{postcode}',
      			'{zone}',
				'{zone_code}',
      			'{country}'
			);
	
			$replace = array(
	  			'firstname' => $order_info['shipping_firstname'],
	  			'lastname'  => $order_info['shipping_lastname'],
	  			'company'   => $order_info['shipping_company'],
      			'address_1' => $order_info['shipping_address_1'],
      			'address_2' => $order_info['shipping_address_2'],
      			'city'      => $order_info['shipping_city'],
      			'postcode'  => $order_info['shipping_postcode'],
      			'zone'      => $order_info['shipping_zone'],
				'zone_code' => $order_info['shipping_zone_code'],
      			'country'   => $order_info['shipping_country']  
			);

			$data['shipping_address'] = str_replace(array("\r\n", "\r", "\n"), '<br />', preg_replace(array("/\s\s+/", "/\r\r+/", "/\n\n+/"), '<br />', trim(str_replace($find, $replace, $format))));

			$data['shipping_method'] = $order_info['shipping_method'];

			if ($order_info['payment_address_format']) {
      			$format = $order_info['payment_address_format'];
    		} else {
				$format = '{firstname} {lastname}' . "\n" . '{company}' . "\n" . '{address_1}' . "\n" . '{address_2}' . "\n" . '{city} {postcode}' . "\n" . '{zone}' . "\n" . '{country}';
			}
		
    		$find = array(
	  			'{firstname}',
	  			'{lastname}',
	  			'{company}',
      			'{address_1}',
      			'{address_2}',
     			'{city}',
      			'{postcode}',
      			'{zone}',
				'{zone_code}',
      			'{country}'
			);
	
			$replace = array(
	  			'firstname' => $order_info['payment_firstname'],
	  			'lastname'  => $order_info['payment_lastname'],
	  			'company'   => $order_info['payment_company'],
      			'address_1' => $order_info['payment_address_1'],
      			'address_2' => $order_info['payment_address_2'],
      			'city'      => $order_info['payment_city'],
      			'postcode'  => $order_info['payment_postcode'],
      			'zone'      => $order_info['payment_zone'],
				'zone_code' => $order_info['payment_zone_code'],
      			'country'   => $order_info['payment_country']  
			);
			
			$data['payment_address'] = str_replace(array("\r\n", "\r", "\n"), '<br />', preg_replace(array("/\s\s+/", "/\r\r+/", "/\n\n+/"), '<br />', trim(str_replace($find, $replace, $format))));

			//xtensions- Custom Fields
			if($this->xtensions->isActive()){
				$this->load->model('account/xcustom_field');
				$formatted_address = $this->model_account_xcustom_field->getFormattedAddressForOrder($order_info);
				$data['payment_address'] = $formatted_address['payment_address_formatted'];
				$data['shipping_address'] = $formatted_address['shipping_address_formatted'];
			}
			//xtensions- Custom Fields
			
      		$data['payment_method'] = $order_info['payment_method'];
			$data['order_status_name'] = $order_info['order_status_name'];
			
			$data['products'] = array();
			
			$products = $this->model_account_guest->getOrderProducts($order_id );

			foreach ($products as $key=>$product) {
				$option_data = array();
				
				$options = $this->model_account_guest->getOrderOptions($order_id , $product['order_product_id']);
				
			if(!empty($options[1])){
					$products[$key]['size_attr'] = "&nbsp;(&nbsp;Bust:".$options[1]['bust']."in&nbsp;Waist:".$options[1]['waist']."in&nbsp;Hips:".$options[1]['hip']."in&nbsp;Hollow:".$options[1]['hollow']."in&nbsp;Height:".$options[1]['height']."in&nbsp;)" ;
			}
       		foreach ($options as $option) {
        			if ($option['type'] != 'file') {
				$value = $option['value'];
				} else {
					$upload_info = $this->model_tool_upload->getUploadByCode($option['value']);

					if ($upload_info) {
						$value = $upload_info['name'];
					} else {
						$value = '';
					}
				}
					
				$products[$key]['attr'][] = array(
						'name'  => $option['name'],
					'value' => (utf8_strlen($value) > 20 ? utf8_substr($value, 0, 20) . '..' : $value)
					);						
				}
      		}
			foreach($products as $k2=>$v2){
					if(!empty($v2['attr'])){
						$data['products'][] = array(
							'order_product_id' => $v2['order_product_id'],
				  			'name'             => $v2['name'],
				  			'model'            => $v2['model'],
				  			'option'           => $v2['attr'],
							'size_attr'	 	 => $v2['size_attr'],
				  			'quantity'         => $v2['quantity'],
				  			'price'            => $this->currency->format($v2['price'], $order_info['currency_code'], $order_info['currency_value']),
							'total'            => $this->currency->format($v2['total'], $order_info['currency_code'], $order_info['currency_value'])
						);
					}else{
						$data['products'][] = array(
							'order_product_id' => $v2['order_product_id'],
				  			'name'             => $v2['name'],
				  			'model'            => $v2['model'],
				  			'quantity'         => $v2['quantity'],
				  			'price'            => $this->currency->format($v2['price'], $order_info['currency_code'], $order_info['currency_value']),
							'total'            => $this->currency->format($v2['total'], $order_info['currency_code'], $order_info['currency_value'])
						);
					}
	
			}
		        		
			

		
					
			// Voucher
			$data['vouchers'] = array();

			$vouchers = $this->model_account_order->getOrderVouchers($order_id);

			foreach ($vouchers as $voucher) {
				$data['vouchers'][] = array(
					'description' => $voucher['description'],
					'amount'      => $this->currency->format($voucher['amount'], $order_info['currency_code'], $order_info['currency_value'])
        		);
      		}

			// Totals
			$data['totals'] = array();

      		$totals = $this->model_account_guest->getOrderTotals($order_id );

			foreach ($totals as $total) {
				$data['totals'][] = array(
					'title' => $total['title'],
					'text'  => $this->currency->format($total['value'], $order_info['currency_code'], $order_info['currency_value']),
				);
			}
			
			$data['comment'] = nl2br($order_info['comment']);
			
			$data['histories'] = array();

			$results = $this->model_account_guest->getOrderHistories($order_id );

      		foreach ($results as $result) {
        		$data['histories'][] = array(
          			'date_added' => date($this->language->get('date_format_short'), strtotime($result['date_added'])),
          			'status'     => $result['status'],
					'comment'    => $result['notify'] ? nl2br($result['comment']) : ''
        		);
      		}

      		$data['continue'] = $this->url->link('account/guest', '', 'SSL');
		
			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');;
//echo '<pre>';print_r($data);die;
			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/account/guest_history.tpl')) {
				$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/account/guest_history.tpl', $data));
			} else {
				$this->response->setOutput($this->load->view('default/template/account/guest_history.tpl', $data));
			}
    	} else {
			$this->document->setTitle($this->language->get('text_order'));
			
      		$data['heading_title'] = $this->language->get('text_order');

      		$data['text_error'] = $this->language->get('text_error');

      		$data['button_continue'] = $this->language->get('button_continue');
			
			$data['breadcrumbs'] = array();

			$data['breadcrumbs'][] = array(
				'text'      => $this->language->get('text_home'),
				'href'      => $this->url->link('common/home')
			);
			
												
      		$data['continue'] = $this->url->link('account/guest', '', 'SSL');
			 			
			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');

			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/error/not_found.tpl')) {
				$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/error/not_found.tpl', $data));
			} else {
				$this->response->setOutput($this->load->view('default/template/error/not_found.tpl', $data));
			}
    	}
  	}
	
	private function validate() {
		if (!isset($this->request->post['selected']) || !isset($this->request->post['action']) || !$this->request->post['action']) {
			$this->error['warning'] = $this->language->get('error_warning');
		}
		
		if (!$this->error) {
      		return true;
    	} else {
      		return false;
    	}		
	}
}
?>
