<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-setting" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
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
    <?php if ($success) { ?>
    <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
      </div>
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-setting" class="form-horizontal">
          <ul class="nav nav-tabs">
            <li class="active"><a href="#tab-general" data-toggle="tab"><?php echo $tab_general; ?></a></li>
            <li><a href="#tab-store" data-toggle="tab"><?php echo $tab_store; ?></a></li>
            <li><a href="#tab-local" data-toggle="tab"><?php echo $tab_local; ?></a></li>
            <li><a href="#tab-option" data-toggle="tab"><?php echo $tab_option; ?></a></li>
            <li><a href="#tab-image" data-toggle="tab"><?php echo $tab_image; ?></a></li>
            <li><a href="#tab-ftp" data-toggle="tab"><?php echo $tab_ftp; ?></a></li>
            <li><a href="#tab-mail" data-toggle="tab"><?php echo $tab_mail; ?></a></li>
            <li><a href="#tab-fraud" data-toggle="tab"><?php echo $tab_fraud; ?></a></li>
            <li><a href="#tab-server" data-toggle="tab"><?php echo $tab_server; ?></a></li>
            <li><a href="#tab-ips" data-toggle="tab">Increase Page Speed 5.2</a></li>
          </ul>
          <div class="tab-content">
            <div class="tab-pane active" id="tab-general">
              <div class="form-group required">
                <label class="col-sm-2 control-label" for="input-name"><?php echo $entry_name; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="config_name" value="<?php echo $config_name; ?>" placeholder="<?php echo $entry_name; ?>" id="input-name" class="form-control" />
                  <?php if ($error_name) { ?>
                  <div class="text-danger"><?php echo $error_name; ?></div>
                  <?php } ?>
                </div>
              </div>
              <div class="form-group required">
                <label class="col-sm-2 control-label" for="input-owner"><?php echo $entry_owner; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="config_owner" value="<?php echo $config_owner; ?>" placeholder="<?php echo $entry_owner; ?>" id="input-owner" class="form-control" />
                  <?php if ($error_owner) { ?>
                  <div class="text-danger"><?php echo $error_owner; ?></div>
                  <?php } ?>
                </div>
              </div>
              <div class="form-group required">
                <label class="col-sm-2 control-label" for="input-address"><?php echo $entry_address; ?></label>
                <div class="col-sm-10">
                  <textarea name="config_address" placeholder="<?php echo $entry_address; ?>" rows="5" id="input-address" class="form-control"><?php echo $config_address; ?></textarea>
                  <?php if ($error_address) { ?>
                  <div class="text-danger"><?php echo $error_address; ?></div>
                  <?php } ?>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-geocode"><span data-toggle="tooltip" data-container="#tab-general" title="<?php echo $help_geocode; ?>"><?php echo $entry_geocode; ?></span></label>
                <div class="col-sm-10">
                  <input type="text" name="config_geocode" value="<?php echo $config_geocode; ?>" placeholder="<?php echo $entry_geocode; ?>" id="input-geocode" class="form-control" />
                </div>
              </div>
              <div class="form-group required">
                <label class="col-sm-2 control-label" for="input-email"><?php echo $entry_email; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="config_email" value="<?php echo $config_email; ?>" placeholder="<?php echo $entry_email; ?>" id="input-email" class="form-control" />
                  <?php if ($error_email) { ?>
                  <div class="text-danger"><?php echo $error_email; ?></div>
                  <?php } ?>
                </div>
              </div>
              <div class="form-group required">
                <label class="col-sm-2 control-label" for="input-telephone"><?php echo $entry_telephone; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="config_telephone" value="<?php echo $config_telephone; ?>" placeholder="<?php echo $entry_telephone; ?>" id="input-telephone" class="form-control" />
                  <?php if ($error_telephone) { ?>
                  <div class="text-danger"><?php echo $error_telephone; ?></div>
                  <?php } ?>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-fax"><?php echo $entry_fax; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="config_fax" value="<?php echo $config_fax; ?>" placeholder="<?php echo $entry_fax; ?>" id="input-fax" class="form-control" />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-image"><?php echo $entry_image; ?></label>
                <div class="col-sm-10"><a href="" id="thumb-image" data-toggle="image" class="img-thumbnail"><img src="<?php echo $thumb; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a>
                  <input type="hidden" name="config_image" value="<?php echo $config_image; ?>" id="input-image" />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-open"><span data-toggle="tooltip" data-container="#tab-general" title="<?php echo $help_open; ?>"><?php echo $entry_open; ?></span></label>
                <div class="col-sm-10">
                  <textarea name="config_open" rows="5" placeholder="<?php echo $entry_open; ?>" id="input-open" class="form-control"><?php echo $config_open; ?></textarea>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-comment"><span data-toggle="tooltip" data-container="#tab-general" title="<?php echo $help_comment; ?>"><?php echo $entry_comment; ?></span></label>
                <div class="col-sm-10">
                  <textarea name="config_comment" rows="5" placeholder="<?php echo $entry_comment; ?>" id="input-comment" class="form-control"><?php echo $config_comment; ?></textarea>
                </div>
              </div>
              <?php if ($locations) { ?>
              <div class="form-group">
                <label class="col-sm-2 control-label"><span data-toggle="tooltip" data-container="#tab-general" title="<?php echo $help_location; ?>"><?php echo $entry_location; ?></span></label>
                <div class="col-sm-10">
                  <?php foreach ($locations as $location) { ?>
                  <div class="checkbox">
                    <label>
                      <?php if (in_array($location['location_id'], $config_location)) { ?>
                      <input type="checkbox" name="config_location[]" value="<?php echo $location['location_id']; ?>" checked="checked" />
                      <?php echo $location['name']; ?>
                      <?php } else { ?>
                      <input type="checkbox" name="config_location[]" value="<?php echo $location['location_id']; ?>" />
                      <?php echo $location['name']; ?>
                      <?php } ?>
                    </label>
                  </div>
                  <?php } ?>
                </div>
              </div>
              <?php } ?>
            </div>
            <div class="tab-pane" id="tab-store">
              <div class="form-group required">
                <label class="col-sm-2 control-label" for="input-meta-title"><?php echo $entry_meta_title; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="config_meta_title" value="<?php echo $config_meta_title; ?>" placeholder="<?php echo $entry_meta_title; ?>" id="input-meta-title" class="form-control" />
                  <?php if ($error_meta_title) { ?>
                  <div class="text-danger"><?php echo $error_meta_title; ?></div>
                  <?php } ?>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-meta-description"><?php echo $entry_meta_description; ?></label>
                <div class="col-sm-10">
                  <textarea name="config_meta_description" rows="5" placeholder="<?php echo $entry_meta_description; ?>" id="input-meta-description" class="form-control"><?php echo $config_meta_description; ?></textarea>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-meta-keyword"><?php echo $entry_meta_keyword; ?></label>
                <div class="col-sm-10">
                  <textarea name="config_meta_keyword" rows="5" placeholder="<?php echo $entry_meta_keyword; ?>" id="input-meta-keyword" class="form-control"><?php echo $config_meta_keyword; ?></textarea>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-template"><?php echo $entry_template; ?></label>
                <div class="col-sm-10">
                  <select name="config_template" id="input-template" class="form-control">
                    <?php foreach ($templates as $template) { ?>
                    <?php if ($template == $config_template) { ?>
                    <option value="<?php echo $template; ?>" selected="selected"><?php echo $template; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $template; ?>"><?php echo $template; ?></option>
                    <?php } ?>
                    <?php } ?>
                  </select>
                  <br />
                  <img src="" alt="" id="template" class="img-thumbnail" /></div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-layout"><?php echo $entry_layout; ?></label>
                <div class="col-sm-10">
                  <select name="config_layout_id" id="input-layout" class="form-control">
                    <?php foreach ($layouts as $layout) { ?>
                    <?php if ($layout['layout_id'] == $config_layout_id) { ?>
                    <option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
                    <?php } ?>
                    <?php } ?>
                  </select>
                </div>
              </div>
            </div>
            <div class="tab-pane" id="tab-local">
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-country"><?php echo $entry_country; ?></label>
                <div class="col-sm-10">
                  <select name="config_country_id" id="input-country" class="form-control">
                    <?php foreach ($countries as $country) { ?>
                    <?php if ($country['country_id'] == $config_country_id) { ?>
                    <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
                    <?php } ?>
                    <?php } ?>
                  </select>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-zone"><?php echo $entry_zone; ?></label>
                <div class="col-sm-10">
                  <select name="config_zone_id" id="input-zone" class="form-control">
                  </select>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-language"><?php echo $entry_language; ?></label>
                <div class="col-sm-10">
                  <select name="config_language" id="input-language" class="form-control">
                    <?php foreach ($languages as $language) { ?>
                    <?php if ($language['code'] == $config_language) { ?>
                    <option value="<?php echo $language['code']; ?>" selected="selected"><?php echo $language['name']; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $language['code']; ?>"><?php echo $language['name']; ?></option>
                    <?php } ?>
                    <?php } ?>
                  </select>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-admin-language"><?php echo $entry_admin_language; ?></label>
                <div class="col-sm-10">
                  <select name="config_admin_language" id="input-admin-language" class="form-control">
                    <?php foreach ($languages as $language) { ?>
                    <?php if ($language['code'] == $config_admin_language) { ?>
                    <option value="<?php echo $language['code']; ?>" selected="selected"><?php echo $language['name']; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $language['code']; ?>"><?php echo $language['name']; ?></option>
                    <?php } ?>
                    <?php } ?>
                  </select>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-currency"><span data-toggle="tooltip" title="<?php echo $help_currency; ?>"><?php echo $entry_currency; ?></span></label>
                <div class="col-sm-10">
                  <select name="config_currency" id="input-currency" class="form-control">
                    <?php foreach ($currencies as $currency) { ?>
                    <?php if ($currency['code'] == $config_currency) { ?>
                    <option value="<?php echo $currency['code']; ?>" selected="selected"><?php echo $currency['title']; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $currency['code']; ?>"><?php echo $currency['title']; ?></option>
                    <?php } ?>
                    <?php } ?>
                  </select>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_currency_auto; ?>"><?php echo $entry_currency_auto; ?></span></label>
                <div class="col-sm-10">
                  <label class="radio-inline">
                    <?php if ($config_currency_auto) { ?>
                    <input type="radio" name="config_currency_auto" value="1" checked="checked" />
                    <?php echo $text_yes; ?>
                    <?php } else { ?>
                    <input type="radio" name="config_currency_auto" value="1" />
                    <?php echo $text_yes; ?>
                    <?php } ?>
                  </label>
                  <label class="radio-inline">
                    <?php if (!$config_currency_auto) { ?>
                    <input type="radio" name="config_currency_auto" value="0" checked="checked" />
                    <?php echo $text_no; ?>
                    <?php } else { ?>
                    <input type="radio" name="config_currency_auto" value="0" />
                    <?php echo $text_no; ?>
                    <?php } ?>
                  </label>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-length-class"><?php echo $entry_length_class; ?></label>
                <div class="col-sm-10">
                  <select name="config_length_class_id" id="input-length-class" class="form-control">
                    <?php foreach ($length_classes as $length_class) { ?>
                    <?php if ($length_class['length_class_id'] == $config_length_class_id) { ?>
                    <option value="<?php echo $length_class['length_class_id']; ?>" selected="selected"><?php echo $length_class['title']; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $length_class['length_class_id']; ?>"><?php echo $length_class['title']; ?></option>
                    <?php } ?>
                    <?php } ?>
                  </select>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-weight-class"><?php echo $entry_weight_class; ?></label>
                <div class="col-sm-10">
                  <select name="config_weight_class_id" id="input-weight-class" class="form-control">
                    <?php foreach ($weight_classes as $weight_class) { ?>
                    <?php if ($weight_class['weight_class_id'] == $config_weight_class_id) { ?>
                    <option value="<?php echo $weight_class['weight_class_id']; ?>" selected="selected"><?php echo $weight_class['title']; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $weight_class['weight_class_id']; ?>"><?php echo $weight_class['title']; ?></option>
                    <?php } ?>
                    <?php } ?>
                  </select>
                </div>
              </div>
            </div>
            <div class="tab-pane" id="tab-option">
              <fieldset>
                <legend><?php echo $text_product; ?></legend>
                <div class="form-group">
                  <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_product_count; ?>"><?php echo $entry_product_count; ?></span></label>
                  <div class="col-sm-10">
                    <label class="radio-inline">
                      <?php if ($config_product_count) { ?>
                      <input type="radio" name="config_product_count" value="1" checked="checked" />
                      <?php echo $text_yes; ?>
                      <?php } else { ?>
                      <input type="radio" name="config_product_count" value="1" />
                      <?php echo $text_yes; ?>
                      <?php } ?>
                    </label>
                    <label class="radio-inline">
                      <?php if (!$config_product_count) { ?>
                      <input type="radio" name="config_product_count" value="0" checked="checked" />
                      <?php echo $text_no; ?>
                      <?php } else { ?>
                      <input type="radio" name="config_product_count" value="0" />
                      <?php echo $text_no; ?>
                      <?php } ?>
                    </label>
                  </div>
                </div>
                <div class="form-group required">
                  <label class="col-sm-2 control-label" for="input-catalog-limit"><span data-toggle="tooltip" title="<?php echo $help_product_limit; ?>"><?php echo $entry_product_limit; ?></span></label>
                  <div class="col-sm-10">
                    <input type="text" name="config_product_limit" value="<?php echo $config_product_limit; ?>" placeholder="<?php echo $entry_product_limit; ?>" id="input-catalog-limit" class="form-control" />
                    <?php if ($error_product_limit) { ?>
                    <div class="text-danger"><?php echo $error_product_limit; ?></div>
                    <?php } ?>
                  </div>
                </div>
                <div class="form-group required">
                  <label class="col-sm-2 control-label" for="input-list-description-limit"><span data-toggle="tooltip" title="<?php echo $help_product_description_length; ?>"><?php echo $entry_product_description_length; ?></span></label>
                  <div class="col-sm-10">
                    <input type="text" name="config_product_description_length" value="<?php echo $config_product_description_length; ?>" placeholder="<?php echo $entry_product_description_length; ?>" id="input-list-description-limit" class="form-control" />
                    <?php if ($error_product_description_length) { ?>
                    <div class="text-danger"><?php echo $error_product_description_length; ?></div>
                    <?php } ?>
                  </div>
                </div>
                <div class="form-group required">
                  <label class="col-sm-2 control-label" for="input-admin-limit"><span data-toggle="tooltip" title="<?php echo $help_limit_admin; ?>"><?php echo $entry_limit_admin; ?></span></label>
                  <div class="col-sm-10">
                    <input type="text" name="config_limit_admin" value="<?php echo $config_limit_admin; ?>" placeholder="<?php echo $entry_limit_admin; ?>" id="input-admin-limit" class="form-control" />
                    <?php if ($error_limit_admin) { ?>
                    <div class="text-danger"><?php echo $error_limit_admin; ?></div>
                    <?php } ?>
                  </div>
                </div>
              </fieldset>
              <fieldset>
                <legend><?php echo $text_review; ?></legend>
                <div class="form-group">
                  <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_review; ?>"><?php echo $entry_review; ?></span></label>
                  <div class="col-sm-10">
                    <label class="radio-inline">
                      <?php if ($config_review_status) { ?>
                      <input type="radio" name="config_review_status" value="1" checked="checked" />
                      <?php echo $text_yes; ?>
                      <?php } else { ?>
                      <input type="radio" name="config_review_status" value="1" />
                      <?php echo $text_yes; ?>
                      <?php } ?>
                    </label>
                    <label class="radio-inline">
                      <?php if (!$config_review_status) { ?>
                      <input type="radio" name="config_review_status" value="0" checked="checked" />
                      <?php echo $text_no; ?>
                      <?php } else { ?>
                      <input type="radio" name="config_review_status" value="0" />
                      <?php echo $text_no; ?>
                      <?php } ?>
                    </label>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_review_guest; ?>"><?php echo $entry_review_guest; ?></span></label>
                  <div class="col-sm-10">
                    <label class="radio-inline">
                      <?php if ($config_review_guest) { ?>
                      <input type="radio" name="config_review_guest" value="1" checked="checked" />
                      <?php echo $text_yes; ?>
                      <?php } else { ?>
                      <input type="radio" name="config_review_guest" value="1" />
                      <?php echo $text_yes; ?>
                      <?php } ?>
                    </label>
                    <label class="radio-inline">
                      <?php if (!$config_review_guest) { ?>
                      <input type="radio" name="config_review_guest" value="0" checked="checked" />
                      <?php echo $text_no; ?>
                      <?php } else { ?>
                      <input type="radio" name="config_review_guest" value="0" />
                      <?php echo $text_no; ?>
                      <?php } ?>
                    </label>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_review_mail; ?>"><?php echo $entry_review_mail; ?></span></label>
                  <div class="col-sm-10">
                    <label class="radio-inline">
                      <?php if ($config_review_mail) { ?>
                      <input type="radio" name="config_review_mail" value="1" checked="checked" />
                      <?php echo $text_yes; ?>
                      <?php } else { ?>
                      <input type="radio" name="config_review_mail" value="1" />
                      <?php echo $text_yes; ?>
                      <?php } ?>
                    </label>
                    <label class="radio-inline">
                      <?php if (!$config_review_mail) { ?>
                      <input type="radio" name="config_review_mail" value="0" checked="checked" />
                      <?php echo $text_no; ?>
                      <?php } else { ?>
                      <input type="radio" name="config_review_mail" value="0" />
                      <?php echo $text_no; ?>
                      <?php } ?>
                    </label>
                  </div>
                </div>
              </fieldset>
              <fieldset>
                <legend><?php echo $text_voucher; ?></legend>
                <div class="form-group required">
                  <label class="col-sm-2 control-label" for="input-voucher-min"><span data-toggle="tooltip" title="<?php echo $help_voucher_min; ?>"><?php echo $entry_voucher_min; ?></span></label>
                  <div class="col-sm-10">
                    <input type="text" name="config_voucher_min" value="<?php echo $config_voucher_min; ?>" placeholder="<?php echo $entry_voucher_min; ?>" id="input-voucher-min" class="form-control" />
                    <?php if ($error_voucher_min) { ?>
                    <div class="text-danger"><?php echo $error_voucher_min; ?></div>
                    <?php } ?>
                  </div>
                </div>
                <div class="form-group required">
                  <label class="col-sm-2 control-label" for="input-voucher-max"><span data-toggle="tooltip" title="<?php echo $help_voucher_max; ?>"><?php echo $entry_voucher_max; ?></span></label>
                  <div class="col-sm-10">
                    <input type="text" name="config_voucher_max" value="<?php echo $config_voucher_max; ?>" placeholder="<?php echo $entry_voucher_max; ?>" id="input-voucher-max" class="form-control" />
                    <?php if ($error_voucher_max) { ?>
                    <div class="text-danger"><?php echo $error_voucher_max; ?></div>
                    <?php } ?>
                  </div>
                </div>
              </fieldset>
              <fieldset>
                <legend><?php echo $text_tax; ?></legend>
                <div class="form-group">
                  <label class="col-sm-2 control-label"><?php echo $entry_tax; ?></label>
                  <div class="col-sm-10">
                    <label class="radio-inline">
                      <?php if ($config_tax) { ?>
                      <input type="radio" name="config_tax" value="1" checked="checked" />
                      <?php echo $text_yes; ?>
                      <?php } else { ?>
                      <input type="radio" name="config_tax" value="1" />
                      <?php echo $text_yes; ?>
                      <?php } ?>
                    </label>
                    <label class="radio-inline">
                      <?php if (!$config_tax) { ?>
                      <input type="radio" name="config_tax" value="0" checked="checked" />
                      <?php echo $text_no; ?>
                      <?php } else { ?>
                      <input type="radio" name="config_tax" value="0" />
                      <?php echo $text_no; ?>
                      <?php } ?>
                    </label>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-tax-default"><span data-toggle="tooltip" title="<?php echo $help_tax_default; ?>"><?php echo $entry_tax_default; ?></span></label>
                  <div class="col-sm-10">
                    <select name="config_tax_default" id="input-tax-default" class="form-control">
                      <option value=""><?php echo $text_none; ?></option>
                      <?php  if ($config_tax_default == 'shipping') { ?>
                      <option value="shipping" selected="selected"><?php echo $text_shipping; ?></option>
                      <?php } else { ?>
                      <option value="shipping"><?php echo $text_shipping; ?></option>
                      <?php } ?>
                      <?php  if ($config_tax_default == 'payment') { ?>
                      <option value="payment" selected="selected"><?php echo $text_payment; ?></option>
                      <?php } else { ?>
                      <option value="payment"><?php echo $text_payment; ?></option>
                      <?php } ?>
                    </select>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-tax-customer"><span data-toggle="tooltip" title="<?php echo $help_tax_customer; ?>"><?php echo $entry_tax_customer; ?></span></label>
                  <div class="col-sm-10">
                    <select name="config_tax_customer" id="input-tax-customer" class="form-control">
                      <option value=""><?php echo $text_none; ?></option>
                      <?php  if ($config_tax_customer == 'shipping') { ?>
                      <option value="shipping" selected="selected"><?php echo $text_shipping; ?></option>
                      <?php } else { ?>
                      <option value="shipping"><?php echo $text_shipping; ?></option>
                      <?php } ?>
                      <?php  if ($config_tax_customer == 'payment') { ?>
                      <option value="payment" selected="selected"><?php echo $text_payment; ?></option>
                      <?php } else { ?>
                      <option value="payment"><?php echo $text_payment; ?></option>
                      <?php } ?>
                    </select>
                  </div>
                </div>
              </fieldset>
              <fieldset>
                <legend><?php echo $text_account; ?></legend>
                <div class="form-group">
                  <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_customer_online; ?>"><?php echo $entry_customer_online; ?></span></label>
                  <div class="col-sm-10">
                    <label class="radio-inline">
                      <?php if ($config_customer_online) { ?>
                      <input type="radio" name="config_customer_online" value="1" checked="checked" />
                      <?php echo $text_yes; ?>
                      <?php } else { ?>
                      <input type="radio" name="config_customer_online" value="1" />
                      <?php echo $text_yes; ?>
                      <?php } ?>
                    </label>
                    <label class="radio-inline">
                      <?php if (!$config_customer_online) { ?>
                      <input type="radio" name="config_customer_online" value="0" checked="checked" />
                      <?php echo $text_no; ?>
                      <?php } else { ?>
                      <input type="radio" name="config_customer_online" value="0" />
                      <?php echo $text_no; ?>
                      <?php } ?>
                    </label>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-customer-group"><span data-toggle="tooltip" title="<?php echo $help_customer_group; ?>"><?php echo $entry_customer_group; ?></span></label>
                  <div class="col-sm-10">
                    <select name="config_customer_group_id" id="input-customer-group" class="form-control">
                      <?php foreach ($customer_groups as $customer_group) { ?>
                      <?php if ($customer_group['customer_group_id'] == $config_customer_group_id) { ?>
                      <option value="<?php echo $customer_group['customer_group_id']; ?>" selected="selected"><?php echo $customer_group['name']; ?></option>
                      <?php } else { ?>
                      <option value="<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></option>
                      <?php } ?>
                      <?php } ?>
                    </select>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_customer_group_display; ?>"><?php echo $entry_customer_group_display; ?></span></label>
                  <div class="col-sm-10">
                    <?php foreach ($customer_groups as $customer_group) { ?>
                    <div class="checkbox">
                      <label>
                        <?php if (in_array($customer_group['customer_group_id'], $config_customer_group_display)) { ?>
                        <input type="checkbox" name="config_customer_group_display[]" value="<?php echo $customer_group['customer_group_id']; ?>" checked="checked" />
                        <?php echo $customer_group['name']; ?>
                        <?php } else { ?>
                        <input type="checkbox" name="config_customer_group_display[]" value="<?php echo $customer_group['customer_group_id']; ?>" />
                        <?php echo $customer_group['name']; ?>
                        <?php } ?>
                      </label>
                    </div>
                    <?php } ?>
                    <?php if ($error_customer_group_display) { ?>
                    <div class="text-danger"><?php echo $error_customer_group_display; ?></div>
                    <?php } ?>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_customer_price; ?>"><?php echo $entry_customer_price; ?></span></label>
                  <div class="col-sm-10">
                    <label class="radio-inline">
                      <?php if ($config_customer_price) { ?>
                      <input type="radio" name="config_customer_price" value="1" checked="checked" />
                      <?php echo $text_yes; ?>
                      <?php } else { ?>
                      <input type="radio" name="config_customer_price" value="1" />
                      <?php echo $text_yes; ?>
                      <?php } ?>
                    </label>
                    <label class="radio-inline">
                      <?php if (!$config_customer_price) { ?>
                      <input type="radio" name="config_customer_price" value="0" checked="checked" />
                      <?php echo $text_no; ?>
                      <?php } else { ?>
                      <input type="radio" name="config_customer_price" value="0" />
                      <?php echo $text_no; ?>
                      <?php } ?>
                    </label>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-login-attempts"><span data-toggle="tooltip" title="<?php echo $help_login_attempts; ?>"><?php echo $entry_login_attempts; ?></span></label>
                  <div class="col-sm-10">
                    <input type="text" name="config_login_attempts" value="<?php echo $config_login_attempts; ?>" placeholder="<?php echo $entry_login_attempts; ?>" id="input-login-attempts" class="form-control" />
                    <?php if ($error_login_attempts) { ?>
                    <div class="text-danger"><?php echo $error_login_attempts; ?></div>
                    <?php } ?>                  
                  </div>
                </div>                
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-account"><span data-toggle="tooltip" title="<?php echo $help_account; ?>"><?php echo $entry_account; ?></span></label>
                  <div class="col-sm-10">
                    <select name="config_account_id" id="input-account" class="form-control">
                      <option value="0"><?php echo $text_none; ?></option>
                      <?php foreach ($informations as $information) { ?>
                      <?php if ($information['information_id'] == $config_account_id) { ?>
                      <option value="<?php echo $information['information_id']; ?>" selected="selected"><?php echo $information['title']; ?></option>
                      <?php } else { ?>
                      <option value="<?php echo $information['information_id']; ?>"><?php echo $information['title']; ?></option>
                      <?php } ?>
                      <?php } ?>
                    </select>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_account_mail; ?>"><?php echo $entry_account_mail; ?></span></label>
                  <div class="col-sm-10">
                    <label class="radio-inline">
                      <?php if ($config_account_mail) { ?>
                      <input type="radio" name="config_account_mail" value="1" checked="checked" />
                      <?php echo $text_yes; ?>
                      <?php } else { ?>
                      <input type="radio" name="config_account_mail" value="1" />
                      <?php echo $text_yes; ?>
                      <?php } ?>
                    </label>
                    <label class="radio-inline">
                      <?php if (!$config_account_mail) { ?>
                      <input type="radio" name="config_account_mail" value="0" checked="checked" />
                      <?php echo $text_no; ?>
                      <?php } else { ?>
                      <input type="radio" name="config_account_mail" value="0" />
                      <?php echo $text_no; ?>
                      <?php } ?>
                    </label>
                  </div>
                </div>
              </fieldset>
              <fieldset>
                <legend><?php echo $text_checkout; ?></legend>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-invoice-prefix"><span data-toggle="tooltip" title="<?php echo $help_invoice_prefix; ?>"><?php echo $entry_invoice_prefix; ?></span></label>
                  <div class="col-sm-10">
                    <input type="text" name="config_invoice_prefix" value="<?php echo $config_invoice_prefix; ?>" placeholder="<?php echo $entry_invoice_prefix; ?>" id="input-invoice-prefix" class="form-control" />
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-api"><span data-toggle="tooltip" title="<?php echo $help_api; ?>"><?php echo $entry_api; ?></span></label>
                  <div class="col-sm-10">
                    <select name="config_api_id" id="input-api" class="form-control">
                      <option value="0"><?php echo $text_none; ?></option>
                      <?php foreach ($apis as $api) { ?>
                      <?php if ($api['api_id'] == $config_api_id) { ?>
                      <option value="<?php echo $api['api_id']; ?>" selected="selected"><?php echo $api['username']; ?></option>
                      <?php } else { ?>
                      <option value="<?php echo $api['api_id']; ?>"><?php echo $api['username']; ?></option>
                      <?php } ?>
                      <?php } ?>
                    </select>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_cart_weight; ?>"><?php echo $entry_cart_weight; ?></span></label>
                  <div class="col-sm-10">
                    <label class="radio-inline">
                      <?php if ($config_cart_weight) { ?>
                      <input type="radio" name="config_cart_weight" value="1" checked="checked" />
                      <?php echo $text_yes; ?>
                      <?php } else { ?>
                      <input type="radio" name="config_cart_weight" value="1" />
                      <?php echo $text_yes; ?>
                      <?php } ?>
                    </label>
                    <label class="radio-inline">
                      <?php if (!$config_cart_weight) { ?>
                      <input type="radio" name="config_cart_weight" value="0" checked="checked" />
                      <?php echo $text_no; ?>
                      <?php } else { ?>
                      <input type="radio" name="config_cart_weight" value="0" />
                      <?php echo $text_no; ?>
                      <?php } ?>
                    </label>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_checkout_guest; ?>"><?php echo $entry_checkout_guest; ?></span></label>
                  <div class="col-sm-10">
                    <label class="radio-inline">
                      <?php if ($config_checkout_guest) { ?>
                      <input type="radio" name="config_checkout_guest" value="1" checked="checked" />
                      <?php echo $text_yes; ?>
                      <?php } else { ?>
                      <input type="radio" name="config_checkout_guest" value="1" />
                      <?php echo $text_yes; ?>
                      <?php } ?>
                    </label>
                    <label class="radio-inline">
                      <?php if (!$config_checkout_guest) { ?>
                      <input type="radio" name="config_checkout_guest" value="0" checked="checked" />
                      <?php echo $text_no; ?>
                      <?php } else { ?>
                      <input type="radio" name="config_checkout_guest" value="0" />
                      <?php echo $text_no; ?>
                      <?php } ?>
                    </label>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-checkout"><span data-toggle="tooltip" title="<?php echo $help_checkout; ?>"><?php echo $entry_checkout; ?></span></label>
                  <div class="col-sm-10">
                    <select name="config_checkout_id" id="input-checkout" class="form-control">
                      <option value="0"><?php echo $text_none; ?></option>
                      <?php foreach ($informations as $information) { ?>
                      <?php if ($information['information_id'] == $config_checkout_id) { ?>
                      <option value="<?php echo $information['information_id']; ?>" selected="selected"><?php echo $information['title']; ?></option>
                      <?php } else { ?>
                      <option value="<?php echo $information['information_id']; ?>"><?php echo $information['title']; ?></option>
                      <?php } ?>
                      <?php } ?>
                    </select>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-order-status"><span data-toggle="tooltip" title="<?php echo $help_order_status; ?>"><?php echo $entry_order_status; ?></span></label>
                  <div class="col-sm-10">
                    <select name="config_order_status_id" id="input-order-status" class="form-control">
                      <?php foreach ($order_statuses as $order_status) { ?>
                      <?php if ($order_status['order_status_id'] == $config_order_status_id) { ?>
                      <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                      <?php } else { ?>
                      <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                      <?php } ?>
                      <?php } ?>
                    </select>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-process-status"><span data-toggle="tooltip" title="<?php echo $help_processing_status; ?>"><?php echo $entry_processing_status; ?></span></label>
                  <div class="col-sm-10">
                    <div class="well well-sm" style="height: 150px; overflow: auto;">
                      <?php foreach ($order_statuses as $order_status) { ?>
                      <div class="checkbox">
                        <label>
                          <?php if (in_array($order_status['order_status_id'], $config_processing_status)) { ?>
                          <input type="checkbox" name="config_processing_status[]" value="<?php echo $order_status['order_status_id']; ?>" checked="checked" />
                          <?php echo $order_status['name']; ?>
                          <?php } else { ?>
                          <input type="checkbox" name="config_processing_status[]" value="<?php echo $order_status['order_status_id']; ?>" />
                          <?php echo $order_status['name']; ?>
                          <?php } ?>
                        </label>
                      </div>
                      <?php } ?>
                    </div>
                    <?php if ($error_processing_status) { ?>
                    <div class="text-danger"><?php echo $error_processing_status; ?></div>
                    <?php } ?>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-complete-status"><span data-toggle="tooltip" title="<?php echo $help_complete_status; ?>"><?php echo $entry_complete_status; ?></span></label>
                  <div class="col-sm-10">
                    <div class="well well-sm" style="height: 150px; overflow: auto;">
                      <?php foreach ($order_statuses as $order_status) { ?>
                      <div class="checkbox">
                        <label>
                          <?php if (in_array($order_status['order_status_id'], $config_complete_status)) { ?>
                          <input type="checkbox" name="config_complete_status[]" value="<?php echo $order_status['order_status_id']; ?>" checked="checked" />
                          <?php echo $order_status['name']; ?>
                          <?php } else { ?>
                          <input type="checkbox" name="config_complete_status[]" value="<?php echo $order_status['order_status_id']; ?>" />
                          <?php echo $order_status['name']; ?>
                          <?php } ?>
                        </label>
                      </div>
                      <?php } ?>
                    </div>
                    <?php if ($error_complete_status) { ?>
                    <div class="text-danger"><?php echo $error_complete_status; ?></div>
                    <?php } ?>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_order_mail; ?>"><?php echo $entry_order_mail; ?></span></label>
                  <div class="col-sm-10">
                    <label class="radio-inline">
                      <?php if ($config_order_mail) { ?>
                      <input type="radio" name="config_order_mail" value="1" checked="checked" />
                      <?php echo $text_yes; ?>
                      <?php } else { ?>
                      <input type="radio" name="config_order_mail" value="1" />
                      <?php echo $text_yes; ?>
                      <?php } ?>
                    </label>
                    <label class="radio-inline">
                      <?php if (!$config_order_mail) { ?>
                      <input type="radio" name="config_order_mail" value="0" checked="checked" />
                      <?php echo $text_no; ?>
                      <?php } else { ?>
                      <input type="radio" name="config_order_mail" value="0" />
                      <?php echo $text_no; ?>
                      <?php } ?>
                    </label>
                  </div>
                </div>
              </fieldset>
              <fieldset>
                <legend><?php echo $text_stock; ?></legend>
                <div class="form-group">
                  <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_stock_display; ?>"><?php echo $entry_stock_display; ?></span></label>
                  <div class="col-sm-10">
                    <label class="radio-inline">
                      <?php if ($config_stock_display) { ?>
                      <input type="radio" name="config_stock_display" value="1" checked="checked" />
                      <?php echo $text_yes; ?>
                      <?php } else { ?>
                      <input type="radio" name="config_stock_display" value="1" />
                      <?php echo $text_yes; ?>
                      <?php } ?>
                    </label>
                    <label class="radio-inline">
                      <?php if (!$config_stock_display) { ?>
                      <input type="radio" name="config_stock_display" value="0" checked="checked" />
                      <?php echo $text_no; ?>
                      <?php } else { ?>
                      <input type="radio" name="config_stock_display" value="0" />
                      <?php echo $text_no; ?>
                      <?php } ?>
                    </label>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_stock_warning; ?>"><?php echo $entry_stock_warning; ?></span></label>
                  <div class="col-sm-10">
                    <label class="radio-inline">
                      <?php if ($config_stock_warning) { ?>
                      <input type="radio" name="config_stock_warning" value="1" checked="checked" />
                      <?php echo $text_yes; ?>
                      <?php } else { ?>
                      <input type="radio" name="config_stock_warning" value="1" />
                      <?php echo $text_yes; ?>
                      <?php } ?>
                    </label>
                    <label class="radio-inline">
                      <?php if (!$config_stock_warning) { ?>
                      <input type="radio" name="config_stock_warning" value="0" checked="checked" />
                      <?php echo $text_no; ?>
                      <?php } else { ?>
                      <input type="radio" name="config_stock_warning" value="0" />
                      <?php echo $text_no; ?>
                      <?php } ?>
                    </label>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_stock_checkout; ?>"><?php echo $entry_stock_checkout; ?></span></label>
                  <div class="col-sm-10">
                    <label class="radio-inline">
                      <?php if ($config_stock_checkout) { ?>
                      <input type="radio" name="config_stock_checkout" value="1" checked="checked" />
                      <?php echo $text_yes; ?>
                      <?php } else { ?>
                      <input type="radio" name="config_stock_checkout" value="1" />
                      <?php echo $text_yes; ?>
                      <?php } ?>
                    </label>
                    <label class="radio-inline">
                      <?php if (!$config_stock_checkout) { ?>
                      <input type="radio" name="config_stock_checkout" value="0" checked="checked" />
                      <?php echo $text_no; ?>
                      <?php } else { ?>
                      <input type="radio" name="config_stock_checkout" value="0" />
                      <?php echo $text_no; ?>
                      <?php } ?>
                    </label>
                  </div>
                </div>
              </fieldset>
              <fieldset>
                <legend><?php echo $text_affiliate; ?></legend>
                <div class="form-group">
                  <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_affiliate_approval; ?>"><?php echo $entry_affiliate_approval; ?></span></label>
                  <div class="col-sm-10">
                    <label class="radio-inline">
                      <?php if ($config_affiliate_approval) { ?>
                      <input type="radio" name="config_affiliate_approval" value="1" checked="checked" />
                      <?php echo $text_yes; ?>
                      <?php } else { ?>
                      <input type="radio" name="config_affiliate_approval" value="1" />
                      <?php echo $text_yes; ?>
                      <?php } ?>
                    </label>
                    <label class="radio-inline">
                      <?php if (!$config_affiliate_approval) { ?>
                      <input type="radio" name="config_affiliate_approval" value="0" checked="checked" />
                      <?php echo $text_no; ?>
                      <?php } else { ?>
                      <input type="radio" name="config_affiliate_approval" value="0" />
                      <?php echo $text_no; ?>
                      <?php } ?>
                    </label>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_affiliate_auto; ?>"><?php echo $entry_affiliate_auto; ?></span></label>
                  <div class="col-sm-10">
                    <label class="radio-inline">
                      <?php if ($config_stock_checkout) { ?>
                      <input type="radio" name="config_affiliate_auto" value="1" checked="checked" />
                      <?php echo $text_yes; ?>
                      <?php } else { ?>
                      <input type="radio" name="config_affiliate_auto" value="1" />
                      <?php echo $text_yes; ?>
                      <?php } ?>
                    </label>
                    <label class="radio-inline">
                      <?php if (!$config_stock_checkout) { ?>
                      <input type="radio" name="config_affiliate_auto" value="0" checked="checked" />
                      <?php echo $text_no; ?>
                      <?php } else { ?>
                      <input type="radio" name="config_affiliate_auto" value="0" />
                      <?php echo $text_no; ?>
                      <?php } ?>
                    </label>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-affiliate-commission"><span data-toggle="tooltip" title="<?php echo $help_affiliate_commission; ?>"><?php echo $entry_affiliate_commission; ?></span></label>
                  <div class="col-sm-10">
                    <input type="text" name="config_affiliate_commission" value="<?php echo $config_affiliate_commission; ?>" placeholder="<?php echo $entry_affiliate_commission; ?>" id="input-affiliate-commission" class="form-control" />
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-affiliate"><span data-toggle="tooltip" title="<?php echo $help_affiliate; ?>"><?php echo $entry_affiliate; ?></span></label>
                  <div class="col-sm-10">
                    <select name="config_affiliate_id" id="input-affiliate" class="form-control">
                      <option value="0"><?php echo $text_none; ?></option>
                      <?php foreach ($informations as $information) { ?>
                      <?php if ($information['information_id'] == $config_affiliate_id) { ?>
                      <option value="<?php echo $information['information_id']; ?>" selected="selected"><?php echo $information['title']; ?></option>
                      <?php } else { ?>
                      <option value="<?php echo $information['information_id']; ?>"><?php echo $information['title']; ?></option>
                      <?php } ?>
                      <?php } ?>
                    </select>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_affiliate_mail; ?>"><?php echo $entry_affiliate_mail; ?></span></label>
                  <div class="col-sm-10">
                    <label class="radio-inline">
                      <?php if ($config_affiliate_mail) { ?>
                      <input type="radio" name="config_affiliate_mail" value="1" checked="checked" />
                      <?php echo $text_yes; ?>
                      <?php } else { ?>
                      <input type="radio" name="config_affiliate_mail" value="1" />
                      <?php echo $text_yes; ?>
                      <?php } ?>
                    </label>
                    <label class="radio-inline">
                      <?php if (!$config_affiliate_mail) { ?>
                      <input type="radio" name="config_affiliate_mail" value="0" checked="checked" />
                      <?php echo $text_no; ?>
                      <?php } else { ?>
                      <input type="radio" name="config_affiliate_mail" value="0" />
                      <?php echo $text_no; ?>
                      <?php } ?>
                    </label>
                  </div>
                </div>
              </fieldset>
              <fieldset>
                <legend><?php echo $text_return; ?></legend>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-return"><span data-toggle="tooltip" title="<?php echo $help_return; ?>"><?php echo $entry_return; ?></span></label>
                  <div class="col-sm-10">
                    <select name="config_return_id" id="input-return" class="form-control">
                      <option value="0"><?php echo $text_none; ?></option>
                      <?php foreach ($informations as $information) { ?>
                      <?php if ($information['information_id'] == $config_return_id) { ?>
                      <option value="<?php echo $information['information_id']; ?>" selected="selected"><?php echo $information['title']; ?></option>
                      <?php } else { ?>
                      <option value="<?php echo $information['information_id']; ?>"><?php echo $information['title']; ?></option>
                      <?php } ?>
                      <?php } ?>
                    </select>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-return-status"><span data-toggle="tooltip" title="<?php echo $help_return_status; ?>"><?php echo $entry_return_status; ?></span></label>
                  <div class="col-sm-10">
                    <select name="config_return_status_id" id="input-return-status" class="form-control">
                      <?php foreach ($return_statuses as $return_status) { ?>
                      <?php if ($return_status['return_status_id'] == $config_return_status_id) { ?>
                      <option value="<?php echo $return_status['return_status_id']; ?>" selected="selected"><?php echo $return_status['name']; ?></option>
                      <?php } else { ?>
                      <option value="<?php echo $return_status['return_status_id']; ?>"><?php echo $return_status['name']; ?></option>
                      <?php } ?>
                      <?php } ?>
                    </select>
                  </div>
                </div>
              </fieldset>
            </div>
            <div class="tab-pane" id="tab-image">
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-logo"><?php echo $entry_logo; ?></label>
                <div class="col-sm-10"><a href="" id="thumb-logo" data-toggle="image" class="img-thumbnail"><img src="<?php echo $logo; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a>
                  <input type="hidden" name="config_logo" value="<?php echo $config_logo; ?>" id="input-logo" />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-icon"><?php echo $entry_icon; ?></label>
                <div class="col-sm-10"><a href="" id="thumb-icon" data-toggle="image" class="img-thumbnail"><img src="<?php echo $icon; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a>
                  <input type="hidden" name="config_icon" value="<?php echo $config_icon; ?>" id="input-icon" />
                </div>
              </div>
              <div class="form-group required">
                <label class="col-sm-2 control-label" for="input-image-category-width"><?php echo $entry_image_category; ?></label>
                <div class="col-sm-10">
                  <div class="row">
                    <div class="col-sm-6">
                      <input type="text" name="config_image_category_width" value="<?php echo $config_image_category_width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-image-category-width" class="form-control" />
                    </div>
                    <div class="col-sm-6">
                      <input type="text" name="config_image_category_height" value="<?php echo $config_image_category_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
                    </div>
                  </div>
                  <?php if ($error_image_category) { ?>
                  <div class="text-danger"><?php echo $error_image_category; ?></div>
                  <?php } ?>
                </div>
              </div>
              <div class="form-group required">
                <label class="col-sm-2 control-label" for="input-image-thumb-width"><?php echo $entry_image_thumb; ?></label>
                <div class="col-sm-10">
                  <div class="row">
                    <div class="col-sm-6">
                      <input type="text" name="config_image_thumb_width" value="<?php echo $config_image_thumb_width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-image-thumb-width" class="form-control" />
                    </div>
                    <div class="col-sm-6">
                      <input type="text" name="config_image_thumb_height" value="<?php echo $config_image_thumb_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
                    </div>
                  </div>
                  <?php if ($error_image_thumb) { ?>
                  <div class="text-danger"><?php echo $error_image_thumb; ?></div>
                  <?php } ?>
                </div>
              </div>
              <div class="form-group required">
                <label class="col-sm-2 control-label" for="input-image-popup-width"><?php echo $entry_image_popup; ?></label>
                <div class="col-sm-10">
                  <div class="row">
                    <div class="col-sm-6">
                      <input type="text" name="config_image_popup_width" value="<?php echo $config_image_popup_width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-image-popup-width" class="form-control" />
                    </div>
                    <div class="col-sm-6">
                      <input type="text" name="config_image_popup_height" value="<?php echo $config_image_popup_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
                    </div>
                  </div>
                  <?php if ($error_image_popup) { ?>
                  <div class="text-danger"><?php echo $error_image_popup; ?></div>
                  <?php } ?>
                </div>
              </div>
              <div class="form-group required">
                <label class="col-sm-2 control-label" for="input-image-product-width"><?php echo $entry_image_product; ?></label>
                <div class="col-sm-10">
                  <div class="row">
                    <div class="col-sm-6">
                      <input type="text" name="config_image_product_width" value="<?php echo $config_image_product_width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-image-product-width" class="form-control" />
                    </div>
                    <div class="col-sm-6">
                      <input type="text" name="config_image_product_height" value="<?php echo $config_image_product_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
                    </div>
                  </div>
                  <?php if ($error_image_product) { ?>
                  <div class="text-danger"><?php echo $error_image_product; ?></div>
                  <?php } ?>
                </div>
              </div>
              <div class="form-group required">
                <label class="col-sm-2 control-label" for="input-image-additional-width"><?php echo $entry_image_additional; ?></label>
                <div class="col-sm-10">
                  <div class="row">
                    <div class="col-sm-6">
                      <input type="text" name="config_image_additional_width" value="<?php echo $config_image_additional_width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-image-additional-width" class="form-control" />
                    </div>
                    <div class="col-sm-6">
                      <input type="text" name="config_image_additional_height" value="<?php echo $config_image_additional_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
                    </div>
                  </div>
                  <?php if ($error_image_additional) { ?>
                  <div class="text-danger"><?php echo $error_image_additional; ?></div>
                  <?php } ?>
                </div>
              </div>
              <div class="form-group required">
                <label class="col-sm-2 control-label" for="input-image-related"><?php echo $entry_image_related; ?></label>
                <div class="col-sm-10">
                  <div class="row">
                    <div class="col-sm-6">
                      <input type="text" name="config_image_related_width" value="<?php echo $config_image_related_width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-image-related" class="form-control" />
                    </div>
                    <div class="col-sm-6">
                      <input type="text" name="config_image_related_height" value="<?php echo $config_image_related_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
                    </div>
                  </div>
                  <?php if ($error_image_related) { ?>
                  <div class="text-danger"><?php echo $error_image_related; ?></div>
                  <?php } ?>
                </div>
              </div>
              <div class="form-group required">
                <label class="col-sm-2 control-label" for="input-image-compare"><?php echo $entry_image_compare; ?></label>
                <div class="col-sm-10">
                  <div class="row">
                    <div class="col-sm-6">
                      <input type="text" name="config_image_compare_width" value="<?php echo $config_image_compare_width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-image-compare" class="form-control" />
                    </div>
                    <div class="col-sm-6">
                      <input type="text" name="config_image_compare_height" value="<?php echo $config_image_compare_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
                    </div>
                  </div>
                  <?php if ($error_image_compare) { ?>
                  <div class="text-danger"><?php echo $error_image_compare; ?></div>
                  <?php } ?>
                </div>
              </div>
              <div class="form-group required">
                <label class="col-sm-2 control-label" for="input-image-wishlist"><?php echo $entry_image_wishlist; ?></label>
                <div class="col-sm-10">
                  <div class="row">
                    <div class="col-sm-6">
                      <input type="text" name="config_image_wishlist_width" value="<?php echo $config_image_wishlist_width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-image-wishlist" class="form-control" />
                    </div>
                    <div class="col-sm-6">
                      <input type="text" name="config_image_wishlist_height" value="<?php echo $config_image_wishlist_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
                    </div>
                  </div>
                  <?php if ($error_image_wishlist) { ?>
                  <div class="text-danger"><?php echo $error_image_wishlist; ?></div>
                  <?php } ?>
                </div>
              </div>
              <div class="form-group required">
                <label class="col-sm-2 control-label" for="input-image-cart"><?php echo $entry_image_cart; ?></label>
                <div class="col-sm-10">
                  <div class="row">
                    <div class="col-sm-6">
                      <input type="text" name="config_image_cart_width" value="<?php echo $config_image_cart_width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-image-cart" class="form-control" />
                    </div>
                    <div class="col-sm-6">
                      <input type="text" name="config_image_cart_height" value="<?php echo $config_image_cart_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
                    </div>
                  </div>
                  <?php if ($error_image_cart) { ?>
                  <div class="text-danger"><?php echo $error_image_cart; ?></div>
                  <?php } ?>
                </div>
              </div>
              <div class="form-group required">
                <label class="col-sm-2 control-label" for="input-image-location"><?php echo $entry_image_location; ?></label>
                <div class="col-sm-10">
                  <div class="row">
                    <div class="col-sm-6">
                      <input type="text" name="config_image_location_width" value="<?php echo $config_image_location_width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-image-location" class="form-control" />
                    </div>
                    <div class="col-sm-6">
                      <input type="text" name="config_image_location_height" value="<?php echo $config_image_location_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
                    </div>
                  </div>
                  <?php if ($error_image_location) { ?>
                  <div class="text-danger"><?php echo $error_image_location; ?></div>
                  <?php } ?>
                </div>
              </div>
            </div>
            <div class="tab-pane" id="tab-ftp">
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-ftp-host"><?php echo $entry_ftp_hostname; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="config_ftp_hostname" value="<?php echo $config_ftp_hostname; ?>" placeholder="<?php echo $entry_ftp_hostname; ?>" id="input-ftp-host" class="form-control" />
                  <?php if ($error_ftp_hostname) { ?>
                  <div class="text-danger"><?php echo $error_ftp_hostname; ?></div>
                  <?php } ?>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-ftp-port"><?php echo $entry_ftp_port; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="config_ftp_port" value="<?php echo $config_ftp_port; ?>" placeholder="<?php echo $entry_ftp_port; ?>" id="input-ftp-port" class="form-control" />
                  <?php if ($error_ftp_port) { ?>
                  <div class="text-danger"><?php echo $error_ftp_port; ?></div>
                  <?php } ?>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-ftp-username"><?php echo $entry_ftp_username; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="config_ftp_username" value="<?php echo $config_ftp_username; ?>" placeholder="<?php echo $entry_ftp_username; ?>" id="input-ftp-username" class="form-control" />
                  <?php if ($error_ftp_username) { ?>
                  <div class="text-danger"><?php echo $error_ftp_username; ?></div>
                  <?php } ?>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-ftp-password"><?php echo $entry_ftp_password; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="config_ftp_password" value="<?php echo $config_ftp_password; ?>" placeholder="<?php echo $entry_ftp_password; ?>" id="input-ftp-password" class="form-control" />
                  <?php if ($error_ftp_password) { ?>
                  <div class="text-danger"><?php echo $error_ftp_password; ?></div>
                  <?php } ?>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-ftp-root"><span data-toggle="tooltip" data-html="true" title="<?php echo htmlspecialchars($help_ftp_root); ?>"><?php echo $entry_ftp_root; ?></span></label>
                <div class="col-sm-10">
                  <input type="text" name="config_ftp_root" value="<?php echo $config_ftp_root; ?>" placeholder="<?php echo $entry_ftp_root; ?>" id="input-ftp-root" class="form-control" />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $entry_ftp_status; ?></label>
                <div class="col-sm-10">
                  <label class="radio-inline">
                    <?php if ($config_ftp_status) { ?>
                    <input type="radio" name="config_ftp_status" value="1" checked="checked" />
                    <?php echo $text_yes; ?>
                    <?php } else { ?>
                    <input type="radio" name="config_ftp_status" value="1" />
                    <?php echo $text_yes; ?>
                    <?php } ?>
                  </label>
                  <label class="radio-inline">
                    <?php if (!$config_ftp_status) { ?>
                    <input type="radio" name="config_ftp_status" value="0" checked="checked" />
                    <?php echo $text_no; ?>
                    <?php } else { ?>
                    <input type="radio" name="config_ftp_status" value="0" />
                    <?php echo $text_no; ?>
                    <?php } ?>
                  </label>
                </div>
              </div>
            </div>
            <div class="tab-pane" id="tab-mail">
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-mail-protocol"><span data-toggle="tooltip" title="<?php echo $help_mail_protocol; ?>"><?php echo $entry_mail_protocol; ?></span></label>
                <div class="col-sm-10">
                  <select name="config_mail[protocol]" id="input-mail-protocol" class="form-control">
                    <?php if ($config_mail_protocol == 'mail') { ?>
                    <option value="mail" selected="selected"><?php echo $text_mail; ?></option>
                    <?php } else { ?>
                    <option value="mail"><?php echo $text_mail; ?></option>
                    <?php } ?>
                    <?php if ($config_mail_protocol == 'smtp') { ?>
                    <option value="smtp" selected="selected"><?php echo $text_smtp; ?></option>
                    <?php } else { ?>
                    <option value="smtp"><?php echo $text_smtp; ?></option>
                    <?php } ?>
                  </select>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-mail-parameter"><span data-toggle="tooltip" title="<?php echo $help_mail_parameter; ?>"><?php echo $entry_mail_parameter; ?></span></label>
                <div class="col-sm-10">
                  <input type="text" name="config_mail[parameter]" value="<?php echo $config_mail_parameter; ?>" placeholder="<?php echo $entry_mail_parameter; ?>" id="input-mail-parameter" class="form-control" />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-smtp-hostname"><span data-toggle="tooltip" title="<?php echo $help_mail_smtp_hostname; ?>"><?php echo $entry_smtp_hostname; ?></span></label>
                <div class="col-sm-10">
                  <input type="text" name="config_mail[smtp_hostname]" value="<?php echo $config_smtp_hostname; ?>" placeholder="<?php echo $entry_smtp_hostname; ?>" id="input-smtp-hostname" class="form-control" />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-smtp-username"><?php echo $entry_smtp_username; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="config_mail[smtp_username]" value="<?php echo $config_smtp_username; ?>" placeholder="<?php echo $entry_smtp_username; ?>" id="input-smtp-username" class="form-control" />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-smtp-password"><?php echo $entry_smtp_password; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="config_mail[smtp_password]" value="<?php echo $config_smtp_password; ?>" placeholder="<?php echo $entry_smtp_password; ?>" id="input-smtp-password" class="form-control" />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-smtp-port"><?php echo $entry_smtp_port; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="config_mail[smtp_port]" value="<?php echo $config_smtp_port; ?>" placeholder="<?php echo $entry_smtp_port; ?>" id="input-smtp-port" class="form-control" />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-smtp-timeout"><?php echo $entry_smtp_timeout; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="config_mail[smtp_timeout]" value="<?php echo $config_smtp_timeout; ?>" placeholder="<?php echo $entry_smtp_timeout; ?>" id="input-smtp-timeout" class="form-control" />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-alert-email"><span data-toggle="tooltip" title="<?php echo $help_mail_alert; ?>"><?php echo $entry_mail_alert; ?></span></label>
                <div class="col-sm-10">
                  <textarea name="config_mail_alert" rows="5" placeholder="<?php echo $entry_mail_alert; ?>" id="input-alert-email" class="form-control"><?php echo $config_mail_alert; ?></textarea>
                </div>
              </div>
            </div>
            <div class="tab-pane" id="tab-fraud">
              <div class="form-group">
                <label class="col-sm-2 control-label"><span data-toggle="tooltip" data-html="true" data-trigger="click" title="<?php echo htmlspecialchars($help_fraud_detection); ?>"><?php echo $entry_fraud_detection; ?></span></label>
                <div class="col-sm-10">
                  <label class="radio-inline">
                    <?php if ($config_fraud_detection) { ?>
                    <input type="radio" name="config_fraud_detection" value="1" checked="checked" />
                    <?php echo $text_yes; ?>
                    <?php } else { ?>
                    <input type="radio" name="config_fraud_detection" value="1" />
                    <?php echo $text_yes; ?>
                    <?php } ?>
                  </label>
                  <label class="radio-inline">
                    <?php if (!$config_fraud_detection) { ?>
                    <input type="radio" name="config_fraud_detection" value="0" checked="checked" />
                    <?php echo $text_no; ?>
                    <?php } else { ?>
                    <input type="radio" name="config_fraud_detection" value="0" />
                    <?php echo $text_no; ?>
                    <?php } ?>
                  </label>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-fraud-key"><?php echo $entry_fraud_key; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="config_fraud_key" value="<?php echo $config_fraud_key; ?>" placeholder="<?php echo $entry_fraud_key; ?>" id="input-fraud-key" class="form-control" />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-fraud-score"><span data-toggle="tooltip" title="<?php echo $help_fraud_score; ?>"><?php echo $entry_fraud_score; ?></span></label>
                <div class="col-sm-10">
                  <input type="text" name="config_fraud_score" value="<?php echo $config_fraud_score; ?>" placeholder="<?php echo $entry_fraud_score; ?>" id="input-fraud-score" class="form-control" />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-fraud-status"><span data-toggle="tooltip" title="<?php echo $help_fraud_status; ?>"><?php echo $entry_fraud_status; ?></span></label>
                <div class="col-sm-10">
                  <select name="config_fraud_status_id" id="input-fraud-status" class="form-control">
                    <?php foreach ($order_statuses as $order_status) { ?>
                    <?php if ($order_status['order_status_id'] == $config_fraud_status_id) { ?>
                    <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                    <?php } ?>
                    <?php } ?>
                  </select>
                </div>
              </div>
            </div>
			<?php $vqmod_path = DIR_SYSTEM . '../vqmod/xml/'; ?>
			<div class="tab-pane" id="tab-ips">
					<link rel="stylesheet" type="text/css" href="data:text/css;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4NCi5qcXVlcnktbXNnYm94IHsgYmFja2dyb3VuZDp1cmwoZGF0YTppbWFnZS9wbmc7YmFzZTY0LGlWQk9SdzBLR2dvQUFBQU5TVWhFVWdBQUFBWUFBQUEzQ0FNQUFBQVlOTXR5QUFBQUdYUkZXSFJUYjJaMGQyRnlaUUJCWkc5aVpTQkpiV0ZuWlZKbFlXUjVjY2xsUEFBQUFBWlFURlJGN3U3dTRPRGdmL3ROdkFBQUFCSkpSRUZVZU5waVlBUURobEV3UUFBZ3dBQUtjZ0FIY2N5am1RQUFBQUJKUlU1RXJrSmdnZz09KSByZXBlYXQteCBsZWZ0IGJvdHRvbTsgcGFkZGluZy1ib3R0b206NTVweDsgZm9udC1zdHlsZTpub3JtYWw7IH0NCi5qcXVlcnktbXNnYm94LXdyYXBwZXIgeyBwYWRkaW5nOjIwcHggMjBweCA0MHB4IDEwMHB4OyB9DQouanF1ZXJ5LW1zZ2JveC1idXR0b25zIHsgcGFkZGluZzoxNXB4OyB0ZXh0LWFsaWduOnJpZ2h0OyBwb3NpdGlvbjphYnNvbHV0ZTsgYm90dG9tOjA7IHJpZ2h0OjA7IH0NCi5qcXVlcnktbXNnYm94LWJ1dHRvbnMgYnV0dG9uLCAuanF1ZXJ5LW1zZ2JveC1idXR0b25zIGlucHV0IHsgbWFyZ2luLWxlZnQ6MTBweDsgbWluLXdpZHRoOjg1cHg7IHBhZGRpbmc6MCAxNHB4IDJweDsgaGVpZ2h0OjI0cHg7IGN1cnNvcjpwb2ludGVyOyB9DQouanF1ZXJ5LW1zZ2JveC1pbnB1dHMgeyBtYXJnaW4tdG9wOjRweDsgfQ0KLmpxdWVyeS1tc2dib3gtaW5wdXRzIGlucHV0IHsgZGlzcGxheTpibG9jazsgcGFkZGluZzozcHggMnB4OyBib3JkZXI6MXB4IHNvbGlkICNkZGRkZGQ7IG1hcmdpbjozcHggMCA2cHggMDsgd2lkdGg6OTUlOyB9DQouanF1ZXJ5LW1zZ2JveC1sYWJlbCB7IGZvbnQtd2VpZ2h0OmJvbGQ7IGZvbnQtc2l6ZToxMXB4OyB9DQouanF1ZXJ5LW1zZ2JveC1hbGVydCB7IGJhY2tncm91bmQ6IHVybChkYXRhOmltYWdlL3BuZztiYXNlNjQsaVZCT1J3MEtHZ29BQUFBTlNVaEVVZ0FBQUVBQUFBQkFDQVlBQUFDcWFYSGVBQUFBR1hSRldIUlRiMlowZDJGeVpRQkJaRzlpWlNCSmJXRm5aVkpsWVdSNWNjbGxQQUFBRE1OSlJFRlVlTnJzVzJsc1hOVVZQbStaZmJObnZHZTh4ZzR4U1V3aHBTbVEwQVVKaVJLVm9rcjhLNkpRQW1sUW8xUlVrQ0IxWVV1TEZFUmJ0alNsUmJSQ1FFRnNLWFFSTFJRaktFbWNGWk00QzdHZDJJN3RqR2M4bnZITXZIbnY5cnR2SnBtWnpOaGplMlpTa25ERnhmRjdkenZuZnVlYzc5ejdMRERHNkVJdUlsM2c1WUpYZ0V5SHJ2NENBVjhvNE95V3I2RCtFWFVZbFNVci8vY1cxS1ZuZXpFQzYxbVIrcTN0UDZXZDdlRFZEekdEYXdPek5CRXpWR0oyVStJNWk1SVFHeVpoc3BlRWVPQmhyT08rRXE4amhRQWVCay9WVWhZbytrbk4zTEJCY3k2RDhGNDhNYVgySC85bXhuclNYTXRJTTNrMzhMWWxYVXVhek9McFJaUlFmblpneFdQTTNMaWEyUmJyZnBjeUprMnZNakY3QnpGei9XcjAyVlM2QmFVcVppenh6dTlmdm82Wkt0WXkrOFdKQitvb1VleFRZdkhEZUJsTUdxS0RCTG1OeUxpUVNQSVFzeTBpUVpuNHNkcTkvRFBwNHM3SFN3Q0JOQlBROEh1eUZydG8zY3U5VExBOHlteExNQUg4YmF5SFdPZ05Zc3F1bFBENmdvSjQxb1YzcjZNTkZFTVNhWTRPRWlUVGI0TTdycWdwdXZ4cE1wZldCQml0WVpZR3lHT0RZQWVJVGY0ZHowSlRXd0Rlc2NtMzBQWWcrdGlKME5kbWxnWi92cVpSTEpVSkFBRndCc2xhektMdXZlcFNKam52SlVzelVYd0lndjE3R3NFeks0djhDMzFPd0JjMEF6aDJ1dU9tNmlYRlJVQktabEczaDFPMVdNTHZ1VktDSUYxa2JjSnYwYVR3MFV6c1RWZTFDUHE4QjkrZ0V0bWF5RzRSMXdpQ0lCYlZCeVNyWEFyYng1Z3J5ZVFtd1R3UDh1L0diZzZuTVE4RGNPY2lRWFFtZVlDQUdrT2ZDV2d1d0xjL0FZUDRJUG9lSURJdkpvdmoyTzFENzE3K05wVHdHaXRDdkU2WFdTNDI5Sld1Sy9oT3ZTYmFGK2dDc2NrZFNmOENRVVY0ZTBNcmpSeXhVM2hVb2NoNEtMRUlrNVZzRlhWVTBhcVNKUFNnbjQvakNIMjdFQjJBSW94bEM0emNpWWR2NkMrS1lBS3BaSWdWM2ZHdEVxeDE0RFlWUk9FUDhIczR1Zk5tckh3QjlXejFrNjMrTXJJM0x5SlBlWVArS2o0Wm9ORGdQdXArODNXYS84MTJzdHIyUUV4L0lsSkVQaVhCc296TUx1KzFJKyt5VlVEQjB3V2pnSlVJQWJGdFg3VWdkajBsT3JEN0NweFlkRThLYjdLTGZMMWwxUEtkaldTclc1elYxN1BvT3FxN2FoWDEvZU1uMU5oUmliRG9TN0xrUFVETmZCTHNyZVFNRFQzNS9NYTJQK0h4UkxFUUlCTC81VlF0T1BDejFZSWRrSlVkZ085T1RCUk4rVmZBWDNRc3pTbjg2ZDJ3dU1pejVCWjQvcktVbjlMQ3VpbVFzWXdFV3dOZHU4ekpVU0FVdU03VHRXaEVLUHJoc25vbW1qZUpkb1M5V0IreDJQNHp3cHRBdHRyRmVjZHh0VnlwdDgwSWkrQVFGTzBqUHJiZGJ0MjA3Ym5GODRwR2hJckZBOUIvdGVob3dZZ20wc0lmWjhkM29FRVN4MmNRUTJINzJ1UVovVFdNdVIza3lLb3JvYkhHK01OQ3dtSW1EeWlDQ1VUZXYvekxnc0c1WHJUVkk0cGg1NVZqR1REVHF4b2haZnhvZmlTTlFORDRSSFovcFJkajkwQUJEZVIwbGEvditVdkhwWjhMRTVoODczSUJmYmVKcmxZOTBySEpYYm5ablJvbVdUeVJQNHdHQVhkMU12Y1lrK0FVTUgrT05HK2xjZnQzditHVy91OG1nSDdYQzVZcUVoSDZXUGdUU0RBQ3pWSjJqVU1Cd3JIOFIxVGFNV1NLNGR4aktJT1lZejlRNEVWVXJhVEgxalpjTnhlSFdEUVRDTCt6bFBPSU55VysreW95dXNqZWFlaHRsRVNCTXowbGp3SUcwRFkwNVRnc0FoU29FeVNWelNlUFEzN3p2cHRyRFFXYXdOd1JnRDYzaWJZNjdINDFkZ2JDeDMzVEpEbWMzZ1pKRGZWTmYwd3R3d21xc2FuSGlaL1VrU1phYXhFV2Eyak5qWlczelJZRkdRaGdLcmZQUkoxTm1mamJaWGFrRWsvTDduWjRyZ0hZWjNkdTJKNWhCckd4M1ZNdlRCa0N6SUVTVFp0MkhOMFhSSWZJNExtWUhCYmpreS8rck1VK0t3V2t5VHhuQktEOU90blpBSlptUnhxZmdHVmk0ZE5VT0RkbC9MT3BvOG5nQjhrSWtHOGNrS013R0tMUkNZTFpRRmN2c2ErYkRRb0s5Z0hCclYveUNwTGxmb09uWFNjb0xQTEp6UEo4SGdsb2FKb0ljRlFQbHpNYWF4STBPM3FNREJVTFFZNHN2L2pvOFl1OFo4VUhqTDl4Q2NJZTZ6ZTR3ZmdraWJUZ3g3a1hxVU1lLzRzaHE0c29XREJTM2drL3liR3BFU0RGdVNtQkxDbkFwc3J5S2tFTGZvUk9ScExMVzZpeDByQjZwdVFvWGVaWm53ZWcvU1VpT0x0YzNnWVlIb0tBdldrc0RsNWExZlNmdVJFVklTRStsb2dFUXJiek5paWZRUUhjQjhTU0dTUlFMUW5JcnhEdUpURnhkSkRCbW9DWThHRXl1T2VUemRlM2Z0L3YybC9CMHgyek9RK0FFNFFta2pWZjhiL1NZVURublVaUG03NUlOczV0Rm4wamNld3VFcDh3Qkl1cStyUGNEb3d6dWdsRXpONGNGRGhNQWo4SGlDdXA5bnhOTVNoMVVrbU5yeVFkWkRvS0VHR01GUXVvM0NiT2lDS255endyRStDa1I3SlZrbHpXU05yRUhrdytESTRPUlhDWWF4a25UVlBYZUloaW96dXpVK214SHYxZDRzSmlxcjdJQ2FBTUxZUTVvOGs1NDhOUXpBR1M0QXdkN3FwYkR6M1QvdTJTT01HeEZ4ZHowdk9xc2VvaUNOMVAybkJud3NiemhiNnNVSWljSUpEdEI5VEFQaDBkTXhwRFRhR09JbXJDRHdGQnhxcDJjdHZFVjFjc3Nzc3pkNEl6TkFHOC81N3NySVhmRTRtTjdkQUZ5VXBZWmxDWkVvS3pHOHlPQUVBQUtlSFpqYWNyQXVZUkFBcjgyMG0yVlFPZFhucHVuZmZtNmNMaUdTYVFQeGs2K2VkRlJzYkVQeGpMdlpqd0JHei93T3gzL2pTZkQ1R3NaUHNBTVQ0S09FZm1OaVlFMFVhM3d5d1BrYW55SW5KYURNODhlbXV0cFdqSkVONnROYnJua1dRQjZmRjNZVkoxeG1mOFdWVlZTT0NNRDdsQmVqSEZEK2pLbWZ1NDhBdSsvNUpvRU1sVTBVdzNMblBlTlJVS01zSmdQdHNmZmJhOVVaQ05qNWdxR29nRkQ0UDFIU3Z3R2dsOWtROG91OVloclczVlQrVllEUHcrZUZCWFRrR0hNbGdiWDZPeHZKb2NvMzIvNm55bytRVTg3c3ZwQTJaNktNcFBlc3lWalNUS0p0Sk83QzdLMlNHTCtJajF2MEFhNXdKOGs3UjQ2Z3lnb0FMSE9MYUx4TG9ieU9UMmtuZThoNGZGRFlnczJwVEg0dE1sUWNOYkZsNHFXUjMzY1BnemZ6Zmk4VWl4N283d1g2ZzB0OUZoT01UQWZ2Q0NWcktmSExwbng4YVdsL0M0Njh4a2FFWUk0THR2cXFnSFNPT2srbmNYNS9wTU5KSEE3d3pNbFNUSWlTU084UVFvTW9MWVBwcmxHK1ppWWhveVRzbldUSHp0WmI3QW5VREJuZWtveUx3WW1VSUJKNTVhY0wzQjZibmQ1SzRqemJjTkRHKzhjT0VsQ3dtT0JUUWNxS094bzM0S25lelhIOXM4ZFZSZTNVRlZMdVFDNHowSmN5am9pTm9QSmV3bGsyY3BsYmtIYis5K1JIc2RTbmpyOUlWS1BoOHc5RVNiQk52Y2FxNXU0aFFOOE4rZkNEY0ZGc0ZhVFFNbmEwbXNXazR0eTY4N2ZVY1FHdGhISjd2ZnBvSGg5Nm5PSGdEQk9WcTRLWXgxazJCckpYTjFJNVdQKzdiZS9TMjNTYitFelBJQldzNDQrWDJUcDRhTXJrbzR2bmYxZzR6Q3BaZWhnRVl5dWxkUzNmSlZHYSs0SW5nZDZIU1JFSm1FQXZxNVhSVG9EOFBZdUgxZ2h5dkk2S3lpSDN4TnZRVW8yTUpSa0pFTW5VbUZCMy9kNmhRRWFZdTF0aGtMUVZnSkhKbzc2VW12b29YR1E1WXM0ZE1MZjhmYjhMYkZtSk9ON1lkVEhDUnJYUXU1clBMbWwrK3FjK1U5RDhEUE5TYllwR3gxZ2xqc1NjVG11WktUaks5UFJETFlQSGszTHRGR0xNNmNDSy9NdHhzVTJRVnVVRU1kODR6OE93TWg4MHd3alJZZTN6Uy9ScEJORDF2cjVzTVpnZlR3RTVvNThQMmNWWW1TckFYektrQnZnN2JGbXBjRmp1aHkyT2Exa2QxaWZ2Q3ZhK2RWWjM0amxHb3NvQTVhcWhwQWVpUnc2NTB6UzI5bldsVW9JTkxIejcybXV4WFIyL0MyeFp4YkcrMGkwV2dnUzNVOXRWVWFmdVM5KzRpWXl3UmFSWk1WOWdMYjl5TTNENDhVeC9aUEp5d2FkZ0lVdU92KzFJbFBCajJONmU5NG04U0pVdkhtWmlFa2NJSERaSUZzZG9kdC9VZjNlaGVtY29GVVJMakI1SzRoZ1Nta1FtT2wrR3FNUmNaSU8vUTh4YUJncVhFbENmYkVCeEpzb28vVTNxM0VrTkh4TnFXWVd4dmVUbEpMRTVrOXRlVHdCVytxdi9mby9mMGJtN1IwSG5DTjBlV0IwL2dFMFRKSUpTa0liU3lNM1RqK1QyTERIK3JFS01HTUVmcjRZUWkvRUNuVko2dXhnQzZid1ZsUEV0SFg4ZVNYa0QyU3pnTmFKRkZOSmp4VXdzSjB1c3VVS0ozdG9vMkNJbGRYOHhoVFMvd3J4UHQ2bGZSUFphMFVIZ0NCT1BzTE8ydEY0U1JyZ0h0R3pnbzUvRUxwSnVEVHhnZTgwbm4rTjFUYXhCQXBjZjFiUEs0RU9mMVQyWGVpd1VoeENNam51Q3FoS0kxT3FQeUNrbjliSUtRVG9hZEM0MGdPVllHS1N3QStQMVZWUlFvRkpIcXBLOFF2VUFSZEFXa05EcXFLOElEZjc0WVN4UE51NTFWVm9vQy9uSGIzeHpjLzBhbmYwT3JYS3hsZml6YzkwUC9UVU5qNDRKaXZnc0loRzZseDZkd1hIREp3V2NaOEh0clpLMjVlK2ZzVHorcG5aL3dqWnZ3VWptekkvT0tzNWVIajBzczNWMTdsTFpQdUtMT0kxeGdsb2ZwY2RuclJPQnNhQ3FxZHIrNE52L2FienVEaHBQRDhkSWVmNzQwTFI5Wm5mM0xYc3ZHNEVUOTQ2dWpXd3lPU05EcjMvOFJPdjVYZ29ZOWZkS0VHSUh0c3Fpc2szakNRT0wwa1d6Sm1TcFI5UDN1dUZKYmNlUjcrSnBKS1VCSm5namtLTk1PQWdsTktDQ2ZiblE4SWlDY0YxN2lNVXlyZ2xCS1NDRkRwUEM3Q2hmN244LzhUWUFEUWhkZm1vWVhWd0FBQUFBQkpSVTVFcmtKZ2dnPT0pIG5vLXJlcGVhdCAyMHB4IDIwcHg7IH0NCi5qcXVlcnktbXNnYm94LWluZm8geyBiYWNrZ3JvdW5kOiB1cmwoZGF0YTppbWFnZS9wbmc7YmFzZTY0LGlWQk9SdzBLR2dvQUFBQU5TVWhFVWdBQUFFQUFBQUJBQ0FZQUFBQ3FhWEhlQUFBQUdYUkZXSFJUYjJaMGQyRnlaUUJCWkc5aVpTQkpiV0ZuWlZKbFlXUjVjY2xsUEFBQURucEpSRUZVZU5yc1czdHdWT1VWUC9mZWZlZEZYcHNRWGlJaHlzUDR3S3FnRlZHb01GWTZDaDByTm1weHRLWnFyYlVkLzhDV0dRZnR0TTdZcWhVTGRxQWpLbW8xZ0lpaUJnVkZIdktJUENJdkUxNGhKSnRrMzN0Mzl6NTd6dDF2d3dZM0pKdmRCVHY0elp5NWR6ZDN2Kzg4ZitlYzc3dmhkRjJIODNud2NKNFAwN1JQL0Q5NHdBOEtPSjlESU4wSmZubUJ0ZC9Qdm5Za09od3ZwZXpqV0NRN3V3OGlIV0QzYlRqbmlSVG1USXQvN3FhUGZNWk4vVS95TTZyWnFSLzdKK0xsS3FTSmpJYm5tVGx3TUpVWFdRUXdNZitUTlIwOGttYmNoMlRVaG1Ka3BtK1J2a0xhVElUODdjZ3dmOHdETXBRR3AzN2tJOHZPUnJvTjZjWUtCeStVMlhrb3QvRkExMXdUbDlKOGZsbXZkRVcweXJhd051ZGtXS1A1dy9qMUJxUzNrRmJVMzF6Z1M0dGhKcmNwWGZsdld1dWJqSmRhaDRtN1kzUytBQmNpVmFEQXA0dWI2akxrTFhsbUFVYmxDY1puVlFjN0ttTDZJYitLcEN6RmRaZmgxeSt2bTE2d09RMzVTUUVEMDhDTkgzcnZJTUVySE1Ma3k0cE5jR0d1Y0Vyb1hxYU1vS3ZMTVU4SEVkMWNZODhKR0FwMklmWnJDOCtCTlFrMGt4cUdvbUtKSmp2TjBCUlFhM2E2NVJya1l5MHA0dE1aZzk1TFRRRnhEOUJTVThDVU5aNUxTSENubmErOWZyQVZCdHY1cEZiMlN6cjRVY2lBSEx1UHBMZ09LU1RmVEFUR05kZDh5cWM0dksxRVR5TTZMcXJUMTdkR3B5TmZ6K09mbnZ2c2xzSmovVklBNDRlYnZOcHQzS3ovYVdHZlA3cmhmYzhDcThETnU3YmNBbU1MVFQzY1hFSExka1EwNklqcTRFWEtkSUdOamdHRExCdzRiUnlVSUs0SUNZdHJ1UFp1and4YlhCTElLanlKc2p6ZEQxbjZId0tvSkVMeDJ2SEY1cHBKWlJhd3N0VjFadWtUb2c0SVdKRE5yb0lNMW9tS0plTDlHamd4VG9ibGNKQ0Ruc0doRTE1YWJJYlJCU2I0NHFTMEFQa2Rnajk1ZnNPdFJRZjZDZ0ZlMThnZGVsLzQrbFh1ZXdVZE50MDh6Rll6cGNMYUxYd1FCVy9vVW1FSEVpSzF3YUIrbGtoRmZpa3pmTldwd202M0N1Rlkyc1FVeThITnc2eHdRNFcxbHRkaFAvSSt1L2NRaUJGUHNkQWJEdng0UlZjdGV0dlMyYVBzaG5acGNVWEZpc1ViVzl3ZGpRRlpLa1NEbEZoazVhQWM4YVBVeGhtTWN3QXB6MFhVRWRGaFM0Y0tUZWdWRkliRTQvZ2lNL3hzcEIwRVhmOHZ5akNuTnd3ZzRza1Zrb1hCZFhXZDk5b0ZXSGg3cFFOSzhJWWVhUlUxK05LbHdQSFF3Q3hPTVVMMVFJRWNnV09OSjJENzVtYll0L01ZQ0I2L29SQWVCdTRSaHdNYVlvQUtMdlFNK3E0aVI0RGJSemt3cThEcktNdk1aQ0ZBbE5RRHJuMm40enBNTzB0bmpzcEJ4Z1RLd2RDSVZtLzA2aERWT05CZ1lHUkN5K2ZxQ3V4dlBBa3pMc3FISjZZTmdYdXZLZ0d4MHc5UkpCdVdoZ09kbTBoRTc5emwwZUdnTDJhZ3Nod1R6TGpBUWRLdVFwa3FrM21BS1ZuODQzZTEwL0NIcFRZQm9pajkxMjROZkhMNkVFYzVYdXdLd0w5cXFxREFmcW9ObVhGSk1memxrMVlJb3RaOVV2cUFlU1JFNlZlRFM0c1FLSE5OY1AwUU82dy9HbnFjZ0R3UkF3d1ExRkFMV29JSFhQT21hMEZWa1hsT1phSFpFSDVIcHdaZVNjOEllSkdMVnpydFBZU1BqeXVHNVdCcTR6SUdsSlF0ZG5acFJwOVJYV3FGWWZtV0I2OSt2ZlVQcDFKblRPNGVHSEQxOHZaeTdGSG0zVERNZ1lDQ0V6RExEd1NjS0M2amlNNGhWSjRQZ2NxTitORWUxQ0NrSk84SmVKTUpPdkdaQURJdTRwcXlPckIxRTZrTDU5cmxqb1hEbEJFT0VBVGgyVEYvV21IckZRUHcrdWlFTXB2aHFvMGVEVHdwb253RUJmWlRyZzdGaE8wU1k4S1RFaUlLdWJjT3h4V0xjWVhUaXFnR0w0QUxueWNGZU1NNmRLQWJ1M0FPRDk2TCtEdzlNeEFsdUhEOUF6NFZxMGtleHFFbjVGeDQyZTg1SEhHNXVRbXZ0blpYbnlhZUUzODlvUWpjVWl6dSt6UElVeUpZN2xJdTdxdW1JdHRUNFZKVndNTzBZU2JJeDhxT1BPWHpWc1dvS2VJSzcyMVlNWVBZVExGcnF1TkhwVHhnVlExTEd0eHdlUEZqOWd2dS8zdms5RjVnNXFoaXExRm43L1ZvMEZmcExxa3h5MkxwbWRJSTRHLzJZUEZ5Q0pFYXc4MVFRQmpuaUtoOUt6Q01vUkdXcVN6V3dZR0t0RnM0Nks4cTltSjJ1TTdKdzVCY000UnZlZmpHSFhkWHJMM2lQeWUwUkFYY05xcklZdVRUeUJtRVVyV1ltMHBxZW1VdGJZWTRNQzFLSE9zTXRmNjN6UFI3Q2pWU0ppbkMwUTlGMExNdEdGYVZKR05PSWUxWjFLUHNra2xUdTVlOXFzUmhncTFkeUV3di9UTlpYSlRTVDRmayt0ckpkbWoxaHcyVUhqRjJCQnhWWStHUVdsTVBNZEJFbm5LeGtMS2F6NnlHUTM0ZHh1WmhSY3RiYUtmSzJqQjNxQnozZ0NLYm1SOHBJaE9TcWlkMXZWQWY4Wm1TQXBEUmE3REN2TmhaWkh4K3V5a0tWczRPMGdBWElMMTVFRUF0MkxUa1kzbk45NktISUtVOVFRQk9zSTdCajVRTndpWldBeFJSZlg1UzdDa2szZnV3dEpSVnlOaWdYb3AyZTZaZFBBaUdGY1UyVkQ5c2RobDRvS1ZaQkZHbWtUQno1R04vWWVrRktOc3hxMkJGYXM2cm5sb2MyRjBmaUtmQklodHkxaFVsb1RtRG9qaFpaeEJMWDRYci9pNFRaQlY0aVBoQzNjTFRxRUMzTlBPWm1WL0JVdDB0WW1oRUlPbmZ1L0I3Ry9KZ3E3allTZmFJZTBEWXlPRXkweVM2ZkNDaVo2Vy94OVlDQ2swOVhjckJhMGJ0b1did25KSkFNb3JMRk5oN2VrSVhlcG1FTGEwYzZOS00rb3Rod0FtL0tFTSszb2FsbVBEWkdvUlRaUEhFTWJyRUFsK0dXSStld2JWSUZnVXhiWkNETjlLN2tjVW9mV09hQ3pSODRETVV3TEtBTzZ5cWJYNVJMUmRsRHJJNUNHdkk0b2xqWElVRHpFY2xBN3hrTGJQclVTaTdzVEtOSzBIQy9DMkhRazJxNkRNOG9Mc1VSdHJvOVVYVHJyLzcyZ3loZzVFcXRIamlvT2FJaTBZTTVXUmpYVktDQi9zTVNyT2lLSUhpNzl3VlQ2U21oRTV3aFNTR1ovTTJXL2JjSDRzZlFaRU1pMzhuTmZLS2dROWFscUtQeW5WQ3RiQlBCTEY1MjNxV1BYdFVndThwWWhpVWdnTGdlRDVMQ3NCYVhsZVR0c09FQzdzazR3QWtheU1VVmlDTXhWZm55cWZveUkwZ1grVTFSRXFpcGlkR0IxVlpmMWJ5aTBaWm1nMmlBdzhIeUVtWnkwRmNzRklxek5MYVJGRnZFQ0xIdjFta1JZUEVoR1FvNExSMitHWFo2MGVrMUxJU2l4VGpRM0tUZTlkRnBSWURIL1FzNFkrSzFaenNENEpyK2FQTG1mV3BHMVI2N0FnZGViTHFzQ3JMejBTN3ZGbGhnbHBacHlPNUFnZ1hyQmlXbEFteUFvU2RiclQrbnBjVjkxR1JrZ05seWU5NEFJMWo4OGZNVTd5K0ZYSlF6SUlIQUl3dFMvNCtBZUdDanBrZ1ZoRm1kbDNaaDY3ZmNyQ3VmZEdzVjVucjAvc0kwYUh6OS9YSUFnbEhUZnBMMGZiTzJ5emxaWkRKckNCaldUMStTRTZ2ZjdlWkJTTlZhVnJtYWhFdEVnRUpyUi82ZW1VZFdaek9aWmtDbE5pZVlKSnQ4Uk1MeHEvVElxRjdvdGl5cWxFcFk1WndZU095dFMxNXBkT0YxV2VMYkFOUnlaemxLYXVSREpHREcrWUhQbDk0aUxrOXZSa1JIanl2VVRPMnhiVmU4azdiMzY1YzV2emQ1b0pJQzd4Z3JoZ01uTldTdGpYYVFqcjhlYk1NRDFhYjRMSVNIdXptR09qdGMydXd0RkdCSmw5Nkd5MDlMQjhNZ2RMdWd1akJkZk84Ny81MkhYTjlFajVnV0YvdDQzaGN4OEZ4M01LU1I3N2dkRVY5WG5DV0FwK2ZseFpUWk4yREhnMmUyb0o5QityVEluQkczcWZkR2pwUnBuWTJFMldBNXNOTTV1cUE4TzY2UndKcjUyOWp3bFB0VDBmQ0VaS3Q3SW05TVFWb1p5aTk4RGtWbGZEU29MdmZiaFNDNWJWQzJmQlpRbGtwZEhjV0E2bk4wY0x0b280MGtQZEcrdHFoVlVIdDZBQzU1ZURLNkw0MWRlTEdGdzh5NGIzVTc1QU5VQ1l0Zmk3UXJ4Y2ttQkxvM1p3ZGhRL1UrelJSbk11WGxBQ1hsd3ZmcDZGNWZhQjFkSUxhdnY4Vjc3S2ZMMkhhalRETGsvQWhrdVgwRnlUNjlZWUkvbEJCSlFROWk2YytsamRyY2IzSk0vcFhmT0hnYVp6VENaemRkazRGMTBVUjlFNFV2TzNidXVnM3ErdkNXeGMxTWJTUE1NdDdtZVhWWkcrSW5ERUVraWtoOE80RDlDN08rcnc3bHRYdzNwRjM4WVhPYXI2b0VMaWNuTE5vYnF4VS9YN1FQUjZNOTQ3dFNtdkRpdEQ3ajMzS0doeXE4a0lNOFB3czVyVWtxVDcxZDRSb0lsUUNSYThTZUt2bTM3U2ZtWFByaTdjS1plUHY1SEtMSjNJRitSZ2FlZWdWOXF3SWJWZzdGQUtkM04xN3ZFN2F0N291dW0xeEUzTjNoVms5d0FRblBtVzlsMWRnVG9WQWl0dFFiTUlvS3NKWU1MVDZrVGZ4dXNZeWJ0Wkk4N2haTS9tQ0lWTTRXLzRsaGhJYzJQYmlsYU5ycXNDcEtGZ1pScW1CTndTSFVEQ3NSM3c3TmQveGJaR056NjFSMi9jRW1jV1ZoTkkyRUsveWtsazkyU3N5Sm4yQU96QU1ITU1NWmNOUzQ3dEJwR2E4WHlRNHh3MHlWOTk1dVZCY2RUbGZOT28rN3FJcUFFRTR3NmxGQVBSZ2tIWW1ZMjJiUkgyeDFLRXJrYU42c0wwQmhXMkliSGk2NGRScGdCSGpNaE5jWkJSbW4xVzlIMWFOeTkxdkREaUROeEEyaEpqN2tmWnRxcXZScDlZLzJXNmI4UStaRzFwOUgvQkM3eGt2SEFidGVBdW9MZHYvcXJuMjdOZERIVUY1NzFzdHAyMzdhMHhvaFFrdU1ZSERiRjNaMk1WUHdaMEhoQUY5S1lJcEk2NElNMTkrNWVSQnpnSUk4Snh4dXZ2ZEEwWUo5Q1BIUUQyNlpVSDBnNGZlVHhCU1paYldFcXd0TVF0SDQyc1I5ZVhxdlh2QUFER2dQMEJKekRydTMyWXhtZmc1TTY4b2hPVUhrcHdxcVNqWDRTT2duV2g0Z1FrdnNSZ1dtY0JLZ2dMaVY3Vy9MdDRQUHRQRGdIN0VXRzNWeUNKb0QzUGRyN0VsQWh3MEh3YTk3Y0NyMGZmbXhqY29DTG03bUFKVTVsaFo0aTRCQTdMeFQxTzJ1VjhWOER6M3Qrb3hUdGp1T2UzWW13Q3V1Um4wOW05ZWtWYmV0WVJaT3NDcXRTRFZHMmVsZ01xbUIrQ2M4NnJIT3NGcXQ4QzN6ZW9wOTBmQTR3ekw3M3BCWG1OWS9wd0luMVVQc055emRXYU93L3pIeTZ2TFliOGIyMXNOWWowdnRxYWN5d1ZhNjdabmxJOGZXczNjUHNqY1BvQjh5R2UxaE5hekFJTG11N2RNd0N5d2F2S2tFY0R6UEh6dFVrSDNCNEJyYWNGNnZmbE5kZWMvWDlPUHJlOWtsdmN6eS92Wlp6Z25Dc2hVUjJxdTJTS2c4TnNuVHh3TzVhVzU4T2x1Ti9pYnVvRHpkSHl1dCsxWXBYNzIrQ2FHNXZHTkNROXpleG5PeGRBekhBSTRqOTFrNHVDTHpjZmdzNDFIZ2hoa0gwQ2c1UjFsOVM5bzV5R1hDUi9ma3FJV05YdzJZNzQzRCtENE9adlNtdWczYzYvc3ZsKzRaRHNKcW1wdlRLSmloZHJEWXFROHB1OTRoMFpYNmVGNktTUHdpMnVtOWZ1MEZaQzB6SHhqa3BrSkh0OURDelBCbzdqZU9iTjZzbUhLMHJ4YVFuT2lkWi9EemRuMHZmdFA3YXg0d1AvVE9PLy9kZlovQWd3QUp1dnV3T1NERk9ZQUFBQUFTVVZPUks1Q1lJST0pIG5vLXJlcGVhdCAyMHB4IDIwcHg7IH0NCi5qcXVlcnktbXNnYm94LWVycm9yIHsgYmFja2dyb3VuZDogdXJsKGRhdGE6aW1hZ2UvcG5nO2Jhc2U2NCxpVkJPUncwS0dnb0FBQUFOU1VoRVVnQUFBRUFBQUFCQUNBWUFBQUNxYVhIZUFBQUFHWFJGV0hSVGIyWjBkMkZ5WlFCQlpHOWlaU0JKYldGblpWSmxZV1I1Y2NsbFBBQUFDd0JKUkVGVWVOcnNtMnRzRk5jVng4L01QbWU5Zm9UWVhodHNLT0JIZ0lSSGVKZ0VBMm9vRkFnUXBhSnFwYXJ1bHo2eXdoalhyUnZhaUFiU1J4cVRwUWJzbGtTcStxV0lxcXBTaFZhcWFCb2hpQlBDQjJ5UXNYbllPSmpZeHJGNStMSDJydGU3YzN2TzNidG1zZnpZbloyMXFjaVZSanV6TzNQdS9mL3V1ZWZlZThhV0dHUHdPQmNaSHZQeTJBTXd4bXpocFplbVY4SDc3My9wQVY4QzBIc0lTSklVc1FGV1VmSGdvcVptRmhRV3RzZTF4VFUxQ3RiaDBkTFdoOW90Wmo5cHJHa3daRFNhS1pMdDJPRUNxN1VNdk41RGVQbUdkUEprcjU2NjBiNFpQNXhnTUZSQ0lMQWI3VmRGOHR4NGdFTGFkQmtDNnZidEx2YmtrMld3WVFPd3ZMd3lOUDRtZm1mWFN6emFNcVBOU2paL2ZpV3NXd2ZNWWptSzN4VS9FakhBdjIwYkZ5K3RYbzNXWkpEeTg0SGw1RGhWeGlyd043c085czFxVUx4VFdyZ1F3RzRINmZublFVVUkrRnZ4dEFJWWZ2RkZGNlNtbHNuUFBjZkZvL3NIaldKRHBkeGNaMEJWRCtJOTloanM4NTZYVUx5OGFGSHd5MENBUTVEWHJPR2VnUGNVVHd1QW9hMWJYWXpFWTg4ekhHZnM3bDFRVDUwQzF0VEV4NWUwWUFISWVYbXYrQkVDM212WFlKLzNQRkRQbzNpeXlXN2NBUFgwYVdBRU9pR0JReUJQd0h1THB4U0FaOHNXRjZTbmx4bEZ6N043OTREVjFQRGVZZlgxdktGVURPZ0pCZ0VCbjFHaXNNL0ZTemlVREU4L0hReGFMUzNBTGwwQzZPc0wxalUwQkJKNmdyR3drSHNDUGxNOEpRQUdOMjkyU1NTK29BQVlpY2VlWng5OUJNenZEL1lTSGRoUTF0d01GR2NOMkh0R2hJREQ0UkErcTBSZ243dTlMTVNURFFMS0xsNThZTCszRjFTRXdEMEJJWmdRQWlBRWZMWTRyZ0RjbXphNUlDMnR6RVFCejJBQUlMY2ZMVjRjS2tIQTRjQVhHeWpFUko0UUNCeENHOG9FOXMycXFsWWFVTHp4bVdlQ1BVOXVIeTQrZFBUMGNBZzg3aVFtZ25udFdtQm04MUcwRVJXRWlOY0JmUnMzdWd3T1I1a1ZJekNKWjkzZG9INzhjVEFvVFVSNDhXSUtpUHpjaDhOajZPclZZN0lrbFNWOThJRW4vRDYwVC9OOEpZSnltdkdaY1BFVGx1UmtNSkFIV0syZzl2ZUQ5OHdaOG96ZGFMOHFrblZBUkFCNk5teHdHVE15eXF3WWRFTGlBMkxNUitSbVM1YUFISUtBbnVFTlF0aVQ4dUdIUG1HZml6Zm41enZOZUMrZiszRUlUU28rMUY2RUlLTUhTQUtDSnhnb2Q2UDlxcGdCM0gzaEJTN2VScFJwekZQUFJ5Rit4T2JTcFlEak9oamhFWUpIUUJBL1YxcFF2Q1ZNUEl0US9FT2VnSXNrakFVY3dvQ0FrSHI2ZEpWbUFGM3IxN3RNSkI0TlN5aGU3ZXJTSkg3RUV3aUM4QVJ2WFIwTVhydDJESU1RczZKNDY3SmxEM29lZjlOU3VDZFFXOGtUY0xib0p3Z2V6L2ZUejV6NVU5UUFPdGV0eTVBVjVYYlM5dTFjUEhkN0RIaGF4WThGd1NPRUtqcUlENGRnV0wrZWUwTGcvbjNvUFhXcU52UHMyZVdhUEtDanNOQmx4Ylc5a3AwTmZoS1AwVjZQWW5qMjJSRUlJK3Q5bkRFQ3RiVzYySmRTVXNDQU1jRjk3aHgwdExlWExEbC8vbyswcXRZVUE5cldyUG1EeFdCd1d2WGVoeTlmRHBLSUNiUm04Ris0b0o5eGJQOEFmalM3M2NmWDF0YnV4OU83ZVBTSFE0Z1lBSjVMVFFVRjd5UWFqVDlRb3QxNzAzeE5Ya1ByQlBxazRTUG1jVG9uQ0h6RGd3RnZKRm9ialh5bWtXaWRnZWY4TThyaVZsVzQ3dkdjK0dwZDNXRUtOM2pjRWNlUXBta1FyeTBYVjZ4NEo5MWsrcDVObm5qdHhIdytZTVBET04vNWdxSmozcTdoRHROa0FzbHM1Z2RNVUQrMTFvMWdTZnlHUzVlTzBOWko5RHlKNzlIa0FlS2FhclZjV0xic21NTnNMcktOOWdTc1ZNVVZHVitheHZrOUF3ZUJVWjdEQ0JlUGJRcUozMWhmSHhMdkZ1NVB5Um1mWUtRdEkwUVFWaVVtMnFybno2OTJtRXhGQ2RRVDJOUHF3SUErUGEzQk0yUUNvU2o4dkJmYjBJVGl2OTdRTUtsNHpTa3hEc0Z1dHgyWk42L2FBVkNrdU4zVG50U2tEWmtidDhaTnc4TW50alkyUmlRK3Bwd2dRVmlKRUE3UG5WdWQ3dmNYSllna3lMU0l4M2IyMld6UUhBaWMySGJsU3NUaVkwNktFb1NkTTJZazdzbk1QT0tZSmdqaDRuZGN1emFtZUd3L20yd3ZvT25ORUQ2c291RitGYUNreE9HQURJdWx5RDZGRUVoOEQ0NzlablQ3bDV1YXhoV3YrYjFBTkJEd3BLUTRQUjB5Y0hhd0R3MU5qWGdNZmswKzMvR2ROMjVVeFNJK0pnRGhFSHlxdXFjVUlkRHNrQmhIQ0tUcVBybzlCcnpqMzJwcGlWbThMbWx4Z3JBNU1kRnJ3bFdXT2pwcm8vTkJhd3dEVG5jR3hwUlVvMUdPVmJ6bUlCaGVhbkp6ZVRJamVjWU1aOEt0VzNFZkFyUXFISmczRDVwYlcvKzZyN1B6cDVlOTNqc1RpWTlMRUF5VnMvUG5jL0V6Y25PZER0elNEalUyZ3ZmOCtmaUp4NzJCYmVOR3NPTndBNnYxMjRjbHFhOVhWWC84OHMyYm1wZWZtb2ZBNmJsenpRRlZyVXpKeWVIaVJ6WS9jVHhVWEhuNnU3dDVWVlJuV2w3ZUQ1TWx5WVZ0VVRSRDFUSUUvanRuRHUvNTFQeDhaeWJ1N1htYTYvSmw4TVN4OThPTFVsQUFGdkcrNEhaZEhYUmZ2WG9NVzF6MnRkWldUN1JESUdvQS81azllMFQ4TENIZTI5QUFuazgvbmRLRmtMSjZOVmpGNjdJT2hOQVZoRkMrNmRZdGQ5d0EvRHNyaTR0UFEvRlpZaTlQNGdlbldIeW8yTkFUck1JVDJoSENGMWV1Y0FoYjJ0cmN1Z1A0MTh5WlhIejZVMDg1czFlc0NJcEh0NTh1OFE5QkVDOVIybXByb2JPeGtVUFkxdEhoMWczQXlZd01MdDVCNGxldURJcXZyNGVCYVJZL0FnR0hneElHNFhaREE0ZXdvN1BUSGZNMCtJLzBkQzQrWThFQ1p4YjJQRDFJUFQ5dzdodzhLb1hhd2xRVmxNV0xZUmJPRHFxcXZ0S0JReFBidmxjc2tyVE5BbjlQVFIwUlAyZlZxbUFxbTNyK0VSSWZYaEp3T0NqaTVjcm42QW50OWZYa0NYdDMzcm5UcThrRGNKNy9kZWJDaGM0NTVQYjRBSWwzNnlpZW1pRHBDTUNOUTVLRTJSQkN0dkNFdHZwNldwNitHZlZtNkVSS1NvYkJZaW5QV3JvVTFKRDRUejdSVlh3N0xtdXQ2THFwTWI1c0NTLzlOQnl3dmVRSnc3Z3hHd3dFQnNXQ1Q0MTZDQnhQVHE1SWNqaks1ODJhcFd1MHB4cmJVSHdMWXljTUFKWjh4cjZScGlNRUt2ZG56b1NyWFYxL0srbnZMNk5Ma1I1WG81NEYvcEtVVktFd1ZwNkZ1ekJaSi9HZjQ1citNeFJmUGpCdzVBbEprbCszMlVwekFMNlpyaE9FTHd3R3VBN3czazhHQnQ2aUdJbEh0NEF3SERVQWVqSHlydDErS0lXeDB1d1lJVkJOdDFBODlmemV3Y0dSVEU2MkxIdGZWWlFEc3huN3JpTkdDSjFDZlBuZzRFSFI0MjRCb0VjVEFIRnRQcW9vaDlJQWRtVmpBMld0NHJGeExSaGVmdUh4akU1ajlhMDJHcFh2bUV5VldZd1ZaYWlxTnZHeUROY2w2YjFYUFo2UWVCci85MFR2RDJrYUF1S2F2akFmc1ZwZHFRaGhkcFFReUVvcml2OE14Yi9tOVk2WHZaVnlaRG1oeEd5dTBnTGh0aEQvYzY5M1V2R2Fsc0loQ0pVV2l5dVZzVjF6c0lHUlFLQmFXN0Z4Skg2Znp6ZGhBcE95elFTaDJHVGlFRElqaEVEaXI2SGJ2K2J6UlNSZTgyWW9CT0gzWm5ORUVNTEYvM0o0T0tMc0xVSElrMldiMDJpc2pnUUM3M2tTUHp3Y3NmaVl0c01oQ0M2VGlRK0hyNHdEZ1dxOVNlSXg0TzMzKzZOS1hYTUlrbVQ3a1lBd2M1eThSQWMyaGNUdjgvdkhGQytTdHZybUE4SWhIRFFhWFdsalFBZ1hmeUFRMEpTM0Q3MlF4VHFPWlk4QmdjU1QyNzhlQ0l3clBpNEprZEVRS2d5R2h5Q0V4R08wUC82clFDQ20xSFVJQXRieEVBUXVIZ1BlL2tuRXh4VkFPSVRmeVhJUUF0NS9FNzhpOGI5UlZWM3k5aUVJV01leGJJQWkrbzdjL29DcVRpbys3Z0RDSWZ4V2t0NUlCUGhaRzhDN2J6SDJaejNFajRhd1Q1SjJld0FTMzJic24rS25DY1hIRENDU2NuM1hMc2lycnVZUUZnRTRHbkJYaXVkV3NmWWVFWS8zeGZTWEUxZ0hoNERIRTNpa2lLOTdKb3YyRTd6UTBRZEFwZmdzRGU1c0tYK1FSRGxMU2gzUUNvL0VWNDd6aWpyYVVocmMxUkdFaEZBdVJJdjRjQUM2L2RlWUVPa1R2UkphZStzbVh0U2hDcy9xRVljbThSRnZoNlB4Z09rcXBWbzNabnA3d1A5cmVld0JTSS83djgvL1Q0QUJBQnFWcWZXN3ZEZ1NBQUFBQUVsRlRrU3VRbUNDKSBuby1yZXBlYXQgMjBweCAyMHB4OyB9DQouanF1ZXJ5LW1zZ2JveC1wcm9tcHQgeyBiYWNrZ3JvdW5kOiB1cmwoZGF0YTppbWFnZS9wbmc7YmFzZTY0LGlWQk9SdzBLR2dvQUFBQU5TVWhFVWdBQUFFQUFBQUJBQ0FZQUFBQ3FhWEhlQUFBQUdYUkZXSFJUYjJaMGQyRnlaUUJCWkc5aVpTQkpiV0ZuWlZKbFlXUjVjY2xsUEFBQURvcEpSRUZVZU5ya1d3bVFGT1VWZnQwOTk3R3pOOGZ1d25MZlFZMUhzVEdvaUVTallLeFlDZEdJSm9vV2lsaGxKWVlxb2trcGxtVnBUTVVZU1pYUllIbEdFRVZGUUJBMUZWRkV1Wlp6V2RtRGdUMW01ejU2K3Z6ei9wNGVtTjJkM1oyZW1jV2s2S3BYYyt4MDkvKys5OTczanIrWElZVEErWHlZQ3IzQU5kc2kvOWNBc0hDZUgrYzlBTDFDZ0dFWXd4ZFkyNVRNNlhldnRnbzErRElGWlNMSzk3UDhKSURTakxJUDVkZ3Y2NjJ4SEs5YkVBQk1KZ21tQVNnV01jNy9LSEk5dml4Q21lY3lNUlBMYlN4NHpBeFUyL29EblZRQXdoSUJINzRKQ0FRa0ZUN0RyNm04dm4xQnliRWlyV2Y0QVppL05Ud09YNWFoM0RiT3pZMGM3K0tneHNGQ2lkbVlkM1VrVlRnZFYrRm9SSWFnUUw3QnI5WlFoOXYrSTQ5U3dOcUdENENydDRTblU4VWRKbWI1eFpVbW1GVENnWU5qaXVKSlBZSUtCNElLSEE3S2dDdDc2T05yUFUvbGN4MWM0L0FBTUc5emFMV05ZMWJOcVRiRE5JOEpzdW1OT2tCQ0p1anFCR0p5RmpKQ09yWnhBQmdxWUVmSmxwK2pHQ0pmQnlRNEdKQTFqOWh4WGVtTEJ0ZFpYQUN1K2pCRVkzelp6SExUOVEyb3ZKWHRyWGxBSk9CUEVnamlLNjhZQTdYVXdtaEMrY0xlQjFIcUVSK2ZGcUdiVi8rQ0gzLy95WTlMWXptdXQzZ0FYUGxCY0NWYTZva0ZkVllZNCtUT2ZDK2pwZHNUS25UeEtvaHFjVktWR3oyaXhzSEFDUHZackszaUVuZjVKUGk2VzN5UGVzT25ONVJ0eVdITnhRSGdpdmNEVDFUWnVaV0w2bTNnTkRGbkZHK05xZENCaWl2RFZGMWptTUZZSndPakhHZUJhSXNxc0ttTkI0eXVKWjh0TEg5bGlIVVhEc0RjallFLzFicE5EOTVRYndXTDd2SWR5TmJmb3ZLU0N1ZmtjR05HbVZyQ2dzdVN1bjgzZXR6R0ZoNTRtZHoxN3h2TFh4eGs3WVZWZ2o5ODE3K3F5czQrU0MxdlJyQWtURWdIL0FvY0NhTzdLeFM0Y3lNUjVKU3Y4Yjd0Q0RyOWpHdUNuNHl6bzBIZ0g3akdtd2RhUHpWc1g4a1pnTXMzOU56aDRHRDF3bnE3ZGxJTUdYbFhqd0xkU0hJMEhzKzEwSkJyUXVBYkF4aHkrTDRDaTZ6cngrTGFDRm1IYTUyZUZRQThzYS9rQk1BUDF2dm00SVgvdVhDOEV4eVlyMExVQWowcXVoeGVGSmljQllNTVV5Uk5jMWdSb3JuS3JDeVVvcmp4dlkxanRSQTBjajBxWFdpQVBmNVUrTlc0VERDMzFnNnFMSy9JRllDYzJtSDBsR1hYMUR1aENoTjFSRXJkTUZlaW96UmhSZkxDdFlFTFk5ZXNxaENQeE1FZlRKeEIzMkl4UVluREFwNUtsMVlHUjBXaWxjYTVjaWxOczNSTkYxV3dNTFBjQXQ2by9aNkd0N3I4TzM4MllsVWZQWXlUNEp4L2RhK2FWbWxkdmFEZWdYR09idTlUSUprajJhRmhvZHpLZ0VWSVFzZXBFRFNlQ0lLQVpER2p4Z2t6VWRKSEJGMnBQU0RBenVZd05NeW9nc21UcXlIQ21DR0VZTWdHTWtvRmt1SUZDQUwxaHBjYnd4Q1B4eS9ZdGFSK2Y0WXV4Z1lpbDczUk5kTENNYXNiUnRzd3poQmxqTGVFZ1VvY3o0WDJwZzZJQldKdzNhd0tXRFYvT3RTVld3Yzk1ODJ2dXVIVkwxdGc4b1FxS0s4dXcrYUk1T3h0UGdUc0dQTENWQThIYzJyc3NLMHBlUjhhOVI2aVcxUlZpVEVBTUVZZXVCZ3ZST1ArSU5iaTJKUVlTbGZvN1RCdlJpWDhhdmE0bk05WmZHazFnbFVPVDI5cEJ5bklnYnVrUkx0dnJuZHVqUkhrRnhWbVZGaGhyOXUrOU1JMWg5N0FyejlKYzBET2FmQ1NWenBveUs3OFhyVk5LMjY4Q1dJNFhXRmV4aWJmYkRqUGUrd21lT3ltOFNDSG8xREdxVUJyTFNQM1BSekV0SXh2TGtYUFpjejJlOUVMT01OWkFOM2w3bG1vUEl1L09CSlM4MHBWQW9hTFgyU3dacyt2Tkh6NGhyRVE2NGxvSkdya3ZwUkFqK09hSjVSWm9jUmx2M25LSTVzbUlBZ01EWUcrWWhyWS9lSE82VlUyT0JIQnVKZnpyOXBvMGJLakpRNDNUM1ZwcGZJeFhOakJJTTBpQkdxZExGeFN5Y0cwTW5aQVQ2aHpzZERDcFJRemNyUmdLTlE1Q1V5dnNvTy9jdXp0K05VZlVDYzVKdzY0OE1WVEYxUzd6ZFBkV0Z4OEZWQ2drQW8zaW1Id1ZZaURwbjJDbHE0aUltZ3RNYjBtTFdTT0lpQkxKcGxoYW1sMkVHcEt6SEJTUUE4QTQxNTBQS3JDRk9TQ3p5M094Zmh4TmJxOG5CTUhvR3RjVzE5bWhqWkVrWFowaFZSc1Niemw2U1RHWlloT2VJalcwOU0wcFdqekFkQXF5VTliRXdNcVVlVTJhNy9ONTk1ZXZKOFZDYnpVWlJ0ZmYvL2E2ZnZ1cW1WekNnRkU2dG94SGlzMk9NU3c2MldQcDhISDByR0VOSEFJRVJiaWN2N3I4R0tqTnJiVURKMGpKaTdBandkUk4ySFFFSmp4ZkJ1SGFmTUttNFdEWUdoNDJ6czY1eWpENG9VUHhQRlRXZGJmSEEybEtrTWx6NlcweGdCR3VTMVlsRGd1eG85WWlQWUdnTTFpL1RFbFZnNzhBblVqWnRpRTF2R2xXQ3Fxd1FoY1BjbWRkZkYwbXVRVnpSZ3ErZDhuZ3M3bE1IUEFtR3hUYVcxMjZONng3S0M5QUNJMHBkVE9ZZTR2elAzcHFUS1NIZTNhWkFXMFNwTG9reHhhSUpXZzVWMmNDQ1FTZ1lhSkUvcWRUNnUvdDQ2TDBKVklkWDZGSENLRGR1YXM5ZmlXbHFFYzZxZ09HQUpFSVRVdVJNeVB4S1VhMUpqMkNpSVNteWlUUVJmdHdMdU94UlRWMVhJYS9uN3J4S3kvK2FoTmdtMG5WZWpCckdIRzlWdXdLbVB6SERLSEpXekNXTmJobkhabFdmeklweUhVVVJvUUFFVEhSZWl3STBmclV5dnplTG1rUkNDWFdTcWQvbzdHL0M5MWRzQ3E2K3EwWE4vM2FFTHVlZVdZb21XTk0xTW05RWdMblJoallVbGZqV3hpMGZSTDIzQnplWjJIaG4xbVQyREt3Z0YyTGUwTVlYNXE1VGpkd1RHNFRlRkcxM2Z6WVpnM3VYZEhtRDVPWXVaNWZMY0lMVmdqQ0gydW5hUnRza2hiYkFKMnZJN0RraHNRWWMyTDBJTmNsWlJzMk15ZWdNM2lBVXBTSG5qS1E5MDhnS2tsZ05ZUlpHTjVtYnB3cll1QmNwWFhtcDYrQngyd1BQT05nR1VzMFdxRXdhWkJVU1RJYml4MDZPdFFkUUlkMTlGMUs0a3doWlJ0L3UxRVpzQTZBTkdKQ1pMYWp3RHA1d1JhUENIbXo0eDB2TTFFdzNEZmxhT3kvdjNkWmhIMkIxSnBqK1RJT3hFRUlJYS9kMWtac0EyeS9aWkVhNG1kVGJHMDBkTmVrSTBEZkFuMFBYUEdDbmd4NWU2RjdwazY4VzdqbkV6V21RQzEvdGFUQkhwNFluaXNycUpkUXduS0VRVGNkclkvV2VMQzZTQkc4QjdndGJrY0N1cEpCc29DemJHWUNKNnFsTlVqQ2RWd25BODJJS2wxWjYvNUQzU0pXdGNvRm5DdnBFUzVTVVVRR0kwbzA0ZUUxbGQ0dmtYbEkwcTZMaVVLR1pBRW0yTnhFV3pJNnBGRWtVcmg5TWdOWlZ5bExldmZEbllKbUUxTVE1THZrTjVBV1IrSjFJRk81dFMzNFVWc1NKUmt6SnRSb3BCMENQUXp4OGsvVG91Sm90TG9ENGdhMlJSemxFMWpsUitndFc0THlVQmJncUxkQzdraEZFOFJaREl1Z0J6eEhkTHhVV3NlT1V5R2FvWStrL25rTE01c0tXcnQzNDBSK014aEU2dzlJVUNHaDJvRERCOXZ4M1JGdFBLMVdBY3Ywb3lCSU1SNEVOcjM3cUZsaThibmc5VUJPaEZ1a1dPSjVZeTdwS2dBSUxWQUc2YllrRUJMNFZSdXBpbVg1bW02MFNJUFErOGxDRmhQaEJNUTJmSE1QaDBBUlIwS0FFUm9teHBQZ0VwWHhCWHZPU3BhOUkzM3NPRGhBeER2am9DSTdGcUJ3VnBiVmdwZWl4TzhNVkwwL1VVMUdnTTVjT3A5SW1oUEpZZzVlVURuRXpQRjZ0ODFQZ2VSNkhMTzR5bktRbWc5WDQ4WndPcnp3cVJLQmhvdXI5VEtZTG9mc0xteEcrcWNwU0RaeXpRUWlrbThVamdLd29uUE4rdldGN1dON0tFQTBHZUNhNVJnZURsVFVod0FhUGRYbWd6QVRiUGR2YXJBQm4wVS92QTdKMEJtWE1nRkpvaEx4VkdlQ0FJb3daN2owYTJQZnFNckw2UThJSWV4dU8rcFdZZlZwTEJlaWNTS3dzb3VqUG5aVlV6V0VwZ2VkQXp1bEtMYTR6RkYyMEQxQjBEcU9MeUJ4ajNsV3VvUUZRL3VKemx2anFLcnJKRjcvRVZaREl0ZHk0eFI5a0V0TnJFNnRmTmNqUHNwU2JRK3VuOTA0NHFOdXZYcDRGSHFPeE1jRklEQW4yZnZVQk9KdnlrOWdhTFVBTWtoTmtuQ01xZTVmMUVBNk9nQ3FYMzNrMFRVQW9yWFJURzhQVTVrNlNuRjF3T3FLQlcwSUQrV3VkdTlBK2Y0R0M1emI5aXE3U01Vckx3L0NQTHBZK3RqRzVhK28xdWZOa0dDWi9rZVloaUEwUE9YdFJGUlhLbTBlMU1uNWZsVUI3WERiaDhEYng5WCtxVTYrcmNuZG9ud2JaQVUvcVFKbndTMXN3dUV4dlhyOU5pUDZ5Sm4yeHJMNlJraHVxM2tXdnJGWDVuSzZ2dVkwYU1LYUlZQVJtSTNlUGxvRnE0ZXc0RUg2M1Z2RkdEVENSbjIrUWdFa3FTd0I2eGtCZFNXVmxCYXYzaVNmKy91RGJyaWRFODhpRHJKN21WN2pPME9uKzBtQ1VFTVZqanYvSStOTVpudmhLcksvTG8xek1UdEVRSWJFZ3BzYlZYQnpLVytpMHU2NVF1cWVOQ2liZTJnZGh4NkNaVlB1MzVFZDM4bG0yRnpCa0EvV1hYODRyM0hvRjJtRDdQY0FaWDVnVUF0ak0ybUpyMzd4RUtVVjRHMHR3TTVmZlFOZnQzaUYvU2lKMHA1bGNaKyt2a0FROXZqV1p1TE4yOXNKL0d1cDVXMnBwZlZ6czVVYS9WZGl5eWoyN2VBZXJMeE5mNnRuejZySzArdFRwK0tURkREWlJpeG54ajZseGs5RkE2YkxsbnhFS2NzWkJsZXVBM3FhckZmNE9BN09SS1kydEh0U2ZlUmw0UjNibmtoZy9Ub0E0RXhHdmQ5cXR2OFE2QVBDRDN5N21lWFdSWi9HR1VTaVh0SlhSMldlcTV6cHpqMWFKOFBtSzR1VUwxZlBDcDk5RUM2MXFmSysvWFlsN0tzdmYrUUp0OW5oZkczTkh6czVrV3YzY3E0UnY0YXFtc3ZJNk5ISTZTbTRWVStGZ1BtMUNrZ3Z1YjF5b0cxcjZyTkgzUm11SDFBVjE0a1daU3czckdyZUFCa2dFQW5uQ1dtbTk1ZXhYanE3b2Z5TWlEVjFmVFp0K0lyanZrZEFoMTdTZmYrRGZLTzMyelhhU0ROOWlHZCtHUXlnQUtXMjRzTVFMcEdvTjB1aW91cG5EbUNuYk55S2VPdSt6bVVWb3dtWldVQXRKM09seU5FMUMwUUFDYUlmQmJ0UWNVUGJGQSswUlFudXRWNVhmbXd0bmRFeUtEUHNwaVhmRmw4QURMT3BiNVBKNTUwOThYTnpYMzhLcVp5MWlLd1Y4d0ZwOHRGS0VkWXJVRHM5aFFnVm12dm1PWjVZQlNGam5BMGNtUFE0c0RIVHBQb3lTM2srTWJONnJGMVhsMXhSVzlyNHhsNVhzeGsrd0VCdUMxSEFJd2N5N2VmVGVqUHpiZWt2WUVDUVZtUjduM1oySXZ1bncwakxyeVVzWHJxd0ZJeUdSak9CU2JibUY3OExQRk5vRW9Sa09KZVZQb2dhZHUraDN5N3FTdGRQbVFNTkhoZDZiZ09oTUxkdWpQdkdxcGdBTmhiZHZhdlMxNXZZUFVNUTgxczE0V0NRb21CMDRYUjZ4QzI5MTVQYWhkZGw3Nks4M3BmcnltTzl5NTRkalFzQUdRQXdlakttbld4NkdMV0Fjb0VBektVemxROExUU3R5WGcvcFpqY09xd0FaQUdEelZDYVRXOVRaUUNRelFPb3BZZnRXWjFoVHRxOWdDSVoxdjJmT2M3Ny94Mytyd0FEQUJiUG5la3VXeU1vQUFBQUFFbEZUa1N1UW1DQykgbm8tcmVwZWF0IDIwcHggMjBweDsgfQ0KLmpxdWVyeS1tc2dib3gtY29uZmlybSB7IGJhY2tncm91bmQ6IHVybChkYXRhOmltYWdlL3BuZztiYXNlNjQsaVZCT1J3MEtHZ29BQUFBTlNVaEVVZ0FBQUVBQUFBQkFDQVlBQUFDcWFYSGVBQUFBR1hSRldIUlRiMlowZDJGeVpRQkJaRzlpWlNCSmJXRm5aVkpsWVdSNWNjbGxQQUFBRGI1SlJFRlVlTnJzVzNsMFZPVVZ2MitXSkpOOVh3QVRFZ1ZrcTBWMlJIRnAxUlpyaTFLdGVGd1EvMmhhQlRmT3dXSmQ2bDVQYmZXZ0tWcFJVYXE0QkVYd0ZCU2xJa0VsSVVWQXdwSVFza0dXU1pqSlRHWjc3L3Q2NzN2ZkM1TmxRbWJ5QmowSEgrZnkzcng1NzN2M2Q1ZmZ2ZC8zSmhMbkhNN2t6UVJuK0diNW53TitqSUFmRFhBbXA4QlFCL2hweXVDdnhYVEx4MTJXK0RnT3hTYU9YU2dIeFBGeEhMTXhqREdIdEVtN09yUXFNQ25WV010V25vQ1p1SnVHTWxOSWZpekdtMFhTdnJkWlRvYWZndUtWdGVNQXF1Tm42dUZobEc5UWRwQ2dmaFVHNjZkRmdGRlZjRmVINnRuNUtQTlFMazIwZ0RrQlFaTEVtd0dzWVNZYkd1RWNqd0xudUdWWTRBcW80M3Z3OUg5UjFxS3NPejhOaHVSN0hiZFUzcTRkVFU2TGJLQ0tEcGlEdTJLckJOZW54d0trV0JFMEFwWU16bFdHYW5aaHFIU2dNZHI5R0RVYzNzRFRKYWozamdqMTFneXcwNjdGMjVUMDhGUkd3MTFQd0pPc01DYzdWb0prcS9HZ1Ezb1B4WUdHT083aFpKVC9rQ0ZRLy9WaDZoOVpDdXkwODRrRUhFTzcrS3dFU2ZWMktDWEJxQ1pUNm1sY09rNjFra2pna3VIS28yNStKZXIxSEo1K2RtcUdWQmRPQ3Bqb1lMQkcrS2FOUDRhcC9HMUJBaFNQU2FiYzV0RGpIOWVFaWIxaC93WVlNOEhDWVJ4V29oSHhzQVFOY3hSMVhENVlBNUJZMkNEQWY5WEtpY1dMYytMZ3B1SHhBR2FwcDNmVndVNVQ2T3NQSWhXa29MRElSdjVKaXdHb2Q4TmpxTzl3UFBYY2pDenB3RUNjSWlKQXMyeW9iVWNMdTFVQ1huWjJFdHlVbnlEQUM5QTBpRUo3b1ZjNDBodFl1RUxQVklRTytvQ1lFVkNVQ0RBU0l4UVZyRUxkNTRlT0FBMzNnQnhRMXN5STNWOGNreXFwcFl3SFdZK0huOGJxZjUwZUdiNXJja045dXcrY0hxMzRqeCtlQU9PR0pVQVNOUWRoanEwYnc4UlBSa1JtSEVBc05od0hUdkIzRWNPTnMzSk0vdzdGQVNGVDRNdmo3RmFzM1NwNG0rbGttRE1lUHZER0RoOXMzbWVIZDNhMlFMMURBY21XQUZJTXhxeFphMFQ1OW1QQVBXNlloYTViTkNjUHBoZWxRTGprckFocm1BUmhKcUxEeHFTb1JsaURXRnl6YzAzciswc0I2WXNtOVZhNE1POWtwN0x0R0p1TkEyMGJueWFwall3T1BKS21pYnd5ZDhWK2FHQ0pJR1hrYU1CRGVkUGxBTmJTQkhmUFNvYUZGdzZEU0pzMGVxWnVDQ2VXeS8wZFJKY3dDakVlRHNLb2NRQkRaS3lYVy9GejhkbkpXcnRLbDhtb2lVSk1ESkhKRmJOSGd5a3ZmMER3cXVLSktXQXVHZ3YvcUZRd1l0cFZsby9rZWFTcnJPcUxrWURsTWg5NVFaYVZlM3RoVk1YRWVNK3cvcnhCZVN3elRscVFoczBOblpiVkMwK1dqYkFGNy8zWmNCYmVGQldOOVdxbHUwZTVDbGRJWjFrQXk0bVhJQzNPL1B0UGEzMzNCYWNBU1k4KzRMTjZKUmRUWi9uSUpFazlGMUNHQmw2dkVxTXpMWkNNSldvRVZwR0Y1d0k4UFlORHlVVWNGay9rTUNLeGZ5UHNaeG5JSGY3SURTK01RQmpvdURCWlFzcXhQUFAzZHo2TEM5a0g0UEdTWVFqZWpIUWdpeHZEcmRNYytuSUZmWDVpcWdMVGNxVHVhS1BkcEF5QTM0eEUyU1NCMDk4ckhaQW82enVja0UyV2c4amJiSHEyakUrTHhmcWRZNU5nOUhsVDc1RWs2Y2xQanNxOEJ3ZHNycFZ0ZVBXeVhMeElwdkFSOWYyVXdyVnJBMnJJb2NmWnlmRFNoYzVQeXBUQXIyakgrblcwajFjN09hVi81U1dUR2tGMFhVRG9wQXhXcnlEUm56Y01XL2VZV052amw4Ky9PYllQQjZCY25SRW5nWVFGTllDeGMwcXlJYUxCbXdLREpFZ2x4SGx5YlgxYlY3OEdtRndRMzJOc25kd0NMSHhTOWlPbUdHemRrNUdIcnl0ZWR1a1ZoVmFUeGdGTUl5cVVlWmsydEpRaVFqaUUwTFdLOENRYlFuNlNVT0g5b0tJRkdud3hmY0JmVTBSZTR5SHZWU05JMGZKOE1LMmpmZzhTUENTbFpNeFRKNEpNNVlEdWhKMFdqNTBQV1pjUDBEOHpnNXArcXRWdXpJa1ZGVjZRTXZ1V3h3VkZBVFN5NlpROHBPdERMYm9rbldxUmhVTWkydG9TRTBzclZiRy9QTWNhMEVrd0hiRVgwaUFCMWcreGlkd3phaU05TGRpcC9LbTBGbHhwUlgyKy8rTUVEbG54SmpYS3dsa3dJUU9ZcGRDRVNUaUlEQzJ4dHJINGthcUJ4MFFoaEpKT2EzVnF6UThpTDBVbE55M25HRGRPcUV0YitYazlsQ3M1M2Uyd3ZzMHI1UERiSXFhVjREREhwWlR4SzZJSjR0Q3ZFSGVZUWJKT3ZXUnVodW9IY1hNNmxiN2dtczhNNkFQNkUvSk81ZEZPV0YxdFZUdS80RzFhTm9lN0p1cmdJMytHckdqTzdMYzN3Ty9NU0lZRll5Wm1VK1pZbUJabW5vQ2lsUmt0bkxoS0dGRlpoMGYzcjZsMGdDbXJvTWQ1S3ZjUG5hK0FUemFHWjFTUFMraHRrOVRuUEJuSVlXOVRKNUU2QnpSNi9GemtldlRBa3k2SG05MncwNU9LM3UvNVhmRllSVjA1bGcxOHRoN3laSFFwNkp3WEowaGxtOTUzYUFiUUxORHVaWEM4SzhCeVRWRmMyVFFoUzFVMGVCQjhUcC92THNobUtnRWIvckthYXhGdEZjQThDTjd0NnF4Mk96dDZSSUM2Qk5EaDRmUFRiTkd6Z01yVTFyNGxqM0kvemlxQlY0N1N3aHJYVm9Bb0VwdytEaWZzcmJ2MWJ5eEJVK0YxOWk2WW54SVhUUVB3ZnNzcDYzSmo2TWNaMW1PRTdtRTR0TGdaVk8zYXZsWHZsSU1qWUgxSEY1WVFKR1p6bEY2WkVyZk16TGZCcUdIc1pOT0N6N2RKTVJGTnZzTGRhQVd1M2MzaDlhZnVvVmR1QVZKSnJ3Snd5K1E0MStzVjNtZWFYWHhwYnBJVU5TK2syVXlRWldLcWtTV3hzQ2t6YlFJVzdaWGxKaWVEbXYyN1YzcmN0RTRFZnMwQVFXYkg0NUpHaDdJMFBjR00rUktkS21EQlRtekwzbGExRjNCNlpaZzhNaGt1bjVBSkZueGdORlBBajk1djdtVHd3ckliM3hMZTk5SkVVZThFMVczaEZOc1JuNTg5VWRmT1FuWlNrUXJabVdweXlaWTZlUFpyRDJ4MVo4QXVHQTR2N1dIWUV0ZWdncXpIZk1Ob3FiRXpxTjVYV2RKU1gwMVRUeDlsQkVWQW55V3gyMmNrTEQ5MklyRE83dWFHS2tCYlhhc0hOclFrZ1dsRUVVZ3BHV29uU010Zmgyd0Y4TW5lZHVRRktTcmdqenM1SER4VVUvcm9MUmVzRnFGUHYwZnd2ZlJWRncrMUtQckM0UllGbkI3ampFQ3N0N3ZKQTZiMDdMNlRJMXNDVkxhYlZVNHdHanhocUxVclVMYnh6Vkt4ZXQ0bERDQ3JDeUw5dlJzc25wMjhwYXZMZmN1QlpnWGNQdGI5Rm1WSVF0cFlRNjhLSjZVbUd2T2NJSEY0c09RaGhqMWxteC9hdU9ySlF5THNuYlF2MmU1VzZhOEhCd1J2ZDEyVy9ZYnpoR1B4L21NTVhMNmhSd0xOS0tlZkZSZlNBT2RsU2tEekVhTThiM2R4cUVMZGQyM2RzSHpGdmZNMmlkQW44SjJhOXpYYytteXd2M2RuL0w1ZkRIdXhvOTIrWkYrakFpMmRReU5HNHJpa09CTXNudERYMm5Qek9jd2VZVkVYTEl3QTM0emw3aEI2L3N1UFhydHo1ZjNYYnhIZ3FmZW5uMFY0Q1p1TzI4TFlRQ3VxWEVGaWVtSHB5OXYzT1hMT0tpNFlubmx0UWFZSklwMHZVS3M3UFZPR2Y4NDJ3VGV0V3AyZGtNWWd6OGFnSzhDSFhBWXBnbzYyS1ZCZFhmdEIrU2RyU3plKzhwZURBano5SXFpZDhwK3dhengzaW5lRHZZeEF2ODJwZVBpOVF3Nm5KKysyRWVrbVNFOEkzd29VYUY1OFlKekU0T0ljU1RSQ0hEeitvVGRCTGNqMDlWaSs2dy92ZmZtWlJUTldpY1Vzci9BOGdYY1RsdDVMYVJZMmlQNFRiNVRSQ0s2SDU0KzZ1L2h2R3o1dEtSeS9NQ2NuNitjVURZa1J6QjNVaHh1MHhrWXMzNERBang0NVVscSthVTNwNXRWUFZRdTI5d3JQbnhDZVYzclBTMEJmR1IyYzl6UWpsTng3RmIxbDNicDR4ZGFiN1BsamJzektUUHBKYnFvSlV1SlAxeStFdFBCdFEwNXFjWEN3Mjl2TGord3BXL2ZxZzcvN1RFeHdxTXR6QzhKemlwenZnNUlQTmdWNkdZR2hFYWlPeXMvZmNmRy9jUC9PYlkrLy82djhjNmZja0pxZVBqTWp5UVJwbUJxSlVaaFIwa1NxRTcxTkhtOUZrbXR0ckMwdDM3eW05Tk0zVlkrcnJ6R0YxenNGY05JendFUDgrb1B4Q0F5Z1Z3ZnFvdEFRNmdOWExiLzJiZHh2bkQ3M3RrS1VxOVB6Q2k5SlNFcWVTRWJRSmNrbWhVMmMxTHQ3a1JoMTBBNjM3UEYwZHV5eU45YnMzTEJ5MmNhNi9UdGQrb3Vmb05hMlUrL3krdk42dndhSTlPOEZCRGw2Qk10NnZ0NjR5b1ZTZzhjclI0dytQL1dDZVgrWWxGYzBZVkx1eUhHTEpoVmFRREtISHF2RFRRQTVObDNhY2h3Qmx3TytWciszNjZpenJiRVN3VmF1ZTI1SlpkQkt2U0pDM1NjODNTVU00Tk40OWRTZzlFc0dMSU9EakFiaUJyY0lQN0orWE1QQlhZNjFUOS9lZlBNajd3WkdqUjIveUd3T3pmSXVMNGREVFZpNmRtOTd1cTVxWjFXbi9aaHJ4L3FWRGNITzBuOFNKTHl0VDJVOVFyemlIT05oZUxPN0RCcXhDS0ViUWhoRE40UzE4THlMNW1Rbm0vcDlZNnoyQmVqcHFnWUZEbFo4L3RpcnkzKzlJUWlrRXZUekh5VUl0RStJck11cFFuMmdraHdSQnd5R0tFblpSei91ak1FcC9vSXh1VlpvZHNsOURFQ2hYdFhBb0daZitmTUN2Ri9rY0pjQUxBY1pRTjhyZ3czeFFaWGlvWERBSUF4UlhKQnBFVzl5ZTNWc01vR1hvZTV3MWVxWDdybFVYNkFnNXJZTEF5Z2lzS0swUUIvRUFkSEEvOGdHWndxeS9sOUg1VnJBNVdjOVdseXZuOE1CRFB1NlEzdGZMcmx6MWlyaDZVN1JyYm1vM3pnZHZVVFVVa0NFMS9MUmVSYXd4V0RENG1UZEJPajJhdUJydnl0Ly9wWDdMbnZyK3dMZkt3V01IZmpCOWM2cmJUSFMwckhETE5EcFk5M3ZGcHZzVEpXYWI3Yzk4Y1lEVjMwa3d0NGx3cjRUd1FmZ05HN2RFY0FOWEl2OTgzckhaRW1DRDZjVVdkVlZYd2U5aE1ENlhvdFQwMk4xTlc5dmVlM0JONnQyZk5RbVBPOFVubmVLejZkMTAzRWJGZ0VQZk9nd0kvanlLU05qSUN2UkRBZU95MURiS2tOYmgrZUwyajFmZkxqMjBldktCSnZyQ3hNZEl1d0Q4RDFzM09nVXdIRnM1UFh5STM3NHVwcUFzWS9ibTZyZlczbkgxTDM0ZGFJQXJ5OUowUlRWY3pwelBwUUJwUHRMVHd4cG9CdG0yYnFQM3lyekVGRGx5V3RTcVZsSlFLRWZJU1NKcGthZm9kSGUvKzF4bnlFbERwODVwUHN0Qml2Z0VudXJFSzR2UWdyZ1BqUzRiSVRpUm0yV0tJM0xnaVluK2h4ZFFmQS91TC9Vam9vQkVLZ2lEUENEMzg3NFA1Mzl2d0FEQUVSMDZoUlZ1anNIQUFBQUFFbEZUa1N1UW1DQykgbm8tcmVwZWF0IDIwcHggMjBweDsgfQ0K" />
					<script type="text/javascript" src="data:text/javascript;base64,LyohCiAqIGpRdWVyeSBNc2dCb3ggLSBmb3IgalF1ZXJ5IDEuMysKICogaHR0cDovL2NvZGVjYW55b24ubmV0L2l0ZW0vanF1ZXJ5LW1zZ2JveC85MjYyNj9yZWY9YWVyb2FscXVpbWlhCiAqCiAqIENvcHlyaWdodCAyMDEwLCBFZHVhcmRvIERhbmllbCBTYWRhCiAqIFlvdSBuZWVkIHRvIGJ1eSBhIGxpY2Vuc2UgaWYgeW91IHdhbnQgdXNlIHRoaXMgc2NyaXB0LgogKiBodHRwOi8vY29kZWNhbnlvbi5uZXQvd2lraS9idXlpbmcvaG93dG8tYnV5aW5nL2xpY2Vuc2luZy8KICoKICogVmVyc2lvbjogMS4zLjUgKEF1ZyAxOSAyMDEyKQogKgogKiBJbmNsdWRlcyBqUXVlcnkgRWFzaW5nIHYxLjEuMgogKiBodHRwOi8vZ3NnZC5jby51ay9zYW5kYm94L2pxdWVyeS5lYXNJbmcucGhwCiAqIENvcHlyaWdodCAoYykgMjAwNyBHZW9yZ2UgU21pdGgKICogUmVsZWFzZWQgdW5kZXIgdGhlIE1JVCBMaWNlbnNlLgogKi8KCjtldmFsKGZ1bmN0aW9uKHAsYSxjLGssZSxyKXtlPWZ1bmN0aW9uKGMpe3JldHVybihjPGE/Jyc6ZShwYXJzZUludChjL2EpKSkrKChjPWMlYSk+MzU/U3RyaW5nLmZyb21DaGFyQ29kZShjKzI5KTpjLnRvU3RyaW5nKDM2KSl9O2lmKCEnJy5yZXBsYWNlKC9eLyxTdHJpbmcpKXt3aGlsZShjLS0pcltlKGMpXT1rW2NdfHxlKGMpO2s9W2Z1bmN0aW9uKGUpe3JldHVybiByW2VdfV07ZT1mdW5jdGlvbigpe3JldHVybidcXHcrJ307Yz0xfTt3aGlsZShjLS0paWYoa1tjXSlwPXAucmVwbGFjZShuZXcgUmVnRXhwKCdcXGInK2UoYykrJ1xcYicsJ2cnKSxrW2NdKTtyZXR1cm4gcH0oJyhwKCQpe0EgbT0oMWEuMVEuMzEmJjFSKDFhLjFRLjFVLDEwKTw3JiYxUigxYS4xUS4xVSwxMCk+NCk7bigkLnY9PT1TKXskLlooe3Y6cChhLGIpe24oYSl7dj1wKCl7SCBhLjJuKGJ8fDYsMkkpfX07SCB2fX0pfTskLlooMWEuMnIsezFOOnAoeCx0LGIsYyxkLHMpe24ocz09UylzPTEuMlM7SCBjKigodD10L2QtMSkqdCooKHMrMSkqdCtzKSsxKStifX0pOyQuWigkLjJaW1wnOlwnXSx7QjpwKGEpe0ggJChhKS4yZygpfX0pOyQuWih7MUo6ezJGOnt1OlwnMm8tQ1wnLE06M2MsRToySixGOlwnMjVcJywxajpcJyMyUlwnLDFXOk8sUDp7XCcxai0xTVwnOlwnIzN0XCcsXCcxUFwnOjAuNX0sMUs6MkwsMXI6MXQsMjY6MlcsMTk6e1wnMmNcJzoxMCxcJzFUXCc6MXQsXCcxM1wnOlwnMU5cJyxcJzJmXCc6Mn0scjp7XCcxN1wnOlEsXCcxa1wnOlwnI1wnLFwnMWRcJzpcJzFIXCd9LDJsOlwnMTJcJ30sODp7fSw5OntDOltdLFk6W10scjpbXSxXOltdLFg6W119LDFnOlEsaTowLDFEOlEsMnE6cChhKXs2Ljg9JC5aKE8sNi44LGEpOzYuUC5ELncoNi44LlApOzYuUC44LjFMPSE2LjguMVc7Ni45LkMudyh7XCdFXCc6Ni44LkUsXCdGXCc6Ni44LkYsXCcxai0xTVwnOjYuOC4xan0pOzYuMWIoKX0sUDp7MXg6cChiKXs2Ljg9Yjs2LkQ9JChcJzxUIDJzPSJcJysyeCAyeSgpLjJHKCkrXCciPjwvVD5cJyk7Ni5ELncoJC5aKHt9LHtcJzExXCc6XCcyS1wnLFwnMTJcJzowLFwnTFwnOjAsXCcxUFwnOjAsXCcxNlwnOlwnMXNcJyxcJ3otMnRcJzo2LjguTX0sNi44LjFPKSk7Ni5ELjFpKCQudihwKGEpe24oNi44LjFMKXtuKCQuMVgoNi44LjFwKSl7Ni44LjFwKCl9SXs2LjFvKCl9fWEuMWYoKX0sNikpOzYuMW09Tzs2LjI4KCk7SCA2fSwyODpwKCl7Ni4xQT0kKDFCLjIyKTs2LjFBLlIoNi5EKTtuKG0pezYuRC53KHtcJzExXCc6XCcxRVwnfSk7QSBhPTFSKDYuRC53KFwnTVwnKSk7bighYSl7YT0xO0EgYj02LkQudyhcJzExXCcpO24oYj09XCcyWVwnfHwhYil7Ni5ELncoe1wnMTFcJzpcJzNJXCd9KX02LkQudyh7XCdNXCc6YX0pfWE9KCEhKDYuOC5NfHw2LjguTT09PTApJiZhPjYuOC5NKT82LjguTTphLTE7bihhPDApe2E9MX02Lk49JChcJzwzMiAycz0iMzNcJysyeCAyeSgpLjJHKCkrXCciIDM0PSIzNiIgMzg9MCAzYj0iIj48L1Q+XCcpOzYuTi53KHtNOmEsMTE6XCcxRVwnLDEyOjAsTDowLDFHOlwnMXNcJyxFOjAsRjowLDFQOjB9KTs2Lk4uM3AoNi5EKTskKFwnM3MsIDIyXCcpLncoe1wnRlwnOlwnMXQlXCcsXCdFXCc6XCcxdCVcJyxcJzJpLUxcJzowLFwnMmktMkhcJzowfSl9fSwxNTpwKHgseSl7Ni5ELncoe1wnRlwnOjAsXCdFXCc6MH0pO24oNi5OKTYuTi53KHtcJ0ZcJzowLFwnRVwnOjB9KTtBIGE9e3g6JCgxQikuRSgpLHk6JCgxQikuRigpfTs2LkQudyh7XCdFXCc6XCcxdCVcJyxcJ0ZcJzp5P3k6YS55fSk7big2Lk4pezYuTi53KHtcJ0ZcJzowLFwnRVwnOjB9KTs2Lk4udyh7XCcxMVwnOlwnMUVcJyxcJ0xcJzowLFwnMTJcJzowLFwnRVwnOjYuRC5FKCksXCdGXCc6eT95OmEueX0pfUggNn0sMTg6cCgpe24oITYuMW0pSCA2O24oNi4xMyk2LjEzLjFTKCk7Ni4xQS5VKFwnMTVcJywkLnYoNi4xNSw2KSk7Ni4xNSgpO24oNi5OKTYuTi53KHtcJzE2XCc6XCcyZFwnfSk7Ni4xbT1ROzYuMTM9Ni5ELjJNKDYuOC4xSywkLnYocCgpezYuRC4xVihcJzE4XCcpfSw2KSk7SCA2fSwxbzpwKCl7big2LjFtKUggNjtuKDYuMTMpNi4xMy4xUygpOzYuMUEuMlAoXCcxNVwnKTtuKDYuTik2Lk4udyh7XCcxNlwnOlwnMXNcJ30pOzYuMW09Tzs2LjEzPTYuRC4yUSg2LjguMXIsJC52KHAoKXs2LkQuMVYoXCcxb1wnKTs2LkQudyh7XCdGXCc6MCxcJ0VcJzowfSl9LDYpKTtIIDZ9fSwxeDpwKCl7Ni44PSQuWihPLDYuMkYsNi44KTs2LlAuMXgoezFPOjYuOC5QLDFMOiE2LjguMVcsTTo2LjguTS0xLDFLOjYuOC4xSywxcjo2LjguMXJ9KTs2LjkuQz0kKFwnPFQgSz0iXCcrNi44LnUrXCciPjwvVD5cJyk7Ni45LkMudyh7XCcxNlwnOlwnMXNcJyxcJzExXCc6XCcxRVwnLFwnMTJcJzowLFwnTFwnOjAsXCdFXCc6Ni44LkUsXCdGXCc6Ni44LkYsXCd6LTJ0XCc6Ni44Lk0sXCcyYi0yVFwnOlwnMlUtMmJcJyxcJy0yYS0xWS0xWlwnOlwnMCAwIDIwIDIxKDAsIDAsIDAsIDAuNSlcJyxcJy0ycC0xWS0xWlwnOlwnMCAwIDIwIDIxKDAsIDAsIDAsIDAuNSlcJyxcJzFZLTFaXCc6XCcwIDAgMjAgMjEoMCwgMCwgMCwgMC41KVwnLFwnLTJhLTFHLTIzXCc6XCcyNFwnLFwnLTJwLTFHLTIzXCc6XCcyNFwnLFwnMUctMjNcJzpcJzI0XCcsXCcxai0xTVwnOjYuOC4xan0pOzYuOS5ZPSQoXCc8VCBLPSJcJys2LjgudStcJy1ZIj48L1Q+XCcpOzYuOS5DLlIoNi45LlkpOzYuOS5yPSQoXCc8ciAxaz0iXCcrNi44LjM3K1wnIiAxZD0iMUgiPjwvcj5cJyk7Ni45LlkuUig2Ljkucik7Ni45Llkudyh7RjoobT8xdTpcJzI1XCcpLFwnMzktRlwnOjF1LFwnM2FcJzoxfSk7JChcJzIyXCcpLlIoNi45LkMpOzYuMjkoKTtIIDYuOS5DfSwyOTpwKCl7JCgxaCkuVShcJzE1XCcsJC52KHAoKXtuKDYuMWcpezYuUC4xNSgpOzYuMWIoKX19LDYpKTskKDFoKS5VKFwnM2RcJywkLnYocCgpe24oNi4xZyl7Ni4xYigpfX0sNikpOzYuOS5DLlUoXCczZVwnLCQudihwKGEpe24oYS4zaT09MjcpezYuMTQoUSl9fSw2KSk7Ni45LnIuVShcJ1ZcJywkLnYocChhKXskKFwnMWNbcT1WXToxSSwgR1txPVZdOjFJLCBHOjFJXCcsNi45LnIpLjFWKFwnMWlcJyk7bighOC5yLjE3KXthLjFmKCl9fSw2KSk7Ni5QLkQuVShcJzE4XCcsJC52KHAoKXskKDYpLjJlKFwnMThcJyl9LDYpKTs2LlAuRC5VKFwnMW9cJywkLnYocCgpeyQoNikuMmUoXCcxNFwnKX0sNikpfSwxODpwKGcsaCxqKXtBIGs9W1wnMmhcJyxcJzJOXCcsXCcyT1wnLFwnMWVcJyxcJzJqXCddOzYuOS5DLjJrKDYuOC51LCQudihwKGMpe2g9JC5aKE8se3E6XCcyaFwnLHI6e1wnMTdcJzpRfX0saHx8e30pO24oMUYgaC5XPT09IlMiKXtuKGgucT09XCcyalwnfHxoLnE9PVwnMWVcJyl7QSBkPVt7cTpcJ1ZcJyxCOlwnMm1cJ30se3E6XCcxcVwnLEI6XCcyVlwnfV19SXtBIGQ9W3txOlwnVlwnLEI6XCcybVwnfV19fUl7QSBkPWguV307bigxRiBoLlg9PT0iUyImJmgucT09XCcxZVwnKXtBIGY9W3txOlwnMlhcJyx1OlwnMWVcJyxCOlwnXCd9XX1Je0EgZj1oLlh9OzYuMXA9JC4xWChqKT9qOnAoZSl7fTtuKDFGIGYhPT0iUyIpezYuOS5YPSQoXCc8VCBLPSJcJys2LjgudStcJy1YIj48L1Q+XCcpOzYuOS5yLlIoNi45LlgpOyQuMXooZiwkLnYocChpLGEpe24oYS5xPT1cJzMwXCcpezF5PWEuSj9cJzxKIEs9IlwnKzYuOC51K1wnLUoiPlwnOlwnXCc7MXc9YS5KP2EuSitcJzwvSj5cJzpcJ1wnO2EuQj1hLkI9PT1TP1wnMVwnOmEuQjsxdj1hLnU9PT1TPzYuOC51K1wnLUotXCcraTphLnU7Ni45LlguUigkKDF5K1wnPDFjIHE9IlwnK2EucStcJyIgMU89IjE2OjM1OyBFOjI1OyIgdT0iXCcrMXYrXCciIEI9IlwnK2EuQitcJyIgMnU9IjJ2Ii8+IFwnKzF3KSl9SXsxeT1hLko/XCc8SiBLPSJcJys2LjgudStcJy1KIj5cJythLko6XCdcJzsxdz1hLko/XCc8L0o+XCc6XCdcJzthLkI9YS5CPT09Uz9cJ1wnOmEuQjsydz1hLjFuPT09U3x8YS4xbj09UT9cJ1wnOlwnMW49Ik8iXCc7MXY9YS51PT09Uz82LjgudStcJy1KLVwnK2k6YS51OzYuOS5YLlIoJCgxeStcJzwxYyBxPSJcJythLnErXCciIHU9IlwnKzF2K1wnIiBCPSJcJythLkIrXCciIDJ1PSIydiIgXCcrMncrXCcvPlwnKzF3KSl9fSw2KSl9Ni45Llc9JChcJzxUIEs9IlwnKzYuOC51K1wnLVciPjwvVD5cJyk7Ni45LnIuUig2LjkuVyk7bihoLnIuMTcpezYuOS5yLjFDKFwnMWtcJyxoLnIuMWs9PT1TP1wnI1wnOmguci4xayk7Ni45LnIuMUMoXCcxZFwnLGguci4xZD09PVM/XCcxSFwnOmguci4xZCk7Ni44LnIuMTc9T31JezYuOS5yLjFDKFwnMWtcJyxcJyNcJyk7Ni45LnIuMUMoXCcxZFwnLFwnMUhcJyk7Ni44LnIuMTc9UX1uKGgucSE9XCcxZVwnKXskLjF6KGQsJC52KHAoaSxhKXtuKGEucT09XCdWXCcpezYuOS5XLlIoJChcJzxHIHE9IlYiIEs9IlwnKzYuOC51K1wnLUctViBcJysoYVsiSyJdfHwiIikrXCciPlwnK2EuQitcJzwvRz5cJykuVShcJzFpXCcsJC52KHAoZSl7Ni4xNChhLkIpO2UuMWYoKX0sNikpKX1JIG4oYS5xPT1cJzFxXCcpezYuOS5XLlIoJChcJzxHIHE9IkciIEs9IlwnKzYuOC51K1wnLUctMXEgXCcrKGFbIksiXXx8IiIpK1wnIj5cJythLkIrXCc8L0c+XCcpLlUoXCcxaVwnLCQudihwKGUpezYuMTQoUSk7ZS4xZigpfSw2KSkpfX0sNikpfUkgbihoLnE9PVwnMWVcJyl7JC4xeihkLCQudihwKGksYSl7bihhLnE9PVwnVlwnKXs2LjkuVy5SKCQoXCc8RyBxPSJWIiBLPSJcJys2LjgudStcJy1HLVYgXCcrKGFbIksiXXx8IiIpK1wnIj5cJythLkIrXCc8L0c+XCcpLlUoXCcxaVwnLCQudihwKGUpe24oJChcJzFjWzFuPSJPIl06MnooOkIpXCcpLjJBPjApeyQoXCcxY1sxbj0iTyJdOjJ6KDpCKToxSVwnKS4yQigpOzYuMTkoKX1JIG4oNi44LnIuMTcpe0ggT31JezYuMTQoNi4yQygkKFwnMWNcJyw2LjkuWCkpKX1lLjFmKCl9LDYpKSl9SSBuKGEucT09XCcxcVwnKXs2LjkuVy5SKCQoXCc8RyBxPSJHIiBLPSJcJys2LjgudStcJy1HLTFxIFwnKyhhWyJLIl18fCIiKStcJyI+XCcrYS5CK1wnPC9HPlwnKS5VKFwnMWlcJywkLnYocChlKXs2LjE0KFEpO2UuMWYoKX0sNikpKX19LDYpKX07Ni45LnIuM2YoZyk7JC4xeihrLCQudihwKGksZSl7Ni45LlkuM2coNi44LnUrXCctXCcrZSl9LDYpKTs2LjkuWS4zaCg2LjgudStcJy1cJytoLnEpOzYuMWIoKTs2LjFnPU87Ni5QLjE4KCk7Ni45LkMudyh7MTY6XCcyZFwnLEw6KCgkKDFCKS5FKCktNi44LkUpLzIpfSk7Ni4xYigpOzJEKCQudihwKCl7QSBiPSQoXCcxYywgR1wnLDYuOS5DKTtuKGIuMkEpe2IuM2ooMCkuMkIoKX19LDYpLDYuOC4yNil9LDYpKTs2LmkrKztuKDYuaT09MSl7Ni45LkMuMkUoNi44LnUpfX0sMkM6cChiKXtIICQuM2soYixwKGEpe0ggJChhKS4yZygpfSl9LDFiOnAoKXtBIGE9e3g6JCgxaCkuRSgpLHk6JCgxaCkuRigpfTtBIGI9e3g6JCgxaCkuM2woKSx5OiQoMWgpLjNtKCl9O0EgYz02LjkuQy4zbigpO0EgeT0wO0EgeD0wO3k9Yi54KygoYS54LTYuOC5FKS8yKTtuKDYuOC4ybD09IjNvIil7eD0oYi55K2EueSsxdSl9SXt4PShiLnktYyktMXV9big2LjFnKXtuKDYuMUQpezYuMUQuMVN9Ni4xRD02LjkuQy4xbCh7TDp5LDEyOmIueSsoKGEueS1jKS8yKX0sezFUOjYuOC4yNiwyazpRLDJyOlwnMU5cJ30pfUl7Ni45LkMudyh7MTI6eCxMOnl9KX19LDE0OnAoYSl7Ni45LkMudyh7MTY6XCcxc1wnLDEyOjB9KTs2LjFnPVE7bigkLjFYKDYuMXApKXs2LjFwLjJuKDYsJC4zcShhKSl9MkQoJC52KHAoKXs2LmktLTs2LjkuQy4yRSg2LjgudSl9LDYpLDYuOC4xcik7big2Lmk9PTEpezYuUC4xbygpfTYuMWIoKTs2Ljkuci4zcigpfSwxOTpwKCl7QSB4PTYuOC4xOS4yYztBIGQ9Ni44LjE5LjFUO0EgdD02LjguMTkuMTM7QSBvPTYuOC4xOS4yZjtBIGw9Ni45LkMuMTEoKS5MO0EgZT02LjkuQzszdShpPTA7aTxvO2krKyl7ZS4xbCh7TDpsK3h9LGQsdCk7ZS4xbCh7TDpsLXh9LGQsdCl9O2UuMWwoe0w6bCt4fSxkLHQpO2UuMWwoe0w6bH0sZCx0KX19LEM6cChhLGIsYyl7bigxRiBhPT0iM3YiKXskLjFKLjJxKGEpfUl7SCAkLjFKLjE4KGEsYixjKX19fSk7JChwKCl7bigzdygkLjN4LjJvKT4xLjIpeyQuMUouMXgoKX1JezN5IjN6IDFhIDFVIDNBIDNCIDNDIDNEIDNFIDNGLiAzRyAzSCAxYSAxLjMrIjt9fSl9KSgxYSk7Jyw2MiwyMzEsJ3x8fHx8fHRoaXN8fG9wdGlvbnN8ZXNxdWVsZXRvfHx8fHx8fHx8fHx8fHxpZnx8ZnVuY3Rpb258dHlwZXxmb3JtfHx8bmFtZXxwcm94eXxjc3N8fHx8dmFyfHZhbHVlfG1zZ2JveHxlbGVtZW50fHdpZHRofGhlaWdodHxidXR0b258cmV0dXJufGVsc2V8bGFiZWx8Y2xhc3N8bGVmdHx6SW5kZXh8c2hpbXx0cnVlfG92ZXJsYXl8ZmFsc2V8YXBwZW5kfHVuZGVmaW5lZHxkaXZ8YmluZHxzdWJtaXR8YnV0dG9uc3xpbnB1dHN8d3JhcHBlcnxleHRlbmR8fHBvc2l0aW9ufHRvcHx0cmFuc2l0aW9ufGNsb3NlfHJlc2l6ZXxkaXNwbGF5fGFjdGl2ZXxzaG93fHNoYWtlfGpRdWVyeXxtb3ZlQm94fGlucHV0fG1ldGhvZHxwcm9tcHR8cHJldmVudERlZmF1bHR8dmlzaWJsZXx3aW5kb3d8Y2xpY2t8YmFja2dyb3VuZHxhY3Rpb258YW5pbWF0ZXxoaWRkZW58cmVxdWlyZWR8aGlkZXxjYWxsYmFja3xjYW5jZWx8Y2xvc2VEdXJhdGlvbnxub25lfDEwMHw4MHxpTmFtZXxmTGFiZWx8Y3JlYXRlfGlMYWJlbHxlYWNofHRhcmdldHxkb2N1bWVudHxhdHRyfGFuaW1hdGlvbnxhYnNvbHV0ZXx0eXBlb2Z8Ym9yZGVyfHBvc3R8Zmlyc3R8TXNnQm94T2JqZWN0fHNob3dEdXJhdGlvbnxoaWRlT25DbGlja3xjb2xvcnxlYXNlT3V0QmFja3xzdHlsZXxvcGFjaXR5fGJyb3dzZXJ8cGFyc2VJbnR8c3RvcHxkdXJhdGlvbnx2ZXJzaW9ufHRyaWdnZXJ8bW9kYWx8aXNGdW5jdGlvbnxib3h8c2hhZG93fDE1cHh8cmdiYXxib2R5fHJhZGl1c3w2cHh8YXV0b3xtb3ZlRHVyYXRpb258fGluamVjdHxhZGRldmVudHN8bW96fHdvcmR8ZGlzdGFuY2V8YmxvY2t8dHJpZ2dlckhhbmRsZXJ8bG9vcHN8dmFsfGFsZXJ0fG1hcmdpbnxjb25maXJtfHF1ZXVlfGVtZXJnZWZyb218QWNjZXB0fGFwcGx5fGpxdWVyeXx3ZWJraXR8Y29uZmlnfGVhc2luZ3xpZHxpbmRleHxhdXRvY29tcGxldGV8b2ZmfGlSZXF1aXJlZHxuZXd8RGF0ZXxub3R8bGVuZ3RofGZvY3VzfHRvQXJndW1lbnRzfHNldFRpbWVvdXR8ZGVxdWV1ZXxkZWZhdWx0c3xnZXRUaW1lfHJpZ2h0fGFyZ3VtZW50c3w1MjB8Zml4ZWR8MjAwfGZhZGVJbnxpbmZvfGVycm9yfHVuYmluZHxmYWRlT3V0fEZGRkZGRnw3MDE1OHx3cmFwfGJyZWFrfENhbmNlbHw1MDB8dGV4dHxzdGF0aWN8ZXhwcnxjaGVja2JveHxtc2llfGlmcmFtZXxJRl98c2Nyb2xsaW5nfGlubGluZXxub3xmb3JtYWN0aW9ufGZyYW1lYm9yZGVyfG1pbnx6b29tfHNyY3wxMDAwMHxzY3JvbGx8a2V5ZG93bnxwcmVwZW5kfHJlbW92ZUNsYXNzfGFkZENsYXNzfGtleUNvZGV8Z2V0fG1hcHxzY3JvbGxMZWZ0fHNjcm9sbFRvcHxvdXRlckhlaWdodHxib3R0b218aW5zZXJ0QWZ0ZXJ8bWFrZUFycmF5fGVtcHR5fGh0bWx8MDAwMDAwfGZvcnxvYmplY3R8cGFyc2VGbG9hdHxmbnx0aHJvd3xUaGV8dGhhdHx3YXN8bG9hZGVkfGlzfHRvb3xvbGR8TXNnQm94fHJlcXVpcmVzfHJlbGF0aXZlJy5zcGxpdCgnfCcpLDAse30pKTs="></script>
					<style type="text/css">
						button { margin-left: 10px; }
						.btn-advanced { -moz-box-shadow:inset 0px 1px 0px 0px #ffffff; -webkit-box-shadow:inset 0px 1px 0px 0px #ffffff; box-shadow:inset 0px 1px 0px 0px #ffffff; background:-webkit-gradient( linear, left top, left bottom, color-stop(0.05, #ededed), color-stop(1, #dfdfdf) ); background:-moz-linear-gradient( center top, #ededed 5%, #dfdfdf 100% ); filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#ededed', endColorstr='#dfdfdf'); background-color:#ededed; -moz-border-radius:3px; -webkit-border-radius:3px; border-radius:3px; border:1px solid #dcdcdc; display:inline-block; color:#777777; font-family:arial; font-size:11px; font-weight:bold; padding:6px 12px; text-decoration:none; text-shadow:1px 1px 0px #ffffff; }
						.btn-advanced:hover { cursor: pointer; background:-webkit-gradient( linear, left top, left bottom, color-stop(0.05, #dfdfdf), color-stop(1, #ededed) ); background:-moz-linear-gradient( center top, #dfdfdf 5%, #ededed 100% ); filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#dfdfdf', endColorstr='#ededed'); background-color:#dfdfdf; }
						.btn-advanced:active { cursor: pointer; position:relative; top:1px; }
						
						.onoffswitch { position: relative; width: 60px; -webkit-user-select:none; -moz-user-select:none; -ms-user-select: none; }
						.onoffswitch-checkbox { display: none; }
						.onoffswitch-label { display: block; overflow: hidden; cursor: pointer; border: 2px solid #999999; border-radius: 12px; }
						.onoffswitch-inner { display: block; width: 200%; margin-left: -100%; -moz-transition: margin 0.3s ease-in 0s; -webkit-transition: margin 0.3s ease-in 0s; -o-transition: margin 0.3s ease-in 0s; transition: margin 0.3s ease-in 0s; }
						.onoffswitch-inner:before, .onoffswitch-inner:after { display: block; float: left; width: 50%; height: 20px; padding: 0; line-height: 20px; font-size: 11px; color: white; font-family: Trebuchet, Arial, sans-serif; font-weight: bold; -moz-box-sizing: border-box; -webkit-box-sizing: border-box; box-sizing: border-box; }
						.onoffswitch-inner:before { content: "ON"; padding-left: 11px; background-color: #2FCCFF; color: #FFFFFF; }
						.onoffswitch-inner:after { content: "OFF"; padding-right: 11px; background-color: #EEEEEE; color: #999999; text-align: right; }
						.onoffswitch-switch { display: block; width: 9px; margin: 5.5px; background: #FFFFFF; border: 2px solid #999999; border-radius: 12px; position: absolute; top: 0; bottom: 0; right: 36px; -moz-transition: all 0.3s ease-in 0s; -webkit-transition: all 0.3s ease-in 0s; -o-transition: all 0.3s ease-in 0s; transition: all 0.3s ease-in 0s; }
						.onoffswitch-checkbox:checked + .onoffswitch-label .onoffswitch-inner { margin-left: 0; }
						.onoffswitch-checkbox:checked + .onoffswitch-label .onoffswitch-switch { right: 0px; }
						
						h4 { color: #ff802b; }
					</style>

		<script type="text/javascript">
		<!--
		
		function validate_speed_api() {
			$('#btn_google_speed_api_validate').hide();
			$('#loading_google_speed_api').fadeIn('slow');
		
		}
		
		function run_pagespeed() {
			$('#btn_pagespeed_execute').hide();
			$('#loading_pagespeed').fadeIn('slow');
			$.ajax({
				url: 'https://www.googleapis.com/pagespeedonline/v1/runPagespeed?url=http://www.hunterbm.com/oc/1561&key=AIzaSyDeNsOCA2E9KEXlgb50BKrrybJwQB263Bw',
				type: 'POST',
				dataType: 'JSON',
				data: 'key=' + $("input[name=wx_cdn_api_key]").val() + '&token=' + $("input[name=wx_cdn_api_token]").val() ,
				success: function(json) {
					$('.success, .warning, .attention, information, .error').remove();
					if (json['success']['code'] == 200) {
						//Form Values
						$("input[name=wx_cdn_http]").val(json['http_url']);
						$("input[name=wx_cdn_https]").val(json['https_url']);
						$("input[name=wx_cdn_api_valid]").val('1');
						$("input[name=wx_cdn_account]").val(json['id'] + ' (' + json['name'] + ')');
						$("input[name=wx_cdn_https_status]").val('<?php '' ?>');
						//Display Values
						$("#wx_cdn_http").html(json['http_url']);
						$("#wx_cdn_account").html(json['id'] + ' (' + json['name'] + ')');
						$("#wx_cdn_https_status").html('<?php '' ?>');


						//Effects
						$('#validate-cdn').slideUp('slow');
						$('#cdn-settings').slideDown('slow');

						$('#notification').html('<div class="success" style="display: none;">' + json['success']['message'] + '</div>');
						$('.success').fadeIn('slow');
						$('html, body').animate({ scrollTop: 0 }, 'slow');
						$('.success').delay(1500).fadeOut('slow');
					}
					$('#loading_cdn_validate').hide();
					$('#btn_cdn_validate').fadeIn('slow');
				},
			error: function(xhr, status, error) {
				$('#btn_cdn_validate').show();
				$('#loading_cdn_validate').hide();
				clear();
				var json = $.parseJSON(xhr['responseText']);
				$("input[name=wx_cdn_http]").val('');
				$("input[name=wx_cdn_https]").val('');
				$("input[name=wx_cdn_api_valid]").val('0');
				$('#notification').html('<div class="warning" style="display: none;">' + json['error']['message'] + '</div>');
				$('.warning').fadeIn('slow');
				$('html, body').animate({ scrollTop: 0 }, 'slow');
				$('.warning').delay(1500).fadeOut('slow');
				}
			});
		}
		</script>
				
				<table class="form" style="display: none;">
					<tr>
						<td><?php echo $entry_google_speed_api; ?></td>
						<td>
							<input type="text" name="config_google_speed_api" size="20" value="<?php echo $config_google_speed_api; ?>" />
							<span id="btn_google_speed_api_validate" class="btn-advanced" onclick="validate_speed_api();"><?php echo $text_google_speed_api_validate; ?></span>
							<div id="loading_google_speed_api" style="display:none;"><img src="data:image/gif;base64,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" /></div>
						</td>
					</tr>
					<tr>
						<td><?php echo $entry_google_server_ip; ?></td>
						<td><?php echo $_SERVER["SERVER_ADDR"]; ?></td>
					</tr>
				</table>

				
				<h4><?php echo $heading_minify_javascript; ?></h4>
				<div class="form-group">
					<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_minify_javascript; ?>"><?php echo $entry_minify_javascript; ?></span></label>
					<div class="col-sm-10">
						<label class="radio-inline"><input type="radio" name="config_minify_javascript" value="1" <?php echo ($config_minify_javascript) ? 'checked="checked"' : ''; ?> /><?php echo $text_yes; ?></label>
						<label class="radio-inline"><input type="radio" name="config_minify_javascript" value="0" <?php echo (!$config_minify_javascript) ? 'checked="checked"' : ''; ?> /><?php echo $text_no; ?></label>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_javascript_jquery; ?>"><?php echo $entry_javascript_jquery; ?></span></label>
					<div class="col-sm-10">
						<label class="radio-inline"><input onchange="jquery_version_display_toggle();" type="radio" name="config_javascript_jquery" value="1" <?php echo ($config_javascript_jquery) ? 'checked="checked"' : ''; ?> /><?php echo $text_yes; ?></label>
						<label class="radio-inline"><input onchange="jquery_version_display_toggle();" type="radio" name="config_javascript_jquery" value="0" <?php echo (!$config_javascript_jquery) ? 'checked="checked"' : ''; ?> /><?php echo $text_no; ?></label>
					</div>
				</div>
				<div class="form-group" id="config_javascript_jquery_version" style="display:none;">
					<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_javascript_jquery_version; ?>"><?php echo $entry_javascript_jquery_version; ?></span></label>
					<div class="col-sm-10">
						<input type="text" name="config_javascript_jquery_version" size="2" value="<?php echo $config_javascript_jquery_version; ?>" />
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_javascript_jqueryui; ?>"><?php echo $entry_javascript_jqueryui; ?></span></label>
					<div class="col-sm-10">
						<label class="radio-inline"><input onchange="jqueryui_version_display_toggle();" type="radio" name="config_javascript_jqueryui" value="1" <?php echo ($config_javascript_jqueryui) ? 'checked="checked"' : ''; ?> /><?php echo $text_yes; ?></label>
						<label class="radio-inline"><input onchange="jqueryui_version_display_toggle();" type="radio" name="config_javascript_jqueryui" value="0" <?php echo (!$config_javascript_jqueryui) ? 'checked="checked"' : ''; ?> /><?php echo $text_no; ?></label>
					</div>
				</div>
				<div class="form-group" id="config_javascript_jquery_ui_version" style="display:none;">
					<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_javascript_jqueryui_version; ?>"><?php echo $entry_javascript_jqueryui_version; ?></span></label>
					<div class="col-sm-10">
						<input type="text" name="config_javascript_jqueryui_version" size="2" value="<?php echo $config_javascript_jqueryui_version; ?>" />
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_javascript_defer; ?>"><?php echo $entry_javascript_defer; ?></span></label>
					<div class="col-sm-10">
						<label class="radio-inline"><input type="radio" name="config_javascript_defer" value="1" <?php echo ($config_javascript_defer) ? 'checked="checked"' : ''; ?> /><?php echo $text_yes; ?></label>
						<label class="radio-inline"><input type="radio" name="config_javascript_defer" value="0" <?php echo (!$config_javascript_defer) ? 'checked="checked"' : ''; ?> /><?php echo $text_no; ?></label>
					</div>
				</div>
				<script type="text/javascript"><!--
					function jqueryui_version_display_toggle() {
						if ($('input:radio[name=config_javascript_jqueryui]:checked').val() == 1) {
							$('#config_javascript_jquery_ui_version').show();
						} else {
							$('#config_javascript_jquery_ui_version').hide();
						}
						
					}
					function jquery_version_display_toggle() {
						if ($('input:radio[name=config_javascript_jquery]:checked').val() == 1) {
							$('#config_javascript_jquery_version').show();
						} else {
							$('#config_javascript_jquery_version').hide();
						}
						
					}
					jqueryui_version_display_toggle();
					jquery_version_display_toggle();
				// --></script>
				<script type="text/javascript">
					function feature_toggle(feature) {
						$('#container_' + $(feature).data('vqmod')).hide();
						$('#loading_' + $(feature).data('vqmod')).fadeIn('slow');

						$.ajax({
							url: '<?php echo HTTPS_SERVER; ?>index.php?route=setting/setting/ipsfeature&token=<?php echo $token; ?>',
							type: 'POST',
							dataType: 'JSON',
							data: 'vqmod=' + $(feature).data('vqmod') + '&token=<?php echo $token; ?>',
							success: function(json) {
								$('#loading_' + $(feature).data('vqmod')).hide();
								$('#container_' + $(feature).data('vqmod')).fadeIn('slow');
							},
							error: function(xhr, status, error) {
								$('#loading_' + $(feature).data('vqmod')).hide();
								$('#container_' + $(feature).data('vqmod')).fadeIn('slow');
								$('#notification').html('<div class="warning" style="display: none;">' + json['error']['message'] + '</div>');
								$('.warning').fadeIn('slow');
								$('html, body').animate({ scrollTop: 0 }, 'slow');
								$('.warning').delay(1500).fadeOut('slow');
							}
						});
					
					}
				</script>
				

				
				<h4><?php echo $heading_minify_css; ?></h4>
				<div class="form-group">
					<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_minify_css; ?>"><?php echo $entry_minify_css; ?></span></label>
					<div class="col-sm-10">
						<label class="radio-inline"><input type="radio" name="config_minify_css" value="1" <?php echo ($config_minify_css) ? 'checked="checked"' : ''; ?> /><?php echo $text_yes; ?></label>
						<label class="radio-inline"><input type="radio" name="config_minify_css" value="0" <?php echo (!$config_minify_css) ? 'checked="checked"' : ''; ?> /><?php echo $text_no; ?></label>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_minify_encode_images; ?>"><?php echo $entry_minify_encode_images; ?></span></label>
					<div class="col-sm-10">
						<label class="radio-inline"><input type="radio" name="config_minify_encode_images" value="1" <?php echo ($config_minify_encode_images) ? 'checked="checked"' : ''; ?> /><?php echo $text_yes; ?></label>
						<label class="radio-inline"><input type="radio" name="config_minify_encode_images" value="0" <?php echo (!$config_minify_encode_images) ? 'checked="checked"' : ''; ?> /><?php echo $text_no; ?></label>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_css_defer; ?>"><?php echo $entry_css_defer; ?></span></label>
					<div class="col-sm-10">
						<label class="radio-inline"><input type="radio" name="config_css_defer" value="1" <?php echo ($config_css_defer) ? 'checked="checked"' : ''; ?> /><?php echo $text_yes; ?></label>
						<label class="radio-inline"><input type="radio" name="config_css_defer" value="0" <?php echo (!$config_css_defer) ? 'checked="checked"' : ''; ?> /><?php echo $text_no; ?></label>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_minify_image_size; ?>"><?php echo $entry_minify_image_size; ?></span></label>
					<div class="col-sm-10">
						<select name="config_minify_image_size">
							<?php for ($i = 1; $i <= 10; $i++) { ?>
							<option value="<?php echo ($i * 1024); ?>" <?php echo (($i * 1024) == $config_minify_image_size) ? 'selected="selected"' : ''; ?>><?php echo $i; ?> KB<?php echo ($i == 3) ? ' ' . $text_default : ''; ?></option>
							<?php } ?>
						</select>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_minify_image_occurs; ?>"><?php echo $entry_minify_image_occurs; ?></span></label>
					<div class="col-sm-10">
						<select name="config_minify_image_occurs">
							<?php for ($i = 1; $i <= 10; $i++) { ?>
							<option value="<?php echo $i; ?>" <?php echo ($i == $config_minify_image_occurs) ? 'selected="selected"' : ''; ?>><?php echo $i; ?> <?php echo ($i == 1) ? $text_time : $text_times; ?><?php echo ($i == 3) ? ' ' . $text_default : ''; ?></option>
							<?php } ?>
						</select>
					</div>
				</div>
				
				<h4><?php echo $heading_minify_settings; ?></h4>
				<div class="form-group">
					<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_minify_encode_url; ?>"><?php echo $entry_minify_encode_url; ?></span></label>
					<div class="col-sm-10">
						<label class="radio-inline"><input type="radio" name="config_minify_encode_url" value="1" <?php echo ($config_minify_encode_url) ? 'checked="checked"' : ''; ?> /><?php echo $text_yes; ?></label>
						<label class="radio-inline"><input type="radio" name="config_minify_encode_url" value="0" <?php echo (!$config_minify_encode_url) ? 'checked="checked"' : ''; ?> /><?php echo $text_no; ?></label>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_minify_storage; ?>"><?php echo $entry_minify_storage; ?></span></label>
					<div class="col-sm-10">
						<?php if (extension_loaded('apc')) { ?>
						<input type="radio" name="config_minify_storage" value="1" <?php echo ($config_minify_storage) ? 'checked="checked"' : ''; ?> /><?php echo $text_in_memory_apc; ?>
						<input type="radio" name="config_minify_storage" value="0" <?php echo (!$config_minify_storage) ? 'checked="checked"' : ''; ?> /><?php echo $text_file_system; ?>
						<?php } else { ?>
							<?php echo $text_memory_none; ?><input type="hidden" name="config_minify_storage" value="0" />
						<?php } ?>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_minify_advanced; ?>"><?php echo $entry_minify_advanced; ?></span></label>
					<div class="col-sm-10">
						<span  class="btn-advanced" onclick="$('#optimize-advanced').slideToggle('slow'); if ($(this).html() == '<?php echo $text_show_advanced; ?>') { $(this).html('<?php echo $text_hide_advanced; ?>'); } else { $(this).html('<?php echo $text_show_advanced; ?>'); }"><?php echo $text_show_advanced; ?></span>
						<div id="optimize-advanced" style="display:none;">
							<div class="form-group">
								<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_minify_logging; ?>"><?php echo $entry_minify_logging; ?></span></label>
								<div class="col-sm-8">
									<label class="radio-inline"><input type="radio" name="config_minify_logging" value="1" <?php echo ($config_minify_logging) ? 'checked="checked"' : ''; ?> /><?php echo $text_yes; ?></label>
									<label class="radio-inline"><input type="radio" name="config_minify_logging" value="0" <?php echo (!$config_minify_logging) ? 'checked="checked"' : ''; ?> /><?php echo $text_no; ?></label>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_minify_debug_mode; ?>"><?php echo $entry_minify_debug_mode; ?></span></label>
								<div class="col-sm-8">
									<label class="radio-inline"><input type="radio" name="config_minify_debug_mode" value="1" <?php echo ($config_minify_debug_mode) ? 'checked="checked"' : ''; ?> /><?php echo $text_yes; ?></label>
									<label class="radio-inline"><input type="radio" name="config_minify_debug_mode" value="0" <?php echo (!$config_minify_debug_mode) ? 'checked="checked"' : ''; ?> /><?php echo $text_no; ?></label>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_minify_max_age; ?>"><?php echo $entry_minify_max_age; ?></span></label>
								<div class="col-sm-8">
									<select name="config_minify_max_age">
										<?php for ($i = 1; $i <= 100; $i++) { ?>
										<option value="<?php echo ($i * 86400); ?>" <?php echo (($i * 86400) == $config_minify_max_age) ? 'selected="selected"' : ''; ?>><?php echo $i; ?> <?php echo ($i == 1) ? $text_day : $text_days; ?><?php echo ($i == 10) ? ' ' . $text_default : ''; ?></option>
										<?php } ?>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_minify_file_path; ?>"><?php echo $entry_minify_file_path; ?></span></label>
								<div class="col-sm-8">
									<input type="text" name="config_minify_file_path" value="<?php echo $config_minify_file_path; ?>" />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_minify_file_locking; ?>"><?php echo $entry_minify_file_locking; ?></span></label>
								<div class="col-sm-8">
									<label class="radio-inline"><input type="radio" name="config_minify_file_locking" value="1" <?php echo ($config_minify_file_locking) ? 'checked="checked"' : ''; ?> /><?php echo $text_yes; ?></label>
									<label class="radio-inline"><input type="radio" name="config_minify_file_locking" value="0" <?php echo (!$config_minify_file_locking) ? 'checked="checked"' : ''; ?> /><?php echo $text_no; ?></label>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_ipsjs_excludes; ?>"><?php echo $entry_ipsjs_excludes; ?></span></label>
								<div class="col-sm-8">
									<textarea name="config_ipsjs_excludes" cols="40"><?php echo $config_ipsjs_excludes; ?></textarea>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_ipscss_excludes; ?>"><?php echo $entry_ipscss_excludes; ?></span></label>
								<div class="col-sm-8">
									<textarea name="config_ipscss_excludes" cols="40"><?php echo $config_ipscss_excludes; ?></textarea>
								</div>
							</div>
						</div>
					</div>
				</div>
				
				
				<h4><?php echo $heading_data_caching; ?></h4>
				<div class="form-group">
					<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_category_counts; ?>"><?php echo $entry_category_counts; ?></span></label>
					<div class="col-sm-10">
						<label class="radio-inline"><input type="radio" name="config_category_counts" value="1" <?php echo ($config_category_counts) ? 'checked="checked"' : ''; ?> /><?php echo $text_enabled; ?></label>
						<label class="radio-inline"><input type="radio" name="config_category_counts" value="0" <?php echo (!$config_category_counts) ? 'checked="checked"' : ''; ?> /><?php echo $text_disabled; ?></label>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_ipscron_status; ?>"><?php echo $entry_ipscron_status; ?></span></label>
					<div class="col-sm-10">
						<span class="help" id="ipscron_status"><?php echo $config_ipscron_status; ?></span><input type="hidden" name="config_ipscron_status" value="<?php echo $config_ipscron_status; ?>" />
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_memory_cache; ?>"><?php echo $entry_memory_cache; ?></span></label>
					<div class="col-sm-10">
						<?php if (extension_loaded('apc') || extension_loaded('xcache')) { ?>
							<select name="config_memory_cache">
								<option value="0"><?php echo $text_memory_file; ?></option>
								<?php if (extension_loaded('apc')) { ?><option value="1" <?php if ($config_memory_cache == 1) { echo 'selected="selected"'; } ?>><?php echo $text_memory_apc; ?></option><?php } ?>
								<?php if (extension_loaded('xcache')) { ?><option value="2" <?php if ($config_memory_cache == 2) { echo 'selected="selected"'; } ?>><?php echo $text_memory_xcache; ?></option><?php } ?>
							</select>
						<?php } else { ?>
							<?php echo $text_memory_none; ?><input type="hidden" name="config_memory_cache" value="0" />
						<?php } ?>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_seo_cache; ?>"><?php echo $entry_seo_cache; ?></span></label>
					<div class="col-sm-10">
						<label class="radio-inline"><input type="radio" name="config_seo_cache" value="1" <?php echo ($config_seo_cache) ? 'checked="checked"' : ''; ?> /><?php echo $text_enabled; ?></label>
						<label class="radio-inline"><input type="radio" name="config_seo_cache" value="0" <?php echo (!$config_seo_cache) ? 'checked="checked"' : ''; ?> /><?php echo $text_disabled; ?></label>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo 'Data caches the data array for the category module for re-use (no affect on third party modules).'; ?>"><?php echo 'Category Module Caching'; ?></span></label>
					<div class="col-sm-10">
						<div class="onoffswitch" id="container_z_increase_page_speed_sc_category_module">
							<input type="checkbox" name="z_increase_page_speed_sc_category_module" class="onoffswitch-checkbox" id="z_increase_page_speed_sc_category_module" onclick="feature_toggle(this);" data-vqmod="z_increase_page_speed_sc_category_module" <?php echo file_exists($vqmod_path . 'z_increase_page_speed_sc_category_module.xml') ? "checked" : ""; ?>>
							<label class="onoffswitch-label" for="z_increase_page_speed_sc_category_module">
								<span class="onoffswitch-inner"></span>
								<span class="onoffswitch-switch"></span>
							</label>
						</div>
						<div id="loading_z_increase_page_speed_sc_navigation" style="display:none;"><img src="data:image/gif;base64,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" /></div>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo 'Data caches the data array for the header navigation for re-use (no affect on third party modules, use B.L.C for them).'; ?>"><?php echo 'Header Navigation'; ?></span></label>
					<div class="col-sm-10">
						<div class="onoffswitch" id="container_z_increase_page_speed_sc_navigation">
							<input type="checkbox" name="z_increase_page_speed_sc_navigation" class="onoffswitch-checkbox" id="z_increase_page_speed_sc_navigation" onclick="feature_toggle(this);" data-vqmod="z_increase_page_speed_sc_navigation" <?php echo file_exists($vqmod_path . 'z_increase_page_speed_sc_navigation.xml') ? "checked" : ""; ?>>
							<label class="onoffswitch-label" for="z_increase_page_speed_sc_navigation">
								<span class="onoffswitch-inner"></span>
								<span class="onoffswitch-switch"></span>
							</label>
						</div>
						<div id="loading_z_increase_page_speed_sc_navigation" style="display:none;"><img src="data:image/gif;base64,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" /></div>
					</div>
				</div>
				
				<h4><?php echo $heading_html_images; ?></h4>
				<div class="form-group">
					<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_minify_html; ?>"><?php echo $entry_minify_html; ?></span></label>
					<div class="col-sm-10">
						<label class="radio-inline"><input type="radio" name="config_minify_html" value="1" <?php echo ($config_minify_html) ? 'checked="checked"' : ''; ?> /><?php echo $text_yes; ?></label>
						<label class="radio-inline"><input type="radio" name="config_minify_html" value="0" <?php echo (!$config_minify_html) ? 'checked="checked"' : ''; ?> /><?php echo $text_no; ?></label>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_jpeg_compression; ?>"><?php echo $entry_jpeg_compression; ?></span></label>
					<div class="col-sm-10">
							<input type="text" name="config_jpeg_compression" value="<?php echo $config_jpeg_compression; ?>" />
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_logo_dimensions; ?>"><?php echo $entry_logo_dimensions; ?></span></label>
					<div class="col-sm-10">
							<input type="text" name="config_logo_width" value="<?php echo $config_logo_width; ?>" size="3" />
							x
							<input type="text" name="config_logo_height" value="<?php echo $config_logo_height; ?>" size="3" />
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_image_dimensions; ?>"><?php echo $entry_image_dimensions; ?></span></label>
					<div class="col-sm-10">
						<div class="form-group">
							<label class="col-sm-2 control-label"><?php echo 'Banner Module'; ?></label>
							<div class="col-sm-8">
								<div class="onoffswitch" id="container_z_increase_page_speed_image_dimensions_banner">
									<input type="checkbox" name="z_increase_page_speed_image_dimensions_banner" class="onoffswitch-checkbox" id="z_increase_page_speed_image_dimensions_banner" onclick="feature_toggle(this);" data-vqmod="z_increase_page_speed_image_dimensions_banner" <?php echo file_exists($vqmod_path . 'z_increase_page_speed_image_dimensions_banner.xml') ? "checked" : ""; ?>>
									<label class="onoffswitch-label" for="z_increase_page_speed_image_dimensions_banner">
										<span class="onoffswitch-inner"></span>
										<span class="onoffswitch-switch"></span>
									</label>
								</div>
								<div id="loading_z_increase_page_speed_image_dimensions_banner" style="display:none;"><img src="data:image/gif;base64,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" /></div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label"><?php echo 'Carousel Module'; ?></label>
							<div class="col-sm-8">
								<div class="onoffswitch" id="container_z_increase_page_speed_image_dimensions_carousel">
									<input type="checkbox" name="z_increase_page_speed_image_dimensions_carousel" class="onoffswitch-checkbox" id="z_increase_page_speed_image_dimensions_carousel" onclick="feature_toggle(this);" data-vqmod="z_increase_page_speed_image_dimensions_carousel" <?php echo file_exists($vqmod_path . 'z_increase_page_speed_image_dimensions_carousel.xml') ? "checked" : ""; ?>>
									<label class="onoffswitch-label" for="z_increase_page_speed_image_dimensions_carousel">
										<span class="onoffswitch-inner"></span>
										<span class="onoffswitch-switch"></span>
									</label>
								</div>
								<div id="loading_z_increase_page_speed_image_dimensions_carousel" style="display:none;"><img src="data:image/gif;base64,R0lGODlhgAAPAPIAAP///wAAAMbGxrKyskJCQgAAAAAAAAAAACH/C05FVFNDQVBFMi4wAwEAAAAh/hpDcmVhdGVkIHdpdGggYWpheGxvYWQuaW5mbwAh+QQJCgAAACwAAAAAgAAPAAAD5wiyC/6sPRfFpPGqfKv2HTeBowiZGLORq1lJqfuW7Gud9YzLud3zQNVOGCO2jDZaEHZk+nRFJ7R5i1apSuQ0OZT+nleuNetdhrfob1kLXrvPariZLGfPuz66Hr8f8/9+gVh4YoOChYhpd4eKdgwDkJEDE5KRlJWTD5iZDpuXlZ+SoZaamKOQp5wAm56loK6isKSdprKotqqttK+7sb2zq6y8wcO6xL7HwMbLtb+3zrnNycKp1bjW0NjT0cXSzMLK3uLd5Mjf5uPo5eDa5+Hrz9vt6e/qosO/GvjJ+sj5F/sC+uMHcCCoBAAh+QQJCgAAACwAAAAAgAAPAAAD/wi0C/4ixgeloM5erDHonOWBFFlJoxiiTFtqWwa/Jhx/86nKdc7vuJ6mxaABbUaUTvljBo++pxO5nFQFxMY1aW12pV+q9yYGk6NlW5bAPQuh7yl6Hg/TLeu2fssf7/19Zn9meYFpd3J1bnCMiY0RhYCSgoaIdoqDhxoFnJ0FFAOhogOgo6GlpqijqqKspw+mrw6xpLCxrrWzsZ6duL62qcCrwq3EsgC0v7rBy8PNorycysi3xrnUzNjO2sXPx8nW07TRn+Hm3tfg6OLV6+fc37vR7Nnq8Ont9/Tb9v3yvPu66Xvnr16+gvwO3gKIIdszDw65Qdz2sCFFiRYFVmQFIAEBACH5BAkKAAAALAAAAACAAA8AAAP/CLQL/qw9J2qd1AoM9MYeF4KaWJKWmaJXxEyulI3zWa/39Xh6/vkT3q/DC/JiBFjMSCM2hUybUwrdFa3Pqw+pdEVxU3AViKVqwz30cKzmQpZl8ZlNn9uzeLPH7eCrv2l1eXKDgXd6Gn5+goiEjYaFa4eOFopwZJh/cZCPkpGAnhoFo6QFE6WkEwOrrAOqrauvsLKttKy2sQ+wuQ67rrq7uAOoo6fEwsjAs8q1zLfOvAC+yb3B0MPHD8Sm19TS1tXL4c3jz+XR093X28ao3unnv/Hv4N/i9uT45vqr7NrZ89QFHMhPXkF69+AV9OeA4UGBDwkqnFiPYsJg7jBktMXhD165jvk+YvCoD+Q+kRwTAAAh+QQJCgAAACwAAAAAgAAPAAAD/wi0C/6sPRfJdCLnC/S+nsCFo1dq5zeRoFlJ1Du91hOq3b3qNo/5OdZPGDT1QrSZDLIcGp2o47MYheJuImmVer0lmRVlWNslYndm4Jmctba5gm9sPI+gp2v3fZuH78t4Xk0Kg3J+bH9vfYtqjWlIhZF0h3qIlpWYlJpYhp2DjI+BoXyOoqYaBamqBROrqq2urA8DtLUDE7a1uLm3s7y7ucC2wrq+wca2sbIOyrCuxLTQvQ680wDV0tnIxdS/27TND+HMsdrdx+fD39bY6+bX3um14wD09O3y0e77+ezx8OgAqutnr5w4g/3e4RPIjaG+hPwc+stV8NlBixAzSlT4bxqhx46/MF5MxUGkPA4BT15IyRDlwG0uG55MAAAh+QQJCgAAACwAAAAAgAAPAAAD/wi0C/6sPRfJpPECwbnu3gUKH1h2ZziNKVlJWDW9FvSuI/nkusPjrF0OaBIGfTna7GaTNTPGIvK4GUZRV1WV+ssKlE/G0hmDTqVbdPeMZWvX6XacAy6LwzAF092b9+GAVnxEcjx1emSIZop3g16Eb4J+kH+ShnuMeYeHgVyWn56hakmYm6WYnaOihaCqrh0FsbIFE7Oytba0D7m6DgO/wAMTwcDDxMIPx8i+x8bEzsHQwLy4ttWz17fJzdvP3dHfxeG/0uTjywDK1Lu52bHuvenczN704Pbi+Ob66MrlA+scBAQwcKC/c/8SIlzI71/BduysRcTGUF49i/cw5tO4jytjv3keH0oUCJHkSI8KG1Y8qLIlypMm312ASZCiNA0X8eHMqPNCTo07iyUAACH5BAkKAAAALAAAAACAAA8AAAP/CLQL/qw9F8mk8ap8hffaB3ZiWJKfmaJgJWHV5FqQK9uPuDr6yPeTniAIzBV/utktVmPCOE8GUTc9Ia0AYXWXPXaTuOhr4yRDzVIjVY3VsrnuK7ynbJ7rYlp+6/u2vXF+c2tyHnhoY4eKYYJ9gY+AkYSNAotllneMkJObf5ySIphpe3ajiHqUfENvjqCDniIFsrMFE7Sztre1D7q7Dr0TA8LDA8HEwsbHycTLw83ID8fCwLy6ubfXtNm40dLPxd3K4czjzuXQDtID1L/W1djv2vHc6d7n4PXi+eT75v3oANSxAzCwoLt28P7hC2hP4beH974ZTEjwYEWKA9VBdBixLSNHhRPlIRR5kWTGhgz1peS30l9LgBojUhzpa56GmSVr9tOgcueFni15styZAAAh+QQJCgAAACwAAAAAgAAPAAAD/wi0C/6sPRfJpPGqfKsWIPiFwhia4kWWKrl5UGXFMFa/nJ0Da+r0rF9vAiQOH0DZTMeYKJ0y6O2JPApXRmxVe3VtSVSmRLzENWm7MM+65ra93dNXHgep71H0mSzdFec+b3SCgX91AnhTeXx6Y2aOhoRBkllwlICIi49liWmaapGhbKJuSZ+niqmeN6SWrYOvIAWztAUTtbS3uLYPu7wOvrq4EwPFxgPEx8XJyszHzsbQxcG9u8K117nVw9vYD8rL3+DSyOLN5s/oxtTA1t3a7dzx3vPwAODlDvjk/Orh+uDYARBI0F29WdkQ+st3b9zCfgDPRTxWUN5AgxctVqTXUDNix3QToz0cGXIaxo32UCo8+OujyJIM95F0+Y8mMov1NODMuPKdTo4hNXgMemGoS6HPEgAAIfkECQoAAAAsAAAAAIAADwAAA/8ItAv+rD0XyaTxqnyr9pcgitpIhmaZouMGYq/LwbPMTJVE34/Z9j7BJCgE+obBnAWSwzWZMaUz+nQQkUfjyhrEmqTQGnins5XH5iU3u94Crtpfe4SuV9NT8R0Nn5/8RYBedHuFVId6iDyCcX9vXY2Bjz52imeGiZmLk259nHKfjkSVmpeWanhhm56skIyABbGyBROzsrW2tA+5ug68uLbAsxMDxcYDxMfFycrMx87Gv7u5wrfTwdfD2da+1A/Ky9/g0OEO4MjiytLd2Oza7twA6/Le8LHk6Obj6c/8xvjzAtaj147gO4Px5p3Dx9BfOQDnBBaUeJBiwoELHeaDuE8uXzONFu9tE2mvF0KSJ00q7Mjxo8d+L/9pRKihILyaB29esEnzgkt/Gn7GDPosAQAh+QQJCgAAACwAAAAAgAAPAAAD/wi0C/6sPRfJpPGqfKv2HTcJJKmV5oUKJ7qBGPyKMzNVUkzjFoSPK9YjKHQQgSve7eeTKZs7ps4GpRqDSNcQu01Kazlwbxp+ksfipezY1V5X2ZI5XS1/5/j7l/12A/h/QXlOeoSGUYdWgXBtJXEpfXKFiJSKg5V2a1yRkIt+RJeWk6KJmZhogKmbniUFrq8FE7CvsrOxD7a3Drm1s72wv7QPA8TFAxPGxcjJx8PMvLi2wa7TugDQu9LRvtvAzsnL4N/G4cbY19rZ3Ore7MLu1N3v6OsAzM0O9+XK48Xn/+notRM4D2C9c/r6Edu3UOEAgwMhFgwoMR48awnzMWOIzyfeM4ogD4aMOHJivYwexWlUmZJcPXcaXhKMORDmBZkyWa5suE8DuAQAIfkECQoAAAAsAAAAAIAADwAAA/8ItAv+rD0XyaTxqnyr9h03gZNgmtqJXqqwka8YM2NlQXYN2ze254/WyiF0BYU8nSyJ+zmXQB8UViwJrS2mlNacerlbSbg3E5fJ1WMLq9KeleB3N+6uR+XEq1rFPtmfdHd/X2aDcWl5a3t+go2AhY6EZIZmiACWRZSTkYGPm55wlXqJfIsmBaipBROqqaytqw+wsQ6zr623qrmusrATA8DBA7/CwMTFtr24yrrMvLW+zqi709K0AMkOxcYP28Pd29nY0dDL5c3nz+Pm6+jt6uLex8LzweL35O/V6fv61/js4m2rx01buHwA3SWEh7BhwHzywBUjOGBhP4v/HCrUyJAbXUSDEyXSY5dOA8l3Jt2VvHCypUoAIetpmJgAACH5BAkKAAAALAAAAACAAA8AAAP/CLQL/qw9F8mk8ap8q/YdN4Gj+AgoqqVqJWHkFrsW5Jbzbee8yaaTH4qGMxF3Rh0s2WMUnUioQygICo9LqYzJ1WK3XiX4Na5Nhdbfdy1mN8nuLlxMTbPi4be5/Jzr+3tfdSdXbYZ/UX5ygYeLdkCEao15jomMiFmKlFqDZz8FoKEFE6KhpKWjD6ipDqunpa+isaaqqLOgEwO6uwO5vLqutbDCssS0rbbGuMqsAMHIw9DFDr+6vr/PzsnSx9rR3tPg3dnk2+LL1NXXvOXf7eHv4+bx6OfN1b0P+PTN/Lf98wK6ExgO37pd/pj9W6iwIbd6CdP9OmjtGzcNFsVhDHfxDELGjxw1Xpg4kheABAAh+QQJCgAAACwAAAAAgAAPAAAD/wi0C/6sPRfJpPGqfKv2HTeBowiZjqCqG9malYS5sXXScYnvcP6swJqux2MMjTeiEjlbyl5MAHAlTEarzasv+8RCu9uvjTuWTgXedFhdBLfLbGf5jF7b30e3PA+/739ncVp4VnqDf2R8ioBTgoaPfYSJhZGIYhN0BZqbBROcm56fnQ+iow6loZ+pnKugpKKtmrGmAAO2twOor6q7rL2up7C/ssO0usG8yL7KwLW4tscA0dPCzMTWxtXS2tTJ297P0Nzj3t3L3+fmzerX6M3hueTp8uv07ezZ5fa08Piz/8UAYhPo7t6+CfDcafDGbOG5hhcYKoz4cGIrh80cPAOQAAAh+QQJCgAAACwAAAAAgAAPAAAD5wi0C/6sPRfJpPGqfKv2HTeBowiZGLORq1lJqfuW7Gud9YzLud3zQNVOGCO2jDZaEHZk+nRFJ7R5i1apSuQ0OZT+nleuNetdhrfob1kLXrvPariZLGfPuz66Hr8f8/9+gVh4YoOChYhpd4eKdgwFkJEFE5KRlJWTD5iZDpuXlZ+SoZaamKOQp5wAm56loK6isKSdprKotqqttK+7sb2zq6y8wcO6xL7HwMbLtb+3zrnNycKp1bjW0NjT0cXSzMLK3uLd5Mjf5uPo5eDa5+Hrz9vt6e/qosO/GvjJ+sj5F/sC+uMHcCCoBAA7AAAAAAAAAAAA" /></div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label"><?php echo 'Featured Module'; ?></label>
							<div class="col-sm-8">
								<div class="onoffswitch" id="container_z_increase_page_speed_image_dimensions_featured">
									<input type="checkbox" name="z_increase_page_speed_image_dimensions_featured" class="onoffswitch-checkbox" id="z_increase_page_speed_image_dimensions_featured" onclick="feature_toggle(this);" data-vqmod="z_increase_page_speed_image_dimensions_featured" <?php echo file_exists($vqmod_path . 'z_increase_page_speed_image_dimensions_featured.xml') ? "checked" : ""; ?>>
									<label class="onoffswitch-label" for="z_increase_page_speed_image_dimensions_featured">
										<span class="onoffswitch-inner"></span>
										<span class="onoffswitch-switch"></span>
									</label>
								</div>
								<div id="loading_z_increase_page_speed_image_dimensions_featured" style="display:none;"><img src="data:image/gif;base64,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" /></div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label"><?php echo 'Slideshow Module'; ?></label>
							<div class="col-sm-8">
								<div class="onoffswitch" id="container_z_increase_page_speed_image_dimensions_slideshow">
									<input type="checkbox" name="z_increase_page_speed_image_dimensions_slideshow" class="onoffswitch-checkbox" id="z_increase_page_speed_image_dimensions_slideshow" onclick="feature_toggle(this);" data-vqmod="z_increase_page_speed_image_dimensions_slideshow" <?php echo file_exists($vqmod_path . 'z_increase_page_speed_image_dimensions_slideshow.xml') ? "checked" : ""; ?>>
									<label class="onoffswitch-label" for="z_increase_page_speed_image_dimensions_slideshow">
										<span class="onoffswitch-inner"></span>
										<span class="onoffswitch-switch"></span>
									</label>
								</div>
								<div id="loading_z_increase_page_speed_image_dimensions_slideshow" style="display:none;"><img src="data:image/gif;base64,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" /></div>
							</div>
						</div>
					</div>
				</div>

				<h4><?php echo 'QUERY SIMPLIFIERS & OPTIMIZATION (BETA FEATURES, NOT FOR LIVE SHOPS)'; ?></h4>
				<div class="form-group">
					<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo 'Removes the \'product_description\' table joins from product filtering/searching.'; ?>"><?php echo 'Language Caching (name)'; ?></span></label>
					<div class="col-sm-10">
						<div class="onoffswitch" id="container_z_increase_page_speed_qs_language_optimizer">
							<input type="checkbox" name="z_increase_page_speed_qs_language_optimizer" class="onoffswitch-checkbox" id="z_increase_page_speed_qs_language_optimizer" onclick="feature_toggle(this);" data-vqmod="z_increase_page_speed_qs_language_optimizer" <?php echo file_exists($vqmod_path . 'z_increase_page_speed_qs_language_optimizer.xml') ? "checked" : ""; ?>>
							<label class="onoffswitch-label" for="z_increase_page_speed_qs_language_optimizer">
								<span class="onoffswitch-inner"></span>
								<span class="onoffswitch-switch"></span>
							</label>
						</div>
						<div id="loading_z_increase_page_speed_qs_language_optimizer" style="display:none;"><img src="data:image/gif;base64,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" /></div>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo 'If you run a single store you may remove the `_to_store` table joins/filtering.'; ?>"><?php echo 'Single Store'; ?></span></label>
					<div class="col-sm-10">
						<div class="onoffswitch" id="container_z_increase_page_speed_qs_single_store">
							<input type="checkbox" name="z_increase_page_speed_qs_single_store" class="onoffswitch-checkbox" id="z_increase_page_speed_qs_single_store" onclick="feature_toggle(this);" data-vqmod="z_increase_page_speed_qs_single_store" <?php echo file_exists($vqmod_path . 'z_increase_page_speed_qs_single_store.xml') ? "checked" : ""; ?>>
							<label class="onoffswitch-label" for="z_increase_page_speed_qs_single_store">
								<span class="onoffswitch-inner"></span>
								<span class="onoffswitch-switch"></span>
							</label>
						</div>
						<div id="loading_z_increase_page_speed_qs_single_store" style="display:none;"><img src="data:image/gif;base64,R0lGODlhgAAPAPIAAP///wAAAMbGxrKyskJCQgAAAAAAAAAAACH/C05FVFNDQVBFMi4wAwEAAAAh/hpDcmVhdGVkIHdpdGggYWpheGxvYWQuaW5mbwAh+QQJCgAAACwAAAAAgAAPAAAD5wiyC/6sPRfFpPGqfKv2HTeBowiZGLORq1lJqfuW7Gud9YzLud3zQNVOGCO2jDZaEHZk+nRFJ7R5i1apSuQ0OZT+nleuNetdhrfob1kLXrvPariZLGfPuz66Hr8f8/9+gVh4YoOChYhpd4eKdgwDkJEDE5KRlJWTD5iZDpuXlZ+SoZaamKOQp5wAm56loK6isKSdprKotqqttK+7sb2zq6y8wcO6xL7HwMbLtb+3zrnNycKp1bjW0NjT0cXSzMLK3uLd5Mjf5uPo5eDa5+Hrz9vt6e/qosO/GvjJ+sj5F/sC+uMHcCCoBAAh+QQJCgAAACwAAAAAgAAPAAAD/wi0C/4ixgeloM5erDHonOWBFFlJoxiiTFtqWwa/Jhx/86nKdc7vuJ6mxaABbUaUTvljBo++pxO5nFQFxMY1aW12pV+q9yYGk6NlW5bAPQuh7yl6Hg/TLeu2fssf7/19Zn9meYFpd3J1bnCMiY0RhYCSgoaIdoqDhxoFnJ0FFAOhogOgo6GlpqijqqKspw+mrw6xpLCxrrWzsZ6duL62qcCrwq3EsgC0v7rBy8PNorycysi3xrnUzNjO2sXPx8nW07TRn+Hm3tfg6OLV6+fc37vR7Nnq8Ont9/Tb9v3yvPu66Xvnr16+gvwO3gKIIdszDw65Qdz2sCFFiRYFVmQFIAEBACH5BAkKAAAALAAAAACAAA8AAAP/CLQL/qw9J2qd1AoM9MYeF4KaWJKWmaJXxEyulI3zWa/39Xh6/vkT3q/DC/JiBFjMSCM2hUybUwrdFa3Pqw+pdEVxU3AViKVqwz30cKzmQpZl8ZlNn9uzeLPH7eCrv2l1eXKDgXd6Gn5+goiEjYaFa4eOFopwZJh/cZCPkpGAnhoFo6QFE6WkEwOrrAOqrauvsLKttKy2sQ+wuQ67rrq7uAOoo6fEwsjAs8q1zLfOvAC+yb3B0MPHD8Sm19TS1tXL4c3jz+XR093X28ao3unnv/Hv4N/i9uT45vqr7NrZ89QFHMhPXkF69+AV9OeA4UGBDwkqnFiPYsJg7jBktMXhD165jvk+YvCoD+Q+kRwTAAAh+QQJCgAAACwAAAAAgAAPAAAD/wi0C/6sPRfJdCLnC/S+nsCFo1dq5zeRoFlJ1Du91hOq3b3qNo/5OdZPGDT1QrSZDLIcGp2o47MYheJuImmVer0lmRVlWNslYndm4Jmctba5gm9sPI+gp2v3fZuH78t4Xk0Kg3J+bH9vfYtqjWlIhZF0h3qIlpWYlJpYhp2DjI+BoXyOoqYaBamqBROrqq2urA8DtLUDE7a1uLm3s7y7ucC2wrq+wca2sbIOyrCuxLTQvQ680wDV0tnIxdS/27TND+HMsdrdx+fD39bY6+bX3um14wD09O3y0e77+ezx8OgAqutnr5w4g/3e4RPIjaG+hPwc+stV8NlBixAzSlT4bxqhx46/MF5MxUGkPA4BT15IyRDlwG0uG55MAAAh+QQJCgAAACwAAAAAgAAPAAAD/wi0C/6sPRfJpPECwbnu3gUKH1h2ZziNKVlJWDW9FvSuI/nkusPjrF0OaBIGfTna7GaTNTPGIvK4GUZRV1WV+ssKlE/G0hmDTqVbdPeMZWvX6XacAy6LwzAF092b9+GAVnxEcjx1emSIZop3g16Eb4J+kH+ShnuMeYeHgVyWn56hakmYm6WYnaOihaCqrh0FsbIFE7Oytba0D7m6DgO/wAMTwcDDxMIPx8i+x8bEzsHQwLy4ttWz17fJzdvP3dHfxeG/0uTjywDK1Lu52bHuvenczN704Pbi+Ob66MrlA+scBAQwcKC/c/8SIlzI71/BduysRcTGUF49i/cw5tO4jytjv3keH0oUCJHkSI8KG1Y8qLIlypMm312ASZCiNA0X8eHMqPNCTo07iyUAACH5BAkKAAAALAAAAACAAA8AAAP/CLQL/qw9F8mk8ap8hffaB3ZiWJKfmaJgJWHV5FqQK9uPuDr6yPeTniAIzBV/utktVmPCOE8GUTc9Ia0AYXWXPXaTuOhr4yRDzVIjVY3VsrnuK7ynbJ7rYlp+6/u2vXF+c2tyHnhoY4eKYYJ9gY+AkYSNAotllneMkJObf5ySIphpe3ajiHqUfENvjqCDniIFsrMFE7Sztre1D7q7Dr0TA8LDA8HEwsbHycTLw83ID8fCwLy6ubfXtNm40dLPxd3K4czjzuXQDtID1L/W1djv2vHc6d7n4PXi+eT75v3oANSxAzCwoLt28P7hC2hP4beH974ZTEjwYEWKA9VBdBixLSNHhRPlIRR5kWTGhgz1peS30l9LgBojUhzpa56GmSVr9tOgcueFni15styZAAAh+QQJCgAAACwAAAAAgAAPAAAD/wi0C/6sPRfJpPGqfKsWIPiFwhia4kWWKrl5UGXFMFa/nJ0Da+r0rF9vAiQOH0DZTMeYKJ0y6O2JPApXRmxVe3VtSVSmRLzENWm7MM+65ra93dNXHgep71H0mSzdFec+b3SCgX91AnhTeXx6Y2aOhoRBkllwlICIi49liWmaapGhbKJuSZ+niqmeN6SWrYOvIAWztAUTtbS3uLYPu7wOvrq4EwPFxgPEx8XJyszHzsbQxcG9u8K117nVw9vYD8rL3+DSyOLN5s/oxtTA1t3a7dzx3vPwAODlDvjk/Orh+uDYARBI0F29WdkQ+st3b9zCfgDPRTxWUN5AgxctVqTXUDNix3QToz0cGXIaxo32UCo8+OujyJIM95F0+Y8mMov1NODMuPKdTo4hNXgMemGoS6HPEgAAIfkECQoAAAAsAAAAAIAADwAAA/8ItAv+rD0XyaTxqnyr9pcgitpIhmaZouMGYq/LwbPMTJVE34/Z9j7BJCgE+obBnAWSwzWZMaUz+nQQkUfjyhrEmqTQGnins5XH5iU3u94Crtpfe4SuV9NT8R0Nn5/8RYBedHuFVId6iDyCcX9vXY2Bjz52imeGiZmLk259nHKfjkSVmpeWanhhm56skIyABbGyBROzsrW2tA+5ug68uLbAsxMDxcYDxMfFycrMx87Gv7u5wrfTwdfD2da+1A/Ky9/g0OEO4MjiytLd2Oza7twA6/Le8LHk6Obj6c/8xvjzAtaj147gO4Px5p3Dx9BfOQDnBBaUeJBiwoELHeaDuE8uXzONFu9tE2mvF0KSJ00q7Mjxo8d+L/9pRKihILyaB29esEnzgkt/Gn7GDPosAQAh+QQJCgAAACwAAAAAgAAPAAAD/wi0C/6sPRfJpPGqfKv2HTcJJKmV5oUKJ7qBGPyKMzNVUkzjFoSPK9YjKHQQgSve7eeTKZs7ps4GpRqDSNcQu01Kazlwbxp+ksfipezY1V5X2ZI5XS1/5/j7l/12A/h/QXlOeoSGUYdWgXBtJXEpfXKFiJSKg5V2a1yRkIt+RJeWk6KJmZhogKmbniUFrq8FE7CvsrOxD7a3Drm1s72wv7QPA8TFAxPGxcjJx8PMvLi2wa7TugDQu9LRvtvAzsnL4N/G4cbY19rZ3Ore7MLu1N3v6OsAzM0O9+XK48Xn/+notRM4D2C9c/r6Edu3UOEAgwMhFgwoMR48awnzMWOIzyfeM4ogD4aMOHJivYwexWlUmZJcPXcaXhKMORDmBZkyWa5suE8DuAQAIfkECQoAAAAsAAAAAIAADwAAA/8ItAv+rD0XyaTxqnyr9h03gZNgmtqJXqqwka8YM2NlQXYN2ze254/WyiF0BYU8nSyJ+zmXQB8UViwJrS2mlNacerlbSbg3E5fJ1WMLq9KeleB3N+6uR+XEq1rFPtmfdHd/X2aDcWl5a3t+go2AhY6EZIZmiACWRZSTkYGPm55wlXqJfIsmBaipBROqqaytqw+wsQ6zr623qrmusrATA8DBA7/CwMTFtr24yrrMvLW+zqi709K0AMkOxcYP28Pd29nY0dDL5c3nz+Pm6+jt6uLex8LzweL35O/V6fv61/js4m2rx01buHwA3SWEh7BhwHzywBUjOGBhP4v/HCrUyJAbXUSDEyXSY5dOA8l3Jt2VvHCypUoAIetpmJgAACH5BAkKAAAALAAAAACAAA8AAAP/CLQL/qw9F8mk8ap8q/YdN4Gj+AgoqqVqJWHkFrsW5Jbzbee8yaaTH4qGMxF3Rh0s2WMUnUioQygICo9LqYzJ1WK3XiX4Na5Nhdbfdy1mN8nuLlxMTbPi4be5/Jzr+3tfdSdXbYZ/UX5ygYeLdkCEao15jomMiFmKlFqDZz8FoKEFE6KhpKWjD6ipDqunpa+isaaqqLOgEwO6uwO5vLqutbDCssS0rbbGuMqsAMHIw9DFDr+6vr/PzsnSx9rR3tPg3dnk2+LL1NXXvOXf7eHv4+bx6OfN1b0P+PTN/Lf98wK6ExgO37pd/pj9W6iwIbd6CdP9OmjtGzcNFsVhDHfxDELGjxw1Xpg4kheABAAh+QQJCgAAACwAAAAAgAAPAAAD/wi0C/6sPRfJpPGqfKv2HTeBowiZjqCqG9malYS5sXXScYnvcP6swJqux2MMjTeiEjlbyl5MAHAlTEarzasv+8RCu9uvjTuWTgXedFhdBLfLbGf5jF7b30e3PA+/739ncVp4VnqDf2R8ioBTgoaPfYSJhZGIYhN0BZqbBROcm56fnQ+iow6loZ+pnKugpKKtmrGmAAO2twOor6q7rL2up7C/ssO0usG8yL7KwLW4tscA0dPCzMTWxtXS2tTJ297P0Nzj3t3L3+fmzerX6M3hueTp8uv07ezZ5fa08Piz/8UAYhPo7t6+CfDcafDGbOG5hhcYKoz4cGIrh80cPAOQAAAh+QQJCgAAACwAAAAAgAAPAAAD5wi0C/6sPRfJpPGqfKv2HTeBowiZGLORq1lJqfuW7Gud9YzLud3zQNVOGCO2jDZaEHZk+nRFJ7R5i1apSuQ0OZT+nleuNetdhrfob1kLXrvPariZLGfPuz66Hr8f8/9+gVh4YoOChYhpd4eKdgwFkJEFE5KRlJWTD5iZDpuXlZ+SoZaamKOQp5wAm56loK6isKSdprKotqqttK+7sb2zq6y8wcO6xL7HwMbLtb+3zrnNycKp1bjW0NjT0cXSzMLK3uLd5Mjf5uPo5eDa5+Hrz9vt6e/qosO/GvjJ+sj5F/sC+uMHcCCoBAA7AAAAAAAAAAAA" /></div>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo 'If you run a single store you may remove the `_to_store` table joins/filtering.'; ?>"><?php echo 'Large Product Catalog'; ?></span></label>
					<div class="col-sm-10">
						<div class="onoffswitch" id="container_z_increase_page_speed_qs_large_catalog">
							<input type="checkbox" name="z_increase_page_speed_qs_large_catalog" class="onoffswitch-checkbox" id="z_increase_page_speed_qs_large_catalog" onclick="feature_toggle(this);" data-vqmod="z_increase_page_speed_qs_large_catalog" <?php echo file_exists($vqmod_path . 'z_increase_page_speed_qs_large_catalog.xml') ? "checked" : ""; ?>>
							<label class="onoffswitch-label" for="z_increase_page_speed_qs_large_catalog">
								<span class="onoffswitch-inner"></span>
								<span class="onoffswitch-switch"></span>
							</label>
						</div>
						<div id="loading_z_increase_page_speed_qs_large_catalog" style="display:none;"><img src="data:image/gif;base64,R0lGODlhgAAPAPIAAP///wAAAMbGxrKyskJCQgAAAAAAAAAAACH/C05FVFNDQVBFMi4wAwEAAAAh/hpDcmVhdGVkIHdpdGggYWpheGxvYWQuaW5mbwAh+QQJCgAAACwAAAAAgAAPAAAD5wiyC/6sPRfFpPGqfKv2HTeBowiZGLORq1lJqfuW7Gud9YzLud3zQNVOGCO2jDZaEHZk+nRFJ7R5i1apSuQ0OZT+nleuNetdhrfob1kLXrvPariZLGfPuz66Hr8f8/9+gVh4YoOChYhpd4eKdgwDkJEDE5KRlJWTD5iZDpuXlZ+SoZaamKOQp5wAm56loK6isKSdprKotqqttK+7sb2zq6y8wcO6xL7HwMbLtb+3zrnNycKp1bjW0NjT0cXSzMLK3uLd5Mjf5uPo5eDa5+Hrz9vt6e/qosO/GvjJ+sj5F/sC+uMHcCCoBAAh+QQJCgAAACwAAAAAgAAPAAAD/wi0C/4ixgeloM5erDHonOWBFFlJoxiiTFtqWwa/Jhx/86nKdc7vuJ6mxaABbUaUTvljBo++pxO5nFQFxMY1aW12pV+q9yYGk6NlW5bAPQuh7yl6Hg/TLeu2fssf7/19Zn9meYFpd3J1bnCMiY0RhYCSgoaIdoqDhxoFnJ0FFAOhogOgo6GlpqijqqKspw+mrw6xpLCxrrWzsZ6duL62qcCrwq3EsgC0v7rBy8PNorycysi3xrnUzNjO2sXPx8nW07TRn+Hm3tfg6OLV6+fc37vR7Nnq8Ont9/Tb9v3yvPu66Xvnr16+gvwO3gKIIdszDw65Qdz2sCFFiRYFVmQFIAEBACH5BAkKAAAALAAAAACAAA8AAAP/CLQL/qw9J2qd1AoM9MYeF4KaWJKWmaJXxEyulI3zWa/39Xh6/vkT3q/DC/JiBFjMSCM2hUybUwrdFa3Pqw+pdEVxU3AViKVqwz30cKzmQpZl8ZlNn9uzeLPH7eCrv2l1eXKDgXd6Gn5+goiEjYaFa4eOFopwZJh/cZCPkpGAnhoFo6QFE6WkEwOrrAOqrauvsLKttKy2sQ+wuQ67rrq7uAOoo6fEwsjAs8q1zLfOvAC+yb3B0MPHD8Sm19TS1tXL4c3jz+XR093X28ao3unnv/Hv4N/i9uT45vqr7NrZ89QFHMhPXkF69+AV9OeA4UGBDwkqnFiPYsJg7jBktMXhD165jvk+YvCoD+Q+kRwTAAAh+QQJCgAAACwAAAAAgAAPAAAD/wi0C/6sPRfJdCLnC/S+nsCFo1dq5zeRoFlJ1Du91hOq3b3qNo/5OdZPGDT1QrSZDLIcGp2o47MYheJuImmVer0lmRVlWNslYndm4Jmctba5gm9sPI+gp2v3fZuH78t4Xk0Kg3J+bH9vfYtqjWlIhZF0h3qIlpWYlJpYhp2DjI+BoXyOoqYaBamqBROrqq2urA8DtLUDE7a1uLm3s7y7ucC2wrq+wca2sbIOyrCuxLTQvQ680wDV0tnIxdS/27TND+HMsdrdx+fD39bY6+bX3um14wD09O3y0e77+ezx8OgAqutnr5w4g/3e4RPIjaG+hPwc+stV8NlBixAzSlT4bxqhx46/MF5MxUGkPA4BT15IyRDlwG0uG55MAAAh+QQJCgAAACwAAAAAgAAPAAAD/wi0C/6sPRfJpPECwbnu3gUKH1h2ZziNKVlJWDW9FvSuI/nkusPjrF0OaBIGfTna7GaTNTPGIvK4GUZRV1WV+ssKlE/G0hmDTqVbdPeMZWvX6XacAy6LwzAF092b9+GAVnxEcjx1emSIZop3g16Eb4J+kH+ShnuMeYeHgVyWn56hakmYm6WYnaOihaCqrh0FsbIFE7Oytba0D7m6DgO/wAMTwcDDxMIPx8i+x8bEzsHQwLy4ttWz17fJzdvP3dHfxeG/0uTjywDK1Lu52bHuvenczN704Pbi+Ob66MrlA+scBAQwcKC/c/8SIlzI71/BduysRcTGUF49i/cw5tO4jytjv3keH0oUCJHkSI8KG1Y8qLIlypMm312ASZCiNA0X8eHMqPNCTo07iyUAACH5BAkKAAAALAAAAACAAA8AAAP/CLQL/qw9F8mk8ap8hffaB3ZiWJKfmaJgJWHV5FqQK9uPuDr6yPeTniAIzBV/utktVmPCOE8GUTc9Ia0AYXWXPXaTuOhr4yRDzVIjVY3VsrnuK7ynbJ7rYlp+6/u2vXF+c2tyHnhoY4eKYYJ9gY+AkYSNAotllneMkJObf5ySIphpe3ajiHqUfENvjqCDniIFsrMFE7Sztre1D7q7Dr0TA8LDA8HEwsbHycTLw83ID8fCwLy6ubfXtNm40dLPxd3K4czjzuXQDtID1L/W1djv2vHc6d7n4PXi+eT75v3oANSxAzCwoLt28P7hC2hP4beH974ZTEjwYEWKA9VBdBixLSNHhRPlIRR5kWTGhgz1peS30l9LgBojUhzpa56GmSVr9tOgcueFni15styZAAAh+QQJCgAAACwAAAAAgAAPAAAD/wi0C/6sPRfJpPGqfKsWIPiFwhia4kWWKrl5UGXFMFa/nJ0Da+r0rF9vAiQOH0DZTMeYKJ0y6O2JPApXRmxVe3VtSVSmRLzENWm7MM+65ra93dNXHgep71H0mSzdFec+b3SCgX91AnhTeXx6Y2aOhoRBkllwlICIi49liWmaapGhbKJuSZ+niqmeN6SWrYOvIAWztAUTtbS3uLYPu7wOvrq4EwPFxgPEx8XJyszHzsbQxcG9u8K117nVw9vYD8rL3+DSyOLN5s/oxtTA1t3a7dzx3vPwAODlDvjk/Orh+uDYARBI0F29WdkQ+st3b9zCfgDPRTxWUN5AgxctVqTXUDNix3QToz0cGXIaxo32UCo8+OujyJIM95F0+Y8mMov1NODMuPKdTo4hNXgMemGoS6HPEgAAIfkECQoAAAAsAAAAAIAADwAAA/8ItAv+rD0XyaTxqnyr9pcgitpIhmaZouMGYq/LwbPMTJVE34/Z9j7BJCgE+obBnAWSwzWZMaUz+nQQkUfjyhrEmqTQGnins5XH5iU3u94Crtpfe4SuV9NT8R0Nn5/8RYBedHuFVId6iDyCcX9vXY2Bjz52imeGiZmLk259nHKfjkSVmpeWanhhm56skIyABbGyBROzsrW2tA+5ug68uLbAsxMDxcYDxMfFycrMx87Gv7u5wrfTwdfD2da+1A/Ky9/g0OEO4MjiytLd2Oza7twA6/Le8LHk6Obj6c/8xvjzAtaj147gO4Px5p3Dx9BfOQDnBBaUeJBiwoELHeaDuE8uXzONFu9tE2mvF0KSJ00q7Mjxo8d+L/9pRKihILyaB29esEnzgkt/Gn7GDPosAQAh+QQJCgAAACwAAAAAgAAPAAAD/wi0C/6sPRfJpPGqfKv2HTcJJKmV5oUKJ7qBGPyKMzNVUkzjFoSPK9YjKHQQgSve7eeTKZs7ps4GpRqDSNcQu01Kazlwbxp+ksfipezY1V5X2ZI5XS1/5/j7l/12A/h/QXlOeoSGUYdWgXBtJXEpfXKFiJSKg5V2a1yRkIt+RJeWk6KJmZhogKmbniUFrq8FE7CvsrOxD7a3Drm1s72wv7QPA8TFAxPGxcjJx8PMvLi2wa7TugDQu9LRvtvAzsnL4N/G4cbY19rZ3Ore7MLu1N3v6OsAzM0O9+XK48Xn/+notRM4D2C9c/r6Edu3UOEAgwMhFgwoMR48awnzMWOIzyfeM4ogD4aMOHJivYwexWlUmZJcPXcaXhKMORDmBZkyWa5suE8DuAQAIfkECQoAAAAsAAAAAIAADwAAA/8ItAv+rD0XyaTxqnyr9h03gZNgmtqJXqqwka8YM2NlQXYN2ze254/WyiF0BYU8nSyJ+zmXQB8UViwJrS2mlNacerlbSbg3E5fJ1WMLq9KeleB3N+6uR+XEq1rFPtmfdHd/X2aDcWl5a3t+go2AhY6EZIZmiACWRZSTkYGPm55wlXqJfIsmBaipBROqqaytqw+wsQ6zr623qrmusrATA8DBA7/CwMTFtr24yrrMvLW+zqi709K0AMkOxcYP28Pd29nY0dDL5c3nz+Pm6+jt6uLex8LzweL35O/V6fv61/js4m2rx01buHwA3SWEh7BhwHzywBUjOGBhP4v/HCrUyJAbXUSDEyXSY5dOA8l3Jt2VvHCypUoAIetpmJgAACH5BAkKAAAALAAAAACAAA8AAAP/CLQL/qw9F8mk8ap8q/YdN4Gj+AgoqqVqJWHkFrsW5Jbzbee8yaaTH4qGMxF3Rh0s2WMUnUioQygICo9LqYzJ1WK3XiX4Na5Nhdbfdy1mN8nuLlxMTbPi4be5/Jzr+3tfdSdXbYZ/UX5ygYeLdkCEao15jomMiFmKlFqDZz8FoKEFE6KhpKWjD6ipDqunpa+isaaqqLOgEwO6uwO5vLqutbDCssS0rbbGuMqsAMHIw9DFDr+6vr/PzsnSx9rR3tPg3dnk2+LL1NXXvOXf7eHv4+bx6OfN1b0P+PTN/Lf98wK6ExgO37pd/pj9W6iwIbd6CdP9OmjtGzcNFsVhDHfxDELGjxw1Xpg4kheABAAh+QQJCgAAACwAAAAAgAAPAAAD/wi0C/6sPRfJpPGqfKv2HTeBowiZjqCqG9malYS5sXXScYnvcP6swJqux2MMjTeiEjlbyl5MAHAlTEarzasv+8RCu9uvjTuWTgXedFhdBLfLbGf5jF7b30e3PA+/739ncVp4VnqDf2R8ioBTgoaPfYSJhZGIYhN0BZqbBROcm56fnQ+iow6loZ+pnKugpKKtmrGmAAO2twOor6q7rL2up7C/ssO0usG8yL7KwLW4tscA0dPCzMTWxtXS2tTJ297P0Nzj3t3L3+fmzerX6M3hueTp8uv07ezZ5fa08Piz/8UAYhPo7t6+CfDcafDGbOG5hhcYKoz4cGIrh80cPAOQAAAh+QQJCgAAACwAAAAAgAAPAAAD5wi0C/6sPRfJpPGqfKv2HTeBowiZGLORq1lJqfuW7Gud9YzLud3zQNVOGCO2jDZaEHZk+nRFJ7R5i1apSuQ0OZT+nleuNetdhrfob1kLXrvPariZLGfPuz66Hr8f8/9+gVh4YoOChYhpd4eKdgwFkJEFE5KRlJWTD5iZDpuXlZ+SoZaamKOQp5wAm56loK6isKSdprKotqqttK+7sb2zq6y8wcO6xL7HwMbLtb+3zrnNycKp1bjW0NjT0cXSzMLK3uLd5Mjf5uPo5eDa5+Hrz9vt6e/qosO/GvjJ+sj5F/sC+uMHcCCoBAA7AAAAAAAAAAAA" /></div>
					</div>
				</div>

				
				<h4><?php echo $heading_content_delivery; ?></h4>
				<div class="form-group">
					<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_cdn_status; ?>"><?php echo $entry_cdn_status; ?></span></label>
					<div class="col-sm-10">
						<label class="radio-inline"><input type="radio" name="config_cdn_status" value="1" <?php echo ($config_cdn_status) ? 'checked="checked"' : ''; ?> /><?php echo $text_yes; ?></label>
						<label class="radio-inline"><input type="radio" name="config_cdn_status" value="0" <?php echo (!$config_cdn_status) ? 'checked="checked"' : ''; ?> /><?php echo $text_no; ?></label>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_cdn_http; ?>"><?php echo $entry_cdn_http; ?></span></label>
					<div class="col-sm-10">
						<input type="text" name="config_cdn_http" size="80" value="<?php echo $config_cdn_http; ?>" />
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_cdn_https; ?>"><?php echo $entry_cdn_https; ?></span></label>
					<div class="col-sm-10">
						<input type="text" name="config_cdn_https" size="80" value="<?php echo $config_cdn_https; ?>" />
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_cdn_images; ?>"><?php echo $entry_cdn_images; ?></span></label>
					<div class="col-sm-10">
						<label class="radio-inline"><input type="radio" name="config_cdn_images" value="1" <?php echo ($config_cdn_images) ? 'checked="checked"' : ''; ?> /><?php echo $text_yes; ?></label>
						<label class="radio-inline"><input type="radio" name="config_cdn_images" value="0" <?php echo (!$config_cdn_images) ? 'checked="checked"' : ''; ?> /><?php echo $text_no; ?></label>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_cdn_css; ?>"><?php echo $entry_cdn_css; ?></span></label>
					<div class="col-sm-10">
						<label class="radio-inline"><input type="radio" name="config_cdn_css" value="1" <?php echo ($config_cdn_css) ? 'checked="checked"' : ''; ?> /><?php echo $text_yes; ?></label>
						<label class="radio-inline"><input type="radio" name="config_cdn_css" value="0" <?php echo (!$config_cdn_css) ? 'checked="checked"' : ''; ?> /><?php echo $text_no; ?></label>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_cdn_js; ?>"><?php echo $entry_cdn_js; ?></span></label>
					<div class="col-sm-10">
						<label class="radio-inline"><input type="radio" name="config_cdn_js" value="1" <?php echo ($config_cdn_js) ? 'checked="checked"' : ''; ?> /><?php echo $text_yes; ?></label>
						<label class="radio-inline"><input type="radio" name="config_cdn_js" value="0" <?php echo (!$config_cdn_js) ? 'checked="checked"' : ''; ?> /><?php echo $text_no; ?></label>
					</div>
				</div>
				
				
				<h4><?php echo $heading_block_level_caching ?></h4>
				<div class="form-group">
					<label class="col-sm-2 control-label" for="input-category"><span data-toggle="tooltip" title="<?php echo $help_cached_routes; ?>"><?php echo $entry_cached_routes; ?></span></label>
					<div class="col-sm-10">
						<div id="cached-routes" class="well well-sm" style="height: 150px; overflow: auto;">
							<?php foreach ($config_cached_routes as $config_cached_route) { ?>
							<div id="config-cached-routes"><i class="fa fa-minus-circle"></i> <?php echo $config_cached_route; ?>
								<input type="hidden" name="config_cached_routes[]" value="<?php echo $config_cached_route; ?>" />
							</div>
							<?php } ?>
						</div>
						<label>Add a Route:&nbsp;&nbsp;&nbsp;&nbsp;</label><input type="text" name="new-cached-route" value="" />
					</div>
					<script type="text/javascript"><!--
					$('input[name=\'new-cached-route\']').keypress(function(e) {
						if (e.which == 13) {
							$('#cached-routes').append('<div id="config-cached-routes' + '22' + '"><i class="fa fa-minus-circle"></i> ' + $('input[name=\'new-cached-route\']').val() + '<input type="hidden" name="config_cached_routes[]" value="' + $('input[name=\'new-cached-route\']').val() + '" /></div>');
							$('input[name=\'new-cached-route\']').val('');
							return false;
						}
					});
					$('#cached-routes').delegate('.fa-minus-circle', 'click', function() {
						$(this).parent().remove();
					});					
					//--></script>
				</div>

				<h4><?php echo $heading_speed_analyzer ?></h4>
				<div class="form-group">
					<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_firebug_analyzer; ?>"><?php echo $entry_firebug_analyzer; ?></span></label>
					<div class="col-sm-10">
						<div class="onoffswitch" id="container_z_increase_page_speed_image_dimensions_banner">
							<input type="checkbox" name="config_firebug_analyzer" class="onoffswitch-checkbox" id="config_firebug_analyzer" onclick="feature_toggle(this);" data-vqmod="z_increase_page_speed_performance_analyzer" <?php echo file_exists($vqmod_path . 'z_increase_page_speed_performance_analyzer.xml') ? "checked" : ""; ?>>
							<label class="onoffswitch-label" for="config_firebug_analyzer">
								<span class="onoffswitch-inner"></span>
								<span class="onoffswitch-switch"></span>
							</label>
						</div>
						<div id="loading_config_firebug_analyzer" style="display:none;"><img src="data:image/gif;base64,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" /></div>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_firebug_queries; ?>"><?php echo $entry_firebug_queries; ?></span></label>
					<div class="col-sm-10">
						<label class="radio-inline"><input type="radio" name="config_firebug_queries" value="1" <?php echo ($config_firebug_queries) ? 'checked="checked"' : ''; ?> /><?php echo $text_yes; ?></label>
						<label class="radio-inline"><input type="radio" name="config_firebug_queries" value="0" <?php echo (!$config_firebug_queries) ? 'checked="checked"' : ''; ?> /><?php echo $text_no; ?></label>
					</div>
				</div>
			</div>			
            <div class="tab-pane" id="tab-server">
              <div class="form-group">
                <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_secure; ?>"><?php echo $entry_secure; ?></span></label>
                <div class="col-sm-10">
                  <label class="radio-inline">
                    <?php if ($config_secure) { ?>
                    <input type="radio" name="config_secure" value="1" checked="checked" />
                    <?php echo $text_yes; ?>
                    <?php } else { ?>
                    <input type="radio" name="config_secure" value="1" />
                    <?php echo $text_yes; ?>
                    <?php } ?>
                  </label>
                  <label class="radio-inline">
                    <?php if (!$config_secure) { ?>
                    <input type="radio" name="config_secure" value="0" checked="checked" />
                    <?php echo $text_no; ?>
                    <?php } else { ?>
                    <input type="radio" name="config_secure" value="0" />
                    <?php echo $text_no; ?>
                    <?php } ?>
                  </label>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_shared; ?>"><?php echo $entry_shared; ?></span></label>
                <div class="col-sm-10">
                  <label class="radio-inline">
                    <?php if ($config_shared) { ?>
                    <input type="radio" name="config_shared" value="1" checked="checked" />
                    <?php echo $text_yes; ?>
                    <?php } else { ?>
                    <input type="radio" name="config_shared" value="1" />
                    <?php echo $text_yes; ?>
                    <?php } ?>
                  </label>
                  <label class="radio-inline">
                    <?php if (!$config_shared) { ?>
                    <input type="radio" name="config_shared" value="0" checked="checked" />
                    <?php echo $text_no; ?>
                    <?php } else { ?>
                    <input type="radio" name="config_shared" value="0" />
                    <?php echo $text_no; ?>
                    <?php } ?>
                  </label>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-robots"><span data-toggle="tooltip" title="<?php echo $help_robots; ?>"><?php echo $entry_robots; ?></span></label>
                <div class="col-sm-10">
                  <textarea name="config_robots" rows="5" placeholder="<?php echo $entry_robots; ?>" id="input-robots" class="form-control"><?php echo $config_robots; ?></textarea>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_seo_url; ?>"><?php echo $entry_seo_url; ?></span></label>
                <div class="col-sm-10">
                  <label class="radio-inline">
                    <?php if ($config_seo_url) { ?>
                    <input type="radio" name="config_seo_url" value="1" checked="checked" />
                    <?php echo $text_yes; ?>
                    <?php } else { ?>
                    <input type="radio" name="config_seo_url" value="1" />
                    <?php echo $text_yes; ?>
                    <?php } ?>
                  </label>
                  <label class="radio-inline">
                    <?php if (!$config_seo_url) { ?>
                    <input type="radio" name="config_seo_url" value="0" checked="checked" />
                    <?php echo $text_no; ?>
                    <?php } else { ?>
                    <input type="radio" name="config_seo_url" value="0" />
                    <?php echo $text_no; ?>
                    <?php } ?>
                  </label>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-file-max-size"><span data-toggle="tooltip" title="<?php echo $help_file_max_size; ?>"><?php echo $entry_file_max_size; ?></span></label>
                <div class="col-sm-10">
                  <input type="text" name="config_file_max_size" value="<?php echo $config_file_max_size; ?>" placeholder="<?php echo $entry_file_max_size; ?>" id="input-file-max-size" class="form-control" />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-file-ext-allowed"><span data-toggle="tooltip" title="<?php echo $help_file_ext_allowed; ?>"><?php echo $entry_file_ext_allowed; ?></span></label>
                <div class="col-sm-10">
                  <textarea name="config_file_ext_allowed" rows="5" placeholder="<?php echo $entry_file_ext_allowed; ?>" id="input-file-ext-allowed" class="form-control"><?php echo $config_file_ext_allowed; ?></textarea>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-file-mime-allowed"><span data-toggle="tooltip" title="<?php echo $help_file_mime_allowed; ?>"><?php echo $entry_file_mime_allowed; ?></span></label>
                <div class="col-sm-10">
                  <textarea name="config_file_mime_allowed" cols="60" rows="5" placeholder="<?php echo $entry_file_mime_allowed; ?>" id="input-file-mime-allowed" class="form-control"><?php echo $config_file_mime_allowed; ?></textarea>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_maintenance; ?>"><?php echo $entry_maintenance; ?></span></label>
                <div class="col-sm-10">
                  <label class="radio-inline">
                    <?php if ($config_maintenance) { ?>
                    <input type="radio" name="config_maintenance" value="1" checked="checked" />
                    <?php echo $text_yes; ?>
                    <?php } else { ?>
                    <input type="radio" name="config_maintenance" value="1" />
                    <?php echo $text_yes; ?>
                    <?php } ?>
                  </label>
                  <label class="radio-inline">
                    <?php if (!$config_maintenance) { ?>
                    <input type="radio" name="config_maintenance" value="0" checked="checked" />
                    <?php echo $text_no; ?>
                    <?php } else { ?>
                    <input type="radio" name="config_maintenance" value="0" />
                    <?php echo $text_no; ?>
                    <?php } ?>
                  </label>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_password; ?>"><?php echo $entry_password; ?></span></label>
                <div class="col-sm-10">
                  <label class="radio-inline">
                    <?php if ($config_password) { ?>
                    <input type="radio" name="config_password" value="1" checked="checked" />
                    <?php echo $text_yes; ?>
                    <?php } else { ?>
                    <input type="radio" name="config_password" value="1" />
                    <?php echo $text_yes; ?>
                    <?php } ?>
                  </label>
                  <label class="radio-inline">
                    <?php if (!$config_password) { ?>
                    <input type="radio" name="config_password" value="0" checked="checked" />
                    <?php echo $text_no; ?>
                    <?php } else { ?>
                    <input type="radio" name="config_password" value="0" />
                    <?php echo $text_no; ?>
                    <?php } ?>
                  </label>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-encryption"><span data-toggle="tooltip" title="<?php echo $help_encryption; ?>"><?php echo $entry_encryption; ?></span></label>
                <div class="col-sm-10">
                  <input type="text" name="config_encryption" value="<?php echo $config_encryption; ?>" placeholder="<?php echo $entry_encryption; ?>" id="input-encryption" class="form-control" />
                  <?php if ($error_encryption) { ?>
                  <div class="text-danger"><?php echo $error_encryption; ?></div>
                  <?php } ?>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-compression"><span data-toggle="tooltip" title="<?php echo $help_compression; ?>"><?php echo $entry_compression; ?></span></label>
                <div class="col-sm-10">
                  <input type="text" name="config_compression" value="<?php echo $config_compression; ?>" placeholder="<?php echo $entry_compression; ?>" id="input-compression" class="form-control" />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $entry_error_display; ?></label>
                <div class="col-sm-10">
                  <label class="radio-inline">
                    <?php if ($config_error_display) { ?>
                    <input type="radio" name="config_error_display" value="1" checked="checked" />
                    <?php echo $text_yes; ?>
                    <?php } else { ?>
                    <input type="radio" name="config_error_display" value="1" />
                    <?php echo $text_yes; ?>
                    <?php } ?>
                  </label>
                  <label class="radio-inline">
                    <?php if (!$config_error_display) { ?>
                    <input type="radio" name="config_error_display" value="0" checked="checked" />
                    <?php echo $text_no; ?>
                    <?php } else { ?>
                    <input type="radio" name="config_error_display" value="0" />
                    <?php echo $text_no; ?>
                    <?php } ?>
                  </label>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $entry_error_log; ?></label>
                <div class="col-sm-10">
                  <label class="radio-inline">
                    <?php if ($config_error_log) { ?>
                    <input type="radio" name="config_error_log" value="1" checked="checked" />
                    <?php echo $text_yes; ?>
                    <?php } else { ?>
                    <input type="radio" name="config_error_log" value="1" />
                    <?php echo $text_yes; ?>
                    <?php } ?>
                  </label>
                  <label class="radio-inline">
                    <?php if (!$config_error_log) { ?>
                    <input type="radio" name="config_error_log" value="0" checked="checked" />
                    <?php echo $text_no; ?>
                    <?php } else { ?>
                    <input type="radio" name="config_error_log" value="0" />
                    <?php echo $text_no; ?>
                    <?php } ?>
                  </label>
                </div>
              </div>
              <div class="form-group required">
                <label class="col-sm-2 control-label" for="input-error-filename"><?php echo $entry_error_filename; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="config_error_filename" value="<?php echo $config_error_filename; ?>" placeholder="<?php echo $entry_error_filename; ?>" id="input-error-filename" class="form-control" />
                  <?php if ($error_error_filename) { ?>
                  <div class="text-danger"><?php echo $error_error_filename; ?></div>
                  <?php } ?>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-google-analytics"><span data-toggle="tooltip" data-html="true" data-trigger="click" title="<?php echo htmlspecialchars($help_google_analytics); ?>"><?php echo $entry_google_analytics; ?></span></label>
                <div class="col-sm-10">
                  <textarea name="config_google_analytics" rows="5" placeholder="<?php echo $entry_google_analytics; ?>" id="input-google-analytics" class="form-control"><?php echo $config_google_analytics; ?></textarea>
                </div>
              </div>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
  <script type="text/javascript"><!--
$('select[name=\'config_template\']').on('change', function() {
	$.ajax({
		url: 'index.php?route=setting/setting/template&token=<?php echo $token; ?>&template=' + encodeURIComponent(this.value),
		dataType: 'html',
		beforeSend: function() {
			$('select[name=\'country_id\']').after(' <i class="fa fa-circle-o-notch fa-spin"></i>');
		},
		complete: function() {
			$('.fa-spin').remove();
		},
		success: function(html) {
      $('.fa-spin').remove();

			$('#template').attr('src', html);
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
});

$('select[name=\'config_template\']').trigger('change');
//--></script> 
  <script type="text/javascript"><!--
$('select[name=\'config_country_id\']').on('change', function() {
	$.ajax({
		url: 'index.php?route=setting/setting/country&token=<?php echo $token; ?>&country_id=' + this.value,
		dataType: 'json',
		beforeSend: function() {
			$('select[name=\'config_country_id\']').after(' <i class="fa fa-circle-o-notch fa-spin"></i>');
		},
		complete: function() {
			$('.fa-spin').remove();
		},
		success: function(json) {
      $('.fa-spin').remove();

			html = '<option value=""><?php echo $text_select; ?></option>';

			if (json['zone'] != '') {
				for (i = 0; i < json['zone'].length; i++) {
          			html += '<option value="' + json['zone'][i]['zone_id'] + '"';

					if (json['zone'][i]['zone_id'] == '<?php echo $config_zone_id; ?>') {
            			html += ' selected="selected"';
					}

					html += '>' + json['zone'][i]['name'] + '</option>';
				}
			} else {
				html += '<option value="0" selected="selected"><?php echo $text_none; ?></option>';
			}

			$('select[name=\'config_zone_id\']').html(html);
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
});

$('select[name=\'config_country_id\']').trigger('change');
//--></script></div>
<?php echo $footer; ?>