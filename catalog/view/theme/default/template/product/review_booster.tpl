<?php echo $header; ?>
<div class="container">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
  <div class="row"><?php echo $column_left; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-sm-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-sm-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-sm-12'; ?>
    <?php } ?>
    <div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>
      <h1><?php echo $heading_title; ?></h1>
	  <?php if ($success) { ?>
	  <p style="margin-top:40px; text-align:center; font-size:1.1em; line-height:1.8;">
	    <?php echo $success; ?>
	  </p>
	  <div class="buttons">
        <div class="pull-right"><a href="<?php echo $continue; ?>" class="btn btn-default"><?php echo $button_continue; ?></a></div>
      </div>
	  <?php } else { ?>
	  <p><?php echo $text_description; ?><br /><br />
	  <b><?php echo $text_product; ?></b><br />
	  <?php if ($objConfig->get('review_booster_product_image_status') && $objConfig->get('review_booster_type') != 'product_single') { ?>
	  <table border="0" cellpadding="0" cellspacing="0" style="width:100%; margin:0; padding:0; border-collapse:collapse;">
	    <?php foreach ($products as $product) { ?>
	    <tr>
	      <td width="<?php echo $objConfig->get('review_booster_product_image_width'); ?>" style="padding: 2px;"><img src="<?php echo $product['image']; ?>" border="0" class="product_image" /></td>
	      <td valign="middle"><?php echo $product['name']; ?></td>
	    </tr>
	    <?php } ?>
	  </table>
	  <?php } else { ?>
	  <?php foreach ($products as $product) { ?>
	  &bullet; <?php echo $product['name']; ?><br />
	  <?php } ?>
	  <?php } ?>
	  <br /></p>
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="form-horizontal">
        <?php if ($objConfig->get('review_booster_type') != 'product_single') { ?>
		<?php array_splice($products, 1, count($products)); ?>
		<?php } ?>
		<?php foreach ($products as $product) { ?>
		<?php $product_id = $objConfig->get('review_booster_type') == 'product_single' ? $product['product_id'] : 'all'; ?>
		<fieldset>
          <?php if ($objConfig->get('review_booster_type') == 'product_single') { ?>
		  <div class="form-group">
		    <div class="col-sm-12" style="margin-top:15px; color:#666; text-align:left; vartical-align: middle; font-weight:600; font-size:15px;">
			  <?php if ($objConfig->get('review_booster_product_image_status')) { ?>
			  <img src="<?php echo $product['image']; ?>" border="0" class="product_image" />
			  <?php } ?>
			  <?php echo $product['name']; ?>
			</div>
		  </div>
		  <?php } ?>
		  <div class="form-group">
            <label class="col-sm-2 control-label" for="input-rating<?php echo $product_id; ?>"><?php echo $entry_rating; ?></label>
            <div class="col-sm-10">
			  <?php if ($ratings) { ?>
			  <table style="border:0; padding:0; margin:0;">
			    <tbody>
			      <?php foreach ($ratings as $r) { ?>
			      <tr>
			        <td align="left" style="padding-top:7px; padding-right:30px;"><b><?php echo $r['name']; ?></b></td>
			        <td>
			          <?php for ($j = 1; $j <= 5; $j++) { ?>
			          <label class="radio-inline">
			            <input type="radio" name="review[<?php echo $product_id; ?>][rating][<?php echo $r['rating_id']; ?>]" value="<?php echo $j; ?>" <?php echo ((isset($review[$product_id][rating][$r['rating_id']]) && $j == $review[$product_id]['rating'][$r['rating_id']]) ? 'checked' : ''); ?> /> 
						<img style="vertical-align:middle; border:0; margin:0; padding:0;" src="data:image/png;base64,<?php echo $stars[$objConfig->get('review_booster_star')][$j]; ?>" />&nbsp;</label>
			          <?php } ?>
			        </td>
			      </tr>
			      <?php } ?>
			    </tbody>
			  </table>
			  <?php } else { ?>
			  <?php for ($j = 1; $j <= 5; $j++) { ?>
			  <label class="radio-inline" style="text-align:center; padding-left:0px; padding-right:15px;">
                <img style="text-align:center; vertical-align:middle; border:0; margin:0; padding:0;" src="data:image/png;base64,<?php echo $stars[$objConfig->get('review_booster_star')][$j]; ?>" /><br />
				<input style="text-align:center; position:relative; margin:0;" type="radio" name="review[<?php echo $product_id; ?>][rating]" value="<?php echo $j; ?>" <?php echo ((isset($review[$product_id]['rating']) && $j == $review[$product_id]['rating']) ? 'checked' : ''); ?> /></label>
			  <?php } ?>
			  <?php } ?>
              <?php if (isset($error_rating[$product_id])) { ?>
              <div class="text-danger"><?php echo $error_rating[$product_id]; ?></div>
              <?php } ?>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-text<?php echo $product_id; ?>"><?php echo $entry_review; ?></label>
            <div class="col-sm-10">
              <textarea name="review[<?php echo $product_id; ?>][text]" rows="10" id="input-text<?php echo $product_id; ?>" class="form-control"><?php echo ((isset($review[$product_id]['text'])) ? $review[$product_id]['text'] : ''); ?></textarea>
              <?php if (isset($error_review[$product_id])) { ?>
              <div class="text-danger"><?php echo $error_review[$product_id]; ?></div>
              <?php } ?>
            </div>
          </div>
		  <?php if ($objConfig->get('review_booster_apr_image_status')) { ?>
		  <div class="form-group">
            <label class="col-sm-2 control-label" for="input-review-image<?php echo $product_id; ?>"><?php echo $entry_review_image; ?></label>
            <div class="col-sm-10">
			  <button type="button" title="<?php echo $button_upload; ?>" id="button-review-image<?php echo $product_id; ?>" class="btn btn-primary"><?php echo $button_upload; ?></button>
			  <div id="review_images<?php echo $product_id; ?>">
			    <?php if (isset($images[$product_id])) { ?>
			    <?php foreach ($images[$product_id] as $image) { ?>
			    <div class="rimage"><img src="<?php echo $image['thumb']; ?>" alt="" /><input type="hidden" name="review[<?php echo $product_id; ?>][review_images][]" value="<?php echo $image['image']; ?>" /></div>
			    <?php } ?>
			    <?php } ?>
			  </div>
            </div>
          </div>
		  <script type="text/javascript"><!--
		  $('#button-review-image<?php echo $product_id; ?>').on('click', function() {
			var node = this;

			$('#form-upload').remove();

			$('body').prepend('<form enctype="multipart/form-data" id="form-upload" style="display: none;"><input type="file" name="file" /></form>');

			$('#form-upload input[name=\'file\']').trigger('click');

			timer = setInterval(function() {
			  if ($('#form-upload input[name=\'file\']').val() != '') {
			    clearInterval(timer);

			    $.ajax({
			      url: 'index.php?route=product/allreviews/reviewimageupload',
			      type: 'post',
			      dataType: 'json',
			      data: new FormData($('#form-upload')[0]),
			      cache: false,
			      contentType: false,
			      processData: false,
			      beforeSend: function() {
			        $(node).button('loading');
			      },
			      complete: function() {
			        $(node).button('reset');
			      },
			      success: function(json) {
			        $('.text-danger').remove();
					
			        if (json['error']) {
			          $(node).after('<div class="text-danger">' + json['error'] + '</div>');
			        }
					
			        if (json['success']) {
			          alert(json['success']);

			          $('#review_images<?php echo $product_id; ?>').append('<div class="rimage"><img src="' + json['thumb'] + '" alt="" /><input type="hidden" name="review[<?php echo $product_id; ?>][review_images][]" value="' + json['file'] + '" /></div>');
			        }
			      },
			      error: function(xhr, ajaxOptions, thrownError) {
			        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			      }
			    });
			  }
			}, 500);
		  });
		  //--></script>
		  <?php } ?>
        </fieldset>
		<?php } ?>
		<?php if ($objConfig->get('review_booster_noticed_status')) { ?>
		<fieldset style="border-top: 1px solid #ebebeb; padding-top: 15px;">
		  <div class="form-group">
            <label class="col-sm-2 control-label" for="input-noticed<?php echo $product_id; ?>"><?php echo $entry_noticed; ?></label>
            <div class="col-sm-10">
			  <select name="review[<?php echo $product_id; ?>][noticed]" class="form-control" id="input-noticed<?php echo $product_id; ?>">';
			    <?php foreach ($notices as $key => $row) { ?>
				<?php if (isset($review[$product_id]['noticed']) && $key == $review[$product_id]['noticed']) { ?>
				<option value="<?php echo $key; ?>" selected="selected"><?php echo $row; ?></option>
				<?php } else { ?>
				<option value="<?php echo $key; ?>"><?php echo $row; ?></option>
				<?php } ?>
				<?php } ?>
			  </select>
            </div>
          </div>
		</fieldset>
		<?php } ?>
        <div class="buttons">
          <div class="pull-right">
            <input class="btn btn-primary" type="submit" value="<?php echo $button_submit; ?>" />
          </div>
        </div>
      </form>
	  <?php } ?>
      <?php echo $content_bottom; ?></div>
    <?php echo $column_right; ?></div>
</div>
<style>
.product_image { border: 1px solid #dddddd; vertical-align: middle; margin-left: 10px; margin-right: 10px; }
.rimage { border: 1px solid #eee; padding: 2px; display: inline-block; margin: 10px 10px 0 0; text-align: center; }
</style>
<?php echo $footer; ?>
