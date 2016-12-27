<div class="container-fluid">
<table id="Settings" class="table">  
    
    <!-- ButtonsDesign -->
    
    <tr>
        <td class="col-xs-3">
            <h5><strong><?php echo $text_buttons_design; ?></strong></h5>
            <span class="help"><i class="fa fa-info-circle"></i>&nbsp;<?php echo $text_buttons_design_help; ?></span>
        </td>
        <td class="col-xs-3">
            <div class="col-xs-4">
                    <select name="<?php echo $moduleNameSmall; ?>[ButtonsDesign]" id="input-status" class="form-control">
                    <option value="sharing" <?php echo(!empty($moduleData['ButtonsDesign']) && $moduleData['ButtonsDesign'] == 'sharing') ? 'selected=selected' : '' ?> ><?php echo $sharing_buttons; ?></option>
                    <option value="native" <?php echo(!empty($moduleData['ButtonsDesign']) && $moduleData['ButtonsDesign'] == 'native') ? 'selected=selected' : '' ?> ><?php echo $original_sharing_buttons; ?></option> 
                    <option value="sharing_sidebar" <?php echo(!empty($moduleData['ButtonsDesign']) && $moduleData['ButtonsDesign'] == 'sharing_sidebar') ? 'selected=selected' : '' ?> ><?php echo $sharing_sidebar; ?></option> 
                    <option value="mobile_toolbar" <?php echo(!empty($moduleData['ButtonsDesign']) && $moduleData['ButtonsDesign'] == 'mobile_toolbar') ? 'selected=selected' : '' ?> ><?php echo $mobile_toolbar; ?></option> 
                    <option value="horizontal_follow" <?php echo(!empty($moduleData['ButtonsDesign']) && $moduleData['ButtonsDesign'] == 'horizontal_follow') ? 'selected=selected' : '' ?> ><?php echo $horizontal_follow_buttons; ?></option> 
                    <option value="vertical_follow" <?php echo(!empty($moduleData['ButtonsDesign']) && $moduleData['ButtonsDesign'] == 'vertical_follow') ? 'selected=selected' : '' ?> ><?php echo $vertical_follow_buttons; ?></option>  
                                          
                </select>
             </div>
         </td>
    </tr>
    
    <!-- End ButtonsDesign -->
    
    <!-- Recommended Content -->
    
    <tr>
        <td class="col-xs-3">
            <h5><strong><?php echo $text_recommended; ?></strong></h5>
            <span class="help"><i class="fa fa-info-circle"></i>&nbsp;<?php echo $text_recommended_help; ?></span>
        </td>
        <td class="col-xs-3">
            <div class="col-xs-4">
                    <select name="<?php echo $moduleNameSmall; ?>[Recommended]" id="input-status" class="form-control">
                    <option value="next" <?php echo(!empty($moduleData['Recommended']) && $moduleData['Recommended'] == 'next') ? 'selected=selected' : '' ?> ><?php echo $whats_next; ?></option>
                    <option value="footer" <?php echo(!empty($moduleData['Recommended']) && $moduleData['Recommended'] == 'footer') ? 'selected=selected' : '' ?> ><?php echo $recommended_footer; ?></option> 
                    <option value="horizontal" <?php echo(!empty($moduleData['Recommended']) && $moduleData['Recommended'] == 'horizontal') ? 'selected=selected' : '' ?> ><?php echo $horizontal_content; ?></option> 
                    <option value="vertical" <?php echo(!empty($moduleData['Recommended']) && $moduleData['Recommended'] == 'vertical') ? 'selected=selected' : '' ?> ><?php echo $vertical_content; ?></option>                     
                                          
                </select>
             </div>
         </td>
    </tr>
    
    <!-- End Recommended Content -->
    
    <!-- Enable Customization -->
    
    <tr>
            <td class="col-xs-3">
                <h5><strong><?php echo $custom_status; ?></strong></h5>
                <span class="help"><i class="fa fa-info-circle"></i>&nbsp;<?= $custom_status_help ?></span>
            </td>
            <td class="col-xs-9">
              <div class="col-xs-4">
                    <select name="<?php echo $moduleNameSmall; ?>[Custom]" id="custom-status" class="form-control">
                      
                      <option value="1" <?php echo(!empty($moduleData['Custom']) && $moduleData['Custom'] == '1') ? 'selected=selected' : '' ?> ><?php echo $custom_enabled; ?></option>
                      <option value="0" <?php echo(empty($moduleData['Custom']) || $moduleData['Custom'] == '0') ? 'selected=selected' : '' ?> ><?php echo $custom_disabled; ?></option>        
                              
                      
                    </select>
                    
              </div>
            </td>
        </tr> 
        
     <!-- End Enable Customization -->
    
    <!-- Custom URL -->
    
    <tr class="hideableRow">
        <td class="col-xs-3">
            <h5><strong><?php echo $text_custom_url; ?></strong></h5>
            <span class="help"><i class="fa fa-info-circle"></i>&nbsp;<?php echo $text_custom_url_help; ?></span>
        </td>
        <td class="col-xs-9">
            <div class="col-xs-4">
                <div class="form-group" style="padding-top:10px;">
                    <input type="url" id="custom-url" class="form-control" name="<?php echo $moduleNameSmall; ?>[CustomURL]" value="<?php if(isset($moduleData['CustomURL'])) { echo $moduleData['CustomURL']; } else { echo ""; }?>">
               </div>
            </div>
        </td>
    </tr>
    
    <!-- End Custom URL -->
    
    <!-- Custom Title -->
    
    <tr class="hideableRow">
        <td class="col-xs-3">
            <h5><strong><?php echo $text_custom_title; ?></strong></h5>
            <span class="help"><i class="fa fa-info-circle"></i>&nbsp;<?php echo $text_custom_title_help; ?></span></td>
        <td class="col-xs-9">
            <div class="col-xs-4">
                <div class="form-group" style="padding-top:10px;">
                    <input type="text" id="custom-title" class="form-control" name="<?php echo $moduleNameSmall; ?>[CustomTitle]" value="<?php if(isset($moduleData['CustomTitle'])) { echo $moduleData['CustomTitle']; } else { echo ""; }?>">
               </div>
            </div>
        </td>
    </tr>
    
    <!-- End Custom Title -->
    
    <!-- Custom CSS -->

	<tr class="hideableRow">
        <td class="col-xs-3">
        	<h5><strong><?php echo $custom_css; ?></strong></h5>
            <span class="help"><i class="fa fa-info-circle"></i>&nbsp;<?php echo $custom_css_help; ?></span></td>
        <td class="col-xs-9">
            <div class="col-xs-4">
                <div class="form-group" style="padding-top:10px;">
                    <textarea id="custom-css" class="form-control" name="<?php echo $moduleNameSmall; ?>[CustomCSS]" placeholder="<?php echo $custom_css_placeholder; ?>" rows="4"><?php if(isset($moduleData['CustomCSS'])) { echo $moduleData['CustomCSS']; } else { echo ""; }?></textarea>
                </div>
            </div>
        </td>
    </tr>
</table>
</div>

<script type="text/javascript">
    
    $(function() {
		var $typeSelector = $('#custom-status');
		var $toggleArea = $('.hideableRow');
		 if ($typeSelector.val() === '1') {
				$toggleArea.show();				
			}
			else {
				$toggleArea.hide();
				$('#custom-url').val("");
				$('#custom-title').val("");
				$('#custom-css').val("");
			}
		$typeSelector.change(function(){
			if ($typeSelector.val() === '1') {
				$toggleArea.show(300);
			}
			else {
				$toggleArea.hide(300);
				$('#custom-url').val("");
				$('#custom-title').val("");
				$('#custom-css').val("");
			}
		});
	});
    
</script>

