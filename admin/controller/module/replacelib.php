<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);
class ControllerModuleReplacelib extends Controller {
       
       public function index() {
	    
        $this->load->model('module/replacelib');
        
      	$total_data = $this->model_module_replacelib->selectdata1();
		//print_r($total_data);
        $this->language->load('module/replacelib');

        // $this->load->model('module/replacelib');
       
	 
	//exit();
//echo "hi";exit();
        $data['breadcrumbs'] = array();
        $url='';
   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('module/replacelib', 'token=' . $this->session->data['token'] . $url, 'SSL'),
      		'separator' => ' :: '
   		);
		
        $data['heading_title'] = $this->language->get('heading_title');		
        $data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
        $data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');
		$data['text_select_all'] = $this->language->get('text_select_all');
		$data['text_unselect_all'] = $this->language->get('text_unselect_all');
		$data['plugin_description'] = $this->language->get('plugin_description');
		$data['plugin_description1'] = $this->language->get('plugin_description1');
		$data['plugin_description2'] = $this->language->get('plugin_description2');
		$data['total_data'] = $total_data;


		
		if (isset($this->error['warning']))
		{
			$data['error_warning'] = $this->error['warning'];
		} 
		else 
		{
			$data['error_warning'] = '';
		}
      
       $data['action'] = $this->url->link('module/replacelib/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');	
       $data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
       	   
	   $data['modules'] = array();
		
		/*************************** code to find file *********************************/	  
        
		$dir    = '../catalog/view/javascript';
		
		$data['jquery_js']=array();

		
	   $data['jquery_js']=$this->files($dir);
	   	//print_r($data['jquery_js'])
	   	$fileslist = $this->files($dir);

	foreach($fileslist as $myfile){

 		

				 $data['list'][]= array(

							'myfilename' => $myfile,
							'status'   => $this->model_module_replacelib->getstatus($myfile)
							
						);

	
		}

	//print_r($data['list']);
	    $this->template = 'module/replacelib.tpl';
		/*$this->children = array(
			'common/header',
			'common/footer'
		);*/
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');
		
		//$this->response->setOutput($this->render());
		$this->response->setOutput($this->load->view('module/replacelib.tpl', $data));




       }

       public function insert() {
	    $this->language->load('module/replacelib');
       $this->load->model('module/replacelib');
       if ($this->request->server['REQUEST_METHOD'] == 'POST')
	        { 

          $this->model_module_replacelib->addurl($this->request->post);
		  
		  $this->session->data['success'] = $this->language->get('text_success');
		  
		  $this->response->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));

	    	}  
		}
		
	
	    public function files($path,&$files = array())
       {
	   
	   $js_list=array('jquery\-','jquery\-ui\-','mootools\-');

		$dir = opendir($path."/.");
        while($item = readdir($dir))
         if(is_file($sub = $path."/".$item))
		   {
		      foreach($js_list as $js_file)
			  {

			   if(preg_match("|$js_file.*?\d+\.\d+\.\d+.*?\.js|",$item,$new_item))
		      {	
            	
            		$files[] =preg_replace('|\.\./|','',$path."/".$item);


			  }
			  }
			}
			else
            if($item != "." and $item != "..")
            $this->files($sub,$files); 
            return(array_unique($files));
       }




}
?>
