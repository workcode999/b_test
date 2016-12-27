<?php if (isset($moduleData['Enabled']) && ($moduleData['Enabled']=='yes')) { ?>
    
        <?php if(!empty($moduleData['CustomCSS'])): ?>
            <style>
                <?php echo htmlspecialchars_decode($moduleData['CustomCSS']); ?>
            </style>
        <?php endif; ?>  
                   
       <div class="container-fluid">
       
            <div>  
            
				<script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-558010d54d60791b" async="async">
                </script>
                
                <div class="addthis_<?php echo $moduleData['ButtonsDesign']; ?>_toolbox"></div>
                
                <div class="addthis_recommended_horizontal"></div>

            </div>
       </div>     
        
<?php } ?>