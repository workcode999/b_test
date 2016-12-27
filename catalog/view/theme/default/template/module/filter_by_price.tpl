<?php
//==============================================================================
// Filter by Price Module v230.1
// 
// Author: Clear Thinking, LLC
// E-mail: johnathan@getclearthinking.com
// Website: http://www.getclearthinking.com
// 
// All code within this file is copyright Clear Thinking, LLC.
// You may not copy or reuse code within this file without written permission.
//==============================================================================
?>

<style type="text/css">
	#filter-module-toggle {
		display: none;
		border-top: 0;
		border-right: 0;
		border-radius: 0 0 0 5px;
		cursor: pointer;
		outline: none !important;
		position: fixed;
		top: 0;
		right: 0;
		z-index: 9999;
	}
	.filter-module {
		background: #FFF;
		border-radius: 5px;
		margin-bottom: 20px;
		z-index: 9999;
	}
	.filter-module .module-heading {
		border-top: 1px solid #DDD;
		<?php if (version_compare(VERSION, '2.0', '<')) { ?>
			background-image: url('catalog/view/theme/<?php echo $template; ?>/image/background.png');
			border-top-left-radius: 7px;
			border-top-right-radius: 7px;
		<?php } else { ?>
			border-top-left-radius: 5px;
			border-top-right-radius: 5px;
		<?php } ?>
	}
	.filter-module h3 {
		margin: 0;
	}
	.filter-module .clear-link {
		float: right;
		font-size: 11px;
	}
	.filter-module .hide-button {
		display: none;
		float: right;
	}
	.filter-module .collapsable-heading {
		cursor: pointer;
		background: #EEE;
		color: #444;
	}
	.filter-module .collapsable-choices {
		background: #FFF;
		<?php if ($settings['block_height']) { ?>
			max-height: <?php echo $settings['block_height']; ?>px;
			overflow: hidden;
		<?php } ?>
	}
	<?php if ($settings['block_height']) { ?>
		.filter-module .collapsable-choices:hover {
			overflow: auto;
		}
	<?php } ?>
	.filter-module .collapsable-choices img {
		vertical-align: middle;
	}
	.filter-module div:not(.collapsable-block) {
		border-left: 1px solid #DDD;
		border-right: 1px solid #DDD;
		border-bottom: 1px solid #DDD;
		padding: 8px 12px;
	}
	.filter-module > div:last-child {
		border-bottom-left-radius: <?php echo (version_compare(VERSION, '2.0', '<')) ? '7px' : '5px'; ?>;
		border-bottom-right-radius: <?php echo (version_compare(VERSION, '2.0', '<')) ? '7px' : '5px'; ?>;
		text-align: center;
	}
	.filter-module input {
		margin-right: 2px;
	}
	.filter-module a,
	.filter-module input[type="checkbox"],
	.filter-module input[type="radio"],
	.filter-module label {
		cursor: pointer;
	}
	.filter-module a.choice {
		color: inherit;
		display: block;
		text-decoration: none;
	}
	.filter-module a.choice:hover {
		color: <?php echo (version_compare(VERSION, '2.0', '<')) ? '#666' : 'initial'; ?>;
	}
	.filter-module input[type="text"] {
		margin-bottom: 10px;
	}
	.filter-module label {
		display: block;
		margin-right: 10px;
	}
	.filter-module select {
		display: inline-block;
		margin: 5px 0;
		max-width: 250px;
		width: 100%;
	}
	.filter-module .clear-filters {
		text-align: center;
	}
	.filter-module .clear-filters a {
		font-size: 11px;
	}
	.filter-module .flexible-filter {
		border: 0 !important;
		padding: 10px 0 0 !important;
		text-align: center;
	}
	.filter-module .flexible-filter input {
		display: inline-block;
		width: 30%;
	}
	
	/* Content Top/Bottom Fixes */
	#content .filter-module {
		border: 1px solid #DDD;
	}
	#content .filter-module div:first-child {
		border-bottom: 1px solid #DDD;
	}
	#content .filter-module div {
		border: none;
	}
	#content .filter-module .collapsable-heading {
		border: 1px solid #DDD;
	}
	#content .filter-module .collapsable-block {
		display: inline-block;
		margin-left: 5px;
		vertical-align: top;
		width: <?php echo $settings['block_width'] . (strpos($settings['block_width'], '%') ? '' : 'px'); ?>;
	}
	#content .filter-module .clear-filters {
		position: relative;
		left: 30%;
		top: 25px;
		height: 0;
		width: 100px;
	}
	
	/* Mobile Devices Styling */
	@media (max-width: 767px) {
		#filter-module-toggle, .filter-module .hide-button {
			display: block;
		}
		.filter-module {
			display: none;
			box-shadow: 0 2px 5px #888;
			position: absolute;
			top: 0;
			left: 2%;
			width: 96%;
		}
		.filter-module .collapsable-block:not(.category-filter) label {
			display: inline-block;
		}
	}
</style>

<div class="filter-module">
	<div class="module-heading">
		<h3>
			<?php if ($heading_title) echo html_entity_decode($settings['heading_' . $language], ENT_QUOTES, 'UTF-8'); ?>
			<a class="hide-button" onclick="$('.filter-module').slideUp(); $('#filter-module-toggle').slideDown();"><?php echo html_entity_decode($settings['mobile_close_' . $language], ENT_QUOTES, 'UTF-8'); ?></a>
		</h3>
	</div>
	
	<?php foreach ($filter_sorting as $filter) { ?>
		
		<?php if ($filter == 'category') { ?>
			<div class="category-filter collapsable-block">
				<?php $collapsed = ($settings['category_display'] == 'collapsed' && (empty($get['category_id']) || !in_array($get['category_id'], $settings['categories']))); ?>
				<?php if ($settings['category_heading_' . $language]) { ?>
					<div class="collapsable-heading">
						<span class="right-triangle" <?php if (!$collapsed) echo 'style="display: none"'; ?>>&#9656;</span>
						<span class="down-triangle" <?php if ($collapsed) echo 'style="display: none"'; ?>>&#9662;</span>
						<?php echo html_entity_decode($settings['category_heading_' . $language], ENT_QUOTES, 'UTF-8'); ?>
						<?php if ($settings['category_filter'] == 'links') { ?>
							<a class="clear-link" onclick="$('.filter-module input[name=category_id]').val(''); $('.filter-module .button').click();">
								<?php echo html_entity_decode($settings['clear_filter_text_' . $language], ENT_QUOTES, 'UTF-8'); ?>
							</a>
						<?php } else { ?>
							<a class="clear-link" onclick="clearFilters($(this).parent().parent())">
								<?php echo html_entity_decode($settings['clear_filter_text_' . $language], ENT_QUOTES, 'UTF-8'); ?>
							</a>
						<?php } ?>
					</div>
				<?php } ?>
					<div class="collapsable-choices" <?php if ($collapsed) echo 'style="display: none"'; ?>>
					<?php if ($settings['category_filter'] == 'select') { ?>
						<select class="form-control" name="category_id">
							<option value=""><?php echo $settings['all_text_' . $language]; ?></option>
					<?php } ?>
					
					<?php $i = 0; ?>
					<?php foreach ($categories as $category) { ?>
						<?php if ($settings['category_filter'] == 'select') { ?>
							<?php $selected = (isset($get['category_id']) && $category['category_id'] == $get['category_id']) ? 'selected="selected"' : ''; ?>
							<option value="<?php echo $category['category_id']; ?>" <?php echo $selected; ?>><?php echo $category['name']; ?></option>
						<?php } elseif ($settings['category_filter'] == 'links') { ?>
							<?php $bold = (isset($get['category_id']) && in_array($category['category_id'], explode(';', $get['category_id']))) ? 'style="font-weight: bold"' : ''; ?>
							<a class="choice" <?php echo $bold; ?> onclick="$('.filter-module input[name=category_id]').val('<?php echo $category['category_id']; ?>'); $('.filter-module .button').click();">
								<?php echo $category['name']; ?>
							</a>
						<?php } else { ?>
							<?php $checked = (isset($get['category_id']) && in_array($category['category_id'], explode(';', $get['category_id']))) ? 'checked="checked" class="isChecked"' : ''; ?>
							<?php $hide = ($i < $settings['choice_display'] || isset($get['category_id'])) ? '' : 'style="display: none"'; ?>
							
							<?php if ($i == $settings['choice_display'] && !isset($get['category_id'])) { ?>
								<a onclick="$(this).parent().find('label').show(); $(this).remove();"><?php echo $settings['show_more_text_' . $language]; ?></a>
							<?php } ?>
							
							<label <?php echo $hide; ?>>
								<input type="<?php echo $settings['category_filter']; ?>" <?php echo $checked; ?> name="category_id" value="<?php echo $category['category_id']; ?>" /> <?php echo $category['name']; ?>
							</label>
							<?php $i++; ?>
						<?php } ?>
					<?php } ?>
					
					<?php if ($settings['category_filter'] == 'links') { ?>
						<input type="hidden" name="category_id" class="form-control" value="<?php if (!empty($get['category_id'])) echo $get['category_id']; ?>" />
						<?php if (!empty($get['category_id'])) { ?>
							<a onclick="$('.filter-module input[name=category_id]').val(''); $('.filter-module .button').click();"><?php echo $settings['show_all_text_' . $language]; ?></a>
						<?php } ?>
					<?php } ?>
					
					<?php if ($settings['category_filter'] == 'select') { ?>
						</select>
					<?php } ?>
				</div>
			</div>
		<?php } ?>
		
		<?php if ($filter == 'manufacturer') { ?>
			<div class="manufacturer-filter collapsable-block">
				<?php $collapsed = ($settings['manufacturer_display'] == 'collapsed' && empty($get['manufacturer_id'])); ?>
				<?php if ($settings['manufacturer_heading_' . $language]) { ?>
					<div class="collapsable-heading">
						<span class="right-triangle" <?php if (!$collapsed) echo 'style="display: none"'; ?>>&#9656;</span>
						<span class="down-triangle" <?php if ($collapsed) echo 'style="display: none"'; ?>>&#9662;</span>
						<?php echo html_entity_decode($settings['manufacturer_heading_' . $language], ENT_QUOTES, 'UTF-8'); ?>
						<?php if ($settings['manufacturer_filter'] == 'links') { ?>
							<a class="clear-link" onclick="$('.filter-module input[name=manufacturer_id]').val(''); $('.filter-module .button').click();">
								<?php echo html_entity_decode($settings['clear_filter_text_' . $language], ENT_QUOTES, 'UTF-8'); ?>
							</a>
						<?php } else { ?>
							<a class="clear-link" onclick="clearFilters($(this).parent().parent())">
								<?php echo html_entity_decode($settings['clear_filter_text_' . $language], ENT_QUOTES, 'UTF-8'); ?>
							</a>
						<?php } ?>
					</div>
				<?php } ?>
				<div class="collapsable-choices" <?php if ($collapsed) echo 'style="display: none"'; ?>>
					<?php if ($settings['manufacturer_filter'] == 'select') { ?>
						<select class="form-control" name="manufacturer_id">
							<option value=""><?php echo $settings['all_text_' . $language]; ?></option>
					<?php } ?>
					
					<?php $i = 0; ?>
					<?php foreach ($manufacturers as $manufacturer) { ?>
						<?php if ($settings['manufacturer_filter'] == 'select') { ?>
							<?php $selected = (isset($get['manufacturer_id']) && $manufacturer['manufacturer_id'] == $get['manufacturer_id']) ? 'selected="selected"' : ''; ?>
							<option value="<?php echo $manufacturer['manufacturer_id']; ?>" <?php echo $selected; ?>><?php echo $manufacturer['name']; ?></option>
						<?php } elseif ($settings['manufacturer_filter'] == 'links') { ?>
							<?php $bold = (isset($get['manufacturer_id']) && $manufacturer['manufacturer_id'] == $get['manufacturer_id']) ? 'style="font-weight: bold"' : ''; ?>
							<a class="choice" <?php echo $bold; ?> onclick="$('.filter-module input[name=manufacturer_id]').val('<?php echo $manufacturer['manufacturer_id']; ?>'); $('.filter-module .button').click();">
								<?php echo $manufacturer['name']; ?>
							</a>
						<?php } else { ?>
							<?php $checked = (isset($get['manufacturer_id']) && in_array($manufacturer['manufacturer_id'], explode(';', $get['manufacturer_id']))) ? 'checked="checked" class="isChecked"' : ''; ?>
							<?php $hide = ($i < $settings['choice_display'] || isset($get['manufacturer_id'])) ? '' : 'style="display: none"'; ?>
							
							<?php if ($i == $settings['choice_display'] && !isset($get['manufacturer_id'])) { ?>
								<a onclick="$(this).parent().find('label').show(); $(this).remove();"><?php echo $settings['show_more_text_' . $language]; ?></a>
							<?php } ?>
							
							<label <?php echo $hide; ?>>
								<input type="<?php echo $settings['manufacturer_filter']; ?>" <?php echo $checked; ?> name="manufacturer_id" value="<?php echo $manufacturer['manufacturer_id']; ?>" /> <?php echo $manufacturer['name']; ?>
							</label>
							<?php $i++; ?>
						<?php } ?>
					<?php } ?>
					
					<?php if ($settings['manufacturer_filter'] == 'links') { ?>
						<input type="hidden" name="manufacturer_id" class="form-control" value="<?php if (!empty($get['manufacturer_id'])) echo $get['manufacturer_id']; ?>" />
						<?php if (!empty($get['manufacturer_id']) && $settings['manufacturer_choices'] == 'relevant') { ?>
							<a onclick="$('.filter-module input[name=manufacturer_id]').val(''); $('.filter-module .button').click();"><?php echo $settings['show_all_text_' . $language]; ?></a>
						<?php } ?>
					<?php } ?>
					
					<?php if ($settings['manufacturer_filter'] == 'select') { ?>
						</select>
					<?php } ?>
				</div>
			</div>
		<?php } ?>
		
		<?php if ($filter == 'price') { ?>
			<div class="price-filter collapsable-block">
				<?php $collapsed = ($settings['price_display'] == 'collapsed' && empty($get['price'])); ?>
				<?php if ($settings['price_heading_' . $language]) { ?>
					<div class="collapsable-heading">
						<span class="right-triangle" <?php if (!$collapsed) echo 'style="display: none"'; ?>>&#9656;</span>
						<span class="down-triangle" <?php if ($collapsed) echo 'style="display: none"'; ?>>&#9662;</span>
						<?php echo html_entity_decode($settings['price_heading_' . $language], ENT_QUOTES, 'UTF-8'); ?>
						<?php if ($settings['price_filter'] == 'links') { ?>
							<a class="clear-link" onclick="$('.flexible-filter input').val(''); $('.filter-module .button').click();">
								<?php echo html_entity_decode($settings['clear_filter_text_' . $language], ENT_QUOTES, 'UTF-8'); ?>
							</a>
						<?php } else { ?>
							<a class="clear-link" onclick="clearFilters($(this).parent().parent())">
								<?php echo html_entity_decode($settings['clear_filter_text_' . $language], ENT_QUOTES, 'UTF-8'); ?>
							</a>
						<?php } ?>
					</div>
				<?php } ?>
				<div class="collapsable-choices" <?php if ($collapsed) echo 'style="display: none"'; ?>>
					<?php if ($settings['price_filter'] == 'select') { ?>
						<select class="form-control" name="price">
							<option value=""><?php echo $settings['all_text_' . $language]; ?></option>
					<?php } ?>
					
					<?php $i = 0; ?>
					<?php foreach ($price_ranges as $range => $text) { ?>
						<?php if ($settings['price_filter'] == 'select') { ?>
							<?php $selected = (isset($get['price']) && $range == $get['price']) ? 'selected="selected"' : ''; ?>
							<option value="<?php echo $range; ?>" <?php echo $selected; ?>><?php echo $text; ?></option>
						<?php } elseif ($settings['price_filter'] == 'links') { ?>
							<?php $bold = (isset($get['price']) && $range == $get['price']) ? 'style="font-weight: bold"' : ''; ?>
							<a class="choice" <?php echo $bold; ?> onclick="$('.flexible-filter input').val(''); $('.filter-module input[name=price]').val('<?php echo $range; ?>'); $('.filter-module .button').click();">
								<?php echo $text; ?>
							</a>
						<?php } else { ?>
							<?php $checked = (isset($get['price']) && in_array($range, explode(';', $get['price']))) ? 'checked="checked" class="isChecked"' : ''; ?>
							<?php $hide = ($i < $settings['choice_display'] || isset($get['price'])) ? '' : 'style="display: none"'; ?>
							
							<?php if ($i == $settings['choice_display'] && !isset($get['price'])) { ?>
								<a onclick="$(this).parent().find('label').show(); $(this).remove();"><?php echo $settings['show_more_text_' . $language]; ?></a>
							<?php } ?>
							
							<label <?php echo $hide; ?>>
								<input type="<?php echo $settings['price_filter']; ?>" <?php echo $checked; ?> name="price" value="<?php echo $range; ?>" /> <?php echo $text; ?>
							</label>
						<?php } ?>
					<?php } ?>
					
					<?php if ($settings['price_filter'] == 'select') { ?>
						</select>
					<?php } ?>
					
					<?php if ($settings['price_flexible']) { ?>
						<div class="flexible-filter">
							<?php echo $left_symbol; ?> <input type="text" class="form-control" name="lower" value="<?php echo $lower; ?>" /> <?php echo $right_symbol; ?>
							<?php echo str_replace(array('[from]', '[to]'), '', $settings['price_middle_text_' . $language]); ?>
							<?php echo $left_symbol; ?> <input type="text" class="form-control" name="upper" value="<?php echo $upper; ?>" /> <?php echo $right_symbol; ?>
						</div>
					<?php } ?>
					
					<?php if ($settings['price_filter'] == 'links') { ?>
						<input type="hidden" name="price" class="form-control" value="<?php if (!empty($get['price'])) echo $get['price']; ?>" />
					<?php } ?>
				</div>
			</div>
		<?php } ?>
		
	<?php } ?>
	
	<?php if (!in_array('category', $filter_sorting) && isset($get['category_id'])) { ?>
		<input type="hidden" class="form-control" name="category_id" value="<?php echo $get['category_id']; ?>" />
	<?php } ?>
	
	<?php if (!in_array('manufacturer', $filter_sorting) && isset($get['manufacturer_id'])) { ?>
		<input type="hidden" class="form-control" name="manufacturer_id" value="<?php echo $get['manufacturer_id']; ?>" />
	<?php } ?>
	
	<?php if (!in_array('search', $filter_sorting)) { ?>
		<?php if (isset($get['filter_name'])) { ?>
			<input type="hidden" class="form-control" name="search" value="<?php echo $get['filter_name']; ?>" />
		<?php } elseif (isset($get['search'])) { ?>
			<input type="hidden" class="form-control" name="search" value="<?php echo $get['search']; ?>" />
		<?php } ?>
	<?php } ?>
	
	<?php if (!empty($list)) { ?>
		<input type="hidden" class="form-control" name="list" value="<?php echo $list; ?>" />
	<?php } ?>
	
	<?php if (!empty($settings['clear_all_filters_text_' . $language])) { ?>
		<div class="clear-filters"><a onclick="clearAllFilters($(this))"><?php echo html_entity_decode($settings['clear_all_filters_text_' . $language], ENT_QUOTES, 'UTF-8'); ?></a></div>
	<?php } ?>
	
	<div class="filter-button" <?php if (empty($settings['filter_button_' . $language])) echo 'style="display: none"'; ?>>
		<a class="button btn btn-primary"><?php echo html_entity_decode($settings['filter_button_' . $language], ENT_QUOTES, 'UTF-8'); ?></a>
	</div>
</div>

<script type="text/javascript">
	// Input functions
	$('.collapsable-heading').click(function(event){
		if ($(event.target).attr('class') != 'clear-link') {
			$(this).next().slideToggle('fast');
			$(this).find('.right-triangle, .down-triangle').toggle();
		}
	});
	
	function clearAllFilters(element) {
		if ('<?php echo $clear_filters; ?>') {
			location = '<?php echo html_entity_decode($clear_filters, ENT_QUOTES, 'UTF-8'); ?>';
		} else {
			clearFilters(element.parent().parent());
		}
	}
	
	function clearFilters(element) {
		element.find(':input').removeAttr('checked');
		element.find('input[type="text"]').val('');
		element.find('option:first-child').attr('selected', 'selected');
		<?php if ($settings['automatic_filter']) { ?>
			clickFilterButton();
		<?php } ?>
	}
	
	$('.filter-module :radio').click(function(){
		if ($(this).hasClass('isChecked')) {
			$(this).removeClass('isChecked').removeAttr('checked').change();
		} else {
			$(this).parent().parent().find(':radio').removeClass('isChecked');
			$(this).addClass('isChecked');
		}
	});
	
	// Filtering functions
	$('.filter-module input[type="text"]').keyup(function(event){
		if (event.which == 13) $('.filter-module .button').click();
	});
	
	$('.filter-module .button').click(function(){
		if ($(this).parent().parent().find('input[name="search"]').val() && <?php echo $smartsearch; ?>) {
			var url = 'index.php?route=product/search&module_id=<?php echo $settings['module_id']; ?>';
		} else {
			var url = 'index.php?route=product/filter&module_id=<?php echo $settings['module_id']; ?>';
		}
		
		var previousInput = '';
		var lower = $(this).parent().parent().find('input[name="lower"]').val();
		var upper = $(this).parent().parent().find('input[name="upper"]').val();
		
		$(this).parent().parent().find(':input').each(function(){
			if ($(this).attr('name') == 'lower' && lower) {
				if (url.indexOf('&price=') == -1) {
					url += '&price=' + lower + '-' + upper;
				} else {
					url += ';' + lower + '-' + upper;
				}
				<?php if (isset($settings['price_filter']) && $settings['price_filter'] == 'links') { ?>
					$('input[name="price"]').val('');
				<?php } ?>
				return;
			}
			if ($(this).attr('name') == 'upper' && lower) {
				return;
			}
			
			if ($(this).is(':checkbox') && $(this).is(':checked')) {
				url += ($(this).attr('name') == previousInput) ? ';' + $(this).val() : '&' + $(this).attr('name') + '=' + $(this).val();
				previousInput = $(this).attr('name');
			} else if ($(this).is(':radio') && $(this).is(':checked')) {
				url += '&' + $(this).attr('name') + '=' + $(this).val();
			} else if ($(this).hasClass('form-control') && $(this).val()) {
				url += '&' + $(this).attr('name') + '=' + $(this).val();
			}
		});
		
		<?php if ($settings['page_loading'] != 'normal') { ?>
			loadAjaxPage(url);
		<?php } else { ?>
			location = url;
		<?php } ?>
	});
	
	<?php if ($settings['page_loading'] != 'normal') { ?>
		$(window).on('popstate', function(){
			location.reload();
		});

		function loadAjaxPage(url) {
			$.ajax({
				url: url,
				beforeSend: function() {
					$('#content').fadeTo(200, 0.5);
				},
				success: function(data) {
					window.history.pushState(data, 'newPage', url);
					
					<?php if ($settings['page_loading'] == 'ajax_quick') { ?>
						document.write(data);
						document.close();
					<?php } else { ?>
						$('#content').append('<div id="ajax-page" style="display: none">' + data + '</div>');
					
						// Journal fix
						$('#ajax-page img[data-src]').each(function(){
							$(this).attr('src', $(this).attr('data-src'));
						});
						
						<?php if ($check_relevant_values) { ?>
							$('#column-left:first').html($('#ajax-page #column-left').html());
							<?php if (version_compare(VERSION, '2.0', '<')) { ?>
								$('#column-right:first').html($('#ajax-page #column-right').html());
								$('#content-top:first').html($('#ajax-page #content-top').html());
								$('#content-bottom:last').html($('#ajax-page #content-bottom').html());
							<?php } else { ?>
								$('#content:first + #column-right').html($('#ajax-page #column-right').html());
							<?php } ?>
						<?php } ?>
						
						$('#content:first').html($('#ajax-page #content').html()).fadeTo(200, 1);
					<?php } ?>
					
					$('html, body').animate({scrollTop : $('#content').offset().top}, 500);
				}
			});
		}
		
		$(document).ready(function(){
			$('.pagination a').each(function(){
				$(this).attr('onclick', 'loadAjaxPage(\"' + $(this).attr('href') + '\")').removeAttr('href').css('cursor', 'pointer');
			});
		});
	<?php } ?>
	
	<?php if ($settings['automatic_filter']) { ?>
		var timeout;
		
		$(document).ready(function(){
			$('.filter-module :input:not(input[type="text"])').change(clickFilterButton);
		});
		
		function clickFilterButton() {
			clearTimeout(timeout);
			timeout = setTimeout(function(){
				$('.filter-module .button').click();
			}, <?php echo (int)($settings['automatic_filter'] * 1000); ?>);
		}
	<?php } ?>
	
	// Mobile-specific functions
	function showFilters() {
		$('.collapsable-choices, .down-triangle').hide();
		$('.right-triangle').show()
		$('#filter-module-toggle').slideUp();
		$('.filter-module').slideDown();
		$('html, body').scrollTop(0);
	}
	
	$(document).ready(function(){
		if ($(window).width() <= 767) {
			$('body').prepend('<a id="filter-module-toggle" class="button btn btn-info" onclick="showFilters()"><?php if ($heading_title) echo html_entity_decode(str_replace("'", "\'", $settings['mobile_button_' . $language]), ENT_QUOTES, 'UTF-8'); ?></a>');
			$('.filter-module').prependTo('body');
		}
	});
</script>
