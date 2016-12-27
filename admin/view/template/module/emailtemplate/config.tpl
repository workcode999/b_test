<?php echo $header; ?>
<?php echo $column_left; ?>

<div id="content">
<div id="emailtemplate">
	<div class="page-header">
		<div class="container-fluid">
			<div class="pull-right">
				<button id="submit_form_button" type="submit" form="form-emailtemplate" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>

				<?php if (isset($action_delete)) { ?>
					<a href="<?php echo $action_delete; ?>" data-confirm="<?php echo $text_confirm; ?>" class="btn btn-danger" data-toggle="tooltip" title="<?php echo $button_delete; ?>"><i class="fa fa-trash-o"></i></a>
				<?php } ?>

				<a href="<?php echo $action_insert_config; ?>" class="btn btn-success" data-toggle="tooltip" title="<?php echo $text_create_config; ?>"><i class="fa fa-copy"></i></a>

				<a href="javascript:void(0)" class="btn btn-info" id="template-test" data-toggle="tooltip" title="<?php echo $button_test; ?>"><i class="fa fa-envelope-o"></i></a>
								
				<?php if (isset($action_configs) || isset($action_default)) { ?>
					<div class="btn-group">
						<button type="button" class="btn btn-info dropdown-toggle" data-toggle="dropdown" aria-expanded="false"><?php echo $button_configs; ?> <span class="caret"></span></button>
						<ul class="dropdown-menu dropdown-menu-right" role="menu">
							<?php if (isset($action_default)) { ?><li><a href="<?php echo $action_default; ?>"><?php echo $button_default; ?></a></li><?php } ?>
							<?php if (isset($action_default) && isset($action_configs)) { ?><li class="divider"></li><?php } ?>
							<?php if (isset($action_configs)) { ?>
								<?php foreach($action_configs as $row) { ?>
						    		<li><a href="<?php echo $row['url']; ?>"><?php echo $row['name']; ?></a></li>
						    	<?php } ?>
					    	<?php } ?>
					  	</ul>
					</div>
				<?php } ?>

				<a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a>
			</div>

			<h1><?php echo $heading_config; ?><?php if ($id == 1) { echo ' - ' . $text_default; } ?></h1>

			<ul class="breadcrumb">
        		<?php $i=1; foreach ($breadcrumbs as $breadcrumb) { ?>
        		<?php if ($i == count($breadcrumbs)) { ?>
        			<li class="active"><?php echo $breadcrumb['text']; ?></li>
        		<?php } else { ?>
        			<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        		<?php } ?>
        		<?php $i++; } ?>
      		</ul>
		</div>
	</div>

	<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-emailtemplate" class="container-fluid form-horizontal">
	    <?php if (isset($error_warning) && $error_warning) { ?>
	    	<div class="alert alert-danger">
				<i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
	      		<button type="button" class="close" data-dismiss="alert">&times;</button>
			</div>
	    <?php } ?>

	    <?php if (isset($error_attention) && $error_attention) { ?>
	    	<div class="alert alert-warning">
				<i class="fa fa-exclamation-circle"></i> <?php echo $error_attention; ?>
	      		<button type="button" class="close" data-dismiss="alert">&times;</button>
			</div>
	    <?php } ?>

	    <?php if (isset($success) && $success) { ?>
	    	<div class="alert alert-success">
				<i class="fa fa-exclamation-circle"></i> <?php echo $success; ?>
	      		<button type="button" class="close" data-dismiss="alert">&times;</button>
			</div>
	    <?php } ?>

		<div class="panel panel-default">
		<div class="panel-body">
            <div class="form-group required">
				<label class="col-sm-2 control-label" for="emailtemplate_config_name"><?php echo $entry_label; ?></label>
				<div class="col-sm-10">
					<input class="form-control" id="emailtemplate_config_name" name="emailtemplate_config_name" value="<?php echo $emailtemplate_config['name']; ?>" required="required" type="text" />
					<?php if (isset($error_emailtemplate_config_name)) { ?><span class="text-danger"><?php echo $error_emailtemplate_config_name; ?></span><?php } ?>
				</div>
			</div>

			<?php if (!empty($languages)) { ?>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="language_id"><?php echo $entry_language; ?></label>
				<div class="col-sm-10">
					<select class="form-control" name="language_id" id="language_id">
						<option value=""><?php echo $text_select; ?></option>
						<?php foreach($languages as $language) { ?>
						<option value="<?php echo $language['language_id']; ?>"<?php if ($language['language_id'] === $emailtemplate_config['language_id']) { ?> selected="selected"<?php } ?>>
							<?php echo $language['name']; ?>
						</option>
						<?php } ?>
					</select>
				</div>
			</div>
			<?php } ?>

			<?php if (!empty($stores)) { ?>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="store_id"><?php echo $entry_store; ?></label>
				<div class="col-sm-10">
					<select class="form-control" name="store_id" id="store_id">
						<option value="-1"><?php echo $text_select; ?></option>
						<?php foreach($stores as $store) { ?>
						<option value="<?php echo $store['store_id']; ?>"<?php if ($store['store_id'] == $emailtemplate_config['store_id']) { ?> selected="selected"<?php } ?>>
							<?php echo $store['store_name']; ?>
						</option>
						<?php } ?>
					</select>
				</div>
			</div>
			<?php } ?>

			<?php if (count($themes) > 1) { ?>
          	<div class="form-group">
				<label class="col-sm-2 control-label" for="emailtemplate_config_theme"><?php echo $entry_theme; ?></label>
				<div class="col-sm-10">
					<select class="form-control" name="emailtemplate_config_theme" id="emailtemplate_config_theme">
						<?php foreach($themes as $theme) { ?>
						<option value="<?php echo $theme; ?>"<?php if ($theme == $emailtemplate_config['theme']) { ?> selected="selected"<?php } ?>><?php echo $theme; ?></option>
						<?php } ?>
					</select>
					<?php if (isset($error_emailtemplate_config_theme)) {?><span class="text-danger"><?php echo $error_emailtemplate_config_theme; ?></span><?php } ?>
				</div>
			</div>
			<?php } ?>
		</div>
		</div>

		<div class="panel">
			<div class="panel-nav-tabs">
				<ul class="nav nav-tabs" id="config-tabs">
    				<li class="active"><a href="javascript:void(0)" data-target="#tab-style" data-toggle="tab"><i class="fa fa-paint-brush hidden-xs"></i> <?php echo $heading_style; ?></a></li>
    				<li><a href="javascript:void(0)" data-target="#tab-header" data-toggle="tab"><i class="fa fa-envelope hidden-xs"></i> <?php echo $heading_header; ?></a></li>
    				<li><a href="javascript:void(0)" data-target="#tab-footer" data-toggle="tab"><i class="fa fa-envelope hidden-xs"></i> <?php echo $heading_footer; ?></a></li>
  				</ul>
			</div>

			<div class="tab-content">
				<div id="tab-style" class="tab-pane fade active in">
				    <div class="form-group">
						<label class="col-sm-2 control-label" for="emailtemplate_config_email_width"><?php echo $entry_email_width; ?></label>
						<div class="col-sm-10">
							<div class="input-group">
								<input class="form-control" id="emailtemplate_config_email_width" name="emailtemplate_config_email_width" value="<?php echo $emailtemplate_config['email_width']; ?>" type="number" />
								<span class="input-group-addon">px</span>
							</div>
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-2 control-label" for="emailtemplate_config_text_align"><?php echo $entry_text_align; ?></label>
						<div class="col-sm-10">
							<select class="form-control " name="emailtemplate_config_text_align" id="emailtemplate_config_text_align">
								<option value="left"<?php if ($emailtemplate_config['text_align'] == 'left') { ?> selected="selected"<?php } ?>><?php echo $text_left; ?></option>
								<option value="right"<?php if ($emailtemplate_config['text_align'] == 'right') { ?> selected="selected"<?php } ?>><?php echo $text_right; ?></option>
							</select>
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-2 control-label" for="emailtemplate_config_page_align"><?php echo $entry_page_align; ?></label>
						<div class="col-sm-10">
							<select class="form-control " name="emailtemplate_config_page_align" id="emailtemplate_config_page_align">
								<option value="center"<?php if ($emailtemplate_config['page_align'] == 'center') { ?> selected="selected"<?php } ?>><?php echo $text_center; ?></option>
								<option value="left"<?php if ($emailtemplate_config['page_align'] == 'left') { ?> selected="selected"<?php } ?>><?php echo $text_left; ?></option>
								<option value="right"<?php if ($emailtemplate_config['page_align'] == 'right') { ?> selected="selected"<?php } ?>><?php echo $text_right; ?></option>
							</select>
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-2 control-label" for="emailtemplate_config_body_bg_color"><?php echo $entry_body_bg_color; ?></label>
						<div class="col-sm-10">
							<div class="input-group input-colorpicker">
								<span class="input-group-addon preview"><i<?php if ($emailtemplate_config['body_bg_color']) { ?> style="background-color:<?php echo $emailtemplate_config['body_bg_color']; ?>;"<?php } ?>></i></span>
								<input class="form-control " type="text" id="emailtemplate_config_body_bg_color" name="emailtemplate_config_body_bg_color" value="<?php echo $emailtemplate_config['body_bg_color']; ?>" />
								<span class="input-group-addon"><i class="fa fa-eyedropper"></i></span>
							</div>
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-2 control-label" for="emailtemplate_config_page_bg_color"><?php echo $entry_page_bg_color; ?></label>
						<div class="col-sm-10">
							<div class="input-group input-colorpicker">
								<span class="input-group-addon preview"><i<?php if ($emailtemplate_config['page_bg_color']) { ?> style="background-color:<?php echo $emailtemplate_config['page_bg_color']; ?>;"<?php } ?>></i></span>
								<input class="form-control " type="text" id="emailtemplate_config_page_bg_color" name="emailtemplate_config_page_bg_color" value="<?php echo $emailtemplate_config['page_bg_color']; ?>" />
								<span class="input-group-addon"><i class="fa fa-eyedropper"></i></span>
							</div>
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-2 control-label" for="emailtemplate_config_body_font_color"><?php echo $entry_body_font_color; ?></label>
						<div class="col-sm-10">
							<div class="input-group input-colorpicker">
								<span class="input-group-addon preview"><i<?php if ($emailtemplate_config['body_font_color']) { ?> style="background-color:<?php echo $emailtemplate_config['body_font_color']; ?>;"<?php } ?>></i></span>
								<input class="form-control " type="text" id="emailtemplate_config_body_font_color" name="emailtemplate_config_body_font_color" value="<?php echo $emailtemplate_config['body_font_color']; ?>" />
								<span class="input-group-addon"><i class="fa fa-eyedropper"></i></span>
							</div>
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-2 control-label" for="emailtemplate_config_body_link_color"><?php echo $entry_body_link_color; ?></label>
						<div class="col-sm-10">
							<div class="input-group input-colorpicker">
								<span class="input-group-addon preview"><i<?php if ($emailtemplate_config['body_link_color']) { ?> style="background-color:<?php echo $emailtemplate_config['body_link_color']; ?>;"<?php } ?>></i></span>
								<input class="form-control " type="text" id="emailtemplate_config_body_link_color" name="emailtemplate_config_body_link_color" value="<?php echo $emailtemplate_config['body_link_color']; ?>" />
								<span class="input-group-addon"><i class="fa fa-eyedropper"></i></span>
							</div>
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-2 control-label" for="emailtemplate_config_body_heading_color"><?php echo $entry_body_heading_color; ?></label>
						<div class="col-sm-10">
							<div class="input-group input-colorpicker">
								<span class="input-group-addon preview"><i<?php if ($emailtemplate_config['body_heading_color']) { ?> style="background-color:<?php echo $emailtemplate_config['body_heading_color']; ?>;"<?php } ?>></i></span>
								<input class="form-control " type="text" id="emailtemplate_config_body_heading_color" name="emailtemplate_config_body_heading_color" value="<?php echo $emailtemplate_config['body_heading_color']; ?>" />
								<span class="input-group-addon"><i class="fa fa-eyedropper"></i></span>
							</div>
						</div>
					</div>

					<fieldset>
						<legend class="heading"><?php echo $heading_sections; ?></legend>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="emailtemplate_config_head_section_bg_color"><?php echo $entry_head; ?></label>
							<div class="col-sm-10">
								<div class="input-group input-colorpicker">
									<span class="input-group-addon preview"><i<?php if ($emailtemplate_config['head_section_bg_color']) { ?> style="background-color:<?php echo $emailtemplate_config['head_section_bg_color']; ?>;"<?php } ?>></i></span>
									<input class="form-control " type="text" id="emailtemplate_config_head_section_bg_color" name="emailtemplate_config_head_section_bg_color" value="<?php echo $emailtemplate_config['head_section_bg_color']; ?>" />
									<span class="input-group-addon"><i class="fa fa-eyedropper"></i></span>
								</div>
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="emailtemplate_config_header_section_bg_color"><?php echo $entry_header; ?></label>
							<div class="col-sm-10">
								<div class="input-group input-colorpicker">
									<span class="input-group-addon preview"><i<?php if ($emailtemplate_config['header_section_bg_color']) { ?> style="background-color:<?php echo $emailtemplate_config['header_section_bg_color']; ?>;"<?php } ?>></i></span>
									<input class="form-control " type="text" id="emailtemplate_config_header_section_bg_color" name="emailtemplate_config_header_section_bg_color" value="<?php echo $emailtemplate_config['header_section_bg_color']; ?>" />
									<span class="input-group-addon"><i class="fa fa-eyedropper"></i></span>
								</div>
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="emailtemplate_config_body_section_bg_color"><?php echo $entry_body; ?></label>
							<div class="col-sm-10">
								<div class="input-group input-colorpicker">
									<span class="input-group-addon preview"><i<?php if ($emailtemplate_config['body_section_bg_color']) { ?> style="background-color:<?php echo $emailtemplate_config['body_section_bg_color']; ?>;"<?php } ?>></i></span>
									<input class="form-control " type="text" id="emailtemplate_config_body_section_bg_color" name="emailtemplate_config_body_section_bg_color" value="<?php echo $emailtemplate_config['body_section_bg_color']; ?>" />
									<span class="input-group-addon"><i class="fa fa-eyedropper"></i></span>
								</div>
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="emailtemplate_config_footer_section_bg_color"><?php echo $entry_footer; ?></label>
							<div class="col-sm-10">
								<div class="input-group input-colorpicker">
									<span class="input-group-addon preview"><i<?php if ($emailtemplate_config['footer_section_bg_color']) { ?> style="background-color:<?php echo $emailtemplate_config['footer_section_bg_color']; ?>;"<?php } ?>></i></span>
									<input class="form-control " type="text" id="emailtemplate_config_footer_section_bg_color" name="emailtemplate_config_footer_section_bg_color" value="<?php echo $emailtemplate_config['footer_section_bg_color']; ?>" />
									<span class="input-group-addon"><i class="fa fa-eyedropper"></i></span>
								</div>
							</div>
						</div>
					</fieldset>

					<fieldset>
						<legend class="heading"><?php echo $heading_shadow; ?></legend>

						<p><?php echo $text_shadow_info; ?></p>
						
						<div class="form-group">
							<label class="col-sm-2 control-label"><?php echo $text_top; ?></label>
							<div class="col-sm-5 col-lg-2">
								<label class="control-label" for="emailtemplate_config_shadow_top_length"><?php echo $entry_height; ?></label>
								<div class="input-group">
									<input class="form-control " name="emailtemplate_config_shadow_top[length]" id="emailtemplate_config_shadow_top_length" value="<?php echo isset($emailtemplate_config['shadow_top']['length']) ? $emailtemplate_config['shadow_top']['length'] : ''; ?>" type="number" />
									<span class="input-group-addon">px</span>
								</div>
							</div>
							<div class="col-sm-5 col-lg-2">
								<label class="control-label" for="emailtemplate_config_shadow_top_overlap"><?php echo $entry_overlap; ?></label>
								<div class="input-group">
									<input class="form-control " name="emailtemplate_config_shadow_top[overlap]" id="emailtemplate_config_shadow_top_overlap" value="<?php echo isset($emailtemplate_config['shadow_top']['overlap']) ? $emailtemplate_config['shadow_top']['overlap'] : ''; ?>" type="number" />
									<span class="input-group-addon">px</span>
								</div>
							</div>
							<div class="col-sm-5 col-sm-offset-2 col-lg-2 col-lg-offset-0">
								<label class="control-label" for="emailtemplate_config_shadow_top_end"><?php echo $entry_start; ?></label>
								<div class="input-group input-colorpicker">
									<span class="input-group-addon preview"><i<?php if ($emailtemplate_config['shadow_top']['start']) { ?> style="background-color:<?php echo $emailtemplate_config['shadow_top']['start']; ?>;"<?php } ?>></i></span>
									<input class="form-control " type="text" id="emailtemplate_config_shadow_top_end" name="emailtemplate_config_shadow_top[start]" value="<?php echo $emailtemplate_config['shadow_top']['start']; ?>" />
									<span class="input-group-addon"><i class="fa fa-eyedropper"></i></span>
								</div>
							</div>
							<div class="col-sm-5 col-lg-2">
								<label class="control-label" for="emailtemplate_config_shadow_top_end"><?php echo $entry_end; ?></label>
								<div class="input-group input-colorpicker">
									<span class="input-group-addon preview"><i<?php if ($emailtemplate_config['shadow_top']['end']) { ?> style="background-color:<?php echo $emailtemplate_config['shadow_top']['end']; ?>;"<?php } ?>></i></span>
									<input class="form-control " type="text" id="emailtemplate_config_shadow_top_end" name="emailtemplate_config_shadow_top[end]" value="<?php echo $emailtemplate_config['shadow_top']['end']; ?>" />
									<span class="input-group-addon"><i class="fa fa-eyedropper"></i></span>
								</div>
							</div>
						</div>

						<?php if ($emailtemplate_config['shadow_bottom']) { ?>
						<div class="form-group">
							<label class="col-sm-2 control-label"><?php echo $text_bottom; ?></label>
							<div class="col-sm-5 col-lg-2">
								<label class="control-label" for="emailtemplate_config_shadow_bottom_length"><?php echo $entry_height; ?></label>
								<div class="input-group">
									<input class="form-control " name="emailtemplate_config_shadow_bottom[length]" id="emailtemplate_config_shadow_bottom_length" value="<?php echo isset($emailtemplate_config['shadow_bottom']['length']) ? $emailtemplate_config['shadow_bottom']['length'] : ''; ?>" type="number" />
									<span class="input-group-addon">px</span>
								</div>
							</div>
							<div class="col-sm-5 col-lg-2">
								<label class="control-label" for="emailtemplate_config_shadow_bottom_overlap"><?php echo $entry_overlap; ?></label>
								<div class="input-group">
									<input class="form-control " name="emailtemplate_config_shadow_bottom[overlap]" id="emailtemplate_config_shadow_bottom_overlap" value="<?php echo isset($emailtemplate_config['shadow_bottom']['overlap']) ? $emailtemplate_config['shadow_bottom']['overlap'] : ''; ?>" type="number" />
									<span class="input-group-addon">px</span>
								</div>
							</div>
							<div class="col-sm-5 col-sm-offset-2 col-lg-2 col-lg-offset-0">
								<label class="control-label" for="emailtemplate_config_shadow_bottom_end"><?php echo $entry_start; ?></label>
								<div class="input-group input-colorpicker">
									<span class="input-group-addon preview"><i<?php if ($emailtemplate_config['shadow_bottom']['start']) { ?> style="background-color:<?php echo $emailtemplate_config['shadow_bottom']['start']; ?>;"<?php } ?>></i></span>
									<input class="form-control " type="text" id="emailtemplate_config_shadow_bottom_end" name="emailtemplate_config_shadow_bottom[start]" value="<?php echo $emailtemplate_config['shadow_bottom']['start']; ?>" />
									<span class="input-group-addon"><i class="fa fa-eyedropper"></i></span>
								</div>
							</div>
							<div class="col-sm-5 col-lg-2">
								<label class="control-label" for="emailtemplate_config_shadow_bottom_end"><?php echo $entry_end; ?></label>
								<div class="input-group input-colorpicker">
									<span class="input-group-addon preview"><i<?php if ($emailtemplate_config['shadow_bottom']['end']) { ?> style="background-color:<?php echo $emailtemplate_config['shadow_bottom']['end']; ?>;"<?php } ?>></i></span>
									<input class="form-control " type="text" id="emailtemplate_config_shadow_bottom_end" name="emailtemplate_config_shadow_bottom[end]" value="<?php echo $emailtemplate_config['shadow_bottom']['end']; ?>" />
									<span class="input-group-addon"><i class="fa fa-eyedropper"></i></span>
								</div>
							</div>
						</div>
						<?php } ?>

						<div class="form-group">
							<label class="col-sm-2 control-label"><?php echo $text_left; ?></label>
							<div class="col-sm-5 col-lg-2">
								<label class="control-label" for="emailtemplate_config_shadow_left_length"><?php echo $entry_width; ?></label>
								<div class="input-group">
									<input class="form-control " name="emailtemplate_config_shadow_left[length]" id="emailtemplate_config_shadow_left_length" value="<?php echo isset($emailtemplate_config['shadow_left']['length']) ? $emailtemplate_config['shadow_left']['length'] : ''; ?>" type="number" />
									<span class="input-group-addon">px</span>
								</div>
							</div>
							<div class="col-sm-5 col-lg-2">
								<label class="control-label" for="emailtemplate_config_shadow_left_overlap"><?php echo $entry_overlap; ?></label>
								<div class="input-group">
									<input class="form-control " name="emailtemplate_config_shadow_left[overlap]" id="emailtemplate_config_shadow_left_overlap" value="<?php echo isset($emailtemplate_config['shadow_left']['overlap']) ? $emailtemplate_config['shadow_left']['overlap'] : ''; ?>" type="number" />
									<span class="input-group-addon">px</span>
								</div>
							</div>
							<div class="col-sm-5 col-sm-offset-2 col-lg-2 col-lg-offset-0">
								<label class="control-label" for="emailtemplate_config_shadow_left_end"><?php echo $entry_start; ?></label>
								<div class="input-group input-colorpicker">
									<span class="input-group-addon preview"><i<?php if ($emailtemplate_config['shadow_left']['start']) { ?> style="background-color:<?php echo $emailtemplate_config['shadow_left']['start']; ?>;"<?php } ?>></i></span>
									<input class="form-control " type="text" id="emailtemplate_config_shadow_left_end" name="emailtemplate_config_shadow_left[start]" value="<?php echo $emailtemplate_config['shadow_left']['start']; ?>" />
									<span class="input-group-addon"><i class="fa fa-eyedropper"></i></span>
								</div>
							</div>
							<div class="col-sm-5 col-lg-2">
								<label class="control-label" for="emailtemplate_config_shadow_left_end"><?php echo $entry_end; ?></label>
								<div class="input-group input-colorpicker">
									<span class="input-group-addon preview"><i<?php if ($emailtemplate_config['shadow_left']['end']) { ?> style="background-color:<?php echo $emailtemplate_config['shadow_left']['end']; ?>;"<?php } ?>></i></span>
									<input class="form-control " type="text" id="emailtemplate_config_shadow_left_end" name="emailtemplate_config_shadow_left[end]" value="<?php echo $emailtemplate_config['shadow_left']['end']; ?>" />
									<span class="input-group-addon"><i class="fa fa-eyedropper"></i></span>
								</div>
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label"><?php echo $text_right; ?></label>
							<div class="col-sm-5 col-lg-2">
								<label class="control-label" for="emailtemplate_config_shadow_right_length"><?php echo $entry_width; ?></label>
								<div class="input-group">
									<input class="form-control" name="emailtemplate_config_shadow_right[length]" id="emailtemplate_config_shadow_right_length" value="<?php echo isset($emailtemplate_config['shadow_right']['length']) ? $emailtemplate_config['shadow_right']['length'] : ''; ?>" type="number" />
									<span class="input-group-addon">px</span>
								</div>
							</div>
							<div class="col-sm-5 col-lg-2">
								<label class="control-label" for="emailtemplate_config_shadow_right_overlap"><?php echo $entry_overlap; ?></label>
								<div class="input-group">
									<input class="form-control" name="emailtemplate_config_shadow_right[overlap]" id="emailtemplate_config_shadow_right_overlap" value="<?php echo isset($emailtemplate_config['shadow_right']['overlap']) ? $emailtemplate_config['shadow_right']['overlap'] : ''; ?>" type="number" />
									<span class="input-group-addon">px</span>
								</div>
							</div>
							<div class="col-sm-5 col-sm-offset-2 col-lg-2 col-lg-offset-0">
								<label class="control-label" for="emailtemplate_config_shadow_right_end"><?php echo $entry_start; ?></label>
								<div class="input-group input-colorpicker">
									<span class="input-group-addon preview"><i<?php if ($emailtemplate_config['shadow_right']['start']) { ?> style="background-color:<?php echo $emailtemplate_config['shadow_right']['start']; ?>;"<?php } ?>></i></span>
									<input type="text" class="form-control" id="emailtemplate_config_shadow_right_end" name="emailtemplate_config_shadow_right[start]" value="<?php echo $emailtemplate_config['shadow_right']['start']; ?>" />
									<span class="input-group-addon"><i class="fa fa-eyedropper"></i></span>
								</div>
							</div>
							<div class="col-sm-5 col-lg-2">
								<label class="control-label" for="emailtemplate_config_shadow_right_end"><?php echo $entry_end; ?></label>
								<div class="input-group input-colorpicker">
									<span class="input-group-addon preview"><i<?php if ($emailtemplate_config['shadow_right']['end']) { ?> style="background-color:<?php echo $emailtemplate_config['shadow_right']['end']; ?>;"<?php } ?>></i></span>
									<input type="text" class="form-control" id="emailtemplate_config_shadow_right_end" name="emailtemplate_config_shadow_right[end]" value="<?php echo $emailtemplate_config['shadow_right']['end']; ?>" />
									<span class="input-group-addon"><i class="fa fa-eyedropper"></i></span>
								</div>
							</div>
						</div>
					</fieldset>

					<fieldset>
						<div class="row">
							<label class="col-sm-2 control-label"><?php echo $entry_corner_image; ?></label>
							<div class="col-xs-6 col-md-3 col-lg-2">
								<a href="javascript:void(0)" id="thumb-shadow-top-left" data-toggle="image" class="img-thumbnail" style="vertical-align:middle"><img class="img-responsive" src="<?php echo $emailtemplate_config['shadow_top']['left_thumb']; ?>" alt="" data-placeholder="<?php echo $no_shadow_image; ?>" /></a>
								<label class="control-label" for="image-shadow-top-left"><?php echo $entry_top_left; ?></label>
                  				<input type="hidden" name="emailtemplate_config_shadow_top[left_img]" value="<?php echo $emailtemplate_config['shadow_top']['left_img']; ?>" id="image-shadow-top-left" />
							</div>
							<div class="col-xs-6 col-md-3 col-lg-2">
								<a href="javascript:void(0)" id="thumb-shadow-top-right" data-toggle="image" class="img-thumbnail" style="vertical-align:middle"><img class="img-responsive" src="<?php echo $emailtemplate_config['shadow_top']['right_thumb']; ?>" alt="" data-placeholder="<?php echo $no_shadow_image; ?>" /></a>
								<label class="control-label" for="image-shadow-top-right"><?php echo $entry_top_right; ?></label>
                  				<input type="hidden" name="emailtemplate_config_shadow_top[right_img]" value="<?php echo $emailtemplate_config['shadow_top']['right_img']; ?>" id="image-shadow-top-right" />
							</div>
							<div class="col-sm-5 col-sm-offset-2 col-lg-2 col-lg-offset-0">
								<a href="javascript:void(0)" id="thumb-shadow-bottom-left" data-toggle="image" class="img-thumbnail" style="vertical-align:middle"><img class="img-responsive" src="<?php echo $emailtemplate_config['shadow_bottom']['left_thumb']; ?>" alt="" data-placeholder="<?php echo $no_shadow_image; ?>" /></a>
								<label class="control-label" for="image-shadow-bottom-left"><?php echo $entry_bottom_left; ?></label>
								<input type="hidden" name="emailtemplate_config_shadow_bottom[left_img]" value="<?php echo $emailtemplate_config['shadow_bottom']['left_img']; ?>" id="image-shadow-bottom-left" />
							</div>
							<div class="col-xs-6 col-md-3 col-lg-2">
								<a href="javascript:void(0)" id="thumb-shadow-bottom-right" data-toggle="image" class="img-thumbnail" style="vertical-align:middle"><img class="img-responsive" src="<?php echo $emailtemplate_config['shadow_bottom']['right_thumb']; ?>" alt="" data-placeholder="<?php echo $no_shadow_image; ?>" /></a>
								<label class="control-label" for="image-shadow-bottom-right"><?php echo $entry_bottom_right; ?></label>
                  				<input type="hidden" name="emailtemplate_config_shadow_bottom[right_img]" value="<?php echo $emailtemplate_config['shadow_bottom']['right_img']; ?>" id="image-shadow-bottom-right" />
							</div>
						</div>
					</fieldset>
				</div><!-- #tab-style -->

				<div id="tab-header" class="tab-pane fade">
					<div class="form-group">
                   		<label class="col-sm-2 control-label" for="emailtemplate_config_head_text"><?php echo $entry_head_text; ?></label>
                   		<div class="col-sm-10">
                   			<textarea class="wysiwyg_editor" name="emailtemplate_config_head_text" id="emailtemplate_config_head_text"><?php echo $emailtemplate_config['head_text']; ?></textarea>
                   		</div>
                  	</div>

					<div class="form-group">
						<label class="col-sm-2 control-label" for="emailtemplate_config_header_bg_color"><?php echo $entry_header_bg_color; ?></label>
						<div class="col-sm-4">
							<div class="input-group input-colorpicker">
								<span class="input-group-addon preview"><i<?php if ($emailtemplate_config['header_bg_color']) { ?> style="background-color:<?php echo $emailtemplate_config['header_bg_color']; ?>;"<?php } ?>></i></span>
								<input type="text" class="form-control" id="emailtemplate_config_header_bg_color" name="emailtemplate_config_header_bg_color" value="<?php echo $emailtemplate_config['header_bg_color']; ?>" />
								<span class="input-group-addon"><i class="fa fa-eyedropper"></i></span>
							</div>
						</div>
						<label class="col-sm-2 control-label" for="emailtemplate_config_header_border_color"><?php echo $entry_header_border_color; ?></label>
						<div class="col-sm-4">
							<div class="input-group input-colorpicker">
								<span class="input-group-addon preview"><i<?php if ($emailtemplate_config['header_bg_color']) { ?> style="background-color:<?php echo $emailtemplate_config['header_border_color']; ?>;"<?php } ?>></i></span>
								<input type="text" class="form-control" id="emailtemplate_config_header_border_color" name="emailtemplate_config_header_border_color" value="<?php echo $emailtemplate_config['header_border_color']; ?>" />
								<span class="input-group-addon"><i class="fa fa-eyedropper"></i></span>
							</div>
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-2 control-label"><?php echo $entry_header_bg_image; ?></label>
                			<div class="col-sm-10">
                				<a href="javascript:void(0)" id="thumb-header-bg" data-toggle="image" class="img-thumbnail"><img class="img-responsive" src="<?php echo $emailtemplate_config['header_bg_image_thumb']; ?>" alt="" data-placeholder="<?php echo $no_image; ?>" /></a>
                  				<input type="hidden" name="emailtemplate_config_header_bg_image" value="<?php echo $emailtemplate_config['header_bg_image']; ?>" id="input-header-bg" />
                  				<?php if (isset($error_emailtemplate_config_header_bg_image)) {?><span class="text-danger"><?php echo $error_emailtemplate_config_header_bg_image; ?></span><?php } ?>
                			</div>
              			</div>

              			<div class="form-group">
							<label class="col-sm-2 control-label" for="emailtemplate_config_header_height"><?php echo $entry_height; ?></label>
						<div class="col-sm-10">
							<div class="input-group">
								<input class="form-control" id="emailtemplate_config_header_height" name="emailtemplate_config_header_height" value="<?php echo $emailtemplate_config['header_height']; ?>" type="number" />
								<span class="input-group-addon">px</span>
							</div>
						</div>
					</div>

					<fieldset>
						<legend class="heading"><?php echo $text_logo; ?></legend>

						<div class="form-group">
							<label class="col-sm-2 control-label"><?php echo $entry_logo; ?></label>
                				<div class="col-sm-10">
                					<a href="javascript:void(0)" id="thumb-logo" data-toggle="image" class="img-thumbnail"><img class="img-responsive" src="<?php echo $emailtemplate_config['logo_thumb']; ?>" alt="" data-placeholder="<?php echo $no_image; ?>" /></a>
                  					<input type="hidden" name="emailtemplate_config_logo" value="<?php echo $emailtemplate_config['logo']; ?>" id="input-logo" />
                  					<?php if (isset($error_emailtemplate_config_logo)) {?><span class="text-danger"><?php echo $error_emailtemplate_config_logo; ?></span><?php } ?>
                				</div>
              				</div>

							<div class="form-group">
								<label class="col-sm-2 control-label" for="emailtemplate_config_logo_width"><?php echo $entry_logo_resize_options; ?></label>
							<div class="col-sm-5">
								<div class="input-group">
									<span class="input-group-addon"><i class="fa fa-arrows-h "></i></span>
									<input class="form-control" name="emailtemplate_config_logo_width" id="emailtemplate_config_logo_width" value="<?php echo $emailtemplate_config['logo_width']; ?>" type="number" />
								</div>
							</div>
							<div class="col-sm-5">
								<div class="input-group">
									<span class="input-group-addon"><i class="fa fa-arrows-v"></i></span>
									<input class="form-control" name="emailtemplate_config_logo_height" id="emailtemplate_config_logo_height" value="<?php echo $emailtemplate_config['logo_height']; ?>" type="number" />
								</div>
							</div>
							<?php if (isset($error_emailtemplate_config_logo_width) || isset($error_emailtemplate_config_logo_height)): ?>
				            	<span class="text-danger"><?php echo $error_required; ?></span>
				            <?php endif; ?>
						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="emailtemplate_config_logo_align"><?php echo $text_align; ?></label>
							<div class="col-sm-5">
								<div class="input-group">
									<span class="input-group-addon"><i class="fa fa-arrows-h "></i></span>
									<select name="emailtemplate_config_logo_align" id="emailtemplate_config_logo_align" class="form-control">
										<option value="center"<?php if ($emailtemplate_config['logo_align'] == 'center') { ?> selected="selected"<?php } ?>><?php echo $text_center; ?></option>
										<option value="left"<?php if ($emailtemplate_config['logo_align'] == 'left') { ?> selected="selected"<?php } ?>><?php echo $text_left; ?></option>
										<option value="right"<?php if ($emailtemplate_config['logo_align'] == 'right') { ?> selected="selected"<?php } ?>><?php echo $text_right; ?></option>
									</select>
								</div>
							</div>
							<div class="col-sm-5">
								<div class="input-group">
									<span class="input-group-addon"><i class="fa fa-arrows-v "></i></span>
									<select name="emailtemplate_config_logo_valign" id="emailtemplate_config_logo_valign" class="form-control">
										<option value="top"<?php if ($emailtemplate_config['logo_valign'] == 'top') { ?> selected="selected"<?php } ?>><?php echo $text_top; ?></option>
										<option value="middle"<?php if ($emailtemplate_config['logo_valign'] == 'middle') { ?> selected="selected"<?php } ?>><?php echo $text_middle; ?></option>
										<option value="bottom"<?php if ($emailtemplate_config['logo_valign'] == 'bottom') { ?> selected="selected"<?php } ?>><?php echo $text_bottom; ?></option>
										<option value="baseline"<?php if ($emailtemplate_config['logo_valign'] == 'baseline') { ?> selected="selected"<?php } ?>><?php echo $text_baseline; ?></option>
									</select>
								</div>
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="emailtemplate_config_logo_font_size"><?php echo $text_font_size; ?></label>
							<div class="col-sm-10">
								<div class="input-group">
									<input class="form-control" id="emailtemplate_config_logo_font_size" name="emailtemplate_config_logo_font_size" value="<?php echo $emailtemplate_config['logo_font_size']; ?>" type="number" />
									<span class="input-group-addon">px</span>
								</div>
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="emailtemplate_config_logo_font_color"><?php echo $text_text_color; ?></label>
							<div class="col-sm-10">
								<div class="input-group input-colorpicker">
									<span class="input-group-addon preview"><i<?php if ($emailtemplate_config['logo_font_color']) { ?> style="background-color:<?php echo $emailtemplate_config['logo_font_color']; ?>;"<?php } ?>></i></span>
									<input class="form-control" type="text" id="emailtemplate_config_logo_font_color" name="emailtemplate_config_logo_font_color" value="<?php echo $emailtemplate_config['logo_font_color']; ?>" />
									<span class="input-group-addon"><i class="fa fa-eyedropper"></i></span>
								</div>
							</div>
						</div>
					</fieldset>
				</div><!-- #tab-header -->

				<div id="tab-footer" class="tab-pane fade">
					<div class="form-group">
                   		<label class="col-sm-2 control-label" for="emailtemplate_config_page_footer_text"><?php echo $entry_page_footer_text; ?></label>
                   		<div class="col-sm-10">
                   			<textarea class="wysiwyg_editor" name="emailtemplate_config_page_footer_text" id="emailtemplate_config_page_footer_text"><?php echo $emailtemplate_config['page_footer_text']; ?></textarea>
                   		</div>
                  	</div>

					<div class="form-group">
                   		<label class="col-sm-2 control-label" for="emailtemplate_config_footer_text"><?php echo $entry_footer_text; ?></label>
                   		<div class="col-sm-10">
                   			<textarea class="wysiwyg_editor" name="emailtemplate_config_footer_text" id="emailtemplate_config_footer_text"><?php echo $emailtemplate_config['footer_text']; ?></textarea>
                   		</div>
                  	</div>

                  	<div class="form-group">
						<label class="col-sm-2 control-label" for="emailtemplate_config_email_width"><?php echo $text_height; ?></label>
						<div class="col-sm-10">
							<div class="input-group">
								<input class="form-control" id="emailtemplate_config_footer_height" name="emailtemplate_config_footer_height" value="<?php echo $emailtemplate_config['footer_height']; ?>" type="number" />
								<span class="input-group-addon">px</span>
							</div>
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-2 control-label" for="emailtemplate_config_footer_font_color"><?php echo $text_text_color; ?></label>
						<div class="col-sm-10">
							<div class="input-group input-colorpicker">
								<span class="input-group-addon preview"><i<?php if ($emailtemplate_config['footer_font_color']) { ?> style="background-color:<?php echo $emailtemplate_config['footer_font_color']; ?>;"<?php } ?>></i></span>
								<input type="text" class="form-control" id="emailtemplate_config_footer_font_color" name="emailtemplate_config_footer_font_color" value="<?php echo $emailtemplate_config['footer_font_color']; ?>" />
								<span class="input-group-addon"><i class="fa fa-eyedropper"></i></span>
							</div>
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-2 control-label" for="emailtemplate_config_footer_align"><?php echo $text_align; ?></label>
						<div class="col-sm-5">
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-arrows-h "></i></span>
								<select name="emailtemplate_config_footer_align" id="emailtemplate_config_footer_align" class="form-control">
									<option value="center"<?php if ($emailtemplate_config['footer_align'] == 'center') { ?> selected="selected"<?php } ?>><?php echo $text_center; ?></option>
									<option value="left"<?php if ($emailtemplate_config['footer_align'] == 'left') { ?> selected="selected"<?php } ?>><?php echo $text_left; ?></option>
									<option value="right"<?php if ($emailtemplate_config['footer_align'] == 'right') { ?> selected="selected"<?php } ?>><?php echo $text_right; ?></option>
								</select>
							</div>
						</div>
						<div class="col-sm-5">
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-arrows-v "></i></span>
								<select name="emailtemplate_config_footer_valign" id="emailtemplate_config_footer_valign" class="form-control">
									<option value="top"<?php if ($emailtemplate_config['footer_valign'] == 'top') { ?> selected="selected"<?php } ?>><?php echo $text_top; ?></option>
									<option value="middle"<?php if ($emailtemplate_config['footer_valign'] == 'middle') { ?> selected="selected"<?php } ?>><?php echo $text_middle; ?></option>
									<option value="bottom"<?php if ($emailtemplate_config['footer_valign'] == 'bottom') { ?> selected="selected"<?php } ?>><?php echo $text_bottom; ?></option>
									<option value="baseline"<?php if ($emailtemplate_config['footer_valign'] == 'baseline') { ?> selected="selected"<?php } ?>><?php echo $text_baseline; ?></option>
								</select>
							</div>
						</div>
					</div>
				</div><!-- #tab-footer -->
			</div>
		</div>
		
		<div class="support-text">
			<h3>Extension not working correct? - <a href="<?php echo $support_url; ?>">Open support ticket!</a></h3>

			<p>Error message are the most useful information you can provide when opening a <a href="<?php echo $support_url; ?>" target="_blank">support ticket</a> and will help in getting your issue resolved quicker.</p>

			<p>This Extension is brought to you by: <a href="http://www.opencart-templates.co.uk" target="_blank">Opencart-templates</a></p>
		</div>
	</form>
</div>
</div>

<?php echo $footer; ?>