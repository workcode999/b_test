(function($){
	
	/**
	 * Get URL param by name
	 */
	$.urlParam = function(name){
	    var results = new RegExp('[\?&]' + name + '=([^&#]*)').exec(window.location.href);
	    return (results==null) ? null : (decodeURIComponent(results[1]) || 0); 
	}
	
	/**
	 * Convert string to version int
	 */
	function parseVersion(a) {
	    if (typeof a != "string") return false;
	    var b = 0,
	        c = a.split("-");
	    var d = a.split(".");
	    a = parseInt(d[0]) || 0;
	    c = parseInt(d[1]) || 0;
	    var e = parseInt(d[2]) || 0;
	    d = parseInt(d[3]) || 0;
	    return a * 1E8 + c * 1E6 + e * 1E4 + d * 100 + b
	}
	
	$(document).ready(function(){
		var $form = $('#form-emailtemplate');
			
		if($.fn.colorpicker){
			$('.input-colorpicker').colorpicker()
		}
				
		// Test
		$('#template-test').click(function(e){
			e.preventDefault();
			
			var $el = $(this);
			
			$form.children(':first.alert').remove();
			
			$el.children('.fa').removeClass("fa-envelope-o").addClass("fa-circle-o-notch fa-spin");
			
			$.ajax({
				url: ('index.php?route=module/emailtemplate&token=' + $.urlParam('token')),
				type: 'GET',
				dataType: 'json',
				data: {
					id: $.urlParam('id'),
					action: 'test_send'
				},
				success: function(data) {
					$el.children('.fa').removeClass("fa-circle-o-notch fa-spin").addClass("fa-envelope-o");
					
					if(data['success']){
						$form.prepend("<div class='alert alert-success'><i class='fa fa-exclamation-circle'></i> " + data['success'] + "<button type='button' class='close' data-dismiss='alert'>&times;</button></div>");
					}
				}
			});
							
			$el.toggleClass('active');
		});	
		
		/**
		 * Remember Tabs
		 */
		if('localStorage' in window && window['localStorage'] !== null){
	        var json, tabsState;
	        $('a[data-toggle="tab"]').on('shown.bs.tab', function(e) {
	            tabsState = localStorage.getItem("tabs-state");
	            json = JSON.parse(tabsState || "{}");
	            json[$(e.target).parents("ul").attr("id")] = $(e.target).data('target');
	
	            localStorage.setItem("tabs-state", JSON.stringify(json));
	        });
	
	        tabsState = localStorage.getItem("tabs-state");
	
	        json = JSON.parse(tabsState || "{}");
	        $.each(json, function(containerId, target) {
	            return $("#" + containerId + " a[data-target=" + target + "]").tab('show');
	        });
	
	        $("ul.nav.nav-pills, ul.nav.nav-tabs").each(function() {
	            var $el = $(this);
	            if (!json[$el.attr("id")]) {
	                return $el.find("a[data-toggle=tab]:first, a[data-toggle=pill]:first").tab("show");
	            }
	        });
		}
			
		/**
		 * HTML Editor
		 */
		$('.wysiwyg_editor').each(function(){
			var $el = $(this)			
			if(!$el.is(':hidden')){
				$el.summernote({
					height: ($el.data('height') ? $el.data('height') : 'auto')
				})
			} else {
				$(this).parents('.tab-pane:eq(0)').each(function(){
					$('a[data-toggle="tab"][data-target="#' + $(this).prop('id') + '"]').on('shown.bs.tab', function(){
						$el.summernote({
							height: ($el.data('height') ? $el.data('height') : 'auto')
						})
					})
				})
			}
		});
		
		/**
		 * Show hidden tab with errors
		 */ 
		var $hidden_error = $('.tabsHolder .error').eq(0);
		if($hidden_error.length > 0){
		    $('.tabs-nav a[href=#'+$hidden_error.parents(".tab-pane").eq(0).attr('id')+']').click();
		}
				
		/**
		 * Table row click and highlight
		 */
		$('table').each(function(){				
			if($(this).hasClass('table-row-check')){
				$(this).find('> tbody > tr').each(function(){						
					// Row
					$(this).on('click', function(e){
						$(this).find('>td:first-child input[type=checkbox], >td:last-child input[type=checkbox]').trigger('click').each(function(){
							$(this).parents('tr').toggleClass('selected', this.checked)
						});
				    });
					
					// Checkbox
					$(this).find('>td:first-child input[type=checkbox], >td:last-child input[type=checkbox]').click(function(e){
						e.stopPropagation();
				    	$(this).parents('tr').toggleClass('selected', this.checked)
				    });
					
					// Anchor
					$(this).find('a').click(function(e){
						e.stopPropagation(); 
					});			    
				});
			}
				
			$(this).find('th [data-checkall]').click(function(event) {
			    if (event.target.type === 'checkbox') {
			    	$($(this).data('checkall')).prop('checked', this.checked).each(function(){
						$(this).parents('tr').toggleClass('selected', this.checked)
					});
			    }
			});			
		});

		/**
		 * Keyboard Shortcut save form [ctrl+s]
		 */
		$(window).keypress(function(event) {
			if (!(event.which == 115 && event.ctrlKey) && !(event.which == 19)) return true;
			var $button = $("#submit_form_button");
			if($button.length){
				$button.click();
				event.preventDefault();
			}
		});
		
		/**
		 * Confirm dialog box 
		 */			
		$("[data-confirm]").click(function(){
			if(window.confirm($(this).data("confirm"))){
				$(this).data('confirmed', true);
				return true;
			}
			
			return false;
		});
		
		/**
		 * Form Action
		 */			
		$("[data-action]").click(function(){
			if($(this).data('confirm') && !$(this).data('confirmed')){
				return false;
			}
			$('#form-emailtemplate').attr('action', $(this).data('action')).submit();
		});
		
		var showVersion = true;
		if(typeof window.localStorage !== "undefined"){
			if(localStorage.getItem('extensionEmailTemplateShowVersion')){
				showVersion = false;
			} else {
				localStorage.setItem('extensionEmailTemplateShowVersion', true)
			}
		}
		if(showVersion){
			$.getScript('http://www.opencart-templates.co.uk/version-default.js', function(){
				var current = parseVersion('2.0.12'),
		        latest = parseVersion(EmailTemplate_latest_version);
				if (latest > current || 1 == 1) {
			        $("#emailtemplate .support-text").append("<p>A new version of this extension is available, the latest version: " + EmailTemplate_latest_version + " was released on: " + EmailTemplate_latest_date + "</p>");
			    }
			});
		}
	});
	
})(jQuery);