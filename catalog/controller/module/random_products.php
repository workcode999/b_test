<?php
class ControllerModuleRandomProducts extends Controller
{
    public function index($setting)
    {
        $this->load->language('module/random_products');

        $data['heading_title'] = $this->language->get('heading_title');

        $data['text_tax'] = $this->language->get('text_tax');

        $data['button_cart'] = $this->language->get('button_cart');
        $data['text_from'] = $this->language->get('text_from');
        $data['button_wishlist'] = $this->language->get('button_wishlist');
        $data['button_compare'] = $this->language->get('button_compare');

        $this->load->model('catalog/product');
        $this->load->model('catalog/category');
        $this->load->model('tool/image');

        $category_id = (int)$setting['category'];
        $data['category'] = $this->model_catalog_category->getCategory($category_id);

        $data['products'] = array();

        $filter_data = array(
            'filter_category_id' => $category_id,
            'sort' => 'p.date_added',
            'order' => 'DESC',
            'start' => 0,
            'limit' => $setting['limit'],
        );

        $productsFromCategory = $this->model_catalog_product->getProducts($filter_data);

        //print_r($productsFromCategory);

        $results = $productsFromCategory;

        foreach ($results as $result) {
        	unset($pids);
			$PID = $this->model_catalog_product->getTotalProductIDByPID($result['product_id']);
			
			if ($PID['master_product_id'] == -1){
				$pids = $PID['product_id'];
				$colors = $this->model_catalog_product->getColorByProductID($pids);
			}else{
				if($PID['master_product_id'] == 0){
					$parentid = $PID['product_id'];
				}else{
					$parentid = $PID['master_product_id'];
				}
				
				$ids = $this->model_catalog_product->getProductIDByProductID($parentid);
				if(!empty($ids)){
					foreach($ids as $key=>$val){
						$pids[] = $val['product_id'];
					}
					$colors = $this->model_catalog_product->getColorByProductID($pids);
				}else{
					$colors = '';
				}
			}
			$num = count($colors);
			
            if ($result['image']) {
                $image = $this->model_tool_image->resize($result['image'], $setting['width'], $setting['height']);
            } else {
                $image = $this->model_tool_image->resize('placeholder.png', $setting['width'], $setting['height']);
            }

            if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
                $price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')),
                    $this->session->data['currency']);
            } else {
                $price = false;
            }

            if ((float)$result['special']) {
                $special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'],
                    $this->config->get('config_tax')), $this->session->data['currency']);
            } else {
                $special = false;
            }

            if ($this->config->get('config_tax')) {
                $tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price'], $this->session->data['currency']);
            } else {
                $tax = false;
            }

            if ($this->config->get('config_review_status')) {
                $rating = $result['rating'];
            } else {
                $rating = false;
            }

            $data['products'][] = array(
                'product_id' => $result['product_id'],
                'thumb' => $image,
                'name' => $result['name'],
            	'model'		  => $result['model'],
				'off'		  => $result['off'],
				'num'		  => $num,
                'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0,
                        $this->config->get($this->config->get('config_theme') . '_product_description_length')) . '..',
                'price' => $price,
                'special' => $special,
                'tax' => $tax,
                'rating' => $rating,
                'href' => $this->url->link('product/product', 'product_id=' . $result['product_id'])
            );
        }
       // echo '<pre>';print_r($data['products']);die;
	if ($data['products']) {
	if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/random_products.tpl')) {
	return $this->load->view($this->config->get('config_template') . '/template/module/random_products.tpl', $data);
	} else {
	return $this->load->view('default/template/module/random_products.tpl', $data);
	}
	}

}
}