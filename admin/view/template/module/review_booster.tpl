<?php echo $header; ?><?php echo $column_left; ?>
<?php $bGljZW5zZV9kZXRhaWw = json_decode(base64_decode($license), true); ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a>
      </div>
      <h1><?php echo $heading_title; ?></h1>
    </div>
  </div>
  <div class="container-fluid">
    <?php if ($error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <?php if ($success) { ?>
    <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
	<?php if (!isset($bGljZW5zZV9kZXRhaWw['status']) || !$bGljZW5zZV9kZXRhaWw['status']) { ?>
	<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> Module does not have a license key, activate (<a onClick="$('a[href=\'#tab-support\']').click();" class="btn-link">click here</a>) it to gain free access for updates and support system.
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
	<?php } ?>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $heading_title; ?></h3>
		<div class="pull-right"><select onChange="location.href = this.value">
	    <?php foreach ($stores as $store) { ?>
		<?php if ($store['store_id'] == $filter_store_id) { ?>
		<option value="<?php echo $store['href']; ?>" selected="selected"><?php echo $store['name']; ?></option>
		<?php } else { ?>
		<option value="<?php echo $store['href']; ?>"><?php echo $store['name']; ?></option>
		<?php } ?>
		<?php } ?>
	    </select></div>
      </div>
      <div class="panel-body">
        <div class="alert alert-info">The following line should be added to the CRON, if you want automatically send notification. <a href="http://www.youtube.com/watch?v=ibcE3BrUKpw" target="_blank">How to set cron job in directadmin</a>?<br /><b>wget -q -O - <?php echo $cron; ?></b><br />or<br /><b>wget -q <?php echo $cron; ?></b><br />or<br /><b>wget -q "<?php echo $cron; ?>"</b><br /><br />If you have a problem to set the cron job on your own server, please use setcronjob.com or easycron.com and use following the url.<br /><b><?php echo $cron; ?></b>
          <button type="button" class="close" data-dismiss="alert">&times;</button>
        </div>
		<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-review-booster" class="form-horizontal">
          <ul class="nav nav-tabs" id="general-tabs">
            <li class="active"><a href="#tab-general" data-toggle="tab"><?php echo $tab_general; ?></a></li>
			<li><a href="#tab-history" data-toggle="tab"><?php echo $tab_history; ?></a></li>
            <li><a href="#tab-support" data-toggle="tab">Support</a></li>
          </ul>
		  <div class="tab-content">
		    <div class="tab-pane active in" id="tab-general">
			  <div class="form-group">
                <label class="col-sm-2 control-label" for="input-module-status"><?php echo $entry_module_status; ?></label>
                <div class="col-sm-7">
                  <select name="review_booster[status]" id="input-module-status" class="form-control">
                    <?php if ($status == 1) { ?>
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
                <label class="col-sm-2 control-label s_help" for="input-order-status"><?php echo $entry_order_status; ?><b><?php echo $help_order_status; ?></b></label>
                <div class="col-sm-7">
                  <select name="review_booster[order_status][]" multiple id="input-order-status" class="form-control" style="height: 150px;">
                    <?php foreach ($order_statuses as $status) { ?>
                    <?php if (in_array($status['order_status_id'], $order_status)) { ?>
                    <option value="<?php echo $status['order_status_id']; ?>" selected="selected"><?php echo $status['name']; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $status['order_status_id']; ?>"><?php echo $status['name']; ?></option>
                    <?php } ?>
                    <?php } ?>
                  </select>
				  <div style="padding-top: 4px; font-size: 11px; color: #666666;"><?php echo $text_multiselect; ?></div>
				  <?php if (isset($error['order_status'])) { ?>
				  <div class="text-danger"><?php echo $error['order_status']; ?></div>
				  <?php } ?>
                </div>
              </div>
			  <div class="form-group">
                <label class="col-sm-2 control-label s_help" for="input-new-order-status"><?php echo $entry_new_order_status; ?><b><?php echo $help_new_order_status; ?></b></label>
                <div class="col-sm-4">
                  <select name="review_booster[new_order_status]" id="input-new-order-status" class="form-control">
                    <option value="0"><?php echo $text_none; ?></option>
					<?php foreach ($order_statuses as $status) { ?>
                    <?php if ($status['order_status_id'] == $new_order_status) { ?>
                    <option value="<?php echo $status['order_status_id']; ?>" selected="selected"><?php echo $status['name']; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $status['order_status_id']; ?>"><?php echo $status['name']; ?></option>
                    <?php } ?>
                    <?php } ?>
                  </select>
                </div>
				<div class="col-sm-3">
				  <?php if ($notify) { ?>
				  <input type="checkbox" name="review_booster[notify]" value="1" id="input-notify" checked />
				  <?php } else { ?>
				  <input type="checkbox" name="review_booster[notify]" value="1" id="input-notify" />
				  <?php } ?>  
				  <?php echo $entry_notify; ?>
				</div>
              </div>
			  <div class="form-group">
                <label class="col-sm-2 control-label s_help" for="input-exclude-customer-group"><?php echo $entry_exclude_customer_group; ?><b><?php echo $help_exclude_customer_group; ?></b></label>
                <div class="col-sm-7">
                  <select name="review_booster[exclude_customer_group][]" multiple id="input-exclude-customer-group" class="form-control">
                    <?php foreach ($customer_groups as $group) { ?>
                    <?php if (in_array($group['customer_group_id'], $exclude_customer_group)) { ?>
                    <option value="<?php echo $group['customer_group_id']; ?>" selected="selected"><?php echo $group['name']; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $group['customer_group_id']; ?>"><?php echo $group['name']; ?></option>
                    <?php } ?>
                    <?php } ?>
                  </select>
				  <div style="padding-top: 4px; font-size: 11px; color: #666666;"><?php echo $text_multiselect; ?></div>
                </div>
              </div>
			  <div class="form-group">
                <label class="col-sm-2 control-label s_help" for="input-day"><?php echo $entry_day; ?><b><?php echo $help_day; ?></b></label>
				<div class="col-sm-3">
                  <div class="input-group">
					<input type="text" name="review_booster[day]" value="<?php echo $day; ?>" placeholder="<?php echo $entry_day; ?>" id="input-day" class="form-control" />
					<span class="input-group-addon"><?php echo $text_day; ?></span>
				  </div>
				  <?php if (isset($error['day'])) { ?>
				  <div class="text-danger"><?php echo $error['day']; ?></div>
				  <?php } ?>
                </div>
				<label class="col-sm-2 control-label s_help" for="input-previous"><?php echo $entry_previous; ?><b><?php echo $help_previous; ?></b></label>
				<div class="col-sm-2">
                  <select name="review_booster[previous]" id="input-previous" class="form-control">
                    <?php if ($previous) { ?>
                    <option value="1" selected="selected"><?php echo $text_yes; ?></option>
                    <option value="0"><?php echo $text_no; ?></option>
                    <?php } else { ?>
                    <option value="1"><?php echo $text_yes; ?></option>
                    <option value="0" selected="selected"><?php echo $text_no; ?></option>
                    <?php } ?>
                  </select>
				</div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label s_help" for="input-type"><?php echo $entry_type; ?><b><?php echo $help_type; ?></b></label>
                <div class="col-sm-7">
                  <select name="review_booster[type]" id="input-type" class="form-control">
                    <?php if ($type == 'order') { ?>
                    <option value="order" selected="selected"><?php echo $text_per_order; ?></option>
                    <option value="product"><?php echo $text_per_product; ?></option>
                    <option value="product_single"><?php echo $text_per_product_single; ?></option>
                    <?php } elseif ($type == 'product') { ?>
                    <option value="order"><?php echo $text_per_order; ?></option>
                    <option value="product" selected="selected"><?php echo $text_per_product; ?></option>
                    <option value="product_single"><?php echo $text_per_product_single; ?></option>
                    <?php } else { ?>
                    <option value="order"><?php echo $text_per_order; ?></option>
                    <option value="product"><?php echo $text_per_product; ?></option>
                    <option value="product_single" selected="selected"><?php echo $text_per_product_single; ?></option>
                    <?php } ?>
                  </select>
                  <?php if (isset($error['type'])) { ?>
                  <div class="text-danger"><?php echo $error['type']; ?></div>
                  <?php } ?>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-product-image-status"><?php echo $entry_product_image_status; ?></label>
                <div class="col-sm-1">
                  <select name="review_booster[product_image_status]" id="input-product-image-status" class="form-control">
                    <?php if ($product_image_status) { ?>
                    <option value="1" selected="selected"><?php echo $text_yes; ?></option>
                    <option value="0"><?php echo $text_no; ?></option>
                    <?php } else { ?>
                    <option value="1"><?php echo $text_yes; ?></option>
                    <option value="0" selected="selected"><?php echo $text_no; ?></option>
                    <?php } ?>
                  </select>
                </div>
                <div class="col-sm-3">
                    <input type="text" name="review_booster[product_image_width]" value="<?php echo $product_image_width; ?>" placeholder="<?php echo $entry_width; ?>" class="form-control" />
                </div>
                <div class="col-sm-3">
                    <input type="text" name="review_booster[product_image_height]" value="<?php echo $product_image_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label s_help" for="input-product-limit"><?php echo $entry_product_limit; ?><b><?php echo $help_product_limit; ?></b></label>
                <div class="col-sm-7">
                  <input type="text" name="review_booster[product_limit]" value="<?php echo $product_limit; ?>" placeholder="<?php echo $entry_product_limit; ?>" id="input-product-limit" class="form-control" />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label s_help" for="input-verified-buyer-status"><?php echo $entry_verified_buyer_status; ?><b><?php echo $help_verified_buyer_status; ?></b></label>
                <div class="col-sm-7">
                  <select name="review_booster[verified_buyer_status]" id="input-verified-buyer-status" class="form-control">
                    <?php if ($verified_buyer_status) { ?>
                    <option value="1" selected="selected"><?php echo $text_yes; ?></option>
                    <option value="0"><?php echo $text_no; ?></option>
                    <?php } else { ?>
                    <option value="1"><?php echo $text_yes; ?></option>
                    <option value="0" selected="selected"><?php echo $text_no; ?></option>
                    <?php } ?>
                  </select>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label s_help" for="input-coupon-status"><?php echo $entry_coupon_status; ?><b><?php echo $help_coupon_status; ?></b></label>
                <div class="col-sm-7">
                  <select name="review_booster[coupon_status]" id="input-coupon-status" class="form-control">
                    <option value="0"><?php echo $text_no; ?></option>
					<?php if ($coupon_status == 'percentage') { ?>
					<option value="percentage" selected="selected"><?php echo $text_percentage; ?></option>
					<?php } else { ?>
					<option value="percentage"><?php echo $text_percentage; ?></option>
					<?php } ?>
					<?php if ($coupon_status == 'fixed') { ?>
					<option value="fixed" selected="selected"><?php echo $text_fixed; ?></option>
					<?php } else { ?>
					<option value="fixed"><?php echo $text_fixed; ?></option>
					<?php } ?>
                  </select>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-coupon-discount"><?php echo $entry_coupon_discount; ?></label>
                <div class="col-sm-3">
				  <div class="input-group">
				    <span class="input-group-addon"><?php echo $entry_coupon_value; ?></span>
					<input type="text" name="review_booster[coupon_discount]" value="<?php echo $coupon_discount; ?>" placeholder="<?php echo $entry_coupon_value; ?>" id="input-coupon-discount" class="form-control" />
				  </div>
				</div>
				<div class="col-sm-4">
				  <div class="input-group">
				    <span class="input-group-addon"><?php echo $entry_coupon_validity; ?></span>
					<input type="text" name="review_booster[coupon_validity]" value="<?php echo $coupon_validity; ?>" placeholder="<?php echo $entry_coupon_validity; ?>" id="input-coupon-validity" class="form-control" />
					<span class="input-group-addon"><?php echo $text_day; ?></span>
				  </div>
				</div>
              </div>
			  <div class="form-group">
                <label class="col-sm-2 control-label" for="input-star"><?php echo $entry_star; ?></label>
                <div class="col-sm-3">
                  <select name="review_booster[star]" id="input-star" class="form-control">
                    <?php foreach ($stars as $key => $name) { ?>
					<?php if ($key == $star) { ?>
                    <option value="<?php echo $key; ?>" selected="selected"><?php echo $name; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $key; ?>"><?php echo $name; ?></option>
                    <?php } ?>
					<?php } ?>
                  </select>
                </div>
				<label class="col-sm-2 control-label s_help" for="input-image-type"><?php echo $entry_image_type; ?><b><?php echo $help_image_type; ?></b></label>
                <div class="col-sm-2">
                  <select name="review_booster[image_type]" id="input-image-type" class="form-control">
                    <?php if ($image_type) { ?>
                    <option value="1" selected="selected"><?php echo $text_yes; ?></option>
                    <option value="0"><?php echo $text_no; ?></option>
                    <?php } else { ?>
                    <option value="1"><?php echo $text_yes; ?></option>
                    <option value="0" selected="selected"><?php echo $text_no; ?></option>
                    <?php } ?>
                  </select>
                </div>
              </div>
			  <div class="form-group">
                <label class="col-sm-2 control-label s_help" for="input-noticed-status"><?php echo $entry_noticed_status; ?><b><?php echo $help_noticed_status; ?></b></label>
                <div class="col-sm-3">
                  <select name="review_booster[noticed_status]" id="input-noticed-status" class="form-control">
                    <?php if ($noticed_status) { ?>
                    <option value="1" selected="selected"><?php echo $text_yes; ?></option>
                    <option value="0"><?php echo $text_no; ?></option>
                    <?php } else { ?>
                    <option value="1"><?php echo $text_yes; ?></option>
                    <option value="0" selected="selected"><?php echo $text_no; ?></option>
                    <?php } ?>
                  </select>
                </div>
				<div class="col-sm-4">
                  <div class="input-group">
                    <input type="text" name="noticed" class="form-control" placeholder="<?php echo $entry_noticed; ?>" />
                    <span class="input-group-btn">
                      <button class="btn btn-default" onclick="addNoticed();" type="button"><i class="fa fa-plus"></i></button>
                    </span>
                  </div>
				  <div id="noticed" style="margin-top: 4px;">
				    <?php foreach ($notice as $row) { ?>
					<div class="input-group">
                      <input type="text" name="review_booster[notice][]" class="form-control" value="<?php echo $row; ?>" placeholder="<?php echo $entry_noticed; ?>" />
                      <span class="input-group-btn">
                        <button class="btn btn-danger" onclick="$(this).parents('div.input-group').remove();" type="button"><i class="fa fa-minus"></i></button>
                      </span>
                    </div>
					<?php } ?>
				  </div>
                </div>
              </div>
			  <div class="form-group">
                <label class="col-sm-2 control-label s_help" for="input-approve-review-status"><?php echo $entry_approve_review_status; ?><b><?php echo $help_approve_review_status; ?></b></label>
                <div class="col-sm-3">
				  <select name="review_booster[approve_review_status]" id="input-approve-review-status" class="form-control">
				    <?php if ($approve_review_status) { ?>
				    <option value="1" selected="selected"><?php echo $text_yes; ?></option>
				    <option value="0"><?php echo $text_no; ?></option>
				    <?php } else { ?>
				    <option value="1"><?php echo $text_yes; ?></option>
				    <option value="0" selected="selected"><?php echo $text_no; ?></option>
				    <?php } ?>
				  </select>
                </div>
				<label class="col-sm-2 control-label" for="input-approve-review-rating"><?php echo $entry_approve_review_rating; ?></label>
				<div class="col-sm-2">
				  <select name="review_booster[approve_review_rating]" id="input-approve-review-rating" class="form-control">
				    <?php foreach ($ratings as $rating) { ?>
				    <?php if ($approve_review_rating == $rating) { ?>
				    <option value="<?php echo $rating; ?>" selected="selected"><?php echo $rating; ?></option>
				    <?php } else { ?>
				    <option value="<?php echo $rating; ?>"><?php echo $rating; ?></option>
				    <?php } ?>
				    <?php } ?>
				  </select>
                </div>
			  </div>
			  <div class="form-group">
                <label class="col-sm-2 control-label s_help" for="input-apr-status"><?php echo $entry_apr_status; ?><b><?php echo $help_apr; ?></b></label>
                <div class="col-sm-7">
                  <select name="review_booster[apr_status]" id="input-apr-status" class="form-control">
                    <?php if ($apr_status) { ?>
                    <option value="1" selected="selected"><?php echo $text_yes; ?></option>
                    <option value="0"><?php echo $text_no; ?></option>
                    <?php } else { ?>
                    <option value="1"><?php echo $text_yes; ?></option>
                    <option value="0" selected="selected"><?php echo $text_no; ?></option>
                    <?php } ?>
                  </select>
                </div>
              </div>
			  <div class="form-group">
                <label class="col-sm-2 control-label s_help" for="input-apr-image-status"><?php echo $entry_apr_image_status; ?><b><?php echo $help_apr_image_status; ?></b></label>
                <div class="col-sm-7">
                  <select name="review_booster[apr_image_status]" id="input-apr-image-status" class="form-control">
                    <?php if ($apr_image_status) { ?>
                    <option value="1" selected="selected"><?php echo $text_yes; ?></option>
                    <option value="0"><?php echo $text_no; ?></option>
                    <?php } else { ?>
                    <option value="1"><?php echo $text_yes; ?></option>
                    <option value="0" selected="selected"><?php echo $text_no; ?></option>
                    <?php } ?>
                  </select>
                </div>
              </div>
			  <div class="form-group">
                <div class="col-sm-9">
				  <ul class="nav nav-tabs" id="language">
                    <?php foreach ($languages as $language) { ?>
                    <li><a href="#language<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></a></li>
                    <?php } ?>
                  </ul>
				  <div class="tab-content">
				    <?php foreach ($languages as $language) { ?>
					<div class="tab-pane" id="language<?php echo $language['language_id']; ?>">
					  <div class="form-group">
					    <label class="col-sm-3 control-label s_help" for="input-link-text<?php echo $language['language_id']; ?>"><?php echo $entry_link_text; ?><b><?php echo $help_link_text; ?></b></label>
					    <div class="col-sm-9">
					      <input type="text" name="review_booster[link_text][<?php echo $language['language_id']; ?>]" value="<?php echo (!is_array($link_text)) ? $link_text : (isset($link_text[$language['language_id']]) ? $link_text[$language['language_id']] : ''); ?>" placeholder="<?php echo $entry_link_text; ?>" id="input-link-text<?php echo $language['language_id']; ?>" class="form-control" />
						</div>
					  </div>
					  <div class="form-group">
					    <label class="col-sm-3 control-label" for="input-subject<?php echo $language['language_id']; ?>"><?php echo $entry_subject; ?></label>
					    <div class="col-sm-9">
					      <input type="text" name="review_booster[email][<?php echo $language['language_id']; ?>][subject]" value="<?php echo (isset($email[$language['language_id']]['subject'])) ? $email[$language['language_id']]['subject'] : ((isset($email['subject']) && !is_array($email['subject'])) ? $email['subject'] : ''); ?>" placeholder="<?php echo $entry_subject; ?>" id="input-subject<?php echo $language['language_id']; ?>" class="form-control" />
					      <div style="padding-top: 7px;"><b>{firstname}</b> - firstname <b>{lastname}</b> - lastname <b>{order_id}</b> - order ID <b>{date_order}</b> - date added of order <b>{store_name}</b> - store name</div>
						</div>
					  </div>
					  <div class="form-group">
					    <label class="col-sm-3 control-label" for="input-description<?php echo $language['language_id']; ?>"><?php echo $entry_description; ?></label>
					    <div class="col-sm-9">
						  <textarea name="review_booster[email][<?php echo $language['language_id']; ?>][description]" rows="12" placeholder="<?php echo $entry_description; ?>" id="input-description<?php echo $language['language_id']; ?>" class="form-control summernote"><?php echo isset($email[$language['language_id']]['description']) ? $email[$language['language_id']]['description'] : ((isset($email['description']) && !is_array($email['description'])) ? $email['description'] : ''); ?></textarea><div style="padding-top: 7px;"><b>{firstname}</b> - firstname <b>{lastname}</b> - lastname <b>{order_id}</b> - order ID <b>{email}</b> - customer email <b>{date_order}</b> - date added of order <b>{store_name}</b> - store name <b>{list}</b> - list of products purchased <b>{form}</b> - review form <b>{link}</b> - link to review form on the website</div>
						  <div><?php if (isset($error['email'])) { ?>
						  <div class="text-danger"><?php echo $error['email']; ?></div>
						  <?php } ?></div>
					    </div>
					  </div>
					</div>
					<?php } ?>
				  </div>
				  <div class="col-sm-7 col-sm-offset-5">
				    <label class="col-sm-6 control-label s_help" for="input-test"><?php echo $entry_test; ?><b><?php echo $help_test; ?></b></label>
				    <div class="col-sm-6">
				      <div class="input-group">
				        <input type="text" name="test" value="" placeholder="<?php echo $entry_test; ?>" id="input-test" class="form-control" />
				        <span class="input-group-btn">
				          <button onClick="sendEmailTest();" class="btn btn-default" type="button"><?php echo $button_test; ?></button>
				        </span>
				      </div>
				    </div>
				  </div>
				</div>
              </div>
			  <div class="form-group">
                <div class="col-sm-10 col-sm-offset-2">
                  <button type="submit" form="form-review-booster" data-toggle="tooltip" title="<?php echo $button_save; ?>" id="button-save" class="btn btn-primary"><?php echo $button_save; ?></button>
                </div>
              </div>
			</div>
			<div class="tab-pane" id="tab-history">
			  <div id="history"></div>
			</div>
			<div class="tab-pane" id="tab-support">
			  <div id="rspLicense"></div>
			  <h3 style="margin-bottom: 25px;"><b>Your license</b></h3>
			  <?php if (isset($bGljZW5zZV9kZXRhaWw['status']) && $bGljZW5zZV9kZXRhaWw['status']) { ?>
			  <table class="table">
			    <tbody>
				  <tr>
				    <td style="width: 150px;">License key:</td>
					<td><span><?php echo $license_key; ?></span><input type="hidden" name="review_booster[license]" class="license_detail form-control" value="<?php echo $license; ?>" />
				      <input type="text" name="review_booster[license_key]" class="license_key form-control" style="display: none!important;" value="<?php echo $license_key; ?>" /> <a id="re-actLicense" class="btn btn-success">Re-activate</a></td>
				  </tr>
				  <tr>
				    <td>License for:</td>
					<td><?php echo $bGljZW5zZV9kZXRhaWw['customer']; ?>, <?php echo $bGljZW5zZV9kZXRhaWw['domain']; ?></td>
				  </tr>
				</tbody>
			  </table>
			  <?php } else { ?>
			  <div class="form-group">
                <label class="col-sm-2 control-label" for="input-enter-license-key">Enter your license key:</label>
                <div class="col-xs-4">
                  <input type="text" name="review_booster[license_key]" value="<?php echo $license_key; ?>" placeholder="xxxxx-xxxxx-xxxxx-xxxxx-xxxxx" id="input-enter-license-key" class="license_key form-control" />
                </div>
				<div class="col-xs-6">
                  <a id="actLicense" class="btn btn-success">Activate</a>
				</div>
              </div>
			  <?php } ?>
			  <br /><br /><br />
			  License required! <a onclick="window.open('https://www.adikon.eu/login')">Click here to get the license key</a>.<br /><br />
			  <b>Module page:</b> <a onclick="window.open('http://www.opencart.com/index.php?route=marketplace/extension/info&extension_id=7191')">Review Booster</a><br />
			  <b>Other modules:</b> <a onclick="window.open('http://www.opencart.com/index.php?route=marketplace/extension&filter_member=adikon')">On Opencart.com</a><br />
			  <br /><br />
			  Adikon.eu, All Rights Reserved.
			  <script type="text/javascript">
			  var mod_id = '1187';
			  var domain = '<?php echo base64_encode((!empty($_SERVER['HTTP_HOST'])) ? $_SERVER['HTTP_HOST'] : (defined('HTTP_SERVER') ? HTTP_SERVER : '')); ?>';
			  </script>
			  <script type="text/javascript" src="//www.adikon.eu/verify/"></script>
			</div>
		  </div>
        </form>
      </div>
    </div>
  </div>
<?php if (version_compare(VERSION, '2.0') < 0) { ?>
<script type="text/javascript" src="view/javascript/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="view/javascript/ckeditor/adapters/jquery.js"></script>
<?php } elseif (version_compare(VERSION, '2.3') >= 0) { ?>
<script type="text/javascript" src="view/javascript/summernote/summernote.js"></script>
<link href="view/javascript/summernote/summernote.css" rel="stylesheet" />
<script type="text/javascript" src="view/javascript/summernote/opencart.js"></script>
<?php } ?>
<script type="text/javascript"><!--
<?php foreach ($languages as $language) { ?>
<?php if (version_compare(VERSION, '2.0') < 0) { ?>
CKEDITOR.replace('input-description<?php echo $language['language_id']; ?>', {
	filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	height: 500
});
<?php } elseif (version_compare(VERSION, '2.3') < 0) { ?>
$('#input-description<?php echo $language['language_id']; ?>').summernote({height: 550});
<?php } ?>
<?php } ?>
//--></script>
<script type="text/javascript"><!--
function sendEmailTest(store_id) {
	if ($("input[name='test']").val().length > 0) {
		$.ajax({
			url: '<?php echo $cron; ?>&test=1&email=' + $("input[name='test']").val(),
			dataType: 'text',
			success: function(data) {
				alert(data);
			}
		});
	}

	return false;
}

function addNoticed() {
	noticed = $('input[name="noticed"]').val().replace(/(<([^>]+)>)/ig, "").trim();

	if (noticed == '') {
		return;
	}

	$('#noticed').append('<div class="input-group"><input type="text" name="review_booster[notice][]" class="form-control" value="' + noticed + '" placeholder="<?php echo $entry_noticed; ?>" /><span class="input-group-btn"><button class="btn btn-danger" onclick="$(this).parents(\'div.input-group\').remove();" type="button"><i class="fa fa-minus"></i></button></span></div>');
	$('input[name="noticed"]').val('');
}
//--></script>
<script type="text/javascript"><!--
$(document).delegate('#button-email-remove', 'click', function() {
	obj = $(this);

	$.ajax({
		url: 'index.php?route=module/review_booster/remove&token=<?php echo $token; ?>&format=raw&email_id=' + obj.data('email-id'),
		type: 'post',
		dataType: 'json',
		beforeSend: function() {
			obj.html('<i class="fa fa-spinner fa-spin"></i>');
		},
		complete: function() {
			obj.html('<i class="fa fa-trash-o"></i>');
		},
		success: function(json) {
			$('.alert').remove();

			if (json['error']) {
				$('#content > .container-fluid').prepend('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '</div>');
			}

			if (json['success']) {
                $('#content > .container-fluid').prepend('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + '</div>');

				$('#history').load('index.php?route=module/review_booster/history&token=<?php echo $token; ?>&store_id=<?php echo $filter_store_id; ?>&format=raw');
			}
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
});

$('#history').delegate('.pagination a, .links a', 'click', function(e) {
	e.preventDefault();

	$('#history').load(this.href);
});

$('#history').load('index.php?route=module/review_booster/history&token=<?php echo $token; ?>&store_id=<?php echo $filter_store_id; ?>&format=raw');

$(document).delegate('#general-tabs a[href="#tab-history"]', 'click', function() {
	$('#history').load('index.php?route=module/review_booster/history&token=<?php echo $token; ?>&store_id=<?php echo $filter_store_id; ?>&format=raw');
});

$('#language a:first').tab('show');
//--></script>
<?php if (version_compare(VERSION, '2.0') < 0) { ?>
<script type="text/javascript"><!--
$('#button-save').on('click', function(e) {
	$('#form-review-booster').submit();
});
//--></script>
<?php } ?>
</div>
<?php echo $footer; ?>