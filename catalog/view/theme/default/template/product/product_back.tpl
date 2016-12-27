<?php echo $header; ?>
<style>	
	#product .pds 
	{
		margin: 0 0 5px 2px;
		float: left;
	}
	.product-thumb .pds
	{
		height: 28px;
		margin-top: 5px;
		overflow: hidden;
	}
	.pds .pds_pics 
	{
		float: left;
		width: 28px;
		height: 28px;
		margin: 0 2px 0 0;
		position: relative;
	}
	.pds .pds_pics a {
		width: 28px;
		height: 28px;
		cursor: pointer;
		display: block;
		border: 2px solid #ffffff;
	}
	.pds .pds_pics a img {
		cursor: pointer;
		width: 24px;
		height: 24px;
	}
	.pds .pds_pics.selected a
	{
		border-color: #ff0000;									
	}
	.pds a.preview
	{
		display: inline-block;
	}
	#product .pds .pds_pics
	{
		float: left;
		width: 30px;
		height: 30px;
		margin: 0;
		position: relative;
	}
	#product .pds .pds_pics a {
		width: 30px;
		height: 30px;
		padding: 1px;
		cursor: pointer;
		display: block;
		border: 2px solid #ffffff;
	}
	#product .pds .pds_pics.pds-current a
	{
		border-color: #ff0000;									
	}
	#product .form-group
	{
		clear: both;
	}
	#preview{
		position: absolute;
		border: 1px solid #DBDEE1;
		background: #F8F8F8;
		padding: 5px;
		display: none;
		color: #333;
		z-index: 1000000;
	}
</style>
<div class="container">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
  <div class="row"><?php echo $column_left; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-sm-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-sm-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-sm-12'; ?>
    <?php } ?>
    <div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>
      <div class="row">
		<div>
			<div class="shareMore2">
				<span class="onfacebook2"><a onclick="window.open(this.href,this.window,'height=320,width=700,top='+($(window).height()/3)+',left='+($(window).width()/3));return false;" href="http://www.facebook.com/sharer/sharer.php?u=<?php echo $product_link; ?>"><img src="catalog/view/javascript/bootstrap/image/facebook.png" alt="facebook"></a></span>
			    <span class="onpinterest2"><a onclick="window.open(this.href,this.window,'height=320,width=700,top='+($(window).height()/3)+',left='+($(window).width()/3));return false;" href="http://pinterest.com/pin/create/button/?url=<?php echo $product_link; ?>&media=<?php echo $data['images'][0]['popup']; ?>&description=<?php echo $heading_title; ?>"><img src="catalog/view/javascript/bootstrap/image/pinterest.png" alt="pinterest"></a></span>
				<span class="ontwitter2"><a onclick="window.open(this.href,this.window,'height=320,width=700,top='+($(window).height()/3)+',left='+($(window).width()/3));return false;" href="http://twitter.com/share?text=I love this dress so much!&url=<?php echo $product_link; ?>"><img src="catalog/view/javascript/bootstrap/image/twitter.png" alt="twitter"></a></span>
				<span class="ongoogle_plus2"><a onclick="window.open(this.href,this.window,'height=320,width=700,top='+($(window).height()/3)+',left='+($(window).width()/3));return false;" href="https://plus.google.com/share?hl=en&amp;url=<?php echo $product_link; ?>"><img src="catalog/view/javascript/bootstrap/image/google_plus.png" alt="google_plus"></a></span>
			</div>
		</div>
        <?php if ($column_left && $column_right) { ?>
        <?php $class = 'col-sm-6'; ?>
        <?php } elseif ($column_left || $column_right) { ?>
        <?php $class = 'col-sm-6'; ?>
        <?php } else { ?>
        <?php $class = 'col-sm-4'; ?>
        <?php } ?>
        <div class="<?php echo $class; ?>">
          <?php if ($thumb || $images) { ?>
				<div id="carousel<?php echo $product_id; ?>" class="owl-carousel">
					<div class="item text-center">
						<a class="thumbnail" href="<?php echo $popup; ?>" title="<?php echo $heading_title; ?>"><img src="<?php echo $thumb; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" /></a>
					</div>
					<?php if ($images) { ?>
						<?php foreach ($images as $image) { ?>
							<div class="item text-center"><a class="thumbnail" href="<?php echo $image['popup']; ?>" title="<?php echo $heading_title; ?>"> <img src="<?php echo $image['thumb']; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" /></a></div>
						<?php } ?>
					<?php } ?>
				</div>
          <?php } ?>

          <?php if ($review_status) { ?>
          <div class="rating">
            <!-- AddThis Button BEGIN -->
	    <!--<div class="addthis_toolbox addthis_default_style"><a class="addthis_button_facebook_like" fb:like:layout="button_count"></a> <a class="addthis_button_tweet"></a> <a class="addthis_button_pinterest_pinit"></a> <a class="addthis_counter addthis_pill_style"></a></div>-->	    
            <?php if ($addthisData['Inherent'] == '1' && $addthisData['InherentDesign'] == '1'){ ?>
				  <div class="addthis_native_toolbox"></div>
                  <script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js#pubid=<?php echo $addthisData['ID']; ?>"></script>
          <?php } elseif ($addthisData['Inherent'] != '1' && $addthisData['InherentDesign'] != '1') { ?>
                  <!-- --> 
                  <?php } else { ?>  		
           <div class="addthis_native_toolbox"></div>
            <script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-56173bb5d7515416"></script>
			<?php } ?>
            <!-- AddThis Button END -->
          </div>
		 <div>
			<div class="shareMore">
				<span class="onfacebook"><a onclick="window.open(this.href,this.window,'height=320,width=700,top='+($(window).height()/3)+',left='+($(window).width()/3));return false;" href="http://www.facebook.com/sharer/sharer.php?u=<?php echo $product_link; ?>"><img src="catalog/view/javascript/bootstrap/image/facebook.png" alt="facebook"></a></span>
				<span class="onpinterest"><a onclick="window.open(this.href,this.window,'height=320,width=700,top='+($(window).height()/3)+',left='+($(window).width()/3));return false;" href="http://pinterest.com/pin/create/button/?url=<?php echo $product_link; ?>&media=<?php echo $data['images'][0]['popup']; ?>&description=<?php echo $heading_title; ?>"><img src="catalog/view/javascript/bootstrap/image/pinterest.png" alt="pinterest"></a></span>
				<span class="ontwitter"><a onclick="window.open(this.href,this.window,'height=320,width=700,top='+($(window).height()/3)+',left='+($(window).width()/3));return false;" href="http://twitter.com/share?text=I love this dress so much!&url=<?php echo $product_link; ?>"><img src="catalog/view/javascript/bootstrap/image/twitter.png" alt="twitter"></a></span>
				<span class="ongoogle_plus"><a onclick="window.open(this.href,this.window,'height=320,width=700,top='+($(window).height()/3)+',left='+($(window).width()/3));return false;" href="https://plus.google.com/share?hl=en&amp;url=<?php echo $product_link; ?>"><img src="catalog/view/javascript/bootstrap/image/google_plus.png" alt="google_plus"></a></span>
			</div>
		</div>
          <?php } ?>
        </div>
        <?php if ($column_left && $column_right) { ?>
        <?php $class = 'col-sm-6'; ?>
        <?php } elseif ($column_left || $column_right) { ?>
        <?php $class = 'col-sm-6'; ?>
        <?php } else { ?>
        <?php $class = 'col-sm-5'; ?>
        <?php } ?>
        <div class="<?php echo $class; ?>">
          <h1><?php echo $heading_title; ?></h1>
			<?php if(isset($extra_field) && $extra_field) { ?>
				<div class="productPromo"><?php echo $extra_field; ?></div>
			<?php } ?>		  
          <ul class="list-unstyled">
            <li><?php echo $text_model; ?> <?php echo $model; ?></li>
            <li><span class="linkaOne">Write a review</span>
				 <span class="linkaTwo">Ask a question</span>
			     <a class="addthis_button_email" target="_blank" title="Email" href="https://www.addthis.com/tellfriend_v2.php?v=300&winname=addthis&pub=ra-56173bb5d7515416&source=men-300&lng=en&s=email&url=http%3A%2F%2Fwww.bjsbridal.com%2Felegant-sheath-one-shoulder-sleeveless-backless-beaded-evening-Dress-P20003.html&title=Hot%20Pink%20Elegant%20Sheath%20One%20Shoulder%20Sleeveless%20Backless%20Beaded%20Evening%20Dress&ate=AT-ra-56173bb5d7515416/-/-/58201e98f11a6763/3&uid=581aa03b21e7b009&ufbl=1&uud=1&ct=1&ui_email_to=&ui_email_from=&ui_email_note=&pre=http%3A%2F%2Fwww.bjsbridal.com%2Ftrend-collection-dresses&tt=0&captcha_provider=recaptcha2&pro=0&ats=imp_url%3D0%26url%3Dhttp%253A%252F%252Fwww.bjsbridal.com%252Felegant-sheath-one-shoulder-sleeveless-backless-beaded-evening-Dress-P20003.html%26title%3DHot%2520Pink%2520Elegant%2520Sheath%2520One%2520Shoulder%2520Sleeveless%2520Backless%2520Beaded%2520Evening%2520Dress%26smd%3Drsi%253D%2526gen%253D0%2526rsc%253D%2526dr%253Dhttp%25253A%25252F%25252Fwww.bjsbridal.com%25252Ftrend-collection-dresses%2526sta%253DAT-ra-56173bb5d7515416%25252F-%25252F-%25252F58201e98f11a6763%25252F1%26hideEmailSharingConfirmation%3Dundefined%26service%3Demail%26media%3Dundefined%26description%3Dundefined%26passthrough%3Dundefined%26email_template%3Dundefined%26email_vars%3Dundefined&atc=username%3Dra-56173bb5d7515416%26services_exclude%3Dskype%26services_exclude_natural%3Dskype%26services_compact%3Dfacebook%252Ctwitter%252Cprint%252Cemail%252Cpinterest_share%252Cgmail%252Cgoogle_plusone_share%252Clinkedin%252Cmailto%252Ctumblr%252Cmore%26product%3Dundefined%26widgetId%3Dundefined%26pubid%3Dra-56173bb5d7515416%26ui_pane%3Demail&rb=false">Email a friend</a>
	    </li>
          </ul>
          <?php if ($price) { ?>
          <ul class="list-unstyled">
            <?php if (!$special) { ?>
            <li>
              <h2><?php echo $price; ?></h2>
            </li>
            <?php } else { ?>
            <li><span class="productPrice1"><?php echo $price; ?></span><span class="productPrice2"><?php echo $special; ?></span><span class="productPrice3">(<?php echo $off; ?>% Off)</span></li>
            <?php } ?>
            <?php if ($tax) { ?>
            <li><?php echo $text_tax; ?> <?php echo $tax; ?></li>
            <?php } ?>
            <?php if ($points) { ?>
            <?php } ?>
			<li><script type="text/javascript" src="http://www.bjsbridal.com/catalog/view/javascript/jquery/kkcountdown.js"></script><div class="coupon">Enjoy Extra <b>5%</b> Off with Coupon Code: <b>BB5ABC</b> and Free Shipping on Order Over <b>$79</b>.</div><div class="count_down"><span time="<?php echo strtotime("2016-11-1"); ?>" class="kkcount-down-2"></span></div></li>
			<!--	<li><div class="coupon">New Year Sale Free Shipping on ALL orders</div><div class="count_down"><span time="<//?php echo strtotime("2016-1-1"); ?>"	class="kkcount-down-2"></span></div></li>-->
            <?php if ($discounts) { ?>
            <li>
              <hr>
            </li>
            <?php foreach ($discounts as $discount) { ?>
            <li><?php echo $discount['quantity']; ?><?php echo $text_discount; ?><?php echo $discount['price']; ?></li>
            <?php } ?>
            <?php } ?>
          </ul>
          <?php } ?>
          <div id="product">
				<div itemscope itemtype="http://schema.org/Product">
					  <meta itemprop="name" content="<?php echo $heading_title; ?>" />
					  <div itemprop="offers" itemscope itemtype="http://schema.org/Offer">
							<meta itemprop="price" content="<?php echo $special_microdata_price; ?>" />
							<meta itemprop="priceCurrency" content="<?php echo $special_microdata_code; ?>" />
							<meta itemprop="itemCondition" content="http://schema.org/NewCondition" />
					  </div>
				</div>
				
	    <!--修改处-->
		<hr>
			
	        <?php if ($options) { ?> 
		   <?php foreach ($options as $option) { ?>
		     <?php if ($option['type'] == 'text') { ?>
			    <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
			      <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>">Color</label>
			      <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" placeholder="<?php echo $option['name']; ?>" id="input-option<?php echo $option['product_option_id']; ?>" readonly="readonly" class="inputStyle"  />
			    </div>
		    <?php } ?>
		   <?php } ?>
	 	<?php } ?>
		
	    <!--修改结束-->
            <?php if ($options) { ?>
			<?php if(sizeof($pds) > 0){?>
					<div class="price pds">
						<?php foreach($pds as $k1=>$v1){?>
							<div class="pds_pics <?php if($color == str_replace(' ','-',strtolower(trim($v1['product_name'])))){ echo 'pds-current';}?>">
								<a href="<?php echo $v1['product_link']; ?>" title="<?php echo $v1['product_name']; ?>">
									<img src="<?php echo $v1['product_pds_image']; ?>" />
								</a>
							</div>
						<?php } ?>
					</div>
			<?php } ?>
			
            <?php foreach ($options as $option) { ?>
            <?php if ($option['type'] == 'select') { ?>
            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
              <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
			  <label><a class="size_chart">Size Chart</a></label>
			  <div id="modal-sizechart" class="modal">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
								<h4 class="modal-title main-heading">Size Chart</h4>
							</div>
							<div class="modal-body">
								<div class="size-chart">
										<button class="tabBtn1 tabBtnOn onBtn7">Inches</button><button class="tabBtn2 tabBtnOn onBtn8">Centimeters</button>
								<div class="size-content tabOne">
									<table class="table table-bordered table-hover" style="width: 100%;">
									<tbody><tr>
											<th class="tabTh7">US Size</th>
											<th class="tabTh7">Bust</th>
											<th class="tabTh7">Waist</th>
											<th class="tabTh7">Hips</th>
											<th class="tabTh7">Hollow to Floor</th>
										</tr>
										<tr>	
											<td></td>
											<td>inch</td>
											<td>inch</td>
											<td>inch</td>
											<td>inch</td>
										</tr>	
										<tr>	
											<td>US 2</td>
											<td>32.75</td>
											<td>25.5</td>
											<td>35.75</td>
											<td>57.75</td>
										</tr>	
										<tr>	
											<td>US 4</td>
											<td>33.5</td>
											<td>26.75</td>
											<td>36.5</td>
											<td>57.75</td>
										</tr>	
										<tr>	
											<td>US 6</td>
											<td>34.75</td>
											<td>27.5</td>
											<td>37.75</td>
											<td>59</td>
										</tr>	
										<tr>	
											<td>US 8</td>
											<td>35.5</td>
											<td>28.25</td>
											<td>38.5</td>
											<td>59</td>
										</tr>	
										<tr>	
											<td>US 10</td>
											<td>36.5</td>
											<td>29.5</td>
											<td>39.75</td>
											<td>59.75</td>
										</tr>	
										<tr>	
											<td>US 12</td>
											<td>38.25</td>
											<td>31</td>
											<td>41.25</td>
											<td>59.75</td>
										</tr>	
										<tr>	
											<td>US 14</td>
											<td>39.25</td>
											<td>32.75</td>
											<td>43</td>
											<td>61</td>
										</tr>	
										<tr>	
											<td>US 16</td>
											<td>41</td>
											<td>33.75</td>
											<td>44</td>
											<td>61</td>
										</tr>	
										<tr>	
											<td>US 16W</td>
											<td>43</td>
											<td>36.25</td>
											<td>45.75</td>
											<td>61</td>
										</tr>	
										<tr>	
											<td>US 18W</td>
											<td>45</td>
											<td>38.5</td>
											<td>47.75</td>
											<td>61</td>
										</tr>	
										<tr>	
											<td>US 20W</td>
											<td>46.75</td>
											<td>41</td>
											<td>49.5</td>
											<td>61</td>
										</tr>	
										<tr>	
											<td>US 22W</td>
											<td>48.75</td>
											<td>43</td>
											<td>51.5</td>
											<td>61</td>
										</tr>	
										<tr>	
											<td>US 24W</td>
											<td>51.25</td>
											<td>45.25</td>
											<td>53.5</td>
											<td>61</td>
										</tr>	
										<tr>	
											<td>US 26W</td>
											<td>53.25</td>
											<td>47.75</td>
											<td>55.5</td>
											<td>61</td>
										</tr>
									</tbody></table>
								</div>
								<div class="size-content tabTwo">
											<table class="table table-bordered table-hover" style="width: 100%;">
											<tbody><tr>
													<th class="tabTh8">US Size</th>
													<th class="tabTh8">Bust</th>
													<th class="tabTh8">Waist</th>
													<th class="tabTh8">Hips</th>
													<th class="tabTh8">Hollow to Floor</th>
												</tr>
												<tr>	
													<td></td>
													<td>cm</td>
													<td>cm</td>
													<td>cm</td>
													<td>cm</td>
												</tr>	
												<tr>	
													<td>US 2</td>
													<td>83</td>
													<td>65</td>
													<td>91</td>
													<td>147</td>
												</tr>	
												<tr>	
													<td>US 4</td>
													<td>85</td>
													<td>68</td>
													<td>91</td>
													<td>147</td>
												</tr>	
												<tr>	
													<td>US 6</td>
													<td>88</td>
													<td>70</td>
													<td>96</td>
													<td>150</td>
												</tr>	
												<tr>	
													<td>US 8</td>
													<td>90</td>
													<td>72</td>
													<td>98</td>
													<td>150</td>
												</tr>	
												<tr>	
													<td>US 10</td>
													<td>93</td>
													<td>75</td>
													<td>101</td>
													<td>152</td>
												</tr>	
												<tr>	
													<td>US 12</td>
													<td>97</td>
													<td>79</td>
													<td>105</td>
													<td>152</td>
												</tr>	
												<tr>	
													<td>US 14</td>
													<td>100</td>
													<td>83</td>
													<td>109</td>
													<td>155</td>
												</tr>	
												<tr>	
													<td>US 16</td>
													<td>104</td>
													<td>86</td>
													<td>112</td>
													<td>155</td>
												</tr>	
												<tr>	
													<td>US 16W</td>
													<td>109</td>
													<td>92</td>
													<td>116</td>
													<td>155</td>
												</tr>	
												<tr>	
													<td>US 18W</td>
													<td>114</td>
													<td>98</td>
													<td>121</td>
													<td>155</td>
												</tr>	
												<tr>	
													<td>US 20W</td>
													<td>119</td>
													<td>104</td>
													<td>126</td>
													<td>155</td>
												</tr>	
												<tr>	
													<td>US 22W</td>
													<td>124</td>
													<td>109</td>
													<td>131</td>
													<td>155</td>
												</tr>	
												<tr>	
													<td>US 24W</td>
													<td>130</td>
													<td>115</td>
													<td>136</td>
													<td>155</td>
												</tr>	
												<tr>	
													<td>US 26W</td>
													<td>135</td>
													<td>121</td>
													<td>141</td>
													<td>155</td>
												</tr>
											</tbody></table>
								</div>		
								</div>
							</div>	
						</div>
					</div>
			  </div>
 <script type="text/javascript">
		$(document).delegate('.size_chart', 'click', function(e) {
			$('#modal-sizechart').modal('show');
		});
</script>
              <select name="option[<?php echo $option['product_option_id']; ?>]" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control">
                <option value=""><?php echo $text_select; ?></option>
                <?php foreach ($option['product_option_value'] as $option_value) { ?>
                <option value="<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
                <?php if ($option_value['price']) { ?>
                (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                <?php } ?>
                </option>
                <?php } ?>
              </select>
            </div>
            <?php } ?>
		  <?php if ($option['type'] == 'size_option') { ?>
            <div id="size" class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
              <label class="control-label"><?php echo $option['name']; ?><a class="size_chart">Size Chart</a></label>
			  <div id="modal-sizechart" class="modal">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
								<h4 class="modal-title main-heading">Size Chart</h4>
							</div>
							<div class="modal-body">
								<div class="size-chart">
										<button class="tabBtn1 onBtn3 tabBtnOn">Inches</button><button class="tabBtn2 onBtn4 tabBtnOn">Centimeters</button>
		<div class="size-content tabOne">
			<table class="table table-bordered table-hover" style="width: 100%;">
			<tbody><tr>
					<th class="tabTh3">US Size</th>
					<th class="tabTh3">Bust</th>
					<th class="tabTh3">Waist</th>
					<th class="tabTh3">Hips</th>
					<th class="tabTh3">Hollow to Floor</th>
				</tr>
				<tr>	
					<td></td>
					<td>inch</td>
					<td>inch</td>
					<td>inch</td>
					<td>inch</td>
				</tr>	
				<tr>	
					<td>US 2</td>
					<td>32.75</td>
					<td>25.5</td>
					<td>35.75</td>
					<td>57.75</td>
				</tr>	
				<tr>	
					<td>US 4</td>
					<td>33.5</td>
					<td>26.75</td>
					<td>36.5</td>
					<td>57.75</td>
				</tr>	
				<tr>	
					<td>US 6</td>
					<td>34.75</td>
					<td>27.5</td>
					<td>37.75</td>
					<td>59</td>
				</tr>	
				<tr>	
					<td>US 8</td>
					<td>35.5</td>
					<td>28.25</td>
					<td>38.5</td>
					<td>59</td>
				</tr>	
				<tr>	
					<td>US 10</td>
					<td>36.5</td>
					<td>29.5</td>
					<td>39.75</td>
					<td>59.75</td>
				</tr>	
				<tr>	
					<td>US 12</td>
					<td>38.25</td>
					<td>31</td>
					<td>41.25</td>
					<td>59.75</td>
				</tr>	
				<tr>	
					<td>US 14</td>
					<td>39.25</td>
					<td>32.75</td>
					<td>43</td>
					<td>61</td>
				</tr>	
				<tr>	
					<td>US 16</td>
					<td>41</td>
					<td>33.75</td>
					<td>44</td>
					<td>61</td>
				</tr>	
				<tr>	
					<td>US 16W</td>
					<td>43</td>
					<td>36.25</td>
					<td>45.75</td>
					<td>61</td>
				</tr>	
				<tr>	
					<td>US 18W</td>
					<td>45</td>
					<td>38.5</td>
					<td>47.75</td>
					<td>61</td>
				</tr>	
				<tr>	
					<td>US 20W</td>
					<td>46.75</td>
					<td>41</td>
					<td>49.5</td>
					<td>61</td>
				</tr>	
				<tr>	
					<td>US 22W</td>
					<td>48.75</td>
					<td>43</td>
					<td>51.5</td>
					<td>61</td>
				</tr>	
				<tr>	
					<td>US 24W</td>
					<td>51.25</td>
					<td>45.25</td>
					<td>53.5</td>
					<td>61</td>
				</tr>	
				<tr>	
					<td>US 26W</td>
					<td>53.25</td>
					<td>47.75</td>
					<td>55.5</td>
					<td>61</td>
				</tr>
			</tbody></table>
		</div>
<div class="size-content tabTwo">
			<table class="table table-bordered table-hover" style="width: 100%;">
			<tbody><tr>
					<th class="tabTh4">US Size</th>
					<th class="tabTh4">Bust</th>
					<th class="tabTh4">Waist</th>
					<th class="tabTh4">Hips</th>
					<th class="tabTh4">Hollow to Floor</th>
				</tr>
				<tr>	
					<td></td>
					<td>cm</td>
					<td>cm</td>
					<td>cm</td>
					<td>cm</td>
				</tr>	
				<tr>	
					<td>US 2</td>
					<td>83</td>
					<td>65</td>
					<td>91</td>
					<td>147</td>
				</tr>	
				<tr>	
					<td>US 4</td>
					<td>85</td>
					<td>68</td>
					<td>91</td>
					<td>147</td>
				</tr>	
				<tr>	
					<td>US 6</td>
					<td>88</td>
					<td>70</td>
					<td>96</td>
					<td>150</td>
				</tr>	
				<tr>	
					<td>US 8</td>
					<td>90</td>
					<td>72</td>
					<td>98</td>
					<td>150</td>
				</tr>	
				<tr>	
					<td>US 10</td>
					<td>93</td>
					<td>75</td>
					<td>101</td>
					<td>152</td>
				</tr>	
				<tr>	
					<td>US 12</td>
					<td>97</td>
					<td>79</td>
					<td>105</td>
					<td>152</td>
				</tr>	
				<tr>	
					<td>US 14</td>
					<td>100</td>
					<td>83</td>
					<td>109</td>
					<td>155</td>
				</tr>	
				<tr>	
					<td>US 16</td>
					<td>104</td>
					<td>86</td>
					<td>112</td>
					<td>155</td>
				</tr>	
				<tr>	
					<td>US 16W</td>
					<td>109</td>
					<td>92</td>
					<td>116</td>
					<td>155</td>
				</tr>	
				<tr>	
					<td>US 18W</td>
					<td>114</td>
					<td>98</td>
					<td>121</td>
					<td>155</td>
				</tr>	
				<tr>	
					<td>US 20W</td>
					<td>119</td>
					<td>104</td>
					<td>126</td>
					<td>155</td>
				</tr>	
				<tr>	
					<td>US 22W</td>
					<td>124</td>
					<td>109</td>
					<td>131</td>
					<td>155</td>
				</tr>	
				<tr>	
					<td>US 24W</td>
					<td>130</td>
					<td>115</td>
					<td>136</td>
					<td>155</td>
				</tr>	
				<tr>	
					<td>US 26W</td>
					<td>135</td>
					<td>121</td>
					<td>141</td>
					<td>155</td>
				</tr>
			</tbody></table>
		</div>		
								</div>
							</div>	
						</div>
					</div>
			  </div>
			  <script type="text/javascript"><!--
					$(document).delegate('.size_chart', 'click', function(e) {
						$('#modal-sizechart').modal('show');
					});
			  //--></script>
              <div id="input-option<?php echo $option['product_option_id']; ?>">
                <?php foreach ($option['product_option_value'] as $option_value) { ?>
                    <?php if ($option_value['price']) {  $opt_price = $option_value['price']; } else { $opt_price = ''; } ?>	
				<div class="radio <?php echo $option['product_option_id']; ?>">
				<?php if($option_value['value_type']=='Free_Customize') { ?>
                  <label class="chk Free_Customize" data-toggle="tooltip" data-original-title="<?php echo $opt_price; ?>">
                    <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" id="<?php echo $option['product_option_id']; ?>" />
					<?php echo $option_value['name']; ?>
                  </label>
				<?php } else {	?>				
                  <label class="chk size<?php echo $option_value['option_value_id']; ?>" data-toggle="tooltip" data-original-title="<?php echo $opt_price; ?>">
                    <input type="radio" id="<?php echo $option['product_option_id']; ?>" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" />
                    	<?php echo $option_value['name']; ?>
                  </label>
				 <?php } ?>
                </div>
                <?php } ?>
					<input type="hidden" id="free_bust<?php echo $option['product_option_id']; ?>" name="custom_option[<?php echo $option['product_option_id']; ?>][Bust]" value="" />
                    <input type="hidden" id="free_waist<?php echo $option['product_option_id']; ?>" name="custom_option[<?php echo $option['product_option_id']; ?>][Waist]" value="" />					
                    <input type="hidden" id="free_hip<?php echo $option['product_option_id']; ?>" name="custom_option[<?php echo $option['product_option_id']; ?>][Hip]" value="" />
                    <input type="hidden" id="free_hollow<?php echo $option['product_option_id']; ?>" name="custom_option[<?php echo $option['product_option_id']; ?>][Hollow]" value="" />
                    <input type="hidden" id="free_height<?php echo $option['product_option_id']; ?>" name="custom_option[<?php echo $option['product_option_id']; ?>][Height]" value="" />
					<input type="hidden" id="free_remarks<?php echo $option['product_option_id']; ?>" name="custom_option[<?php echo $option['product_option_id']; ?>][remarks]" value="" />
					<input type="hidden" id="cfree_bust<?php echo $option['product_option_id']; ?>" name="custom_option[<?php echo $option['product_option_id']; ?>][cBust]" value="" />
                    <input type="hidden" id="cfree_waist<?php echo $option['product_option_id']; ?>" name="custom_option[<?php echo $option['product_option_id']; ?>][cWaist]" value="" />					
                    <input type="hidden" id="cfree_hip<?php echo $option['product_option_id']; ?>" name="custom_option[<?php echo $option['product_option_id']; ?>][cHip]" value="" />
                    <input type="hidden" id="cfree_hollow<?php echo $option['product_option_id']; ?>" name="custom_option[<?php echo $option['product_option_id']; ?>][cHollow]" value="" />
                    <input type="hidden" id="cfree_height<?php echo $option['product_option_id']; ?>" name="custom_option[<?php echo $option['product_option_id']; ?>][cHeight]" value="" />
					<input type="hidden" id="cfree_remarks<?php echo $option['product_option_id']; ?>" name="custom_option[<?php echo $option['product_option_id']; ?>][cremarks]" value="" />					
              </div>
			  <div class="custom_con<?php echo $option['product_option_id']; ?> custom_box"></div>
            </div>
            <?php } ?>			
            <?php if ($option['type'] == 'radio') { ?>
            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
              <label class="control-label"><?php echo $option['name']; ?></label>
              <div id="input-option<?php echo $option['product_option_id']; ?>">
                <?php foreach ($option['product_option_value'] as $option_value) { ?>
                <div class="radio">
                  <label>
                    <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" />
                    <?php echo $option_value['name']; ?>
                    <?php if ($option_value['price']) { ?>
                    (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                    <?php } ?>
                  </label>
                </div>
                <?php } ?>
              </div>
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'checkbox') { ?>
            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
              <label class="control-label"><?php echo $option['name']; ?></label>
              <div id="input-option<?php echo $option['product_option_id']; ?>">
                <?php foreach ($option['product_option_value'] as $option_value) { ?>
                <div class="checkbox">
                  <label>
                    <input type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" />
                    <?php echo $option_value['name']; ?>
                    <?php if ($option_value['price']) { ?>
                    (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                    <?php } ?>
                  </label>
                </div>
                <?php } ?>
              </div>
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'image') { ?>
            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
              <label class="control-label"><?php echo $option['name']; ?></label>
              <div id="input-option<?php echo $option['product_option_id']; ?>">
                <?php foreach ($option['product_option_value'] as $option_value) { ?>
                <div class="radio">
                  <label>
                    <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" />
                    <img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" class="img-thumbnail" /> <?php echo $option_value['name']; ?>
                    <?php if ($option_value['price']) { ?>
                    (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                    <?php } ?>
                  </label>
                </div>
                <?php } ?>
              </div>
            </div>
            <?php } ?>
            <!--修改处<?php if ($option['type'] == 'text') { ?>
            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
              <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
              <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" placeholder="<?php echo $option['name']; ?>" id="input-option<?php echo $option['product_option_id']; ?>" readonly="readonly" style="border:none;"  />
            </div>
            <?php } ?>修改结束-->
            <?php if ($option['type'] == 'textarea') { ?>
            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
              <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
              <textarea name="option[<?php echo $option['product_option_id']; ?>]" rows="5" placeholder="<?php echo $option['name']; ?>" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control"><?php echo $option['value']; ?></textarea>
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'file') { ?>
            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
              <label class="control-label"><?php echo $option['name']; ?></label>
              <button type="button" id="button-upload<?php echo $option['product_option_id']; ?>" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-default btn-block"><i class="fa fa-upload"></i> <?php echo $button_upload; ?></button>
              <input type="hidden" name="option[<?php echo $option['product_option_id']; ?>]" value="" id="input-option<?php echo $option['product_option_id']; ?>" />
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'date') { ?>
            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
              <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
              <div class="input-group date">
                <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="MMM DD, YYYY" id="input-option<?php echo $option['product_option_id']; ?>" readonly="readonly" class="form-control" />
                <span class="input-group-btn">
                <button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
                </span></div>
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'datetime') { ?>
            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
              <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
              <div class="input-group datetime">
                <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="YYYY-MM-DD HH:mm" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
                <span class="input-group-btn">
                <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                </span></div>
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'time') { ?>
            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
              <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
              <div class="input-group time">
                <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="HH:mm" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
                <span class="input-group-btn">
                <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                </span></div>
            </div>
            <?php } ?>
            <?php } ?>
            <?php } ?>
			<!--<p class="arrival-date">The earliest arrival date is <b><?php echo date("M jS, Y",strtotime('+15 day'));?></b> if order placed TODAY.</p>-->
            <?php if ($recurrings) { ?>
            <hr>
            <h3><?php echo $text_payment_recurring ?></h3>
            <div class="form-group required">
              <select name="recurring_id" class="form-control">
                <option value=""><?php echo $text_select; ?></option>
                <?php foreach ($recurrings as $recurring) { ?>
                <option value="<?php echo $recurring['recurring_id'] ?>"><?php echo $recurring['name'] ?></option>
                <?php } ?>
              </select>
              <div class="help-block" id="recurring-description"></div>
            </div>
            <?php } ?>
            <div class="form-group">
			<div><label class="control-label label-change" for="input-quantity"><?php echo $entry_qty; ?></label><input type="text" name="quantity" value="<?php echo $minimum; ?>" size="2" id="input-quantity" class="form-control input-change" /></div>
                <input type="hidden" name="product_id" value="<?php echo $product_id; ?>" />
				<div>
					<button type="button" id="quick-buy" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary btn-lg" style="width:49.4%;">BUY NOW</button>
					<button type="button" id="button-cart" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary btn-lg" style="width:49.4%;">ADD TO CART</button>
				</div>
            </div>
			<p class="arrival-date">The earliest arrival date is <b><?php echo date("M jS, Y",strtotime('+7 day'));?></b> if order placed TODAY.</p>
            <?php if ($minimum > 1) { ?>
            <div class="alert alert-info"><i class="fa fa-info-circle"></i> <?php echo $text_minimum; ?></div>
            <?php } ?>
          </div>	  
  
	  <div class="four-link">
	    <a class="" target="_blank" href="<?php echo HTTP_SERVER . 'measuring-guide.html'; ?>"><i class="fa fa-calendar"></i>Measuring Guide</a>		
		<a class="" target="_blank" href="<?php echo HTTP_SERVER . 'shipping-methods-guide.html'; ?>"><i class="fa fa-retweet"></i>Shipping Methods</a>
		<a class="" data-toggle="tooltip" title="<?php echo $button_compare; ?>" onclick="compare.add('<?php echo $product_id; ?>');"><i class="glyphicon glyphicon-sort"></i>Compare</a>
		<a class="" data-toggle="tooltip" title="<?php echo $button_wishlist; ?>" onclick="wishlist.add('<?php echo $product_id; ?>');"><i class="fa fa-heart"></i>Favorites</a>
	  </div>
	  <div class="text-center"><a rel="nofollow" href="javascript:var newin=window.open('https://safeweb.norton.com/report/show?url=www.bjsbridal.com&ulang=eng','htm','height=570,width=562,scrollbars=yes');if(newin!=null){newin.focus();}"><img class="norton" src="catalog/view/theme/default/image/norton.png" /></a></div>
        </div>

	<div class="col-sm-9">
		<div class="liOne"><?php echo $tab_description; ?></div>
		            <div class="tab-pane" id="tab-description">
		    <?php if ($attribute_groups) { ?>
		      <table class="table table-bordered">
			<?php foreach ($attribute_groups as $attribute_group) { ?>
			  <?php foreach ($attribute_group['attribute'] as $attribute) { ?>
			  <tr>
			    <td><?php echo $attribute['name']; ?></td>
			    <td><?php echo $attribute['text']; ?></td>
			  </tr>
			  <?php } ?>
			<?php } ?>
		      </table>
		    <?php } ?>
	      <div class="size-chart">
		<h3>Size Chart</h3>
		<button class="tabBtn1 onBtn1">Inches</button><button class="tabBtn2 onBtn2">Centimeters</button>
		<div class="size-content tabOne">
			<table class="table table-bordered table-hover" style="width: 100%;">
			<tbody><tr>
					<th class="tabTh">US Size</th>
					<th class="tabTh">Bust</th>
					<th class="tabTh">Waist</th>
					<th class="tabTh">Hips</th>
					<th class="tabTh">Hollow to Floor</th>
				</tr>
				<tr>	
					<td></td>
					<td>inch</td>
					<td>inch</td>
					<td>inch</td>
					<td>inch</td>
				</tr>	
				<tr>	
					<td>US 2</td>
					<td>32.75</td>
					<td>25.5</td>
					<td>35.75</td>
					<td>57.75</td>
				</tr>	
				<tr>	
					<td>US 4</td>
					<td>33.5</td>
					<td>26.75</td>
					<td>36.5</td>
					<td>57.75</td>
				</tr>	
				<tr>	
					<td>US 6</td>
					<td>34.75</td>
					<td>27.5</td>
					<td>37.75</td>
					<td>59</td>
				</tr>	
				<tr>	
					<td>US 8</td>
					<td>35.5</td>
					<td>28.25</td>
					<td>38.5</td>
					<td>59</td>
				</tr>	
				<tr>	
					<td>US 10</td>
					<td>36.5</td>
					<td>29.5</td>
					<td>39.75</td>
					<td>59.75</td>
				</tr>	
				<tr>	
					<td>US 12</td>
					<td>38.25</td>
					<td>31</td>
					<td>41.25</td>
					<td>59.75</td>
				</tr>	
				<tr>	
					<td>US 14</td>
					<td>39.25</td>
					<td>32.75</td>
					<td>43</td>
					<td>61</td>
				</tr>	
				<tr>	
					<td>US 16</td>
					<td>41</td>
					<td>33.75</td>
					<td>44</td>
					<td>61</td>
				</tr>	
				<tr>	
					<td>US 16W</td>
					<td>43</td>
					<td>36.25</td>
					<td>45.75</td>
					<td>61</td>
				</tr>	
				<tr>	
					<td>US 18W</td>
					<td>45</td>
					<td>38.5</td>
					<td>47.75</td>
					<td>61</td>
				</tr>	
				<tr>	
					<td>US 20W</td>
					<td>46.75</td>
					<td>41</td>
					<td>49.5</td>
					<td>61</td>
				</tr>	
				<tr>	
					<td>US 22W</td>
					<td>48.75</td>
					<td>43</td>
					<td>51.5</td>
					<td>61</td>
				</tr>	
				<tr>	
					<td>US 24W</td>
					<td>51.25</td>
					<td>45.25</td>
					<td>53.5</td>
					<td>61</td>
				</tr>	
				<tr>	
					<td>US 26W</td>
					<td>53.25</td>
					<td>47.75</td>
					<td>55.5</td>
					<td>61</td>
				</tr>
			</tbody></table>
		</div>
<div class="size-content tabTwo">
			<table class="table table-bordered table-hover" style="width: 100%;">
			<tbody><tr>
					<th class="tabTh2">US Size</th>
					<th class="tabTh2">Bust</th>
					<th class="tabTh2">Waist</th>
					<th class="tabTh2">Hips</th>
					<th class="tabTh2">Hollow to Floor</th>
				</tr>
				<tr>	
					<td></td>
					<td>cm</td>
					<td>cm</td>
					<td>cm</td>
					<td>cm</td>
				</tr>	
				<tr>	
					<td>US 2</td>
					<td>83</td>
					<td>65</td>
					<td>91</td>
					<td>147</td>
				</tr>	
				<tr>	
					<td>US 4</td>
					<td>85</td>
					<td>68</td>
					<td>91</td>
					<td>147</td>
				</tr>	
				<tr>	
					<td>US 6</td>
					<td>88</td>
					<td>70</td>
					<td>96</td>
					<td>150</td>
				</tr>	
				<tr>	
					<td>US 8</td>
					<td>90</td>
					<td>72</td>
					<td>98</td>
					<td>150</td>
				</tr>	
				<tr>	
					<td>US 10</td>
					<td>93</td>
					<td>75</td>
					<td>101</td>
					<td>152</td>
				</tr>	
				<tr>	
					<td>US 12</td>
					<td>97</td>
					<td>79</td>
					<td>105</td>
					<td>152</td>
				</tr>	
				<tr>	
					<td>US 14</td>
					<td>100</td>
					<td>83</td>
					<td>109</td>
					<td>155</td>
				</tr>	
				<tr>	
					<td>US 16</td>
					<td>104</td>
					<td>86</td>
					<td>112</td>
					<td>155</td>
				</tr>	
				<tr>	
					<td>US 16W</td>
					<td>109</td>
					<td>92</td>
					<td>116</td>
					<td>155</td>
				</tr>	
				<tr>	
					<td>US 18W</td>
					<td>114</td>
					<td>98</td>
					<td>121</td>
					<td>155</td>
				</tr>	
				<tr>	
					<td>US 20W</td>
					<td>119</td>
					<td>104</td>
					<td>126</td>
					<td>155</td>
				</tr>	
				<tr>	
					<td>US 22W</td>
					<td>124</td>
					<td>109</td>
					<td>131</td>
					<td>155</td>
				</tr>	
				<tr>	
					<td>US 24W</td>
					<td>130</td>
					<td>115</td>
					<td>136</td>
					<td>155</td>
				</tr>	
				<tr>	
					<td>US 26W</td>
					<td>135</td>
					<td>121</td>
					<td>141</td>
					<td>155</td>
				</tr>
			</tbody></table>
		</div>		
	      </div>
	    </div>
		<hr class="HR">
            <?php if ($review_status) { ?>
		<div class="liTwo"><?php echo $tab_review; ?></div>

		            <?php if ($review_status) { ?>
					
					
					
					
					
					
					
					
            <div class="tab-pane" id="tab-review">
              <form class="form-horizontal">
                <div id="review"></div>
                <h3><?php echo $text_write; ?></h3>
                <?php if ($review_guest) { ?>
                <div class="form-group required">
                  <div class="col-sm-12">
                    <label class="control-label" for="input-name"><?php echo $entry_name; ?></label>
                    <input type="text" name="name" value="" id="input-name" class="form-control" />
                  </div>
                </div>
				<div class="form-group required">
					  <div class="col-sm-12">
						<label class="control-label" for="input-name"><?php echo $entry_email; ?></label>
						<input type="text" name="email" value="" id="input-name" class="form-control" />
					  </div>
				</div>
                <div class="form-group required">
                  <div class="col-sm-12">
                    <label class="control-label" for="input-review"><?php echo $entry_review; ?></label>
                    <textarea name="text" rows="5" id="input-review" class="form-control"></textarea>
                    <div class="help-block"><?php echo $text_note; ?></div>
                  </div>
                </div>
                <div class="form-group required">
                  <div class="col-sm-12">
                    <label class="control-label"><?php echo $entry_rating; ?></label>
                    <!--&nbsp;&nbsp;&nbsp; <//?php echo $entry_bad; ?>&nbsp;
                    <input type="radio" name="rating" value="1" />
                    &nbsp;
                    <input type="radio" name="rating" value="2" />
                    &nbsp;
                    <input type="radio" name="rating" value="3" />
                    &nbsp;
                    <input type="radio" name="rating" value="4" />
                    &nbsp;
                    <input type="radio" name="rating" value="5" />
					&nbsp;<//?php echo $entry_good; ?>-->
					<div class="evaluate">
						<span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x" style="color:#ffcc00;"></i></span>				
						<span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x" style="color:#ffcc00;"></i></span>
						<span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x" style="color:#ffcc00;"></i></span>
						<span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x" style="color:#ffcc00;"></i></span>
						<span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x" style="color:#ffcc00;"></i></span>
					</div>
				  </div>
				</div>
                <div class="buttons">
                  <div class="pull-right">
                    <button type="button" id="button-review" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary"><?php echo $button_continue; ?></button>
                  </div>
                </div>
                <?php } else { ?>
                <?php echo $text_login; ?>
                <?php } ?>
              </form>
            </div>
            <?php } ?>
			<hr class="HR" style="margin-top: 60px;">
					<div class="liThree">Ask a question</div>
					
							  <?php if ($qa_status) { ?>
<div class="tab-pane" id="tab-askquestion">
	<form class="form-horizontal" id="q-form">
	  <?php if ($qa_display_questions) { ?>
	  <div id="qa"><?php echo $qas; ?></div>
	  <?php } ?>
	  <?php if ($qa_form_display_name) { ?>
	  <div class="col-md-6">
		<div class="form-group q-form<?php echo ($qa_form_require_name) ? ' required' : ''; ?>">
		  <label class="control-label" for="input-q-name"><?php echo $entry_name; ?></label>
		  <input type="text" name="q_name" value="<?php echo $q_name; ?>" id="input-q-name" class="form-control" />
		</div>
	  </div>
	  <?php } ?>
	  <?php if ($qa_form_display_email) { ?>
	  <div class="col-md-6">
		<div class="form-group q-form<?php echo ($qa_form_require_email) ? ' required' : ''; ?>">
		  <label class="control-label" for="input-q-email"><?php echo $entry_email; ?></label>
		  <input type="email" name="q_email" value="<?php echo $q_email; ?>" id="input-q-email" class="form-control" />
		</div>
	  </div>
	  <?php } ?>
	  <?php if ($qa_form_display_phone) { ?>
	  <div class="col-md-6">
		<div class="form-group q-form<?php echo ($qa_form_require_phone) ? ' required' : ''; ?>">
		  <label class="control-label" for="input-q-phone"><?php echo $entry_phone; ?></label>
		  <input type="tel" name="q_phone" value="" id="input-q-phone" class="form-control" />
		</div>
	  </div>
	  <?php } ?>
	  <?php if ($qa_form_display_custom_field) { ?>
	  <div class="col-md-6">
		<div class="form-group q-form<?php echo ($qa_form_require_custom_field) ? ' required' : ''; ?>">
		  <label class="control-label" for="input-q-custom"><?php echo $entry_custom; ?></label>
		  <input type="text" name="q_custom" value="" id="input-q-custom" class="form-control" />
		</div>
	  </div>
	  <?php } ?>
	  <div class="form-group q-form required col-sm-12">
		<div>
		  <label class="control-label" for="input-q-question"><?php echo $entry_question; ?></label>
		  <textarea name="q_question" rows="5" id="input-q-question" class="form-control"></textarea>
		  <div class="help-block"><?php echo $text_note; ?></div>
		</div>
	  </div>
	  <?php if ($qa_form_display_captcha) { ?>
		<?php if ($recaptcha && $site_key) { ?>
	  <div class="form-group q-form<?php echo ($qa_form_require_captcha) ? ' required' : ''; ?>"">
		<div class="col-sm-12">
			<div id="q_grecaptcha"></div>
		</div>
	  </div>
		  <?php } else { ?>
	  <div class="form-group">
		<div class="col-sm-12"><img src="index.php?route=<?php echo $captcha_route; ?>" alt="" id="q-captcha" class="img-captcha" /></div>
	  </div>
		  <?php } ?>
	  <?php } ?>
	  <div class="buttons">
		<div class="pull-right">
		  <button type="button" id="button-qa" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary"><?php echo $button_continue; ?></button>
		</div>
	  </div>
	</form>
  </div>
  <?php } ?>
				
            <?php } ?>
	</div>


      <?php if ($products) { ?>
      <div class="col-sm-3 related-row">
	  <div class="row">
        <h4>Related Products</h4>
        <?php $i = 0; ?>
        <?php foreach ($products as $product) { ?>
        <?php if ($column_left && $column_right) { ?>
        <?php $class = 'col-lg-6 col-md-6 col-sm-12 col-xs-12'; ?>
        <?php } elseif ($column_left || $column_right) { ?>
        <?php $class = 'col-lg-4 col-md-4 col-sm-6 col-xs-12'; ?>
        <?php } else { ?>
        <?php $class = 'col-xs-12'; ?>
        <?php } ?>
	<div class="col-md-6 col-xs-6">
	  <div>
	    <div class="image imageHover"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive" /></a></div>
	    <div class="caption">
	      <?php if ($product['rating']) { ?>
	      <div class="rating">
		<?php for ($i = 1; $i <= 5; $i++) { ?>
		<?php if ($product['rating'] < $i) { ?>
		<span class="fa fa-stack"><i class="fa fa-star-o fa-stack-1x"></i></span>
		<?php } else { ?>
		<span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
		<?php } ?>
		<?php } ?>
	      </div>
	      <?php } ?>
	      <?php if ($product['price']) { ?>
	      <p class="price">
		<?php if (!$product['special']) { ?>
		<?php echo $product['price']; ?>
		<?php } else { ?>
		<span class="related-old"><?php echo $product['price']; ?></span> <span class="related-new"><?php echo $product['special']; ?></span>
		<?php } ?>
		<?php if ($product['tax']) { ?>
		<span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
		<?php } ?>
	      </p>
	      <?php } ?>
	    </div>
	</div>
	</div>
        <?php if (($column_left && $column_right) && ($i % 2 == 0)) { ?>
        <div class="clearfix visible-md visible-sm"></div>
        <?php } elseif (($column_left || $column_right) && ($i % 3 == 0)) { ?>
        <!--<div class="clearfix visible-md"></div>-->
        <?php } elseif ($i % 4 == 0) { ?>
        <!--<div class="clearfix visible-md"></div>-->
        <?php } ?>
        <?php $i++; ?>
        <?php } ?>
      </div>




      </div>
       
   
      

      <?php } ?>
      <?php if ($tags) { ?>
      <p><?php echo $text_tags; ?>
        <?php for ($i = 0; $i < count($tags); $i++) { ?>
        <?php if ($i < (count($tags) - 1)) { ?>
        <a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>,
        <?php } else { ?>
        <a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>
        <?php } ?>
        <?php } ?>
      </p>
      <?php } ?>
      <?php echo $content_bottom; ?></div>
    <?php echo $column_right; ?></div>
	<div id="boxes">
		<div id="dialog" class="window col-sm-5 col-xs-11"></div>
		<div id="mask"></div>
	</div>
</div>
</div>
<script type="text/javascript"><!--
$('select[name=\'recurring_id\'], input[name="quantity"]').change(function(){
	$.ajax({
		url: 'index.php?route=product/product/getRecurringDescription',
		type: 'post',
		data: $('input[name=\'product_id\'], input[name=\'quantity\'], select[name=\'recurring_id\']'),
		dataType: 'json',
		beforeSend: function() {
			$('#recurring-description').html('');
		},
		success: function(json) {
			$('.alert, .text-danger').remove();
			
			if (json['success']) {
				$('#recurring-description').html(json['success']);
			}
		}
	});
});
//--></script> 
<script type="text/javascript"><!--
$('#quick-buy').on('click', function() {
	$.ajax({
		url: 'index.php?route=checkout/cart/add',
		type: 'post',
		data: $('#product input[type=\'text\'], #product input[type=\'hidden\'], #product input[type=\'radio\']:checked, #product input[type=\'checkbox\']:checked, #product select, #product textarea'),
		dataType: 'json',
		beforeSend: function() {
			$('#quick_buy').button('loading');
		},
		complete: function() {
			$('#quick_buy').button('reset');
		},
		success: function(json) {
			$('.alert, .text-danger').remove();
			$('.form-group').removeClass('has-error');

			if (json['error']) {
				if (json['error']['option']) {
					for (i in json['error']['option']) {
						var element = $('#input-option' + i.replace('_', '-'));
						
						if (element.parent().hasClass('input-group')) {
							element.parent().after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
						} else {
							element.after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
						}
					}
				}
				
				if (json['error']['recurring']) {
					$('select[name=\'recurring_id\']').after('<div class="text-danger">' + json['error']['recurring'] + '</div>');
				}
				
				// Highlight any found errors
				$('.text-danger').parent().addClass('has-error');
			}
			
			if (json['success']) {

// redirect to checkout page
				setTimeout(function(){
					window.location.href = "https://www.bjsbridal.com/index.php?route=checkout/checkout";
				},500);
// redirect to checkout page

				$('.breadcrumb').after('<div class="alert alert-success">' + json['success'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
				
				$('#cart-total').html(json['total']);
				
				$('html, body').animate({ scrollTop: 0 }, 'slow');
				
				$('#cart > ul').load('index.php?route=common/cart/info ul li');
			}
		}
	});
});
$('#button-cart').on('click', function() {
	$.ajax({
		url: 'index.php?route=checkout/cart/add',
		type: 'post',
		data: $('#product input[type=\'text\'], #product input[type=\'hidden\'], #product input[type=\'radio\']:checked, #product input[type=\'checkbox\']:checked, #product select, #product textarea'),
		dataType: 'json',
		beforeSend: function() {
			$('#button-cart').button('loading');
		},
		complete: function() {
			$('#button-cart').button('reset');
		},
		success: function(json) {
			$('.alert, .text-danger').remove();
			$('.form-group').removeClass('has-error');

			if (json['error']) {
				if (json['error']['option']) {
					for (i in json['error']['option']) {
						var element = $('#input-option' + i.replace('_', '-'));
						
						if (element.parent().hasClass('input-group')) {
							element.parent().after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
						} else {
							element.after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
						}
					}
				}
				
				if (json['error']['recurring']) {
					$('select[name=\'recurring_id\']').after('<div class="text-danger">' + json['error']['recurring'] + '</div>');
				}
				
				// Highlight any found errors
				$('.text-danger').parent().addClass('has-error');
			}
			
			if (json['success']) {
				$('.breadcrumb').after('<div class="alert alert-success">' + json['success'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
				
				$('#cart-total').html(json['total']);
				
				$('html, body').animate({ scrollTop: 0 }, 'slow');
				
				$('#cart > ul').load('index.php?route=common/cart/info ul li');
			}
		}
	});
});
//--></script> 
<script type="text/javascript"><!--
$('.date').datetimepicker({
	pickTime: false,
	useCurrent: false,
	defaultDate: new Date(new Date().setDate(new Date().getDate() + 9)),
	minDate: new Date(new Date().setDate(new Date().getDate() + 9))
});

$('.datetime').datetimepicker({
	pickDate: true,
	pickTime: true
});

$('.time').datetimepicker({
	pickDate: false
});

$('button[id^=\'button-upload\']').on('click', function() {
	var node = this;
	
	$('#form-upload').remove();
	
	$('body').prepend('<form enctype="multipart/form-data" id="form-upload" style="display: none;"><input type="file" name="file" /></form>');
	
	$('#form-upload input[name=\'file\']').trigger('click');
	
	timer = setInterval(function() {
		if ($('#form-upload input[name=\'file\']').val() != '') {
			clearInterval(timer);
			
			$.ajax({
				url: 'index.php?route=tool/upload',
				type: 'post',
				dataType: 'json',
				data: new FormData($('#form-upload')[0]),
				cache: false,
				contentType: false,
				processData: false,
				beforeSend: function() {
					$(node).button('loading');
				},
				complete: function() {
					$(node).button('reset');
				},
				success: function(json) {
					$('.text-danger').remove();
					
					if (json['error']) {
						$(node).parent().find('input').after('<div class="text-danger">' + json['error'] + '</div>');
					}
					
					if (json['success']) {
						alert(json['success']);
						
						$(node).parent().find('input').attr('value', json['code']);
					}
				},
				error: function(xhr, ajaxOptions, thrownError) {
					alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
				}
			});
		}
	}, 500);
});
//--></script> 
<script type="text/javascript"><!--
$('#review').delegate('.pagination a', 'click', function(e) {
  e.preventDefault();

    $('#review').fadeOut('slow');

    $('#review').load(this.href);

    $('#review').fadeIn('slow');
});

$('#review').load('index.php?route=product/product/review&product_id=<?php echo $product_id; ?>');

$('#button-review').on('click', function() {
	var num = $(".review_color").length;
	$.ajax({
		url: 'index.php?route=product/product/write&product_id=<?php echo $product_id; ?>',
		type: 'post',
		dataType: 'json',
		data: 'name=' + encodeURIComponent($('input[name=\'name\']').val())+'&email=' + '&email=' +encodeURIComponent($('input[name=\'email\']').val()) + '&text=' + encodeURIComponent($('textarea[name=\'text\']').val()) + '&rating=' + encodeURIComponent(num) + '&captcha=' + encodeURIComponent($('input[name=\'captcha\']').val()),//encodeURIComponent($('input[name=\'rating\']:checked').val() ? $('input[name=\'rating\']:checked').val() : '')
		beforeSend: function() {
			$('#button-review').button('loading');
		},
		complete: function() {
			$('#button-review').button('reset');
			$("#captcha,.img-captcha").attr("src","index.php?route=<?php echo $captcha_route; ?>#"+(new Date).getTime());
			$('#captcha,.img-captcha').attr('src', 'index.php?route=tool/captcha#'+new Date().getTime());
			$('input[name=\'captcha\']').val('');
		},
		success: function(json) {
			$('.alert-success, .alert-danger').remove();
			
			if (json['error']) {
				$('#review').after('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '</div>');
			}
			
			if (json['success']) {
				$('#review').after('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + '</div>');
				
				$('input[name=\'name\']').val('');
				$('textarea[name=\'text\']').val('');
				$('input[name=\'rating\']:checked').prop('checked', false);
				$('input[name=\'captcha\']').val('');
			}
		}
	});
});

/*$(document).ready(function() {
	$('.thumbnails').magnificPopup({
		$('.owl-carousel').magnificPopup({
			type:'image',
			delegate: 'a',
			gallery: {
				enabled:true;
			}
		});
	});
});*/
//--></script> 
<script type="text/javascript"><!--
$('#carousel<?php echo $product_id; ?>').owlCarousel({
	items: 1,
	singleItem: true,
	autoPlay: false,
	navigation: true,
	navigationText: ['<i class="fa fa-chevron-left fa-5x"></i>', '<i class="fa fa-chevron-right fa-5x"></i>'],
	pagination: true,
	dots:true
});
--></script>
<script type="text/javascript"><!--
	$('.col-sm-5 .list-unstyled a').click( function() {
		$('html, body').animate({
			scrollTop: $(".nav-tabs").offset().top
		}, 100);
	});
//--></script> 
<script type="text/javascript"><!--
$('#button-askquestion').on('click', function() {
	$.ajax({
		url: 'index.php?route=product/product/write1&product_id=<?php echo $product_id; ?>',
		type: 'post',
		dataType: 'json',
		data: 'name1=' + encodeURIComponent($('input[name=\'name1\']').val()) + '&email1=' + encodeURIComponent($('input[name=\'email1\']').val()) + '&text1=' + encodeURIComponent($('textarea[name=\'text1\']').val()) + '&captcha1=' + encodeURIComponent($('input[name=\'captcha1\']').val()),
		beforeSend: function() {
			$('#button-askquestion').button('loading');
		},
		complete: function() {
			$('#button-askquestion').button('reset');
			$('#captcha1').attr('src', 'index.php?route=tool/captcha1#'+new Date().getTime());
			$('input[name=\'captcha1\']').val('');
		},
		success: function(json) {
			$('.alert-success, .alert-danger').remove();
			
			if (json['error']) {
				$('#askquestion').after('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '</div>');
			}
			
			if (json['success']) {
				$('#askquestion').after('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + '</div>');
				
				$('input[name=\'name1\']').val('');
				$('input[name=\'email1\']').val('');
				$('textarea[name=\'text1\']').val('');
				$('input[name=\'captcha1\']').val('');
			}
		}
	});
});
//--></script>
<script type="text/javascript"><!--	
function showplaceholder(placetext)
{
var $txtA = $("textarea");
var emailDef = placetext;
$txtA.val(emailDef);
$txtA.focusout(function() {
     if ($.trim(this.value) == "") {
         this.value = emailDef;
     }
});
$txtA.focus(function() {
     if( this.value == emailDef ) {
         this.value="";
     }
});
}	  
		$('#size input[type=radio]').on('click', function() {
		var optid = $(this).attr('id');
		var optvid = $(this).val();
	    $.ajax({
		url: 'index.php?route=product/product/custom_size&product_id=<?php echo $product_id; ?>',
		type: 'post',
		dataType: 'json',
		data: 'option_value_id=' + encodeURIComponent($(this).val()) + '&option_id=' + encodeURIComponent($(this).attr('id')),
		beforeSend: function() {
			$('#button-review').button('loading');
		},
		complete: function() {
			$('#button-review').button('reset');
			$('#captcha').attr('src', 'index.php?route=tool/captcha#'+new Date().getTime());
			$('input[name=\'captcha\']').val('');
		},
		success: function(json) {
			$('.alert-success, .alert-danger').remove();
			
			if (json['error']) {
				$('#review').after('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '</div>');
			}
			  if (json['success']) {
                var default_remark = json['remarks'];
			    var re =  $("#free_remarks"+ optid).val();
			    if(re==''){ re = json['remarks'];}		
			    json['remarks'] = re; 
			    if($('.'+ optid +' .Free_Customize input[type=radio]').is(':checked')){
				   var re =  $("#cfree_remarks"+ optid).val();
				   if(re==''){ re = json['remarks'];}		
                   json['remarks'] = re;
                   json['bust'] = $("#cfree_bust"+optid).val();
				   json['waist'] = $("#cfree_waist"+optid).val();
				   json['hip'] = $("#cfree_hip"+optid).val();
				   json['hollow'] = $("#cfree_hollow"+optid).val();
				   json['height'] = $("#cfree_height"+optid).val();
				   json['remarks'] = re;
				   // showplaceholder(placetext);
                }
			
                html  = '    <div class="popup-box">';
                html += '    <div id="oc_header" class="col-sm-12"><div id="size_select" style="display: block;"><p><?php echo $text_size_selected; ?><strong><span id="size_x" class="spacial-text"> ' + json['value_name'] + ' <span></span></span></strong><?php echo $text_size_details; ?></p></div>';
                html += '    <span style="position: absolute; right: -1px; top: 0px;" id="cartcuclose" >X</span>';
                html += '    <div class="clear"></div></div>';
                html += '    <div id="oc">';
                html += '    <div class="oc_left col-sm-8 col-xs-12 col-md-8">';
                html += '    <form action="" >';
                html += '    <div class="size_note"><p>' + json['description'] + '</p></div>';
                html += '    <div class="clear"></div>';
                html += '    <dl class="size_details">';
                html += '    <input type="hidden" name="optionval" value="' + json['option_value_id'] + '" class="binput" />';
                html += '    <input type="hidden" name="optionid"  value="' + optid + '" class="binput" />';				
                html += '    <dt><label id="label_bust"><i>*</i><?php echo $text_bust; ?></label></dt>';
                html += '    <dd><input type="text" name="opbust" value="' + json['bust'] + '" class="binput" /><span class="text_size_unit"><?php echo $text_inch; ?></span></dd>';
                html += '    <dt><label id="label_waist"><i>*</i><?php echo $text_waist; ?></label></dt>';
                html += '    <dd><input type="text" name="opwaist" value="' + json['waist'] + '" class="binput"/><span class="text_size_unit"><?php echo $text_inch; ?></span></dd>';
                html += '    <dt><label id="label_hip"><i>*</i><?php echo $text_hip; ?></label></dt>';
                html += '    <dd><input type="text" name="ophip" value="' + json['hip'] + '" class="binput"/><span class="text_size_unit"><?php echo $text_inch; ?></span></dd>';
                html += '    <dt><label id="label_hollow"><i>*</i><?php echo $text_hollow; ?></label></dt>';
                html += '    <dd><input type="text" name="ophollow" value="' + json['hollow'] + '" class="binput"/><span class="text_size_unit"><?php echo $text_inch; ?></span></dd>';
                html += '    <dt><label id="label_height"><?php echo $text_height; ?></label></dt>';
                html += '    <dd><input type="text" name="opheight" value="' + json['height'] + '" class="binput"/><span class="text_size_unit"><?php echo $text_inch; ?></span></dd>';
                html += '    </dl>';
                html += '    <div class="clear"></div>';
                html += '    <div id="req"></div>';
                html += '    <div id="oc_submit"><p style="color:#222;"><?php echo $text_item_remarks; ?></p>';
                html += '    <textarea class="bs_input" id="txtItem" name="txtItemRemark" ></textarea>';
                html += '    <input type="hidden" name="txtar" value="' + default_remark + '" class="binput" />';
                html += '    <div style="clear:both;text-align: center;">';
                html += '    <input value="<?php echo $text_cancel; ?>" style="margin-right:8px; padding:5px 16px;" id="btnCancelItemRemark" class="secondary-button" type="button">';
                html += '    <input curidtype="nocus" curid="2" style="padding:5px 16px;" value="<?php echo $text_submit; ?>" id="btnSubItemRemark" class="primary-button" type="button"></div>';
                html += '    </div>';
                html += '    </form>';
                html += '    </div>';
                html += '    <div class="oc_left col-sm-4 col-xs-4 col-md-4">';
                html += '    <a href="http://www.bjsbridal.com/measuring-guide.html" target="_blank" style="float: left;"><img src="image/' + json['image'] + '" /></a>';
                html += '    </div>';
                html += '    <div class="oc_tips col-sm-4 col-xs-4 col-md-4">';
				html += '    <a href="http://www.bjsbridal.com/measuring-guide.html" target="_blank" style="float: left;">Click here to see more details about measuring guide.</a>';
                html += '    </div>'
                html += '    </div>';
                html += '    </div>';
                if($('.popup-box').length){
                $('#mask').hide();
                $('.window').hide();
                $(".popup-box").remove();
                $('#dialog').append(html);
                showpopup();
                }else{
                $('#dialog').append(html);
                showpopup();
                }

			  var placetext = json['remarks'];
              showplaceholder(placetext);
			  			  
			}
			
		}
	});
});
function uncheck_option(opt)
{var id = "input-option"+opt;
$("#"+ id +" input[type='radio']").each(function(){
      $(this).prop('checked', false); 
});
}
function showpopup()	
{
var id = '#dialog';
	
//Get the screen height and width
var maskHeight = $(document).height();
var maskWidth = $(window).width();
	
//Set heigth and width to mask to fill up the whole screen
$('#mask').css({'width':maskWidth,'height':maskHeight});

//transition effect
$('#mask').fadeIn(20);	
$('#mask').fadeTo(20);	
	
//Get the window height and width
var winH = $(window).height();
var winW = $(window).width();
              
//Set the popup window to center
$(id).css('top',  winH/3-$(id).height()/3);
$(id).css('left', winW/2-$(id).width()/2);
	
//transition effect
$(id).fadeIn(200); 	
	
//if close button is clicked
$('.window #cartcuclose').click(function (e) {
var opt_id = $("input[name=optionid]").val();

//Cancel the link behavior
e.preventDefault();

$('#mask').hide();
$('.window').hide();
$(".popup-box").remove();
uncheck_option(opt_id);
});

$('.window #btnCancelItemRemark').click(function (e) {
var opt_id = $("input[name=optionid]").val();

//Cancel the link behavior
e.preventDefault();

$('#mask').hide();
$('.window').hide();
$(".popup-box").remove();
uncheck_option(opt_id);
});

$('#btnSubItemRemark').on('click', function() {
    var opt_id = $("input[name=optionid]").val();
	var opt_v_id = $("input[name=optionval]").val();
    $('.custom_con'+opt_id).empty();
	var txtval = $("input[name=txtar]").val();
	var txtremark = $("#oc_submit textarea").val();
	if(txtremark == txtval){ var remr = ''; } else { var remr = txtremark;}
	$.ajax({
		url: 'index.php?route=product/product/check_size&product_id=<?php echo $product_id; ?>',
		type: 'post',
		dataType: 'json',
		data: 'option_value_id=' + encodeURIComponent($("input[name=optionval]").val()) +'&bust=' +encodeURIComponent($("input[name=opbust]").val())+'&waist='+encodeURIComponent($("input[name=opwaist]").val())+'&hip='+encodeURIComponent($("input[name=ophip]").val())+'&hollow='+encodeURIComponent($("input[name=ophollow]").val())+'&height='+encodeURIComponent($("input[name=opheight]").val())+'&remarks='+remr,
		beforeSend: function() {
			$('#button-review').button('loading');
		},
		complete: function() {
		},
		success: function(json) {
			$('.alert-success, .alert-danger').remove();
			
			if (json['error_bust'] || json['error_waist'] || json['error_hip'] || json['error_hollow']) {
			        if(json['error_bust']){
					$("input[name=opbust]").addClass('act');
					}
			        if(json['error_waist']){
					$("input[name=opwaist]").addClass('act');
					}
			        if(json['error_hip']){
					$("input[name=ophip]").addClass('act');
					}
			        if(json['error_hollow']){
					$("input[name=ophollow]").addClass('act');
					}			
			}else
			if (json['success']) {
			
			    if(json['custom']){
			       var siz = json['size'];
			       $('.'+ opt_id +' label').removeClass('actives');
				   $( '.'+ opt_id +' .'+ siz +' input[type=radio]' ).prop( 'checked', false );
                   $('.'+ opt_id +' .'+siz).addClass('actives');	
				   $('.'+ opt_id +' .' + siz +' input[type=radio]').prop( 'checked', true );
                   var bust = $("input[name=opbust]").val(); var waist = $("input[name=opwaist]").val(); var hip = $("input[name=ophip]").val(); var hollow = $("input[name=ophollow]").val(); var height = $("input[name=opheight]").val(); var remarks = remr;
                   $('#free_bust'+opt_id).val(bust);
                   $('#free_waist'+opt_id).val(waist);
                   $('#free_hip'+opt_id).val(hip);
                   $('#free_hollow'+opt_id).val(hollow);
                   $('#free_height'+opt_id).val(height);
                   $('#free_remarks'+opt_id).val(remarks);	
                   $('#cfree_bust'+opt_id).val(bust);
                   $('#cfree_waist'+opt_id).val(waist);
                   $('#cfree_hip'+opt_id).val(hip);
                   $('#cfree_hollow'+opt_id).val(hollow);
                   $('#cfree_height'+opt_id).val(height);
                   $('#cfree_remarks'+opt_id).val(remarks);				   
                   $('.custom_con'+opt_id).append('<?php echo $text_bust; ?>: <strong>'+ bust +' <?php echo $text_inch; ?></strong>, <?php echo $text_waist; ?>: <strong>'+ waist +' <?php echo $text_inch; ?></strong>, <?php echo $text_hip; ?>: <strong>'+ hip +' <?php echo $text_inch; ?></strong>, <?php echo $text_hollow; ?>: <strong>'+ hollow +' <?php echo $text_inch; ?></strong>, <?php echo $text_height; ?>: <strong>'+ height +' <?php echo $text_inch; ?></strong>');				   
				   }else{
			       var siz = json['success'];
			       $('.'+ opt_id +' label').removeClass('actives');
				   $( '.'+ opt_id +' .' + siz +' input[type=radio]' ).prop( 'checked', false );
                   $('.'+ opt_id +' .'+siz).addClass('actives');	
                   $('.'+ opt_id +' .' + siz +' input[type=radio]').prop( 'checked', true );				   
                   var bust = $("input[name=opbust]").val(); var waist = $("input[name=opwaist]").val(); var hip = $("input[name=ophip]").val(); var hollow = $("input[name=ophollow]").val(); var height = $("input[name=opheight]").val(); var remarks = remr;
                   $('#free_bust'+opt_id).val(bust);
                   $('#free_waist'+opt_id).val(waist);
                   $('#free_hip'+opt_id).val(hip);
                   $('#free_hollow'+opt_id).val(hollow);
                   $('#free_height'+opt_id).val(height); 
                   $('#free_remarks'+opt_id).val(remarks);				   
                   $('.custom_con'+opt_id).empty();				   
				   }
				   $('#mask').hide();
                   $('.window').hide();
                  $(".popup-box").remove();
			}
			
		}
	});
});
}

</script>

<script>
$(function(){
	/*产品页 详情介绍的折叠下拉效果*/
	var Owidth = $(window).width();
	if(Owidth<768)
	{
		var twoWidth = $('.liTwo').offset().top;
        var threeWidth = $('.liThree').offset().top;
		$('.ul-Remove').removeClass('nav nav-tabs')
		$('#tab-description,#tab-review,#tab-askquestion').hide();
		$('.liOne').click(function(){
			$('#tab-review,#tab-askquestion').hide();
			$(this).toggleClass('liOne2');
			$('#tab-description').slideToggle(200);
			$('.liTwo').removeClass('liTwo2');
			$('.liThree').removeClass('liThree2');
		});
		$('.liTwo').click(function(){
		    $('#tab-description,#tab-askquestion').hide();
			$(this).toggleClass('liTwo2');
			$('#tab-review').slideToggle(200);
			$('.liOne').removeClass('liOne2');
			$('.liThree').removeClass('liThree2');
			$('html,body').scrollTop(($('.liTwo').offset().top) - 50);
		});
		$('.liThree').click(function(){
			$('#tab-description,#tab-review').hide();
			$(this).toggleClass('liThree2');
			$('#tab-askquestion').slideToggle(200);
			$('.liTwo').removeClass('liTwo2');
			$('.liOne').removeClass('liOne2');
			$('html,body').scrollTop(($('.liThree').offset().top) - 50);
		});		
		$('.linkaOne').click(function(){
			$('#tab-review').show();
			$('html,body').animate({scrollTop:($('.liTwo').offset().top) - 50},100);
			$('.liTwo').toggleClass('liTwo2');
		});
		$('.linkaTwo').click(function(){
			 $('#tab-askquestion').show();
			 $('html,body').animate({scrollTop:($('.liThree').offset().top) - 50},100);	
			 $('.liThree').toggleClass('liThree2');								 
		});				

		//移除col-sm-3
		$('.related-row').removeClass('col-sm-3').children().removeClass('row');
	}else{
		$('.linkaOne').click(function(){
			$('html,body').animate({scrollTop:$('.liTwo').offset().top},100);
		});
		$('.linkaTwo').click(function(){
			 $('html,body').animate({scrollTop:$('.liThree').offset().top-50},100);				 
		});		
	}		
})
</script>

<style>
.custom_box{
display: block;
height: auto;
overflow: auto;
width: 100%;
}
#mask {
  position:fixed;
  left: 0;
  top: 0;
  z-index: 9000;
  background-color:rgba(0, 0, 0, 0.1)
  display: none;
}
.spacial-text{
color: #CE2525;
}
#boxes .window {
display: none;
z-index: 9999;
position: fixed;
background-color: #FFF;
margin: auto;
border: 1px solid #999;
box-shadow: 0px 0px 10px #333;
z-index: 100000;
font-family: Calibri;
padding:0px;
}
#boxes #dialog {
padding-bottom: 6px;
height: auto;
}
.popup-box{
margin: auto;
border: 1px solid #fff;
background: #fff;
}
#oc_header{
background: #F2F2F2 none repeat scroll 0% 0%;
padding: 8px 11px 1px;
}
#oc_header p {
font-size: 14px;
font-weight: bold;
text-align: left;
line-height: 12px;
}
#cartcuclose {
height: 18px;
position: absolute;
right: 0px;
top: 5px !important;
width: 25px;
z-index: 9999;
cursor:pointer;
font-weight: bold;
}
.size_note p {
    line-height: 1.5em;
    margin-bottom: 0;
	font-size: 13px;
}
#oc {
    margin: 0px 12px;
}
.oc_left {
float: left;
/* height: 350px;
width: 190px; */
padding: 6px 0px 0px 0px;
}
.oc_right {
float: right;
/* width: 395px; */
margin-left:0px;
font-size: 12px;
padding:5px;
}
.oc_tips {
float: right;
margin-left:0px;
font-size: 12px;
padding:5px;
}
.oc_tips {
float: right;
margin-left:0px;
font-size: 12px;
padding:5px;
}
@media (max-width: 768px) {
	.oc_tips {
		float: left;
		margin-left:20px;
	}
}
.oc_tips a,.oc_tips a:hover,.oc_tips a:focus {
color: #f00;
}
dl.size_details {
    display: block;
	overflow: auto;
	margin: 2px;
}
dl dt {
    float: left;
    width: 45%;
	margin-top: 2px;
    padding-right: 10px;
    text-align: right;
    line-height: 20px;
    clear: both;
}
dt label{
font-size: 13px;
font-weight: normal;
margin-bottom:0px;
}
dl dd {
    float: left;
    width: 45%;
	margin-top: 2px;
    line-height: 23px;
    display: inline;
}
.binput {
    border: 1px solid #CCC;
    padding-left: 4px;
    width: 46px;
	font-size: 12px;
    box-shadow: 1px 1px 1px 1px #FAFAFA inset;
    height: 18px;
    color: #CE2525;
	line-height: 2px;
}
.text_size_unit {
	margin-left: 3px;
	font-size: 13px;
}
.size_details i {
    color: #DD4B39;
    font-weight: bold;
    vertical-align: middle;
    font-style: normal;
    padding: 0px 4px;
}
#oc_submit {
    padding-top: 0px;
}
#oc_submit p{
    margin-bottom:0px;
}
.bs_input {
	border: 1px solid #DDD;
	height: 36px;
	margin-bottom: 0px;
	padding: 2px 4px;
	width:100%;
	color: #555;
	line-height: 14px;
}
#oc_submit textarea {
    overflow: auto;
    box-shadow: 1px 1px 1px 1px #F3F3F3 inset;
}

#btnSubItemRemark {
	font-size: 15px;
	font-weight: bold;
    border: medium none;
    cursor: pointer;
    height: 30px;
    width: 88px;
}
#btnCancelItemRemark {
	font-size: 15px;
    border: medium none;
    cursor: pointer;
    height: 30px;
    width: 88px;
}
.primary-button {
    background-color: #229ac8;
    color: #FFF;
    border: 1px solid #229ac8;
}
.secondary-button {
	background-color: #eeeeee;
	border: 1px solid #999;
	color: #666;
}
.primary-button, .secondary-button {
    display: inline-block;
    margin: 8px 0px;
    cursor: pointer;
    padding: 6px 16px;
    font-weight: normal;
    letter-spacing: 1px;
    border-radius: 0px;
    overflow: visible;
}
.clear {
    clear: both;
}
.act { border:1px solid red !important;}
input[type="radio"] {
    display:none;
}
#size {
	margin-bottom: 5px;
}
#size .text-danger {
	clear: both;
}
#size .radio label {
font-family: "Ubuntu",sans-serif;
font-size: 12px;
background: rgb(246, 246, 246) none repeat scroll 0% 0%;
color: #333;
border: 1px solid #C9C9CC;
padding: 2px 8px;
}
#size .radio label:hover{
border:1px solid #f00!important;
}
.actives{
border:2px solid #f00!important;
}
.oc_left img {
    border: 1px solid #DDD;
	margin-left: 5px;
	width: 100%;
}
#size .radio {
margin: 2px 0px 2px 0px !important;
padding: 2px 3px !important;
float: left !important;
display: inline-block !important;
}
#size input[type="radio"] {
    display: none;
}
input[type="radio"] {
    display: inline;
}
#size .control-label {
	margin-bottom: 5px;
}
.form-group {
	overflow:auto !important;
}
</style>
<?php if ($qa_status) { ?>
<script type="text/javascript"><!--
<?php if ($recaptcha) { ?>
var grw;$("body").on("click","#qa-ask",function(a){a.preventDefault(),$("a[href='#tab-qa']").trigger("click"),$("html,body").animate({scrollTop:$("#qa-title").offset().top},1300)}).on("click","#qa .pagination a",function(){var a=this.href;return $("#qa").slideUp("slow",function(){$("#qa").load(a,function(){$("#qa").slideDown("slow")})}),!1});<?php if ($preload != 1) { ?>$("#qa").load("index.php?route=product/product/question&product_id=<?php echo $product_id; ?>");<?php } ?>$("#button-qa").on("click",function(){$.ajax({type:"POST",url:"index.php?route=product/product/ask&product_id=<?php echo $product_id; ?>",dataType:"json",data:$("#q-form :input").serialize(),beforeSend:function(){$("#button-qa").button("loading")},complete:function(){$("#button-qa").button("reset"),grw&&grecaptcha&&grecaptcha.reset(grw)},success:function(a){$(".alert-success, .alert-danger").remove(),a.error&&$("#qa").after('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> '+a.error+"</div>"),a.success&&($("#qa").after('<div class="alert alert-success"><i class="fa fa-check-circle"></i> '+a.success+"</div>"),$("textarea[name='q_question']").val(""))},error:function(a){$("#qa").after('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> '+a.statusText+"</div>")}})});<?php if ($qa_form_display_captcha) { ?>window.onload=function(){grecaptcha&&(grw=grecaptcha.render("q_grecaptcha",{sitekey:"<?php echo $site_key; ?>"}))};<?php } ?>
<?php } else { ?>
$("body").on("click","#qa-ask",function(a){a.preventDefault(),$("a[href='#tab-qa']").trigger("click"),$("html,body").animate({scrollTop:$("#qa-title").offset().top},1300)}).on("click","#qa .pagination a",function(){var a=this.href;return $("#qa").slideUp("slow",function(){$("#qa").load(a,function(){$("#qa").slideDown("slow")})}),!1});<?php if ($preload != 1) { ?>$('#qa').load('index.php?route=product/product/question&product_id=<?php echo $product_id; ?>');<?php } ?>$("#button-qa").on("click",function(){$.ajax({type:"POST",url:"index.php?route=product/product/ask&product_id=<?php echo $product_id; ?>",dataType:"json",data:$("#q-form :input").serialize(),beforeSend:function(){$("#button-qa").button("loading")},complete:function(){$("#button-qa").button("reset"),$("#captcha,.img-captcha").attr("src","index.php?route=<?php echo $captcha_route; ?>#"+(new Date).getTime()),$("input[name='q_captcha']").val("")},success:function(a){$(".alert-success, .alert-danger").remove(),a.error&&$("#qa").after('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> '+a.error+"</div>"),a.success&&($("#qa").after('<div class="alert alert-success"><i class="fa fa-check-circle"></i> '+a.success+"</div>"),$("textarea[name='q_question']").val(""),$("input[name='q_captcha']").val(""))},error:function(a){$("#qa").after('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> '+a.statusText+"</div>")}})});
<?php } ?>
//--></script>
<?php } ?>
<style>
.verified_buyer {
	background-color: #698b22;
	color: #ffffff;
	padding: 2px 3px;
	font-size: 11px;
	font-weight: normal;
	-webkit-border-radius: 3px;
	-khtml-border-radius: 3px;    
	-moz-border-radius: 3px;
	border-radius: 3px;
}
</style>
<?php echo $footer; ?>
