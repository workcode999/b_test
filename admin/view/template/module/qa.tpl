<?php echo $header; ?>
<div class="modal fade" id="legal_text" tabindex="-1" role="dialog" aria-labelledby="legal_text_label" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="legal_text_label"><?php echo $text_terms; ?></h4>
			</div>
			<div class="modal-body">
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default cancel" data-dismiss="modal"><i class="fa fa-times"></i> <?php echo $button_close; ?></button>
			</div>
		</div>
	</div>
</div>
<?php echo $column_left; ?>
<div id="content">
	<div class="page-header">
		<div class="container-fluid">
			<ul class="breadcrumb bull5i-breadcrumb">
				<?php foreach ($breadcrumbs as $breadcrumb) { ?>
				<li<?php echo ($breadcrumb['active']) ? ' class="active"' : ''; ?>><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
				<?php } ?>
			</ul>
			<div class="navbar-placeholder">
				<nav class="navbar navbar-bull5i" role="navigation" id="bull5i-navbar">
					<div class="nav-container">

						<div class="navbar-header">
							<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bull5i-navbar-collapse">
								<span class="sr-only"><?php echo $text_toggle_navigation; ?></span>
								<span class="icon-bar"></span>
								<span class="icon-bar"></span>
								<span class="icon-bar"></span>
							</button>
							<h1 class="bull5i-navbar-brand"><i class="fa fa-question-circle fa-fw ext-icon"></i> <?php echo $heading_title; ?></h1>
						</div>
						<div class="collapse navbar-collapse" id="bull5i-navbar-collapse">
							<ul class="nav navbar-nav">
								<li class="active"><a href="#settings" data-toggle="tab"><!-- ko if: general_errors() --><i class="fa fa-exclamation-circle text-danger hidden" data-bind="css:{'hidden': !general_errors()}"></i> <!-- /ko --><?php echo $tab_settings; ?></a></li>
								<li><a href="#qa_form" data-toggle="tab"><!-- ko if: form_errors() --><i class="fa fa-exclamation-circle text-danger hidden" data-bind="css:{'hidden': !form_errors()}"></i> <!-- /ko --><?php echo $tab_form; ?></a></li>
								<li><a href="#questions" data-toggle="tab"><!-- ko if: qa_errors() --><i class="fa fa-exclamation-circle text-danger hidden" data-bind="css:{'hidden': !qa_errors()}"></i> <!-- /ko --><?php echo $tab_qa; ?></a></li>
								<li><a href="#ext-support" data-toggle="tab"><?php echo $tab_support; ?></a></li>
								<li><a href="#about-ext" data-toggle="tab"><?php echo $tab_about; ?></a></li>
							</ul>
							<div class="nav navbar-nav navbar-right btn-group">
								<?php if ($update_pending) { ?><button type="button" data-toggle="tooltip" data-container="body" data-placement="bottom" title="<?php echo $button_upgrade; ?>" class="btn btn-info" id="btn-upgrade" data-url="<?php echo $upgrade; ?>" data-form="#sForm" data-context="#content" data-overlay="#page-overlay" data-loading-text="<i class='fa fa-spinner fa-spin'></i> <span class='visible-lg-inline visible-xs-inline'><?php echo $text_upgrading; ?></span>"><i class="fa fa-arrow-circle-up"></i> <span class="visible-lg-inline visible-xs-inline"><?php echo $button_upgrade; ?></span></button><?php } ?>
								<button type="button" data-toggle="tooltip" data-container="body" data-placement="bottom" title="<?php echo $button_apply; ?>" class="btn btn-success" id="btn-apply" data-url="<?php echo $save; ?>" data-form="#sForm" data-context="#content" data-vm="ExtVM" data-overlay="#page-overlay" data-loading-text="<i class='fa fa-spinner fa-spin'></i> <span class='visible-lg-inline visible-xs-inline'><?php echo $text_saving; ?></span>"<?php echo $update_pending ? ' disabled': ''; ?>><i class="fa fa-check"></i> <span class="visible-lg-inline visible-xs-inline"><?php echo $button_apply; ?></span></button>
								<button type="submit" data-toggle="tooltip" data-container="body" data-placement="bottom" title="<?php echo $button_save; ?>" class="btn btn-primary" id="btn-save" data-url="<?php echo $save; ?>" data-form="#sForm" data-context="#content" data-overlay="#page-overlay" data-loading-text="<i class='fa fa-spinner fa-spin'></i> <span class='visible-lg-inline visible-xs-inline'><?php echo $text_saving; ?></span>" <?php echo $update_pending ? ' disabled': ''; ?>><i class="fa fa-save"></i> <span class="visible-lg-inline visible-xs-inline"><?php echo $button_save; ?></span></button>
								<a href="<?php echo $cancel; ?>" class="btn btn-default" data-toggle="tooltip" data-container="body" data-placement="bottom" title="<?php echo $button_cancel; ?>" id="btn-cancel" data-loading-text="<i class='fa fa-spinner fa-spin'></i> <span class='visible-lg-inline visible-xs-inline'><?php echo $text_canceling; ?></span>"><i class="fa fa-ban"></i> <span class="visible-lg-inline visible-xs-inline"><?php echo $button_cancel; ?></span></a>
							</div>
						</div>

					</div>
				</nav>
			</div>
		</div>
	</div>

	<div class="alerts">
		<div class="container-fluid" id="alerts">
			<?php foreach ($alerts as $type => $_alerts) { ?>
				<?php foreach ((array)$_alerts as $alert) { ?>
					<?php if ($alert) { ?>
			<div class="alert alert-<?php echo ($type == "error") ? "danger" : $type; ?> fade in">
				<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
				<i class="fa <?php echo $alert_icon($type); ?>"></i><?php echo $alert; ?>
			</div>
					<?php } ?>
				<?php } ?>
			<?php } ?>
		</div>
	</div>

	<div class="container-fluid bull5i-content bull5i-container">
		<div id="page-overlay" class="bull5i-overlay fade in">
			<div class="page-overlay-progress"><i class="fa fa-refresh fa-spin fa-5x text-muted"></i></div>
		</div>

		<form action="<?php echo $save; ?>" method="post" enctype="multipart/form-data" id="sForm" class="form-horizontal" role="form">
			<div class="tab-content">
				<div class="tab-pane active" id="settings">
					<div class="panel panel-default">
						<div class="panel-heading"><h3 class="panel-title"><i class="fa fa-cog fa-fw"></i> <?php echo $tab_settings; ?></h3></div>
						<div class="panel-body">
							<div class="row">
								<div class="col-sm-12">
									<fieldset>
										<div class="form-group">
											<label class="col-sm-3 col-md-2 control-label" for="qa_status"><?php echo $entry_extension_status; ?></label>
											<div class="col-sm-2 fc-auto-width">
												<select name="qa_status" id="qa_status" data-bind="value: status" class="form-control">
													<option value="1"><?php echo $text_enabled; ?></option>
													<option value="0"><?php echo $text_disabled; ?></option>
												</select>
												<input type="hidden" name="qa_installed" value="1" />
												<input type="hidden" name="qa_installed_version" value="<?php echo $installed_version; ?>" />
												<input type="hidden" name="qa_as" data-bind="value: as" />
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-3 col-md-2 control-label" for="qa_dashboard_widget"><?php echo $entry_dashboard_widget; ?></label>
											<div class="col-sm-2 fc-auto-width">
												<select name="qa_dashboard_widget" id="qa_dashboard_widget" data-bind="value: dashboard_widget" class="form-control">
													<option value="1"><?php echo $text_enabled; ?></option>
													<option value="0"><?php echo $text_disabled; ?></option>
												</select>
											</div>
											<div class="col-sm-offset-3 col-md-offset-2 col-sm-9 col-md-10 help-container">
												<span class="help-block help-text"><?php echo $help_dashboard_widget; ?></span>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-3 col-md-2 control-label" for="qa_new_question_notification1"><?php echo $entry_new_question_notification; ?></label>
											<div class="col-sm-9 col-md-10">
												<label class="radio-inline">
													<input type="radio" name="qa_new_question_notification" id="qa_new_question_notification1" value="1" data-bind="checked: new_question_notification"> <?php echo $text_yes; ?>
												</label>
												<label class="radio-inline">
													<input type="radio" name="qa_new_question_notification" id="qa_new_question_notification0" value="0" data-bind="checked: new_question_notification"> <?php echo $text_no; ?>
												</label>
											</div>
											<div class="col-sm-offset-3 col-md-offset-2 col-sm-9 col-md-10 help-container">
												<span class="help-block help-text"><?php echo $help_new_question_notification; ?></span>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-3 col-md-2 control-label" data-bind="attr: {for: 'notification_emails<?php echo $default_language; ?>'}, css: {'has-error': notification_emails.hasError}"><?php echo $entry_notification_emails; ?></label>
											<div class="col-sm-6 col-md-5 col-lg-4">
											<!-- ko foreach: notification_emails -->
												<div data-bind="css: {'multi-row': $index() != 0, 'has-error': email.hasError}">
													<div class="input-group">
														<span class="input-group-addon" data-bind="attr: {title: $root.languages[language_id()].name}"><img data-bind="attr: {src: $root.languages[language_id()].flag, title: $root.languages[language_id()].name}" /></span>
														<input data-bind="attr: {name: 'qa_notification_emails[' + language_id() + ']', id: 'notification_emails' + language_id()}, value: email" class="form-control">
													</div>
												</div>
												<div class="has-error" data-bind="visible: email.hasError && email.errorMsg">
													<span class="help-block" data-bind="text: email.errorMsg"></span>
												</div>
											<!-- /ko -->
											</div>
											<div class="col-sm-offset-3 col-md-offset-2 col-sm-9 col-md-10 help-container">
												<span class="help-block help-text"><?php echo $help_notification_emails; ?></span>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-3 col-md-2 control-label" for="qa_notification_from"><?php echo $entry_notification_email_from; ?></label>
											<div class="col-sm-2 fc-auto-width">
												<select name="qa_notification_from" id="qa_notification_from" data-bind="value: notification_from" class="form-control">
													<option value="0"><?php echo $text_store_email_address; ?></option>
													<option value="1"><?php echo $text_customer_email_address; ?></option>
												</select>
											</div>
											<div class="col-sm-offset-3 col-md-offset-2 col-sm-9 col-md-10 help-container">
												<span class="help-block help-text"><?php echo $help_notification_email_from; ?></span>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-3 col-md-2 control-label" for="qa_question_reply_notification1"><?php echo $entry_question_reply_notification; ?></label>
											<div class="col-sm-9 col-md-10">
												<label class="radio-inline">
													<input type="radio" name="qa_question_reply_notification" id="qa_question_reply_notification1" value="1" data-bind="checked: question_reply_notification"> <?php echo $text_yes; ?>
												</label>
												<label class="radio-inline">
													<input type="radio" name="qa_question_reply_notification" id="qa_question_reply_notification0" value="0" data-bind="checked: question_reply_notification"> <?php echo $text_no; ?>
												</label>
											</div>
											<div class="col-sm-offset-3 col-md-offset-2 col-sm-9 col-md-10 help-container">
												<span class="help-block help-text"><?php echo $help_question_reply_notification; ?></span>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-3 col-md-2 control-label" for="qa_remove_sql_changes0"><?php echo $entry_remove_sql_changes; ?></label>
											<div class="col-sm-9 col-md-10">
												<label class="radio-inline">
													<input type="radio" name="qa_remove_sql_changes" id="qa_remove_sql_changes1" value="1" data-bind="checked: remove_sql_changes"> <?php echo $text_yes; ?>
												</label>
												<label class="radio-inline">
													<input type="radio" name="qa_remove_sql_changes" id="qa_remove_sql_changes0" value="0" data-bind="checked: remove_sql_changes"> <?php echo $text_no; ?>
												</label>
											</div>
											<div class="col-sm-offset-3 col-md-offset-2 col-sm-9 col-md-10 help-container">
												<span class="help-block help-text"><?php echo $help_remove_sql_changes; ?></span>
											</div>
										</div>
										<!-- ko if: _sas() == 1 -->
										<div class="form-group">
											<div class="col-sm-offset-3 col-md-offset-2 col-sm-6 col-md-5 col-lg-4">
												<select class="form-control" data-bind="selectedOptions: _as" multiple>
													<?php foreach ($stores as $store_id => $store) { ?>
													<option value="<?php echo $store_id; ?>"><?php echo $store['name']; ?></option>
													<?php } ?>
												</select>
											</div>
										</div>
										<!-- /ko -->
									</fieldset>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="tab-pane" id="qa_form">
					<div class="panel panel-default">
						<div class="panel-heading"><h3 class="panel-title"><i class="fa fa-cog fa-fw"></i> <?php echo $tab_form; ?></h3></div>
						<div class="panel-body">
							<div class="row">
								<div class="col-sm-12">
									<fieldset>
										<div class="form-group">
											<label class="col-sm-3 col-md-2 control-label" for="qa_form_display_name1"><?php echo $entry_form_display_name; ?></label>
											<div class="col-sm-9 col-md-10">
												<label class="radio-inline">
													<input type="radio" name="qa_form_display_name" id="qa_form_display_name1" value="1" data-bind="checked: form_display_name"> <?php echo $text_yes; ?>
												</label>
												<label class="radio-inline">
													<input type="radio" name="qa_form_display_name" id="qa_form_display_name0" value="0" data-bind="checked: form_display_name"> <?php echo $text_no; ?>
												</label>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-3 col-md-2 control-label" for="qa_form_require_name1"><?php echo $entry_form_require_name; ?></label>
											<div class="col-sm-9 col-md-10">
												<label class="radio-inline">
													<input type="radio" name="qa_form_require_name" id="qa_form_require_name1" value="1" data-bind="checked: form_require_name"> <?php echo $text_yes; ?>
												</label>
												<label class="radio-inline">
													<input type="radio" name="qa_form_require_name" id="qa_form_require_name0" value="0" data-bind="checked: form_require_name"> <?php echo $text_no; ?>
												</label>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-3 col-md-2 control-label" for="qa_form_display_email1"><?php echo $entry_form_display_email; ?></label>
											<div class="col-sm-9 col-md-10">
												<label class="radio-inline">
													<input type="radio" name="qa_form_display_email" id="qa_form_display_email1" value="1" data-bind="checked: form_display_email"> <?php echo $text_yes; ?>
												</label>
												<label class="radio-inline">
													<input type="radio" name="qa_form_display_email" id="qa_form_display_email0" value="0" data-bind="checked: form_display_email"> <?php echo $text_no; ?>
												</label>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-3 col-md-2 control-label" for="qa_form_require_email1"><?php echo $entry_form_require_email; ?></label>
											<div class="col-sm-9 col-md-10">
												<label class="radio-inline">
													<input type="radio" name="qa_form_require_email" id="qa_form_require_email1" value="1" data-bind="checked: form_require_email"> <?php echo $text_yes; ?>
												</label>
												<label class="radio-inline">
													<input type="radio" name="qa_form_require_email" id="qa_form_require_email0" value="0" data-bind="checked: form_require_email"> <?php echo $text_no; ?>
												</label>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-3 col-md-2 control-label" for="qa_form_display_phone1"><?php echo $entry_form_display_phone; ?></label>
											<div class="col-sm-9 col-md-10">
												<label class="radio-inline">
													<input type="radio" name="qa_form_display_phone" id="qa_form_display_phone1" value="1" data-bind="checked: form_display_phone"> <?php echo $text_yes; ?>
												</label>
												<label class="radio-inline">
													<input type="radio" name="qa_form_display_phone" id="qa_form_display_phone0" value="0" data-bind="checked: form_display_phone"> <?php echo $text_no; ?>
												</label>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-3 col-md-2 control-label" for="qa_form_require_phone1"><?php echo $entry_form_require_phone; ?></label>
											<div class="col-sm-9 col-md-10">
												<label class="radio-inline">
													<input type="radio" name="qa_form_require_phone" id="qa_form_require_phone1" value="1" data-bind="checked: form_require_phone"> <?php echo $text_yes; ?>
												</label>
												<label class="radio-inline">
													<input type="radio" name="qa_form_require_phone" id="qa_form_require_phone0" value="0" data-bind="checked: form_require_phone"> <?php echo $text_no; ?>
												</label>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-3 col-md-2 control-label" for="qa_form_display_phone1"><?php echo $entry_form_display_custom; ?></label>
											<div class="col-sm-9 col-md-10">
												<label class="radio-inline">
													<input type="radio" name="qa_form_display_custom_field" id="qa_form_display_custom_field1" value="1" data-bind="checked: form_display_custom_field"> <?php echo $text_yes; ?>
												</label>
												<label class="radio-inline">
													<input type="radio" name="qa_form_display_custom_field" id="qa_form_display_custom_field0" value="0" data-bind="checked: form_display_custom_field"> <?php echo $text_no; ?>
												</label>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-3 col-md-2 control-label" for="qa_form_require_custom_field1"><?php echo $entry_form_require_custom; ?></label>
											<div class="col-sm-9 col-md-10">
												<label class="radio-inline">
													<input type="radio" name="qa_form_require_custom_field" id="qa_form_require_custom_field1" value="1" data-bind="checked: form_require_custom_field"> <?php echo $text_yes; ?>
												</label>
												<label class="radio-inline">
													<input type="radio" name="qa_form_require_custom_field" id="qa_form_require_custom_field0" value="0" data-bind="checked: form_require_custom_field"> <?php echo $text_no; ?>
												</label>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-3 col-md-2 control-label" data-bind="attr: {for: 'custom_field_names<?php echo $default_language; ?>'}, css: {'has-error': form_custom_field_name.hasError}"><?php echo $entry_form_custom_field_name; ?></label>
											<div class="col-sm-6 col-md-5 col-lg-4">
											<!-- ko foreach: form_custom_field_name -->
												<div data-bind="css: {'multi-row': $index() != 0, 'has-error': name.hasError}">
													<div class="input-group">
														<span class="input-group-addon" data-bind="attr: {title: $root.languages[language_id()].name}"><img data-bind="attr: {src: $root.languages[language_id()].flag, title: $root.languages[language_id()].name}" /></span>
														<input data-bind="attr: {name: 'qa_form_custom_field_name[' + language_id() + ']', id: 'custom_field_names' + language_id()}, value: name" class="form-control">
													</div>
												</div>
												<div class="has-error" data-bind="visible: name.hasError && name.errorMsg">
													<span class="help-block" data-bind="text: name.errorMsg"></span>
												</div>
											<!-- /ko -->
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-3 col-md-2 control-label" for="qa_form_display_captcha1"><?php echo $entry_form_display_captcha; ?></label>
											<div class="col-sm-9 col-md-10">
												<label class="radio-inline">
													<input type="radio" name="qa_form_display_captcha" id="qa_form_display_captcha1" value="1" data-bind="checked: form_display_captcha"> <?php echo $text_yes; ?>
												</label>
												<label class="radio-inline">
													<input type="radio" name="qa_form_display_captcha" id="qa_form_display_captcha0" value="0" data-bind="checked: form_display_captcha"> <?php echo $text_no; ?>
												</label>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-3 col-md-2 control-label" for="qa_form_require_captcha1"><?php echo $entry_form_require_captcha; ?></label>
											<div class="col-sm-9 col-md-10">
												<label class="radio-inline">
													<input type="radio" name="qa_form_require_captcha" id="qa_form_require_captcha1" value="1" data-bind="checked: form_require_captcha"> <?php echo $text_yes; ?>
												</label>
												<label class="radio-inline">
													<input type="radio" name="qa_form_require_captcha" id="qa_form_require_captcha0" value="0" data-bind="checked: form_require_captcha"> <?php echo $text_no; ?>
												</label>
											</div>
										</div>
									</fieldset>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="tab-pane" id="questions">
					<div class="panel panel-default">
						<div class="panel-heading"><h3 class="panel-title"><i class="fa fa-cog fa-fw"></i> <?php echo $tab_qa; ?></h3></div>
						<div class="panel-body">
							<div class="row">
								<div class="col-sm-12">
									<fieldset>
										<div class="form-group">
											<label class="col-sm-3 col-md-2 control-label" for="qa_display_questions1"><?php echo $entry_display_questions; ?></label>
											<div class="col-sm-9 col-md-10">
												<label class="radio-inline">
													<input type="radio" name="qa_display_questions" id="qa_display_questions1" value="1" data-bind="checked: display_questions"> <?php echo $text_yes; ?>
												</label>
												<label class="radio-inline">
													<input type="radio" name="qa_display_questions" id="qa_display_questions0" value="0" data-bind="checked: display_questions"> <?php echo $text_no; ?>
												</label>
											</div>
											<div class="col-sm-offset-3 col-md-offset-2 col-sm-9 col-md-10 help-container">
												<span class="help-block help-text"><?php echo $help_display_questions; ?></span>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-3 col-md-2 control-label" for="qa_display_all_languages1"><?php echo $entry_display_all_languages; ?></label>
											<div class="col-sm-9 col-md-10">
												<label class="radio-inline">
													<input type="radio" name="qa_display_all_languages" id="qa_display_all_languages1" value="1" data-bind="checked: display_all_languages"> <?php echo $text_yes; ?>
												</label>
												<label class="radio-inline">
													<input type="radio" name="qa_display_all_languages" id="qa_display_all_languages0" value="0" data-bind="checked: display_all_languages"> <?php echo $text_no; ?>
												</label>
											</div>
											<div class="col-sm-offset-3 col-md-offset-2 col-sm-9 col-md-10 help-container">
												<span class="help-block help-text"><?php echo $help_display_all_languages; ?></span>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-3 col-md-2 control-label" for="qa_new_question_status"><?php echo $entry_new_questions_status; ?></label>
											<div class="col-sm-2 fc-auto-width">
												<select name="qa_new_question_status" id="qa_new_question_status" data-bind="value: new_question_status" class="form-control">
													<option value="1"><?php echo $text_enabled; ?></option>
													<option value="0"><?php echo $text_disabled; ?></option>
												</select>
											</div>
										</div>
										<div class="form-group" data-bind="css: {'has-error': items_per_page.hasError}">
											<label class="col-sm-3 col-md-2 control-label" for="qa_items_per_page"><?php echo $entry_items_per_page; ?></label>
											<div class="col-sm-2 col-md-2 col-lg-1">
												<input type="text" name="qa_items_per_page" id="qa_items_per_page"  data-bind="value: items_per_page" class="form-control" />
											</div>
											<div class="col-sm-offset-3 col-md-offset-2 col-sm-9 col-md-10 error-container" data-bind="visible: items_per_page.hasError && items_per_page.errorMsg">
												<span class="help-block error-text" data-bind="text: items_per_page.errorMsg"></span>
											</div>
											<div class="col-sm-offset-3 col-md-offset-2 col-sm-9 col-md-10 help-container">
												<span class="help-block help-text"><?php echo $help_items_per_page; ?></span>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-3 col-md-2 control-label" for="qa_preload"><?php echo $entry_preload; ?></label>
											<div class="col-sm-2 fc-auto-width">
												<select name="qa_preload" id="qa_preload" data-bind="value: preload" class="form-control">
													<option value="0"><?php echo $text_none; ?></option>
													<option value="1"><?php echo $text_first_page; ?></option>
													<option value="2"><?php echo $text_all; ?></option>
												</select>
											</div>
											<div class="col-sm-offset-3 col-md-offset-2 col-sm-9 col-md-10 help-container">
												<span class="help-block help-text"><?php echo $help_preload; ?></span>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-3 col-md-2 control-label" for="qa_display_question_author1"><?php echo $entry_display_question_author; ?></label>
											<div class="col-sm-9 col-md-10">
												<label class="radio-inline">
													<input type="radio" name="qa_display_question_author" id="qa_display_question_author1" value="1" data-bind="checked: display_question_author"> <?php echo $text_yes; ?>
												</label>
												<label class="radio-inline">
													<input type="radio" name="qa_display_question_author" id="qa_display_question_author0" value="0" data-bind="checked: display_question_author"> <?php echo $text_no; ?>
												</label>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-3 col-md-2 control-label" for="qa_display_question_date1"><?php echo $entry_display_question_date; ?></label>
											<div class="col-sm-9 col-md-10">
												<label class="radio-inline">
													<input type="radio" name="qa_display_question_date" id="qa_display_question_date1" value="1" data-bind="checked: display_question_date"> <?php echo $text_yes; ?>
												</label>
												<label class="radio-inline">
													<input type="radio" name="qa_display_question_date" id="qa_display_question_date0" value="0" data-bind="checked: display_question_date"> <?php echo $text_no; ?>
												</label>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-3 col-md-2 control-label" for="qa_display_answer_author1"><?php echo $entry_display_answer_author; ?></label>
											<div class="col-sm-9 col-md-10">
												<label class="radio-inline">
													<input type="radio" name="qa_display_answer_author" id="qa_display_answer_author1" value="1" data-bind="checked: display_answer_author"> <?php echo $text_yes; ?>
												</label>
												<label class="radio-inline">
													<input type="radio" name="qa_display_answer_author" id="qa_display_answer_author0" value="0" data-bind="checked: display_answer_author"> <?php echo $text_no; ?>
												</label>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-3 col-md-2 control-label" for="qa_display_answer_date1"><?php echo $entry_display_answer_date; ?></label>
											<div class="col-sm-9 col-md-10">
												<label class="radio-inline">
													<input type="radio" name="qa_display_answer_date" id="qa_display_answer_date1" value="1" data-bind="checked: display_answer_date"> <?php echo $text_yes; ?>
												</label>
												<label class="radio-inline">
													<input type="radio" name="qa_display_answer_date" id="qa_display_answer_date0" value="0" data-bind="checked: display_answer_date"> <?php echo $text_no; ?>
												</label>
											</div>
										</div>
									</fieldset>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="tab-pane" id="ext-support">
					<div class="panel panel-default">
						<div class="panel-heading">
							<div class="navbar-header">
								<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#support-navbar-collapse">
									<span class="sr-only"><?php echo $text_toggle_navigation; ?></span>
									<span class="icon-bar"></span>
									<span class="icon-bar"></span>
								</button>
								<h3 class="panel-title"><i class="fa fa-phone fa-fw"></i> <?php echo $tab_support; ?></h3>
							</div>
							<div class="collapse navbar-collapse" id="support-navbar-collapse">
								<ul class="nav navbar-nav">
									<li class="active"><a href="#general" data-toggle="tab"><?php echo $tab_general; ?></a></li>
									<li><a href="#faq" data-toggle="tab" title="<?php echo $text_faq; ?>"><?php echo $tab_faq; ?></a></li>
									<li><a href="#services" data-toggle="tab"><?php echo $tab_services; ?></a></li>
								</ul>
							</div>
						</div>
						<div class="panel-body">
							<div class="tab-content">
								<div class="tab-pane active" id="general">
									<div class="row">
										<div class="col-sm-12">
											<h3>Getting support</h3>
											<p>I consider support a priority of mine, so if you need any help with your purchase you can contact me in one of the following ways:</p>
											<ul>
												<li>Send an email to <a href="mailto:<?php echo $ext_support_email; ?>?subject='<?php echo $text_support_subject; ?>'"><?php echo $ext_support_email; ?></a></li>
												<li>Post in the <a href="<?php echo $ext_support_forum; ?>" target="_blank">extension forum thread</a> or send me a <a href="http://forum.opencart.com/ucp.php?i=pm&mode=compose&u=17771">private message</a></li>
												<!--li><a href="<?php echo $ext_store_url; ?>" target="_blank">Leave a comment</a> in the extension store comments section</li-->
											</ul>
											<p>I usually reply within a few hours, but can take up to 36 hours.</p>
											<p>Please note that all support is free if it is an issue with the product. Only issues due conflicts with other third party extensions/modules or custom front end theme are the exception to free support. Resolving such conflicts, customizing the extension or doing additional bespoke work will be provided with the hourly rate of <span id="hourly_rate">USD 50 / EUR 40</span>.</p>

											<h4>Things to note when asking for help</h4>
											<p>Please describe your problem in as much detail as possible. When contacting, please provide the following information:</p>
											<ul>
												<li>The OpenCart version you are using. <small>This can be found at the bottom of any admin page.</small></li>
												<li>The extension name and version. <small>You can find this information under the About tab.</small></li>
												<li>If you got any error messages, please include them in the message.</li>
												<li>In case the error message is generated by a VQMod cached file, please also attach that file.</li>
											</ul>
											<p>Any additional information that you can provide about the issue is greatly appreciated and will make problem solving much faster.</p>

											<h3 class="page-header">Happy with <?php echo $ext_name; ?>?</h3>
											<p>I would appreciate it very much if you could <a href="<?php echo $ext_store_url; ?>" target="_blank">rate the extension</a> once you've had a chance to try it out. Why not tell everybody how great this extension is by <a href="<?php echo $ext_store_url; ?>" target="_blank">leaving a comment</a> as well.</p>
										</div>
									</div>
									<div class="row">
										<div class="col-sm-6">
											<div class="alert alert-info">
												<p><?php echo $text_other_extensions; ?></p>
											</div>
										</div>
									</div>
								</div>
								<div class="tab-pane" id="faq">
									<h3><?php echo $text_faq; ?></h3>
									<ul class="media-list" id="faqs">
										<li class="media">
											<div class="pull-left">
												<i class="fa fa-question-circle fa-4x media-object"></i>
											</div>
											<div class="media-body">
												<h4 class="media-heading">Why isn't the extension working in store front end?</h4>

												<p class="short-answer">Verify that VQMod is working. If you are using a custom theme please make sure you have properly integrated the extension with your theme. Check for any <a href="#" class="external-tab-link" data-target="#about-ext">license issues</a>.</p>

												<button type="button" class="btn btn-default btn-sm" data-toggle="collapse" data-target="#not_working" data-parent="#faqs">Show the full answer</button>
												<div class="collapse full-answer" id="not_working">
													<p>There may be several causes due to which the extension may not appear to be working in the store front end.</p>

													<ol>
														<li>
															<p>Verify that VQMod is working (for the store front end), proper VQMod cached files are being generated and none of the <?php echo $ext_name; ?> VQMod script files are reporting any errors in the VQMod error log files.</p>
															<p>If VQMod reports errors then these must be addressed. In case proper VQMod cached files are not being generated then VQMod installation needs to be fixed.</p>
														</li>

														<li>
															<p>If you are using a custom theme please make sure you have properly integrated the extension with your theme. See <a href="#theme_integration" role="button" data-toggle="collapse" aria-expanded="false" aria-controls="theme_integration">"How to integrate the extension with a custom theme?"</a> FAQ below.</p>
														</li>

														<li>
															<p>If you have a multi store installation, you need to verify that proper amount of licenses have been purchased. Check the <a href="#" class="external-tab-link" data-target="#about-ext">About tab</a> License section to see whether <?php echo $ext_name; ?> is activated on all of your stores.</p>
															<p>In case <?php echo $ext_name; ?> is inactive on some of your stores, you will need to purchase additional licenses for each inactive store you wish to enable the extension on.</p>
														</li>
													</ol>

													<p>In case none of the above helped you to get the extension working please contact me on the support email given on the <a href="#" class="external-tab-link" data-target="#general">General Support</a> section.</p>
												</div>
											</div>
										</li>
										<li class="media">
											<div class="pull-left">
												<i class="fa fa-question-circle fa-4x media-object"></i>
											</div>
											<div class="media-body">
												<h4 class="media-heading">How to translate the extension to another language?</h4>

												<p class="short-answer">The store front end translatable strings can be found in the <em>vqmod/xml/questions_and_answers.xml</em> VQMod script file and also from <em>catalog/language/english/mail/new_question.php</em> translation file.</p>

												<button type="button" class="btn btn-default btn-sm" data-toggle="collapse" data-target="#translation" data-parent="#faqs">Show the full answer</button>
												<div class="collapse full-answer" id="translation">
													<ol>
														<li>
															<p><strong>Copy</strong> the following language files <strong>to YOUR_LANGUAGE folder</strong> under the appropriate location as shown below:</p>
															<div class="btm-mgn">
																<em class="text-muted"><small>FROM:</small></em>
																<ul class="list-unstyled">
																	<li>admin/language/english/catalog/qa.php</li>
																	<li>admin/language/english/dashboard/qa.php</li>
																	<li>admin/language/english/mail/question_reply.php</li>
																	<li>admin/language/english/module/qa.php</li>
																	<li>catalog/language/english/mail/new_question.php</li>
																</ul>
																<em class="text-muted"><small>TO:</small></em>
																<ul class="list-unstyled">
																	<li>admin/language/YOUR_LANGUAGE/catalog/qa.php</li>
																	<li>admin/language/YOUR_LANGUAGE/dashboard/qa.php</li>
																	<li>admin/language/YOUR_LANGUAGE/mail/question_reply.php</li>
																	<li>admin/language/YOUR_LANGUAGE/module/qa.php</li>
																	<li>catalog/language/YOUR_LANGUAGE/mail/new_question.php</li>
																</ul>
															</div>
														</li>

														<li>
															<p><strong>Open</strong> each of the copied <strong>language files</strong> with a text editor such as <a href="http://www.sublimetext.com/">Sublime Text</a> or <a href="http://notepad-plus-plus.org/">Notepad++</a> and <strong>make the required translations</strong>. You can also leave the files in English.</p>
															<p><span class="label label-info">Note</span> You only need to translate the parts that are to the right of the equal sign.</p>
															<p><span class="label label-danger">Important</span> The <em>admin/language/english/mail/question_reply.php</em> language file needs to be translated to each custom language your store front end uses, because this is used for sending question answer notifications to customers.</p>
														</li>

														<li>
															<p>Some of the translatable strings are located inside the VQMod script file <em>vqmod/xml/questions_and_answers.xml</em>, so <strong>open the XML file</strong> with a text editor (<strong>not</strong> with a word processor application such as MS Word) and <strong>search</strong> for a <em>file</em> block that edits the <em>admin/language/english/common/header.php</em> language file. It should look similar to the following:</p>
															<pre class="prettyprint linenums"><code class="language-xml">    &lt;file name=&quot;admin/language/english/common/header.php&quot;&gt;
                &lt;operation&gt;
                        &lt;search position=&quot;after&quot;&gt;&lt;![CDATA[
                        ?&gt;
                        ]]&gt;&lt;/search&gt;
                        &lt;add&gt;&lt;![CDATA[
$_[&#039;text_qa&#039;]                          = &#039;Q &amp;amp; A&#039;;
                        ]]&gt;&lt;/add&gt;
                &lt;/operation&gt;
        &lt;/file&gt;</code></pre>
														</li>

														<li>
															<p>Make a <strong>copy</strong> of the whole <em>file</em> block, <strong>replace</strong> <em>english</em> with <em>YOUR_LANGUAGE</em> in the file path and <strong>translate the string(s)</strong>. You can also leave the strings in English.</p>

															<p><span class="label label-info">Note</span> If you want to quickly familiarize yourself with the simple <a href="https://github.com/vqmod/vqmod/wiki" target="_blank">VQMod</a> script syntax, please check out the <a href="https://github.com/vqmod/vqmod/wiki/Scripting" target="_blank">official Wiki page</a></p>

															<p>The end result would look similar to the following example:</p>

															<pre class="prettyprint linenums"><code class="language-xml">    &lt;file name=&quot;admin/language/english/common/header.php&quot;&gt;
                &lt;operation&gt;
                        &lt;search position=&quot;after&quot;&gt;&lt;![CDATA[
                        ?&gt;
                        ]]&gt;&lt;/search&gt;
                        &lt;add&gt;&lt;![CDATA[
$_[&#039;text_qa&#039;]                          = &#039;Q &amp;amp; A&#039;;
                        ]]&gt;&lt;/add&gt;
                &lt;/operation&gt;
        &lt;/file&gt;

        &lt;file name=&quot;admin/language/YOUR_LANGUAGE/common/header.php&quot;&gt;
                &lt;operation&gt;
                        &lt;search position=&quot;after&quot;&gt;&lt;![CDATA[
                        ?&gt;
                        ]]&gt;&lt;/search&gt;
                        &lt;add&gt;&lt;![CDATA[
$_[&#039;text_qa&#039;]                          = &#039;YOUR_LANGUAGE_TRANSLATION&#039;;
                        ]]&gt;&lt;/add&gt;
                &lt;/operation&gt;
        &lt;/file&gt;</code></pre>
														</li>

														<li>
															<p>Now, repeat steps <strong>3</strong> and <strong>4</strong> for the blocks that edit the following language files:</p>
															<ul class="list-unstyled">
																<li>admin/language/english/common/home.php</li>
																<li>catalog/language/english/product/product.php</li>
															</ul>
														</li>
													</ol>
												</div>
											</div>
										</li>
										<li class="media">
											<div class="pull-left">
												<i class="fa fa-question-circle fa-4x media-object"></i>
											</div>
											<div class="media-body">
												<h4 class="media-heading">How to integrate the extension with a custom theme?</h4>

												<p class="short-answer">If you are using a custom theme and the extension is not working out of the box then the first thing to do is to make a copy of the <em>vqmod/xml/questions_and_answers_default_theme_patch.xml</em> VQMod script file and change all occurrences of the theme name to point to your custom theme folder.</p>

												<button type="button" class="btn btn-default btn-sm" data-toggle="collapse" data-target="#theme_integration" data-parent="#faqs">Show the full answer</button>
												<div class="collapse full-answer" id="theme_integration">
													<p>In order to integrate the <?php echo $ext_name; ?> extension with your custom theme you need to make a copy of the <em>vqmod/xml/questions_and_answers_default_theme_patch.xml</em> file and give it a different name (eg. <em>questions_and_answers_custom_theme_patch.xml</em>). Then open the copied VQMod file with a text editor such as <a href="http://www.sublimetext.com/">Sublime Text</a> or <a href="http://notepad-plus-plus.org/">Notepad++</a> and change the theme name from 'default' to your custom theme (folder name) for the block that edits the default theme <em>product.tpl</em> template file.</p>
													<p>If changing the theme name does not make it work, then your custom theme template structure must differ in some way from the default theme. In this case you need to further tailor the VQMod search &amp; replace/insert patterns for the <em>product.tpl</em> template file to deal with the structural peculiarities of your custom theme. Please see the comments in the VQMod script file to better understand the meaning of each modification.</p>
													<p>As due to the very nature of a custom theme there does not exist a universal solution. A custom theme may have a different way of displaying things. Take a look at the changes made to the default theme and work out adjustments to the search &amp; replace patterns to suit your theme.</p>
													<p>If you do not know how the VQMod script works, I kindly suggest you read about it from the VQMod <a href="https://github.com/vqmod/vqmod/wiki" target="_blank">wiki pages</a>. VQMod log files (<em>vqmod/logs/*.log</em>) are helpful for debugging. They will tell you where the script fails (meaning which VQMod search line it does not find in the referenced file), so you need to adjust that part of the script.</p>
													<p>If you would like to change the way questions and answers are displayed on the product page you should copy <em>catalog/view/theme/default/template/product/qa.tpl</em> template file to <em>catalog/view/theme/<strong>YOUR_CUSTOM_THEME_FOLDER_NAME</strong>/template/product/qa.tpl</em> and make changes to that file.</p>
													<p>Should you find yourself in trouble with the changes I can offer commercial custom theme integration service. Please refer to the <a href="#" class="external-tab-link" data-target="#services">Services</a> section.</p>
												</div>
											</div>
										</li>
										<li class="media">
											<div class="pull-left">
												<i class="fa fa-question-circle fa-4x media-object"></i>
											</div>
											<div class="media-body">
												<h4 class="media-heading">How to upgrade the extension?</h4>
												<p class="short-answer">Back up your system, disable the extension, overwrite the current extension files with new ones and click Upgrade on the extension settings page. After upgrade is complete enable the extension again.</p>

												<button type="button" class="btn btn-default btn-sm" data-toggle="collapse" data-target="#upgrade" data-parent="#faqs">Show the full answer</button>
												<div class="collapse full-answer" id="upgrade">
													<ol>
														<li>
															<p><strong>Back up your system</strong> before making any upgrades or changes.</p>
															<p><span class="label label-info">Note</span> Although <?php echo $ext_name; ?> does not overwrite any OpenCart core files, it is always a good practice to create a system backup before making any changes to the system.</p>
														</li>
														<li><strong>Disable</strong> <?php echo $ext_name; ?> <strong>extension</strong> on the module settings page (<em>Extensions > Modules > <?php echo $ext_name; ?></em>) by changing <em>Extension status</em> setting to "Disabled".</li>

														<li>
															<p><strong>Upload</strong> the <strong>extension archive</strong> <em>ProductQA-x.x.x.ocmod.zip</em> using the <a href="<?php echo $extension_installer; ?>" target="_blank">Extension Installer</a>.</p>
															<p><span class="label label-info">Note</span> Do not worry, no OpenCart core files will be replaced! Only the previously installed <?php echo $ext_name; ?> files will be overwritten.</p>
															<p><span class="label label-danger">Important</span> If you have done custom modifications to the extension (for example customized it for your theme) then back up the modified files and re-apply the modifications after upgrade. To see which files have changed, please take a look at the <a href="#" class="external-tab-link" data-target="#changelog,#about-ext">Changelog</a>.</p>
														</li>

														<li>
															<p><strong>Open</strong> the <?php echo $ext_name; ?> <strong>module settings page</strong> <small>(<em>Extensions > Modules > <?php echo $ext_name; ?></em>)</small> and <strong>refresh the page</strong> by pressing <em>Ctrl + F5</em> twice to force the browser to update the css changes.</p>
														</li>

														<li><p>You should see a notice stating that new version of extension files have been found. <strong>Upgrade the extension</strong> by clicking on the 'Upgrade' button.</p></li>

														<li>After the extension has been successfully upgraded <strong>enable the extension</strong> by changing <em>Extension status</em> setting to "Enabled".</li>
													</ol>
												</div>
											</div>
										</li>
									</ul>
								</div>
								<div class="tab-pane" id="services">
									<h3>Premium Services<button type="button" class="btn btn-default btn-sm pull-right" data-toggle="tooltip" data-container="body" data-placement="bottom" title="<?php echo $button_refresh; ?>" id="btn-refresh-services" data-loading-text="<i class='fa fa-refresh fa-spin'></i> <span class='visible-lg-inline visible-xs-inline'><?php echo $text_loading; ?></span>"><i class="fa fa-refresh"></i> <span class="visible-lg-inline visible-xs-inline"><?php echo $button_refresh; ?></span></button></h3>
									<div id="service-container">
										<p data-bind="visible: service_list_loading()">Loading service list ... <i class="fa fa-refresh fa-spin"></i></p>
										<p data-bind="visible: service_list_loaded() && services().length == 0">There are currently no available services for this extension.</p>
										<table class="table table-hover">
											<tbody data-bind="foreach: services">
												<tr class="srvc">
													<td>
														<h4 class="service" data-bind="html: name"></h4>
														<span class="help-block">
															<p class="description" data-bind="visible: description != '', html: description"></p>
															<p data-bind="visible: turnaround != ''"><strong>Turnaround time</strong>: <span class="turnaround" data-bind="html: turnaround"></span></p>
															<span class="hidden code" data-bind="html: code"></span>
														</span>
													</td>
													<td class="nowrap text-right top-pad"><span class="currency" data-bind="html: currency"></span> <span class="price" data-bind="html: price"></span></td>
													<td class="text-right"><button type="button" class="btn btn-sm btn-primary purchase"><i class="fa fa-shopping-cart"></i> Buy Now</button></td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="tab-pane" id="about-ext">
					<div class="panel panel-default">
						<div class="panel-heading">
							<div class="navbar-header">
								<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#about-navbar-collapse">
									<span class="sr-only"><?php echo $text_toggle_navigation; ?></span>
									<span class="icon-bar"></span>
									<span class="icon-bar"></span>
								</button>
								<h3 class="panel-title"><i class="fa fa-info fa-fw"></i> <?php echo $tab_about; ?></h3>
							</div>
							<div class="collapse navbar-collapse" id="about-navbar-collapse">
								<ul class="nav navbar-nav">
									<li class="active"><a href="#ext_info" data-toggle="tab"><?php echo $tab_extension; ?></a></li>
									<li><a href="#changelog" data-toggle="tab"><?php echo $tab_changelog; ?></a></li>
								</ul>
							</div>
						</div>
						<div class="panel-body">
							<div class="tab-content">
								<div class="tab-pane active" id="ext_info">
									<div class="row">
										<div class="col-sm-12">
											<h3><?php echo $text_extension_information; ?></h3>

											<div class="form-group">
												<label class="col-sm-3 col-md-2 control-label label-normal"><?php echo $entry_extension_name; ?></label>
												<div class="col-sm-9 col-md-10">
													<p class="form-control-static"><?php echo $ext_name; ?></p>
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-3 col-md-2 control-label label-normal"><?php echo $entry_installed_version; ?></label>
												<div class="col-sm-9 col-md-10">
													<p class="form-control-static"><strong><?php echo $installed_version; ?></strong></p>
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-3 col-md-2 control-label label-normal"><?php echo $entry_extension_compatibility; ?></label>
												<div class="col-sm-9 col-md-10">
													<p class="form-control-static"><?php echo $ext_compatibility; ?></p>
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-3 col-md-2 control-label label-normal"><?php echo $entry_extension_store_url; ?></label>
												<div class="col-sm-9 col-md-10">
													<p class="form-control-static"><a href="<?php echo $ext_store_url; ?>" target="_blank"><?php echo htmlspecialchars($ext_store_url); ?></a></p>
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-3 col-md-2 control-label label-normal"><?php echo $entry_copyright_notice; ?></label>
												<div class="col-sm-9 col-md-10">
													<p class="form-control-static">&copy; 2011 - <?php echo date("Y"); ?> Romi Agar</p>
												</div>
											</div>
											<div class="form-group">
												<div class="col-sm-offset-3 col-sm-9 col-md-offset-2 col-md-10">
													<p class="form-control-static"><a href="#legal_text" id="legal_notice" data-toggle="modal"><?php echo $text_terms; ?></a></p>
												</div>
											</div>

											<h3 class="page-header"><?php echo $text_license; ?></h3>
											<p><?php echo $text_license_text; ?></p>

											<div class="form-group has-success">
												<label class="col-sm-3 col-md-2 control-label"><?php echo $entry_active_on; ?></label>
												<div class="col-sm-9 col-md-10">
													<p class="form-control-static" data-bind="text: asn"></p>
												</div>
											</div>
											<div class="form-group has-error" data-bind="visible: iasn() != ''">
												<label class="col-sm-3 col-md-2 control-label"><?php echo $entry_inactive_on; ?></label>
												<div class="col-sm-9 col-md-10">
													<p class="form-control-static" data-bind="text: iasn"></p>
												</div>
												<div class="col-sm-offset-3 col-md-offset-2 col-sm-9 col-md-10 error-container">
													<span class="help-block error-text"><?php echo $help_purchase_additional_licenses; ?></span>
													<a href="<?php echo $ext_purchase_url; ?>" class="btn btn-sm btn-danger" target="_blank"><i class="fa fa-shopping-cart"></i> <?php echo $button_purchase_license; ?></a>
												</div>
											</div>
										</div>
									</div>
								</div>
								<div class="tab-pane" id="changelog">
									<div class="row">
										<div class="col-sm-12">
											<div class="release">
												<h3>Version 1.8.6 <small class="release-date text-muted">06 Mar 2016</small></h3>

												<blockquote>
													<ul class="list-unstyled">
														<li><em class="text-success">Fixed:</em> Support for OpenCart 2.2.0.0</li>
													</ul>

													<h4><i class="fa fa-pencil text-primary"></i> Files changed:</h4>

													<ul>
														<li>admin/controller/catalog/qa.php</li>
														<li>admin/controller/dashboard/qa.php</li>
														<li>admin/controller/module/qa.php</li>
														<li>admin/model/catalog/qa.php</li>
														<li>admin/model/module/qa.php</li>
														<li>admin/language/english/module/qa.php</li>
														<li>admin/view/javascript/qa/custom.min.js</li>
														<li>admin/view/stylesheet/qa/css/custom.min.css</li>
														<li>admin/view/template/module/qa.tpl</li>
														<li>catalog/model/catalog/qa.php</li>
														<li>vqmod/xml/questions_and_answers.xml</li>
														<li>vqmod/xml/questions_and_answers_default_theme_patch.xml</li>
													</ul>

													<h4><i class="fa fa-plus text-success"></i> Files added:</h4>

													<ul>
														<li>admin/language/en-gb/catalog/qa.php</li>
														<li>admin/language/en-gb/dashboard/qa.php</li>
														<li>admin/language/en-gb/mail/question_reply.php</li>
														<li>admin/language/en-gb/module/qa.php</li>
														<li>catalog/language/en-gb/mail/new_question.php</li>
													</ul>

												</blockquote>
											</div>

											<div class="release">
												<h3>Version 1.8.5 <small class="release-date text-muted">26 Oct 2015</small></h3>

												<blockquote>
													<ul class="list-unstyled">
														<li><em class="text-success">Fixed:</em> Captcha check causes validation error for OpenCart 2.0.2+</li>
														<li><em class="text-success">Fixed:</em> Dashboard widget generates errors if extension has not been installed</li>
													</ul>

													<h4><i class="fa fa-pencil text-primary"></i> Files changed:</h4>

													<ul>
														<li>admin/controller/dashboard/qa.php</li>
														<li>admin/controller/module/qa.php</li>
														<li>admin/view/template/module/qa.tpl</li>
														<li>vqmod/xml/questions_and_answers.xml</li>
														<li>vqmod/xml/questions_and_answers_default_theme_patch.xml</li>
													</ul>
												</blockquote>
											</div>

											<div class="release">
												<h3>Version 1.8.4 <small class="release-date text-muted">01 Oct 2015</small></h3>

												<blockquote>
													<ul class="list-unstyled">
														<li><em class="text-success">Fixed:</em> E-mail notifications for OpenCart 2.0.3+</li>
														<li><em class="text-success">Fixed:</em> OpenCart 2.1.0.x support</li>
													</ul>

													<h4><i class="fa fa-pencil text-primary"></i> Files changed:</h4>

													<ul>
														<li>admin/controller/catalog/qa.php</li>
														<li>admin/controller/module/qa.php</li>
														<li>admin/view/stylesheet/qa/css/custom.min.css</li>
														<li>admin/view/template/module/qa.tpl</li>
														<li>catalog/model/catalog/qa.php</li>
														<li>vqmod/xml/questions_and_answers.xml</li>
														<li>vqmod/xml/questions_and_answers_default_theme_patch.xml</li>
													</ul>
												</blockquote>
											</div>

											<div class="release">
												<h3>Version 1.8.3 <small class="release-date text-muted">30 Aug 2015</small></h3>

												<blockquote>
													<ul class="list-unstyled">
														<li><em class="text-info">Changed:</em> Moved theme integration into separate VQMod</li>
														<li><em class="text-info">Changed:</em> Some code refactoring and UI improvements</li>
													</ul>

													<h4><i class="fa fa-pencil text-primary"></i> Files changed:</h4>

													<ul>
														<li>admin/controller/module/qa.php</li>
														<li>admin/language/english/module/qa.php</li>
														<li>admin/view/javascript/qa/custom.min.js</li>
														<li>admin/view/template/module/qa.tpl</li>
														<li>system/helper/qa.php</li>
														<li>vqmod/xml/questions_and_answers.xml</li>
													</ul>

													<h4><i class="fa fa-plus text-success"></i> Files added:</h4>

													<ul>
														<li>vqmod/xml/questions_and_answers_default_theme_patch.xml</li>
													</ul>
												</blockquote>
											</div>

											<div class="release">
												<h3>Version 1.8.2 <small class="release-date text-muted">14 May 2015</small></h3>

												<blockquote>
													<ul class="list-unstyled">
														<li><em class="text-success">Fixed:</em> Question and answer content escaping</li>
														<li><em class="text-success">Fixed:</em> Undefined variable notice</li>
														<li><em class="text-info">Changed:</em> Minor UI changes</li>
													</ul>

													<h4><i class="fa fa-pencil text-primary"></i> Files changed:</h4>

													<ul>
														<li>admin/controller/catalog/qa.php</li>
														<li>admin/controller/module/qa.php</li>
														<li>admin/language/english/catalog/qa.php</li>
														<li>admin/language/english/module/qa.php</li>
														<li>admin/view/javascript/qa/custom.min.js</li>
														<li>admin/view/stylesheet/qa/css/custom.min.css</li>
														<li>admin/view/template/catalog/qa_form.tpl</li>
														<li>admin/view/template/catalog/qa_list.tpl</li>
														<li>admin/view/template/module/qa.tpl</li>
														<li>system/helper/qa.php</li>
														<li>vqmod/xml/questions_and_answers.xml</li>
													</ul>
												</blockquote>
											</div>

											<div class="release">
												<h3>Version 1.8.1 <small class="release-date text-muted">01 Apr 2015</small></h3>

												<blockquote>
													<ul class="list-unstyled">
														<li><em class="text-success">Fixed:</em> Compatibility with OpenCart 2.0.2.x</li>
													</ul>

													<h4><i class="fa fa-pencil text-primary"></i> Files changed:</h4>

													<ul>
														<li>admin/controller/catalog/qa.php</li>
														<li>admin/controller/module/qa.php</li>
														<li>admin/language/english/module/qa.php</li>
														<li>admin/view/template/module/qa.tpl</li>
														<li>catalog/model/catalog/qa.php</li>
														<li>vqmod/xml/questions_and_answers.xml</li>
													</ul>
												</blockquote>
											</div>

											<div class="release">
												<h3>Version 1.8.0 <small class="release-date text-muted">19 Dec 2014</small></h3>

												<blockquote>
													<ul class="list-unstyled">
														<li><em class="text-primary">New:</em> Q&amp;A dashboard widget showing total number of questions and recent change</li>
														<li><em class="text-success">Fixed:</em> Q&amp;A incorrectly displayed as a module on the layouts page</li>
														<li><em class="text-success">Fixed:</em> E-mail notifications</li>
														<li><em class="text-success">Fixed:</em> Question submission validation on some setting combinations</li>
													</ul>

													<h4><i class="fa fa-pencil text-primary"></i> Files changed:</h4>

													<ul>
														<li>admin/controller/catalog/qa.php</li>
														<li>admin/controller/module/qa.php</li>
														<li>admin/language/english/catalog/qa.php</li>
														<li>admin/language/english/module/qa.php</li>
														<li>admin/model/module/qa.php</li>
														<li>admin/view/javascript/qa/custom.min.js</li>
														<li>admin/view/stylesheet/qa/css/custom.min.css</li>
														<li>admin/view/template/catalog/qa_form.tpl</li>
														<li>admin/view/template/catalog/qa_list.tpl</li>
														<li>admin/view/template/module/qa.tpl</li>
														<li>catalog/model/catalog/qa.php</li>
														<li>vqmod/xml/questions_and_answers.xml</li>
													</ul>

													<h4><i class="fa fa-plus text-success"></i> Files added:</h4>

													<ul>
														<li>admin/controller/dashboard/qa.php</li>
														<li>admin/language/english/dashboard/qa.php</li>
														<li>admin/view/template/dashboard/qa.tpl</li>
													</ul>
												</blockquote>
											</div>

											<div class="release">
												<h3>Version 1.7.5 <small class="release-date text-muted">03 Oct 2014</small></h3>

												<blockquote>
													<ul class="list-unstyled">
														<li><em class="text-success">Fixed:</em> Question filtering in the admin panel</li>
													</ul>

													<h4><i class="fa fa-pencil text-primary"></i> Files changed:</h4>

													<ul>
														<li>admin/controller/module/qa.php</li>
														<li>admin/model/catalog/qa.php</li>
														<li>admin/view/template/module/qa.tpl</li>
														<li>vqmod/xml/questions_and_answers.xml</li>
													</ul>
												</blockquote>
											</div>

											<div class="release">
												<h3>Version 1.7.4 <small class="release-date text-muted">15 Apr 2014</small></h3>

												<blockquote>
													<ul class="list-unstyled">
														<li><em class="text-success">Fixed:</em> Popup display on admin Q &amp; A list page</li>
														<li><em class="text-primary">New:</em> Changelog on module settings page under About tab</li>
													</ul>

													<h4><i class="fa fa-pencil text-primary"></i> Files changed:</h4>

													<ul>
														<li>admin/controller/catalog/qa.php</li>
														<li>admin/controller/module/qa.php</li>
														<li>admin/language/english/module/qa.php</li>
														<li>admin/model/module/qa.php</li>
														<li>admin/view/template/catalog/qa_form.tpl</li>
														<li>admin/view/template/catalog/qa_list.tpl</li>
														<li>admin/view/template/module/qa.tpl</li>
														<li>vqmod/xml/questions_and_answers.xml</li>
													</ul>
												</blockquote>
											</div>

											<div class="release">
												<h3>Version 1.7.3 <small class="release-date text-muted">04 Feb 2014</small></h3>

												<blockquote>
													<ul class="list-unstyled">
														<li><em class="text-success">Fixed:</em> Autocomplete not working on PHP versions &lt; 5.4.0</li>
													</ul>

													<h4><i class="fa fa-pencil text-primary"></i> Files changed:</h4>

													<ul>
														<li>admin/controller/module/qa.php</li>
														<li>system/helper/qa.php</li>
														<li>vqmod/xml/questions_and_answers.xml</li>
													</ul>
												</blockquote>
											</div>

											<div class="release">
												<h3>Version 1.7.2 <small class="release-date text-muted">01 Feb 2014</small></h3>

												<blockquote>
													<ul class="list-unstyled">
														<li><em class="text-success">Fixed:</em> Captcha validation fails even if not required</li>
													</ul>

													<h4><i class="fa fa-pencil text-primary"></i> Files changed:</h4>

													<ul>
														<li>admin/controller/module/qa.php</li>
														<li>vqmod/xml/questions_and_answers.xml</li>
													</ul>
												</blockquote>
											</div>

											<div class="release">
												<h3>Version 1.7.1 <small class="release-date text-muted">31 Jan 2014</small></h3>

												<blockquote>
													<ul class="list-unstyled">
														<li><em class="text-success">Fixed:</em> Multiple identical alerts displayed in admin</li>
														<li><em class="text-success">Fixed:</em> Database upgrade when upgrading from version &lt; 1.7.0</li>
													</ul>

													<h4><i class="fa fa-pencil text-primary"></i> Files changed:</h4>

													<ul>
														<li>admin/controller/catalog/qa.php</li>
														<li>admin/controller/module/qa.php</li>
														<li>admin/model/catalog/qa.php</li>
														<li>vqmod/xml/questions_and_answers.xml</li>
													</ul>
												</blockquote>
											</div>

											<div class="release">
												<h3>Version 1.7.0 <small class="release-date text-muted">28 Jan 2014</small></h3>

												<blockquote>
													<ul class="list-unstyled">
														<li><em class="text-primary">New:</em> Revamped module admin interface</li>
														<li><em class="text-primary">New:</em> Configurable question fields</li>
														<li><em class="text-primary">New:</em> Optional phone and a custom field</li>
														<li><em class="text-primary">New:</em> Multi-store support</li>
														<li><em class="text-primary">New:</em> Customer language based notification addresses</li>
														<li><em class="text-primary">New:</em> Option to receive new question notification from customer email address</li>
													</ul>

													<h4><i class="fa fa-pencil text-primary"></i> Files changed:</h4>

													<ul>
														<li>admin/controller/catalog/qa.php</li>
														<li>admin/controller/module/qa.php</li>
														<li>admin/language/english/catalog/qa.php</li>
														<li>admin/language/english/mail/question_reply.php</li>
														<li>admin/language/english/module/qa.php</li>
														<li>admin/model/catalog/qa.php</li>
														<li>admin/view/static/bull5i_qa_extension_terms.htm</li>
														<li>admin/view/template/catalog/qa_form.tpl</li>
														<li>admin/view/template/catalog/qa_list.tpl</li>
														<li>admin/view/template/module/qa.tpl</li>
														<li>catalog/language/english/mail/new_question.php</li>
														<li>catalog/model/catalog/qa.php</li>
														<li>catalog/view/theme/default/template/mail/new_question.tpl</li>
														<li>catalog/view/theme/default/template/product/qa.tpl</li>
														<li>vqmod/xml/questions_and_answers.xml</li>
													</ul>

													<h4><i class="fa fa-plus text-success"></i> Files added:</h4>

													<ul>
														<li>admin/model/module/qa.php</li>
														<li>admin/view/javascript/qa/*</li>
														<li>admin/view/stylesheet/qa/*</li>
														<li>catalog/view/theme/default/stylesheet/qa.css</li>
														<li>system/helper/qa.php</li>
													</ul>

													<h4><i class="fa fa-minus text-danger"></i> Files removed:</h4>

													<ul>
														<li>admin/view/image/qa/*</li>
														<li>admin/view/static/bull5i_qa_extension_help.htm</li>
													</ul>
												</blockquote>
											</div>

											<div class="release">
												<h3>Version 1.6.0 <small class="release-date text-muted">07 Apr 2013</small></h3>

												<blockquote>
													<ul class="list-unstyled">
														<li><em class="text-primary">New:</em> Option to display questions in all languages or only current language</li>
														<li><em class="text-success">Fixed:</em> HTML support in customer notification emails</li>
														<li><em class="text-success">Fixed:</em> Store logo display in emails</li>
													</ul>

													<h4><i class="fa fa-pencil text-primary"></i> Files changed:</h4>

													<ul>
														<li>admin/controller/catalog/qa.php</li>
														<li>admin/controller/module/qa.php</li>
														<li>admin/language/english/catalog/qa.php</li>
														<li>admin/language/english/module/qa.php</li>
														<li>admin/model/catalog/qa.php</li>
														<li>admin/view/template/catalog/qa_form.tpl</li>
														<li>admin/view/template/catalog/qa_list.tpl</li>
														<li>admin/view/template/module/qa.tpl</li>
														<li>catalog/model/catalog/qa.php</li>
														<li>vqmod/xml/questions_and_answers.xml</li>
													</ul>
												</blockquote>
											</div>

											<div class="release">
												<h3>Version 1.5.0 <small class="release-date text-muted">14 Mar 2012</small></h3>

												<blockquote>
													<ul class="list-unstyled">
														<li><em class="text-primary">New:</em> HTML is allowed in question answers</li>
													</ul>

													<h4><i class="fa fa-pencil text-primary"></i> Files changed:</h4>

													<ul>
														<li>admin/controller/module/qa.php</li>
														<li>admin/model/catalog/qa.php</li>
														<li>vqmod/xml/questions_and_answers.xml</li>
													</ul>
												</blockquote>
											</div>

											<div class="release">
												<h3>Version 1.4.2 <small class="release-date text-muted">14 Mar 2012</small></h3>

												<blockquote>
													<ul class="list-unstyled">
														<li><em class="text-success">Fixed:</em> Email validation when no reply was needed</li>
													</ul>

													<h4><i class="fa fa-pencil text-primary"></i> Files changed:</h4>

													<ul>
														<li>admin/controller/module/qa.php</li>
														<li>vqmod/xml/questions_and_answers.xml</li>
													</ul>
												</blockquote>
											</div>

											<div class="release">
												<h3>Version 1.4.1 <small class="release-date text-muted">17 Nov 2011</small></h3>

												<blockquote>
													<ul class="list-unstyled">
														<li><em class="text-success">Fixed:</em> Links to the shop in customer notification emails</li>
													</ul>
												</blockquote>
											</div>

											<div class="release">
												<h3>Version 1.4.0 <small class="release-date text-muted">15 Nov 2011</small></h3>

												<blockquote>
													<ul class="list-unstyled">
														<li><em class="text-primary">New:</em> Option to configure the number of questions displayed per page</li>
														<li><em class="text-primary">New:</em> Option to improve SEO by preloading first page or all questions without AJAX</li>
													</ul>
												</blockquote>
											</div>

											<div class="release">
												<h3>Version 1.3.2 <small class="release-date text-muted">30 Sep 2011</small></h3>

												<blockquote>
													<ul class="list-unstyled">
														<li><em class="text-success">Fixed:</em> Minor bugs</li>
													</ul>
												</blockquote>
											</div>

											<div class="release">
												<h3>Version 1.3.1 <small class="release-date text-muted">16 Sep 2011</small></h3>

												<blockquote>
													<ul class="list-unstyled">
														<li><em class="text-success">Fixed:</em> Error messages when extension was not installed, but core files were modified</li>
														<li><em class="text-primary">New:</em> First VQMod release</li>
													</ul>
												</blockquote>
											</div>

											<div class="release">
												<h3>Version 1.3.0 <small class="release-date text-muted">28 Jul 2011</small></h3>

												<blockquote>
													<ul class="list-unstyled">
														<li><em class="text-primary">New:</em> Customer notification email when question has been answered</li>
													</ul>
												</blockquote>
											</div>

											<div class="release">
												<h3>Version 1.2.0 <small class="release-date text-muted">22 Apr 2011</small></h3>

												<blockquote>
													<ul class="list-unstyled">
														<li><em class="text-primary">New:</em> New question notification email</li>
														<li><em class="text-primary">New:</em> Easier installation</li>
													</ul>
												</blockquote>
											</div>

											<div class="release">
												<h3>Version 1.1.0 <small class="release-date text-muted">23 Jan 2011</small></h3>

												<blockquote>
													<ul class="list-unstyled">
														<li><em class="text-primary">New:</em> Configuration options</li>
													</ul>
												</blockquote>
											</div>

											<div class="release">
												<h3>Version 1.0.0 <small class="release-date text-muted">22 Jan 2011</small></h3>

												<blockquote>
													<ul class="list-unstyled">
														<li>Initial release</li>
													</ul>
												</blockquote>
											</div>

										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
</div>
<script type="text/javascript"><!--
!function(e,o,a){var r,t=<?php echo json_encode($errors); ?>,s=<?php echo json_encode($languages); ?>,i=<?php echo json_encode($qa_notification_emails); ?>,n=<?php echo json_encode($qa_form_custom_field_name); ?>,_=<?php echo json_encode($stores); ?>;e.texts=o.extend({},e.texts,{error_ajax_request:"<?php echo addslashes($error_ajax_request); ?>",error_email:"<?php echo addslashes($error_email); ?>",error_custom_field_name:"<?php echo addslashes($error_custom_field_name); ?>",error_positive_integer:"<?php echo addslashes($error_positive_integer); ?>"}),e.load_service_list=function(e){var e=e!==a?1*e:0,t=o.Deferred();return r.service_list_loaded()&&!e||r.service_list_loading()?t.reject():(r.service_list_loading(!0),o.when(o.ajax({url:"<?php echo $services; ?>",data:{force:e},dataType:"json"})).then(function(e){r.service_list_loaded(!0),r.service_list_loading(!1),r.clearServices(),e.services&&o.each(e.services,function(e,o){var a=o.code,t=o.name,s=o.description||"",i=o.currency,n=o.price,_=o.turnaround;r.addService(a,t,s,i,n,_)}),e.rate&&o("#hourly_rate").html(e.rate),t.resolve()},function(e,o,a){r.service_list_loaded(!0),r.service_list_loading(!1),t.reject(),window.console&&window.console.log&&window.console.log("Failed to load services list: "+a)})),t.promise()};var h=function(e){isNaN(parseInt(e))||parseInt(e)<0?(this.target.hasError(!0),this.target.errorMsg(this.message)):(this.target.hasError(!1),this.target.errorMsg(""))},c=function(e){var o=new RegExp("^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$");!parseInt(this.root.new_question_notification())||o.test(e)?(this.target.hasError(!1),this.target.errorMsg("")):(this.target.hasError(!0),this.target.errorMsg(this.message))},l=function(e){!parseInt(this.root.form_display_custom_field())||e?(this.target.hasError(!1),this.target.errorMsg("")):(this.target.hasError(!0),this.target.errorMsg(this.message))},p=function(e,o,a,r,t,s){this.code=e,this.name=o,this.description=a,this.currency=r,this.price=t,this.turnaround=s},d=function(e,o,a){this.id=e,this.name=o,this.flag=a},u=function(o,a,r){var t=this;this.language_id=ko.observable(o),this.email=ko.observable(a).extend({validate:{message:e.texts.error_email,context:t,method:c,root:r}}),this.validate=function(){for(var e in t)ko.isObservable(t[e])&&"function"==typeof t[e].validate&&t[e].validate(t[e]())}};u.prototype=new e.observable_object_methods;var m=function(o,a,r){var t=this;this.language_id=ko.observable(o),this.name=ko.observable(a).extend({validate:{message:e.texts.error_custom_field_name,context:t,method:l,root:r}}),this.validate=function(){for(var e in t)ko.isObservable(t[e])&&"function"==typeof t[e].validate&&t[e].validate(t[e]())}};m.prototype=new e.observable_object_methods;var f=function(){var a=this,r={},t={};this.languages={},o.each(s,function(e,o){a.languages[e]=new d(o.language_id,o.name,(o.hasOwnProperty("image")&&o.image)?"view/image/flags/"+o.image:"language/"+o.code+"/"+o.code+".png")}),this.default_language="<?php echo $default_language; ?>",o.each(a.languages,function(e,o){r[o.id]=i.hasOwnProperty(o.id)?{email:i[o.id]}:{email:""},t[o.id]=n.hasOwnProperty(o.id)?{name:n[o.id]}:{name:""}}),this.status=ko.observable("<?php echo $qa_status; ?>"),this.dashboard_widget=ko.observable("<?php echo $qa_dashboard_widget; ?>"),this.new_question_notification=ko.observable("<?php echo $qa_new_question_notification; ?>"),this.notification_emails=ko.observableArray(o.map(r,function(e,o){return new u(o,e.hasOwnProperty("email")?e.email:"",a)})).withIndex("language_id").extend({hasError:{check:!0,context:a},applyErrors:{context:a},checkErrors:{context:a}}),this.notification_from=ko.observable("<?php echo $qa_notification_from; ?>"),this.question_reply_notification=ko.observable("<?php echo $qa_question_reply_notification; ?>"),this.remove_sql_changes=ko.observable("<?php echo $qa_remove_sql_changes; ?>"),this._sas=ko.observable(0),this._as=ko.observableArray(JSON.parse(atob("<?php echo $qa_as; ?>"))),this.as=ko.computed(function(){return btoa(JSON.stringify(a._as()))}),this.asn=ko.computed(function(){var e=[];return ko.utils.arrayForEach(a._as(),function(o){_.hasOwnProperty(o)&&e.push(_[o].name)}),e.join(", ")}),this.iasn=ko.computed(function(){var e=[];return o.map(_,function(o,r){-1==a._as().indexOf(r.toString())&&e.push(o.name)}),e.join(", ")}),this.general_errors=ko.computed(function(){return a.notification_emails.hasError()}),this.new_question_notification.subscribe(function(){a.notification_emails.checkErrors()}),this.form_display_name=ko.observable("<?php echo $qa_form_display_name; ?>"),this.form_require_name=ko.observable("<?php echo $qa_form_require_name; ?>"),this.form_display_email=ko.observable("<?php echo $qa_form_display_email; ?>"),this.form_require_email=ko.observable("<?php echo $qa_form_require_email; ?>"),this.form_display_phone=ko.observable("<?php echo $qa_form_display_phone; ?>"),this.form_require_phone=ko.observable("<?php echo $qa_form_require_phone; ?>"),this.form_display_custom_field=ko.observable("<?php echo $qa_form_display_custom_field; ?>"),this.form_require_custom_field=ko.observable("<?php echo $qa_form_require_custom_field; ?>"),this.form_custom_field_name=ko.observableArray(o.map(t,function(e,o){return new m(o,e.hasOwnProperty("name")?e.name:"",a)})).withIndex("language_id").extend({hasError:{check:!0,context:a},applyErrors:{context:a},checkErrors:{context:a}}),this.form_display_captcha=ko.observable("<?php echo $qa_form_display_captcha; ?>"),this.form_require_captcha=ko.observable("<?php echo $qa_form_require_captcha; ?>"),this.form_errors=ko.computed(function(){return a.form_custom_field_name.hasError()}),this.form_display_custom_field.subscribe(function(){a.form_custom_field_name.checkErrors()}),this.display_questions=ko.observable("<?php echo $qa_display_questions; ?>"),this.display_all_languages=ko.observable("<?php echo $qa_display_all_languages; ?>"),this.new_question_status=ko.observable("<?php echo $qa_new_question_status; ?>"),this.items_per_page=ko.observable("<?php echo (int)$qa_items_per_page; ?>").extend({numeric:{precision:0,context:a},validate:{message:e.texts.error_positive_integer,context:a,method:h}}),this.preload=ko.observable("<?php echo $qa_preload; ?>"),this.display_question_author=ko.observable("<?php echo $qa_display_question_author; ?>"),this.display_question_date=ko.observable("<?php echo $qa_display_question_date; ?>"),this.display_answer_author=ko.observable("<?php echo $qa_display_answer_author; ?>"),this.display_answer_date=ko.observable("<?php echo $qa_display_answer_date; ?>"),this.qa_errors=ko.computed(function(){return a.items_per_page.hasError()}),a.service_list_loaded=ko.observable(!1),a.service_list_loading=ko.observable(!1),a.services=ko.observableArray([]),a.addService=function(e,o,r,t,s,i){a.services.push(new p(e,o,r,t,s,i))},a.clearServices=function(){a.services.removeAll()},this.checkErrors=function(){for(var e in a)ko.isObservable(a[e])&&"function"==typeof a[e].checkErrors&&a[e].checkErrors()}};f.prototype=new e.observable_object_methods,o(function(){var a=window.location.hash,s=a.split("?")[0];r=e.view_model=new f,e.view_models=o.extend({},e.view_models,{ExtVM:e.view_model}),r.checkErrors(),r.applyErrors(t),ko.applyBindings(r,o("#content")[0]),o("#legal_text .modal-body").load("view/static/bull5i_qa_extension_terms.htm"),o("body").on("shown.bs.tab","a[data-toggle='tab'][href='#ext-support'],a[data-toggle='tab'][href='#services']",function(){e.load_service_list()}).on("keydown","#qa_status",function(e){if(e.altKey&&e.shiftKey&&e.ctrlKey&&83==e.keyCode){var o=ko.dataFor(this);o._sas(0==o._sas()?1:0)}}),e.onComplete(o("#page-overlay"),o("#content")).done(function(){e.activateTab(s)})})}(window.bull5i=window.bull5i||{},jQuery);
//--></script>
<?php echo $footer; ?>
