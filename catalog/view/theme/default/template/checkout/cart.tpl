<?php echo $header; ?>
<div class="container">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
  <?php if ($attention) { ?>
  <div class="alert alert-info"><i class="fa fa-info-circle"></i> <?php echo $attention; ?>
    <button type="button" class="close" data-dismiss="alert">&times;</button>
  </div>
  <?php } ?>
  <?php if ($success) { ?>
  <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
    <button type="button" class="close" data-dismiss="alert">&times;</button>
  </div>
  <?php } ?>
  <?php if ($error_warning) { ?>
  <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
    <button type="button" class="close" data-dismiss="alert">&times;</button>
  </div>
  <?php } ?>
  <div class="row"><?php echo $column_left; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-sm-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-sm-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-sm-12'; ?>
    <?php } ?>
    <div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>
      <h1><?php echo $heading_title; ?>
        <?php if ($weight) { ?>
        &nbsp;(<?php echo $weight; ?>)
        <?php } ?>
      </h1>
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
        <div class="table-responsive">
          <table class="table table-bordered" style="overflow:hidden;">
            <thead>
              <tr>
				<td class="text-center cart-title"><?php echo $column_image; ?></td>
				<td class="text-left cart-title" style="padding-left:8px;width:50%;"><?php echo $column_name; ?></td>
				<td class="text-left cart-title noneCartTiter"><?php echo $column_price; ?></td>
              </tr>
            </thead>
            <tbody>
              <?php foreach ($products as $product) { ?>
              <tr>
                <td class="text-center" style="vertical-align: middle"><?php if ($product['thumb']) { ?>
                  <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" /></a>
                  <?php } ?></td>
                <td class="text-left textLeftChange"><span><a href="<?php echo $product['href']; ?>">Item #: <?php echo $product['model']; ?></a></span>
                  <?php if (!$product['stock']) { ?>
                  <span class="text-danger">***</span>
                  <?php } ?>
                  <?php if ($product['option']) { ?>
				<?php foreach ($product['option'] as $option) { ?>
			    <?php if ($option['name'] == 'Estimated Delivery Date') { ?>				  
                  <span><br><?php echo $option['name']; ?>: <br /><?php echo $option['value']; ?></span>
				<?php } else { ?>
				  <br>
				  <span><?php echo $option['name']; ?>: <?php echo $option['value']; ?><?php if($option['custom_values']){ ?><br/>
				  -<?php echo $text_bust; ?>: <b><?php echo stripslashes($option['custom_values']['Bust']); ?></b> inch <br/>-<?php echo $text_waist; ?>: <b><?php echo stripslashes($option['custom_values']['Waist']); ?></b> inch <br/>-<?php echo $text_hip; ?>: <b><?php echo stripslashes($option['custom_values']['Hip']); ?></b> inch <br/>-<?php echo $text_hollow; ?>: <b><?php echo stripslashes($option['custom_values']['Hollow']); ?></b> inch <br/>-<?php echo $text_height; ?>: <b><?php echo stripslashes($option['custom_values']['Height']); ?></b> inch
				   <?php if($option['custom_values']['remarks'] && !empty($option['custom_values']['remarks'])) {?><br><span class="liuyan"><?php echo $text_remarks; ?>: <br><?php echo stripslashes($option['custom_values']['remarks']); ?></span><?php } ?>
				  <?php }  ?></span>
			    <?php }  ?>				  
                  <?php } ?>
                  <?php } ?>
                  <?php if ($product['recurring']) { ?>
                  <br />
                  <span class="label label-info"><?php echo $text_recurring_item; ?></span> <small><?php echo $product['recurring']; ?></small>
                  			<?php } ?>
			<div class="input-group btn-block" style="max-width: 100px;margin-top: 5px;">
				<span class="input-group-btn">
				<button class="btn cart-min"><i class="fa">-</i></button>
				<input type="text" name="quantity[<?php echo $product['key']; ?>]" value="<?php echo $product['quantity']; ?>" size="1" class="cart-input"  />
				<button class="btn cart-max"><i class="fa">+</i></button>
				<!--<button type="submit" data-toggle="tooltip" title="<//?php echo $button_update; ?>" class="btn btn-primary"><i class="fa fa-refresh"></i></button>-->
				<button type="button" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn-link cart-danger" onclick="cart.remove('<?php echo $product['key']; ?>');">Remove</button>
				</span>
			</div>
			<div id="noneDiv">
				<p  class="price-old"><?php echo $product['list_price']; ?></p>
				<p  class="price-new"><?php echo $product['price']; ?></p>
				<p  class="save">Save <?php echo $product['save']; ?></p>
				<p  class="off"><?php echo $product['off']; ?>% OFF</p>
			</div>
		</td>
				<td id="noneTextLeft" class="text-left">
					<p class="price-old"><?php echo $product['list_price']; ?></p>
					<p class="price-new"><?php echo $product['price']; ?></p>
					<p class="save">Save <?php echo $product['save']; ?></p>
					<p class="off"><?php echo $product['off']; ?>% OFF</p>
				</td>
              </tr>
              <?php } ?>
              <?php foreach ($vouchers as $vouchers) { ?>
              <tr>
                <td></td>
                <td class="text-left"><?php echo $vouchers['description']; ?></td>
                <td class="text-left"></td>
                <td class="text-left"><div class="input-group btn-block" style="max-width: 200px;">
                    <input type="text" name="" value="1" size="1" disabled="disabled" class="form-control" />
                    <span class="input-group-btn"><button type="button" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger" onclick="voucher.remove('<?php echo $vouchers['key']; ?>');"><i class="fa fa-times-circle"></i></button></span></div></td>
                <td class="text-right"><?php echo $vouchers['amount']; ?></td>
                <td class="text-right"><?php echo $vouchers['amount']; ?></td>
              </tr>
              <?php } ?>
            </tbody>
			<?php foreach ($totals as $total) { ?>
				<?php if($total['title'] == 'Total') { ?>
					<tfoot><tr><td class="total-save" colspan="3">YOUR TOTAL SAVINGS: <span>-<?php echo $total['text_save']; ?></span></td></tr></tfoot>
				<?php } ?>
			<?php } ?>
          </table>
        </div>
      </form>
      <div class="row">
        <div class="col-sm-4 col-sm-offset-8">
          <table class="table table-bordered">
            <?php foreach ($totals as $total) { ?>
            <tr>
              <td class="text-right"><?php echo $total['title']; ?>:</td>
              <td class="text-right"><?php if($total['title'] == 'Total'){  ?><strong><?php echo $total['text']; ?></strong><?php } else{  ?> <?php echo $total['text']; ?><?php } ?></td>
            </tr>
            <?php } ?>
          </table>
        </div>
      </div>
      <div class="buttons">
        <div class="pull-left"><a href="<?php echo $continue; ?>" class="btn btn-default"><?php echo $button_shopping; ?></a></div>
        <div class="pull-right"><a href="<?php echo $checkout; ?>" class="btn btn-primary"><?php echo $button_checkout; ?></a></div>
      </div>
      <?php echo $content_bottom; ?></div>
    <?php echo $column_right; ?></div>
</div>
<?php echo $footer; ?> 
