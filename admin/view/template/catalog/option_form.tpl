<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-option" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
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
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_form; ?></h3>
      </div>
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-option" class="form-horizontal">
          <div class="form-group required">
            <label class="col-sm-2 control-label"><?php echo $entry_name; ?></label>
            <div class="col-sm-10">
              <?php foreach ($languages as $language) { ?>
              <div class="input-group"><span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
                <input type="text" name="option_description[<?php echo $language['language_id']; ?>][name]" value="<?php echo isset($option_description[$language['language_id']]) ? $option_description[$language['language_id']]['name'] : ''; ?>" placeholder="<?php echo $entry_name; ?>" class="form-control" />
              </div>
              <?php if (isset($error_name[$language['language_id']])) { ?>
              <div class="text-danger"><?php echo $error_name[$language['language_id']]; ?></div>
              <?php } ?>
              <?php } ?>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-type"><?php echo $entry_type; ?></label>
            <div class="col-sm-10">
              <select name="type" id="input-type" class="form-control">
                <optgroup label="<?php echo $text_choose; ?>">
		       <?php if ($type == 'size_option') { ?>
                <option value="size_option" selected="selected"><?php echo $text_size_option; ?></option>
                <?php } else { ?>
                <option value="size_option"><?php echo $text_size_option; ?></option>
                <?php } ?>				
                <?php if ($type == 'select') { ?>
                <option value="select" selected="selected"><?php echo $text_select; ?></option>
                <?php } else { ?>
                <option value="select"><?php echo $text_select; ?></option>
                <?php } ?>
                <?php if ($type == 'radio') { ?>
                <option value="radio" selected="selected"><?php echo $text_radio; ?></option>
                <?php } else { ?>
                <option value="radio"><?php echo $text_radio; ?></option>
                <?php } ?>
                <?php if ($type == 'checkbox') { ?>
                <option value="checkbox" selected="selected"><?php echo $text_checkbox; ?></option>
                <?php } else { ?>
                <option value="checkbox"><?php echo $text_checkbox; ?></option>
                <?php } ?>
                <?php if ($type == 'image') { ?>
                <option value="image" selected="selected"><?php echo $text_image; ?></option>
                <?php } else { ?>
                <option value="image"><?php echo $text_image; ?></option>
                <?php } ?>
                </optgroup>
                <optgroup label="<?php echo $text_input; ?>">
                <?php if ($type == 'text') { ?>
                <option value="text" selected="selected"><?php echo $text_text; ?></option>
                <?php } else { ?>
                <option value="text"><?php echo $text_text; ?></option>
                <?php } ?>
                <?php if ($type == 'textarea') { ?>
                <option value="textarea" selected="selected"><?php echo $text_textarea; ?></option>
                <?php } else { ?>
                <option value="textarea"><?php echo $text_textarea; ?></option>
                <?php } ?>
                </optgroup>
                <optgroup label="<?php echo $text_file; ?>">
                <?php if ($type == 'file') { ?>
                <option value="file" selected="selected"><?php echo $text_file; ?></option>
                <?php } else { ?>
                <option value="file"><?php echo $text_file; ?></option>
                <?php } ?>
                </optgroup>
                <optgroup label="<?php echo $text_date; ?>">
                <?php if ($type == 'date') { ?>
                <option value="date" selected="selected"><?php echo $text_date; ?></option>
                <?php } else { ?>
                <option value="date"><?php echo $text_date; ?></option>
                <?php } ?>
                <?php if ($type == 'time') { ?>
                <option value="time" selected="selected"><?php echo $text_time; ?></option>
                <?php } else { ?>
                <option value="time"><?php echo $text_time; ?></option>
                <?php } ?>
                <?php if ($type == 'datetime') { ?>
                <option value="datetime" selected="selected"><?php echo $text_datetime; ?></option>
                <?php } else { ?>
                <option value="datetime"><?php echo $text_datetime; ?></option>
                <?php } ?>
                </optgroup>
              </select>
            </div>
          </div>
          <div class="form-group">
		  <!---Custom Size Modification--->
		  <div id="size_option_tag">
		  <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $entry_image; ?></label>
            <div class="col-sm-10">
             <div class="input-group"> <a href="" id="thumb-image" data-toggle="image" class="img-thumbnail"><img src="<?php echo $thumb; ?>" data-placeholder="<?php echo $placeholder; ?>" /></a>
               <input type="hidden" name="option_image" value="<?php echo $option_image; ?>" id="input-image" />
            </div></div>
          </div>
		  <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $entry_discription; ?></label>
            <div class="col-sm-10">
              <?php foreach ($languages as $language) { ?>
              <div class="input-group"><span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
                <textarea name="option_description[<?php echo $language['language_id']; ?>][description]" class="form-control"><?php echo isset($option_description[$language['language_id']]['description']) ? $option_description[$language['language_id']]['description'] : ''; ?></textarea>
			  </div>
              <?php } ?>
            </div>
          </div>
		  	<div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $entry_remarks; ?></label>
            <div class="col-sm-10">
              <?php foreach ($languages as $language) { ?>
              <div class="input-group"><span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
                <textarea name="option_description[<?php echo $language['language_id']; ?>][remarks]" class="form-control" ><?php echo isset($option_description[$language['language_id']]['remarks']) ? $option_description[$language['language_id']]['remarks'] : ''; ?></textarea>
			  </div>
              <?php } ?>
            </div>
          </div>
		  </div>
		  <!---Custom Size Modification--->		  
            <label class="col-sm-2 control-label" for="input-sort-order"><?php echo $entry_sort_order; ?></label>
            <div class="col-sm-10">
              <input type="text" name="sort_order" value="<?php echo $sort_order; ?>" placeholder="<?php echo $entry_sort_order; ?>" id="input-sort-order" class="form-control" />
            </div>
          </div>
          <table id="option-value" class="table table-striped table-bordered table-hover">
            <thead>
              <tr>
                <td class="text-left required"><?php echo $entry_option_value; ?></td>
		        <td class="text-left imgs" ><?php echo $entry_image; ?></td>
				<td class="text-left custom" >Size options</td>
                <td class="text-right"><?php echo $entry_sort_order; ?></td>
                <td></td>
              </tr>
            </thead>
            <tbody>
              <?php $option_value_row = 0; ?>
              <?php foreach ($option_values as $option_value) { ?>
			  <?php if($option_value['value_type']=='Free_Customize') { ?>
			  <tr id="option-value-row<?php echo $option_value_row; ?>" class="free"> <?php } else { ?>
			  <tr id="option-value-row<?php echo $option_value_row; ?>">
			 <?php } ?>
                <td class="text-left"><input type="hidden" name="option_value[<?php echo $option_value_row; ?>][option_value_id]" value="<?php echo $option_value['option_value_id']; ?>" />
                  <?php foreach ($languages as $language) { ?>
                  <div class="input-group"><span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
                    <input type="text" name="option_value[<?php echo $option_value_row; ?>][option_value_description][<?php echo $language['language_id']; ?>][name]" value="<?php echo isset($option_value['option_value_description'][$language['language_id']]) ? $option_value['option_value_description'][$language['language_id']]['name'] : ''; ?>" placeholder="<?php echo $entry_option_value; ?>" class="form-control" />
                  </div>
                  <?php if (isset($error_option_value[$option_value_row][$language['language_id']])) { ?>
                  <div class="text-danger"><?php echo $error_option_value[$option_value_row][$language['language_id']]; ?></div>
                  <?php } ?>
                  <?php } ?></td>
                 <td class="text-left custom">
		            <input class="text-left custom-opt" type="hidden" name="option_value[<?php echo $option_value_row; ?>][value_type]" value="<?php echo $option_value['value_type']; ?>" />
                    <span class="text-left custom-opt"><label><?php echo $text_bust; ?></label>
					<input type="text" name="option_value[<?php echo $option_value_row; ?>][bust]"   value="<?php if(isset($option_value['bust'])) { echo $option_value['bust']; } ?>"></span>
                    <span class="text-left custom-opt"><label><?php echo $text_waist; ?></label>
					<input type="text" name="option_value[<?php echo $option_value_row; ?>][waist]"  value="<?php if(isset($option_value['waist'])) { echo $option_value['waist']; } ?>"></span>
                    <span class="text-left custom-opt"><label><?php echo $text_hip; ?></label>
					<input type="text" name="option_value[<?php echo $option_value_row; ?>][hip]"    value="<?php if(isset($option_value['hip'])) { echo $option_value['hip']; } ?>"></span>
                    <span class="text-left custom-opt"><label><?php echo $text_hollow; ?></label>
					<input type="text" name="option_value[<?php echo $option_value_row; ?>][hollow]" value="<?php if(isset($option_value['hollow'])) { echo $option_value['hollow']; } ?>"></span>
                    <span class="text-left custom-opt"><label><?php echo $text_height; ?></label>
					<input type="text" name="option_value[<?php echo $option_value_row; ?>][height]" value="<?php if(isset($option_value['height'])) { echo $option_value['height']; } ?>"></span>
				</td>
                <td class="text-left imgs"><a href="" id="thumb-image<?php echo $option_value_row; ?>" data-toggle="image" class="img-thumbnail"><img src="<?php echo $option_value['thumb']; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a><input type="hidden" name="option_value[<?php echo $option_value_row; ?>][image]" value="<?php echo $option_value['image']; ?>" id="input-image<?php echo $option_value_row; ?>" /></td>
                <td class="text-right"><input type="text" name="option_value[<?php echo $option_value_row; ?>][sort_order]" value="<?php echo $option_value['sort_order']; ?>" class="form-control" /></td>
                <td class="text-left"><button type="button" onclick="$('#option-value-row<?php echo $option_value_row; ?>').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>
              </tr>
              <?php $option_value_row++; ?>
              <?php } ?>
            </tbody>
            <tfoot>
              <tr>
                <td colspan="3"></td>
                <td class="text-left"><button type="button" onclick="addOptionValue();" data-toggle="tooltip" title="<?php echo $button_option_value_add; ?>" class="btn btn-primary"><i class="fa fa-plus-circle"></i></button></td>
              </tr>
            </tfoot>
          </table>
        </form>
      </div>
    </div>
  </div>
  <script type="text/javascript"><!--
  /*Comment the old jquery function
$('select[name=\'type\']').on('change', function() {
	if (this.value == 'select' || this.value == 'radio' || this.value == 'checkbox' || this.value == 'image') {
		$('#option-value').show();
	} else {
		$('#option-value').hide();
	}
});

$('select[name=\'type\']').trigger('change');

var option_value_row = <?php echo $option_value_row; ?>;

function addOptionValue() {
	html  = '<tr id="option-value-row' + option_value_row + '">';	
    html += '  <td class="text-left"><input type="hidden" name="option_value[' + option_value_row + '][option_value_id]" value="" />';
	<?php foreach ($languages as $language) { ?>
	html += '    <div class="input-group">';
	html += '      <span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></span><input type="text" name="option_value[' + option_value_row + '][option_value_description][<?php echo $language['language_id']; ?>][name]" value="" placeholder="<?php echo $entry_option_value; ?>" class="form-control" />';
    html += '    </div>';
	<?php } ?>
	html += '  </td>';
    html += '  <td class="text-left"><a href="" id="thumb-image' + option_value_row + '" data-toggle="image" class="img-thumbnail"><img src="<?php echo $placeholder; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a><input type="hidden" name="option_value[' + option_value_row + '][image]" value="" id="input-image' + option_value_row + '" /></td>';
	html += '  <td class="text-right"><input type="text" name="option_value[' + option_value_row + '][sort_order]" value="" placeholder="<?php echo $entry_sort_order; ?>" class="form-control" /></td>';
	html += '  <td class="text-left"><button type="button" onclick="$(\'#option-value-row' + option_value_row + '\').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>';
	html += '</tr>';	
	
	$('#option-value tbody').append(html);
	
	option_value_row++;
}
END Commenting the old jquery function */
$('select[name=\'type\']').on('change', function() {
    typ = this.value;
	if (this.value == 'select' || this.value == 'radio' || this.value == 'checkbox' || this.value == 'image') {
		$('.custom').hide();
		$('.free').remove();
		$('.imgs').show();	
		$('#size_option_tag').hide();
		$('#option-value').show();
	    }else if(this.value == 'size_option'){
	    if($('.free').length > 0){
	    	    var tp = '';
	    }else{
		    addfreecustom();
		}
	   	$('#option-value').show();
        $('#size_option_tag').show();			
	    $('.custom').show();
	    $('.imgs').hide();	
	
	} else {
		$('#option-value').hide();
        $('#size_option_tag').hide();			
		$('.custom').hide();
		$('.free').remove();
		$('.imgs').hide();	
	}
});

$('select[name=\'type\']').trigger('change');

var option_value_row = <?php echo $option_value_row; ?>;

function addfreecustom()
{
	html_free  = '<tr id="option-value-row' + option_value_row + '" class="free">';	
    html_free += '  <td class="text-left"><input type="hidden" name="option_value[' + option_value_row + '][option_value_id]" value="Free Customize" />';
	<?php foreach ($languages as $language) { ?>
	html_free += '    <div class="input-group">';
	html_free += '      <span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></span><input type="text" name="option_value[' + option_value_row + '][option_value_description][<?php echo $language['language_id']; ?>][name]" value="Free Customize" placeholder="<?php echo $entry_option_value; ?>" class="form-control" />';
    html_free += '    </div>';
	<?php } ?>
	html_free += '  </td>';		  
	html_free += '  <input type="hidden" name="option_value[' + option_value_row + '][value_type]" value="Free_Customize" /><td class="text-left">';
	html_free += '  <span class="text-left custom-opt"><label><?php echo $text_bust; ?></label>';
	html_free += '  <input type="text" name="option_value[' + option_value_row + '][bust]"   value=""></span>';
	html_free += '  <span class="text-left custom-opt"><label><?php echo $text_waist; ?></label>';
	html_free += '  <input type="text" name="option_value[' + option_value_row + '][waist]" value=""></span>';
	html_free += '  <span class="text-left custom-opt"><label><?php echo $text_hip; ?></label>';
	html_free += '  <input type="text" name="option_value[' + option_value_row + '][hip]"    value=""></span>';
	html_free += '  <span class="text-left custom-opt"><label><?php echo $text_hollow; ?></label>';
	html_free += '  <input type="text" name="option_value[' + option_value_row + '][hollow]" value=""></span>';
	html_free += '  <span class="text-left custom-opt"><label><?php echo $text_height; ?></label>';
	html_free += '  <input type="text" name="option_value[' + option_value_row + '][height]"  value=""></span>';
	html_free += '  </td>';
	html_free += '  <td class="text-right"><input type="text" name="option_value[' + option_value_row + '][sort_order]" value="" placeholder="<?php echo $entry_sort_order; ?>" class="form-control" /></td>';
	html_free += '  <td class="text-left"><button type="button" onclick="$(\'#option-value-row' + option_value_row + '\').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>';
	html_free += '</tr>';
	$('#option-value tbody').append(html_free);
	option_value_row++;
}

function addOptionValue() {
	html  = '<tr id="option-value-row' + option_value_row + '">';	
    html += '  <td class="text-left"><input type="hidden" name="option_value[' + option_value_row + '][option_value_id]" value="" />';
	<?php foreach ($languages as $language) { ?>
	html += '    <div class="input-group">';
	html += '      <span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></span><input type="text" name="option_value[' + option_value_row + '][option_value_description][<?php echo $language['language_id']; ?>][name]" value="" placeholder="<?php echo $entry_option_value; ?>" class="form-control" />';
    html += '    </div>';
	<?php } ?>
	html += '  </td>';
      
    html += '  <input type="hidden" name="option_value[' + option_value_row + '][value_type]" value="Pre_Customize" /><td class="text-left 2">';
	if(typ == 'size_option')
	{
	html += '  <span class="text-left custom-opt"><label><?php echo $text_bust; ?></label>';
	html += '  <input type="text" name="option_value[' + option_value_row + '][bust]"   value=""></span>';
	html += '  <span class="text-left custom-opt"><label><?php echo $text_waist; ?></label>';
	html += '  <input type="text" name="option_value[' + option_value_row + '][waist]" value=""></span>';
	html += '  <span class="text-left custom-opt"><label><?php echo $text_hip; ?></label>';
	html += '  <input type="text" name="option_value[' + option_value_row + '][hip]"    value=""></span>';
	html += '  <span class="text-left custom-opt"><label><?php echo $text_hollow; ?></label>';
	html += '  <input type="text" name="option_value[' + option_value_row + '][hollow]" value=""></span>';
	html += '  <span class="text-left custom-opt"><label><?php echo $text_height; ?></label>';
	html += '  <input type="text" name="option_value[' + option_value_row + '][height]"  value=""></span>';
	}else{ 
    html += ' <a href="" id="thumb-image' + option_value_row + '" data-toggle="image" class="img-thumbnail"><img src="<?php echo $placeholder; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a><input type="hidden" name="option_value[' + option_value_row + '][image]" value="" id="input-image' + option_value_row + '" />';
	}
	html += '  </td>';
	html += '  <td class="text-right"><input type="text" name="option_value[' + option_value_row + '][sort_order]" value="" placeholder="<?php echo $entry_sort_order; ?>" class="form-control" /></td>';
	html += '  <td class="text-left"><button type="button" onclick="$(\'#option-value-row' + option_value_row + '\').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>';
	html += '</tr>';	
	$('#option-value tbody').append(html);
	option_value_row++;
}
//--></script></div>
<style>
	.custom-opt{
	display:block;
	margin:10px;
	}
	.custom-opt label{
	width: 65px;
	}
</style>
<?php echo $footer; ?>