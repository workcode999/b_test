    <script type="text/javascript">
		var wait;
		var selector = '<?php echo $sphinx_autocomple_selector; ?>';
		var catTitle = '<?php echo $label_categories; ?>';
		var prodTitle = '<?php echo $label_products; ?>';
		var viewAllTitle = '<?php echo $label_view_all; ?>';
		var noResTitle = '<?php echo $text_no_results; ?>';
	
		$(document).ready(function(){
			$(selector).after('<div class="sphinxsearch"></div>').blur(function(){
				clearTimeout(wait);
				wait = setTimeout(hideSearch, 1000);
			}).keydown(function(e){
				if ($('.sphinx-product').length && e.which == 38) {
					e.preventDefault();
					return false;
				}
				if(e.which == 13) {

					xhr.abort();
					unbind("keyup");
					var url = '<?php echo str_replace('&amp;', '&', $search_url); ?>' + encodeURIComponent($(selector).val());
					if(url != undefined) {
						location.href = url;
					}
					return false;
				}
			}).keyup(function(e){
				if (!$(selector).val()) {
					clearTimeout(wait);
					wait = setTimeout(hideSearch, 1000);
				}
				if ($(selector).val().replace(/^\s+|\s+$/g, '') && (e.which == 8 || (47 < e.which && e.which < 112) || e.which > 185)) {
					clearTimeout(wait);
					wait = setTimeout(sphinxSearch, 1000);
				}
				if ($(selector).val() == '') {
					hideSearch();
				}
			});
		});
		
		function sphinxSearch() {
			$(selector).next().html('<div class="sphinx-viewall"><img src="catalog/view/theme/default/image/loading.gif" /></div>').show();
			
			$('#search input').css({ 'border-bottom-left-radius':0, 'border-bottom-right-radius':0 });

			xhr = $.ajax({
				url: '<?php echo str_replace('&amp;', '&', $autocomplete_url); ?>' + $(selector).val(),
				dataType: 'json',
				success: function(data) {
					var html = '';
					
					//Categories
					if (data.categories.length) {
						html += '<div class="categories"><span>'+catTitle+'</span>';
						var categories = data.categories;
						for (i = 0; i < categories.length; i++) {
							html += '<a class="sphinx-product-cat" href="' + categories[i]['href'] + '">';
								if(categories[i]['image'] != '') {
									html += '<img src="' + categories[i]['image'] + '" />';
								}
								html += categories[i]['name'];
								html += '<br />';
							html += '</a>';
						}
						html += '</div>';
					}
					
					//Products
					if (data.products.length) {
						if (data.categories.length) { html += '<div class="products"><span>'+prodTitle+'</span>'; }
						var products = data.products;
						for (i = 0; i < products.length; i++) {
							html += '<a class="sphinx-product" href="' + products[i]['href'] + '">';
								html += '<img src="' + products[i]['image'] + '" />';
								html += products[i]['name'];
								html += '<br />';
							html += '</a>';
						}
						if (data.categories.length) {  html += '</div>'; }
						html += '<div class="sphinx-viewall"><a id="view-all" href="<?php echo $search_url ?>' + encodeURIComponent($(selector).val()) + '">'+viewAllTitle+'</a></div>';
					} else {
						html = '<div class="sphinx-viewall">'+noResTitle+'</div>';
					}
					$(selector).next().html(html);
				}
			});
		}
		
		function hideSearch() {
			$('.sphinxsearch').hide();
			$('#search input').removeAttr('style');
		}
	</script>
