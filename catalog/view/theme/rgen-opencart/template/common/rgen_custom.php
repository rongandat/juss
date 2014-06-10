<?php if(isset($RGen_custom[$mod_id]['style'])){ ?>
	<?php if($RGen_custom[$mod_id]['style'] == 'cust1'){ ?>
	<div class='custom1<?php if($RGen_custom[$mod_id]['class'] != ''){ ?> <?php echo $RGen_custom[$mod_id]['class']; ?><?php } ?>'>
		<?php if($RGen_custom[$mod_id]['title'][$l_id] != ''){ ?>
		<h2 class='header-1'><?php echo $RGen_custom[$mod_id]['title'][$l_id]; ?></h2>
		<?php } ?>	
		<?php echo html_entity_decode($RGen_custom[$mod_id]['description'][$l_id], ENT_QUOTES, 'UTF-8'); ?>
	</div>
	<?php } ?>
	<?php if($RGen_custom[$mod_id]['style'] == 'cust2'){ ?>
	<div class='custom2<?php if($RGen_custom[$mod_id]['class'] != ''){ ?> <?php echo $RGen_custom[$mod_id]['class']; ?><?php } ?>'>
		<?php if($RGen_custom[$mod_id]['title'][$l_id] != ''){ ?>
		<h2 class='header-1'><?php echo $RGen_custom[$mod_id]['title'][$l_id]; ?></h2>
		<?php } ?>	
		<?php echo html_entity_decode($RGen_custom[$mod_id]['description'][$l_id], ENT_QUOTES, 'UTF-8'); ?>
	</div>
	<?php } ?>
	<?php if($RGen_custom[$mod_id]['style'] == 'cust3'){ ?>
	<div class='custom3<?php if($RGen_custom[$mod_id]['class'] != ''){ ?> <?php echo $RGen_custom[$mod_id]['class']; ?><?php } ?>'>
		<?php if($RGen_custom[$mod_id]['title'][$l_id] != ''){ ?>
		<h2 class='header-1'><?php echo $RGen_custom[$mod_id]['title'][$l_id]; ?></h2>
		<?php } ?>
		<?php echo html_entity_decode($RGen_custom[$mod_id]['description'][$l_id], ENT_QUOTES, 'UTF-8'); ?>
	</div>
	<?php } ?>
<?php } ?>