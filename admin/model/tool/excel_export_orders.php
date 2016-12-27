<?php
class ModelToolExcelExportOrders extends Model {
  
	public function getLanguages(){
	  $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "language");
    return $query->rows;
	}
  
	public function getOrderProduct($order_id){
	
	  $product_cell = '';
	  $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "order_product WHERE order_id = '".(int)$order_id."'");
    if($query->rows){
      foreach($query->rows as $product){
        $product_cell .= '['. $product['model'].'] '.$product['name'].' ('.$product['quantity'].'x)
';
    	  $query_option = $this->db->query("SELECT * FROM " . DB_PREFIX . "order_option WHERE order_id = '".(int)$order_id."' AND order_product_id = '".(int)$product['order_product_id']."'");
        if($query_option->rows){
          foreach($query_option->rows as $product_option){
            $product_cell .= ' - '.$product_option['name'].': '.$product_option['value'].'
';
          }
        }
        $product_cell .= "\n";
      }
      return $product_cell;
    }else{
      return '';
    }
	}
	
	public function getDefaultCurrencySR(){
	  $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "currency WHERE value = 1");
    return $query->row['symbol_right'];
	}
	
	public function getShopName(){
	  $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "setting WHERE `key` = 'config_title'");
    if($query->row){return $query->row['value'];}
    else{return '';}
	}
	
  
	public function getLanguageFolder($lang_id){
	  $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "language WHERE language_id = '".(int)$lang_id."'");
    return $query->row['directory'];
	}
	
	public function getCurrencySL($currency_id){
	  $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "currency WHERE currency_id = '".(int)$currency_id."'");
    return $query->row['symbol_left'];
	}
	
	public function getCurrencySR($currency_id){
	  $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "currency WHERE currency_id = '".(int)$currency_id."'");
    return $query->row['symbol_right'];
	}
	
	public function getOrderStatusName($order_status_id){
	  $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "order_status WHERE order_status_id = '".(int)$order_status_id."'");
    if($query->row){return $query->row['name'];}
    else{return "";}
	}
	
	public function getLanguageName($language_id){
	  $query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "language` WHERE language_id = '".$language_id."'");
    if($query->row){return $query->row['name'];}
    else{return "";}
    
	}
	
	public function getProductSku($order_id){
	  
    $return_sku = array();
    
	  $query = $this->db->query("SELECT product_id FROM `" . DB_PREFIX . "order_product` WHERE order_id = '".(int)$order_id."'");
    foreach($query->rows as $op){
	    $product = $this->db->query("SELECT sku FROM `" . DB_PREFIX . "product` WHERE product_id = '".(int)$op['product_id']."'");
      $return_sku[] = $product->row['sku'];
    }
    
    return implode(", ",$return_sku);
	  
	}
	
	public function getCustomerGroupName($customer_group_id){
	  if($customer_group_id){
      $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "customer_group WHERE customer_group_id = '".(int)$customer_group_id."'");
      if(isset($query->row['name'])){echo $query->row['name'];}
    }else{
      return "";
    }
	}
	
	
	

	public function exportExcel($data){
	  $get_data = array();
	
    if(!isset($_COOKIE['language'])){$language = 'english';}
    else{$language = $_COOKIE['language'];}

    require(DIR_LANGUAGE.$this->getLanguageFolder($data['language_id']).'/tool/excel_export_orders.php');
  
  	if(isset($data['download']['order_id'])){$get_data[] = 'order_id';}
  	if(isset($data['download']['invoice_no'])){$get_data[] = 'invoice_no';}

    if(isset($data['separated_products']) AND $data['separated_products'] == 1){
      $separated_products = true;
      if(isset($data['download']['product_id'])){$get_data[] = 'product_id';}
      if(isset($data['download']['product_name'])){$get_data[] = 'product_name';}
      if(isset($data['download']['product_model'])){$get_data[] = 'product_model';}
      if(isset($data['download']['product_sku'])){$get_data[] = 'product_sku';}
      if(isset($data['download']['product_option'])){$get_data[] = 'product_option';}
      if(isset($data['download']['product_price'])){$get_data[] = 'product_price';}
      if(isset($data['download']['product_quantity'])){$get_data[] = 'product_quantity';}
      if(isset($data['download']['product_total_price'])){$get_data[] = 'product_total_price';}
    }else{
    	$separated_products = false;
    	$get_data[] = 'product';
    }

    if(isset($data['download']['total'])){$get_data[] = 'total';}
  	if(isset($data['download']['invoice_prefix'])){$get_data[] = 'invoice_prefix';}
  	if(isset($data['download']['store_name'])){$get_data[] = 'store_name';}
  	if(isset($data['download']['comment'])){$get_data[] = 'comment';}
  	if(isset($data['download']['reward'])){$get_data[] = 'reward';}
  	if(isset($data['download']['order_status_id'])){$get_data[] = 'order_status_id';}
  	if(isset($data['download']['date_added'])){$get_data[] = 'date_added';}
  	if(isset($data['download']['date_modified'])){$get_data[] = 'date_modified';}
  	if(isset($data['download']['ip'])){$get_data[] = 'ip';}
  	if(isset($data['download']['shipping_firstname'])){$get_data[] = 'shipping_firstname';}
  	if(isset($data['download']['shipping_lastname'])){$get_data[] = 'shipping_lastname';}
  	if(isset($data['download']['shipping_company'])){$get_data[] = 'shipping_company';}
  	if(isset($data['download']['shipping_address_1'])){$get_data[] = 'shipping_address_1';}
  	if(isset($data['download']['shipping_address_2'])){$get_data[] = 'shipping_address_2';}
  	if(isset($data['download']['shipping_city'])){$get_data[] = 'shipping_city';}
  	if(isset($data['download']['shipping_postcode'])){$get_data[] = 'shipping_postcode';}
  	if(isset($data['download']['shipping_country'])){$get_data[] = 'shipping_country';}
  	if(isset($data['download']['shipping_zone'])){$get_data[] = 'shipping_zone';}
  	if(isset($data['download']['shipping_address_format'])){$get_data[] = 'shipping_address_format';}
  	if(isset($data['download']['shipping_method'])){$get_data[] = 'shipping_method';}
  	if(isset($data['download']['payment_firstname'])){$get_data[] = 'payment_firstname';}
  	if(isset($data['download']['payment_lastname'])){$get_data[] = 'payment_lastname';}
  	if(isset($data['download']['payment_company'])){$get_data[] = 'payment_company';}
  	if(isset($data['download']['payment_address_1'])){$get_data[] = 'payment_address_1';}
  	if(isset($data['download']['payment_address_2'])){$get_data[] = 'payment_address_2';}
  	if(isset($data['download']['payment_city'])){$get_data[] = 'payment_city';}
  	if(isset($data['download']['payment_postcode'])){$get_data[] = 'payment_postcode';}
  	if(isset($data['download']['payment_country'])){$get_data[] = 'payment_country';}
  	if(isset($data['download']['payment_zone'])){$get_data[] = 'payment_zone';}
  	if(isset($data['download']['payment_address_format'])){$get_data[] = 'payment_address_format';}
  	if(isset($data['download']['payment_method'])){$get_data[] = 'payment_method';}
  	if(isset($data['download']['affiliate_id'])){$get_data[] = 'affiliate_id';}
  	if(isset($data['download']['commission'])){$get_data[] = 'commission';}
  	if(isset($data['download']['language_id'])){$get_data[] = 'language_id';}
  	if(isset($data['download']['currency_value'])){$get_data[] = 'currency_value';}
  	if(isset($data['download']['customer_id'])){$get_data[] = 'customer_id';}
  	if(isset($data['download']['customer_group_id'])){$get_data[] = 'customer_group_id';}
  	if(isset($data['download']['firstname'])){$get_data[] = 'firstname';}
  	if(isset($data['download']['lastname'])){$get_data[] = 'lastname';}
  	if(isset($data['download']['email'])){$get_data[] = 'email';}
  	if(isset($data['download']['telephone'])){$get_data[] = 'telephone';}
  	if(isset($data['download']['fax'])){$get_data[] = 'fax';}

    $price_code = false;
  	if(isset($data['price_code'])){$price_code = true;}

  	
  	
  	
    $export = array();
    $i = 0;
    
    $sql = " WHERE 1 = 1";
    
    if($data['date_start'] AND $data['date_stop']){

      $data['date_start'] = $data['date_start']." 00:00:00";
      $data['date_stop']  = $data['date_stop']." 23:59:59";
    
      $sql .= " AND date_added >= '".$data['date_start']."' AND date_added <= '".$data['date_stop']."'";
    }
    
    $sql .= " AND order_status_id != '0'";
    
    
    
    
	  $all_orders = $this->db->query("SELECT * FROM `" . DB_PREFIX . "order`".$sql);
    foreach($all_orders->rows as $order){
    
    
    
    
    
      foreach($get_data as $dat){
        if($dat != 'order_status_id' AND $dat != 'language_id' AND 
           $dat != 'customer_group_id' AND $dat != 'sku' AND $dat != 'product'){
           if($dat == 'total'){
             if($price_code){
               $export[$i][$dat] = $this->getCurrencySL($order['currency_id']).$order[$dat].$this->getCurrencySR($order['currency_id']);
             }else{
               $export[$i][$dat] = $order[$dat];
             }
           }else{
             
             if(isset($order[$dat])){$export[$i][$dat] = $order[$dat];}
             else{$export[$i][$dat] = "";}
           }
        }else{
          if($dat == 'order_status_id'){$export[$i][$dat] = $this->getOrderStatusName($order['order_status_id']);}
          if($dat == 'language_id'){$export[$i][$dat] = $this->getLanguageName($order['language_id']);}
          if($dat == 'customer_group_id'){$export[$i][$dat] = $this->getCustomerGroupName($order['customer_group_id']);}
          if($dat == 'sku'){$export[$i][$dat] = $this->getProductSku($order['order_id']);}



          if($dat == 'product'){
            $product_data = "";
                  
        	  $products_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "order_product WHERE order_id = '".(int)$order['order_id']."'");
            if($products_query->rows){
              foreach($products_query->rows as $product){
      
      
                  if(isset($data['download']['product_id'])){$product_data .= $_['text_product_id'].": ".$product['product_id'].";\n";}
                  if(isset($data['download']['product_name'])){$product_data .= $_['text_product_name'].": ".$product['name'].";\n";}
                  if(isset($data['download']['product_model'])){$product_data .= $_['text_product_model'].": ".$product['model'].";\n";}
      
                  $product_sku = '';
                  $product_detail = $this->db->query("SELECT sku FROM " . DB_PREFIX . "product WHERE product_id = '".(int)$product['product_id']."'");
                  if($product_detail->row){
                    $product_sku = $product_detail->row['sku'];
                  }
                  if(isset($data['download']['product_sku'])){$product_data .= $_['text_product_sku'].": ".$product_sku.";\n";}
      
      
                 if(isset($data['download']['product_option'])){
                 
                   $product_option_value = "";
                   
                   $product_option_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "order_option WHERE order_id = '".(int)$order['order_id']."' AND order_product_id = '".(int)$product['order_product_id']."'");
                   if($product_option_query->rows){
                     foreach($product_option_query->rows as $product_option){
                       $product_option_value .= "   ".$product_option['name'].": ".$product_option['value'].";\n";
                     }
                   }
                   
                   $product_data .= $_['text_product_option'].": \n";
                   if($product_option_value != ""){
                     $product_data .= $product_option_value.";\n";
                   }
                 }
                 
                 if(isset($data['download']['product_price'])){
                   if($price_code){
                     $product_data .= $_['text_product_price'].": ".$this->getCurrencySL($order['currency_id']).$product['price'].$this->getCurrencySR($order['currency_id']).";\n";
                   }else{
                     $product_data .= $_['text_product_price'].": ".$product['price'].";\n";
                   }
                 }
                 
                 if(isset($data['download']['product_quantity'])){$product_data .= $_['text_product_quantity'].": ".$product['quantity'].";\n";}
                 
                 if(isset($data['download']['product_total_price'])){
                   if($dat == 'product_price'){
                     if($price_code){
                       $product_data .= $_['text_product_total_price'].": ".$this->getCurrencySL($order['currency_id']).$product['total'].$this->getCurrencySR($order['currency_id']).";\n";
                     }else{
                       $product_data .= $_['text_product_total_price'].": ".$product['total'].";\n";
                     }
                   }
                 }
                $product_data = $product_data."\n";
              }
            }
          $export[$i][$dat] = $product_data;
          }
        }
      }
      
      
        
      
      
      
      
      
    if($separated_products){
    
  	  $products_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "order_product WHERE order_id = '".(int)$order['order_id']."'");
      if($products_query->rows){
        foreach($products_query->rows as $product){

          foreach($get_data as $dat){

            if(isset($export[$i][$dat])){
              $export[$i][$dat] = $export[$i][$dat];
            }
    
            if($dat == 'product_id'){$export[$i][$dat] = $product['product_id'];}
            if($dat == 'product_name'){$export[$i][$dat] = $product['name'];}
            if($dat == 'product_model'){$export[$i][$dat] = $product['model'];}
            if($dat == 'product_sku'){
              $product_sku = '';
              $product_detail = $this->db->query("SELECT sku FROM " . DB_PREFIX . "product WHERE product_id = '".(int)$product['product_id']."'");
              if($product_detail->row){
                $product_sku = $product_detail->row['sku'];
              }
              $export[$i][$dat] = $product_sku;
            }

    
        if($dat == 'product_option'){
          $product_option_value = "";
      	  $product_option_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "order_option WHERE order_id = '".(int)$order['order_id']."' AND order_product_id = '".(int)$product['order_product_id']."'");
          if($product_option_query->rows){
            foreach($product_option_query->rows as $product_option){
              $product_option_value .= $product_option['name'].": ".$product_option['value']."\n";
            }
          }
          $export[$i][$dat] = $product_option_value;
        }
            
            
            
            if($dat == 'product_quantity'){$export[$i][$dat] = $product['quantity'];}
            
            if($dat == 'product_price'){
              if($price_code){
                $export[$i][$dat] = $this->getCurrencySL($order['currency_id']).$product['price'].$this->getCurrencySR($order['currency_id']);
              }else{
                $export[$i][$dat] = $product['price'];
              }
            }
            
            
            if($dat == 'product_total_price'){
              if($price_code){
                $export[$i][$dat] = $this->getCurrencySL($order['currency_id']).$product['total'].$this->getCurrencySR($order['currency_id']);
              }else{
                $export[$i][$dat] = $product['total'];
              }
            }
          }
  $i++;
          }
      }
   
   
   
    }else{
       $i++;
    }
      
      
    }
    
    $return['cols'] = $get_data;
    $return['rows'] = $export;
    $return['language_id'] = $data['language_id'];
    
    if(count($return['cols'])){return $this->createExcel($return);}
    else{return false;}
    
    
	}

	public function createExcel($data){
	
    error_reporting(E_ALL);
    date_default_timezone_set('Europe/London');
    require_once '../system/phpexcel/Classes/PHPExcel.php';
    
    $objPHPExcel = new PHPExcel();
    $objPHPExcel->getProperties()->setCreator("DEAWid, DEAWid@seznam.cz")
    							 ->setLastModifiedBy("DEAWid")
    							 ->setTitle("EXCEL BACKUP ORDERS ".$this->getShopName()." FROM ".date("d-m-Y",time()))
    							 ->setSubject("EXCEL BACKUP ORDERS ".$this->getShopName())
    							 ->setDescription("EXCEL BACKUP ORDERS ".$this->getShopName()." FROM ".date("d-m-Y",time()))
    							 ->setKeywords("EXCEL BACKUP ORDERS ".$this->getShopName()." FROM ".date("d-m-Y",time()))
    							 ->setCategory("EXCEL BACKUP ORDERS ".$this->getShopName()." FROM ".date("d-m-Y",time()));
  
    if(!isset($_COOKIE['language'])){$language = 'english';}
    else{$language = $_COOKIE['language'];}

    require(DIR_LANGUAGE.$this->getLanguageFolder($data['language_id']).'/tool/excel_export_orders.php');
  
    $i = 0;
  	foreach($data['cols'] as $col){
  	  $i++;
  	  $lang_title = $_['text_'.$col];
  	  
  	  
  	  $width = "15";
  	  
  	  
  	  if($col == "order_id"){$width = "8";}
  	  if($col == "invoice_no"){$width = "10";}
  	  if($col == "product_id"){$width = "10";}
  	  if($col == "product_name"){$width = "17";}
  	  if($col == "product_model"){$width = "14";}
  	  if($col == "product_quantity"){$width = "16";}
  	  if($col == "product_price"){$width = "13";}
  	  if($col == "product_total_price"){$width = "17";}
  	  if($col == "product"){$width = "100";}
  	  if($col == "invoice_prefix"){$width = "13";}
  	  if($col == "store_name"){$width = "15";}
  	  if($col == "comment"){$width = "14";}
  	  if($col == "total"){$width = "12";}
  	  if($col == "reward"){$width = "12";}
  	  if($col == "order_status_id"){$width = "14";}
  	  if($col == "date_added"){$width = "18";}
  	  if($col == "date_modified"){$width = "18";}
  	  if($col == "ip"){$width = "15";}
  	  if($col == "shipping_firstname"){$width = "19";}
  	  if($col == "shipping_lastname"){$width = "19";}
  	  if($col == "shipping_company"){$width = "19";}
  	  if($col == "shipping_address_1"){$width = "19";}
  	  if($col == "shipping_address_2"){$width = "19";}
  	  if($col == "shipping_city"){$width = "19";}
  	  if($col == "shipping_postcode"){$width = "19";}
  	  if($col == "shipping_country"){$width = "19";}
  	  if($col == "shipping_zone"){$width = "19";}
  	  if($col == "shipping_address_format"){$width = "19";}
  	  if($col == "shipping_method"){$width = "19";}
  	  if($col == "payment_firstname"){$width = "19";}
  	  if($col == "payment_lastname"){$width = "19";}
  	  if($col == "payment_company"){$width = "19";}
  	  if($col == "payment_address_1"){$width = "19";}
  	  if($col == "payment_address_2"){$width = "19";}
  	  if($col == "payment_city"){$width = "19";}
  	  if($col == "payment_postcode"){$width = "19";}
  	  if($col == "payment_country"){$width = "19";}
  	  if($col == "payment_zone"){$width = "19";}
  	  if($col == "payment_address_format"){$width = "22";}
  	  if($col == "payment_method"){$width = "18";}
  	  if($col == "affiliate_id"){$width = "12";}
  	  if($col == "commission"){$width = "12";}
  	  if($col == "language_id"){$width = "12";}
  	  if($col == "currency_value"){$width = "14";}
  	  if($col == "customer_id"){$width = "11";}
  	  if($col == "customer_group_id"){$width = "16";}
  	  if($col == "firstname"){$width = "19";}
  	  if($col == "lastname"){$width = "19";}
  	  if($col == "email"){$width = "19";}
  	  if($col == "telephone"){$width = "19";}
  	  if($col == "fax"){$width = "19";}
  	  if($col == "sku"){$width = "19";}
      
    //set width
      $objPHPExcel->getActiveSheet()->getColumnDimension($this->IncToAbc($i))->setWidth($width);
      $objPHPExcel->getActiveSheet()->setCellValue($this->IncToAbc($i).'1', $lang_title);
    }
    
    $objPHPExcel->getActiveSheet()->getStyle('A1:'.$this->IncToAbc($i).'1')->getFont()->setBold(true);
    $objPHPExcel->getActiveSheet()->getStyle('A1:'.$this->IncToAbc($i).'1')->getFill()->setFillType(PHPExcel_Style_Fill::FILL_SOLID);
    $objPHPExcel->getActiveSheet()->getStyle('A1:'.$this->IncToAbc($i).'1')->getFill()->getStartColor()->setARGB('FFA0A0A0');
    
    $row_num = 2;
    $i = 0;
    foreach($data['rows'] as $row){
        $col_num = 1;
    	  foreach($data['cols'] as $col){
    	    $coordinate = $this->IncToAbc($col_num).$row_num;
    	    if(isset($row[$col])){
    	      $cell_value = htmlspecialchars_decode($row[$col]);
          }else{
            $cell_value = "";
          }
          $objPHPExcel->getActiveSheet()->setCellValue($coordinate, $cell_value);
          
          if($objPHPExcel->getActiveSheet()->getCell('A'.$row_num)->getValue() != ""){
            $styleArray = array(
              'borders' => array(
                'top' => array(
                  'style' => PHPExcel_Style_Border::BORDER_THIN,
                  'color' => array('argb' => 'FFA0A0A0'),
                )
              )
            );
            $objPHPExcel->getActiveSheet()->getStyle($coordinate)->applyFromArray($styleArray);
          }
          
          $col_num++;
        }
      $i++;
      $row_num++;
    }
  
    $objPHPExcel->setActiveSheetIndex(0);
  
    require_once '../system/phpexcel/Classes/PHPExcel/IOFactory.php';
    $objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel5');


    
    $xls_name = 'XLS-BACKUP-ORDERS.xls';
    $xls_full_filename = '../system/download/'.$xls_name;
    if(VERSION >= "2.1.0.1"){
      $xls_full_filename = '../system/storage/download/'.$xls_name;
    }
    $objWriter->save($xls_full_filename);

    
    return $xls_name;
	}

	public function IncToAbc($num){
  	if($num == 1){return 'A';}
  	if($num == 2){return 'B';}
  	if($num == 3){return 'C';}
  	if($num == 4){return 'D';}
  	if($num == 5){return 'E';}
  	if($num == 6){return 'F';}
  	if($num == 7){return 'G';}
  	if($num == 8){return 'H';}
  	if($num == 9){return 'I';}
  	if($num == 10){return 'J';}
  	if($num == 11){return 'K';}
  	if($num == 12){return 'L';}
  	if($num == 13){return 'M';}
  	if($num == 14){return 'N';}
  	if($num == 15){return 'O';}
  	if($num == 16){return 'P';}
  	if($num == 17){return 'Q';}
  	if($num == 18){return 'R';}
  	if($num == 19){return 'S';}
  	if($num == 20){return 'T';}
  	if($num == 21){return 'U';}
  	if($num == 22){return 'V';}
  	if($num == 23){return 'W';}
  	if($num == 24){return 'X';}
  	if($num == 25){return 'Y';}
  	if($num == 26){return 'Z';}
  	if($num == 27){return 'AA';}
  	if($num == 28){return 'AB';}
  	if($num == 29){return 'AC';}
  	if($num == 30){return 'AD';}
  	if($num == 31){return 'AE';}
  	if($num == 32){return 'AF';}
  	if($num == 33){return 'AG';}
  	if($num == 34){return 'AH';}
  	if($num == 35){return 'AI';}
  	if($num == 36){return 'AJ';}
  	if($num == 37){return 'AK';}
  	if($num == 38){return 'AL';}
  	if($num == 39){return 'AM';}
  	if($num == 40){return 'AN';}
  	if($num == 41){return 'AO';}
  	if($num == 42){return 'AP';}
  	if($num == 43){return 'AQ';}
  	if($num == 44){return 'AR';}
  	if($num == 45){return 'AS';}
  	if($num == 46){return 'AT';}
  	if($num == 47){return 'AU';}
  	if($num == 48){return 'AV';}
  	if($num == 49){return 'AW';}
  	if($num == 50){return 'AX';}
  	if($num == 51){return 'AY';}
  	if($num == 52){return 'AZ';}
  	if($num == 53){return 'BA';}
	}
}


?>