<table class="table table-bordered">
  <thead>
    <tr>
      <td class="text-left"></td>
	  <td class="text-left"><?php echo $column_email; ?></td>
      <td class="text-left"><?php echo $column_date_added; ?></td>
      <td class="text-left"><?php echo $column_order_id; ?></td>
      <td class="text-left"><?php echo $column_product; ?></td>
      <td class="text-left"><?php echo $column_coupon; ?></td>
      <td class="text-left"><?php echo $column_date_review; ?></td>
	  <td class="text-center"></td>
    </tr>
  </thead>
  <tbody>
    <?php if ($histories) { ?>
    <?php foreach ($histories as $history) { ?>
    <tr>
      <td class="text-left">#<?php echo $history['email_id']; ?></td>
	  <td class="text-left"><?php echo $history['email'] . $history['test']; ?></td>
      <td class="text-left"><?php echo $history['date_added']; ?></td>
      <td class="text-left"><?php echo $history['order_id']; ?></td>
      <td class="text-left"><?php if ($history['product']) { ?>
	    <table class="table table-bordered" style="margin-bottom:0;">
	      <tbody>
	        <?php foreach ($history['product'] as $product) { ?>
	        <tr>
	          <td class="text-left"><?php echo $product['name']; ?></td>
	        </tr>
	        <?php } ?>
	      </>
	    </table>
		<?php } ?></td>
	  <td class="text-left"><?php echo $history['coupon']; ?></td>
	  <td class="text-left"><?php echo $history['date_review']; ?></td>
	  <td class="text-right"><a href="<?php echo $history['view']; ?>" target="_blank" data-toggle="tooltip" title="<?php echo $button_view; ?>" class="btn btn-info"><i class="fa fa-link"></i></a> <a id="button-email-remove" data-toggle="tooltip" data-email-id="<?php echo $history['email_id']; ?>" title="<?php echo $button_delete; ?>" class="btn btn-danger"><i class="fa fa-trash-o"></i></a></td>
    </tr>
    <?php } ?>
    <?php } else { ?>
    <tr>
      <td class="text-center" colspan="8"><?php echo $text_no_results; ?></td>
    </tr>
    <?php } ?>
  </tbody>
</table>
<div class="row">
  <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
  <div class="col-sm-6 text-right"><?php echo $results; ?></div>
</div>