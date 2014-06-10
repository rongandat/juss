<?php echo $header; ?>
<link rel="stylesheet" type="text/css" href="view/stylesheet/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="view/stylesheet/rgenadmin.css" />

<?php if(!$checkPermission){ ?>
<input type="hidden" id="permission" val="demo">
<?php } ?>

<div id="content" class="rgen-custom-html" style="opacity:0">
	<div class="breadcrumb">
		<?php foreach ($breadcrumbs as $breadcrumb) { ?>
		<?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
		<?php } ?>
	</div>
	<?php if ($error_warning) { ?>
	<div class="warning"><?php echo $error_warning; ?></div>
	<?php } ?>
	<div class="box" id="main-wrapper">
		<!-- MAIN TABS START -->
		<div class="navbar" id='main-tabs'>
			<div class="navbar-inner">
				<span class="brand">R.Gen Theme<b><?php echo $ver; ?></b></span>
				<ul class="nav">
					<li class="active"><a href="#customHtm">CUSTOM HTML</a></li>
				</ul>
				<div class="buttons pull-right">
					<a id="saveBtn" class="btn btn-success btn-large"><?php echo $button_save; ?></a><a onclick="location = '<?php echo $cancel; ?>';" class="btn btn-large">Back</a>
					<a onclick="image_upload('RGen_custom', 'RGen_custom');" class="btn btn-large">Upload image</a>
				</div>
			</div>
		</div>

		<!-- <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form" > -->
		<form id="form" enctype="multipart/form-data">
			<div class='tab-content main-panes'>
				<?php
				$positions = array(
							$text_content_top				=> 'content_top',
							$text_content_bottom			=> 'content_bottom',
							$text_column_left				=> 'column_left',
							$text_column_right				=> 'column_right',
							'Stick to right'				=> 's_right',
							'Stick to left'					=> 's_left',
							'Footer - Payment cards'		=> 'footer_cards',
							'Footer - Above social icons'	=> 'ft_social',
							'Footer - Below copyright'		=> 'ft_below',
							'Header - Top'					=> 'tp_above',
							'Product page - Above images'	=> 'pd_above_img',
							'Product page - Below images'	=> 'pd_below_img',
							'Product page - Above options'	=> 'pd_above_options',
							'Product page - Below options'	=> 'pd_below_options',
							'Product page - Above tabs'		=> 'pd_above_tb',
							'Product page - Above related'	=> 'pd_above_rel',
							'Product page - Extra tab'		=> 'pd_tb'
							);
				$status = array('Disabled' => 0, 'Enabled' => 1);
				?>
				<div id="customHtm" class="tab-pane active">
					<div class="tabs-left tabbable" data-theme="tab1">
						<a class='btn btn-success btn-large' id="module-add" onclick="addModule();"><i class="icon-plus icon-white"></i> <?php echo $button_add_module; ?></a>
						<ul id="tabs1" class="nav nav-tabs">
							<?php $module_row = 1; ?>
							<?php foreach ($modules as $module) { ?>
								<li class="tab-module-<?php echo $module_row; ?>">
									<a href="#tab-module-<?php echo $module_row; ?>" id="module-<?php echo $module_row; ?>">
										<?php if(isset($module['modName']) && $module['modName']) { ?>
										<b><?php echo $module['modName']; ?></b>
										<?php } else { ?>
										<b><?php echo $tab_module . ' ' . $module_row; ?></b>
										<?php } ?>
										<span class='btn btn-danger btn-mini' onclick="$('#tabs1 li:first a').trigger('click'); $('#module-<?php echo $module_row; ?>').parent().remove(); $('#tab-module-<?php echo $module_row; ?>').remove(); return false;">&times;</span>
									</a>
								</li>
							<?php $module_row++; ?>
							<?php } ?>
						</ul>
						<div class="tab-content customContentPanes">
							<?php $module_row = 1; ?>
							<?php 
							//echo "<pre style='color:;'>" . print_r($modules, TRUE) . "</pre>";
							foreach ($modules as $module) { 
								if(isset($module['status'])){ 
									$module['status'];
								} else { 
									$module['status'] = 0; 
								}
							?>
							<div id="tab-module-<?php echo $module_row; ?>" class="tab-pane lng-tab">

								<h4>Module settings</h4>
								<div class="form-horizontal">
									<div class="control-group">
										<label class="control-label">Module name</label>
										<div class="controls mod-name">
											<?php 
												$dbKey 	= isset($module['modName']) ? $module['modName'] : '';
												$name	= 'rgen_custom_module' . $module_row . '[modName]';
											?>
											<input type="text" placeholder="Module name" name="<?php echo $name; ?>" value="<?php echo $dbKey; ?>" />
											<input type="hidden" name="rgen_custom_module<?php echo $module_row; ?>[mod_id]" value="<?php echo 'rgen_custom_module' . $module_row; ?>" />
										</div>
									</div>
									<div class="control-group">
										<label class="control-label"><?php echo $entry_status; ?></label>
										<div class="controls">
											<?php 
												$ar 	= $status;
												$dbKey 	= isset($module['status']) ? $module['status'] : '0';
												$name	= 'rgen_custom_module' . $module_row . '[status]';
											?>
											<span class='select status-select'>
												<select name="<?php echo $name; ?>">
													<?php foreach ($ar as $key => $value) { ?>
														<?php ($value ==  $dbKey) ? $selected = 'selected' : $selected=''; ?>
														<option value="<?php echo $value; ?>" <?php echo $selected; ?>><?php echo $key; ?></option>
													<?php } ?>
												</select>
											</span>
											<input placeholder='Sort order' type="text" class='input-small' name="rgen_custom_module<?php echo $module_row; ?>[sort_order]" value="<?php echo $module['sort_order']; ?>" size="3" />
										</div>
									</div>
									<div class="control-group">
										<label class="control-label"><?php echo $entry_layout; ?></label>
										<div class="controls">
											<span class='select layout-select'>
												<select name="rgen_custom_module<?php echo $module_row; ?>[layout_id]">
													<?php foreach ($layouts as $layout) { ?>
													<?php 
														if (isset($layout['route'][0])) {
															$routeInfo = $layout['route'][0]['route'];
														}else{
															$routeInfo = '';
														}
													?>
													<?php if ($layout['layout_id'] == $module['layout_id']) { ?>
													<option value="<?php echo $layout['layout_id']; ?>" selected="selected" data-route="<?php echo $routeInfo; ?>"><?php echo $layout['name']; ?></option>
													<?php } else { ?>
													<option value="<?php echo $layout['layout_id']; ?>" data-route="<?php echo $routeInfo; ?>"><?php echo $layout['name']; ?></option>
													<?php } ?>
													<?php } ?>
												</select>
											</span>
										</div>
									</div>
									
									<!-- Category selection -->
									<div class="control-group cat-select-wrp" style="display:<?php if(isset($module['cat_status'])){ echo "block;"; }else{echo "none;";} ?>">
										<label class="control-label">Display content</label>
										<div class="controls cat-selection" id="rgen_custom_module<?php echo $module_row; ?>-cat-sel" data-array="rgen_custom_module<?php echo $module_row; ?>">
											
											<?php 
											$ar 	= array( 'On all categories' => 'allc', 'On selected category' => 'selc');
											$dbKey 	= isset($module['cat_status']) ? $module['cat_status'] : '';
											$name	= 'rgen_custom_module' . $module_row . '[cat_status]';
											$id		= 'rgen_custom_module[' . $module_row . '][cat_status]';
											?>
											<div class="btn-group" data-toggle="buttons-radio">
												<?php foreach ($ar as $key => $value) { ?>
													<?php ($value ==  $dbKey) ? $selected = ' active' : $selected=''; ?>
													<label for="<?php echo $id . '-' . $value; ?>"  type="button" class="btn<?php echo $selected; ?>">
														<input type="radio" id="<?php echo $id . '-' . $value; ?>" name="<?php echo $name; ?>" value="<?php echo $value; ?>" <?php if ($dbKey == $value) { ?>checked="checked"<?php }?>>
														<?php echo $key; ?>
													</label>
												<?php } ?>
											</div>

											<div class="selected-cat" id="rgen_custom_module<?php echo $module_row; ?>-cat" data-array="rgen_custom_module<?php echo $module_row; ?>" style="display:<?php if(isset($module['cat_status']) && $module['cat_status'] == "selc"){ echo "block"; }else{ echo ""; } ?>;">
												<input type="text" placeholder="Type category name to insert" class="find-cat" value="" /><br>
									            <div class="select_scrollbox scrollbox cat-sel">
													<?php 
													if (isset($rgen_catlist['rgen_custom_module' . $module_row])) {
													foreach ($rgen_catlist['rgen_custom_module' . $module_row] as $category) { ?>
													<div><?php echo $category['name']; ?>
														<img src="view/image/delete.png" alt="" />
														<input type="hidden" name="rgen_custom_module<?php echo $module_row; ?>[category][]" value="<?php echo $category['category_id']; ?>" />
													</div>
													<?php } } ?>
												</div>
											</div>
										</div>
									</div>

									<!-- Product selection -->
									<div class="control-group prd-select-wrp" style="display:<?php if(isset($module['prd_status'])){ echo "block;"; }else{echo "none;";} ?>">
										<label class="control-label">Display content</label>
										<div class="controls prd-selection" id="rgen_custom_module<?php echo $module_row; ?>-prd-sel" data-array="rgen_custom_module<?php echo $module_row; ?>">
											
											<?php 
											$ar 	= array( 'On all products' => 'allp', 'On selected product' => 'selp');
											$dbKey 	= isset($module['prd_status']) ? $module['prd_status'] : '';
											$name	= 'rgen_custom_module' . $module_row . '[prd_status]';
											$id		= 'rgen_custom_module[' . $module_row . '][prd_status]';
											?>
											<div class="btn-group" data-toggle="buttons-radio">
												<?php foreach ($ar as $key => $value) { ?>
													<?php ($value ==  $dbKey) ? $selected = ' active' : $selected=''; ?>
													<label for="<?php echo $id . '-' . $value; ?>"  type="button" class="btn<?php echo $selected; ?>">
														<input type="radio" id="<?php echo $id . '-' . $value; ?>" name="<?php echo $name; ?>" value="<?php echo $value; ?>" <?php if ($dbKey == $value) { ?>checked="checked"<?php }?>>
														<?php echo $key; ?>
													</label>
												<?php } ?>
											</div>

											<div class="selected-prd" id="rgen_custom_module<?php echo $module_row; ?>-prd" data-array="rgen_custom_module<?php echo $module_row; ?>" style="display:<?php if(isset($module['prd_status']) && $module['prd_status'] == "selp"){ echo "block"; }else{ echo ""; } ?>;">
												<input type="text" placeholder="Type product name to insert" class="find-prd" value="" /><br>
									            <div class="select_scrollbox scrollbox prd-sel">
													<?php 
													if (isset($rgen_prdlist['rgen_custom_module' . $module_row])) {
													foreach ($rgen_prdlist['rgen_custom_module' . $module_row] as $product) { ?>
													<div><?php echo $product['name']; ?>
														<img src="view/image/delete.png" alt="" />
														<input type="hidden" name="rgen_custom_module<?php echo $module_row; ?>[prd][]" value="<?php echo $product['product_id']; ?>" />
													</div>
													<?php } } ?>
												</div>
											</div>
										</div>
									</div>

									<!-- Brand selection -->
									<div class="control-group brand-select-wrp" style="display:<?php if(isset($module['brand_status'])){ echo "block;"; }else{echo "none;";} ?>">
										<label class="control-label">Display content</label>
										<div class="controls brand-selection" id="rgen_custom_module<?php echo $module_row; ?>-brand-sel" data-array="rgen_custom_module<?php echo $module_row; ?>">
											
											<?php 
											$ar 	= array( 'On all brands' => 'allb', 'On selected brand' => 'selb');
											$dbKey 	= isset($module['brand_status']) ? $module['brand_status'] : '';
											$name	= 'rgen_custom_module' . $module_row . '[brand_status]';
											$id		= 'rgen_custom_module[' . $module_row . '][brand_status]';
											?>
											<div class="btn-group" data-toggle="buttons-radio">
												<?php foreach ($ar as $key => $value) { ?>
													<?php ($value ==  $dbKey) ? $selected = ' active' : $selected=''; ?>
													<label for="<?php echo $id . '-' . $value; ?>"  type="button" class="btn<?php echo $selected; ?>">
														<input type="radio" id="<?php echo $id . '-' . $value; ?>" name="<?php echo $name; ?>" value="<?php echo $value; ?>" <?php if ($dbKey == $value) { ?>checked="checked"<?php }?>>
														<?php echo $key; ?>
													</label>
												<?php } ?>
											</div>

											<div class="selected-brand" id="rgen_custom_module<?php echo $module_row; ?>-brand" data-array="rgen_custom_module<?php echo $module_row; ?>" style="display:<?php if(isset($module['brand_status']) && $module['brand_status'] == "selb"){ echo "block"; }else{ echo ""; } ?>;">
												<input type="text" placeholder="Type manufacturer name to insert" class="find-brand" value="" /><br>
									            <div class="select_scrollbox scrollbox brand-sel">
													<?php 
													if (isset($rgen_brandlist['rgen_custom_module' . $module_row])) {
													foreach ($rgen_brandlist['rgen_custom_module' . $module_row] as $brand) { ?>
													<div><?php echo $brand['name']; ?>
														<img src="view/image/delete.png" alt="" />
														<input type="hidden" name="rgen_custom_module<?php echo $module_row; ?>[brand][]" value="<?php echo $brand['manufacturer_id']; ?>" />
													</div>
													<?php } } ?>
												</div>
											</div>
										</div>
									</div>

									<!-- Information selection -->
									<div class="control-group info-select-wrp" style="display:<?php if(isset($module['info_status'])){ echo "block;"; }else{echo "none;";} ?>">
									<!-- <div class="control-group info-select-wrp"> -->
										<label class="control-label">Display content</label>
										<div class="controls info-selection" id="rgen_custom_module<?php echo $module_row; ?>-info-sel" data-array="rgen_custom_module<?php echo $module_row; ?>">
											
											<?php 
											$ar 	= array( 'On all information pages' => 'alli', 'On selected information page' => 'seli');
											$dbKey 	= isset($module['info_status']) ? $module['info_status'] : '';
											$name	= 'rgen_custom_module' . $module_row . '[info_status]';
											$id		= 'rgen_custom_module[' . $module_row . '][info_status]';
											?>
											<div class="btn-group" data-toggle="buttons-radio">
												<?php foreach ($ar as $key => $value) { ?>
													<?php ($value ==  $dbKey) ? $selected = ' active' : $selected=''; ?>
													<label for="<?php echo $id . '-' . $value; ?>"  type="button" class="btn<?php echo $selected; ?>">
														<input type="radio" id="<?php echo $id . '-' . $value; ?>" name="<?php echo $name; ?>" value="<?php echo $value; ?>" <?php if ($dbKey == $value) { ?>checked="checked"<?php }?>>
														<?php echo $key; ?>
													</label>
												<?php } ?>
											</div>

											<div class="selected-info" id="rgen_custom_module<?php echo $module_row; ?>-info" data-array="rgen_custom_module<?php echo $module_row; ?>" style="display:<?php if(isset($module['info_status']) && $module['info_status'] == "seli"){ echo "block"; }else{ echo ""; } ?>;">
												<input type="text" placeholder="Type information page name to insert" class="find-info" value="" /><br>
									            <div class="select_scrollbox scrollbox info-sel">
													<?php 
													if (isset($rgen_infolist['rgen_custom_module' . $module_row])) {
													foreach ($rgen_infolist['rgen_custom_module' . $module_row] as $info) { ?>
													<div><?php echo $info['name']; ?>
														<img src="view/image/delete.png" alt="" />
														<input type="hidden" name="rgen_custom_module<?php echo $module_row; ?>[info][]" value="<?php echo $info['information_id']; ?>" />
													</div>
													<?php } } ?>
												</div>
											</div>
										</div>
									</div>

									<div class="control-group pos-select-wrp">
										<label class="control-label"><?php echo $entry_position; ?></label>
										<div class="controls">
											<?php 
												$ar 	= $positions;
												$dbKey 	= isset($module['position']) ? $module['position'] : 'content_top';
												$name	= 'rgen_custom_module' . $module_row . '[position]';
											?>
											<span class='select pos-select'>
												<select name="<?php echo $name; ?>">
													<?php foreach ($ar as $key => $value) { ?>
														<?php ($value ==  $dbKey) ? $selected = 'selected' : $selected=''; ?>
														<option value="<?php echo $value; ?>" <?php echo $selected; ?>><?php echo $key; ?></option>
													<?php } ?>
												</select>
											</span>
										</div>
									</div>
									<div class="control-group cust-options" id="<?php echo 'rgen_custom_module-' . $module_row . '-cusOptions'; ?>"<?php if($module['position'] == "s_right" || $module['position'] == "s_left"){ ?> style="display:block;"<?php } else { ?> style="display:none;"<?php } ?>>
										<label class="control-label">Custom content options</label>
										<div class="controls">
											<?php 
												$dbKey 	= isset($module['custWidth']) ? $module['custWidth'] : '';
												$name	= 'rgen_custom_module' . $module_row . '[custWidth]';
											?>
											<input type="text" placeholder="Width" class="input-small" name="<?php echo $name; ?>" value="<?php echo $dbKey; ?>" />
											<?php 
												$dbKey 	= isset($module['custTop']) ? $module['custTop'] : '';
												$name	= 'rgen_custom_module' . $module_row . '[custTop]';
											?>
											<input type="text" placeholder="Top position" class="input-small" name="<?php echo $name; ?>" value="<?php echo $dbKey; ?>" />
											<?php 
												$dbKey 	= isset($module['custColor']) ? $module['custColor'] : '';
												$name	= 'rgen_custom_module' . $module_row . '[custColor]';
											?>
											<input type="text" placeholder="Color" class="rgb input-small" name="<?php echo $name; ?>" value="<?php echo $dbKey; ?>" />
											<?php 
												$dbKey 	= isset($module['custImg']) ? $module['custImg'] : '';
												$name	= 'rgen_custom_module' . $module_row . '[custImg]';
											?>
											<span class="custImg-icon" id="<?php echo 'rgen_custom_module-' . $module_row . '-custImg-preview'; ?>" style="background-image: url(../image/<?php echo isset($module['custImg']) ? $module['custImg'] : '' ?>); background-color:<?php echo isset($module['custColor']) ? $module['custColor'] : '' ?>;"></span>
											<input type="hidden" id="<?php echo 'rgen_custom_module-' . $module_row . '-custImg'; ?>" name="<?php echo $name; ?>" value="<?php echo $dbKey; ?>" />
											<a onclick="image_upload('<?php echo 'rgen_custom_module-' . $module_row . '-custImg'; ?>', '<?php echo 'rgen_custom_module-' . $module_row . '-custImg-preview'; ?>');" class="btn btn-small">Set image</a>
										</div>
									</div>
									<div class="control-group">
										<label class="control-label">Content styles</label>
										<div class="controls">
											<?php 
											$ar 	= array( 'Boxed' => 'cust1', 'With out box' => 'cust2', 'Free style' => 'cust3');
											$dbKey 	= isset($module['style']) ? $module['style'] : 'cust2';
											$name	= 'rgen_custom_module' . $module_row . '[style]';
											$id		= 'rgen_custom_module[' . $module_row . '][style]';
											?>
											<div class="btn-group" data-toggle="buttons-radio">
												<?php foreach ($ar as $key => $value) { ?>
													<?php ($value ==  $dbKey) ? $selected = ' active' : $selected=''; ?>
													<label for="<?php echo $id . '-' . $value; ?>"  type="button" class="btn<?php echo $selected; ?>">
														<input type="radio" id="<?php echo $id . '-' . $value; ?>" name="<?php echo $name; ?>" value="<?php echo $value; ?>" <?php if ($dbKey == $value) { ?>checked="checked"<?php }?>>
														<?php echo $key; ?>
													</label>
												<?php } ?>
											</div>
											<span class="help-block">
												Style options only work with "<strong>Content top</strong>", "<strong>Content bottom</strong>", "<strong>Column left</strong>" and "<strong>Column right</strong>" positions
											</span>
										</div>
									</div>

									<div class="control-group">
										<label class="control-label"><?php echo $entry_class; ?></label>
										<div class="controls">
											<?php 
												$dbKey 	= isset($module['class']) ? $module['class'] : '';
												$name	= 'rgen_custom_module' . $module_row . '[class]';
												$id  	= 'rgen_custom_module[' . $module_row . '][class]';
											?>
											<input type="text" id="<?php echo $id; ?>" name="<?php echo $name; ?>" value="<?php echo $dbKey; ?>" />
											<span class="help-block">
												<strong>Tips:</strong><br>
												1) Use multiple class name with space example: " <strong>class1 class2</strong> "<br>
												2) Use class name "<strong>d-close</strong>" to display content default close for below footer section custom block and above header section custom block<br>
											</span>
										</div>
									</div>
								</div>

								<h4>Module content</h4>
								<div class="form-horizontal" id="language-<?php echo $module_row; ?>">
							        <ul class="nav nav-tabs">
										<?php foreach ($languages as $language) { ?>
										<li>
											<a href="#tab-language-<?php echo $module_row; ?>-<?php echo $language['language_id']; ?>">
											<img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?>
											</a>
										</li>
										<?php } ?>
									</ul>
									<div class="tab-content">
										<?php foreach ($languages as $language) { ?>
										<div class="tab-pane" id="tab-language-<?php echo $module_row; ?>-<?php echo $language['language_id']; ?>">
											<div class="control-group">
												<label class="control-label"><?php echo $entry_title; ?></label>
												<div class="controls menu-sort">
													<?php 
														$dbKey 	= isset($module['title'][$language['language_id']]) ? $module['title'][$language['language_id']] : '';
														$name	= 'rgen_custom_module' . $module_row . '[title][' . $language['language_id'] . ']';
														$id  	= 'rgen_custom_module[' . $module_row . '][title][' . $language['language_id'] . ']';
													?>
													<input type="text" id="<?php echo $id; ?>" name="<?php echo $name; ?>" value="<?php echo $dbKey; ?>" />
												</div>
											</div>

											<div class="control-group">
												<label class="control-label"><?php echo $entry_description; ?></label>
												<div class="controls">
													<textarea name="rgen_custom_module<?php echo $module_row; ?>[description][<?php echo $language['language_id']; ?>]" id="description-<?php echo $module_row; ?>-<?php echo $language['language_id']; ?>"><?php echo isset($module['description'][$language['language_id']]) ? $module['description'][$language['language_id']] : ''; ?></textarea>
												</div>		
											</div>
										</div>
										<?php } ?>
									</div>
								</div>

								<script type="text/javascript">
									$("#tab-module-<?php echo $module_row; ?> .nav-tabs a").click(function (e) {
										e.preventDefault();
										$(this).tab("show");
									});
									$("#tab-module-<?php echo $module_row; ?> .nav-tabs > li:first").addClass("active");
									$("#tab-module-<?php echo $module_row; ?> .tab-content .tab-pane:first").addClass("active");
								</script>
							</div>
							<?php $module_row++; ?>
							<?php } ?>
						</div>
					</div>
				</div>
			</div>
		</form>
		
	</div>
</div>

<script src="view/javascript/rgen/bootstrap.min.js"></script>
<script src="view/javascript/rgen/rgenadmin.js"></script>
<script type="text/javascript" src="view/javascript/ckeditor/ckeditor.js"></script> 
<script type="text/javascript"><!--
//$('#content').css({opacity:0});
$('body').prepend('<div class="loading">Loading...</div>');
$(document).ready(function(){
	//$('#content').css({display:'block'});
	$('.loading').css({display:"none"});
	$('#content').animate({opacity: 1}, 300, function(){});
});
<?php $module_row = 1; ?>
<?php foreach ($modules as $module) { ?>
<?php foreach ($languages as $language) { ?>
CKEDITOR.replace('description-<?php echo $module_row; ?>-<?php echo $language['language_id']; ?>', {
	filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	height: '600px'
});
<?php } ?>
<?php $module_row++; ?>
<?php } ?>
//--></script> 
<script type="text/javascript"><!--

function custOptions(){
	$(".active").find(".pos-select select").change(function(){
		var pos = $(this).find('option:selected').val();
		if(pos == 's_right' || pos == 's_left' ){
			$(".lng-tab.active").find(".cust-options").css({display:'block'});
		}else{
			$(".lng-tab.active").find(".cust-options").css({display:'none'});
		}
	});

	$('.rgb').each(function(index, element) {
		$(this).colorpicker({
			hsv:false,
			alpha:true,
			colorFormat: ['RGBA'],
			showNoneButton:true,
			select: function(event, color) {
						$(this).val(color.formatted);
						$(this).next().css({backgroundColor: color.formatted});
					}
		});
		
		$(this).click(function(){
			$('.ui-colorpicker').css({top:$(this).offset().top + 25});
		});
	});
}
custOptions();

function layoutSelect(){
	$(".layout-select select").change(function(){
		var vl = $(this).val();
		var nxtObj = $(this).parent().parent().parent().parent().find(".pos-select");
		var custOptions = $(this).parent().parent().parent().parent().find(".cust-options");
		if(vl == 99999){
			nxtObj.find("option::nth-child(-n+4)").css({display:"none"});
			nxtObj.find("option::nth-child(5)").attr("selected", "selected");
			if(nxtObj.find("select").val() == 's_right' || nxtObj.find("select").val() == 's_left') {
				custOptions.css({display:'block'});
			}else{
				custOptions.css({display:'none'});
			}
		} else {
			nxtObj.find("option::nth-child(-n+4)").css({display:"block"});
			nxtObj.find("option::nth-child(1)").attr("selected", "selected");
			custOptions.css({display:'none'});
		}
		
		// Category
		var route = $(this).find(this + "[selected='selected']").attr('data-route');
		if (route == 'product/category') {
			$(this).parent().parent().parent().parent().find(".cat-select-wrp").css({display:'block'});
			$(this).parent().parent().parent().parent().find(".cat-select-wrp .btn-group input:radio").first().attr("checked", true);
			$(this).parent().parent().parent().parent().find(".cat-select-wrp .btn-group label").first().addClass("active");
		}else{
			$(this).parent().parent().parent().parent().find(".cat-select-wrp").css({display:'none'});
			$(this).parent().parent().parent().parent().find(".cat-select-wrp .btn-group input:radio").attr("checked", false);
			$(this).parent().parent().parent().parent().find(".cat-select-wrp .selected-cat > input:text").val('');
			$(this).parent().parent().parent().parent().find(".cat-select-wrp .btn-group label").removeClass("active");
			$(this).parent().parent().parent().parent().find(".cat-select-wrp .selected-cat").css({display:'none'});
			$(this).parent().parent().parent().parent().find(".cat-select-wrp .selected-cat .scrollbox div").remove();
		}

		// Product
		var route = $(this).find(this + "[selected='selected']").attr('data-route');
		if (route == 'product/product') {
			$(this).parent().parent().parent().parent().find(".prd-select-wrp").css({display:'block'});
			$(this).parent().parent().parent().parent().find(".prd-select-wrp .btn-group input:radio").first().attr("checked", true);
			$(this).parent().parent().parent().parent().find(".prd-select-wrp .btn-group label").first().addClass("active");
		}else{
			$(this).parent().parent().parent().parent().find(".prd-select-wrp").css({display:'none'});
			$(this).parent().parent().parent().parent().find(".prd-select-wrp .btn-group input:radio").attr("checked", false);
			$(this).parent().parent().parent().parent().find(".prd-select-wrp .selected-prd > input:text").val('');
			$(this).parent().parent().parent().parent().find(".prd-select-wrp .btn-group label").removeClass("active");
			$(this).parent().parent().parent().parent().find(".prd-select-wrp .selected-prd").css({display:'none'});
			$(this).parent().parent().parent().parent().find(".prd-select-wrp .selected-prd .scrollbox div").remove();
		}

		// Brands
		var route = $(this).find(this + "[selected='selected']").attr('data-route');
		if (route == 'product/manufacturer') {
			$(this).parent().parent().parent().parent().find(".brand-select-wrp").css({display:'block'});
			$(this).parent().parent().parent().parent().find(".brand-select-wrp .btn-group input:radio").first().attr("checked", true);
			$(this).parent().parent().parent().parent().find(".brand-select-wrp .btn-group label").first().addClass("active");
		}else{
			$(this).parent().parent().parent().parent().find(".brand-select-wrp").css({display:'none'});
			$(this).parent().parent().parent().parent().find(".brand-select-wrp .btn-group input:radio").attr("checked", false);
			$(this).parent().parent().parent().parent().find(".brand-select-wrp .selected-brand > input:text").val('');
			$(this).parent().parent().parent().parent().find(".brand-select-wrp .btn-group label").removeClass("active");
			$(this).parent().parent().parent().parent().find(".brand-select-wrp .selected-brand").css({display:'none'});
			$(this).parent().parent().parent().parent().find(".brand-select-wrp .selected-brand .scrollbox div").remove();
		}

		// Information
		var route = $(this).find(this + "[selected='selected']").attr('data-route');
		if (route == 'information/information') {
			$(this).parent().parent().parent().parent().find(".info-select-wrp").css({display:'block'});
			$(this).parent().parent().parent().parent().find(".info-select-wrp .btn-group input:radio").first().attr("checked", true);
			$(this).parent().parent().parent().parent().find(".info-select-wrp .btn-group label").first().addClass("active");
		}else{
			$(this).parent().parent().parent().parent().find(".info-select-wrp").css({display:'none'});
			$(this).parent().parent().parent().parent().find(".info-select-wrp .btn-group input:radio").attr("checked", false);
			$(this).parent().parent().parent().parent().find(".info-select-wrp .selected-info > input:text").val('');
			$(this).parent().parent().parent().parent().find(".info-select-wrp .btn-group label").removeClass("active");
			$(this).parent().parent().parent().parent().find(".info-select-wrp .selected-info").css({display:'none'});
			$(this).parent().parent().parent().parent().find(".info-select-wrp .selected-info .scrollbox div").remove();
		}
		

	});

	// Category
	$(".cat-selection .btn-group input").click(function(){
		if($(this).val() == 'selc'){
			$(this).parent().parent().parent().find('.selected-cat').css({display:'block'});
		}else{
			$(this).parent().parent().parent().find('.selected-cat').css({display:''});
			$(this).parent().parent().parent().find('.selected-cat .scrollbox div').remove();
		}
	});

	// Product
	$(".prd-selection .btn-group input").click(function(){
		if($(this).val() == 'selp'){
			$(this).parent().parent().parent().find('.selected-prd').css({display:'block'});
		}else{
			$(this).parent().parent().parent().find('.selected-prd').css({display:''});
			$(this).parent().parent().parent().find('.selected-prd .scrollbox div').remove();
		}
	});

	// Brands
	$(".brand-selection .btn-group input").click(function(){
		if($(this).val() == 'selb'){
			$(this).parent().parent().parent().find('.selected-brand').css({display:'block'});
		}else{
			$(this).parent().parent().parent().find('.selected-brand').css({display:''});
			$(this).parent().parent().parent().find('.selected-brand .scrollbox div').remove();
		}
	});

	// Information
	$(".info-selection .btn-group input").click(function(){
		if($(this).val() == 'seli'){
			$(this).parent().parent().parent().find('.selected-info').css({display:'block'});
		}else{
			$(this).parent().parent().parent().find('.selected-info').css({display:''});
			$(this).parent().parent().parent().find('.selected-info .scrollbox div').remove();
		}
	});

}
layoutSelect();

//var module_row = <?php echo $module_row; ?>;
function addModule() {	
	
	var module_row = parseInt($('.customContentPanes .lng-tab').length + 1);

	html  = '<div id="tab-module-' + module_row + '" class="tab-pane lng-tab">';
	html += '	<h4>Module settings</h4>';
	html += '	<div class="form-horizontal">';

	html += '		<div class="control-group">';
	html += '			<label class="control-label">Module name</label>';
	html += '			<div class="controls mod-name">';
	html += '				<input type="text" placeholder="Module name" name="rgen_custom_module' + module_row + '[modName]" value="" />';
	html += '				<input type="hidden" name="rgen_custom_module' + module_row + '[mod_id]" value="rgen_custom_module' + module_row + '"/>';
	html += '			</div>';
	html += '		</div>';

	html += '		<div class="control-group">';
	html += '			<label class="control-label"><?php echo $entry_status; ?></label>';
	html += '			<div class="controls">';
	html += '				<span class="select status-select"><select name="rgen_custom_module' + module_row + '[status]">';
	<?php foreach ($status as $key => $value) { ?>
	html += '           		<option value="<?php echo $value; ?>"><?php echo $key; ?></option>';
	<?php } ?>
	html += '				</select></span>';

	html += '				<input type="text" placeholder="Sort order" class="input-small" name="rgen_custom_module' + module_row + '[sort_order]" value="" size="3" />';
	html += '			</div>';
	html += '		</div>';

	html += '		<div class="control-group">';
	html += '			<label class="control-label"><?php echo $entry_layout; ?></label>';
	html += '			<div class="controls">';
	html += '				<span class="select layout-select"><select name="rgen_custom_module' + module_row + '[layout_id]">';
	<?php foreach ($layouts as $layout) { ?>
	<?php if (isset($layout['route'][0])) { $routeInfo = $layout['route'][0]['route']; }else{ $routeInfo = ''; } ?>
	html += '           		<option value="<?php echo $layout['layout_id']; ?>" data-route="<?php echo $routeInfo; ?>"><?php echo addslashes($layout['name']); ?></option>';
	<?php } ?>
	html += '				</select></span>';
	html += '			</div>';
	html += '		</div>';

	// Category
	html += '		<div class="control-group cat-select-wrp" style="display: none"><label class="control-label">Display content</label>';
	html += '			<div class="controls cat-selection" id="rgen_custom_module' + module_row + '-cat-sel" data-array="rgen_custom_module' + module_row + '">';
	html += '				<div class="btn-group" data-toggle="buttons-radio">';
	html += '				<label for="rgen_custom_module[' + module_row + '][cat_status]-allc"  type="button" class="btn"><input type="radio" id="rgen_custom_module[' + module_row + '][cat_status]-allc" name="rgen_custom_module' + module_row + '[cat_status]" value="allc">On all categories</label>';
	html += '				<label for="rgen_custom_module[' + module_row + '][cat_status]-selc"  type="button" class="btn"><input type="radio" id="rgen_custom_module[' + module_row + '][cat_status]-selc" name="rgen_custom_module' + module_row + '[cat_status]" value="selc">On selected category</label>';
	html += '				</div>';
	html += '				<div class="selected-cat" id="rgen_custom_module' + module_row + '-cat" data-array="rgen_custom_module' + module_row + '"><input type="text" placeholder="Type category name to insert" class="find-cat" value="" /><br>';
	html += '				<div class="select_scrollbox scrollbox cat-sel">';
	html += '				</div></div>';
	html += '			</div>';
	html += '		</div>';

	// Product
	html += '		<div class="control-group prd-select-wrp" style="display: none"><label class="control-label">Display content</label>';
	html += '			<div class="controls prd-selection" id="rgen_custom_module' + module_row + '-prd-sel" data-array="rgen_custom_module' + module_row + '">';
	html += '				<div class="btn-group" data-toggle="buttons-radio">';
	html += '				<label for="rgen_custom_module[' + module_row + '][prd_status]-allp"  type="button" class="btn"><input type="radio" id="rgen_custom_module[' + module_row + '][prd_status]-allp" name="rgen_custom_module' + module_row + '[prd_status]" value="allp">On all products</label>';
	html += '				<label for="rgen_custom_module[' + module_row + '][prd_status]-selp"  type="button" class="btn"><input type="radio" id="rgen_custom_module[' + module_row + '][prd_status]-selp" name="rgen_custom_module' + module_row + '[prd_status]" value="selp">On selected product</label>';
	html += '				</div>';
	html += '				<div class="selected-prd" id="rgen_custom_module' + module_row + '-prd" data-array="rgen_custom_module' + module_row + '"><input type="text" placeholder="Type product name to insert" class="find-prd" value="" /><br>';
	html += '				<div class="select_scrollbox scrollbox prd-sel">';
	html += '				</div></div>';
	html += '			</div>';
	html += '		</div>';

	// Brands
	html += '		<div class="control-group brand-select-wrp" style="display: none"><label class="control-label">Display content</label>';
	html += '			<div class="controls brand-selection" id="rgen_custom_module' + module_row + '-brand-sel" data-array="rgen_custom_module' + module_row + '">';
	html += '				<div class="btn-group" data-toggle="buttons-radio">';
	html += '				<label for="rgen_custom_module[' + module_row + '][brand_status]-allb"  type="button" class="btn"><input type="radio" id="rgen_custom_module[' + module_row + '][brand_status]-allb" name="rgen_custom_module' + module_row + '[brand_status]" value="allb">On all brands</label>';
	html += '				<label for="rgen_custom_module[' + module_row + '][brand_status]-selb"  type="button" class="btn"><input type="radio" id="rgen_custom_module[' + module_row + '][brand_status]-selb" name="rgen_custom_module' + module_row + '[brand_status]" value="selb">On selected brand</label>';
	html += '				</div>';
	html += '				<div class="selected-brand" id="rgen_custom_module' + module_row + '-brand" data-array="rgen_custom_module' + module_row + '"><input type="text" placeholder="Type product name to insert" class="find-brand" value="" /><br>';
	html += '				<div class="select_scrollbox scrollbox brand-sel">';
	html += '				</div></div>';
	html += '			</div>';
	html += '		</div>';

	// Information
	html += '		<div class="control-group info-select-wrp" style="display: none"><label class="control-label">Display content</label>';
	html += '			<div class="controls info-selection" id="rgen_custom_module' + module_row + '-info-sel" data-array="rgen_custom_module' + module_row + '">';
	html += '				<div class="btn-group" data-toggle="buttons-radio">';
	html += '				<label for="rgen_custom_module[' + module_row + '][info_status]-alli"  type="button" class="btn"><input type="radio" id="rgen_custom_module[' + module_row + '][info_status]-alli" name="rgen_custom_module' + module_row + '[info_status]" value="alli">On all information pages</label>';
	html += '				<label for="rgen_custom_module[' + module_row + '][info_status]-seli"  type="button" class="btn"><input type="radio" id="rgen_custom_module[' + module_row + '][info_status]-seli" name="rgen_custom_module' + module_row + '[info_status]" value="seli">On selected information page</label>';
	html += '				</div>';
	html += '				<div class="selected-info" id="rgen_custom_module' + module_row + '-info" data-array="rgen_custom_module' + module_row + '"><input type="text" placeholder="Type product name to insert" class="find-info" value="" /><br>';
	html += '				<div class="select_scrollbox scrollbox info-sel">';
	html += '				</div></div>';
	html += '			</div>';
	html += '		</div>';


	html += '		<div class="control-group pos-select-wrp">';
	html += '			<label class="control-label"><?php echo $entry_position; ?></label>';
	html += '			<div class="controls">';
	html += '				<span class="select pos-select"><select name="rgen_custom_module' + module_row + '[position]">';
	<?php foreach ($positions as $key => $value) { ?>
	html += '					<option value="<?php echo $value; ?>"><?php echo $key; ?></option>';
	<?php } ?>
	html += '				</select></span>';
	html += '			</div>';
	html += '		</div>';

	html += '		<div class="control-group cust-options" id="rgen_custom_module-' + module_row + '-cusOptions" style="display:none;">';
	html += '			<label class="control-label">Custom content options</label>';
	html += '			<div class="controls">';
	html += '				<input type="text" placeholder="Width" class="input-small" name="rgen_custom_module' + module_row + '[custWidth]" value="" />';
	html += '				<input type="text" placeholder="Top position" class="input-small" name="rgen_custom_module' + module_row + '[custTop]" value="" />';
	html += '				<input type="text" placeholder="Color" class="rgb input-small" name="rgen_custom_module' + module_row + '[custColor]" value="" />';
	html += '				<span class="custImg-icon" id="rgen_custom_module-' + module_row + '-custImg-preview"></span>';
	html += '				<input type="hidden" id="rgen_custom_module-' + module_row + '-custImg" name="rgen_custom_module' + module_row + '[custImg]" value="" />';
	html += '				<a onclick="image_upload(\'rgen_custom_module-' + module_row + '-custImg\', \'rgen_custom_module-' + module_row + '-custImg-preview\');" class="btn btn-small">Set image</a>';
	html += '			</div>';
	html += '		</div>';

	html += '		<div class="control-group">';
	html += '			<label class="control-label">Content styles</label>';
	html += '			<div class="controls">';
	html += '				<div class="btn-group" data-toggle="buttons-radio">';
	html += '				<label for="rgen_custom_module' + module_row + '[style]-cust1" type="button" class="btn">';
	html += '				<input type="radio" id="rgen_custom_module[' + module_row + '][style]-cust1" name="rgen_custom_module' + module_row + '[style]" value="cust1">Boxed';
	html += '				</label>';
	html += '				<label for="rgen_custom_module' + module_row + '[style]-cust2" type="button" class="btn active">';
	html += '				<input type="radio" id="rgen_custom_module[' + module_row + '][style]-cust2" name="rgen_custom_module' + module_row + '[style]" checked="checked" value="cust2">With out box';
	html += '				</label>';
	html += '				<label for="rgen_custom_module' + module_row + '[style]-cust3" type="button" class="btn">';
	html += '				<input type="radio" id="rgen_custom_module[' + module_row + '][style]-cust3" name="rgen_custom_module' + module_row + '[style]" value="cust3">Free style';
	html += '				</label>';
	html += '				</div>';
	html += '				<span class="help-block">Style options only work with "<strong>Content top</strong>", "<strong>Content bottom</strong>", "<strong>Column left</strong>" and "<strong>Column right</strong>" positions</span>';
	html += '			</div>';
	html += '		</div>';

	html += '		<div class="control-group">';
	html += '			<label class="control-label"><?php echo $entry_class; ?></label>';
	html += '			<div class="controls">';
	html += '				<input type="text" name="rgen_custom_module' + module_row + '[class]" value="" />';
	html += '				<span class="help-block"><strong>Tips:</strong><br> 1) Use multiple class name with space example: " <strong>class1 class2</strong> "<br> 2) Use class name "<strong>d-close</strong>" to display content default close for below footer section custom block and above header section custom block<br> </span>';
	html += '			</div>';
	html += '		</div>';

	html += '	</div>';


	html += '	<h4>Module content</h4>';
	html += '	<div class="form-horizontal" id="language-' + module_row + '">';
	html += '		<ul class="nav nav-tabs">';
	<?php foreach ($languages as $language) { ?>
	html += '    		<li><a href="#tab-language-'+ module_row + '-<?php echo $language['language_id']; ?>"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>';
	<?php } ?>
	html += '		</ul>';
	html += '		<div class="tab-content">';
	<?php foreach ($languages as $language) { ?>
	html += '			<div class="tab-pane" id="tab-language-'+ module_row + '-<?php echo $language['language_id']; ?>">';
	
	html += '				<div class="control-group">';
	html += '					<label class="control-label"><?php echo $entry_title; ?></label>';
	html += '					<div class="controls">';
	html += '						<input type="text" name="rgen_custom_module' + module_row + '[title][<?php echo $language['language_id']; ?>]" value="" />';
	html += '					</div>';
	html += '				</div>';

	html += '				<div class="control-group">';
	html += '        			<label class="control-label"><?php echo $entry_description; ?></label>';
	html += '					<div class="controls">';
	html += '          				<textarea name="rgen_custom_module' + module_row + '[description][<?php echo $language['language_id']; ?>]" id="description-' + module_row + '-<?php echo $language['language_id']; ?>"></textarea>';
	html += '					</div>';
	html += '				</div>';
	html += '			</div>';
	<?php } ?>
	html += '		</div>';
	html += '		<script type="text/javascript">';
	html += '		$("#tab-module-' + module_row + ' .nav-tabs a").click(function (e) { e.preventDefault();$(this).tab("show"); });';
	html += '		$("#tab-module-' + module_row + ' .nav-tabs > li:first").addClass("active");';
	html += '		$("#tab-module-' + module_row + ' .tab-content .tab-pane:first").addClass("active");';
	html += '		</script>';
	html += '	</div>';
	html += '</div>';
	
	$('.customContentPanes').append(html);
	
	<?php foreach ($languages as $language) { ?>
	CKEDITOR.replace('description-' + module_row + '-<?php echo $language['language_id']; ?>', {
		filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		height: '600px'
	});  
	<?php } ?>
	
	//$('#language-' + module_row + ' a').tabs();
	$('#tabs1').append('<li><a href="#tab-module-' + module_row + '" id="module-' + module_row + '"><b><?php echo $tab_module; ?> ' + module_row + '</b><span class="btn btn-danger btn-mini" onclick="$(\'#tabs1 li:first a\').trigger(\'click\'); $(\'#module-' + module_row + '\').parent().remove(); $(\'#tab-module-' + module_row + '\').remove(); return false;">&times;</span></a></li>');
	
	//$('.vtabs a').tabs();
	$('#tabs1 a').click(function (e) {
		e.preventDefault();
		$(this).tab('show');
	});

	custOptions();
	layoutSelect();
	// Category
	catAutocomplete();
	// Products
	prdAutocomplete();
	// Brands
	brandAutocomplete();
	// Information
	infoAutocomplete();
	
	$('#module-' + module_row).trigger('click');
	
	module_row++;
}
//--></script> 

<script type="text/javascript"><!--
$("#saveBtn").click(function(){
	$('body').prepend('<div class="saving"><span>Please wait...<span></div>');
	$(".saving").css({height: $("html").height()});
	if (typeof CKEDITOR != 'undefined'){ for(instance in CKEDITOR.instances){ CKEDITOR.instances[instance].updateElement(); } }
	$.ajax({
		type: "POST",
		url: "index.php?route=module/rgen_custom&token=<?php echo $token; ?>",
		data: $('#form input[type=\'text\'], #form input[type=\'checkbox\']:checked, #form input[type=\'radio\']:checked, #form input[type=\'hidden\'], #form select, #form textarea').serializeArray(),
		dataType: "html",
		success: function() {
			//console.log($('#form textarea').val());
			if($("body").find("#permission").length>0){
				$('.saving').addClass('error-msg').find("span").text("<?php echo $this->language->get('error_permission'); ?>").css({backgroundImage:""});
				$('.saving').animate({opacity:1}, 2000, function(){
					$('.saving').animate({opacity:0}, 300, function(){$('.saving').css({display:"none"}); $(".saving").remove();});
				});	
			}else{
				$('.saving').addClass('success-msg').find("span").text("<?php echo $this->language->get('text_success'); ?>").css({backgroundImage:""});
				$('.saving').animate({opacity:1}, 1000, function(){
					$('.saving').animate({opacity:0}, 300, function(){
						$('.saving').css({display:"none"}); $(".saving").remove();
					});
				});
			}
		}
	});
});


function image_upload(field, previewImg) {
	$('#dialog').remove();
	$('#content').prepend('<div id="dialog" style="padding: 3px 0px 0px 0px;"><iframe src="index.php?route=common/filemanager&token=<?php echo $token; ?>&field=' + encodeURIComponent(field) + '" style="padding:0; margin: 0; display: block; width: 100%; height: 100%;" frameborder="no" scrolling="auto"></iframe></div>');
	$('#dialog').dialog({
		title: 'Image manager<br><div class="path">Uploaded image path to use in content => image/data/ Folder name if created / image name without space </div>',
		close: function (event, ui) {
			if ($('#' + field).attr('value')) {
				$.ajax({
					url: 'index.php?route=common/filemanager/image&token=<?php echo $token; ?>&image=' + encodeURIComponent($('#' + field).attr('value')),
					dataType: 'text',
					success: function(data) {
						//$('#' + previewImg).replaceWith('<img src="' + data + '" alt="" class="PreviewImage" id="' + previewImg + '" />');
						$('#' + previewImg).css({backgroundImage: 'url(' + data + ')'});
					}
				});
			}
		},	
		bgiframe: false,
		width: 800,
		height: 400,
		resizable: false,
		modal: false
	});
};


// Category
function catAutocomplete() {
$('.find-cat').autocomplete({
	delay: 100,
	source: function(request, response) {
		$.ajax({
			url: 'index.php?route=catalog/category/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request.term),
			dataType: 'json',
			success: function(json) {		
				response($.map(json, function(item) {
					return {
						label: item.name,
						value: item.category_id
					}
				}));
			}
		});
	}, 
	select: function(event, ui) {
		var catBox = '#' + $(this).parent().attr('id') + ' .scrollbox';
		var arrName = $(this).parent().attr('data-array');
		$(catBox + ui.item.value).remove();
		$(catBox).append('<div>' + ui.item.label + '<img src="view/image/delete.png" alt="" /><input type="hidden" name="' +arrName + '[category][]" value="' + ui.item.value + '" /></div>');
		return false;
	},
	focus: function(event, ui) {
      return false;
   }
});

$('.cat-sel div img').live('click', function() {
	$(this).parent().remove();
});
}
catAutocomplete();


function prdAutocomplete() {
	$('.find-prd').autocomplete({
		delay: 100,
		source: function(request, response) {
			$.ajax({
				url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request.term),
				dataType: 'json',
				success: function(json) {		
					response($.map(json, function(item) {
						return {
							label: item.name,
							value: item.product_id
						}
					}));
				}
			});
		}, 
		select: function(event, ui) {
			var prdBox = '#' + $(this).parent().attr('id') + ' .scrollbox';
			var arrName = $(this).parent().attr('data-array');
			$(prdBox + ui.item.value).remove();
			$(prdBox).append('<div>' + ui.item.label + '<img src="view/image/delete.png" alt="" /><input type="hidden" name="' +arrName + '[prd][]" value="' + ui.item.value + '" /></div>');
			return false;
		},
		focus: function(event, ui) {
			return false;
		}
	});
	$('.prd-sel div img').live('click', function() {
		$(this).parent().remove();
	});
}
prdAutocomplete();

// Manufacturer
function brandAutocomplete() {
	$('.find-brand').autocomplete({
		delay: 100,
		source: function(request, response) {
			$.ajax({
				url: 'index.php?route=catalog/manufacturer/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request.term),
				dataType: 'json',
				success: function(json) {		
					response($.map(json, function(item) {
						return {
							label: item.name,
							value: item.manufacturer_id
						}
					}));
				}
			});
		}, 
		select: function(event, ui) {

			var brdBox = '#' + $(this).parent().attr('id') + ' .scrollbox';
			var arrName = $(this).parent().attr('data-array');
			$(brdBox + ui.item.value).remove();
			$(brdBox).append('<div>' + ui.item.label + '<img src="view/image/delete.png" alt="" /><input type="hidden" name="' +arrName + '[brand][]" value="' + ui.item.value + '" /></div>');

			/*$('input[name=\'manufacturer\']').attr('value', ui.item.label);
			$('input[name=\'manufacturer_id\']').attr('value', ui.item.value);*/
		
			return false;
		},
		focus: function(event, ui) {
	      return false;
	   }
	});
	$('.brand-sel div img').live('click', function() {
		$(this).parent().remove();
	});
}
brandAutocomplete();

// Information
function infoAutocomplete() {
	$('.find-info').autocomplete({
		delay: 100,
		source: function(request, response) {
			$.ajax({
				url: 'index.php?route=catalog/information/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request.term),
				dataType: 'json',
				success: function(json) {	
					response($.map(json, function(item) {
						return {
							label: item.name,
							value: item.information_id
						}
					}));
				}   
			});
		}, 
		select: function(event, ui) {
			var infoBox = '#' + $(this).parent().attr('id') + ' .scrollbox';
			var arrName = $(this).parent().attr('data-array');
			$(infoBox + ui.item.value).remove();
			$(infoBox).append('<div>' + ui.item.label + '<img src="view/image/delete.png" alt="" /><input type="hidden" name="' +arrName + '[info][]" value="' + ui.item.value + '" /></div>');

			return false;
		},
		focus: function(event, ui) {
	      return false;
	   }
	});
	$('.info-sel div img').live('click', function() {
		$(this).parent().remove();
	});
}
infoAutocomplete();

//--></script> 
<?php echo $footer; ?>