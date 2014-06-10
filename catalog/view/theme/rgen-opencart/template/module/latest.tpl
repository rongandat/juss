<?php if($position == 'column_left' || $position == 'column_right'){ ?>
	
<div class="box latest-prd" id="latest-prd<?php echo $module; ?>">
	<div class="box-heading header-1"><?php echo $heading_title; ?></div>
	<?php if($this->config->get('RGen_colprdView_latest') != 'scroll'){ ?>
	<ul class="box-product">
		<?php foreach ($products as $product) { ?>
		<li class="col-prd">
			<div class="image">
				<?php if ($product['special']) { ?>
				<span class="offer-tag"></span>
				<?php } ?>
				<a href="<?php echo $product['href']; ?>">
					<?php if ($product['thumb']) { ?>
					<img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" />
					<?php } ?>
				</a>
			</div>
			<div class="info-wrp">
				<a href="<?php echo $product['href']; ?>" class="name"><?php echo $product['name']; ?></a>
				<?php if ($product['price']) { ?>
				<div class="price col-price">
					<?php if (!$product['special']) { ?>
					<?php echo $product['price']; ?>
					<?php } else { ?>
					<span class="price-old"><?php echo $product['price']; ?></span>
					<span class="price-new"><?php echo $product['special']; ?></span>
					<?php } ?>
				</div>
				<?php } ?>
				<a href="<?php echo $product['href']; ?>" class="more"><?php echo $this->language->get('button_moreinfo'); ?> <span>&#8250;</span></a>
			</div>
		</li>
		<?php } ?>
	</ul>
	<?php } else { 
		$this->document->addScript('catalog/view/theme/' . $this->config->get('config_template') . '/js/jquery.touchSwipe.min.js');
		$this->document->addScript('catalog/view/theme/' . $this->config->get('config_template') . '/js/jquery.carouFredSel-6.1.0-packed.js');
	?>
	<div class='list-carousel col-prd-carousel'>
		<ul class="box-product">
			<?php foreach ($products as $product) { ?>
			<li class="col-prd carousel-item">
				<div class="image">
					<?php if ($product['special']) { ?>
					<span class="offer-tag"></span>
					<?php } ?>
					<a href="<?php echo $product['href']; ?>">
						<?php if ($product['thumb']) { ?>
						<img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" />
						<?php } ?>
					</a>
				</div>
				<div class="info-wrp">
					<a href="<?php echo $product['href']; ?>" class="name"><?php echo $product['name']; ?></a>
					<?php if ($product['price']) { ?>
					<div class="price col-price">
						<?php if (!$product['special']) { ?>
						<?php echo $product['price']; ?>
						<?php } else { ?>
						<span class="price-old"><?php echo $product['price']; ?></span>
						<span class="price-new"><?php echo $product['special']; ?></span>
						<?php } ?>
					</div>
					<?php } ?>
					<a href="<?php echo $product['href']; ?>" class="more"><?php echo $this->language->get('button_moreinfo'); ?> <span>&#8250;</span></a>
				</div>
			</li>
			<?php } ?>
		</ul>
		<div class="carousel-controls"><a class="prev"></a><a class="next"></a></div>
	</div>
	<script type="text/javascript">
		$('#latest-prd<?php echo $module; ?>').find('.box-product').carouFredSel({
			prev: '#latest-prd<?php echo $module; ?> .carousel-controls .prev',
			next: '#latest-prd<?php echo $module; ?> .carousel-controls .next',
			scroll: 1,
			width:'100%',
			swipe:{ onMouse: true, onTouch: true },
			auto: false,
			circular:false,
			infinite:false
		});
	</script>
	<?php } ?>
	
</div>		

<?php }else{ ?>

<?php 
$this->document->addScript('catalog/view/theme/' . $this->config->get('config_template') . '/js/jquery.touchSwipe.min.js');
$this->document->addScript('catalog/view/theme/' . $this->config->get('config_template') . '/js/jquery.carouFredSel-6.1.0-packed.js');

$getRoute = 'common/home';
if (isset($this->request->get['route'])) {
    $getRoute = $this->request->get['route'];
} else {
    $getRoute = 'common/home';
}
if ($this->config->get('RGen_SlideShow_Mod_status') == 1 && $this->config->get('RGen_SlideShow_Mod') == 'latest' && $getRoute == 'common/home') { ?>
<div class="box latest-prd slidshow-prd list-carousel" id="slidshow-box">
	<div class="box-heading header-1"><?php echo $heading_title; ?></div>
	<ul class="box-product">
		<?php foreach ($products as $product) { ?>
		<li class="carousel-item">
			<?php include 'catalog/view/theme/rgen-opencart/template/common/RGen_mod_productblock1.php'; ?>
		</li>
		<?php } ?>
	</ul>
	<div class="carousel-controls"><a class="prev"></a><a class="next"></a></div>
	<div class="clearfix hr"></div>
</div>

<script type="text/javascript"><!--
$(document).ready(function(){
	$('#slidshow-box').find('.box-product').each(function() {
		$(this).carouFredSel({
			//responsive: true,
			prev: '#slidshow-box .carousel-controls .prev',
			next: '#slidshow-box .carousel-controls .next',
			width: 469,
			auto:false,
			scroll: 1,
			onCreate: function(){
				$('#slidshow-box .carousel-controls').css({ display:'block' });
			},
			items: { visible: {min: 2}},
			swipe:{ onMouse: true, onTouch: true },
			circular:false,
			infinite:false
		});
	});
	$('#slidshow-box').prependTo('#content .slideshow:first');
});
//--></script>

<?php }else { 

$this->document->addScript('catalog/view/theme/' . $this->config->get('config_template') . '/js/jquery.touchSwipe.min.js');
$this->document->addScript('catalog/view/theme/' . $this->config->get('config_template') . '/js/jquery.carouFredSel-6.1.0-packed.js');
$modprd = $this->config->get('RGen_modPrdBlock_latest');
?>
<div class="box latest-prd list-carousel<?php if ($this->config->get('RGen_carouselArrow') == 'tr' || $modprd == 'prd2') { ?> arrow-tr<?php } ?><?php if ($modprd == 'prd2') { ?> modprd2<?php } ?><?php if ($modprd == 'prd1' || $modprd == '') { ?> modprd1<?php } ?>" id="latest-prd<?php echo $module; ?>">
<div class="box-heading header-1"><?php echo $heading_title; ?></div>
	<ul class="box-product">
		<?php foreach ($products as $product) { ?>
		<li class="carousel-item">
			<?php 
			if ($modprd == 'prd1' || $modprd == '') {
				include 'catalog/view/theme/rgen-opencart/template/common/RGen_mod_productblock1.php';
			} elseif ($this->config->get('RGen_modPrdBlock_latest') == 'prd2') {
				include 'catalog/view/theme/rgen-opencart/template/common/RGen_mod_productblock2.php';
			} elseif ($modprd == 'prd3') {
				include 'catalog/view/theme/rgen-opencart/template/common/RGen_mod_productblock3.php';
			}
			?>
		</li>
		<?php } ?>
	</ul>
	<div class="carousel-controls"><a class="prev"></a><a class="next"></a></div>
	<div class="pager"></div>
	<div class="clearfix hr"></div>
</div>
<script type="text/javascript"><!--
$(document).ready(function(){

	var obj = '#latest-prd<?php echo $module; ?>';
	function Carousel(){

		if($(obj).find('.box-product').children('li').length == 3) {
			$(obj).addClass('less3');
		}else if($(obj).find('.box-product').children('li').length == 2) {
			$(obj).addClass('less2');
		}else if($(obj).find('.box-product').children('li').length == 1) {
			$(obj).addClass('less1');
		}

		$(obj).each(function() {
			var main_w = $(this).outerWidth();
			var totalprd_w = $(this).find(".carousel-item").outerWidth()*$(this).find(".carousel-item").length;
			if (totalprd_w > main_w){
				setCarousel();
			}else{
				$(this).find('.box-product').trigger("destroy", true);
				$(this).find('.box-product').removeAttr("style");
				$(this).find('.box-product .carousel-item').removeAttr("style");
			};
		});
		function setCarousel() {
			$(obj).find('.box-product').carouFredSel({
				prev: obj + ' .carousel-controls .prev',
				next: obj + ' .carousel-controls .next',
				width: '100%',
				pagination: obj + ' .pager',
				mousewheel: true,
				scroll: 1,
				auto: false,
				circular:false,
				infinite:false,
				swipe:{ onMouse: true, onTouch: true }
			});
		}
	}
	Carousel();
	
	<?php if ($this->config->get('RGen_reaponsive_status') == 1) { ?>
	enquire.register("only screen and (min-width: 980px)", {
		match : function() { Carousel(); }
	}).register("only screen and (min-width: 768px) and (max-width: 979px)", {
		match : function() { Carousel(); }
	}).register("only screen and (min-width: 200px) and (max-width: 419px)", {
		match : function() { Carousel(); }
	}).register("only screen and (min-width: 420px) and (max-width: 599px)", {
		match : function() { Carousel(); }
	}).register("only screen and (min-width: 600px) and (max-width: 767px)", {
		match : function() { Carousel(); }
	}).listen();
	<?php } ?>
});
//--></script>

<?php } ?>
<?php } ?>