<?php 
require_once 'catalog/view/theme/rgen-opencart/template/common/Mobile_Detect.php' ;
$detect = new Mobile_Detect();
if ($detect->isTablet() || !$detect->isMobile()) { 
if ($modules) { ?>
<div id="column-left" class="column">
  <?php foreach ($modules as $module) { ?>
  <?php echo $module; ?>
  <?php } ?>
</div>
<?php } } ?> 
