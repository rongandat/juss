<?php 
if (isset($setting['mod_id'])) {

	$l_id = $this->config->get('config_language_id');
	$mod_id = $setting['mod_id'];
	
	// Specific Category 
	if(isset($RGen_custom[$mod_id]['cat_status']) && $RGen_custom[$mod_id]['cat_status'] == "selc") { 
		if(isset($RGen_custom[$mod_id]['category']) && in_array($category_id, $RGen_custom[$mod_id]['category'])) {
		include "catalog/view/theme/rgen-opencart/template/common/rgen_custom.php";
		}

	// Specific Product 
	}elseif (isset($RGen_custom[$mod_id]['prd_status']) && $RGen_custom[$mod_id]['prd_status'] == "selp") {
		if(isset($RGen_custom[$mod_id]['prd']) && in_array($product_id, $RGen_custom[$mod_id]['prd'])) {
		include "catalog/view/theme/rgen-opencart/template/common/rgen_custom.php";
		}

	// Specific Brands
	}elseif (isset($RGen_custom[$mod_id]['brand_status']) && $RGen_custom[$mod_id]['brand_status'] == "selb") {
		if(isset($RGen_custom[$mod_id]['brand']) && in_array($brand_id, $RGen_custom[$mod_id]['brand'])) {
		include "catalog/view/theme/rgen-opencart/template/common/rgen_custom.php";
		}

	// Specific Information
	}elseif (isset($RGen_custom[$mod_id]['info_status']) && $RGen_custom[$mod_id]['info_status'] == "seli") {
		if(isset($RGen_custom[$mod_id]['info']) && in_array($information_id, $RGen_custom[$mod_id]['info'])) {
		include "catalog/view/theme/rgen-opencart/template/common/rgen_custom.php";
		}

	} else {
		include "catalog/view/theme/rgen-opencart/template/common/rgen_custom.php";
	}

} ?>
