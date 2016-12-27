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
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="login" class="form-horizontal">
        <fieldset>
          <div class="form-group required">
            <label class="col-sm-2 control-label" for="input-email"><?php echo $entry_email; ?></label>
            <div class="col-sm-10">
              <input type="text" name="email" value="" id="input-email" class="form-control" />
            </div>
          </div>
<!--      <div class="form-group required">
            <label class="col-sm-2 control-label" for="input-ip"><?php echo $entry_ip; ?></label>
            <div class="col-sm-10">
              <input type="text" name="ip" value="" id="input-ip" class="form-control" placeholder="<?php echo $text_ip; ?>" />
            </div>
          </div>-->
          <div class="form-group required">
            <label class="col-sm-2 control-label" for="input-order_number"><?php echo $entry_order_number; ?></label>
            <div class="col-sm-10">
              <input type="text" name="order_number" value="" id="input-order_number" class="form-control" placeholder="<?php echo $text_order_number; ?>" />
            </div>
          </div>
        </fieldset>
        <div class="buttons">
          <div class="pull-right">
            <a onclick="$('#login').submit();" class="btn btn-primary"><span><?php echo $button_continue; ?></span></a>
          </div>
        </div>
      </form>
      <?php echo $content_bottom; ?></div>
    <?php echo $column_right; ?></div>
</div>
<?php echo $footer; ?>
<script type="text/javascript"><!--
$('#login input').keydown(function(e) {
	if (e.keyCode == 13) {
		$('#login').submit();
	}
});
//--></script>   