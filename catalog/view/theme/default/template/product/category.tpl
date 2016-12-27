<?php echo $header; ?>
<div class="container">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
  <div class="row category-row"><?php echo $column_left; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-sm-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-sm-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-sm-12'; ?>
    <?php } ?>
    <div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>
		<h1><?php echo $heading_title; ?></h1>
      <?php if ($products) { ?>
		 <div id="input-sort" class="">
		   <a href="<?php echo $popular; ?>" class="d_s" alt="<?php echo $viewed['title'];?>" ><span class="sortspan1">Popular</span></a>
			<a href="<?php echo $viewed['href']?>" class="d_s"  alt="<?php echo $viewed['title'];?>" ><span class="sortspan2">View&nbsp&nbsp<i class="fa fa-sort"></i></span></a>
			<a href="<?php echo $sorts['href'];?>" class="d_s" alt="<?php echo $sorts['title']?>" ><span class="sortspan3">Price&nbsp&nbsp<i class="fa fa-sort"></i></span></a>
		 </div>
		<div class="onfilter btn btn-primary ">Filter</div> 
      <div class="row" style="margin-bottom:10px;">
        <?php foreach ($products as $product) { ?>
        <div class="product-layout product-grid col-lg-3 col-md-3 col-sm-6 col-xs-6">
          <div class="product-thumb">
	      <div class="image imageHover">
				<a href="<?php echo $product['href']; ?>" target="_blank">
						<img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive" />
				</a>
				<?php if($product['num'] > 1) { ?><img class="multicolor" src="catalog/view/theme/default/image/color.png"><?php } ?>
				<span class="discount"><?php echo $product['off'].'%'; ?></span>
				<?php $str = substr($product['model'],0,1); if($str == 'S'){ ?><img class="Hours24" src="catalog/view/theme/default/image/24h.png"><?php } ?>			
		  </div>
              <div class="caption">
                <h4><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
                <?php if ($product['price']) { ?>
                <p class="price">
                  <?php if (!$product['special']) { ?>
                  <?php echo $product['price']; ?>
                  <?php } else { ?>
                  <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
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
      <div class="row">
        <div class="text-center"><?php echo $pagination1; ?></div>
      </div>
      <?php } ?>
      <?php if (!$categories && !$products) { ?>
      <p><?php echo $text_empty; ?></p>
      <div class="buttons">
        <div class="pull-right"><a href="<?php echo $continue; ?>" class="btn btn-primary"><?php echo $button_continue; ?></a></div>
      </div>
      <?php } ?>
      <?php echo $content_bottom; ?></div>
    <?php echo $column_right; ?></div>
</div>
<?php echo $footer; ?>
