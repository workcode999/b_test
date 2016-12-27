$(function(){	

	/*头部 currency货币的 hover效果 */

	//显示函数
	Lishow = function(){		
		$('nav #currency-none .list-unstyled').show();	
		$('nav #currency-none h5 i').attr('class','fa fa-angle-up');	
		$('nav #currency-none h5').css('color','#f76790');
	}	
	//隐藏函数			
	Lihide = function(){
		$('nav #currency-none .list-unstyled').hide();	
		$('nav #currency-none h5 i').attr('class','fa fa-angle-down');
		$('nav #currency-none h5').css('color','#555');
	}
	
	var timer = null;			
	$('nav #currency-none h5').mouseover(function(){						
		Lishow();					
	});		

	$('nav #currency-none h5').mouseout(function(){						
		Lihide();					
	});	

	$('nav #currency-none h5 i').mouseover(function(){			
		clearTimeout(timer);						
		Lishow();					
	});		

	$('nav #currency-none .list-unstyled').mouseover(function(){			
		clearTimeout(timer);						
		Lishow();					
	});		

	$('nav #currency-none .list-unstyled').mouseout(function(){					
		Lihide();					
	});	


	$('.myUserMax').hover(function(){
		$(this).find('i').eq(1).attr('class','fa fa-angle-up');
	},function(){
		$(this).find('i').eq(1).attr('class','fa fa-angle-down');
	});

	/*手机端 菜单按钮的下拉事件 */
	$('.userToggle').click(function(){
		$('.MyFunction').slideToggle(100);
		$('.userCaret').toggleClass('fa-angle-up');
	})			
	$('.dropDownMin').click(function(){
	    $(this).find('.downMenuMin').slideToggle(200);
	    if($(this).find('i').hasClass('fa-angle-down')){
	    	$(this).find('i').removeClass('fa-angle-down');
	    	$(this).find('i').addClass('fa-angle-up');
	    }else{
	    	$(this).find('i').removeClass('fa-angle-up');
	    	$(this).find('i').addClass('fa-angle-down');
	    }
	})


	/*屏幕小于或等于 992 的时候，footer栏内容的下拉效果*/
	var Owidth = $(window).width();
	if (Owidth <= 992){
		var Ofh5 = $('footer h5');
		$('footer h5').click(function(){
			$(this).next('.list-unstyled').slideToggle(300);
			if($(this).find('i').hasClass('fa-angle-down')){
				$(this).find('i').removeClass('fa-angle-down');
				$(this).find('i').addClass('fa-angle-up');
			}else{
				$(this).find('i').removeClass('fa-angle-up');
				$(this).find('i').addClass('fa-angle-down');
			}
			
		})
	};
	
	/* 屏幕小于 768 的时候，点击翻页按钮时，显示加载gif图片,增加蒙层效果*/
	if (Owidth < 768){
	$('.pagination li').click(function(){
		if($(this).hasClass('active')){
			$('.jiaziagif').css('display','none');
		}else{
			$('.jiaziagif').css('display','block');
			$('body').append('<div class="mengCeng"></div>');
		}	
	})
	}

	/*产品页面选一种衣服颜色，增加一个有“对号”的小图片 */
	$('.price .pds-current img').after('<img class="rightsx" src="catalog/view/javascript/bootstrap/image/rightsx.png" alt="right" />');
	
	/* 在导航栏添加 Home 图标*/
	//$('.navbar-collapse').prepend('<div class="navHome"><a href="index.php?route=common/home"><i class="glyphicon glyphicon-home"></i></></div>');

	/*移除面包屑的第一个 li 标签中的 i 标签 ，并在 a 标签中添加 文本*/
	//$('ul.breadcrumb li:first-child i').remove();
	//$('ul.breadcrumb li:first-child a').append('Home');
	
	/* 获取当前页面的路径*/
	//var sUrl = window.location.href;
	//如果路径是 搜索页面，将 input 里的 value 值打印到新创建的标签中, seo 优化作用
	/*if(sUrl.indexOf('index.php?route=product/search')!=-1){
		var value = $('#search input.form-control').val();
		$('ul.breadcrumb').append('<li><a class="liResult"></a></li>');
		$('.liResult').html(value);
		$('ul.breadcrumb').after('<div class="searchResult1 text-center"></div>');
		$('.searchResult1').html('<h2>'+value+'</h2>');
		$('.searchResult2').append('<strong>'+value+'</strong> !');
	}*/
		
	/*产品页 尺码表的切换效果*/	
	function buttonOn(btn1,btn2){
		$(btn1).addClass('tabActive');
		$(btn1).click(function(){
			$(this).addClass('tabActive');
			$(btn2).removeClass('tabActive');
			$('.tabTwo').css('display','none');
			$('.tabOne').css('display','block');
		});
		$(btn2).click(function(){
			$(this).addClass('tabActive');
			$(btn1).removeClass('tabActive');
			$('.tabOne').css('display','none');
			$('.tabTwo').css('display','block');
		
		});			
	}
	var onBtn1= $('.onBtn1');
	var onBtn2= $('.onBtn2');
	buttonOn(onBtn1,onBtn2);
	
	var onBtn7= $('.onBtn7');
	var onBtn8= $('.onBtn8');
	buttonOn(onBtn7,onBtn8);				
	
	var onBtn3= $('.onBtn3');
	var onBtn4= $('.onBtn4');
	buttonOn(onBtn3,onBtn4);				
	
	/*尺码表的 hover 事件*/
	function tabHover(tabClass1,tabClass2){
		$(tabClass1).hover(function(){
			$(this).css('background','#ff6e94');
			$(this).parent().children().first().css('background','#ff6e94');
			$(tabClass2).eq($(this).index()).css('background','#ff6e94');
		},function(){
			$(this).parent().children().first().css('background','');
			$(this).css('background','');
			$(tabClass2).eq($(this).index()).css('background','');
		});
	}
	var tabTd = $('.tabOne td');
	var tabTh = $('.tabTh');
	tabHover(tabTd,tabTh);
		
	var tabTd2 = $('.tabTwo td');
	var tabTh2 = $('.tabTh2');		
	tabHover(tabTd2,tabTh2);
	
	var tabTh3 = $('.tabTh3');		
	tabHover(tabTd,tabTh3);		

	var tabTh4 = $('.tabTh4');		
	tabHover(tabTd2,tabTh4);					
	
	var tabTh7 = $('.tabTh7');		
	tabHover(tabTd,tabTh7);			

	var tabTh8 = $('.tabTh8');		
	tabHover(tabTd2,tabTh8);	
				
	/*ship in 24 hours-去掉属性*/
	// var path_url = window.location.href;
	// if(path_url == 'http://www.bjsbridal.com/ship-in-24-hours'){
	// 	$("#column-left").css("display","none");
	// 	$("#content").css("width","100%");
	// }

    /* 当鼠标触发hover事件的时候，将产品图片更换成为背面图片*/
	// if(Owidth > 992){
	// 	$('.imageHover img').hover(function(){
	// 		var oldSrc = $(this).attr('src');
	// 		if(oldSrc.indexOf('front-240x369')!=-1){
	// 			var oldSrc1 = oldSrc.replace(/front-240x369/, "back-325x500");
	// 		}
	// 		else if(oldSrc.indexOf('a-240x369')!=-1){
	// 			var oldSrc1 = oldSrc.replace(/a-240x369/, "b-325x500");
	// 		}
	// 		$(this).attr('src',oldSrc1);
	// 	});
	// 	$('.imageHover img').mouseout(function(){
	// 		var oldSrc = $(this).attr('src');
	// 		if(oldSrc.indexOf('back-325x500')!=-1){
	// 			var oldSrc1 = oldSrc.replace(/back-325x500/, "front-240x369");
	// 		}
	// 		else if(oldSrc.indexOf('b-325x500')!=-1){
	// 			var oldSrc1 = oldSrc.replace(/b-325x500/, "a-240x369");
	// 		}							
	// 		$(this).attr('src',oldSrc1);
	// 	})		
	// }
	//星级评价
	$('.evaluate span').click(function(){
		$(this).addClass('review_color');
		$(this).prevAll().addClass('review_color');
		$(this).nextAll().removeClass('review_color');
		$(this).find('i').attr('class','fa fa-star fa-stack-2x');
		$(this).prevAll().find('i').attr('class','fa fa-star fa-stack-2x');		
		$(this).nextAll().find('i').attr('class','fa fa-star-o fa-stack-2x');
	});



	var value = $('#input-quantity').val();
	$('.myPlus').click(function(){
		$('.myMinus').attr('disabled',false);
		value++;
		$('#input-quantity').val(value);
	});
	$('.myMinus').click(function(){
		if(value<=1){
			$('.myMinus').attr('disabled',true);
			value = 1;
			$('#input-quantity').val(value);	
		}else{
			value--;
			$('#input-quantity').val(value);			
		}

	})



	$('.cart-max').click(function(){
		var value = $(this).prev().val();
		value++;
		$(this).prev().val(value);
	});
	$('.cart-min').click(function(){
		var value = $(this).next().val();
		if(value<=1){
			value = 1;
			$(this).next().val(value);	
		}else{
			value--;
			$(this).next().val(value);			
		}

	})	


	$('#menu .navbar-toggle').click(function(){
		var Left = $("#menu .navbar-collapse").css("left");
		if(Left.indexOf('0px') != 0){
			$('#menu .navbar-collapse').animate({left:'0'});
			$('#menu').parent().next().hide();

		}else{
			$('#menu .navbar-collapse').animate({left:'-100%'});
			$('#menu').parent().next().show();
		}
	})
	
	
	// $('.filterNone input[name^=\'filter\']:checked').parents('.filterNone').show().prev().children().toggleClass('fa-angle-up');
	// $('.filterName').click(function(){
	// 	$(this).children().toggleClass('fa-angle-up');
	// 	$(this).next().slideToggle(200);
	// });
	// if(Owidth>767){
	// 	$('.filterNone label').click(function(){
	// 		$('.refineBy #button-filter').trigger('click');
	// 	})		
	// }else{
	// 	$('.refineBy').parents('body').css('overflow-x','hidden');
	// 	$('.refineBy').parent().removeClass('col-sm-3 hidden-xs');
	// 	$('.myFilter').click(function(){
	// 		$('.refineBy').animate({left:'0'});
	// 	})
	// 	$('.filterBack').click(function(){
	// 		$('.refineBy').animate({left:'100%'});
	// 	})		
	// }
	


	var trem = document.getElementsByClassName('filtertrem');
	for(var i=0;i<trem.length;i++){
		var trem_a = trem[i].getElementsByTagName('a'); 
		var trem_input =  trem[i].getElementsByTagName('input');
		if(trem_a.length>19){
			var oP = document.createElement('p');
			oP.innerHTML = 'More <i class="fa fa-angle-down"></i>';
			oP.className = 'filtermore';
			trem[i].appendChild(oP);
		}
		for(var a=0;a<trem_a.length;a++){
			trem_a[a].index = a;
			if(trem_a[a].index>19){
				trem_a[a].style.display = 'none';
				trem_a[a].className = 'morenone';
			}
		}
		for(var b=0;b<trem_input.length;b++){
			if(trem_input[b].checked == true){
				var lbText = $(trem_input[b]).parent().text();
				var lbVal = $(trem_input[b]).val();
				trem_input[b].className = 'addinput' + lbVal;
				$('.addP').append('<p class="addinput' + lbVal + '">' + lbText + ' <i class="fa fa-times deltimes"></i></p>');
			}
		}
	};

	$('.addP>p').click(function(){
		var pClass = $(this).attr('class');
		var arrInput = $('.myfilter input');
		for(var k=0;k<arrInput.length;k++){
			if(arrInput.eq(k).attr('class') == pClass){
				arrInput.eq(k).attr('checked',false);
			}
		}
		$('#button-filter').trigger('click');
	});

	var onOff = true;
	$('.filtermore').click(function(){
		if(onOff){
			$(this).html('Less <i class="fa fa-angle-up"></i>');
			onOff = false;
		}
		else{
			$(this).html('More <i class="fa fa-angle-down"></i>');
			onOff = true;
		}
		$(this).siblings('.morenone').toggle();
	});

	if(Owidth>767){
		var filterDiv = $('.filterdiv');	
		for(var i=0;i<filterDiv.length;i++){
			filterDiv[i].index = i;
			if(filterDiv[i].index>4){
				filterDiv[i].className += ' ' + 'filterDivNone';
			}
		}
	}

	$('.ClearAlla').click(function(){
		$('#button-filter').trigger('click');
	})

	if(Owidth>767){
		$('.filtertrem label').click(function(){
			$('#button-filter').trigger('click');
		})		
	}else{
		$('.myfilter').parents('.category-row').css('overflow-x','hidden');
		$('.myfilter').parent().removeClass('col-sm-3 hidden-xs');

		$('.onfilter').click(function(){
			$('.logoSearch .col-sm-8').css('display','none');
			$('.category-row #column-left').animate({left:'0'},300);
		})
		$('.filterBack').click(function(){
			$('.logoSearch .col-sm-8').css('display','block');
			$('.category-row #column-left').animate({left:'100%'},300);
		})			
	}	
		$('.filterdiv .filtertrem').css('display','none')
		$('.filterdiv .filtername').click(function(){
			if($(this).children('i').hasClass('fa-angle-down')){
				$(this).children('i').removeClass('fa-angle-down');
				$(this).children('i').addClass('fa-angle-up');
			}else{
				$(this).children('i').removeClass('fa-angle-up');
				$(this).children('i').addClass('fa-angle-down');				
			}
			$(this).next().toggle();
		})
		$('.filtertrem input[name^=\'filter\']:checked').parents('.filtertrem').show().prev().children('i').attr('class','fa fa-angle-up');
	

		/*$('.tremradio a').click(function(){
			$(this).addClass('aa');
		})*/
		var sortUrl = location.href;
		if(sortUrl.indexOf('price&order=ASC') != -1){
			$('#input-sort .sortspan3').addClass('sortActive').children().attr('class','fa fa-long-arrow-up');

		}else if(sortUrl.indexOf('price&order=DESC') != -1){
			$('#input-sort .sortspan3').addClass('sortActive').children().attr('class','fa fa-long-arrow-down');				
		}else if(sortUrl.indexOf('viewed&order=ASC') != -1){
			$('#input-sort .sortspan2').addClass('sortActive').children().attr('class','fa fa-long-arrow-up');
		}else if(sortUrl.indexOf('viewed&order=DESC') != -1){
			$('#input-sort .sortspan2').addClass('sortActive').children().attr('class','fa fa-long-arrow-down');
		}else{
			$('#input-sort .sortspan1').addClass('sortActive');
		}
		// var sortOnOff = true;
		// $('#input-sort .sortspan3').click(function(){
		// 	if(sortOnOff){
		// 		$(this).children().attr('class','fa fa-long-arrow-up');
		// 	}else{
		// 		$(this).children().attr('class','fa fa-long-arrow-down');
		// 	}
		// 	sortOnOff = !sortOnOff;
		// })
	
});


	