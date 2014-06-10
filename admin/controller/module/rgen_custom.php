<?php
class ControllerModuleRgenCustom extends Controller {
	private $error = array(); 

	/********************************************
	CREATE TABLE FOR RGEN DB */
	public function install() {
		$this->load->model('rgen/rgencustom');
		$this->model_rgen_rgencustom->install();
	}
	/*********************************************/

	public function index() {
		$this->install();
		$this->language->load('module/rgen_custom');

		$this->document->setTitle($this->language->get('heading_title'));
		
		// COLOUR PICKER FILES
		$this->document->addStyle('view/stylesheet/jquery.colorpicker.css');
		$this->document->addScript('view/javascript/jquery/jquery.colorpicker.js');
		
		/********************************************
		POST DATA TO RGEN CUSTOM DB */
		$this->load->model('rgen/rgencustom');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_rgen_rgencustom->editRGen('rgen_custom', $this->request->post);	
			$this->add_entry();

			$this->session->data['success'] = $this->language->get('text_success');
						
			$this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
		}
		/*********************************************/

		$this->data['mod'] = $this->language->get('mod');
		$this->data['ver'] = $this->language->get('ver');

		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_content_top'] = $this->language->get('text_content_top');
		$this->data['text_content_bottom'] = $this->language->get('text_content_bottom');		
		$this->data['text_column_left'] = $this->language->get('text_column_left');
		$this->data['text_column_right'] = $this->language->get('text_column_right');
		
		$this->data['entry_description'] = $this->language->get('entry_description');
		$this->data['entry_layout'] = $this->language->get('entry_layout');
		$this->data['entry_position'] = $this->language->get('entry_position');
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');
		$this->data['entry_title'] = $this->language->get('entry_title');
		$this->data['entry_class'] = $this->language->get('entry_class');
		
		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		$this->data['button_add_module'] = $this->language->get('button_add_module');
		$this->data['button_remove'] = $this->language->get('button_remove');
		
		$this->data['tab_module'] = $this->language->get('tab_module');

 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

  		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_module'),
			'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('module/rgen_custom', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
		$this->data['action'] = $this->url->link('module/rgen_custom', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['token'] = $this->session->data['token'];

		$this->data['modules'] = array();
		
		if (isset($this->request->post['rgen_custom_module'])) {
			$this->data['modules'] = $this->request->post['rgen_custom_module'];
		} elseif ($this->config->get('rgen_custom_module')) { 
			$this->data['old_modules'] = $this->config->get('rgen_custom_module');
		}

		
		$this->data['modules'] = $this->model_rgen_rgencustom->getRGen("rgen_custom");

		$this->delete_old_entry();
		

		/*********************************************************************/
		// Categories
		$this->load->model('catalog/category');
		$this->data['rgen_catlist'] = array();
		
		foreach ($this->data['modules'] as $catarry) {
			if (isset($catarry['category'])) {
				foreach ($catarry['category'] as $cat) {
					$category_info = $this->model_catalog_category->getCategory($cat);
					if ($category_info) {
						$this->data['rgen_catlist'][$catarry['mod_id']][] = array(
							'category_id' => $category_info['category_id'],
							'name'        => ($category_info['path'] ? $category_info['path'] . ' &gt; ' : '') . $category_info['name']
						);	
					}
				}
			}
		}
		//echo "<pre style='color:;'>" . print_r($this->data['rgen_catlist'], TRUE) . "</pre>";
		/*********************************************************************/

		/*********************************************************************/
		// Products
		$this->load->model('catalog/product');
		$this->data['rgen_prdlist'] = array();
		
		foreach ($this->data['modules'] as $prdarry) {
			if (isset($prdarry['prd'])) {
				foreach ($prdarry['prd'] as $prd) {
					$prd_info = $this->model_catalog_product->getProduct($prd);
					if ($prd_info) {
						$this->data['rgen_prdlist'][$prdarry['mod_id']][] = array(
							'product_id' => $prd_info['product_id'],
							'name'        => $prd_info['name']
						);	
					}
				}
			}
		}
		//echo "<pre style='color:;'>" . print_r($this->data['rgen_prdlist'], TRUE) . "</pre>";
		/*********************************************************************/

		/*********************************************************************/
		// Manufacturer 
		$this->load->model('catalog/manufacturer');
		$this->data['rgen_brandlist'] = array();
		
		foreach ($this->data['modules'] as $brdarry) {
			if (isset($brdarry['brand'])) {
				foreach ($brdarry['brand'] as $brd) {
					$brand_info = $this->model_catalog_manufacturer->getManufacturer($brd);
					if ($brand_info) {
						$this->data['rgen_brandlist'][$brdarry['mod_id']][] = array(
							'manufacturer_id' 	=> $brand_info['manufacturer_id'],
							'name'      		=> $brand_info['name']
						);	
					}
				}
			}
		}
		//echo "<pre style='color:;'>" . print_r($this->data['rgen_brandlist'], TRUE) . "</pre>";
		/*********************************************************************/

		/*********************************************************************/
		// Information
		$this->load->model('catalog/information');
		$this->data['rgen_infolist'] = array();
		
		foreach ($this->data['modules'] as $infoarry) {
			if (isset($infoarry['info'])) {
				foreach ($infoarry['info'] as $info) {
					$information_info = $this->model_catalog_information->getInfoPage($info);
					if ($information_info) {
						$this->data['rgen_infolist'][$infoarry['mod_id']][] = array(
							'information_id' 	=> $information_info['information_id'],
							'name'      		=> $information_info['title']
						);
					}
				}
			}
		}
		//echo "<pre style='color:;'>" . print_r($this->data['rgen_infolist'], TRUE) . "</pre>";
		/*********************************************************************/


		
		// Data sorting
		$sort_order = array();
		foreach ($this->data['modules'] as $key => $value) {
			$parts = explode('rgen_custom_module', (string)$value['mod_id']);
			$this->data['sort_data'] = (int)array_pop($parts);
			$sort_order[$key] = $this->data['sort_data'];
		}
		array_multisort($sort_order, SORT_ASC, $this->data['modules']);



		$this->load->model('design/layout');
		$this->data['layoutlist'] = $this->model_design_layout->getLayouts();
		foreach ($this->data['layoutlist'] as $value) {

			$this->data['layouts'][] = array(
				'layout_id'	=>	$value['layout_id'],
				'name' 		=>	$value['name'],
				'route'		=>	$this->model_design_layout->getLayoutRoutes($value['layout_id'])
			);
		}
		$this->data['layouts'][] = array('layout_id'=>99999, 'name' => "All pages", 'route' => "");

		$this->load->model('localisation/language');
		
		$this->data['languages'] = $this->model_localisation_language->getLanguages();

		$this->data['checkPermission'] = $this->user->hasPermission('modify', 'module/rgen_custom');

		$this->template = 'module/rgen_custom.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
	}

	public function delete_old_entry() {
		$this->data['entry_check'] = $this->model_rgen_rgencustom->getRGen("rgen_custom");
		
		if (isset($this->data['old_modules'])) {
			$check_arr = end($this->data['old_modules']);
		}else{
			$check_arr = '';
		}
		
		if(isset($this->data['old_modules']) && !isset($check_arr['data'])){
			$i = count($this->data['modules']);
			foreach ($this->data['old_modules'] as $value) {
				$this->data['modules']['rgen_custom_module' . $i] = $value;
				$this->data['modules']['rgen_custom_module' . $i]['mod_id'] = 'rgen_custom_module' . $i;
			$i++; }
		}
	}

	public function add_entry() {
		$this->data['add_entry'] = $this->model_rgen_rgencustom->getRGen("rgen_custom");
		$this->data['rgen_setting'] = array();
		foreach ($this->data['add_entry'] as $key => $value) {
			$this->data['rgen_setting']['rgen_custom_module'][] = array(
				'mod_id' 		=> $value['mod_id'],
				'layout_id' 	=> $value['layout_id'], 
				'position' 		=> $value['position'], 
				'status' 		=> $value['status'], 
				'sort_order'	=> $value['sort_order'],
				'data'			=> 'new'
			);
		}
		$this->model_rgen_rgencustom->addRGenSetting("rgen_custom", $this->data['rgen_setting']);
	}
	
	protected function validate() {
		if (!$this->user->hasPermission('modify', 'module/rgen_custom')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}
}
?>