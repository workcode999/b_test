<div class="buttons">
<div class="right" >
<input id="button-confirm" class="button" type="button" value="<?php echo $button_confirm; ?>" >
</div>
</div>
<script type="text/javascript"><!--
	$("#button-confirm").bind("click",function(){
		$.ajax({
			type: "GET",
			url: "index.php?route=payment/creditcard/confirm",
                        beforeSend: function() {
			$('#button-confirm').attr('disabled', true);
		        },	
			success: function()
			{
			location = 'index.php?route=payment/creditcard/creditcardiframe';
			}
		});
	});
//--></script>
