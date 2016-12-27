<?php echo $header; ?><?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content"><?php echo $content_top; ?>
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <script type="text/javascript" src="catalog/view/javascript/jquery/ajaxupload.js"></script>
  <h1><?php echo $heading_title; ?></h1>
    <div class="content">
	  <?php if ($success) { ?>
	  <p style="margin-top:40px; text-align:center; font-size:1.1em; line-height:1.8;">
        <?php echo $success; ?>
      </p>
      <div class="buttons">
        <div class="right"><a href="<?php echo $continue; ?>" class="button"><?php echo $button_continue; ?></a></div>
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
	  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
	    <?php if ($objConfig->get('review_booster_type') != 'product_single') { ?>
		<?php array_splice($products, 1, count($products)); ?>
		<?php } ?>
		<?php foreach ($products as $product) { ?>
		<?php $product_id = $objConfig->get('review_booster_type') == 'product_single' ? $product['product_id'] : 'all'; ?>
		<?php if ($objConfig->get('review_booster_type') == 'product_single') { ?>
		<div style="margin-top:15px; margin-bottom:15px; color:#666; text-align:left; vartical-align: middle; font-weight:600; font-size:15px;">
		  <?php if ($objConfig->get('review_booster_product_image_status')) { ?>
		  <img src="<?php echo $product['image']; ?>" border="0" class="product_image" />
		  <?php } ?>
		  <?php echo $product['name']; ?>
		</div>
		<?php } ?>
		<b><?php echo $entry_rating; ?></b><br />
	    <table style="border:0; padding:0; margin:0;">
		  <tbody>
		  <?php if ($ratings) { ?>
		    <?php foreach ($ratings as $r) { ?>
			<tr>
			  <td align="left" style="padding-top:7px; padding-right:30px;"><b><?php echo $r['name']; ?></b></td>
			  <?php for ($j = 1; $j <= 5; $j++) { ?>
			  <td align="center" style="padding-right:15px;">
			    <img style="vertical-align:middle; border:0; margin:0; padding:0;" src="data:image/png;base64,<?php echo $stars[$objConfig->get('review_booster_star')][$j]; ?>" /><br />
				<input type="radio" name="review[<?php echo $product_id; ?>][rating][<?php echo $r['rating_id']; ?>]" value="<?php echo $j; ?>" <?php echo ((isset($review[$product_id]['rating'][$r['rating_id']]) && $j == $review[$product_id]['rating'][$r['rating_id']]) ? 'checked' : ''); ?> />
			  </td>
			  <?php } ?>
			</tr>
		    <?php } ?>
		  <?php } else { ?>
		    <tr>
			  <?php for ($j = 1; $j <= 5; $j++) { ?>
			  <td align="center" style="padding-right:15px;">
			    <img style="vertical-align:middle; border:0; margin:0; padding:0;" src="data:image/png;base64,<?php echo $stars[$objConfig->get('review_booster_star')][$j]; ?>" /><br />
				<input type="radio" name="review[<?php echo $product_id; ?>][rating]" value="<?php echo $j; ?>" <?php echo ((isset($review[$product_id]['rating']) && $j == $review[$product_id]['rating']) ? 'checked' : ''); ?> />
			  </td>
		      <?php } ?>
			</tr>
		  <?php } ?>
		  </tbody>
		</table>
		<br />
		<?php if (isset($error_rating[$product_id])) { ?>
		<span class="error"><?php echo $error_rating[$product_id]; ?></span>
		<?php } ?>
		<br />
		<b><?php echo $entry_review; ?></b>
		<textarea name="review[<?php echo $product_id; ?>][text]" cols="40" rows="8" style="width: 98%;"><?php echo ((isset($review[$product_id]['text'])) ? $review[$product_id]['text'] : ''); ?></textarea>
		<br />
		<?php if (isset($error_review[$product_id])) { ?>
		<span class="error"><?php echo $error_review[$product_id]; ?></span>
		<?php } ?>
		<br />
		<?php if ($objConfig->get('review_booster_apr_image_status')) { ?>
		<b><?php echo $entry_review_image; ?></b> <button type="button" title="<?php echo $button_upload; ?>" id="button-review-image<?php echo $product_id; ?>" class="button"><?php echo $button_upload; ?></button>
		<div id="review_images<?php echo $product_id; ?>">
		  <?php if (isset($images[$product_id])) { ?>
		  <?php foreach ($images[$product_id] as $image) { ?>
		  <div class="rimage"><img src="<?php echo $image['thumb']; ?>" alt="" /><input type="hidden" name="review[<?php echo $product_id; ?>][review_images][]" value="<?php echo $image['image']; ?>" /></div>
		  <?php } ?>
		  <?php } ?>
		</div>
		<script type="text/javascript"><!--
		new AjaxUpload('#button-review-image<?php echo $product_id; ?>', {
		  action: 'index.php?route=product/allreviews/reviewimageupload',
		  name: 'file',
		  autoSubmit: true,
		  responseType: 'json',
		  onSubmit: function(file, extension) {
		    $('#button-review-image<?php echo $product_id; ?>').after('<img src="catalog/view/theme/default/image/loading.gif" class="loading" style="padding-left: 5px;" />');
		    $('#button-review-image<?php echo $product_id; ?>').attr('disabled', true);
		  },
		  onComplete: function(file, json) {
		    $('#button-review-image<?php echo $product_id; ?>').attr('disabled', false);

		    $('.error').remove();

		    if (json['success']) {
		      alert(json['success']);

		      $('#review_images<?php echo $product_id; ?>').append('<div class="rimage"><img src="' + json['thumb'] + '" alt="" /><input type="hidden" name="review[<?php echo $product_id; ?>][review_images][]" value="' + json['file'] + '" /></div>');
		    }

		    if (json['error']) {
		      $('#button-review-image<?php echo $product_id; ?>').after('<span class="error">' + json['error'] + '</span>');
		    }

		    $('.loading').remove();	
		  }
		});
		//--></script>	
		<?php } ?>
		<?php } ?>
		<?php if ($objConfig->get('review_booster_noticed_status')) { ?>
		<br />
		<b><?php echo $entry_noticed; ?></b> 
		<select name="review[<?php echo $product_id; ?>][noticed]">';
		  <?php foreach ($notices as $key => $row) { ?>
		  <?php if (isset($review[$product_id]['noticed']) && $key == $review[$product_id]['noticed']) { ?>
		  <option value="<?php echo $key; ?>" selected="selected"><?php echo $row; ?></option>
		  <?php } else { ?>
		  <option value="<?php echo $key; ?>"><?php echo $row; ?></option>
		  <?php } ?>
		  <?php } ?>
		</select>
		<?php } ?>
		<div class="buttons">
		  <div class="right"><input type="submit" value="<?php echo $button_submit; ?>" class="button" /></div>
		</div>
	  </form>
      <?php } ?>
	</div>
  <?php echo $content_bottom; ?></div>
<style>
.product_image { border: 1px solid #dddddd; vertical-align: middle; margin-left: 10px; margin-right: 10px; }
.rimage { border: 1px solid #eee; padding: 2px; display: inline-block; margin: 10px 10px 0 0; text-align: center; }
</style>
<?php echo $footer; ?>