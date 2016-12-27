<footer>
  <div class="container">
    <div class="row">
      <?php if ($informations) { ?>
	  <?php echo $currency;?>
      <div class="col-sm-3">
        <h5><?php echo $text_information; ?><i class="fa fa-angle-down footerIcon"></i></h5>
        <ul class="list-unstyled">
          <?php foreach ($informations as $information) { ?>
          <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
          <?php } ?>
		  <li><a href="<?php echo $sitemap; ?>"><?php echo $text_sitemap; ?></a></li>
        </ul>
      </div>
      <?php } ?>
      <div class="col-sm-3">
        <h5><?php echo $text_service; ?><i class="fa fa-angle-down footerIcon"></i></h5>
        <ul class="list-unstyled">
			<li><a href="<?php echo HTTP_SERVER . 'contact-us.html'; ?>">Contact Us</a></li>
			<li><a href="<?php echo HTTPS_SERVER . 'index.php?route=account/guest'; ?>">Track Your Order</a></li>
			<li><a href="<?php echo HTTP_SERVER . 'faqs.html'; ?>">FAQs</a></li>
			<li><a href="<?php echo $return; ?>"><?php echo $text_return; ?></a></li>
        </ul>
      </div>
      <div class="col-sm-3">
		<h5>Payment & Shipping<i class="fa fa-angle-down footerIcon"></i></h5>
		<ul class="list-unstyled">		
			<li><a href="<?php echo HTTP_SERVER . 'accepted-payment-methods.html'; ?>">Payment Methods</a></li>
			<li><a href="<?php echo HTTP_SERVER . 'shipping-methods-guide.html'; ?>">Shipping Methods Guide</a></li> 
			<li><a href="<?php echo HTTP_SERVER . 'locations-we-ship-to.html'; ?>">Locations We Ship To</a></li>
			<li><a href="<?php echo HTTP_SERVER . 'estimated-delivery-time.html'; ?>">Estimated Delivery Time</a></li>
        </ul>
      </div>
      <div class="col-sm-3">
		<h5>Company Policies<i class="fa fa-angle-down footerIcon"></i></h5>
		<ul class="list-unstyled">
			<li><a href="<?php echo HTTP_SERVER . 'return-policy.html'; ?>">Return Policy</a></li>
			<li><a href="<?php echo HTTP_SERVER . 'cancellation-policy.html'; ?>">Cancellation Policy</a></li>
			<li><a href="<?php echo HTTP_SERVER . 'privacy-policy.html'; ?>">Privacy Policy</a></li>
			<li><a href="<?php echo HTTP_SERVER . 'terms-of-use.html'; ?>">Terms of Use</a></li>
			<li><a href="<?php echo HTTP_SERVER . 'terms-of-use.html#intellectual_property_infringement_policy'; ?>">Intellectual Property Infringement Policy</a></li>
        </ul>
      </div>
    </div>
	<p>Copyright &copy <?php echo date('Y') ?> BJSBRIDAL.com All rights reserved.</p>
    <hr>
  </div>
  <div class="jiaziagif"><img src="catalog/view/javascript/bootstrap/image/jiazai.gif"></div>
</footer>
<?php if (isset($google_remarketing_code))
{
	echo $google_remarketing_code;
} ?>
<style type="text/css">
	#ToTopHover {background: url(http://www.bjsbridal.com/image/data/totop.png) no-repeat left -51px;width: 51px;height: 51px;display: block;overflow: hidden;float: left;opacity: 0;-moz-opacity: 0;filter: alpha(opacity=0);}
	#ToTop {z-index: 9999;display: none;text-decoration: none;position: fixed;bottom: 50px;right: 0px;overflow: hidden;width: 51px;height: 51px;border: none;text-indent: -999px;background: url(http://www.bjsbridal.com/image/data/totop.png) no-repeat left top;}
	@media (min-width: 1200px) {
		#ToTop {
			right: 110px;
		}
	}
</style>
<script type="text/javascript">
/* UItoTop jQuery */
jQuery(document).ready(function(){$().UItoTop({easingType:'easeOutQuint'});});
(function($){
	$.fn.UItoTop = function(options) {
		var defaults = {
			text: 'To Top',
			min: 200,
			inDelay:600,
			outDelay:400,
			containerID: 'ToTop',
			containerHoverID: 'ToTopHover',
			scrollSpeed: 200,
			easingType: 'linear'
		};
		var settings = $.extend(defaults, options);
		var containerIDhash = '#' + settings.containerID;
		var containerHoverIDHash = '#'+settings.containerHoverID;
		$('body').append('<a href="#" id="'+settings.containerID+'">'+settings.text+'</a>');
		$(containerIDhash).hide().click(function(event){
			$('html, body').animate({scrollTop: 0}, settings.scrollSpeed);
			event.preventDefault();
		})
		.prepend('<span id="'+settings.containerHoverID+'"></span>')
		.hover(function() {
				$(containerHoverIDHash, this).stop().animate({
					'opacity': 1
				}, 600, 'linear');
			}, function() { 
				$(containerHoverIDHash, this).stop().animate({
					'opacity': 0
				}, 700, 'linear');
			});			
		$(window).scroll(function() {
			var sd = $(window).scrollTop();
			if(typeof document.body.style.maxHeight === "undefined") {
				$(containerIDhash).css({
					'position': 'absolute',
					'top': $(window).scrollTop() + $(window).height() - 50
				});
			}
			if ( sd > settings.min ) 
				$(containerIDhash).fadeIn(settings.inDelay);
			else 
				$(containerIDhash).fadeOut(settings.Outdelay);
		});
};
})(jQuery);
</script>
</body></html>
<!--<script language="javascript" src="http://lkt.zoosnet.net/JS/LsJS.aspx?siteid=LKT18977481&lng=en"></script>-->
<script language="javascript">
if(typeof(LiveReceptionCode_isonline)!='undefined'  && LR_GetObj('LR_User_TextLink0')!=null)
{
	if(LiveReceptionCode_isonline)
		LR_GetObj('LR_User_TextLink0').innerHTML='<a '+LiveReceptionCode_BuildChatWin('Live Support','Live Support')+' class="fa fa-info-circle"><span class="live-change"> Live Support</span></a>';
	else
		LR_GetObj('LR_User_TextLink0').innerHTML='<a '+LiveReceptionCode_BuildChatWin('Live Support','Leave Message')+' class="fa fa-info-circle"><span class="live-change"> Leave Message</span></a>';
}
</script>