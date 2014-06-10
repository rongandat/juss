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
			<div class="rating"><span class="sml-stars stars-<?php echo $product['rating']; ?>" title="<?php echo $product['reviews']; ?>"></span></div>
			<?php if ($product['price']) { ?>
			<div class="price">
				<?php if (!$product['special']) { ?>
				<span class="price-new"><?php echo $product['price']; ?></span>
				<?php } else { ?>
				<span class="price-old"><?php echo $product['price']; ?></span>
				<span class="price-new"><?php echo $product['special']; ?></span>
				<?php } ?>
			</div>
			<?php } ?>
			<div class="buy-option">
				<a class="addtocart" title="<?php echo $button_cart; ?>" onclick="addToCart('<?php echo $product['product_id']; ?>');"><?php echo $button_cart; ?></a>
				<span class="otherbtn">
					<a class="prdbt wish" onclick="addToWishList('<?php echo $product['product_id']; ?>');" title="<?php echo $this->language->get('button_wishlist'); ?>"><?php echo $this->language->get('button_wishlist'); ?></a>
					<a class="prdbt compare" onclick="addToCompare('<?php echo $product['product_id']; ?>');" title="<?php echo $this->language->get('button_compare'); ?>"><?php echo $this->language->get('button_compare'); ?></a>
				</span>
			</div>
		</div>
	</div>
</div>