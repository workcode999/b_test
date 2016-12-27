<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<meta name="Robots" content="all" />
	<meta name="MSSmartTagsPreventParsing" content="true" />
    <meta name="viewport" content="initial-scale=1.0" />
    <meta name="format-detection" content="telephone=no" />
    <meta name="author" content="Opencart-Templates" />

	<title><?php echo $title; ?></title>
</head>
<body style="width:100% !important; min-width:100%; height:100%; margin-top:0 !important; margin-right:0 !important; margin-bottom:0 !important; margin-left:0 !important; padding:0 !important; background:<?php echo $config['body_bg_color']; ?> !important; font-family:'Helvetica Neue','Helvetica',Helvetica,Arial,sans-serif; font-size:14px; line-height:normal; -webkit-text-size-adjust:none; -ms-text-size-adjust:none;" text="<?php echo $config['body_font_color']; ?>" link="<?php echo $config['body_link_color']; ?>" alink="<?php echo $config['body_link_color']; ?>" vlink="<?php echo $config['body_link_color']; ?>" leftmargin="0" marginwidth="0" topmargin="0" marginheight="0" offset="0">
<table id="emailWrapper" style="table-layout:fixed; border-collapse:collapse; border:none; mso-table-lspace:0pt; mso-table-rspace:0pt; width:100%;" width="100%" cellpadding="0" cellspacing="0" border="0" bgcolor="<?php echo $config['body_bg_color']; ?>">
    <?php if(!empty($config['head_text']) || !empty($config['shadow_top']['bg'])){ ?>
    <tr>
    	<td class="emailWrapper" bgcolor="<?php echo $config['body_bg_color']; ?>" width="100%" style="width:100%; font-family:'Helvetica Neue','Helvetica',Helvetica,Arial,sans-serif; font-size:14px; line-height:normal; color:<?php echo $config['body_font_color']; ?>;">

    	<table class="emailHead" border="0" cellspacing="0" cellpadding="0" width="100%" style="table-layout:fixed; width:100%; border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt;">
			<tr>
				<td width="100%" align="center" valign="top" style="text-align:center; width:100%; vertical-align:top" bgcolor="<?php echo ($config['head_section_bg_color']) ? $config['head_section_bg_color'] : $config['body_bg_color']; ?>">
					<center>
					<!--[if mso]>
						<table align="center" border="0" cellspacing="0" cellpadding="0" width="<?php echo $config['email_full_width']; ?>" style="width:<?php echo $config['email_full_width']; ?>; border:none; border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt;">
							<tr><td width="<?php echo $config['email_full_width']; ?>" style="width:<?php echo $config['email_full_width']; ?>px;">
					<![endif]-->
					<div style="max-width:<?php echo $config['email_full_width']; ?>px; margin-left:auto; margin-right:auto;" align="center">
					<table class="mainContainer" width="100%" cellpadding="0" cellspacing="0" border="0" style="table-layout:fixed; border:none; width:100%; max-width:<?php echo $config['email_full_width']; ?>px; border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt;">
            			<?php if(!empty($config['head_text'])){ ?>
            			<tr>
            				<td width="100%" style="width:100%;">
            					<table class="emailHeadText" border="0" cellspacing="0" cellpadding="0" width="100%" style="table-layout:auto; width:100%; border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt;">
									<tr>
										<td><?php echo $config['head_text']; ?></td>
									</tr>
								</table>
            				</td>
            			</tr>
            			<?php } ?>
            			<tr>
            				<td width="100%" style="width:100%;">
                				<?php if(!empty($config['shadow_top']['bg'])){ ?>
                				<table border="0" cellspacing="0" cellpadding="0" width="100%" style="table-layout:fixed; width:100%; border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt;">
                					<tr>
                						<?php if($config['shadow_top']['left_img']){ ?>
                						<td width="<?php echo $config['shadow_top']['left_img_width']; ?>" height="<?php echo $config['shadow_top']['left_img_height']; ?>" style="width:<?php echo $config['shadow_top']['left_img_width']; ?>px; height:<?php echo $config['shadow_top']['left_img_height']; ?>px; font-size:1px; line-height:0; vertical-align:top" valign="top">
                							<img src="<?php echo $config['shadow_top']['left_img']; ?>" width="<?php echo $config['shadow_top']['left_img_width']; ?>" height="<?php echo $config['shadow_top']['left_img_height']; ?>" alt="" style="border:none;" />
                						</td>
                						<?php } ?>
                						<td valign="top" style="vertical-align:top">
                							<table class="emailShadow emailShadowTop" border="0" cellspacing="0" cellpadding="0" width="100%" style="table-layout:fixed; width:100%; border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt;">
												<?php echo $config['shadow_top']['bg']; ?>
												<tr>
													<td height="<?php echo $config['shadow_top']['overlap']; ?>" style="height:<?php echo $config['shadow_top']['overlap']; ?>px; font-size:1px; line-height:0; mso-margin-top-alt:1px; background-color:<?php echo $config['header_bg_color']; ?>;" bgcolor="<?php echo $config['header_bg_color']; ?>">&nbsp;</td>
												</tr>
											</table>
                						</td>
                						<?php if($config['shadow_top']['right_img']){ ?>
                						<td width="<?php echo $config['shadow_top']['right_img_width']; ?>" height="<?php echo $config['shadow_top']['right_img_height']; ?>" style="width:<?php echo $config['shadow_top']['right_img_width']; ?>px; height:<?php echo $config['shadow_top']['right_img_height']; ?>px; font-size:1px; line-height:0; vertical-align:top" valign="top">
                							<img src="<?php echo $config['shadow_top']['right_img']; ?>" width="<?php echo $config['shadow_top']['right_img_width']; ?>" height="<?php echo $config['shadow_top']['right_img_height']; ?>" alt="" style="border:none;" />
                						</td>
                						<?php } ?>
                					</tr>
								</table>
								<?php } ?>
							</td>
						</tr>
					</table>
					</div>
					<!--[if mso]>
							</td></tr>
						</table>
					<![endif]-->
					</center>
				</td>
			</tr>
		</table>

		</td>
	</tr>
    <?php } ?>
    <tr>
    	<td class="emailWrapper" bgcolor="<?php echo $config['body_bg_color']; ?>" width="100%" style="width:100%; font-family:'Helvetica Neue','Helvetica',Helvetica,Arial,sans-serif; font-size:14px; line-height:normal; color:<?php echo $config['body_font_color']; ?>;">
	    	<table class="emailHeader" border="0" cellspacing="0" cellpadding="0" width="100%" style="table-layout:fixed; width:100%; border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt;">
				<tr>
					<td width="100%" align="center" valign="top" style="text-align:center; width:100%; vertical-align:top" bgcolor="<?php echo ($config['header_section_bg_color']) ? $config['header_section_bg_color'] : $config['body_bg_color']; ?>">
						<center>
						<!--[if mso]>
							<table align="center" border="0" cellspacing="0" cellpadding="0" width="<?php echo $config['email_full_width']; ?>" style="width:<?php echo $config['email_full_width']; ?>; border:none; border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt;">
								<tr><td width="<?php echo $config['email_full_width']; ?>" style="width:<?php echo $config['email_full_width']; ?>px;">
						<![endif]-->
						<div style="width: 100%; max-width:<?php echo $config['email_full_width']; ?>px; margin-left:auto; margin-right:auto;" align="center">
						<table class="mainContainer" width="100%" cellpadding="0" cellspacing="0" border="0" align="center" height="<?php echo $config['header_height']; ?>" style="table-layout:auto; border:none; height:<?php echo $config['header_height']; ?>px; width:100%; max-width:<?php echo $config['email_full_width']; ?>px; border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt;">
            				<tr>
            					<?php if($config['shadow_left']['bg']) echo $config['shadow_left']['bg']; ?>
                				<td>
									<table class="emailHeader" border="0" cellspacing="0" cellpadding="0" width="100%" style="table-layout:fixed; width:100%; border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt; <?php if($config['header_bg_image']){ echo " background-image:url('".$config['header_bg_image']."');"; } ?>background-color:<?php echo $config['header_bg_color']; ?>;" <?php if($config['header_bg_image']){ ?> background="<?php echo $config['header_bg_image']; ?>"<?php } ?> bgcolor="<?php echo $config['header_bg_color']; ?>">
                						<tr>
											<td width="100%" style="width:100%; height:<?php echo $config['header_height']; ?>px;" height="<?php echo $config['header_height']; ?>" valign="<?php echo $config['logo_valign']; ?>" align="<?php echo $config['logo_align']; ?>">
			                					<?php if($config['header_bg_image']){ ?>
												<!--[if gte mso 9]>
													<v:image xmlns:v="urn:schemas-microsoft-com:vml" id="HeaderImage" style='behavior:url(#default#VML);display:inline-block;position:absolute; height:<?php echo $config['header_height']; ?>px; width:<?php echo $config['email_width']; ?>px;top:0;left:0;border:0;z-index:1;' src="<?php echo $config['header_bg_image']; ?>"/>
													<v:shape xmlns:v="urn:schemas-microsoft-com:vml" id="HeaderText" style='behavior:url(#default#VML);display:inline-block;position:absolute;visibility:visible;height:<?php echo $config['header_height']-5; ?>px;width:<?php echo $config['email_width']; ?>px;background-color:transparent;top:-5px;left:-10px;border:0;z-index:2;' stroked='f'>
													<div>
												<![endif]-->
												<?php } ?>
												<table cellspacing="0" cellpadding="0" border="0" width="100%" height="<?php echo $config['header_height']; ?>" style="width:100%; height:<?php echo $config['header_height']; ?>px;">
													<tr>
														<td width="100%" style="width:100%; height:<?php echo $config['header_height']; ?>px; text-align:<?php echo $config['logo_align']; ?>; vertical-align:<?php echo $config['logo_valign']; ?>" height="<?php echo $config['header_height']; ?>" valign="<?php echo $config['logo_valign']; ?>" align="<?php echo $config['logo_align']; ?>">
															<a href="<?php echo $store_url; ?>" target="_blank" title="<?php echo $store_name; ?>" style="display:block; text-decoration:none; font-size:<?php echo $config['logo_font_size']; ?>px; font-weight:bold; color:<?php echo $config['logo_font_color']; ?>;">
																<?php if(isset($config['logo'])){ ?>
						        									<img class="emailLogo emailStretch" src="<?php echo $config['logo']; ?>" alt="<?php echo $store_name; ?>" border="0" style="outline:none; text-decoration:none; -ms-interpolation-mode:bicubic; display:inline; border:none; max-width:100% !important;" height="<?php echo $config['logo_height']; ?>" width="<?php echo $config['logo_width']; ?>" />
						        								<?php } else { ?>
						        				 					<?php echo $store_name; ?>
						        				 				<?php } ?>
					        				 				</a>
														</td>
													</tr>
												</table>
		        				 				<?php if($config['header_bg_image']){ ?>
												<!--[if gte mso 9]>
													</div>
													</v:shape>
												<![endif]-->
												<?php } ?>
											</td>
										</tr>
									</table>
									<?php if($config['header_border_color']){ ?>
									<table class="emailHeaderBorder" border="0" cellspacing="0" cellpadding="0" width="100%" style="table-layout:fixed; width:100%; border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt;" bgcolor="<?php echo $config['header_border_color']; ?>">
										<tr>
											<td width="100%" height="2" align="center" valign="top" style="vertical-align:top; text-align:center; width:100%; font-size:1px; line-height:0; height:2px;">&nbsp;</td>
										</tr>
									</table>
									<?php } ?>
								</td>
								<?php if($config['shadow_right']['bg']) echo $config['shadow_right']['bg']; ?>
							</tr>
						</table>
						</div>
						<!--[if mso]>
								</td></tr>
							</table>
						<![endif]-->
						</center>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
    	<td class="emailWrapper" bgcolor="<?php echo $config['body_bg_color']; ?>" width="100%" style="width:100%; font-family:'Helvetica Neue','Helvetica',Helvetica,Arial,sans-serif; font-size:14px; line-height:normal; color:<?php echo $config['body_font_color']; ?>;">
	    	<table class="emailPage" border="0" cellspacing="0" cellpadding="0" width="100%" style="table-layout:fixed; width:100%; border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt;">
				<tr>
					<td width="100%" align="center" valign="top" style="text-align:center; width:100%; vertical-align:top;" bgcolor="<?php echo ($config['body_section_bg_color']) ? $config['body_section_bg_color'] : $config['body_bg_color']; ?>">
						<center>
						<!--[if mso]>
							<table align="center" border="0" cellspacing="0" cellpadding="0" width="<?php echo $config['email_full_width']; ?>" style="width:<?php echo $config['email_full_width']; ?>; border:none; border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt;">
								<tr><td width="<?php echo $config['email_full_width']; ?>" style="width:<?php echo $config['email_full_width']; ?>px;">
						<![endif]-->
						<div style="width:100%; max-width:<?php echo $config['email_full_width']; ?>px; margin-left:auto; margin-right:auto;" align="center">
						<table class="mainContainer" width="100%" cellpadding="0" cellspacing="0" border="0" style="table-layout:auto; border:none; width:100%; max-width:<?php echo $config['email_full_width']; ?>px; border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt;" align="center">
            				<tr>
                				<?php if($config['shadow_left']['bg']) echo $config['shadow_left']['bg']; ?>
                				<td>
									<table class="emailMainText" border="0" cellspacing="0" cellpadding="25" width="100%" style="table-layout:fixed; width:100%; border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt;" bgcolor="<?php echo $config['page_bg_color']; ?>">
                						<tr>
											<td style="padding:25px; text-align:<?php echo $config['text_align']; ?>; font-family:'Helvetica Neue','Helvetica',Helvetica,Arial,sans-serif; font-size:14px; line-height:normal; color:<?php echo $config['body_font_color']; ?>;" align="<?php echo $config['text_align']; ?>">
												{CONTENT}
											</td>
										</tr>
										<?php if($config['page_footer_text']){ ?>
                							<tr>
                								<td style="padding:25px"><?php echo $config['page_footer_text']; ?></td>
                							</tr>
										<?php } ?>
									</table>
								</td>
								<?php if($config['shadow_right']['bg']) echo $config['shadow_right']['bg']; ?>
							</tr>
						</table>
						</div>
						<!--[if mso]>
								</td></tr>
							</table>
						<![endif]-->
						</center>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
    	<td class="emailWrapper" bgcolor="<?php echo $config['body_bg_color']; ?>" width="100%" style="width:100%; font-family:'Helvetica Neue','Helvetica',Helvetica,Arial,sans-serif; font-size:14px; line-height:normal; color:<?php echo $config['body_font_color']; ?>;">
	    	<table class="emailFooter" border="0" cellspacing="0" cellpadding="0" width="100%" style="table-layout:fixed; width:100%; border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt;">
				<tr>
					<td width="100%" align="center" valign="top" style="text-align:center; width:100%; vertical-align:top;" bgcolor="<?php echo ($config['footer_section_bg_color']) ? $config['footer_section_bg_color'] : $config['body_bg_color']; ?>">
						<center>
						<!--[if mso]>
							<table align="center" border="0" cellspacing="0" cellpadding="0" width="<?php echo $config['email_full_width']; ?>" style="width:<?php echo $config['email_full_width']; ?>; border:none; border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt;">
								<tr><td width="<?php echo $config['email_full_width']; ?>" style="width:<?php echo $config['email_full_width']; ?>px;">
						<![endif]-->
						<div style="width:100%; max-width:<?php echo $config['email_full_width']; ?>px; margin-left:auto; margin-right:auto;" align="center">
						<table class="mainContainer" width="100%" cellpadding="0" cellspacing="0" border="0" style="table-layout:fixed; border:none; width:100%; max-width:<?php echo $config['email_full_width']; ?>px; border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt;" align="center">
            				<tr>
                				<td width="100%" style="width:100%">

									<?php if($config['shadow_bottom']){ ?>
                					<table border="0" cellspacing="0" cellpadding="0" width="100%" style="table-layout:auto; width:100%; border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt;">
                						<tr>
                							<?php if($config['shadow_bottom']['left_img']){ ?>
                							<td width="<?php echo $config['shadow_bottom']['left_img_width']; ?>" height="<?php echo $config['shadow_bottom']['left_img_height']; ?>" style="width:<?php echo $config['shadow_bottom']['left_img_width']; ?>px; height:<?php echo $config['shadow_bottom']['left_img_height']; ?>px; vertical-align:top; font-size:1px; line-height:0;" valign="top">
                								<img src="<?php echo $config['shadow_bottom']['left_img']; ?>" width="<?php echo $config['shadow_bottom']['left_img_width']; ?>" height="<?php echo $config['shadow_bottom']['left_img_height']; ?>" alt="" border="0" style="outline:none; text-decoration:none; -ms-interpolation-mode:bicubic; display:inline; border:none" />
                							</td>
                							<?php } ?>
                							<td valign="top" style="vertical-align:top">
                								<table class="emailShadow emailShadowBottom" border="0" cellspacing="0" cellpadding="0" width="100%" style="table-layout:fixed; width:100%; border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt;">
                									<?php if($config['shadow_bottom']['overlap']){ ?>
                										<tr><td height="<?php echo $config['shadow_bottom']['overlap']; ?>" bgcolor="<?php echo $config['page_bg_color']; ?>" style="height:<?php echo $config['shadow_bottom']['overlap']; ?>px; font-size:1px; line-height:0; mso-margin-top-alt:1px">&nbsp;</td></tr>
                									<?php } ?>
													<?php echo $config['shadow_bottom']['bg']; ?>
												</table>
                							</td>
                							<?php if($config['shadow_bottom']['right_img']){ ?>
                							<td width="<?php echo $config['shadow_bottom']['right_img_width']; ?>" height="<?php echo $config['shadow_bottom']['right_img_height']; ?>" style="width:<?php echo $config['shadow_bottom']['right_img_width']; ?>px; height:<?php echo $config['shadow_bottom']['right_img_height']; ?>px; vertical-align:top; font-size:1px; line-height:0;" valign="top">
                								<img src="<?php echo $config['shadow_bottom']['right_img']; ?>" width="<?php echo $config['shadow_bottom']['right_img_width']; ?>" height="<?php echo $config['shadow_bottom']['right_img_height']; ?>" alt="" border="0" style="outline:none; text-decoration:none; -ms-interpolation-mode:bicubic; display:inline; border:none" />
                							</td>
                							<?php } ?>
                						</tr>
									</table>
									<?php } ?>

									<table class="emailFooterText" border="0" cellspacing="0" cellpadding="0" width="100%" height="<?php echo $config['footer_height']; ?>" style="table-layout:fixed; width:100%; height:<?php echo $config['footer_height']; ?>px; border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt;">
                						<tr>
											<td class="legal" style="width:100%; height:<?php echo $config['footer_height']; ?>px; font-family:'Helvetica Neue','Helvetica',Helvetica,Arial,sans-serif; font-size:11px; line-height:normal; color:<?php echo $config['footer_font_color']; ?>; text-align:<?php echo $config['footer_align']; ?>; vertical-align:<?php echo $config['footer_valign']; ?>" valign="<?php echo $config['footer_valign']; ?>" height="<?php echo $config['footer_height']; ?>" width="100%">
												<?php if(isset($unsubscribe)){ ?>
                									<p class="standard" align="<?php echo $config['text_align']; ?>" style="-ms-text-size-adjust:100%; mso-line-height-rule:exactly; font-size:11px; line-height:18px; color:<?php echo $config['footer_font_color']; ?>; padding:0 0 8px 0; margin:0;">
                										<?php echo $unsubscribe; ?>
                									</p>
												<?php } ?>

												<?php echo $config['footer_text']; ?>
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
						</div>
						<!--[if mso]>
								</td></tr>
							</table>
						<![endif]-->
						</center>
					</td>
				</tr>
			</table>
        </td>
    </tr>
    <tr>
		<td height="30" style="height:30px; font-size:1px; line-height:0; mso-margin-top-alt:1px">&nbsp;</td>
	</tr>
</table>

<style type="text/css">
	/* Client-specific Styles */
	v\:* { behavior: url(#default#VML); display:inline-block} /* background image hack for outlook */
	table { border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt; }   /* table hacks mainly for outlook */
	#outlook a { padding:0 } /* Force Outlook to provide a "view in browser" button. */
	body { width:100% !important } .ReadMsgBody { width:100% } .ExternalClass { width:100% } /* Force Hotmail to display emails at full width */
	body { -webkit-text-size-adjust:none } /* Prevent Webkit platforms from changing default text sizes. */
	img { -ms-interpolation-mode: bicubic } /* Make Microsoft apps scale images properly. */

	.link span, .link span:hover, .link span:active, .link span:focus { color:#333333 !important; border-bottom:none !important; background:none !important; text-decoration:none !important;  }
	.link a:link, .link a:visited, .link a:active { color:#28B0EC; text-decoration:none; }
	.link a:hover, .link a:focus { color:#28B0EC; text-decoration:underline !important; }

	.legal span, .legal span:hover, .legal span:active, .legal span:focus { color:#333333 !important; border-bottom:none !important; background:none !important; }
	.legal a span, .legal a span:hover, .legal a span:active, .legal a span:focus { color:#28B0EC !important; border-bottom:none !important; background:none !important; }
	.legal a:link, .legal a:visited, .legal a:active { color:#28B0EC; text-decoration:none; }
	.legal a:focus, .legal a:hover { color:#28B0EC; text-decoration:underline !important; }

	@media screen and (max-width: 489px) {
		#emailWrapper .tableStack, #emailWrapper .tableStack tbody, #emailWrapper .tableStack tr {
			display: block !important;
			width: 100% !important
		}
			#emailWrapper .tableStack td {
				display: block !important;
				padding-bottom: 8px !important;
				width: auto !important;
			}
			#emailWrapper .tableStack td.last-child {
				border-top: 1px solid #E0E0E0 !important;
				border-left: none !important;
			}
		#emailWrapper .productImage {
			float: none !important;
			display: block !important;
		}
		#emailWrapper .clearMobile {
			clear: both !important;
		}
	}

	@media all and (max-width: <?php echo $config['email_full_width']; ?>px) {
		img[class=emailStretch] { width:100% !important; height:auto !important; max-width:<?php echo $config['email_width']; ?>px !important; display:block !important; }
	}
	/* Developer: Opencart-Templates */
</style>

</body>
</html>