<!DOCTYPE html>
<!--[if IE]><![endif]-->
<!--[if IE 8 ]><html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie8"><![endif]-->
<!--[if IE 9 ]><html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie9"><![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-->
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>">
<!--<![endif]-->
<head>
<meta charset="UTF-8" />
<meta http-equiv="Access-Control-Allow-Origin" content="*">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0" />
<meta name="google-site-verification" content="MU6J_6AVspQ_2hEMuvI345lTQyf_Dhdi8j753I8rKlI" />
<meta name="msvalidate.01" content="1415D52722947FF587546B5805D35AF2" />
<title><?php echo $title; ?></title>
<base href="<?php echo $base; ?>" />
<?php if ($description) { ?>
<meta name="description" content="<?php echo $description; ?>" />
<?php } ?>
<?php if ($keywords) { ?>
<meta name="keywords" content= "<?php echo $keywords; ?>" />
<?php } ?>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<?php if ($icon) { ?>
<link href="<?php echo $icon; ?>" rel="icon" />
<?php } ?>
<?php foreach ($links as $link) { ?>
<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
<?php } ?>
<script src="catalog/view/javascript/jquery/jquery-2.1.1.min.js" type="text/javascript"></script>
<script src="catalog/view/javascript/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<link href="catalog/view/javascript/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen" />
<link href="catalog/view/theme/default/stylesheet/stylesheet.css" rel="stylesheet">
<link href="catalog/view/javascript/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
<link href="catalog/view/javascript/gg/OpenSans.css" rel="stylesheet" type="text/css" />
<?php foreach ($styles as $style) { ?>
<link href="<?php echo $style['href']; ?>" type="text/css" rel="<?php echo $style['rel']; ?>" media="<?php echo $style['media']; ?>" />
<?php } ?>
<script src="catalog/view/javascript/jquery.range.js" type="text/javascript"></script>
<script src="catalog/view/javascript/common.js" type="text/javascript"></script>
<?php foreach ($scripts as $script) { ?>
<script src="<?php echo $script; ?>" type="text/javascript"></script>
<?php } ?>
<?php if (isset($google_ga_remarketing_code))
{
	echo $google_ga_remarketing_code;
} ?>
<style>	
	.sphinxsearch {
		display: none;
		width:100%;
		position: absolute;
		top: 36px;
		right: 0;
		background: #fff;
		line-height: 1.2;
		z-index: 9999999;
		border: 1px solid #ccc;
		border-top: 0;
		border-radius: 5px;
		border-top-right-radius: 0;
		border-top-left-radius: 0;
	}
	.sphinx-product, .sphinx-product-cat {
		min-height: 40px;
		border-bottom: 1px solid #e9e9e9;
		color: #000;
		display: block;
		font-size: 11px;
		font-weight: normal;
		padding: 5px;
		text-decoration: none;
		line-height: 38px;
	}
	@media(min-width: 992px) and (max-width: 1200px){
		.sphinxsearch{
			width: 101%;
		}
	}
	@media(min-width: 768px) and (max-width: 991px){
		.sphinxsearch{
			width: 102%;
		}
	}
	@media (max-width: 767px){
		.sphinxsearch{
			width: 100%;
			top:30px;
		}
		.sphinx-product {
			line-height: 18px;
		}
	}
	#search, .searchbox {
		overflow: visible;
		z-index: 1;
	}
	.sphinxsearch .categories span,
	.sphinxsearch .products span {
		text-align: center;
		display: block;
		padding: 10px 0;
		background: #eee;
		font-size: 14px;
	}
	.sphinx-product-cat {
		line-height: 40px;
		text-transform: uppercase;
		text-indent: 10px;
	}
	.sphinx-product img, .sphinx-product-cat img {
		float: left;
		margin: 0 10px 0 0;
	}
	.sphinx-product strong {
		font-size: 13px;
		margin: 5px 5px 5px 0;
	}
	.sphinx-viewall {
		font-size: 12px;
		font-weight: bold;
		padding: 10px;
		text-align: center;
	}
</style>	
<?php echo $sphinx_autocomplete_js; ?>
<script src="catalog/view/javascript/cws.web.js" type="text/javascript"></script>
</head>
<body class="<?php echo $class; ?>">
<nav id="top">
  <div class="container">
    <?php echo $currency; ?>
    <?php echo $language; ?>
    <div id="top-links" class="nav pull-right">
      <ul class="list-inline">
		<li class="live-support">
			<script language="javascript">
			<!--
			if(document.all || document.getElementById)
			{
				document.write('<span id="LR_User_TextLink0"></span>');
			}
			else if(document.layers)
			{
				document.write('<layer name="LR_User_TextLink0"></layer>');
			}
			//-->
			</script>
		</li>
		<li><?php echo $cart; ?></li>
		<li class="myUserMax"><?php if(empty($email)){ ?><a href="<?php echo $account; ?>" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user"></i> <span class="hidden-xs hidden-sm hidden-md"><?php echo $text_account; ?></span>&nbsp&nbsp<i class="fa fa-angle-down"></i></a><?php } else{ ?><a href="<?php echo $account; ?>" title="<?php echo $text_account; ?>" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user"></i> <span class="hidden-xs hidden-sm hidden-md"><?php $email = explode('@',$email); echo 'Hi,'.$email[0]; ?></span>&nbsp&nbsp<i class="fa fa-angle-down"></i></a><?php } ?>
          <ul class="dropdownChange">
            <?php if ($logged) { ?>
            <li><a href="<?php echo $account; ?>"><?php echo $text_account; ?></a></li>
            <li><a href="<?php echo $logout; ?>"><?php echo $text_logout; ?></a></li>
            <?php } else { ?>
            <li><a href="<?php echo $register; ?>"><?php echo $text_register; ?></a></li>
            <li><a href="<?php echo $login; ?>"><?php echo $text_login; ?></a></li>
            <?php } ?>
          </ul>
        </li>
        <li class="MyfavoritesMax"><a href="<?php echo $wishlist; ?>" id="wishlist-total" title="<?php echo $text_wishlist; ?>"><i class="fa fa-heart"></i> <span class="hidden-xs hidden-sm hidden-md"><?php echo $text_wishlist; ?></span></a></li>
        <li class="pc-order"><a href="<?php echo HTTPS_SERVER . 'index.php?route=account/guest'; ?>"><i id="myOrder"></i><span class="hideOrder">My Order<span></a></li>    
	</ul>
    </div>
  </div>
</nav>
<header>
  <div class="container">
    <div class="row logoSearch">
      <div class="col-sm-4">
        <div id="logo">
          <?php if ($logo) { ?>
          <a href="<?php echo $home; ?>"><img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" class="img-responsive" /></a>
          <?php } else { ?>
          <a href="<?php echo $home; ?>"><img src="catalog/view/theme/default/image/logo.png" /></a>
          <?php } ?>
        </div>
      </div>
      <div class="col-sm-8"><?php echo $search; ?>
      </div>
    </div>
  </div>
</header>
<?php if ($categories) { ?>
<div class="container">
  <nav id="menu" class="navbar">
    <div class="navbar-header">
      <button type="button" class="btn btn-navbar navbar-toggle"><i class="fa fa-bars"></i></button>
    </div>
    <div class="collapse navbar-collapse navbar-ex1-collapse">
      <ul class="nav navbar-nav">
	  			<div class="m-search"><?php echo $search; ?></div>
				<li class="m-home"><a href="<?php echo $home; ?>"><i class="glyphicon glyphicon-home"></i>&nbsp&nbspHome</a></li>
				<li class="m-order"><a href="<?php echo HTTPS_SERVER . 'index.php?route=account/guest'; ?>"><i class="fa fa-file-text-o"></i>&nbsp&nbspTrack My Order</a></li>
				<?php if (!empty($email)) { ?>
				<li class="myUserMin userToggle"><a><i class="glyphicon glyphicon-user"></i>&nbsp&nbsp<?php echo 'Hi,'.$email[0]; ?><i class="userCaret fa fa-chevron-down"></i></a>
					   <div class="MyFunction">
					        <div class="MyfavoritesMin"><a href="<?php echo $wishlist; ?>" id="wishlist-total" title="<?php echo $text_wishlist; ?>"><i class="fa fa-heart" style="top: 1px;position: relative"></i> &nbspFavorites</a></div>
							<div class="MyOrderMin"><a href="<?php echo $order; ?>"><i class="fa fa-file-text-o"></i> &nbspOrder</a></div>
							<div class="MyAccountMin"><a href="<?php echo $account; ?>"><i class="glyphicon glyphicon-user"></i> &nbspAccount</a></div>
							<div class="MyLogoutMin"><a href="<?php echo $logout; ?>"><i class="fa fa-sign-out"></i> &nbspLogout</a></div>
					   </div>
				</li>
				<?php } else { ?>
				<li class="myUserMin"><a><i class="glyphicon glyphicon-user"></i></a>
					<a class="myLogin" href="<?php echo $login; ?>"><?php echo $text_login; ?></a>
					<span class="familyLi">or</span>
					<a class="myRegister" href="<?php echo $register; ?>"><?php echo $text_register; ?></a>
				</li>
				<?php } ?>
				<li class="MyCompareMin"><a href="index.php?route=product/compare" id="compare-total"><i class="glyphicon glyphicon-sort"></i>&nbsp&nbsp<?php echo $text_compare; ?></a></li>
        <?php foreach ($categories as $category) { ?>
        <?php if ($category['children']) { ?>
        <li class="dropdown dropDownMin"><a><?php echo $category['name']; ?><i class="fa fa-chevron-down caretChange"></i></a>
          <div class="dropdown-menu downMenuMin">
            <div class="dropdown-inner">
              <?php foreach (array_chunk($category['children'], ceil(count($category['children']) / $category['column'])) as $children) { ?>
              <ul class="list-unstyled">
                <?php foreach ($children as $child) { ?>
                <li><a href="<?php echo $child['href']; ?>"><?php echo $child['name']; ?></a></li>
                <?php } ?>
              </ul>
              <?php } ?>
            </div>
            <a href="<?php echo $category['href']; ?>" class="see-all"><?php echo $text_all; ?> <?php echo $category['name']; ?></a> </div>
        </li>
        <?php } else { ?>
        <li><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a></li>
        <?php } ?>
        <?php } ?>
      </ul>
    </div>
  </nav>
</div>
<?php } ?>