<div class="container-fluid">
<table class="table">
 <tr>
    <td class="col-xs-3">
    	<h5><span class="required">* </span><strong><?php echo $entry_code; ?></strong></h5>
        <span class="help"><i class="fa fa-info-circle"></i>&nbsp;<?php echo $entry_code_help; ?></span></td>
    <td class="col-xs-9">
        <div class="col-xs-4">
        	<select id="Checker" name="<?php echo $moduleNameSmall; ?>[Enabled]" class="form-control">
                  <option value="yes" <?php echo (!empty($moduleData['Enabled']) && $moduleData['Enabled'] == 'yes') ? 'selected=selected' : '' ?>><?php echo $text_enabled; ?></option>
                  <option value="no"  <?php echo (empty($moduleData['Enabled']) || $moduleData['Enabled'] == 'no') ? 'selected=selected' : '' ?>><?php echo $text_disabled; ?></option>
            </select>
            
        </div>
    </td>
    </tr>
    
    <!-- ID -->  
      
    <tr>    
        <td class="col-xs-3">        
            <h5><span class="required">* </span><strong><?php echo $text_id; ?></strong></h5>
            <span class="help"><i class="fa fa-info-circle"></i>&nbsp;<?php echo $text_id_help; ?><a href="https://www.addthis.com/" target="_blank"> www.addthis.com </a><?php echo $text_id_help_two; ?></span>
        </td>
        <td class="col-xs-9">
            <div class="col-xs-4">
                <div class="form-group" style="padding-top:10px;">
                    <input type="text" id="id-status" class="form-control" name="<?php echo $moduleNameSmall; ?>[ID]" value="<?php if(isset($moduleData['ID'])) { echo $moduleData['ID']; } else { echo ""; }?>">
               </div>
               
               <?php if ($error_id) { ?>
            <div class="text-danger autoSlideUp"><i class="fa fa-exclamation-circle"></i> <?php echo $error_id; ?>             
            </div>
        <?php } ?>
            </div>
        </td>
    </tr>

    <!-- End ID -->
    
    <!-- Inherent AddThis -->
    
    <tr>
    <td class="col-xs-3">
    	<h5><strong><?php echo $entry_addthis; ?></strong></h5>
        <span class="help"><i class="fa fa-info-circle"></i>&nbsp;<?php echo $entry_addthis_help; ?></span></td>
    <td class="col-xs-9">
        <div class="col-xs-4">
        	<select id="inherent-status" name="<?php echo $moduleNameSmall; ?>[Inherent]" class="form-control">
                  <option value="1" <?php echo (!empty($moduleData['Inherent']) && $moduleData['Inherent'] == '1') ? 'selected=selected' : '' ?>><?php echo $text_enabled; ?></option>
                  <option value="0"  <?php echo (empty($moduleData['Inherent']) || $moduleData['Inherent']== '0') ? 'selected=selected' : '' ?>><?php echo $text_disabled; ?></option>
            </select>
        </div>
    </td>
    </tr>
    
    <!-- End Inherent AddThis -->
    
    <!-- Inherent Design -->
    
    <tr class="hideableDesign">
    <td class="col-xs-3">
    	<h5><strong><?php echo $text_inherent_design; ?></strong></h5>
        <span class="help"><i class="fa fa-info-circle"></i>&nbsp;<?php echo $text_inherent_design_help; ?></span></td>
    <td class="col-xs-9">
        <div class="col-xs-4">
        	<select id="design-status" name="<?php echo $moduleNameSmall; ?>[InherentDesign]" class="form-control">
                  <option value="1" <?php echo (!empty($moduleData['InherentDesign']) && $moduleData['InherentDesign'] == '1') ? 'selected=selected' : '' ?>><?php echo $text_enabled; ?></option>
                  <option value="0"  <?php echo (empty($moduleData['InherentDesign']) || $moduleData['InherentDesign']== '0') ? 'selected=selected' : '' ?>><?php echo $text_disabled; ?></option>
            </select>
        </div>
    </td>
    </tr>
    
    <!-- End Inherent Design -->
    
    <!-- Enable Customization -->
    
    <tr class="hideableDesign">
    <td class="col-xs-3">
    	<h5><strong><?php echo $text_enable_customization; ?></strong></h5>
        <span class="help"><i class="fa fa-info-circle"></i>&nbsp;<?php echo $text_enable_customization_help; ?></span></td>
    <td class="col-xs-9">
        <div class="col-xs-4">
        	<select id="customize-status" name="<?php echo $moduleNameSmall; ?>[InherentCustom]" class="form-control">
                  <option value="1" <?php echo (!empty($moduleData['InherentCustom']) && $moduleData['InherentCustom'] == '1') ? 'selected=selected' : '' ?>><?php echo $text_enabled; ?></option>
                  <option value="0"  <?php echo (empty($moduleData['InherentCustom']) || $moduleData['InherentCustom']== '0') ? 'selected=selected' : '' ?>><?php echo $text_disabled; ?></option>
            </select>
        </div>
    </td>
    </tr>
</table>
</div>
<script>
$(function() {
	
    var $typeSelector = $('#Checker');
	var $toggleArea2 = $('#mainSettingsTab');	
	
	 if ($typeSelector.val() === 'yes') {
			$toggleArea2.show();			
        }
        else {
			$toggleArea2.hide();
			
        }
    $typeSelector.change(function(){
        if ($typeSelector.val() === 'yes') {
			$toggleArea2.show(300);			
        }
        else {
			$toggleArea2.hide(300);			
        }	
		
    });
	
});
</script>
<script type="text/javascript">
$(function() {
	
	var $design = $('#inherent-status');
	var $toggleDesign = $('.hideableDesign');
	if ($design.val() === '1') {
				$toggleDesign.show();				
			}
		else {
				$toggleDesign.hide();
				$('#design-status').val('0');
				$('#customize-status').val('0');
			}
		$design.change(function(){
			if ($design.val() === '1') {
				$toggleDesign.show(300);
			}
			else {
				$toggleDesign.hide(300);
				$('#design-status').val('0');
				$('#customize-status').val('0');
			}
		});
});
</script>
