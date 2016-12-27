<div class="panelhead hidden-xs">Refine by</div>
<div class="panel-heading">	
	<button class="btn btn-primary filterBack">Back</button>
	<button type="button" id="button-filter" class="btn btn-primary">Filter</button>
</div>
	<div class="myfilter">
		<div class="addP">
			<p class="ClearAlla"><a href="<?php echo $action; ?>">Clear All</a></p>
			<?php if(isset($_GET['area'])){ 
						foreach($price_range as $ka=>$va){
							if($_GET['area'] == $va['values']){
								echo '<p>
								<a class="addinputA" href='. $remove_area.'>'.$va['name'].' <i class="fa fa-times deltimes"></i></a>
								</p>';
							}
						}
					}
			?>

		</div>
		<!-- XSP: add -->
		<?php if(!empty($price_range)){ ?>
			<div class="filterdiv">
				<div class="filtername"><a>Price</a><i class="fa fa-angle-down hidden-sm"></i></div>
				<div class="filtertrem tremradio">
					<?php foreach($price_range as $k=>$v) { ?>
						<?php if($v['count'] !=0){ ?>
							<a href="<?php echo $v['href'];?>">
								<label class="checkbox">
								<?php echo $v['name']?>
								</label>
							</a>
						<?php } ?>
					<?php } ?>
				</div>      
			</div>
		<?php } ?>
		<!-- XSP: end -->
		<?php if(!empty($filter_groups)){?>
			<?php foreach ($filter_groups as $filter_group) { ?>
				<div class="filterdiv">
					<div class="filtername"><a><?php echo $filter_group['name']; ?></a><i class="fa fa-angle-down hidden-sm"></i></div>
					<div class="filtertrem">
				 
						<?php foreach ($filter_group['filter'] as $filter) { ?>
							<?php if (in_array($filter['filter_id'], $filter_category)) { ?>
								<a><label class="checkbox">
									<input name="filter[]" type="checkbox" value="<?php echo $filter['filter_id']; ?>" checked="checked" />
									<?php echo $filter['name']; ?><span>(<?php echo $filter['filter_count'];?>)</label>
								 </a>

							<?php } else { ?>
								<a><label class="checkbox">
									<input name="filter[]" type="checkbox" value="<?php echo $filter['filter_id']; ?>" />
									<?php echo $filter['name']; ?><span>(<?php echo $filter['filter_count'];?>)</label>
								</a>
							<?php } ?>
						<?php } ?>
					
					</div>
				</div>
			<?php } ?>
		<?php } ?>
	</div>
<script type="text/javascript">
$('#button-filter').on('click', function() {
	filter = [];
	
	$('input[name^=\'filter\']:checked').each(function(element) {
		filter.push(this.value);
	});

	if(filter.length == ''){
		location = '<?php echo $action; ?>';
	}else{
		location = '<?php echo $action; ?>&filter=' + filter.join(',');
	}
});


</script> 
