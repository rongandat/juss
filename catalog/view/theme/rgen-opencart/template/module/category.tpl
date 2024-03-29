<div class="box category-links">
	<div class="box-heading header-3"><?php echo $heading_title; ?></div>
	<div class="box-content">
		<div class="box-category col-links">
			<ul>
				<?php foreach ($categories as $category) { ?>
				<?php if ($category['category_id'] == $category_id) { ?>
				<li class="cat-active">
					<a href="<?php echo $category['href']; ?>" class="active"><?php echo $category['name']; ?></a>
				<?php } else { ?>
				<li>
					<a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a>
					<?php } ?>
					<?php if ($category['children']) { ?>
					<b class="cc"></b>
					<ul class="col-subcat">
						<?php foreach ($category['children'] as $child) { ?>
						<li>
							<?php if ($child['category_id'] == $child_id) { ?>
							<a href="<?php echo $child['href']; ?>" class="active"><?php echo $child['name']; ?></a>
							<?php } else { ?>
							<a href="<?php echo $child['href']; ?>"><?php echo $child['name']; ?></a>
							<?php } ?>
						</li>
						<?php } ?>
					</ul>
					<?php } ?>
				</li>
				<?php } ?>
			</ul>
		</div>
	</div>
</div>
