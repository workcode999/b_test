<?php if(!empty($isBestActive)) { ?>
	<script type="text/javascript">
	$(document).ready(function(){
		$('#payment .pull-right').removeClass('pull-right');
		$('#payment .btn-primary').addClass('btn-success mybutton');
		$('#payment .btn-primary').parent().addClass('paddingb');
		$('#payment .right .button').addClass('btn btn-success mybutton');
		$('#payment .right .button').parent().addClass('paddingb');
		$('#payment .right .button').removeClass('button');
		$('#payment .btn-primary').removeClass('btn-primary');
		$('#payment input[type=\'button\']').wrapAll('<h3>');
	});
	</script>
<?php } ?>
<?php if (!isset($redirect)) { ?>
<div class="table-responsive">
  <table class="table table-bordered table-hover">
    <thead>
      <tr>
        <td class="text-left"><?php echo $column_name; ?><span id="cartEdit"><a href="index.php?route=checkout/cart">Edit</a></span></td>
		<td class="text-right"><?php echo $column_quantity; ?></td>
		<td class="text-right"><?php echo $column_price; ?></td>
      </tr>
    </thead>
    <tbody>
      <?php foreach ($products as $product) { ?>
      <tr>
        <td class="text-left">Item #: <?php echo $product['model']; ?>
			 <?php foreach ($product['option'] as $option) { ?>
			    <?php if ($option['name'] == 'Estimated Delivery Date') { ?>
                  <span><br><?php echo $option['name']; ?>: <br /><?php echo $option['value']; ?></span>				  
				<?php } else { ?>
				  <br />
				  <span><?php echo $option['name']; ?>: <?php echo $option['value']; ?><?php if($option['custom_values']){ ?>
				  <br/>-<?php echo $text_bust; ?>: <b><?php echo stripslashes($option['custom_values']['Bust']); ?></b> inch <br/>-<?php echo $text_waist; ?>: <b><?php echo stripslashes($option['custom_values']['Waist']); ?></b> inch <br/>-<?php echo $text_hip; ?>: <b><?php echo stripslashes($option['custom_values']['Hip']); ?></b> inch <br/>-<?php echo $text_hollow; ?>: <b><?php echo stripslashes($option['custom_values']['Hollow']); ?></b> inch <br/>-<?php echo $text_height; ?>: <b><?php echo stripslashes($option['custom_values']['Height']); ?></b> inch
				  <?php if(isset($option['custom_values']['remarks']) && !empty($option['custom_values']['remarks'])){ ?><span class="scrollP"><?php echo $text_remarks; ?>: <br><?php echo stripslashes($option['custom_values']['remarks']); ?></span><?php } ?>
				  <?php }  ?></span>
				<?php }  ?>	
          <?php } ?>
          <?php if($product['recurring']) { ?>
          <br />
          <span class="label label-info"><?php echo $text_recurring_item; ?></span> <small><?php echo $product['recurring']; ?></small>
          <?php } ?></td>
		<td class="text-right"><?php echo $product['quantity']; ?></td>
		<td class="text-right"><?php echo $product['price']; ?></td>
      </tr>
      <?php } ?>
      <?php foreach ($vouchers as $voucher) { ?>
      <tr>
        <td class="text-left"><?php echo $voucher['description']; ?></td>
        <td class="text-left"></td>
        <td class="text-right">1</td>
        <td class="text-right"><?php echo $voucher['amount']; ?></td>
        <td class="text-right"><?php echo $voucher['amount']; ?></td>
      </tr>
      <?php } ?>
    </tbody>
    <tfoot>
      <?php foreach ($totals as $total) { ?>
      <tr>
        <td colspan="2" class="text-right"><?php echo $total['title']; ?>:</td>
        <td class="text-right"><strong><?php echo $total['text']; ?></strong></td>
      </tr>
      <?php } ?>
    </tfoot>
  </table>
</div>
<?php echo $payment; ?>
<?php } else { ?>
<script type="text/javascript"><!--
location = '<?php echo $redirect; ?>';
//--></script>
<?php } ?>
