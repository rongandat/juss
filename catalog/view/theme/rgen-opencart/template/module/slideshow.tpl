<?php 
    /*$this->document->addScript('catalog/view/theme/' . $this->config->get('config_template') . '/js/jquery.nivo.slider.pack.js');
    $this->document->addStyle('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/nivo-slider.css');*/
    
    $getRoute = 'common/home';
    if (isset($this->request->get['route'])) {
        $getRoute = $this->request->get['route'];
    } else {
        $getRoute = 'common/home';
    }
    $slideshowType = $this->config->get('RGen_SlideShow_Type');
?>
<?php if ($getRoute == 'common/home') { 
	if ($this->config->get('RGen_capStatus') && $this->config->get('RGen_cap') == 'c1') { $cpcls = " cap1"; }
	if ($this->config->get('RGen_capStatus') && $this->config->get('RGen_cap') == 'c2') { $cpcls = " cap2"; }
	if ($this->config->get('RGen_capStatus') && $this->config->get('RGen_cap') == 'c3') { $cpcls = " cap3"; }
	if ($this->config->get('RGen_capStatus') && $this->config->get('RGen_cap') == 'c4') { $cpcls = " cap4"; }
	if ($this->config->get('RGen_capStatus') && $this->config->get('RGen_cap') == 'c5') { $cpcls = " cap5"; }
	if ($this->config->get('RGen_capStatus') && $this->config->get('RGen_cap') == 'c6') { $cpcls = " cap6"; }

?><div class="slideshow-wrapper<?php if ($this->config->get('RGen_bannerPosition') == 'beside') { ?> beside-slideshow<?php } ?><?php if(isset($cpcls)){ echo $cpcls; } ?>">
<?php } else { ?>
<div class="slideshow-wrapper">
<?php } ?>
	<?php if ($this->config->get('RGen_bannerPosition') == 'onslide' && $getRoute == 'common/home') { ?>
	<div class="banner-onslide"></div>
	<?php } ?>
	<div class="slideshow slider-wrapper theme-default" style="min-height:<?php echo $height; ?>px;">
		<div id="slideshow<?php echo $module; ?>" class="nivoSlider"<?php if ($this->config->get('RGen_SlideShow_Type') == 'w-full' && $getRoute == 'common/home' || $this->config->get('RGen_SlideShow_Type') == 'wf-full' && $getRoute == 'common/home') { ?> style="width:<?php echo $width; ?>px; height:<?php echo $height; ?>px"<?php } ?>>
			<?php $i=1; foreach ($banners as $banner) { ?>
			<?php if ($banner['link']) { ?>
			<a href="<?php echo $banner['link']; ?>"><img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" title='#<?php echo $i; ?>' /></a>
			<?php } else { ?>
			<img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" title='#<?php echo $i; ?>' />
			<?php } ?>
			<?php $i++; } ?>
		</div>
	</div>

	<?php if($this->config->get('RGen_capStatus') && $getRoute == 'common/home') { ?>
		<?php
			$l_id = $this->config->get('config_language_id');
			$caption1 = $this->document->caption1;
			if($caption1) { 
			foreach ($caption1[$l_id]['captions'] as $caption) {
		?>
			<?php if(
					$this->config->get('RGen_cap') == 'c1' || 
					$this->config->get('RGen_cap') == 'c2' || 
					$this->config->get('RGen_cap') == 'c3' || 
					$this->config->get('RGen_cap') == 'c4' || 
					$this->config->get('RGen_cap') == 'c5' || 
					$this->config->get('RGen_cap') == 'c6' 
					) { 
			?><div id="<?php echo $caption['sort_order'] ?>" class="nivo-html-caption">
				<div class='<?php 
					if($caption['position'] == 'lb') { ?>lb<?php 
					}elseif ($caption['position'] == 'lt') { ?>lt<?php 
					}elseif ($caption['position'] == 'rt') { ?>rt<?php 
					}elseif ($caption['position'] == 'rb') { ?>rb<?php 
					}elseif ($caption['position'] == 'cb') { ?>cb<?php 
					}elseif ($caption['position'] == 'ct') { ?>ct<?php 
					}elseif ($caption['position'] == 'cc') { ?>cc<?php 
					}elseif ($caption['position'] == 'mr') { ?>mr<?php 
					}elseif ($caption['position'] == 'ml') { ?>ml<?php
					} ?>'>
					<?php if($caption['title'] != '') { ?>
					<h3 class='cap-hd'><?php echo htmlspecialchars_decode($caption['title'], ENT_QUOTES ); ?></h3><br>
					<?php } ?>
					<?php if($caption['data'] != '') { ?>
					<div class='cap-data'><?php echo htmlspecialchars_decode($caption['data'], ENT_QUOTES ); ?></div><br>
					<?php } ?>
					<?php if($caption['linktext'] != '') { ?>
					<a href="<?php echo $caption['link'] ?>" class='cap-link'><?php echo htmlspecialchars_decode($caption['linktext'], ENT_QUOTES ); ?></a>
					<?php } ?>
				</div>
			</div>
			<?php } ?> 
		<?php } } ?>
	<?php } ?>
	
	<?php if ($this->config->get('RGen_bannerPosition') == 'beside' && $getRoute == 'common/home') { ?>
	<div class="banner-beside"></div>
	<?php } ?>
</div>

<script type="text/javascript"><!--
<?php if($this->config->get('RGen_capStatus') && $getRoute == 'common/home') { ?>

function cAnimation1 (){
	var time = 400;
	var animSpeed = 400;
	setTimeout(function(){ $('.nivo-caption > div').stop().animate({ left:'0px', opacity:1 }, animSpeed); },0);
	setTimeout(function(){ $('.nivo-caption .cap-hd').stop().animate({ left:'0px', opacity:1 }, animSpeed); },0);
	if ($('.nivo-caption .cap-hd').length != 0) {
		setTimeout(function(){ $('.nivo-caption .cap-data').stop().animate({ left:'0px', opacity:1 }, animSpeed); },time)
	} else {
		setTimeout(function(){ $('.nivo-caption .cap-data').stop().animate({ left:'0px', opacity:1 }, animSpeed); },0)
	}
	if ($('.nivo-caption .cap-data').length != 0) {
		setTimeout(function(){ $('.nivo-caption .cap-link').stop().animate({ left:'0px', opacity:1 }, animSpeed); },time)
	} else {
		setTimeout(function(){ $('.nivo-caption .cap-link').stop().animate({ left:'0px', opacity:1 }, animSpeed); },0)
	}
}
function position(){ 
	var pos = $('.nivo-caption > div').attr('class');
	$('.nivo-caption').removeAttr('id');
	$('.nivo-caption').attr('id', pos);
	if (pos == 'cc' || pos == 'mr' || pos == 'ml') {
		$('.nivo-caption').css({marginBottom: -$('.nivo-caption').height()/2 });
	}
}
<?php } ?>


$(window).load(function() {
	$('#slideshow<?php echo $module; ?>').animate({opacity:1}, 50, function(){
		$(this).nivoSlider({
			<?php if ($this->config->get('RGen_slideshow_Effect') != '--') { ?>
			effect: '<?php echo $this->config->get('RGen_slideshow_Effect'); ?>',
			<?php } ?>
			<?php if ($this->config->get('RGen_slideshow_animSpeed') != '') { ?>
			animSpeed: <?php echo $this->config->get('RGen_slideshow_animSpeed'); ?>,
			<?php } ?>
			<?php if ($this->config->get('RGen_slideshow_pauseTime') != '') { ?>
			pauseTime: <?php echo $this->config->get('RGen_slideshow_pauseTime'); ?>,
			<?php } ?>
			<?php if ($this->config->get('RGen_slideshow_startSlide') != '') { ?>
			startSlide: <?php echo $this->config->get('RGen_slideshow_startSlide'); ?>,
			<?php } ?>
			<?php if ($this->config->get('RGen_slideshow_directionNav') == 'false') { ?>
			directionNav: <?php echo $this->config->get('RGen_slideshow_directionNav'); ?>,
			<?php } ?>
			<?php if ($this->config->get('RGen_slideshow_controlNav') == 'false') { ?>
			controlNav: <?php echo $this->config->get('RGen_slideshow_controlNav'); ?>,
			<?php } ?>
			<?php if ($this->config->get('RGen_slideshow_pauseOnHover') == 'false') { ?>
			pauseOnHover: <?php echo $this->config->get('RGen_slideshow_pauseOnHover'); ?>,
			<?php } ?>
			randomStart: false,
			beforeChange: function(){
					<?php if($this->config->get('RGen_capStatus') && $getRoute == 'common/home') { ?>
					$('.nivo-caption .cap-hd').stop().animate({ opacity:0 }, 300, function(){});
					$('.nivo-caption .cap-data').stop().animate({ opacity:0 }, 300, function(){});
					$('.nivo-caption .cap-link').stop().animate({ opacity:0 }, 300, function(){});
					$('.nivo-caption > div').stop().animate({ opacity:0 }, 300, function(){});
					<?php } ?>
					
				},
	        afterChange: function(){ 
	        		<?php if($this->config->get('RGen_capStatus') && $getRoute == 'common/home') { ?>
	        		position();
					cAnimation1();
					<?php } ?>
	        	},
	        slideshowEnd: function(){},
	        lastSlide: function(){},
	        afterLoad: function(){
	        	//$('.store-home .nivoSlider .nivo-directionNav').appendTo('.slider-wrapper');
	        	if ($(".slider-wrapper").width() < $(".nivoSlider").width()) {
					$('.store-home .nivoSlider .nivo-directionNav').css({width: $(window).width()});
				}
	        	$('.store-home .nivo-directionNav a').css({bottom: ($(".nivoSlider").height() - $(".store-home .nivo-directionNav a").height())/2});
	        	<?php if($this->config->get('RGen_capStatus') && $getRoute == 'common/home') { ?>
	        	position();
	        	cAnimation1();
	        	<?php } ?>
	        	if ($(window).width() < $(".nivoSlider").width()) {
					$('.store-home .cap4 .nivo-caption').css({width: $(window).width(), marginLeft:-$(window).width()/2});
				}else{
					$('.store-home .cap4 .nivo-caption').css({width: "100%", left:0});
				};
	        }
		});	
	});
});


$(document).ready(function() {
	// DO NOT DELETE THIS JS 
	if($('#content').hasClass('full-slideshow') || $('#content').hasClass('medium-slideshow') || $('#content').hasClass('small-slideshow') || $('#content').hasClass('w-full-slideshow') || $('#content').hasClass('wf-full-slideshow')){
		
		$('.slideshow-wrapper').css({opacity:0}).prependTo('#content').end().animate({opacity:1}, 500);
		$('.slideshow-wrapper').after('<div class="notification-block"></div>');
		$('#notification').prependTo('.notification-block');
		//$('.slideshow').wrap('<div class="slideshow-wrapper" />');
		
		<?php if ($this->config->get('RGen_bannerPosition') == 'below') { ?>
		$('#banner0').css({opacity:0}).appendTo('.slideshow-wrapper').end().animate({opacity:1}, 500);
		<?php } ?>
	}
	<?php if ($this->config->get('RGen_bannerPosition') == 'beside' && $getRoute == 'common/home') { ?>
	$('.beside-bnr-slideshow #banner0').css({opacity:0}).appendTo('.banner-beside').end().animate({opacity:1}, 500, function(){
		$('.beside-slideshow').css({minHeight: $('.banner-beside').outerHeight()});
	});
	<?php } ?>

	<?php if ($this->config->get('RGen_bannerPosition') == 'onslide' && $getRoute == 'common/home') { ?>
	$('.bnr-onslide #banner0').css({opacity:0}).appendTo('.banner-onslide').end().animate({opacity:1}, 500, function(){});
	<?php } ?>

	<?php if ($this->config->get('RGen_SlideShow_Type') == 'full' || $this->config->get('RGen_SlideShow_Type') == 'wf-full') { ?>
	if($('#content').hasClass('full-slideshow') || $('#content').hasClass('wf-full-slideshow')){
		$('.full-slideshow .slideshow, .wf-full-slideshow .slideshow').css({marginTop:-$('#header-wrapper').outerHeight()});
	}
	/* FOR THEME 5 */
	if($('body').hasClass('thm-5')){
		$('.full-slideshow .slideshow, .wf-full-slideshow .slideshow').css({marginTop:-(70 + $('#header-wrapper').outerHeight())});
	}
	/* FOR THEME 6 */
	if($('body').hasClass('thm-6')){
		$('.full-slideshow .slideshow, .wf-full-slideshow .slideshow').css({marginTop:-(36 + $('#header-wrapper').outerHeight())});
	}
	<?php } ?>

	<?php if ($this->config->get('RGen_SlideShow_Type') == 'w-full' || $this->config->get('RGen_SlideShow_Type') == 'wf-full') { ?>
	function fullSlideshow(){
		var fullWidth = Math.floor(($(window).width() - $('#content').width())/2);
		var slideWidth = Math.floor(($(window).width() - $(".nivoSlider").width())/2);
		$('.store-home .slider-wrapper').css({marginLeft: -fullWidth, marginRight: -fullWidth});
		if ($(window).width() < $(".nivoSlider").width()) {
			$('.store-home .nivoSlider').css({left: slideWidth});
			$('.store-home .cap4 .nivo-caption').css({width: $(window).width(), marginLeft:-$(window).width()/2});
		};
		if ($(".slider-wrapper").width() < $(".nivoSlider").width()) {
			$('.store-home .nivoSlider .nivo-directionNav').css({width: $(window).width()});
		}
		$('.store-home .nivo-directionNav a').css({bottom: ($(".nivoSlider").height() - $(".store-home .nivo-directionNav a").height())/2});
	}
	fullSlideshow();
	$(window).resize(function(){fullSlideshow();});
	<?php } ?>
});

--></script>