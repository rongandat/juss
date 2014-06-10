<?php  
class ControllerModuleRgenCustom extends Controller {
	protected function index($setting) {
		
		$this->data['heading_title'] = sprintf($this->language->get('heading_title'), $this->config->get('config_name'));

		$this->load->model('rgen/rgencustom');
		$this->data['RGen_customs'] = $this->model_rgen_rgencustom->getRGen("rgen_custom");
		$this->data['RGen_custom'] = $this->data['RGen_customs'];

		//echo "<pre style='color:#fff;'>" . print_r($setting, TRUE) . "</pre>";
		
		$this->data['setting'] = $setting;

		/* GET LAYOUT ID
		******************************/
		$this->load->model('design/layout');

		$this->data['getRoute'] = 'common/home';
		if (isset($this->request->get['route'])) {
			$this->data['getRoute'] = $this->request->get['route'];
		} else {
			$this->data['getRoute'] = 'common/home';
		}

		if (isset($this->request->get['route'])) {
			$route = (string)$this->request->get['route'];
		} else {
			$route = 'common/home';
		}
		
		$layout_id = 0;
		
		if ($route == 'product/category' && isset($this->request->get['path'])) {
			$path = explode('_', (string)$this->request->get['path']);

			if (!$this->config->get('config_maintenance')) {
				$layout_id = $this->model_catalog_category->getCategoryLayoutId(end($path));
			}
		}
		
		if ($route == 'product/product' && isset($this->request->get['product_id'])) {
			$layout_id = $this->model_catalog_product->getProductLayoutId($this->request->get['product_id']);
		}
		
		if ($route == 'information/information' && isset($this->request->get['information_id'])) {
			$layout_id = $this->model_catalog_information->getInformationLayoutId($this->request->get['information_id']);
		}
		
		if (!$layout_id) {
			$layout_id = $this->model_design_layout->getLayout($route);
		}
				
		if (!$layout_id) {
			$layout_id = $this->config->get('config_layout_id');
		}
		$this->data['layouts'] = $layout_id;

		/* GET CATEGORY ID
		******************************/
		if (isset($this->request->get['path'])) {
			$parts = explode('_', (string)$this->request->get['path']);
			$this->data['category_id'] = (int)array_pop($parts);
		}else{
			$this->data['category_id'] = '';
		}
		
		/* GET PRODUCT ID
		******************************/
		if (isset($this->request->get['product_id'])) {
			$this->data['product_id'] = (int)$this->request->get['product_id'];
		} else {
			$this->data['product_id'] = 0;
		}

		/* GET BRAND ID
		******************************/
		if (isset($this->request->get['manufacturer_id'])) {
			$this->data['brand_id'] = (int)$this->request->get['manufacturer_id'];
		} else {
			$this->data['brand_id'] = 0;
		} 

		/* GET INFORMATION ID
		******************************/
		if (isset($this->request->get['information_id'])) {
			$this->data['information_id'] = (int)$this->request->get['information_id'];
		} else {
			$this->data['information_id'] = 0;
		} 


		/* RGEN CUSTOM
		******************************/
		if ($this->data['RGen_custom']) {
			$sort_order = array();
			foreach ($this->data['RGen_custom'] as $key => $value) {
				$sort_order[$key] = $value['sort_order'];
			}
			array_multisort($sort_order, SORT_ASC, $this->data['RGen_custom']);
		}

		$this->document->RGen_custom =      $this->data['RGen_custom'];
		$this->document->Layout =           $this->data['layouts'];
		
		//echo "<pre style='color:#FFF;'>" . print_r($this->data['RGen_custom'], TRUE) . "</pre>";

		if($this->config->get('config_template') == "rgen-opencart"){
			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/rgen_custom.tpl')) {
				$this->template = $this->config->get('config_template') . '/template/module/rgen_custom.tpl';
			} else {
				$this->template = 'default/template/module/rgen_custom.tpl';
			}
			$this->render();
		}
		
	}
}
?>