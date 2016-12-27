    <div id="instock-row" class="row col-md-3 col-xs-3">
	<div class="row">
	  <h4 class="instock-h3"><?php echo $heading_title; ?></h4>
        <?php shuffle($products) ?>
        <?php foreach ($products as $product) { ?>
        <div class="col-md-6 col-xs-6">
            <div>
                <div class="image">
					<a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive"/></a>
					<?php if($product['num'] > 1) { ?><img class="multicolor" src="catalog/view/theme/default/image/color.png"><?php } ?>
					<span class="discount1"><?php echo $product['off'].'%'; ?></span>
					<?php $str = substr($product['model'],0,1); if($str == 'S'){ ?><img class="Hours241" src="catalog/view/theme/default/image/24h.png"><?php } ?>
                </div>
                <div class="caption">
                    <?php if ($product['price']) { ?>
                    <p class="price">
                        <?php if (!$product['special']) { ?>
                        <?php echo $product['price']; ?>
                        <?php } else { ?>
                        <span class="instock-price-new"><?php echo $product['special']; ?></span>
                        <?php } ?>
                        <?php if ($product['tax']) { ?>
                        <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
                        <?php } ?>
                    </p>
                    <?php } ?>
                </div>
            </div>
        </div>
        <?php } ?>
		</div>
    </div>
<script>
$(function(){
	var oWidth = $(window).width();
	if(oWidth<768)
	{
		$('#instock-row').removeClass('col-md-3 col-xs-3 row');
	}
});











</script>