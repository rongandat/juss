<?php require_once '../../../stylesheet/cssminify.php'; ?>

/*	
	COMMON ICONS
	============================ 
*/
.wish,
.compare,
.store-home #slidshow-box .next,
.store-home #slidshow-box .prev,
#header .button-search,
.home-btn,
.prev,
.prev:hover, 
.next,
.next:hover, 
.jcarousel-prev,
.jcarousel-prev:hover,
.jcarousel-prev.jcarousel-prev-disabled,
.jcarousel-prev.jcarousel-prev-disabled:hover,
.jcarousel-next,
.jcarousel-next:hover,
.jcarousel-next.jcarousel-next-disabled,
.jcarousel-next.jcarousel-next-disabled:hover,
a.cart-bt, 
.cart-bt,
.cart-bt:hover,
#footer .contact-info .ph-image, 
#footer .contact-info .fax-image, 
#footer .contact-info .email-image,
.footer-bt a,
.list-bt,
.grid-bt,
.product-info .image .zoom-text b,
.product-info .cart a.cart-bt,
.read-review .wrt-on,
#twitter ul li,
#header #cart .cart-arrow {
	background-image: url(sprites.png);
	background-repeat: no-repeat;
}

#header #cart .heading a {
	background:url(cart.png) no-repeat 8px 8px;
}

/* Header icons */
.home-btn {
	background-position:0 -40px;
	background-repeat: no-repeat;
}
#header .button-search {
	background-position: -40px 0;
}
#header #search:hover .button-search,
#header .button-search:hover {
	background-position: 0 0;
}
.home-btn:hover {
	background-position:-40px -40px;
}
.selected-currency,
.selected-language {
	background:url(downArrow.png) no-repeat 40px 13px;
}
#header #cart .cart-arrow {
	background-position: 350px -2420px;
}
.select {
	background-image:url(SelectMenu.png);
	background-repeat:no-repeat;
	background-position:right bottom;
}
/* Cart button */
a.cart-bt {
	background-position: 0 -140px;
}
a.cart-bt:hover {
	background-position: -52px -140px;
}
.prd-block1 a.cart-bt {
	background-image:url(cartbt.png);
	background-repeat:no-repeat;
	background-position: center center;
}
.prd-block1 a.cart-bt:hover {
	background-image:url(cartbt_hover.png);
}
.product-info .cart a.cart-bt {
	background-position: 0 -192px;
}
.wish {
	background-position: -80px -40px;
}
.wish:hover {
	background-position: -120px -40px;
}
.compare {
	background-position: -104px -140px;
}
.compare:hover {
	background-position: -144px -140px;
}
/* Arrows */
.prev, .jcarousel-prev {
	background-position: 0px -310px;
}
.next, .jcarousel-next {
	background-position: 0px -339px;
}
.prev:hover, .jcarousel-prev:hover {
	background-position: -29px -310px;
}
.next:hover, .jcarousel-next:hover {
	background-position: -29px -339px;
}
.jcarousel-prev.jcarousel-prev-disabled, 
.jcarousel-prev.jcarousel-prev-disabled:hover {
	background-position: -29px -310px;
}
.jcarousel-next.jcarousel-next-disabled,
.jcarousel-next.jcarousel-next-disabled:hover {
	background-image: -29px -339px;
}
.store-home #slidshow-box .next {
	background-position: -60px -80px;
}
.store-home #slidshow-box .prev {
	background-position: 0 -80px;
}

/* Product list */
.list-bt {
	background-position: -40px -368px;
}
.grid-bt {
	background-position: 0 -368px;
}

/* Product page icons */
.product-info .cart .cart-bt:hover {
	background-position:-58px -192px;
}
.product-info .image .zoom-text b {
	background-position: -80px -905px;
}
.read-review .wrt-on {
	background-position: -40px -905px;
}

/* Footer icons */
#twitter ul li { 
	background-position: 0 -1914px; 
}
#footer .contact-info .ph-image {
	background-position: 0 -945px;
}
#footer .contact-info .fax-image {
	background-position: -45px -945px;
}
#footer .contact-info .email-image {
	background-position: -90px -945px;
}
a.facebook-icon {
	background-position: 0 -1504px;
}
a.twitter-icon {
	background-position: 0 -1570px;
}
a.youtube-icon {
	background-position: 0 -1636px;
}
a.google-icon {
	background-position: 0 -1702px;
}


a.flickr-icon {
	background-position: 0 -1959px;
}
a.pintrest-icon {
	background-position: 0 -2019px;
}
a.yahoo-icon {
	background-position: 0 -2079px;
}
a.tumblr-icon {
	background-position: 0 -2139px;
}
a.insta-icon {
	background-position: 0 -2199px;
}
a.linkedin-icon {
	background-position: 0 -2259px;
}
a.vimeo-icon {
	background-position: 0 -2319px;
}
a.mailto-icon {
	background-position: 0 -1768px;
}
a.addthis-icon {
	background-position: 0 -1834px;
}
a.facebook-icon:hover {
	background-position: -66px -1504px;
}
a.twitter-icon:hover {
	background-position: -66px -1570px;
}
a.youtube-icon:hover {
	background-position: -66px -1636px;
}
a.google-icon:hover {
	background-position: -66px -1702px;
}
a.flickr-icon:hover {
	background-position: -66px -1959px;
}
a.pintrest-icon:hover {
	background-position: -66px -2019px;
}
a.yahoo-icon:hover {
	background-position: -66px -2079px;
}
a.tumblr-icon:hover {
	background-position: -66px -2139px;
}
a.insta-icon:hover {
	background-position: -66px -2199px;
}
a.linkedin-icon:hover {
	background-position: -66px -2259px;
}
a.vimeo-icon:hover {
	background-position: -66px -2319px;
}

a.mailto-icon:hover {
	background-position: -66px -1768px;
}
a.addthis-icon:hover {
	background-position: -66px -1834px;
}
<?php ob_end_flush(); ?>