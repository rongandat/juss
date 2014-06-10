$(document).ready(function() {
	/* Search */
	$('.button-search').bind('click', function() {
		url = $('base').attr('href') + 'index.php?route=product/search';
				 
		var search = $('input[name=\'search\']').attr('value');
		
		if (search) {
			url += '&search=' + encodeURIComponent(search);
		}
		
		location = url;
	});
	
	$('#header input[name=\'search\']').bind('keydown', function(e) {
		if (e.keyCode == 13) {
			url = $('base').attr('href') + 'index.php?route=product/search';
			 
			var search = $('input[name=\'search\']').attr('value');
			
			if (search) {
				url += '&search=' + encodeURIComponent(search);
			}
			
			location = url;
		}
	});
	
	$('.success img, .warning img, .attention img, .information img').live('click', function() {
		$('#notification').fadeOut('slow');
		$(this).parent().fadeOut('slow', function() {
			$(this).remove();
		});
	});	
});

function getURLVar(key) {
	var value = [];
	
	var query = String(document.location).split('?');
	
	if (query[1]) {
		var part = query[1].split('&');

		for (i = 0; i < part.length; i++) {
			var data = part[i].split('=');
			
			if (data[0] && data[1]) {
				value[data[0]] = data[1];
			}
		}
		
		if (value[key]) {
			return value[key];
		} else {
			return '';
		}
	}
} 

function addToCart(product_id, quantity) {
	quantity = typeof(quantity) != 'undefined' ? quantity : 1;

	$.ajax({
		url: 'index.php?route=checkout/cart/add',
		type: 'post',
		data: 'product_id=' + product_id + '&quantity=' + quantity,
		dataType: 'json',
		success: function(json) {
			$('.success, .warning, .attention, .information, .error').remove();
			
			if (json['redirect']) {
				location = json['redirect'];
			}
			
			if (json['success']) {
				$('#notification').show();
				$('#notification').html('<div class="success" style="display: none;">' + json['success'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
				alertBox();
				$('.success').fadeIn('slow');
				
				$('#cart').load('index.php?route=module/cart #cart > *', function(){
					var getTotal = $('.mini-cart-total').find('tr:last').find('td:last').html();
					$('#cart').find('#cart-total').html(getTotal);
				});

				//$('html, body').animate({ scrollTop: 0 }, 'slow'); 
			}
			if (json['success']) {
				$('html, body').animate({ scrollTop: 0 }, 'slow');
			}	
		}
	});
}
function addToWishList(product_id) {
	$.ajax({
		url: 'index.php?route=account/wishlist/add',
		type: 'post',
		data: 'product_id=' + product_id,
		dataType: 'json',
		success: function(json) {
			$('.success, .warning, .attention, .information').remove();
						
			if (json['success']) {
				$('#notification').show();
				$('#notification').html('<div class="success" style="display: none;">' + json['success'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
				alertBox();
				$('.success').fadeIn('slow');
				
				$('#wishlist-total').html(json['total']);
				
				//$('html, body').animate({ scrollTop: 700 }, 'slow');
			}
			if (json['success']) {
				$('html, body').animate({ scrollTop: 0 }, 'slow');
			}	
		}
	});
}

function addToCompare(product_id) { 
	$.ajax({
		url: 'index.php?route=product/compare/add',
		type: 'post',
		data: 'product_id=' + product_id,
		dataType: 'json',
		success: function(json) {
			$('.success, .warning, .attention, .information').remove();
						
			if (json['success']) {
				$('#notification').show();
				$('#notification').html('<div class="success" style="display: none;">' + json['success'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
				alertBox();
				$('.success').fadeIn('slow');
				
				$('#compare-total').html(json['total']);
				
				//$('html, body').animate({ scrollTop: 700 }, 'slow'); 
			}
			if (json['success']) {
				$('html, body').animate({ scrollTop: 0 }, 'slow');
			}	
		}
	});
}


/************************************************************
RGEN THEME SCRIPT */

// Tiny jQuery Plugin by Chris Goodchild
$.fn.exists = function(callback) { var args = [].slice.call(arguments, 1); if (this.length) { callback.call(this, args); } return this; };
function alertBox(){
	$('#notification').css({marginLeft: -$('#notification').outerWidth()/2});
}

$(document).ready(function() {

	/* CSS CLASS ADDED FOR HOME PAGE */
	$('.store-home').parent().addClass('home-wrapper');
	if($('.store-home').hasClass('full-slideshow') == true){
		$('body').addClass('full-slideshow');
	}
	if($('.store-home').hasClass('wf-full-slideshow') == true){
		$('body').addClass('wf-full-slideshow');
	}
	$('.home-wrapper').exists(function() {
		$('body').addClass('homepage');
	});

	if($('#column-left, #column-right').hasClass('column') == false){
		$('body').addClass('col-n');
	}else{
		$('body').addClass('col-y');
	}
	
	if($('#content').hasClass('full-slideshow') || $('#content').hasClass('medium-slideshow')){
		$('#container').addClass('slideshow-overflow')
	}

	/*====================================*/

	/* NOTIFICATION ADDED IN TO CONTENT AREA */
	$('#notification').prependTo('#content');

	/*====================================*/

	/* CUSTOM FOOTER ADD CLASS */
	$('.custom-footer').find('.column:last').addClass('last');

	/*====================================*/

	/* CATEGORIES */
	$(".box-category .cc").each(function(index, element) {
		//alert($(".box-category .cc").parent().hasClass('cat-active'));
		if($(this).parent().hasClass('cat-active') == true){
			$(this).addClass('open');
			$(this).next().addClass('active');
		}	
	});
	$(".box-category .cc").click(function(){ 
		if($(this).next().is(':visible') == false) {
			$('.box-category .col-subcat').slideUp(300, function(){
				$(this).removeClass('active');
				$('.cc').removeClass('open');
			});
		}
		if($(this).hasClass('open') == true) {
			$(this).next().slideUp(300, function(){
				$(this).removeClass('active');
				$(this).prev().removeClass('open');
			});
		}else{
			$(this).next().slideDown(300, function(){
				$(this).addClass('active');
				$(this).prev().addClass('open');
			});
		}
	});

	/*====================================*/

	/* BREADCRUMB */
	if($('#container').hasClass('menu-fw')){
		$('.breadcrumb').appendTo('#menu');
	} else {
		$('.breadcrumb').appendTo('.navigation-bar');
	}
	$('.breadcrumb').css({visibility:'visible'});
	$('.thm-3 .breadcrumb').appendTo('#menu');

	/*====================================*/

	/* THEMES SETTINGS */
	if($('body').hasClass('thm-5') || $('body').hasClass('thm-6')){
		pgHd();
		$('.header-1').each(function(){
			if($(this).find('span').length == 0){
				$(this).wrapInner("<span></span>");	
			}
		});
	}
	if($('body').hasClass('thm-7')){ pgHd(); }
	if($('body').hasClass('thm-8') || $('body').hasClass('thm-9')){ pgHd(); }
	function pgHd() {
		if($("body").hasClass('homepage') == false){
			$('.content-body').prepend("<div class='page-heading-wrp'></div>");
		}
		if($(".page-heading-wrp .page-heading").length == 0){
			$('.page-heading').prependTo(".page-heading-wrp");
		}
		if($(".page-heading-wrp .breadcrumb").length == 0){
			$('.breadcrumb').appendTo(".page-heading-wrp");
		}
		if($(".content-body > .product-info").length != 0){
			$('.product-info > .right > .header-1').prependTo(".page-heading-wrp");
			$('.page-heading-wrp .header-1').addClass("page-heading").removeClass('header-1');
		}
	}

	/*====================================*/

	/* AUTO TAB SETUP */
	var T = 0;
	var CT = 0;
	var CP = 0;
	$('.content-tab').each(function(){
		T++
		var createCls = 'cTab'+T;
		$(this).addClass(createCls);
		
		var newCls = '.cTab'+T + ' .htabs a';
		var newClsPane = '.cTab'+ T + ' .tab-content';
		
		
		$(newCls).each(function(){
			CT++
			var tabCls = 'cT'+CT;
			$(this).attr('href', '#'+tabCls);
		});
		
		$(newClsPane).each(function(){
			CP++
			var paneCls = 'cT'+CP;
			$(this).attr('id', paneCls);
		});
		$(newCls).tabs();
	});

	/*====================================*/

	/* Custom Scroll bar setup */
	var srl = 0;
	$('.scrollPane').each(function(){
		
		// SET ID ON ALL SCROLL PANE
		srl++;
		var createCls = 'sp'+srl;
		$(this).addClass(createCls);
		$(this).wrapInner('<div class="dataHolder"></div>');
		
		var newCls = '.sp'+srl;
		// CALLING SCROLL FUNCTION
		$(window).load(function(){
			$(newCls).mCustomScrollbar();
			$(newCls + ' .mCSB_dragger_bar').prepend('<b class="t"></b><b class="b"></b>');
		});
	});

	/*====================================*/

	/* SELECT DROPDOWN MENU	*/
	$('select').each(function(){
		if($(this).parent().hasClass('select') == false){
			$(this).wrap("<span class='select'></span>");
			$(this).addClass('select-menu');
		}
	})

	/*====================================*/

	/* CURRENCY */
	$('#currency').hover(
		function(){ $(this).find('ul').css({display:'block'}) },
		function(){ $(this).find('ul').css({display:'none'}) }
	);
	
	/* LANGUAGE */
	$('#language').hover(
		function(){ $(this).find('ul').css({display:'block'}) },
		function(){ $(this).find('ul').css({display:'none'}) }
	);

	/*====================================*/

	/* CUSTOM STICKY BLOCKS */
	$('.custom-left').each(function(){
		$(this).css({left: -$(this).outerWidth(), display: "block"});
	});
	$('.custom-right').each(function(){
		$(this).css({right: -$(this).outerWidth(), display: "block"});
	});
	$('.custom-left .icon').mouseenter(function(){
		$(this).parent().css({zIndex : 99999});
		$(this).parent().stop().animate({'left' : '0px'});
	});
	$('.custom-left').mouseleave(function(){
		var w = $(this).outerWidth();
		$(this).stop().animate({'left': 0 - w}, function(){$(this).css({zIndex : 9999});});
		
	});
	$('.custom-right .icon').mouseenter(function(){
		$(this).parent().css({zIndex : 99999});
		$(this).parent().stop().animate({'right' : '0px'});
	});
	$('.custom-right').mouseleave(function(){
		var w = $(this).outerWidth();
		$(this).stop().animate({'right': 0 - w}, function(){$(this).css({zIndex : 9999});});
	});

	/*====================================*/

	/* CUSTOM TOP AND BOTTOM BLOCKS */
	$(".tp-wrp.d-close, .ft-wrp.d-close").each(function(){
		var h = $(this).find(".custom-data").outerHeight();
		$(this).find(".custom-data").css({'marginTop' : -h});
		$(this).find(".open").removeClass("open");
	});
	$('.hdl').click(function(){
		var block = "#" + $(this).parent().parent().attr("id");
		var h = $(block).find(".custom-data").outerHeight();
		if($(block).find(".wrapper").hasClass('open') == false){
			$(block).find(".custom-data").stop().animate({'marginTop' : 0}, 500, function(){
				$(block).find(".wrapper").addClass("open");
			});
			if($(block).hasClass("ft-wrp")){
				$('html, body').animate({ scrollTop: $("html").height()+h  }, '500');
			}
		}else {
			$(block).find(".custom-data").stop().animate({'marginTop' : -h},function(){
				$(block).find(".wrapper").removeClass("open");
			});
		}
	});

	/*====================================*/

	$('.scroll-top').click(function(){
		$('html, body').animate({ scrollTop: 0 }, '500');
	});

	/*====================================*/

	/* Mega Menu */
	$('#menu ul > li > a.top-lvl').mouseover(function(e) {
		if($(this).parent().children('.sub-menu').length != 0){
			var submenu = $(this).next('.sub-menu');
			var menu = $('#menu').offset();
			var dropdown = $(submenu).offset();
			i = (dropdown.left + $(submenu).outerWidth()) - (menu.left + $('#menu').outerWidth());
			if (i > 0) {
				$(submenu).css('margin-left', '-' + (i + 5) + 'px');
			}
		}
	});
	/* Mega Menu */
	if ($.browser.msie) {
		$('body').addClass('oldie');
		$('#menu > ul > li').bind('mouseover', function() {
			$(this).addClass('active');
		});
		$('#menu > ul > li').bind('mouseout', function() {
			$(this).removeClass('active');
		});
	}

	// IE6 & IE7 Fixes
	if ($.browser.msie) {
		if ($.browser.version <= 6) {
			$('#column-left + #column-right + #content, #column-left + #content').css('margin-left', '195px');
			
			$('#column-right + #content').css('margin-right', '195px');
		
			$('.box-category ul li a.active + ul').css('display', 'block');	
		}
		
		if ($.browser.version <= 7) {
			$('#menu > ul > li').bind('mouseover', function() {
				$(this).addClass('active');
			});
				
			$('#menu > ul > li').bind('mouseout', function() {
				$(this).removeClass('active');
			});	
		}
	}

	/*====================================*/

	/* IMAGE SLIDER */
	var slide = 0;
	$('.set-slider').each(function(){
		// SET ID ON ALL OBJECTS
		slide++;
		var createCls = 'sld'+slide;
		$(this).addClass(createCls);
		
		var newCls = '.sld'+slide;
		$(newCls).addClass('slide-widget');
		$(window).load(function(){
			slideSet();
		});

		var w 				= parseInt($(newCls).attr('data-width'));
		var h 				= parseInt($(newCls).attr('data-height'));
		var interval 		= parseInt($(newCls).attr('data-interval'));
		var effect 			= $(newCls).attr('data-effect');
		var auto 			= eval($(newCls).attr('data-auto'));
		var pauseOnHover 	= eval($(newCls).attr('data-pauseOnHover'));

		$(newCls).css({maxWidth:w,maxHeight:h});
		
		function slideSet(){
			$(newCls).slidesjs({ 
				width: w, height: h,
				play: {
					effect: effect,
					interval: interval,
					auto: auto,
					pauseOnHover: pauseOnHover
				}
			});
		}
	});

	/*====================================*/

	/* NIVO SLIDER */
	var nivo = 0;
	$('.nivo-widget').each(function(){
		// SET ID ON ALL OBJECTS
		nivo++;
		var createCls = 'niv'+nivo;
		$(this).addClass(createCls);
		
		var newCls = '.niv'+nivo;

		$(newCls).wrap( "<div class='slideshow slider-wrapper'></div>" )
		$(newCls).addClass('nivoSlider');

		$(window).load(function(){
			nivoSet();
		});

		var animSpeed 		= parseInt($(newCls).attr('data-animSpeed'));
		var pauseTime 		= parseInt($(newCls).attr('data-pauseTime'));
		var directionNav 	= eval($(newCls).attr('data-directionNav'));
		var controlNav 		= eval($(newCls).attr('data-controlNav'));
		var pauseOnHover 	= eval($(newCls).attr('data-pauseOnHover'));

		function nivoSet(){
			$(newCls).nivoSlider({
				animSpeed: 		animSpeed,
				pauseTime: 		pauseTime,
				directionNav:	directionNav,
				controlNav: 	controlNav,
				pauseOnHover: 	pauseOnHover
			});
		}
	});

	/*====================================*/

	/* COLLAGE IMAGE GRID BANNERS */
	var clg = 0;
	$('.Collage').each(function(){
		// SET ID ON ALL OBJECTS
		clg++;
		var createCls = 'clg'+clg;
		$(this).addClass(createCls);
		
		var newCls = '.clg'+clg;

		$(newCls).children("div").addClass("Image_Wrapper");
		$(newCls).children("div").css({display:"none"});

		$(window).load(function(){
			$(newCls).find(".Image_Wrapper").css({display:"inline-block"});
			collage();
			$(newCls).collageCaption({
				'background' : "",
				'cssClass' : "clg-caption",
				'opacity' : "1"
			});
		});

		function collage(){
			$(newCls).removeWhitespace().collagePlus(
				{
					'fadeSpeed'     : 1000,
					'targetHeight'  : $(newCls).attr('row-height'),
					'direction'     : 'vertical'
				}
			);
		}

		var resizeTimer = null;
		$(window).bind('resize', function() {
			$(newCls).find('.Image_Wrapper').css("opacity", 0);
			if (resizeTimer) clearTimeout(resizeTimer);
			resizeTimer = setTimeout(collage, 200);
		});

	});

	/*====================================*/

	/* MASONRY IMAGE GRID */
	var masonry = 0;
	$('.masonry-wrp').each(function(){
		// SET ID ON ALL OBJECTS
		masonry++;
		var createCls = 'mas'+masonry;
		$(this).addClass(createCls);
		
		var newCls = '.mas'+masonry;

		$(newCls).children("div").addClass("masonry-item");
		
		$(window).load(function(){
			masonrySet();
			$(newCls).collageCaption({
				'background' : "",
				'cssClass' : "masonry-caption",
				'opacity' : "1"
			});
		});
		
		if (!$(newCls).attr('data-width')) {
			if ($('body').hasClass('col-y')){
				var w = 100;
			}else{
				var w = 104;
			};
		}else{
			var w = parseInt($(newCls).attr('data-width'));
		};

		function masonrySet(){
			$(newCls).masonry({
			  columnWidth: w,
			  itemSelector: '.masonry-item'
			});
		}
	});

});