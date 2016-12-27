<?php echo $header; ?>
<!-- confirm deletion -->
<div class="modal fade" id="confirmDelete" tabindex="-1" role="dialog" aria-labelledby="confirmDeleteLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="confirmDeleteLabel"><?php echo $text_confirm_delete; ?></h4>
			</div>
			<div class="modal-body">
				<p><?php echo $text_are_you_sure; ?></p>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-ban"></i> <?php echo $button_cancel; ?></button>
				<button type="button" class="btn btn-danger delete"><i class="fa fa-trash-o"></i> <?php echo $button_delete; ?></button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
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
							<div class="nav navbar-nav navbar-right">
								<div class="nav navbar-nav navbar-form" id="nav-filter">
									<div class="form-group search-form">
										<label for="global-search" class="sr-only"><?php echo $text_search;?></label>
										<div class="search">
											<div class="input-group">
												<input type="text" name="search" class="form-control" placeholder="<?php echo $text_search;?>" id="global-search" value="<?php echo $search; ?>">
												<span class="input-group-btn">
													<button type="button" class="btn btn-default" data-toggle="tooltip" data-container="body" data-placement="bottom" title="<?php echo $text_search; ?>" id="global-search-btn"><i class="fa fa-search fa-fw"></i></button>
													<?php if ($search) { ?><button type="button" class="btn btn-default" data-toggle="tooltip" data-container="body" data-placement="bottom" title="<?php echo $text_clear_search; ?>" id="clear-global-search-btn"><i class="fa fa-times fa-fw"></i></button><?php } ?>
												</span>
											</div>
										</div>
									</div>
									<?php if ($multilingual) { ?>
									<div class="form-group">
										<select id="selectLanguage" name="filter_language" class="form-control" data-toggle="tooltip" data-original-title="<?php echo $text_display_language; ?>" data-placement="bottom">
											<option value=""<?php echo (!isset($filters['language']) || $filters['language'] == '') ? ' selected="selected"' : ''; ?>><?php echo $text_all_languages; ?></option>
											<?php foreach ($languages as $lang) { ?>
											<option value="<?php echo $lang['language_id']; ?>"<?php echo (isset($filters['language']) && $filters['language'] == $lang['language_id']) ? ' selected="selected"' : ''; ?>><?php echo $lang['name']; ?></option>
											<?php } ?>
										</select>
									</div>
									<?php } ?>
								</div>
								<div class="nav navbar-nav navbar-btn btn-group">
									<button type="button" class="btn btn-primary" data-toggle="tooltip" data-container="body" data-placement="bottom" title="<?php echo $button_add; ?>" data-url="<?php echo $add; ?>" id="btn-insert" data-form="#qa-list-form" data-context="#content" data-overlay="#page-overlay"><i class="fa fa-plus"></i> <span class="visible-lg-inline visible-xs-inline"><?php echo $button_add; ?></span></button>
									<button type="button" class="btn btn-default" data-toggle="tooltip" data-container="body" data-placement="bottom" title="<?php echo $button_copy; ?>" data-url="<?php echo $copy; ?>" id="btn-copy" data-form="#qa-list-form" data-context="#content" data-overlay="#page-overlay" data-loading-text="<i class='fa fa-spinner fa-spin'></i> <span class='visible-lg-inline visible-xs-inline'><?php echo $text_copying; ?></span>" disabled><i class="fa fa-files-o"></i> <span class="visible-lg-inline visible-xs-inline"><?php echo $button_copy; ?></span></button>
									<button type="button" class="btn btn-danger" data-toggle="tooltip" data-container="body" data-placement="bottom" title="<?php echo $button_delete; ?>" data-url="<?php echo $delete; ?>" id="btn-delete" data-form="#qa-list-form" data-context="#content" data-overlay="#page-overlay" data-loading-text="<i class='fa fa-spinner fa-spin'></i> <span class='visible-lg-inline visible-xs-inline'><?php echo $text_deleting; ?></span>" disabled><i class="fa fa-trash-o"></i> <span class="visible-lg-inline visible-xs-inline"><?php echo $button_delete; ?></span></button>
								</div>
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
				<h3 class="panel-title"><i class="fa fa-list"></i> <?php echo $text_list; ?></h3>
			</div>
			<div class="panel-body">
				<form method="post" enctype="multipart/form-data" id="qa-list-form" class="form-horizontal" role="form">
					<fieldset>
						<div class="table-responsive">
							<table class="table table-bordered table-condensed table-striped table-list table-hover">
								<thead>
									<tr>
										<?php foreach ($columns as $column => $attr) {
										 switch($column) {
											case 'selector': ?>
										<th class="<?php echo $attr['align']; ?> <?php echo $attr['class']; ?> col_<?php echo $column; ?>" width="1"><input type="checkbox" id="master-selector" /></th>
											<?php break;
											default: ?>
											<?php if (!empty($attr['sort'])) { ?>
										<th class="<?php echo $attr['align']; ?> <?php echo $attr['class']; ?> col_<?php echo $column; ?>"><a href="<?php echo $sorts[$column]; ?>"><?php echo $attr['name']; ?><?php echo ($sort == $attr['sort']) ? ' <i class="fa fa-sort-' . strtolower($order) . '"></i>' : ''; ?></a></th>
											<?php } else { ?>
										<th class="<?php echo $attr['align']; ?> <?php echo $attr['class']; ?> col_<?php echo $column; ?>"><?php echo $attr['name']; ?></th>
											<?php } ?>
											<?php break;
										 } ?>
										<?php } ?>
									</tr>
									<tr class="filters">
										<?php foreach ($columns as $column => $attr) {
										 switch($column) {
											case 'selector': ?>
										<td></td>
											<?php break;
											case 'status': ?>
										<td class="<?php echo $attr['align']; ?> <?php echo $attr['class']; ?>">
											<select name="filter_<?php echo $column; ?>" class="form-control input-sm fltr <?php echo $column; ?>" data-column="<?php echo $column; ?>">
												<option value=""<?php echo (!isset($filters[$column]) || $filters[$column] == '') ? ' selected' : ''; ?>></option>
												<option value="1"<?php echo (isset($filters[$column]) && $filters[$column] == '1') ? ' selected' : ''; ?>><?php echo $text_enabled; ?></option>
												<option value="0"<?php echo (isset($filters[$column]) && $filters[$column] == '0') ? ' selected' : ''; ?>><?php echo $text_disabled; ?></option>
											</select>
										</td>
											<?php break;
											case 'action': ?>
										<td class="<?php echo $attr['align']; ?> <?php echo $attr['class']; ?>">
											<div class="btn-group">
												<button type="button" class="btn btn-sm btn-default" id="filter" data-toggle="tooltip" title="<?php echo $text_filter; ?>"><i class="fa fa-filter fa-fw"></i></button>
												<button type="button" class="btn btn-sm btn-default" id="clear-filter" data-toggle="tooltip" title="<?php echo $text_clear_filter; ?>"><i class="fa fa-times fa-fw"></i></button>
											</div>
										</td>
											<?php break;
											case 'store': ?>
										<td class="<?php echo $attr['align']; ?> <?php echo $attr['class']; ?>">
											<select name="filter_<?php echo $column; ?>" class="form-control input-sm fltr <?php echo $column; ?>" data-column="<?php echo $column; ?>">
												<option value=""<?php echo (!isset($filters[$column]) || $filters[$column] == '') ? ' selected' : ''; ?>></option>
												<option value="*"<?php echo (isset($filters[$column]) && $filters[$column] == '*') ? ' selected' : ''; ?>><?php echo $text_none; ?></option>
												<?php foreach ($stores as $s) { ?>
												<option value="<?php echo $s['store_id']; ?>"<?php echo (isset($filters[$column]) && $filters[$column] == $s['store_id']) ? ' selected' : ''; ?>><?php echo $s['name']; ?></option>
												<?php } ?>
											</select>
										</td>
											<?php break;
											case 'product': ?>
										<td class="<?php echo $attr['align']; ?> <?php echo $attr['class']; ?>"><input type="text" name="filter_<?php echo $column; ?>" value="<?php echo isset($filters[$column]) ? $filters[$column] : ''; ?>" class="form-control input-sm fltr <?php echo $column; ?> typeahead" placeholder="<?php echo $text_autocomplete; ?>" data-column="<?php echo $column; ?>"></td>
											<?php break;
											default: ?>
										<td class="<?php echo $attr['align']; ?> <?php echo $attr['class']; ?>"><input type="text" name="filter_<?php echo $column; ?>" value="<?php echo isset($filters[$column]) ? $filters[$column] : ''; ?>" class="form-control input-sm fltr <?php echo $column; ?>" data-column="<?php echo $column; ?>"></td>
											<?php break;
										 } ?>
										<?php } ?>
									</tr>
								</thead>
								<tbody>
									<?php if ($questions) { ?>
										<?php foreach ($questions as $q) { ?>
									<tr>
											<?php foreach ($columns as $column => $attr) {
												switch($column) {
													case 'selector': ?>
										<td class="<?php echo $attr['align']; ?> <?php echo $attr['class']; ?>"><input type="checkbox" name="selected[]" value="<?php echo $q['qa_id']; ?>"<?php echo ($q['selected']) ? ' checked' : ''; ?> /></td>
											<?php break;
													case 'status': ?>
										<td class="<?php echo $attr['align']; ?> <?php echo $attr['class']; ?>"><span class="label label-<?php echo $q['status_class'];?>"><?php echo $q[$column]; ?></span></td>
											<?php break;
													case 'question_author_name': ?>
										<td class="<?php echo $attr['align']; ?> <?php echo $attr['class']; ?>">
											<?php if ($q['customer_id']) { ?>
											<a href="<?php echo $customer . $q['customer_name']; ?>"><?php echo $q[$column]; ?></a>
											<?php } else { ?>
											<?php echo $q[$column]; ?>
											<?php } ?>
											<?php if ($q['author_details']) { ?>
											<button type="button" class="btn btn-default btn-xs pull-right" data-toggle="popover" data-placement="right" data-html="true" data-trigger="manual" data-content="<?php echo $q['author_details']; ?>" data-popover-group="author-details"><i class="fa fa-eye"></i></button>
											<?php } ?>
										</td>
											<?php break;
													case 'question':
													case 'answer': ?>
										<td class="<?php echo $attr['align']; ?> <?php echo $attr['class']; ?>">
											<?php echo $q[$column]; ?>
											<?php if ($q[$column] != $q[$column . '_full']) { ?>
											<button type="button" class="btn btn-default btn-xs pull-right" data-toggle="popover" data-placement="right" data-html="true" data-trigger="manual" data-content="<?php echo $q[$column . '_full']; ?>" data-popover-group="<?php echo $column; ?>"><i class="fa fa-eye"></i></button>
											<?php } ?>
										</td>
											<?php break;
													case 'action': ?>
										<td class="<?php echo $attr['align']; ?> <?php echo $attr['class']; ?> action">
											<div class="btn-group">
												<?php foreach ($q['action'] as $action) { ?>
													<?php if ($action['url']) { ?>
												<a href="<?php echo $action['url']; ?>" id="<?php echo $action['name'] . "-" . $q['qa_id']; ?>" class="btn <?php echo $action['class']; ?> btn-sm <?php echo $action['name']; ?>" data-toggle="tooltip" title="<?php echo $action['title']; ?>"><?php if ($action['icon']) {?><i class="fa fa-<?php echo $action['icon']; ?>"></i><?php } ?> <span class="visible-lg-inline"><?php echo $action['text']; ?></span></a>
													<?php } else { ?>
												<button type="button" id="<?php echo $action['name'] . "-" . $q['qa_id']; ?>" class="btn <?php echo $action['class']; ?> btn-sm <?php echo $action['name']; ?>" data-toggle="tooltip" title="<?php echo $action['title']; ?>"><?php if ($action['icon']) {?><i class="fa fa-<?php echo $action['icon']; ?>"></i><?php } ?> <span class="visible-lg-inline"><?php echo $action['text']; ?></span></button>
													<?php } ?>
												<?php } ?>
											</div>
										</td>
											<?php break;
													default: ?>
										<td class="<?php echo $attr['align']; ?> <?php echo $attr['class']; ?>"><?php echo $q[$column]; ?></td>
											<?php break;
												}
											} ?>
									</tr>
										<?php } ?>
									<?php } else { ?>
									<tr>
										<td class="text-center" colspan="<?php echo count($columns); ?>"><?php echo $text_no_results; ?></td>
									</tr>
									<?php } ?>
								</tbody>
							</table>
						</div>
					</fieldset>
				</form>
				<div class="row">
					<div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
					<div class="col-sm-6 text-right"><?php echo $results; ?></div>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript"><!--
(function(bull5i,$,undefined){
bull5i.texts=$.extend({},bull5i.texts,{error_ajax_request:"<?php echo addslashes($error_ajax_request); ?>"});var filter=function(){var e="index.php?route=catalog/qa",t=$("#nav-filter").find("input,select").filter(function(){return $.trim(this.value).length>0}).serialize(),o=$("tr.filters .fltr:input").filter(function(){return $.trim(this.value).length>0}).serialize(),r="sort=<?php echo $sort; ?>",n="order=<?php echo $order; ?>",l="token=<?php echo $token; ?>",i=$.grep([e,t,o,r,n,l],function(e){return $.trim(e).length>0}).join("&");location=i},update_nav_buttons=function(){$("input[name*='selected']:checked").length?($("#btn-delete").prop("disabled",!1),$("#btn-copy").prop("disabled",!1)):($("#btn-delete").prop("disabled",!0),$("#btn-copy").prop("disabled",!0))};$("body").on("click","[data-toggle=popover]",function(){var e=$(this).data("popover-group"),t=$(this).data("bs.popover");$('[data-popover-group="'+e+'"]').not(this).popover("destroy"),t?$(".popover").not(t.$tip).remove():$(".popover").remove(),$(this).popover("toggle")}).on("click",function(e){var t=$(e.target).is("[data-toggle=popover]")||$(e.target).parent().is("[data-toggle=popover]"),o=$(e.target).closest(".popover").length>0;t||o||($("[data-toggle=popover]").popover("destroy"),$(".popover").remove())}).on("click","#clear-global-search-btn",function(){$("#global-search").val(""),filter()}).on("click","#global-search-btn,#filter",function(){filter()}).on("change","#selectLanguage",function(){filter()}).on("click","#clear-filter",function(){$("tr.filters .fltr:input").val(""),filter()}).on("keypress","#global-search,tr.filters .fltr:input",function(e){13==e.which&&filter()}).on("change","input[name*='selected']",function(){update_nav_buttons()});
<?php foreach ($typeahead as $column => $attr) { switch ($column) { case 'product': ?>var product_source=new Bloodhound({<?php if (isset($attr['prefetch'])) { ?>prefetch:'<?php echo $attr['prefetch']; ?>',<?php }; if (isset($attr['remote'])) { ?>remote:'<?php echo $attr['remote']; ?>',<?php } ?>datumTokenizer:Bloodhound.tokenizers.obj.whitespace('value'),queryTokenizer:Bloodhound.tokenizers.whitespace,dupDetector:function(remoteMatch,localMatch){return remoteMatch.id&&localMatch.id&&remoteMatch.id==localMatch.id;},limit:10,});product_source.initialize();$('.<?php echo $column; ?>.typeahead').typeahead({hint:true,highlight:true,},{name:'<?php echo $column; ?>',source:product_source.ttAdapter(),templates:{empty:['<div class="tt-no-suggestion"><?php echo addslashes($text_no_records_found); ?></div>'].join('\n'),suggestion:Handlebars.compile('<p><span class="tt-nowrap">{{value}}<span class="tt-secondary-right">{{model}}</span></span></p>')}});<?php break; default: break; } } ?>
$(".typeahead.input-sm").length&&$(".typeahead.input-sm").siblings("input.tt-hint").addClass("hint-small");bull5i.onComplete($("#page-overlay"),$("#content"));
}(window.bull5i=window.bull5i||{},jQuery));
//--></script>
<?php echo $footer; ?>
