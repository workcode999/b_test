<?php
class ControllerModuleFilter extends Controller {
	public function index() {
		if (isset($this->request->get['path'])) {
			$parts = explode('_', (string)$this->request->get['path']);
		} else {
			$parts = array();
		}

		$category_id = end($parts);

		$this->load->model('catalog/category');

		$category_info = $this->model_catalog_category->getCategory($category_id);

		if ($category_info) {
			$this->load->language('module/filter');

			$data['heading_title'] = $this->language->get('heading_title');

			$data['button_filter'] = $this->language->get('button_filter');

			if (isset($this->request->get['sort'])) {
				$sort = $this->request->get['sort'];
			} else {
				$sort = 'p.sort_order';
			}
	
			if (isset($this->request->get['order'])) {
				$order = $this->request->get['order'];
			} else {
				$order = 'ASC';
			}
			//Price range
			if (isset($this->request->get['area'])) {
				$area = $this->request->get['area'];
			}else{
				$area = '';
			}

			if (isset($this->request->get['filter'])) {
				$filter = $this->request->get['filter'];
			}else{
				$filter = '';
			}
			
			$url = '';
			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}
			
			if (isset($this->request->get['area'])) {
				$url .= '&area=' . $this->request->get['area'];
			}
			
			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			
			$data['action'] = str_replace('&amp;', '&', $this->url->link('product/category', 'path=' . $this->request->get['path'] . $url));

			$url = '';
			if (isset($this->request->get['filter'])) {
				$url .= '&filter=' . $this->request->get['filter'];
			}
			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}
			
			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$data['remove_area'] = str_replace('&amp;', '&', $this->url->link('product/category', 'path=' . $this->request->get['path'].$url));

			if (isset($this->request->get['filter'])) {
				$data['filter_category'] = explode(',', $this->request->get['filter']);
			} else {
				$data['filter_category'] = array();
			}

			$this->load->model('catalog/product');

			$filter_data = array(
						'filter_category_id' => end($parts),
						'filter_filter'      => $filter,
						'sort'               => $sort,
						'order'              => $order,
						'area'				 => $area
					);
			
			$implode = $this->model_catalog_product->getProducts($filter_data,1);

			$data['filter_groups'] = array();
			
			$filter_groups = $this->model_catalog_category->getCategoryFilters($category_id);

			if ($filter_groups) {
				foreach ($filter_groups as $filter_group) {
					$childen_data = array();

					foreach ($filter_group['filter'] as $filter) {
						$filter_data = array(
							'filter_category_id' => $category_id,
							'filter_filter'      => $filter['filter_id']
						);

						//the number of statistical product attributes
						if(!empty($implode)){
							$f_c = (int)$this->model_catalog_product->getAttributeByCidPid(end($parts),$implode,$filter['filter_id']);
						}else{
							$f_c = 0;
						}
						if(!empty($f_c)){
							$childen_data[] = array(
								'filter_id' => $filter['filter_id'],
								'name'      => $filter['name'] . ($this->config->get('config_product_count') ? ' (' . $this->model_catalog_product->getTotalProducts($filter_data) . ')' : ''),
								'filter_count' => $f_c
							);
						}
					}

					if(!empty($childen_data)){
						$data['filter_groups'][] = array(
							'filter_group_id' => $filter_group['filter_group_id'],
							'name'            => $filter_group['name'],
							'filter'          => $childen_data
						);
					}
				}
				
				$url = '';
				if (isset($this->request->get['sort'])) {
					$url .= '&sort=' . $this->request->get['sort'];
				}
			
				if (isset($this->request->get['order'])) {
					$url .= '&order=' . $this->request->get['order'];
				}
				
				if (isset($this->request->get['limit'])) {
					$url .= '&limit=' . $this->request->get['limit'];
				}
				if (isset($this->request->get['filter'])) {
					$url .= '&filter=' . $this->request->get['filter'];
				}

				//The price range with the change of currency
				$data['price_range'] = array();
			        	$price_range = array(100,200,300,400);
			        	 
			          foreach($price_range as $k=>$v){
			           if($k == 0){
			           	$p_r['name'] = $this->currency->format($this->tax->calculate($v, 0, $this->config->get('config_tax')));
			          		$p_r['href'] = $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&area=0,' .$v.$url);
			          		$p_r['values']  = '0,'.$v;
							$filter_data['area'] = $p_r['values'];
							$p_r['count'] = $this->model_catalog_product->getTotalProducts($filter_data);
			           }else{
			           	$p_r['name'] = $this->currency->format($this->tax->calculate($price_range[$k-1], 0, $this->config->get('config_tax'))) . '-' . $this->currency->format($this->tax->calculate($v, 0, $this->config->get('config_tax')));
			          	    $p_r['href'] = $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&area=' .$price_range[$k-1] . ',' . $price_range[$k] . $url);
			          	    $p_r['values']  =$price_range[$k-1] . ',' . $price_range[$k];
							$filter_data['area'] = $p_r['values'];
							$p_r['count'] = $this->model_catalog_product->getTotalProducts($filter_data);

			           }
			          
			          	$p[] = $p_r;
			          }
			
			         	$ps['name'] = $this->currency->format($this->tax->calculate($price_range[3], 0, $this->config->get('config_tax')));
			        	$ps['href'] = $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&area=' .$price_range[3] . $url);
			        	$ps['values']  = $price_range[3];
						$filter_data['area'] = $ps['values'];
						$ps['count'] = $this->model_catalog_product->getTotalProducts($filter_data);
						$p[4] = $ps;
						$data['price_range'] = $p;


				if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/filter.tpl')) {
					return $this->load->view($this->config->get('config_template') . '/template/module/filter.tpl', $data);
				} else {
					return $this->load->view('default/template/module/filter.tpl', $data);
				}
			}
		}
	}
}
