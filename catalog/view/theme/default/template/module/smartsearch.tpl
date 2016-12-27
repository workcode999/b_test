<?php
//==============================================================================
// Smart Search v201.2
// 
// Author: Clear Thinking, LLC
// E-mail: johnathan@getclearthinking.com
// Website: http://www.getclearthinking.com
// 
// All code within this file is copyright Clear Thinking, LLC.
// You may not copy or reuse code within this file without written permission.
//==============================================================================
?>

<?php if ($smartsearch_message) { ?>
	<script type="text/javascript">
		$(document).ready(function(){
			$('body').prepend('<div style="padding: 10px; text-align: center; font-size: 14px; background: #FF8"><?php echo $smartsearch_message; ?></div>');
		});
	</script>
<?php } ?>

<?php if ($settings['status'] && $settings['live_search']) { ?>
	<style type="text/css">
		#search, .searchbox {
			overflow: visible !important;
			//z-index: 9999999 !important;
		}
		.smartsearch {
			display: none;
			background: <?php echo $settings['live_background_color']; ?> !important;
			border: 1px solid <?php echo $settings['live_borders_color']; ?> !important;
			border-top: none !important;
			border-radius: 0 0 7px 7px !important;
			box-shadow: 0 2px 2px #DDD !important;
			line-height: 1.2 !important;
			margin: -8px 0 0 2px !important;
			padding: 0 !important;
			position: absolute !important;
			white-space: normal !important;
			width: <?php echo (strpos($settings['live_width'], '%')) ? $settings['live_width'] : $settings['live_width'] . 'px'; ?> !important;
			z-index: 9999999 !important;
			<?php if ($settings['live_top']) { ?>
				top: <?php echo $settings['live_top']; ?>px !important;
			<?php } ?>
			<?php if ($settings['live_left']) { ?>
				left: <?php echo $settings['live_left']; ?>px !important;
			<?php } ?>
			<?php if ($settings['live_right']) { ?>
				right: <?php echo $settings['live_right']; ?>px !important;
			<?php } ?>
		}
		.smartsearch a {
			white-space: normal !important;
		}
		.smartsearch .addtocart {
			float: right;
			margin: 5px;
		}
		<?php if ($settings['live_addtocart_button'] == 'no_quantity') { ?>
			.smartsearch .quantity {
				display: none;
			}
		<?php } ?>
		.smartsearch .quantity {
			padding: 5px;
		}
		.smartsearch .quantity input {
			width: 30px;
		}
		.smartsearch-product {
			border-bottom: 1px solid <?php echo $settings['live_borders_color']; ?> !important;
			color: <?php echo $settings['live_font_color']; ?> !important;
			display: block !important;
			font-size: <?php echo $settings['live_description_font']; ?>px !important;
			font-weight: normal !important;
			<?php if ($settings['live_image_height']) { ?>
				min-height: <?php echo $settings['live_image_height']; ?>px !important;
			<?php } ?>
			padding: 5px !important;
			text-decoration: none !important;
		}
		.smartsearch-product img {
			float: left !important;
			margin: 0 10px 0 0 !important;
		}
		.smartsearch-product strong {
			font-size: <?php echo $settings['live_product_font']; ?>px !important;
			margin: 5px 5px 5px 0 !important;
		}
		.smartsearch-focus, .smartsearch-product:hover {
			background: <?php echo $settings['live_highlight_color']; ?> !important;
			text-decoration: none !important;
		}
		.smartsearch-bottom {
			font-size: 12px !important;
			font-weight: bold !important;
			padding: 10px !important;
			text-align: center !important;
		}
		<?php echo $settings['live_css']; ?>
	</style>
	<script type="text/javascript">
		var wait;
		var searchinput;
		
		$(document).click(function(e){
			if(!$(e.target).closest('.smartsearch').length && $('.smartsearch').is(':visible')) {
				clearTimeout(wait);
				wait = setTimeout(hideSmartSearch, <?php echo max($settings['live_delay'], 100); ?>);
			}
		});
		
		$(document).ready(function(){
			$('<?php echo html_entity_decode($settings['live_selector'], ENT_QUOTES, 'UTF-8'); ?>')
			.after('<div class="smartsearch"></div>')
			.keydown(function(e){
				if ($('.smartsearch-product').length && e.which == 38) {
					e.preventDefault();
					return false;
				}
			}).keyup(function(e){
				searchinput = $(this);
				if (!searchinput.val()) {
					clearTimeout(wait);
					wait = setTimeout(hideSmartSearch, <?php echo max($settings['live_delay'], 100); ?>);
				}
				if (e.which == 13 && $('.smartsearch-focus').length) {
					location = $('.smartsearch-focus').attr('href');
				}
				if (searchinput.val().replace(/^\s+|\s+$/g, '') && (e.which == 8 || (47 < e.which && e.which < 112) || e.which > 185)) {
					clearTimeout(wait);
					wait = setTimeout(showSmartSearch, <?php echo max($settings['live_delay'], 100); ?>);
				}
				if ($('.smartsearch-product').length && (e.which == 38 || e.which == 40)) {
					if (!$('.smartsearch-focus').length) {
						if (e.which == 38) $('.smartsearch-bottom').prev().addClass('smartsearch-focus');
						if (e.which == 40) $('.smartsearch-product:first-child').addClass('smartsearch-focus');
					} else {
						if (e.which == 38) $('.smartsearch-focus').removeClass('smartsearch-focus').prev('a').addClass('smartsearch-focus');
						if (e.which == 40) $('.smartsearch-focus').removeClass('smartsearch-focus').next('a').addClass('smartsearch-focus');
					}
				}
			});
		});
		
		function hideSmartSearch() {
			$('.smartsearch').hide();
		}
		
		function showSmartSearch() {
			searchinput.next().html('<div class="smartsearch-bottom"><img alt="" src="data:image/gif;base64,R0lGODlhCgAKANUAAP////v7+/f39/Pz8+/v7+rq6ubm5uLi4t7e3tra2tbW1tLS0s7OzsrKysXFxcHBwb29vbm5ubW1tbGxsa2trampqaWlpaCgoJycnJiYmJSUlJCQkIyMjIiIiISEhICAgHt7e3d3d3Nzc2NjY19fX1paWlZWVlJSUk5OTkZGRiEhIR0dHRkZGQgICP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH/C05FVFNDQVBFMi4wAwEAAAAh+QQJCgAuACwAAAMACQAHAAAGKkCBAeAqGksqjPG4qiyLgsjnUSQwBC5KytNwNB4Jl4Hi4GQKiGVggsG6ggAh+QQJCgAuACwAAAEABwAJAAAGKkCXQbNwGV2bFuooiJAmR9DJcXR5TJHqwFFpVB+cS8FgLDAYjseguigGAQAh+QQJCgAuACwAAAAABwAJAAAGLECXEFAqCVyGiYSlOrgqqVDGAhA4PA+hC7NhaF0WjeMbKDgIX8Sj8XUljsIgACH5BAkKAC4ALAAAAAAJAAcAAAYqQJcw4PkAhK6Cw2EyRTQGF4RzkTxQrY5LEXEIJ6MFw1FAIhmPqFk4WAuDACH5BAkKAC4ALAAAAAAKAAcAAAYrQJdQcLkEhEjEYbNxUAzCxMOxaIBSlCGDIHx0IgKkuLIqiZEYlfnsAhgEQQAh+QQJCgAuACwDAAAABwAJAAAGKkDXYuEqugYPx+JRKBoKFM7D6HJYHAPqw+TRmkLGCQkiMKJaHOpCY3AFAQAh+QQJCgAuACwDAAEABwAJAAAGK0CXUJAQGhsPhNFFcBgESwXnslxkMMZIpzEAWCygVMV1WLEik4JLUCoBjEEAIfkECQoALgAsAAADAAoABwAABipAl3AoHBCJhgfjKCwoXYvRRNiYKISdFioCwXAaQoMmYjopHgYi4OMRDIMAOw==" /></div>').show();
			$.ajax({
				url: 'index.php?route=module/smartsearch/smartsearch&search=' + encodeURIComponent(searchinput.val()),
				dataType: 'json',
				success: function(data) {
					var html = '';
					if (data.length) {
						for (i = 0; i < data.length; i++) {
							<?php if ($settings['live_addtocart_button']) { ?>
								html += '<div class="addtocart"><span class="quantity"><?php echo $settings['live_quantity_text_' . $language_code]; ?> <input value="1" /></span> <a class="button btn btn-primary" onclick="<?php echo (version_compare(VERSION, '2.0') < 0) ? 'addToCart' : 'cart.add'; ?>(' + data[i]['product_id'] + ', $(this).prev().find(\'input\').val());"><?php echo html_entity_decode($settings['live_addtocart_text_' . $language_code], ENT_QUOTES, 'UTF-8'); ?></a></div>';
							<?php } ?>
							html += '<a class="smartsearch-product" href="' + data[i]['href'] + (data[i]['href'].indexOf('?') == -1 ? '?' : '&') + '<?php echo (version_compare(VERSION, '1.5.5') < 0) ? 'filter_name' : 'search'; ?>=' + encodeURIComponent(searchinput.val()) + '">';
							<?php if ($settings['live_image_width']) { ?>
								html += '<img src="' + data[i]['image'] + '" />';
							<?php } ?>
							html += '<strong>' + data[i]['name'];
							<?php if ($settings['live_model']) { ?>
								html += ' (' + data[i]['model'] + ')';
							<?php } ?>
							<?php if ($settings['live_price']) { ?>
								if (data[i]['price']) {
									var price = '<span style="color: <?php echo $settings['live_price_color']; ?>;' + (data[i]['special'] ? 'text-decoration: line-through' : '') + '">' + data[i]['price'] + '</span>';
									var special = (data[i]['special'] ? '<span style="color: <?php echo $settings['live_special_color']; ?>">' + data[i]['special'] + '</span>' : '');
									html += '<span style="float: right">' + price + ' ' + special + '</span>';
								}
							<?php } ?>
							html += '</strong><br />';
							<?php if ($settings['live_description']) { ?>
								html += data[i]['description'];
							<?php } ?>
							html += '</a>';
						}
						<?php if ($settings['live_viewall_' . $language_code]) { ?>
							html += '<div class="smartsearch-bottom"><a href="<?php echo $config_url; ?>index.php?route=product/search&<?php echo (version_compare(VERSION, '1.5.5') < 0) ? 'filter_name' : 'search'; ?>=' + encodeURIComponent(searchinput.val()) + '"><?php echo html_entity_decode($settings['live_viewall_' . $language_code], ENT_QUOTES, 'UTF-8'); ?></a></div>';
						<?php } ?>
					} else {
						html = '<div class="smartsearch-bottom"><?php echo html_entity_decode($settings['live_noresults_' . $language_code], ENT_QUOTES, 'UTF-8'); ?></div>';
					}
					searchinput.next().html(html);
				}
			});
		}
	</script>
<?php } ?>