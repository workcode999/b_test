<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width; initial-scale=1.0; minimum-scale=1.0; maximum-scale=1.0" />
<title>Credit/Debit Card (Visa, MasterCard) Payment - BjsBridal.com</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<script src="catalog/view/javascript/jquery/jquery-2.1.1.min.js" type="text/javascript"></script>
<link href="catalog/view/javascript/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen" />
<script src="catalog/view/javascript/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<link href="catalog/view/theme/default/stylesheet/stylesheet.css" rel="stylesheet">
</head>
<div style="position: relative;>
    <div style="background:#FFF; padding: 20px; border: #000 1px solid; width: 320px;margin:130px auto 0;" id="loading">
        <img src="catalog/view/theme/default/image/loading.gif"  /> Loading...Please do not refresh the page.
    </div>
</div>
<form action="<?php echo str_replace('&', '&amp;', $action); ?>" method="post" id="checkout_creditcard" name="checkout_creditcard">
  <input type="hidden" name="merNo" value="<?php echo $merNo; ?>" />
  <input type="hidden" name="gatewayNo" value="<?php echo $gatewayNo; ?>" />
  <input type="hidden" name="orderNo" value="<?php echo $orderNo; ?>" />
  <input type="hidden" name="orderCurrency" value="<?php echo $orderCurrency; ?>" />
  <input type="hidden" name="orderAmount" value="<?php echo $orderAmount; ?>" />
  <input type="hidden" name="returnUrl" value="<?php echo $returnUrl; ?>"/>
  <input type="hidden" name="signInfo" value="<?php echo $signInfo; ?>" />
  <input type="hidden" name="firstName" value="<?php echo $firstName; ?>" />
  <input type="hidden" name="remark" value="<?php echo $remark; ?>" />
  <input type="hidden" name="lastName" value="<?php echo $lastName; ?>" />
  <input type="hidden" name="email" value="<?php echo $email; ?>" />
  <input type="hidden" name="phone" value="<?php echo $phone; ?>" />
  <input type="hidden" name="paymentMethod" value="<?php echo $paymentMethod; ?>" />
  <input type="hidden" name="zip" value="<?php echo $zip; ?>" />
  <input type="hidden" name="city" value="<?php echo $city; ?>" />
  <input type="hidden" name="state" value="<?php echo $state; ?>" />
  <input type="hidden" name="country" value="<?php echo $country; ?>" />
  <input type="hidden" name="address" value="<?php echo $address; ?>" />
  <input type="hidden" name="interfaceInfo" value="<?php echo $interfaceInfo; ?>" />
  <input type="hidden" name="interfaceVersion" value="<?php echo $interfaceVersion; ?>" />
  <input type="hidden" name="isMobile" value="<?php echo $isMobile; ?>" />
</form>

<iframe width="100%" height="550" scrolling="no" name="ifrm_creditcard_checkout" id="ifrm_creditcard_checkout" style="border:none; margin: 0 auto; overflow:auto;"></iframe>

<script type="text/javascript">

if (window.XMLHttpRequest) {
document.checkout_creditcard.target="ifrm_creditcard_checkout";
}

document.checkout_creditcard.action="<?php echo $action;?>";
document.checkout_creditcard.submit();
window.status = "<?php echo $action;?>";
</script>
<script type="text/javascript">
    var ifrm_cc  = document.getElementById("ifrm_creditcard_checkout");
    var loading  = document.getElementById("loading");
    if (ifrm_cc.attachEvent){
        ifrm_cc.attachEvent("onload", function(){
            loading.style.display = 'none';
        });
    } else {
        ifrm_cc.onload = function(){
            loading.style.display = 'none';   		
        };
    }
</script>
