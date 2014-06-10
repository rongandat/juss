<?php  
class ControllerModuleRgenTheme extends Controller {
	protected function index() {
		
		$this->language->load('module/rgen_theme');
		$this->data['RGenData_mod'] = $this->config->get('RGenData_mod');
		$this->data['RGen_module'] 	= $this->config->get('RGen_module');

		/* GET LANGUAGE ID
		******************************/
		$this->load->model('localisation/language');
		$this->data['languages'] = $this->model_localisation_language->getLanguages();
		$this->data['language_id'] = array();
		foreach ($this->data['languages'] as $result) {
      		$this->data['language_id'][] = array(
        		'language_id' => $result['language_id']
      		);
    	}
		$this->document->Lang_id = $this->data['language_id'];
		//echo "<pre style='color:#fff;'>" . print_r($this->document->Lang_id, TRUE) . "</pre>";
		

		/* Information menu 
		******************************/
		$this->data['informations'] = array();
		foreach ($this->model_catalog_information->getInformations() as $result) {
			$this->data['informations'][] = array(
				'title' => $result['title'],
				'href'  => $this->url->link('information/information', 'information_id=' . $result['information_id'])
			);
		}
		$this->document->RGen_infoMenu = $this->data['informations'];
		

		// ALL RGEN MODULE ARRAYS
		$this->data['RGen_ddMenu'] 		= array();
		$this->data['RGen_menu_item']	= array();
		$this->data['RGen_HtmlMenu']	= array();
		$this->data['RGen_HtmlMenuMod']	= array();
		$this->data['RGen_Menu']		= array();
		$this->data['RGen_CustomFt']	= array();
		$this->data['RGen_social']		= array();
		$this->data['caption1']			= array();
		$this->data['caption2']			= array();

		if($this->data['RGen_module']){
			/* CUSTOM DROPDOWN MENU
			******************************/
			$i = 0;
			foreach ($this->data['RGen_module'] as $result) {
				$m = 0; //[0] = DROPDOWN MENU
				$this->data['RGen_ddMenu'][$this->data['language_id'][$i]['language_id']] = array(
					'name'			=>	$result['Menu'][$m]['name'],	
					'url'			=>	$result['Menu'][$m]['url'],
					'ddMenuItems'	=>	$result['Menu'][$m]['ddMenuItems']
				);
				$i++;
			}

			/* CUSTOM MENU ITEMS
			******************************/
			$i = 0;
			foreach ($this->data['RGen_module'] as $result) {
				$m = 1; //[1] = MENU ITEMS
				$this->data['RGen_menu_item'][$this->data['language_id'][$i]['language_id']] = array(
					'RGen_menu_items'	=>	$result['Menu'][$m]['RGen_menu_items']
				);
				$sort_order = array();
				foreach ($this->data['RGen_menu_item'][$this->data['language_id'][$i]['language_id']]['RGen_menu_items'] as $key => $value) {
					$sort_order[$key] = $value['sort_order'];
				}
				array_multisort($sort_order, SORT_ASC, $this->data['RGen_menu_item'][$this->data['language_id'][$i]['language_id']]['RGen_menu_items']);
				$i++;
			}

			/* CUSTOM HTML MENU
			******************************/
			$i = 0;
			foreach ($this->data['RGen_module'] as $result) {
				$m = 2; //[2] = HTML MENU
				$this->data['RGen_HtmlMenu'][$this->data['language_id'][$i]['language_id']] = array(
					'name'		=>	$result['Menu'][$m]['name'],
					'htmldata'	=>	$result['Menu'][$m]['htmldata']
				);
				$i++;
			}

			/* CUSTOM HTML MENU MOD
			******************************/
			$i = 0;
			foreach ($this->data['RGen_module'] as $result) {
				$m = 3; //[3] = UNLIMITED HTML MENU MOD
				if(isset($result['Menu'][$m])){
					$this->data['RGen_HtmlMenuMod'][$this->data['language_id'][$i]['language_id']] = array(
						'RGen_HtmlMenuMod'	=>	$result['Menu'][$m]['htmMenu']
					);
					$sort_order = array();
					foreach ($this->data['RGen_HtmlMenuMod'][$this->data['language_id'][$i]['language_id']]['RGen_HtmlMenuMod'] as $key => $value) {
						$sort_order[$key] = $value['sort_order'];
					}
					array_multisort($sort_order, SORT_ASC, $this->data['RGen_HtmlMenuMod'][$this->data['language_id'][$i]['language_id']]['RGen_HtmlMenuMod']);
				}
				$i++;
			}

			/* CUSTOM FOOTER
			******************************/
			$i = 0;
			foreach ($this->data['RGen_module'] as $result) {
				$this->data['RGen_CustomFt'][$this->data['language_id'][$i]['language_id']] = array(
					'ftAbout_title'		=>	$result['ftAbout_title'],
					'ftAbout'	=>	$result['ftAbout']
				);
				$i++;
			}
			
			/* CUSTOM DROPDOWN MENU
			******************************/
			$i = 0;
			foreach ($this->data['RGen_module'] as $result) {
				$capArr = 'cap1_' . $this->data['language_id'][$i]['language_id'];
				if(isset($result[$capArr])){
					$this->data['caption1'][$this->data['language_id'][$i]['language_id']] = array(
						'captions'		=>	$result[$capArr]
					);	
				}
				$i++;
			}
		}
		
		if($this->data['RGenData_mod']){
			/* MENU SORT ORDER
			******************************/
			$i = 0;
			foreach ($this->data['RGenData_mod']['RGen_menu_sort'] as $result) {
	      		$this->data['RGen_Menu'][] = array(
					'sort_order' => $result['sort_order']
	      		);
		    	$i++;
		    }
			$this->data['RGen_Menu'][0]['RGen_catMenu'] 	= 'RGen_catMenu';
			$this->data['RGen_Menu'][1]['RGen_infoMenu'] 	= $this->data['informations'];
			$this->data['RGen_Menu'][2]['RGen_myAccount'] 	= 'RGen_myAccount';
			$this->data['RGen_Menu'][3]['ddMenu'] 			= $this->data['RGen_ddMenu'];
			$this->data['RGen_Menu'][4]['RGen_menu_item'] 	= $this->data['RGen_menu_item'];
			$this->data['RGen_Menu'][5]['RGen_HtmlMenu'] 	= $this->data['RGen_HtmlMenu'];
			
			$sort_order = array();
			foreach ($this->data['RGen_Menu'] as $key => $value) {
				$sort_order[$key] = $value['sort_order'];
			}
			array_multisort($sort_order, SORT_ASC, $this->data['RGen_Menu']);

			/* CUSTOM SOCIAL ICONS
			******************************/
			$i = 0;
			if(isset($this->data['RGenData_mod']['RGen_social'])){
				foreach ($this->data['RGenData_mod']['RGen_social'] as $result) {
					if(isset($result['status'])){ 
						$result['status'];
					} else { 
						$result['status'] = 0; 
					}
		      		$this->data['RGen_social'][] = array(
		        		'normal' => $result['normal'],
			    		'hover'  => $result['hover'],
						'url'  => $result['url'],
						'status'  => $result['status'],
						'sort_order' => $result['sort_order']
		      		);
					
		    	$i++; }
		    	$sort_order = array();
				foreach ($this->data['RGen_social'] as $key => $value) {
					$sort_order[$key] = $value['sort_order'];
				}
				array_multisort($sort_order, SORT_ASC, $this->data['RGen_social']);
				//echo "<pre style='color:#fff;'>" . print_r($this->data['RGen_social'], TRUE) . "</pre>";
			}
		}

		if(!$this->data['RGen_Menu']){
			$this->data['RGen_Menu'][0]['RGen_catMenu'] 	= 'RGen_catMenu';
			$this->data['RGen_Menu'][1]['RGen_infoMenu'] 	= $this->data['informations'];
			$this->data['RGen_Menu'][2]['RGen_myAccount'] 	= 'RGen_myAccount';
			$this->data['RGen_Menu'][3]['ddMenu'] 			= $this->data['RGen_ddMenu'];
			$this->data['RGen_Menu'][4]['RGen_menu_item'] 	= $this->data['RGen_menu_item'];
			$this->data['RGen_Menu'][5]['RGen_HtmlMenu'] 	= $this->data['RGen_HtmlMenu'];
		}

		$this->document->RGen_ddMenu		= $this->data['RGen_ddMenu'];
		$this->document->RGen_menu_item		= $this->data['RGen_menu_item'];
		$this->document->RGen_HtmlMenu		= $this->data['RGen_HtmlMenu'];
		$this->document->RGen_HtmlMenuMod	= $this->data['RGen_HtmlMenuMod'];
		$this->document->RGen_Menu 			= $this->data['RGen_Menu'];
		$this->document->RGen_CustomFt 		= $this->data['RGen_CustomFt'];
		$this->document->RGen_social 		= $this->data['RGen_social'];
		$this->document->caption1			= $this->data['caption1'];


		//echo "<pre style='color:#fff;'>" . print_r($this->document->caption1, TRUE) . "</pre>";
	}
}


?>