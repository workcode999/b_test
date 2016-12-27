<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
   <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-creditcard" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
      <h1><?php echo $heading_title; ?></h1>
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></li>
    <?php } ?>
  </ul>
  </div>
  </div>
   <div class="container-fluid">
    <?php if ($error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    
<div class="panel panel-default">
      
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-creditcard" class="form-horizontal">
         <div class="form-group required">
		      <label class="col-sm-2 control-label" for="input-merchant"><?php echo $entry_merchantid; ?></label>
              <div class="col-sm-10">
              <input type="text" name="creditcard_merchant" value="<?php echo $creditcard_merchant; ?>" placeholder="<?php echo $entry_merchantid; ?>" id="input-merchant" class="form-control" />
              <?php if ($error_merchant) { ?>
              <div class="text-danger"><?php echo $error_merchant; ?></div>
              <?php } ?>
              </div>
         </div>
	     <div class="form-group required">
		      <label class="col-sm-2 control-label" for="input-gatewayno"><?php echo $entry_gatewayno; ?></label>
              <div class="col-sm-10">
              <input type="text" name="creditcard_gatewayno" value="<?php echo $creditcard_gatewayno; ?>" placeholder="<?php echo $entry_gatewayno; ?>" id="input-gatewayno" class="form-control" />
              <?php if ($error_gatewayno) { ?>
              <div class="text-danger"><?php echo $error_gatewayno; ?></div>
              <?php } ?>
              </div>
          </div>
          <div class="form-group required">
		      <label class="col-sm-2 control-label" for="input-signkey"><?php echo $entry_signkey; ?></label>
              <div class="col-sm-10">
              <input type="text" name="creditcard_signkey" value="<?php echo $creditcard_signkey; ?>" placeholder="<?php echo $entry_signkey; ?>" id="input-signkey" class="form-control" />
              <?php if ($error_signkey) { ?>
              <div class="text-danger"><?php echo $error_signkey; ?></div>
              <?php } ?>
              </div>
          </div>
		  <div class="form-group">
            <label class="col-sm-2 control-label" for="input-gateway"><?php echo $entry_gateway; ?></label>
            <div class="col-sm-10">
            
              <select name="creditcard_gateway" id="input-gateway" class="form-control">
                  <?php if ($creditcard_gateway == $text_really) { ?>
                  <option value="<?php echo $text_really; ?>" selected="selected"><?php echo $text_really; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $text_really; ?>"><?php echo $text_really; ?></option>
                  <?php } ?>

                  <?php if ($creditcard_gateway == $text_test) { ?>
                  <option value="<?php echo $text_test; ?>" selected="selected"><?php echo $text_test; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $text_test; ?>"><?php echo $text_test; ?></option>
                  <?php } ?>
                </select>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-order-status"><?php echo $entry_order_status; ?></label>
            <div class="col-sm-10">
              <select name="creditcard_order_status_id" id="input-order-status" class="form-control">
                <?php foreach ($order_statuses as $order_status) { ?>
                <?php if ($order_status['order_status_id'] == $creditcard_order_status_id) { ?>
                <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                <?php } ?>
                <?php } ?>
              </select>
            </div>
          </div>
    	  <div class="form-group">
              <label class="col-sm-2 control-label" for="input-success-order-status"><?php echo $entry_success_order_status; ?></label>
			  <div class="col-sm-10">
              <select name="creditcard_success_order_status_id" id="input-success-order-status" class="form-control">
                  <?php foreach ($order_statuses as $order_status) { ?>
                  <?php if ($order_status['order_status_id'] == $creditcard_success_order_status_id) { ?>
                  <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select>
            </div>
          </div>
          <div class="form-group">
              <label class="col-sm-2 control-label" for="input-failed-order-status"><?php echo $entry_failed_order_status; ?></label>
			  <div class="col-sm-10">
              <select name="creditcard_failed_order_status_id" id="input-failed-order-status" class="form-control">
                  <?php foreach ($order_statuses as $order_status) { ?>
                  <?php if ($order_status['order_status_id'] == $creditcard_failed_order_status_id) { ?>
                  <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-geo-zone"><?php echo $entry_geo_zone; ?></label>
            <div class="col-sm-10">
              <select name="creditcard_geo_zone_id" id="input-geo-zone" class="form-control">
                <option value="0"><?php echo $text_all_zones; ?></option>
                <?php foreach ($geo_zones as $geo_zone) { ?>
                <?php if ($geo_zone['geo_zone_id'] == $creditcard_geo_zone_id) { ?>
                <option value="<?php echo $geo_zone['geo_zone_id']; ?>" selected="selected"><?php echo $geo_zone['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $geo_zone['geo_zone_id']; ?>"><?php echo $geo_zone['name']; ?></option>
                <?php } ?>
                <?php } ?>
              </select>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
            <div class="col-sm-10">
              <select name="creditcard_status" id="input-status" class="form-control">
                <?php if ($creditcard_status) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-sort-order"><?php echo $entry_sort_order; ?></label>
            <div class="col-sm-10">
              <input type="text" name="creditcard_sort_order" value="<?php echo $creditcard_sort_order; ?>" placeholder="<?php echo $entry_sort_order; ?>" id="input-sort-order" class="form-control" />
            </div>
          </div>
        </form>
      </div>
      </div>
  </div>
</div>
<?php echo $footer; ?>
