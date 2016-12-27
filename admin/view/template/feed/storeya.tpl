<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-google-base" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
  <div class="panel panel-default">
    <div class="panel-heading">
      <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
    </div>
    <div class="panel-body">
      <div class="container-fluid">
        <?php if ($error_warning) { ?>
        <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
          <button type="button" class="close" data-dismiss="alert">&times;</button>
        </div>
        <?php } ?>
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-storeya" class="form-horizontal">
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
            <div class="col-sm-10">
              <select name="storeya_status" id="input-status" class="form-control">
                <?php if ($storeya_status) { ?>
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
            <label class="col-sm-2 control-label" >Max amount of products</label>
            <div class="col-sm-10">
             <select name="storeya_tocount">
            <option value="50" <?php if($storeya_tocount==50) echo 'selected="selected"';?> >50</option>
            <option value="500" <?php if($storeya_tocount==500 || $storeya_tocount=='') echo 'selected="selected"';?>)>500</option>
            <option value="5000" <?php if($storeya_tocount==5000) echo 'selected="selected"';?>>5000</option>
            <option value="10000" <?php if($storeya_tocount==10000) echo 'selected="selected"';?>>10000</option>
            </select>
            
             <input type="hidden" name="storeya_fromcount" maxlength="5" size="5" value="0"/>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" >Currency</label>
            <div class="col-sm-10">
              <select name="storeya_currency">
           <?php foreach ($currencies as $curr) { ?>
            <option value="<?php echo $curr['code']; ?>" <?php if($curr['code']== $storeya_currency) echo 'selected="selected"';?> ><?php echo $curr['title']; ?></option>
           <?php } ?>
            </select>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" >Language</label>
            <div class="col-sm-10">
              <select name="storeya_language">
           <?php foreach ($languages as $lang) { ?>
            <option value="<?php echo $lang['code']; ?>" <?php if($lang['code']== $storeya_language) echo 'selected="selected"';?> ><?php echo $lang['name']; ?></option>
           <?php } ?>
            </select>
            </div>
          </div>
          
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-data-feed"><?php echo $entry_data_feed; ?></label>
            <div class="col-sm-10">
              <textarea rows="5" readonly id="input-data-feed" class="form-control"><?php echo $data_feed; ?></textarea>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>
<?php echo $footer; ?>