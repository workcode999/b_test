<?php if (count($products)>0) { ?>
	<h3><?php echo $heading_title; ?></h3>

	<div class="row">
	<?php foreach ($products as $product) { ?>
	    <div class="AnyListDiv product-layout product-grid col-lg-3 col-md-3 col-sm-6 col-xs-6">
	        <div class="product-thumb">
                    <?php if ($product['thumb']) { ?>
                    <div class="image imageHover">
							<a href="<?php echo $product['href']; ?>"><img class="img-responsive" src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a>
							<?php if($product['num'] > 1) { ?><img class="multicolor" src="catalog/view/theme/default/image/color.png"  /><?php } ?>
							<span class="discount"><?php echo $product['off'].'%'; ?></span>
							<?php $str = substr($product['model'],0,1); if($str == 'S'){ ?><img class="Hours24" src="catalog/view/theme/default/image/24h.png"><?php } ?>
					</div>
                    <?php } ?>
		    <div class="caption">
			    <h4><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>

			    <?php if ($product['price']) { ?>
				<p class="price">
				  <?php if (!$product['special']) { ?>
					<?php echo $product['price']; ?>
				  <?php } else { ?>
					<span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
				  <?php } ?>				  
				</p>
			    <?php } ?>
		     </div>
                </div>  
            </div>
        <?php } ?>
	</div>	
	
	<script type="text/javascript">
		$(document).ready(
			function() {
				$('.AnyListDiv').each( 
					function(index) {
						var divclass = 'col-lg-12 col-md-12'; 
						if (($(this).closest('#column-right').length==0) && ($(this).closest('#column-left').length==0)) { // if we are in content area check the layout
							var cols = $('#column-right, #column-left').length; // how many columns we have
							// 2 columns - left, right and content - smallest content area - 2 boxes on row
							if (cols==2) 
								divclass = 'col-lg-6 col-md-6 col-sm-12 col-xs-6';
									
							// 1 column - left or right and content - 3 boxes on row	
							if (cols==1) 	
								divclass = 'col-lg-4 col-md-4 col-sm-8 col-xs-6';	
								
							// only content - largest content area - 4 boxes on row
							if (cols==0) 
								divclass = 'product-layout product-grid col-lg-3 col-md-3 col-sm-6 col-xs-6';	
						}
						$(this).addClass(divclass);
					}
				)
			}
		);
	</script>
	
<?php } ?>