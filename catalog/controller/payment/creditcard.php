<?php
include("Mobile_Detect.php");
error_reporting(0);
class ControllerPaymentCreditCard extends Controller {
	const paymentMethod = 'Credit Card';
	public function confirm()
	{
		$this->load->model('checkout/order');
		
		//$this->model_checkout_order->confirm($this->session->data['order_id'], $this->config->get('creditcard_order_status_id'));
	}
	public function index() {	
		$detect = new Mobile_Detect(); 
		if($detect->isiOS()){  
			$_SESSION['isMobile']='1';
		}  
		elseif($detect->isMobile()){  
			$_SESSION['isMobile']='1';
		}  
		elseif($detect->isTablet()){ 
			$_SESSION['isMobile']='0'; 
		} 
		else
		{
			$_SESSION['isMobile']='0';
		}
		$data['button_confirm'] = $this->language->get('button_confirm');
		$data['button_back'] = $this->language->get('button_back');
		//$data['action'] = HTTPS_SERVER . 'index.php?route=payment/creditcard&token='. $this->session->data['token'];
		
		$this->load->model('checkout/order');
		
		$order_info = $this->model_checkout_order->getOrder($this->session->data['order_id']);

		
		
		$this->load->library('encryption');
		$this->id = 'payment';
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/payment/creditcard.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/template/payment/creditcard.tpl', $data);
		} else {
			return $this->load->view('default/template/payment/creditcard.tpl', $data);
		}	
	}
	
	public function creditcardiframe()
	{
		
		$this->children = array(
			'common/content_top',
			'common/content_bottom',
			'common/footer',
			'common/header'			
		);

		$this->tocreditcard();
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/payment/creditcardiframe.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/template/payment/creditcardiframe.tpl',$data);
		} else {
			return $this->load->view('default/template/payment/creditcardiframe.tpl',$data);
		}
		
	}
	
	public function tocreditcard() {
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');
		

		$data['button_confirm'] = $this->language->get('button_confirm');
		$data['button_back'] = $this->language->get('button_back');
		$this->load->model('checkout/order');
		//$this->model_checkout_order->confirm($this->session->data['order_id'], 
		$this->config->get('creditcard_order_status_id');
		$order_info = $this->model_checkout_order->getOrder($this->session->data['order_id']);
		$this->load->library('encryption');
		
		$action = $this->config->get('creditcard_gateway');    //提交网关
		$data['action'] = $action;
		
		$merNo= $this->config->get('creditcard_merchant');     //商户号
		$data['merNo'] =$merNo;
		
	 	$gatewayNo= $this->config->get('creditcard_gatewayno');   //网关号
		$data['gatewayNo'] =$gatewayNo;
	
	 	$orderNo=$order_info['order_id'];             //订单号
		$data['orderNo'] = $orderNo;
		
	 	$orderAmount=$this->currency->format($order_info['total'], $order_info['currency_code'], '', FALSE);
		$data['orderAmount'] = $orderAmount;       //总额
		
	    $orderCurrency=$order_info['currency_code'];     //币种
		$data['orderCurrency'] = $orderCurrency;
		
		

				$returnUrl=HTTPS_SERVER.'index.php?route=payment/creditcard/callback';

		$data['returnUrl'] = $returnUrl;            //返回地址
		
		$remark = '';
	 	$data['remark'] = '';                     //备注
		
	    $signkey=$this->config->get('creditcard_signkey');        //sign密匙
	    
		$signsrc = $merNo.$gatewayNo.$orderNo.$orderCurrency.$orderAmount.$returnUrl.$signkey;
	 	$signInfo = hash("sha256",$signsrc);            //signkey加密
		$data['signInfo']=$signInfo;
		
	    $paymentMethod="Credit Card";                //支付方式
		$data['paymentMethod'] = $paymentMethod;

		$firstName = $order_info['payment_firstname'];     //其他信息
	    $lastName = $order_info['payment_lastname'];
	    $email =$order_info['email'];
	    $phone=empty($order_info['shipping_custom_field'][3])?$order_info['payment_custom_field'][3]:$order_info['shipping_custom_field'][3];
	    $zip = $order_info['payment_postcode'];
		$isMobile = $_SESSION['isMobile'];
		$rand='';
		for($i=0;$i<6;$i++)
		{
			$temp=rand(0,9);
			$rand.=$temp;
		}
		$zip=empty($zip)?$rand:$zip;
		$interfaceInfo='opencart';
		$interfaceVersion='V2.3';
		$isMobile=$_SESSION['isMobile'];

	    $city = $order_info['payment_city'];
	    $state = $order_info['payment_zone'];
	    $country =$order_info['payment_country'];
		if (!$order_info['payment_address_2']) {
			$address = $order_info['payment_address_1'] ;
		} else {
			$address = $order_info['payment_address_1'] . ', ' . $order_info['payment_address_2'];
		}
		
		$data['firstName'] = $firstName;
		$data['lastName'] = $lastName;
		$data['email'] = $email;
		$data['phone'] = $phone;
		$data['zip'] = $zip;
		$data['city'] = $city;
		$data['state'] = $state;
		$data['country'] = $country;
		$data['address'] = $address;
		$data['interfaceInfo']=$interfaceInfo;
		$data['interfaceVersion']=$interfaceVersion;
		$data['isMobile']=$isMobile;
	 		
		
		//记录post log
		$filedate = date('Y-m-d');			
		$postdate = date('Y-m-d H:i:s');			
		$newfile  = fopen( "globebill_log/" . $filedate . ".log", "a+" );		
		$post_log = $postdate."[POST]\r\n" .
				"merNo = "        .$merNo . "\r\n".
				"gatewayNo = "    .$gatewayNo . "\r\n".
				"orderNo = "      .$orderNo . "\r\n".
				"orderCurrency = ".$orderCurrency . "\r\n".
				"orderAmount = "  .$orderAmount . "\r\n".
				"returnUrl = "    .$returnUrl . "\r\n".
				"signInfo = "     .$signInfo . "\r\n".
				"firstName = "    .$firstName . "\r\n".
				"lastName = "     .$lastName . "\r\n".
				"email = "        .$email . "\r\n".
				"phone = "        .$phone . "\r\n".
				"remark = "       .$remark . "\r\n".
				"paymentMethod = ".$paymentMethod . "\r\n".
				"country = "      .$country . "\r\n".
				"state = "        .$state . "\r\n".
				"city = "         .$city . "\r\n".
				"address = "      .$address . "\r\n".
				"zip = "          .$zip . "\r\n".
				"interfaceInfo = ".$interfaceInfo . "\r\n".
				"interfaceVersion = ".$interfaceVersion . "\r\n".
				"isMobile = ".$isMobile . "\r\n";		
		$post_log = $post_log . "*************************************\r\n";		
		$post_log = $post_log.file_get_contents( "globebill_log/" . $filedate . ".log");		
		$filename = fopen( "globebill_log/" . $filedate . ".log", "r+" );	
		fwrite($filename,$post_log);
		fclose($filename);
		fclose($newfile);
		
		if ($this->request->get['route'] != 'checkout/guest_step_3') {
			$data['back'] = HTTPS_SERVER . 'index.php?route=checkout/payment';
		} else {
			$data['back'] = HTTPS_SERVER . 'index.php?route=checkout/guest_step_2';
		}
		
		$this->id = 'payment';

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/payment/creditcardiframe.tpl')) {
			 $this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/payment/creditcardiframe.tpl',$data));
		} else {
			 $this->response->setOutput($this->load->view('default/template/payment/creditcardiframe.tpl',$data));
		}	
				
	}
	public function callback() {
		if (isset($this->request->post['orderNo']) && !(empty($this->request->post['orderNo']))) {
			$this->load->language('payment/creditcard');
		
			$data['title'] = sprintf($this->language->get('heading_title'), $this->config->get('config_name'));

			if (!isset($this->request->server['HTTPS']) || ($this->request->server['HTTPS'] != 'on')) {
				$data['base'] = HTTP_SERVER;
			} else {
				$data['base'] = HTTPS_SERVER;
			}
		
			$data['charset'] = $this->language->get('charset');
			$data['language'] = $this->language->get('code');
			$data['direction'] = $this->language->get('direction');
			
            $data['text_success_url'] = HTTPS_SERVER . 'index.php?route=checkout/success';
			$data['text_failure_url'] = HTTPS_SERVER . 'index.php?route=payment/creditcard/creditcardiframe';


			//成功交易
			$data['heading_title'] = sprintf($this->language->get('heading_title'), $this->config->get('config_name'));			
			$data['text_response_success'] = sprintf($this->language->get('text_response_success'), HTTPS_SERVER . 'index.php?route=account/order/info&order_id=' . $this->request->post['orderNo'], $this->request->post['orderNo'], $this->currency->format($this->request->post['orderAmount']));

			$data['text_success_wait'] = sprintf($this->language->get('text_success_wait'), HTTP_SERVER . 'index.php?route=checkout/success');


			//失败交易
			$data['heading_title_failure'] = sprintf($this->language->get('heading_title_failure'), $this->config->get('config_name'));
			$data['text_response_failure'] = sprintf($this->language->get('text_response_failure'), HTTPS_SERVER . 'index.php?route=account/order/info&order_id=' . $this->request->post['orderNo'], $this->request->post['orderNo'], $this->currency->format($this->request->post['orderAmount']));

			$data['text_failure_wait'] = sprintf($this->language->get('text_failure_wait'), HTTP_SERVER . 'contact-us.html');


			//返回信息
			$merNo= $this->config->get('creditcard_merchant');
			$gatewayNo= $this->config->get('creditcard_gatewayno');
			$tradeNo = $this->request->post['tradeNo'];
			$orderNo = $this->request->post['orderNo'];
			$orderCurrency =$this->request->post['orderCurrency'];
			$orderAmount =$this->request->post['orderAmount'];
			$orderStatus =$this->request->post['orderStatus'];
			$signInfo = $this->request->post['signInfo'];
			$orderInfo = $this->request->post['orderInfo'];
			$signkey=$this->config->get('creditcard_signkey');


			/* 针对指定失败交易匹配具体类型 */
			preg_match('/declined/si', $orderInfo, $dec);
			preg_match('/sufficient/si', $orderInfo, $nsf);
			preg_match('/honour/si', $orderInfo, $dno);
			preg_match('/permitted/si', $orderInfo, $per);
			
			if(isset($nsf[0])) {
				$data['text_failure'] = sprintf($this->language->get('text_failure_funds'), HTTPS_SERVER . 'index.php?route=payment/creditcard/creditcardiframe');
			}
			elseif(isset($dec[0])) {
				$data['text_failure'] = sprintf($this->language->get('text_failure_declined'), HTTPS_SERVER . 'index.php?route=payment/creditcard/creditcardiframe');
			}
			elseif(isset($dno[0])) {
				$data['text_failure'] = sprintf($this->language->get('text_failure_declined'), HTTPS_SERVER . 'index.php?route=payment/creditcard/creditcardiframe');
			}
			elseif(isset($per[0])) {
				$data['text_failure'] = sprintf($this->language->get('text_failure_declined'), HTTPS_SERVER . 'index.php?route=payment/creditcard/creditcardiframe');
			}
			else {
				$data['text_failure'] = sprintf($this->language->get('text_failure'), HTTPS_SERVER . 'index.php?route=payment/creditcard/creditcardiframe');
			}

			//签名数据
			$signsrc = $merNo.$gatewayNo.$tradeNo.$orderNo.$orderCurrency.$orderAmount.$orderStatus.$orderInfo.$signkey;
			$signInfocheck =strtoupper(hash("sha256",$signsrc));
			$message = '';
			
			if(isset($this->request->post['isPush']) == '1'){      //检测是否推送 1为推送  空为正常POST
				$logtype = '[PUSH]';   
				$mestype = '(PUSH)';
				$isPush  = $this->request->post['isPush'];
			}else{
				$logtype = '[RETURN]';    
				$mestype = '(POST)';
				$isPush  = '';
			}
			
			//记录日志
			$filedate   = date('Y-m-d');
			$returndate = date('Y-m-d H:i:s');
			$newfile    = fopen( "globebill_log/" . $filedate . ".log", "a+" );
			$return_log = $returndate . $logtype. "\r\n".
					"isPush = "       . $isPush . "\r\n".
					"merNo = "        . $_REQUEST['merNo'] . "\r\n".
					"gatewayNo = "    . $_REQUEST['gatewayNo'] . "\r\n".
					"tradeNo = "      . $_REQUEST['tradeNo'] . "\r\n".
					"orderNo = "      . $_REQUEST['orderNo'] . "\r\n".
					"orderCurrency = ". $_REQUEST['orderCurrency'] . "\r\n".
					"orderAmount = "  . $_REQUEST['orderAmount'] . "\r\n".
					"orderStatus = "  . $_REQUEST['orderStatus'] . "\r\n".
					"orderInfo = "    . $_REQUEST['orderInfo'] . "\r\n".
					"signInfo = "     . $_REQUEST['signInfo'] . "\r\n".
					"riskInfo = "     . $_REQUEST['riskInfo'] . "\r\n".
					"remark = "       . $_REQUEST['remark'] . "\r\n";
			
			$return_log = $return_log . "*************************************\r\n";
			$return_log = $return_log.file_get_contents( "globebill_log/" . $filedate . ".log");
			$filename   = fopen( "globebill_log/" . $filedate . ".log", "r+" );
			fwrite($filename,$return_log);
			fclose($filename);
			fclose($newfile);
	
			if ($orderStatus=="1"){           //交易状态
				$message .= $mestype . 'PAY:success。';
			}elseif ($orderStatus=="0"){
				$message .= $mestype . 'PAY:failure。';
			}elseif ($orderStatus=="-1"){
				$message .= $mestype . 'PAY:wait。';
			}elseif ($orderStatus=="-2"){
				$message .= $mestype . 'PAY:wait。';
			}
	
			if (isset($this->request->post['orderNo'])) {
				$message .= 'OrderNo: ' . $this->request->post['orderNo'] . ' | TradeNo:' . $tradeNo . ' | orderInfo:' . $orderInfo . "\n";
			}

			if ($signInfocheck == $signInfo) {     //数据签名对比
				
				//是否推送，isPush:1则是推送，为空则是POST返回
				if($isPush == '1'){
					
					if(substr($orderInfo,0,5) == 'I0061'){	 //排除订单号重复(I0061)的交易
						
					}else{
						if ($orderStatus=="1" ){   //交易成功
							$this->load->model('checkout/order');
							$this->model_checkout_order->addOrderHistory($this->request->post['orderNo'], $this->config->get('creditcard_success_order_status_id'), $message, FALSE);	
							$this->response->setOutput($this->render(TRUE), $this->config->get('config_compression'));
						
						}elseif ($orderStatus=="-1" || $orderStatus=="-2"){   //交易待确认，待处理     二次支付			
							$this->load->model('checkout/order');				
							$message .= 'Result: ' . $orderStatus . "\n";					
							$this->model_checkout_order->addOrderHistory($this->request->post['orderNo'], $this->config->get('creditcard_failed_order_status_id'),$message, FALSE);
							$this->response->setOutput($this->render(TRUE), $this->config->get('config_compression'));
								
						}else{     //交易失败
							$this->load->model('checkout/order');		
							$message .= 'Result: ' . $orderStatus . "\n";			
							$this->model_checkout_order->addOrderHistory($this->request->post['orderNo'], $this->config->get('creditcard_failed_order_status_id'),$message, FALSE);		
							$this->response->setOutput($this->render(TRUE), $this->config->get('config_compression'));
								
 						}		
					}
					
				}elseif($isPush == ''){		
					
					//正常 POST返回
					if(substr($orderInfo,0,5) == 'I0061'){	 //排除订单号重复(I0061)的交易
						
						if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/payment/creditcard_failure.tpl')) {
							$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/payment/creditcard_failure.tpl',$data),$this->config->get('config_compression'));
						} else {
							$this->response->setOutput($this->load->view('default/template/payment/creditcard_failure.tpl',$data),$this->config->get('config_compression'));
						}
						
						
					}else{
						if ($orderStatus=="1" ){  //交易成功
							$this->load->model('checkout/order');
							$this->model_checkout_order->addOrderHistory($this->request->post['orderNo'], $this->config->get('creditcard_success_order_status_id'), $message, FALSE);
							
							$data['continue'] = HTTPS_SERVER . 'index.php?route=checkout/success';
							if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/payment/creditcard_success.tpl')) {
								$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/payment/creditcard_success.tpl',$data),$this->config->get('config_compression'));
							} else {
								$this->response->setOutput($this->load->view('default/template/payment/creditcard_successs.tpl',$data),$this->config->get('config_compression'));
							}
							
								
						}elseif ($orderStatus=="-1" || $orderStatus=="-2"){   //交易待确认，待处理     二次支付
							$this->load->model('checkout/order');
							$message .= 'Result: ' . $orderStatus . "\n";
							$this->model_checkout_order->addOrderHistory($this->request->post['orderNo'], $this->config->get('creditcard_failed_order_status_id'),$message, FALSE);
							if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/payment/creditcard_failure.tpl')) {
								$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/payment/creditcard_failure.tpl',$data),$this->config->get('config_compression'));
							} else {
								$this->response->setOutput($this->load->view('default/template/payment/creditcard_failure.tpl',$data),$this->config->get('config_compression'));
							}
							
						}else{     //交易失败
							$this->load->model('checkout/order');
							$message .= 'Result: ' . $orderStatus . "\n";
							$this->model_checkout_order->addOrderHistory($this->request->post['orderNo'], $this->config->get('creditcard_failed_order_status_id'),$message, FALSE);
							if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/payment/creditcard_failure.tpl')) {
								$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/payment/creditcard_failure.tpl',$data),$this->config->get('config_compression'));
							} else {
								$this->response->setOutput($this->load->view('default/template/payment/creditcard_failure.tpl',$data),$this->config->get('config_compression'));
							}
							
								
						}
 					}								
				}
		
			} else {     //数据签名对比失败
				$this->load->model('checkout/order');
				$message .= 'Result: ' . $orderStatus . "\n";			
				$this->model_checkout_order->addOrderHistory($this->request->post['orderNo'], $this->config->get('creditcard_failed_order_status_id'),$message, FALSE);	
				if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/payment/creditcard_failure.tpl')) {
					$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/payment/creditcard_failure.tpl',$data),$this->config->get('config_compression'));
				} else {
					$this->response->setOutput($this->load->view('default/template/payment/creditcard_failure.tpl',$data),$this->config->get('config_compression'));
				}
	  				
			}
		}
	}
}
?>
