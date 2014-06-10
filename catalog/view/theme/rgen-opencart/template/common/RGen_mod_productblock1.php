<div class="prd-block">
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
		<div class="info"> <a href="<?php echo $product['href']; ?>" class="name"><?php echo $product['name']; ?></a>
			<?php if ($product['price']) { ?>
			<div class="price-wrp">
				<?php if (!$product['special']) { ?>
				<?php echo $product['price']; ?>
				<?php } else { ?>
				<span class="price-old"><?php echo $product['price']; ?></span>
				<?php echo $product['special']; ?>
				<?php } ?>
			</div>
			<?php } ?>
			
			<?php if ($product['rating']) { ?>
			<div class="rating"><img src="catalog/view/theme/default/image/stars-<?php echo $product['rating']; ?>.png" alt="<?php echo $product['reviews']; ?>" /></div>
			<?php } ?>
			<a class="cart-bt" title="<?php echo $button_cart; ?>" onclick="addToCart('<?php echo $product['product_id']; ?>');"><?php echo $button_cart; ?></a>
			<ul>
				<li><a href="<?php echo $product['href']; ?>"><?php echo $this->language->get('button_moreinfo'); ?> <span>&#8250;</span></a></li>
				<li><a onclick="addToWishList('<?php echo $product['product_id']; ?>');"><?php echo $this->language->get('button_wishlist'); ?> <span>&#8250;</span></a></li>
				<li class="last"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');"><?php echo $this->language->get('button_compare'); ?> <span>&#8250;</span></a></li>
			</ul>
		</div>
		<?php if ($product['price']) { ?>
		<div class="price">
			<?php if (!$product['special']) { ?>
			<span class="price-new"><?php echo $product['price']; ?></span>
			<?php } else { ?>
			<span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
			<?php } ?>
		</div>
		<?php } ?>
	</div>
</div>