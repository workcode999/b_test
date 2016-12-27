<?php if ($modules) { ?>
<style>
@media (max-width:1199px){
	#content{margin-top:8px !important;}
}
#content{margin-top:18px;}
</style>
<column id="column-left" class="col-sm-3 hidden-xs">
  <?php foreach ($modules as $module) { ?>
  <?php echo $module; ?>
  <?php } ?>
</column>
<?php } ?>