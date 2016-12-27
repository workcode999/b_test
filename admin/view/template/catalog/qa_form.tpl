<?php echo $header; ?><?php echo $column_left; ?>
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
							<div class="nav navbar-nav navbar-right btn-group">
								<button type="button" class="btn btn-success" data-toggle="tooltip" data-container="body" data-placement="bottom" title="<?php echo $button_apply; ?>" data-url="<?php echo $save; ?>" id="btn-apply" data-form="#qa-form" data-context="#content" data-overlay="#page-overlay" data-vm="QAVM" data-loading-text="<i class='fa fa-spinner fa-spin'></i> <span class='visible-lg-inline visible-xs-inline'><?php echo $text_saving; ?></span>"><i class="fa fa-check"></i> <span class="visible-lg-inline visible-xs-inline"><?php echo $button_apply; ?></span></button>
								<button type="button" class="btn btn-primary" data-toggle="tooltip" data-container="body" data-placement="bottom" title="<?php echo $button_save; ?>" data-url="<?php echo $save; ?>" id="btn-save" data-form="#qa-form" data-context="#content" data-overlay="#page-overlay" data-loading-text="<i class='fa fa-spinner fa-spin'></i> <span class='visible-lg-inline visible-xs-inline'><?php echo $text_saving; ?></span>"><i class="fa fa-save"></i> <span class="visible-lg-inline visible-xs-inline"><?php echo $button_save; ?></span></button>
								<a href="<?php echo $cancel; ?>" class="btn btn-default" data-toggle="tooltip" data-container="body" data-placement="bottom" title="<?php echo $button_cancel; ?>" id="btn-cancel" data-loading-text="<i class='fa fa-spinner fa-spin'></i> <span class='visible-lg-inline visible-xs-inline'><?php echo $text_canceling; ?></span>"><i class="fa fa-ban"></i> <span class="visible-lg-inline visible-xs-inline"><?php echo $button_cancel; ?></span></a>
								<?php if ($qa_id && $delete) { ?><a href="<?php echo $delete; ?>" class="btn btn-danger btn-nav-link" data-toggle="tooltip" data-container="body" data-placement="bottom" title="<?php echo $button_delete; ?>" id="btn-delete" data-loading-text="<i class='fa fa-spinner fa-spin'></i> <span class='visible-lg-inline visible-xs-inline'><?php echo $text_deleting; ?></span>"><i class="fa fa-trash-o"></i> <span class="visible-lg-inline"><?php echo $button_delete; ?></span></a><?php } ?>
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

		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_form; ?></h3>
			</div>
			<div class="panel-body">

				<form action="<?php echo $save; ?>" method="post" enctype="multipart/form-data" id="qa-form" class="form-horizontal" role="form">
					<fieldset>
						<!-- ko if: qa_id -->
						<div class="row">
							<div class="col-sm-12 col-lg-6">
								<div class="form-group">
									<label class="col-sm-3 col-md-2 col-lg-4 control-label" for="inputID"><?php echo $entry_id; ?></label>
									<div class="col-sm-2 col-md-1 col-lg-3">
										<p class="form-control-static" data-bind="text: qa_id" id="inputID"></p>
										<input type="hidden" name="qa_id" data-bind="value: qa_id">
										<input type="hidden" name="store_id" value="<?php echo $store_id; ?>">
									</div>
								</div>
							</div>
							<div class="col-sm-12 col-lg-6">
								<div class="form-group">
									<label class="col-sm-3 col-md-2 col-lg-4 control-label" for="inputDateModified"><?php echo $entry_date_modified; ?></label>
									<div class="col-sm-3 col-md-4 col-lg-8">
										<p class="form-control-static" data-bind="text: date_modified_formatted" id="inputDateModified"></p>
										<input type="hidden" name="date_modified" data-bind="value: date_modified">
									</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12 col-lg-6">
								<div class="form-group">
									<label class="col-sm-3 col-md-2 col-lg-4 control-label" for="inputDateAsked"><?php echo $entry_date_asked; ?></label>
									<div class="col-sm-3 col-md-4 col-lg-6">
										<p class="form-control-static" data-bind="text: date_asked_formatted" id="inputDateAsked"></p>
										<input type="hidden" name="date_asked" data-bind="value: date_asked">
									</div>
								</div>
							</div>
							<div class="col-sm-12 col-lg-6">
								<div class="form-group">
									<label class="col-sm-3 col-md-2 col-lg-4 control-label" for="inputDateAnswered"><?php echo $entry_date_answered; ?></label>
									<div class="col-sm-3 col-md-4 col-lg-8">
										<p class="form-control-static" data-bind="text: date_answered_formatted" id="inputDateAnswered"></p>
										<input type="hidden" name="date_answered" data-bind="value: date_answered">
									</div>
								</div>
							</div>
						</div>
						<!-- /ko -->
						<!-- ko ifnot: qa_id -->
						<input type="hidden" name="date_asked" data-bind="value: date_asked">
						<!-- /ko -->
						<div class="row">
							<div class="col-sm-12 col-lg-6 col-lg-push-6">
								<!-- ko if: qa_id -->
								<div class="form-group">
									<div class="col-sm-offset-3 col-sm-3 col-md-offset-2 col-md-4 col-lg-offset-4 col-lg-8">
										<div class="checkbox">
											<label for="inputUpdateQuestionAnsweredDate">
												<input type="checkbox" name="update_date_answered" value="1" id="inputUpdateQuestionAnsweredDate" data-bind="checked: update_date_answered"> <?php echo $entry_update_date_answered; ?>
											</label>
										</div>
									</div>
								</div>
								<!-- /ko -->
							</div>
							<div class="col-sm-12 col-lg-6 col-lg-pull-6">
								<div class="form-group has-feedback" data-bind="css: {'has-success': product_id(), 'has-warning': !product_id() && product(), 'has-error': product.hasError}">
									<label class="col-sm-3 col-md-2 col-lg-4 control-label required" data-bind="attr: {for: 'product'}"><?php echo $entry_product; ?></label>
									<div class="col-sm-6 col-md-5 col-lg-4">
										<input data-bind="attr: {name: 'product_name', id: 'product'}" class="form-control typeahead product" placeholder="<?php echo $text_autocomplete; ?>" autocomplete="off">
										<!-- ko if: !product.hasError() && product_id() -->
										<span class="fa fa-check form-control-feedback"></span>
										<!-- /ko -->
										<!-- ko if: !product.hasError() && !product_id() && product() -->
										<span class="fa fa-warning form-control-feedback"></span>
										<!-- /ko -->
										<!-- ko if: product.hasError() -->
										<span class="fa fa-times form-control-feedback"></span>
										<!-- /ko -->
										<input type="hidden" data-bind="attr: {name: 'product_id'}, value: product_id">
										<input type="hidden" data-bind="attr: {name: 'product'}, value: product">
									</div>
									<div class="col-sm-offset-3 col-md-offset-2 col-lg-offset-4 col-sm-9 col-md-10 col-lg-8 error-container" data-bind="visible: product.hasError && product.errorMsg">
										<span class="help-block error-text" data-bind="text: product.errorMsg"></span>
									</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12 col-lg-6">
								<div class="form-group">
									<label class="col-sm-3 col-md-2 col-lg-4 control-label" for="selectStatus"><?php echo $entry_status; ?></label>
									<div class="col-sm-3 col-md-2 col-lg-4">
										<select name="status" id="selectStatus" data-bind="value: status" class="form-control">
											<option value="1"><?php echo $text_enabled; ?></option>
											<option value="0"><?php echo $text_disabled; ?></option>
										</select>
									</div>
								</div>
							</div>
							<!-- ko ifnot: multistore -->
							<div class="col-sm-12 col-lg-6">
								<div class="form-group">
									<div class="col-sm-offset-3 col-sm-3 col-md-offset-2 col-md-4 col-lg-offset-4 col-lg-8">
										<div class="checkbox">
											<label for="inputNotifyCustomer">
												<input type="checkbox" name="notify_customer" value="1" id="inputNotifyCustomer" data-bind="checked: notify_customer"> <?php echo $entry_notify; ?>
											</label>
											<span class="help-block"><?php echo $help_notify; ?></span>
										</div>
									</div>
								</div>
							</div>
							<!-- /ko -->
						</div>
						<!-- ko if: multistore -->
						<div class="row">
							<div class="col-sm-12 col-lg-6">
								<div class="form-group">
									<label class="col-sm-3 col-md-2 col-lg-4 control-label" for="selectStore"><?php echo $entry_stores; ?></label>
									<div class="col-sm-4 col-lg-6">
										<select name="question_stores[]" id="selectStore" class="form-control" data-bind="selectedOptions: question_stores" multiple>
											<?php foreach ($stores as $store_id => $store) { ?>
											<option value="<?php echo $store_id; ?>"><?php echo $store['name']; ?></option>
											<?php } ?>
										</select>
									</div>
								</div>
							</div>
							<div class="col-sm-12 col-lg-6">
								<div class="form-group">
									<div class="col-sm-offset-3 col-sm-9 col-md-offset-2 col-md-10 col-lg-offset-4 col-lg-8">
										<div class="checkbox">
											<label for="inputNotifyCustomer">
												<input type="checkbox" name="notify_customer" value="1" id="inputNotifyCustomer" data-bind="checked: notify_customer"> <?php echo $entry_notify; ?>
											</label>
											<span class="help-block"><?php echo $help_notify; ?></span>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- /ko -->
						<!-- ko ifnot: multistore -->
						<!-- ko foreach: question_stores -->
						<input type="hidden" name="question_stores[]" data-bind="value: $data" />
						<!-- /ko -->
						<!-- /ko -->
					</fieldset>
					<fieldset>
						<legend><?php echo $text_question; ?></legend>
						<!-- ko if: language_count > 1 -->
						<div class="row">
							<div class="col-sm-12">
								<div class="form-group">
									<label class="col-sm-3 col-md-2 control-label" for="inputLanguage"><?php echo $entry_language; ?></label>
									<div class="col-sm-3 col-md-3 fc-auto-width">
										<select name="language_id" id="selectLanguage" data-bind="value: language_id" class="form-control">
											<?php foreach ($languages as $lang_id => $language) { ?>
											<option value="<?php echo $lang_id; ?>"><?php echo $language['name']; ?></option>
											<?php } ?>
										</select>
									</div>
								</div>
							</div>
						</div>
						<!-- /ko -->
						<!-- ko if: language_count == 1 -->
						<input type="hidden" name="language_id" data-bind="value: language_id">
						<!-- /ko -->
						<div class="row">
							<div class="col-sm-12 col-lg-6">
								<div class="form-group">
									<label class="col-sm-3 col-md-2 col-lg-4 control-label" for="inputQuestionAuthorName"><?php echo $entry_author_name; ?></label>
									<div class="col-sm-3 col-md-2 col-lg-4">
										<input type="text" name="question_author_name" class="form-control" data-bind="value: question_author_name" id="inputQuestionAuthorName">
									</div>
								</div>
							</div>
							<div class="col-sm-12 col-lg-6">
								<div class="form-group has-feedback" data-bind="css: {'has-success': customer_id()}">
									<label class="col-sm-3 col-md-2 col-lg-4 control-label" for="inputCustomer"><?php echo $entry_customer; ?></label>
									<div class="col-sm-3 col-lg-6">
										<input data-bind="attr: {name: 'customer_name', id: 'inputCustomer'}" class="form-control typeahead customer" placeholder="<?php echo $text_autocomplete; ?>" autocomplete="off">
										<!-- ko if: customer_id() -->
										<span class="fa fa-check form-control-feedback"></span>
										<!-- /ko -->
										<input type="hidden" data-bind="attr: {name: 'customer_id'}, value: customer_id">
									</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12">
								<div class="form-group has-feedback" data-bind="css: {'has-error': question_author_email.hasError}">
									<label class="col-sm-3 col-md-2 control-label" for="inputQuestionAuthorEmail"><?php echo $entry_email; ?></label>
									<div class="col-sm-4 col-md-3">
										<input type="text" name="question_author_email" class="form-control" data-bind="value: question_author_email" id="inputQuestionAuthorEmail">
										<!-- ko if: question_author_email.hasError -->
										<span class="fa fa-times form-control-feedback"></span>
										<!-- /ko -->
									</div>
									<div class="col-sm-offset-3 col-md-offset-2 col-sm-9 col-md-10 error-container" data-bind="visible: question_author_email.hasError && question_author_email.errorMsg">
										<span class="help-block error-text" data-bind="text: question_author_email.errorMsg"></span>
									</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12">
								<div class="form-group">
									<label class="col-sm-3 col-md-2 control-label" for="inputQuestionAuthorPhone"><?php echo $entry_phone; ?></label>
									<div class="col-sm-3 col-md-2">
										<input type="text" name="question_author_phone" class="form-control" data-bind="value: question_author_phone" id="inputQuestionAuthorPhone">
									</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12">
								<div class="form-group">
									<label class="col-sm-3 col-md-2 control-label" for="inputQuestionAuthorCustom"><?php echo $entry_custom; ?></label>
									<div class="col-sm-4 col-md-3">
										<input type="text" name="question_author_custom" class="form-control" data-bind="value: question_author_custom" id="inputQuestionAuthorCustom">
									</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12">
								<div class="form-group" data-bind="css: {'has-error': question.hasError}">
									<label class="col-sm-3 col-md-2 control-label input-required" for="inputQuestion"><?php echo $entry_question; ?></label>
									<div class="col-sm-9 col-md-10">
										<textarea name="question" id="inputQuestion" data-bind="summernote: {height: 200}, value: question" class="form-control" rows="4"></textarea>
									</div>
									<div class="col-sm-offset-3 col-md-offset-2 col-sm-9 col-md-10 error-container" data-bind="visible: question.hasError && question.errorMsg">
										<span class="help-block error-text" data-bind="text: question.errorMsg"></span>
									</div>
								</div>
							</div>
						</div>
					</fieldset>
					<fieldset>
						<legend><?php echo $text_answer; ?></legend>
						<div class="row">
							<div class="col-sm-12">
								<div class="form-group">
									<label class="col-sm-3 col-md-2 control-label" for="inputAnswerAuthorName"><?php echo $entry_author_name; ?></label>
									<div class="col-sm-3 col-md-2">
										<input type="text" name="answer_author_name" class="form-control" data-bind="value: answer_author_name" id="inputAnswerAuthorName">
									</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12">
								<div class="form-group">
									<label class="col-sm-3 col-md-2 control-label" for="inputAnswer"><?php echo $entry_answer; ?></label>
									<div class="col-sm-9 col-md-10">
										<textarea name="answer" id="inputAnswer" data-bind="summernote: {height: 200}, value: answer"class="form-control" rows="4"></textarea>
									</div>
								</div>
							</div>
						</div>
					</fieldset>
				</form>

			</div>
		</div>
	</div>
</div>
<script type="text/javascript"><!--
(function(bull5i,$,undefined){
var question_stores=<?php echo json_encode($question_stores); ?>,errors=<?php echo json_encode($errors); ?>;bull5i.texts=$.extend({},bull5i.texts,{error_ajax_request:"<?php echo addslashes($error_ajax_request); ?>",error_email:"<?php echo addslashes($error_email); ?>"});var validateEmail=function(e){var o=new RegExp("^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$");!e||o.test(e)?(this.target.hasError(!1),this.target.errorMsg("")):(this.target.hasError(!0),this.target.errorMsg(this.message))},QAViewModel=function(){var e=this;this.language_count=parseInt("<?php echo count($languages); ?>"),this.qa_id=ko.observable("<?php echo $qa_id; ?>"),this.product_id=ko.observable("<?php echo $product_id; ?>"),this.product=ko.observable("<?php echo addslashes(html_entity_decode($product)); ?>").extend({validate:{context:e}}),this.date_modified_formatted=ko.observable("<?php echo $date_modified_formatted; ?>"),this.date_modified=ko.observable("<?php echo $date_modified; ?>"),this.date_asked_formatted=ko.observable("<?php echo $date_asked_formatted; ?>"),this.date_asked=ko.observable("<?php echo $date_asked; ?>"),this.date_answered_formatted=ko.observable("<?php echo $date_answered_formatted; ?>"),this.date_answered=ko.observable("<?php echo $date_answered; ?>"),this.update_date_answered=ko.observable(parseInt("<?php echo (int)$update_date_answered; ?>")),this.status=ko.observable("<?php echo $status; ?>"),this.multistore=ko.observable("<?php echo $multistore; ?>"),this.question_stores=ko.observableArray(question_stores),this.notify_customer=ko.observable(parseInt("<?php echo (int)$notify_customer; ?>")),this.language_id=ko.observable("<?php echo $language_id; ?>"),this.question_author_name=ko.observable("<?php echo $question_author_name; ?>"),this.customer_id=ko.observable("<?php echo $customer_id; ?>"),this.customer_name=ko.observable("<?php echo $customer_name; ?>"),this.question_author_email=ko.observable("<?php echo $question_author_email; ?>").extend({validate:{message:bull5i.texts.error_email,context:e,method:validateEmail,root:parent}}),this.question_author_phone=ko.observable("<?php echo $question_author_phone; ?>"),this.question_author_custom=ko.observable("<?php echo $question_author_custom; ?>"),this.question=ko.observable("<?php echo addslashes(replace_nl2br(html_entity_decode($question))); ?>").extend({validate:{context:e}}),this.answer_author_name=ko.observable("<?php echo $answer_author_name; ?>"),this.answer=ko.observable("<?php echo addslashes(replace_nl2br(html_entity_decode($answer))); ?>")};QAViewModel.prototype=new bull5i.observable_object_methods;var QAVM=bull5i.view_model=new QAViewModel;bull5i.view_models=$.extend({},bull5i.view_models,{QAVM:bull5i.view_model}),QAVM.applyErrors(errors),ko.applyBindings(QAVM,$("#qa-form")[0]);
<?php foreach ($typeahead as $type => $attr) { switch ($type) { case 'product': ?>var product_source=new Bloodhound({<?php if (isset($attr['prefetch'])) { ?>prefetch:'<?php echo $attr['prefetch']; ?>',<?php }; if (isset($attr['remote'])) { ?>remote:'<?php echo $attr['remote']; ?>',<?php } ?>datumTokenizer:Bloodhound.tokenizers.obj.whitespace('value'),queryTokenizer:Bloodhound.tokenizers.whitespace,dupDetector:function(remoteMatch,localMatch){return remoteMatch.id&&localMatch.id&&remoteMatch.id==localMatch.id;},limit:10,});product_source.initialize();$('.<?php echo $type; ?>.typeahead').typeahead({autoselect:true,hint:true,highlight:true,},{name:'<?php echo $type; ?>',source:product_source.ttAdapter(),templates:{empty:['<div class="tt-no-suggestion"><?php echo addslashes($text_no_records_found); ?></div>'].join('\n'),suggestion:Handlebars.compile('<p><span class="tt-nowrap">{{value}}<span class="tt-secondary-right">{{model}}</span></span></p>')}}).on('typeahead:selected typeahead:autocompleted',function(e,datum,name){var mvvm=ko.dataFor(this);mvvm.product_id(datum.id);mvvm.product(datum.value);}).on('typeahead:closed blur',function(){var mvvm=ko.dataFor(this),ta_value=$(this).typeahead('val');if(ta_value==''){mvvm.product_id('');mvvm.product('');}else if(ta_value!=mvvm.product()){mvvm.product_id('');}});$('.<?php echo $type; ?>.typeahead.tt-input').typeahead('val',QAVM.product());<?php break; case 'customer': ?>var customer_source=new Bloodhound({<?php if (isset($attr['prefetch'])) { ?>prefetch:'<?php echo $attr['prefetch']; ?>',<?php }; if (isset($attr['remote'])) { ?>remote:'<?php echo $attr['remote']; ?>',<?php } ?>datumTokenizer:Bloodhound.tokenizers.obj.whitespace('value'),queryTokenizer:Bloodhound.tokenizers.whitespace,dupDetector:function(remoteMatch,localMatch){return remoteMatch.id&&localMatch.id&&remoteMatch.id==localMatch.id;},limit:10,});customer_source.initialize();$('.<?php echo $type; ?>.typeahead').typeahead({hint:true,highlight:true,},{name:'<?php echo $type; ?>',source:customer_source.ttAdapter(),templates:{empty:['<div class="tt-no-suggestion"><?php echo addslashes($text_no_records_found); ?></div>'].join('\n'),suggestion:Handlebars.compile('<p><span class="tt-nowrap"><strong>{{value}}</strong><em class="tt-secondary-right">({{email}})</em></span></p>')}}).on('typeahead:selected typeahead:autocompleted',function(e,datum,name){var mvvm=ko.dataFor(this);mvvm.customer_id(datum.id);mvvm.customer_name(datum.value);mvvm.question_author_name(datum.value);mvvm.question_author_email(datum.email);mvvm.question_author_phone(datum.phone);}).on('typeahead:closed blur',function(){var mvvm=ko.dataFor(this),ta_value=$(this).typeahead('val');if(ta_value==''){mvvm.customer_id('');mvvm.customer_name('');}else if(ta_value!=mvvm.customer_name()){mvvm.customer_id('');}});$('.<?php echo $type; ?>.typeahead.tt-input').typeahead('val',QAVM.customer_name());<?php break; default: break; } } ?>
bull5i.onComplete($("#page-overlay"), $("#content"));
}(window.bull5i=window.bull5i||{},jQuery));
//--></script>
<?php echo $footer; ?>
