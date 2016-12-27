<?php if (count($currencies) > 1) { ?>			
<div id="currency-none" class="col-sm-3">			
	<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="currency">				
		<?php 	foreach ($currencies as $currency) { ?>				
		<?php if ($currency['symbol_left'] && $currency['code'] == $code) { ?>				
		<h5><?php echo $currency['symbol_left']; ?>&nbsp&nbsp<i class="fa fa-angle-down"></i></h5>	
		<?php } elseif ($currency['symbol_right'] && $currency['code'] == $code) { ?>				<?php } ?>				<?php } ?>							
		<ul class="list-unstyled">				 
			<?php foreach ($currencies as $currency) { ?>				  <?php if ($currency['symbol_left']) { ?>				  
			<li><a class="currency-select"  name="<?php echo $currency['code']; ?>"><?php echo $currency['title']; ?>&nbsp&nbsp<?php echo $currency['symbol_left']; ?></a></li>				  
			<?php } else { ?>				
			<li><a class="currency-select"  name="<?php echo $currency['code']; ?>"><?php echo $currency['title']; ?>&nbsp&nbsp<?php echo $currency['symbol_right']; ?></a></li>			
			<?php } ?>				  <?php } ?>				
			<input type="hidden" name="code" value="" />				
			<input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />			 
		</ul>			
	</form>			
</div>			
<?php } ?>
