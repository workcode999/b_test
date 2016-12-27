<?php echo $header; ?>
<div class="container">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
   <div class="search_keyword" style="text-align: center; "><h2><?php echo $search; ?></h2></div>
  <div class="row"><?php echo $column_left; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-sm-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-sm-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-sm-12'; ?>
    <?php } ?>
    <div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>
      <?php if ($products) { ?>
		 <div id="input-sort" class="">
		   <a href="<?php echo $popular; ?>" class="d_s" alt="<?php echo $viewed['title'];?>" ><span class="sortspan1">Popular</span></a>
			<a href="<?php echo $viewed['href']?>" class="d_s"  alt="<?php echo $viewed['title'];?>" ><span class="sortspan2">View&nbsp&nbsp<i class="fa fa-sort"></i></span></a>
			<a href="<?php echo $sorts['href'];?>" class="d_s" alt="<?php echo $sorts['title']?>" ><span class="sortspan3">Price&nbsp&nbsp<i class="fa fa-sort"></i></span></a>
		 </div>
      <div class="row" style="margin-bottom:10px;">
        <?php foreach ($products as $product) { ?>
        <div class="product-layout product-grid col-lg-3 col-md-3 col-sm-6 col-xs-6">
          <div class="product-thumb">
           <div class="image imageHover">
			   <a href="<?php echo $product['href']; ?>" target="_blank"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive" /></a>
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
              <?php if ($product['rating']) { ?>
              <div class="rating">
                <?php for ($i = 1; $i <= 5; $i++) { ?>
                <?php if ($product['rating'] < $i) { ?>
                <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
                <?php } else { ?>
                <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
                <?php } ?>
                <?php } ?>
              </div>
              <?php } ?>
            </div>
          </div>
        </div>
        <?php } ?>
      </div>
      <div class="row">
        <div class="text-center"><?php echo $pagination1; ?></div>
      </div>
      <?php } else { ?>
      <p>			   
	  <?php
			echo $text_empty;
			if(isset($search_suggestion) && $search_suggestion != '') {
		?>
				<div class="sphinx-suggestion"><?php echo $entry_suggestion; ?> <a href="<?php echo $suggestion_link; ?>"><?php echo $search_suggestion; ?></a>?</div>
		<?php
			}
		?>
		</p>
      <?php } ?>
      <?php echo $content_bottom; ?></div>
    <?php echo $column_right; ?></div>
</div>
<script type="text/javascript"><!--
$('#button-search').bind('click', function() {
	url = 'index.php?route=product/search';
	
	var search = $('#content input[name=\'search\']').prop('value');
	
	if (search) {
		url += '&search=' + encodeURIComponent(search);
	}

	var category_id = $('#content select[name=\'category_id\']').prop('value');
	
	if (category_id > 0) {
		url += '&category_id=' + encodeURIComponent(category_id);
	}
	
	var sub_category = $('#content input[name=\'sub_category\']:checked').prop('value');
	
	if (sub_category) {
		url += '&sub_category=true';
	}
		
	var filter_description = $('#content input[name=\'description\']:checked').prop('value');
	
	if (filter_description) {
		url += '&description=true';
	}

	location = url;
});

$('#content input[name=\'search\']').bind('keydown', function(e) {
	if (e.keyCode == 13) {
		$('#button-search').trigger('click');
	}
});

$('select[name=\'category_id\']').on('change', function() {
	if (this.value == '0') {
		$('input[name=\'sub_category\']').prop('disabled', true);
	} else {
		$('input[name=\'sub_category\']').prop('disabled', false);
	}
});

$('select[name=\'category_id\']').trigger('change');
--></script> 
<?php echo $footer; ?> 