<table style="border-collapse: collapse; mso-table-lspace:0pt; mso-table-rspace:0pt;" cellpadding="0" cellspacing="0" border="0">
	<tr>
		<td width="2"></td>
		<td class="heading2" align="<?php echo $config['text_align']; ?>" style="-ms-text-size-adjust:100%; mso-line-height-rule:exactly; font-family:Helvetica, Arial, sans-serif; font-size:16px; line-height:20px; color:<?php echo $config['body_heading_color']; ?>; margin:0; padding: 0; font-weight:bold;"><strong>
			<?php echo $title; ?>
		</strong></td>
	</tr>
	<tr style="font-size:1px; line-height:0;"><td width="2" height="3">&nbsp;</td><td height="3">&nbsp;</td></tr>
	<tr style="font-size:1px; line-height:0;"><td width="2" height="1" bgcolor="#cccccc">&nbsp;</td><td height="1" bgcolor="#cccccc">&nbsp;</td></tr>
	<tr style="font-size:1px; line-height:0;"><td width="2" height="10">&nbsp;</td><td height="10">&nbsp;</td></tr>
</table>

<p class="standard" align="<?php echo $config['text_align']; ?>" style="-ms-text-size-adjust:100%; mso-line-height-rule:exactly; font-family:Helvetica, Arial, sans-serif; font-size:12px; line-height:18px; color:<?php echo $config['body_font_color']; ?>; margin-top:0px; margin-bottom:8px;">
	<strong><?php echo $text_name; ?></strong> <?php echo $name; ?>
</p>
<p class="standard" align="<?php echo $config['text_align']; ?>" style="-ms-text-size-adjust:100%; mso-line-height-rule:exactly; font-family:Helvetica, Arial, sans-serif; font-size:12px; line-height:18px; color:<?php echo $config['body_font_color']; ?>; margin-top:0px; margin-bottom:8px;">
	<strong><?php echo $text_email; ?></strong> <?php echo $email; ?>
</p>
<p class="standard" align="<?php echo $config['text_align']; ?>" style="-ms-text-size-adjust:100%; mso-line-height-rule:exactly; font-family:Helvetica, Arial, sans-serif; font-size:12px; line-height:18px; color:<?php echo $config['body_font_color']; ?>; margin-top:0px; margin-bottom:8px;">
	<strong><?php echo $text_enquiry; ?></strong><br /> <?php echo $enquiry; ?>
</p>

<table cellpadding="0" cellspacing="0" width="100%" style="width:100%; color:#666; table-layout:auto; border-collapse:separate; -moz-border-radius:3px; -moz-box-shadow:0 1px 2px #d1d1d1; -webkit-border-radius:3px; -webkit-box-shadow:0 1px 2px #d1d1d1; background:#eaebec; border:1px solid #e0e0e0; border-radius:3px; box-shadow:0 1px 2px #d1d1d1; text-shadow:1px 1px 0px #fff;">
<tbody>
	<?php $i = 0;
	foreach ($user_tracking as $key => $track) {
		if(($i++ % 2)){
			$row_style_background = "background:#f6f6f6;";
		} else {
			$row_style_background = "background:#fafafa;";
		}

		if(!empty($track)){
	?>
    <tr>
		<td style="padding:4px 5px; font-size:12px; border-bottom:1px solid #e0e0e0; <?php echo $row_style_background; ?>"><?php echo ucwords(str_replace('_', ' ', $key)); ?></td>
		<td style="word-wrap:break-word; padding:4px 5px; font-size:12px; border-bottom:1px solid #e0e0e0; border-left:1px solid #e0e0e0; <?php echo $row_style_background; ?>"><?php echo $track; ?></td>
	</tr>
	<?php }
	 } ?>
</tbody>
</table>

<table class="emailSpacer" cellpadding="0" cellspacing="0" width="100%" style="width:100%; table-layout:fixed; border-collapse:separate;">
<tr><td style="line-height: 0; font-size: 0;" height="15">&nbsp;</td></tr>
</table>

<p class="standard" align="<?php echo $config['text_align']; ?>" style="-ms-text-size-adjust:100%; mso-line-height-rule:exactly; font-family:Helvetica, Arial, sans-serif; font-size:12px; line-height:18px; color:<?php echo $config['body_font_color']; ?>; margin-top:0px; margin-bottom:0px;">
	<a href="<?php echo $store_url; ?>" style="color:#000000; text-decoration:none; font-weight:bold" target="_blank"><?php echo $store_name; ?></a>
</p>