<?php if (isset($moduleData['Enabled']) && ($moduleData['Enabled']=='yes')) { ?>
<div class="addthis-container">
        <?php if(!empty($moduleData['CustomCSS'])): ?>
            <style>
                <?php echo htmlspecialchars_decode($moduleData['CustomCSS']); ?>
            </style>
        <?php endif; ?>   
            <div>  
            
				<script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js#pubid=<?php echo $moduleData['ID']; ?>" async="async">				
				
                </script>
                
                <div class="addthis_<?php echo $moduleData['ButtonsDesign']; ?>_toolbox" data-url="<?php if (!isset($moduleData['CustomURL'])){echo "";} else { echo $moduleData['CustomURL'];} ?>" data-title="<?php if (!isset($moduleData['CustomTitle'])){echo "";} else { echo $moduleData['CustomTitle'];} ?>"></div>
                
                <div class="addthis_recommended_<?php if (!isset($moduleData['Recommended']) || ($moduleData['Recommended'] != 'horizontal' && $moduleData['Recommended'] != 'vertical') ){echo "";} else { echo $moduleData['Recommended'];} ?>"></div>
				
            </div>
        
</div>
<?php } ?>