<?php if(!empty($account_approve)){ ?>
<p class="link" align="<?php echo $config['text_align']; ?>" style="-ms-text-size-adjust:100%; mso-line-height-rule:exactly; font-family:Helvetica, Arial, sans-serif; font-size:12px; line-height:18px; color:<?php echo $config['body_font_color']; ?>; margin-top:5px; margin-bottom:15px;">
	<?php echo $text_approve; ?><br />
	<span style="line-height:100%; font-size:120%;">&raquo;</span>
	<a href="<?php echo $account_approve; ?>" style="color:<?php echo $config['body_link_color']; ?>; text-decoration:none;" target="_blank">
		<b><?php echo $account_approve; ?></b>
	</a>
</p>
<?php } ?>

<p class="standard" align="<?php echo $config['text_align']; ?>" style="-ms-text-size-adjust:100%; mso-line-height-rule:exactly; font-family:Helvetica, Arial, sans-serif; font-size:12px; line-height:18px; color:<?php echo $config['body_font_color']; ?>; margin-top:0px; margin-bottom:8px;">
	<strong><?php echo $text_name; ?></strong> <?php echo $firstname . ' ' . $lastname; ?>
</p>

<p class="standard" align="<?php echo $config['text_align']; ?>" style="-ms-text-size-adjust:100%; mso-line-height-rule:exactly; font-family:Helvetica, Arial, sans-serif; font-size:12px; line-height:18px; color:<?php echo $config['body_font_color']; ?>; margin-top:0px; margin-bottom:8px;">
	<strong><?php echo $text_email; ?></strong> <a href="mailto:<?php echo $email; ?>" style="color:<?php echo $config['body_link_color']; ?>; text-decoration:none; word-wrap:break-word;"><?php echo $email; ?></a>
</p>

<?php if(!empty($company)){ ?>
	<p class="standard" align="<?php echo $config['text_align']; ?>" style="-ms-text-size-adjust:100%; mso-line-height-rule:exactly; font-family:Helvetica, Arial, sans-serif; font-size:12px; line-height:18px; color:<?php echo $config['body_font_color']; ?>; margin-top:0px; margin-bottom:8px;">
		<strong><?php echo $text_company; ?></strong> <?php echo $company; ?>
	</p>
<?php } ?>

<?php if(!empty($telephone)){ ?>
	<p class="standard" align="<?php echo $config['text_align']; ?>" style="-ms-text-size-adjust:100%; mso-line-height-rule:exactly; font-family:Helvetica, Arial, sans-serif; font-size:12px; line-height:18px; color:<?php echo $config['body_font_color']; ?>; margin-top:0px; margin-bottom:8px;">
		<strong><?php echo $text_telephone; ?></strong> <?php echo $telephone; ?>
	</p>
<?php } ?>

<?php if(!empty($fax)){ ?>
	<p class="standard" align="<?php echo $config['text_align']; ?>" style="-ms-text-size-adjust:100%; mso-line-height-rule:exactly; font-family:Helvetica, Arial, sans-serif; font-size:12px; line-height:18px; color:<?php echo $config['body_font_color']; ?>; margin-top:0px; margin-bottom:8px;">
		<strong><?php echo $text_fax; ?></strong> <?php echo $fax; ?>
	</p>
<?php } ?>

<?php if(!empty($address)){ ?>
<p class="standard" align="<?php echo $config['text_align']; ?>" style="-ms-text-size-adjust:100%; mso-line-height-rule:exactly; font-family:Helvetica, Arial, sans-serif; font-size:12px; line-height:18px; color:<?php echo $config['body_font_color']; ?>; margin-top:0px; margin-bottom:8px;">
	<strong><?php echo $text_address; ?></strong><br /><?php echo $address; ?>
</p>
<?php } ?>

<?php if(!empty($newsletter)){ ?>
<p class="standard" align="<?php echo $config['text_align']; ?>" style="-ms-text-size-adjust:100%; mso-line-height-rule:exactly; font-family:Helvetica, Arial, sans-serif; font-size:12px; line-height:18px; color:<?php echo $config['body_font_color']; ?>; margin-top:0px; margin-bottom:8px;">
	<strong><?php echo $text_newsletter; ?></strong> <?php echo $newsletter; ?>
</p>
<?php } ?>

<?php if(!empty($customer_group)){ ?>
	<p class="standard" align="<?php echo $config['text_align']; ?>" style="-ms-text-size-adjust:100%; mso-line-height-rule:exactly; font-family:Helvetica, Arial, sans-serif; font-size:12px; line-height:18px; color:<?php echo $config['body_font_color']; ?>; margin-top:0px; margin-bottom:0px;">
		<strong><?php echo $text_customer_group; ?></strong> <?php echo $customer_group; ?>
	</p>
<?php } ?>