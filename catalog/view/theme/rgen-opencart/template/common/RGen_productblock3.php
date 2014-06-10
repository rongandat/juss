<?php foreach ($products as $product) { ?>
<div class="prd-block2">
	<div class="image">
		<?php if ($product['special']) { ?>
		<span class="offer-tag"></span>
		<?php } ?>
        <a href="<?php echo $product['href']; ?>">
			<?php if ($product['thumb']) { ?>
			<img src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
			<?php } ?>
		</a>
	</div>
	<div class="info-wrp">
		<div class="info">
			<strong class="nameText"><a href="<?php echo $product['href']; ?>" class="name"><?php echo $product['name']; ?></a></strong>
			<div class="description"><?php echo $product['description']; ?></div>
			<div class="rating"><span class="sml-stars stars-<?php echo $product['rating']; ?>" title="<?php echo $product['reviews']; ?>"></span></div>
			<?php if ($product['price']) { ?>
			<div class="price">
				<?php if (!$product['special']) { ?>
				<span class="price-new"><?php echo $product['price']; ?></span>
				<?php } else { ?>
				<span class="price-old"><?php echo $product['price']; ?></span>
				<span class="price-new"><?php echo $product['special']; ?></span>
				<?php } ?>
				<?php if ($product['tax']) { ?>
				<span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
				<?php } ?>
			</div>
			<?php } ?>
			<div class="buy-option">
				<a class="addtocart" title="<?php echo $button_cart; ?>" onclick="addToCart('<?php echo $product['product_id']; ?>');"><?php echo $button_cart; ?></a>
				<span class="otherbtn">
					<a class="prdbt wish" onclick="addToWishList('<?php echo $product['product_id']; ?>');" title="<?php echo $button_wishlist; ?>"><?php echo $button_wishlist; ?></a>
					<a class="prdbt compare" onclick="addToCompare('<?php echo $product['product_id']; ?>');" title="<?php echo $button_compare; ?>"><?php echo $button_compare; ?></a>
				</span>
			</div>
		</div>
	</div>
</div>
<?php } ?>

<script type="text/javascript"><!--
function display(view) {
	if (view == 'list') {
		
		$('.product-grid').attr('class', 'product-list');
		
		
		$('.product-list > .prd-block2').each(function(index, element) {
			
			$('.product-list > .prd-block2').addClass('list-block');
			
			// PRODUCT IMAGE
			var image = $(element).find('.image').html();
			html = '<div class="image">' + image + '</div>';
			
			html += '<div class="info-wrp">'
			html += '	<div class="info">'
			html += '		<strong class="nameText">' + $(element).find('.nameText').html() + '</strong>';
			html += '		<div class="rating">' + $(element).find('.rating').html() + '</div>';
			html += '		<div class="description">'+ $(element).find('.description').html() +'</div>';
			
			// PRODUCT PRICE
			var price = $(element).find('.price').html();
			if (price != null) {
				html += '<div class="price">' + price  + '</div>';
			}

			html += '		<div class="buy-option">' + $(element).find('.buy-option').html() + '</div>';
			html += '	</div>'
			
			html += '</div>';
			$(element).html(html);
			
		});		
		
		$('.display').html('<a onclick="display(\'grid\');" class="grid-bt"><?php echo $text_grid; ?></a><b class="list-bt"><?php echo $text_list; ?></b>');
		
		$.totalStorage('display', 'list'); 
	} else {
		$('.product-list').attr('class', 'product-grid');
		
		$('.product-grid > .prd-block2').each(function(index, element) {

			$('.product-grid > .prd-block2').removeClass('list-block');
			$('.product-grid > .prd-block2').addClass('grid-block');
					
			// PRODUCT IMAGE
			var image = $(element).find('.image').html();
			html = '<div class="image">' + image + '</div>';
			
			html += '<div class="info-wrp">'
			html += '	<div class="info">'
			html += '		<strong class="nameText">' + $(element).find('.nameText').html() + '</strong>';
			html += '		<div class="rating">' + $(element).find('.rating').html() + '</div>';
			html += '		<div class="description" style="display:none;">'+ $(element).find('.description').html() +'</div>';
			
			// PRODUCT PRICE
			var price = $(element).find('.price').html();
			if (price != null) {
				html += '<div class="price">' + price  + '</div>';
			}
			
			html += '		<div class="buy-option">' + $(element).find('.buy-option').html() + '</div>';
			html += '	</div>'
			
			html += '</div>';
			
			$(element).html(html);
			
			
		});	
					
		$('.display').html('<b class="grid-bt"><?php echo $text_grid; ?></b><a onclick="display(\'list\');" class="list-bt"><?php echo $text_list; ?></a>');
		
		$.totalStorage('display', 'grid');
		
		$('.grid-block').on('hover');
	}
}

view = $.totalStorage('display');

if (view) { 
	display(view);
} else {
	<?php if ($this->config->get('RGen_prdList_defaultView') == 'grid') { ?>
	display('grid');
	<?php }else { ?>
	display('list');
	<?php } ?>
}
//--></script> 