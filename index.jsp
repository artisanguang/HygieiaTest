<%@page import="org.dom4j.VisitorSupport"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.bpm.framework.console.Application"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="renderer" content="webkit" />
		<meta http-equiv=X-UA-Compatible content="IE=edge,chrome=1" />
		<title>催收宝—让催收更简单,一站式SaaS云催收平台</title>
		<meta name="keywords" content="催收系统,催收管理系统,催收平台,催收,催收公司,催收机构,不良资产处置,催收软件," />
		<meta name="description" content="催收宝是国内首家SaaS云催收管理平台，系统涵盖电话催收、信函催收、短信催收、等多种催收作业功能，可设置自动催收方案，无人值守短信催收、灵活可配坐席催收。专业用于各种不良资产处置，债权债务处理，成功入驻即可实现催收操作免安装、零部署、费用低。" />
		<meta name="copyright" content="(C) 2009-2017 cuisb.com 版权所有 深圳市长亮科技股份有限公司" />
		<%-- <%@include file="/app/common/link.jsp"%> --%>
		<link rel="shortcut icon" href="/fw2.0/resources/images/logo-til.png" />
		<link rel="stylesheet" href="/resources/css/new_index.css" />
		<link rel="stylesheet" href="/resources/css/animate.css" />
		<link rel="stylesheet" href="/fw2.0/resources/css/webindex/messagebox.css" />
		<link rel="stylesheet" href="/resources/css/xcConfirm.css" />
		<script type="text/javascript" src="/resources/js/plugins/jquery/jquery-1.8.3.min.js" ></script>
		<script type="text/javascript" src="/resources/js/common.js" ></script>	
		<script type="text/javascript" src="/resources/js/xcConfirm.js" ></script>
		<script type="text/javascript" src="/resources/js/jquery.msgbox.js" ></script>
		<script type="text/javascript" src="/resources/js/banner.js" ></script>
		
		<script type="text/javascript">
		$(function() {
		    var isshow = '${param.showLogin}';
		    if(isshow){
		        add_start();
		    }
			  //判断是否在iframe中 
			  if(window != top) {
			  	top.location.href = window.location.href;
			  }
		     //（1）banner图数据加载
			 $.ajax({
				type: "POST",
				url: "/cuiBannerController/queryIndexBanner",
				data: {
					position:"home",
					terminal:"PC"
				},
				success: function(data){
					var banner_htm_ = "";
					var count = 0;
					if(data==null || data=="" || data.length==0){
						var banner_htm_ ='<dd>'
							+'<img draggable="false" class="banner-img" src="/fw2.0/resources/images/webindex/banner4.jpg" />'
							+'</dd>';
						count = 1;
					}else{
						$.each(data,function(i,item){
							var href_ = (item.href==null || item.href==''?'javascript:void(0)':item.href);
							var item_htm_ = '';
							if(item.href==null || item.href=='') {
								item_htm_ ='<dd>'
									+'<img draggable="false" class="banner-img" src="'+item.icon+'"/>'
									+'</dd>';
							} else {
								item_htm_ ='<dd>'
									+'<a href='+href_+'  target='+item.openType+'>'
									+'<img draggable="false" class="banner-img" src="'+item.icon+'"/></a>'
									+'</dd>';
							}
							banner_htm_ += item_htm_;
							count ++;
 						})
					}
					$("#swiper_banner_div").html(banner_htm_);
					//动态加载完banner图后需要调用swiper重新渲染
					/* if(count>1){
						var mySwiper = new Swiper('.swiper-container', {
							autoplay: 3000, //可选选项，自动滑动
							loop: true,
							pagination: '.swiper-pagination',
							autoplayDisableOnInteraction: false,
							paginationClickable: true,
							simulateTouch: false,
						});
					} */
				}
			});
		     
			 $.ajax({
					type: "POST",
					url: "/sysCodeController/get-WEBSITE/serviceEmail",
					success: function(data){
						$("#contactEmail").attr("href", "mailto:" + data.value);
					}
				});
		     
			//（2）合作伙伴数据加载
			 $.ajax({
					type: "POST",
					url: "/cuiCooperativePartnerController/queryIndexCooperative",
					data: {
						pageSize:10
					},
					success: function(data){
						var cooperative_htm_ = "";
						if(data==null || data=="" || data.length==0){
							$("#cooperative_list_ul").parent().parent().parent().css("display","none");
							return;
						}else{
							$.each(data,function(i,item){
								var href_ = (item.href==null || item.href==''?'javascript:void(0)':item.href);
								cooperative_htm_ +='<li><a href='+href_+' target="_blank"><img src="'+item.icon+'" title='+item.name+'></a></li>';
	 						})
	 						if(data.length%5!=0){
	 							for(var j = data.length%5;j<5;j++){
	 								cooperative_htm_ +='<li class="customer_no"><a href="javascript:void(0);">招商中</a></li>';
	 							}
	 						}
	 						$("#cooperative_list_ul").html(cooperative_htm_);
						}
					}
				});
			
				//问题反馈弹框
				viewFeedback = function() {
					$.msgbox({
						height:580,
						width:590,
						content:'/fwFeedbackController/addEntity.htm',
						type :'iframe',
						title: '问题反馈',
						
					});
					$('body').css({overflow:'hidden'});
					$('.v2_msgbox_main').css({overflow:'hidden'});
				}
				
				pageScroll=function() {
			        $("html,body").animate({scrollTop:0}, 500);
			    }; 
		});
		
		</script>
	</head>
	<body>
	<div id="invest_window_box" style="display: none;">
		<div class="invest_window_bg"></div>
		<div class="invest_window">
			<div class="invest_close"></div>
			<div class="prompt">
				<div class="prompt_top"></div>
				<div class="prompt_center">
					<h1>建议升级浏览器，浏览器升级下载！</h1>
					<div class="v2_but_list">
						<a class="bg_l" href="http://www.googlechromer.cn/">谷歌 chrome</a>
						<a class="bg_l" href="http://www.firefox.com.cn/download/">火狐 Firefox</a>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- top -->	
	<div class="new_banner ">
	    <%@include file="/app/common/top.jsp"%>
	    <div class="banner_box">
			<div id="banner" class="bannerSlider">
				<dl class="slider-content" id='swiper_banner_div'>
					<!-- <dd><a href="#"><img src="images/banner_map.gif"></a></dd>
					<dd><a href="#"><img src="images/banner_02.jpg"></a></dd>
					<dd><a href="#"><img src="images/banner_03.jpg"></a></dd> -->
				</dl>
				<a href="javascript:;" class="prev" id="bannerLeftBtn"><i></i></a>
				<a href="javascript:;" class="next" id="bannerRightBtn"><i></i></a>
				<div class="slider-ctrl">
					<div id="btn" class="ctrl-dot"></div>
				</div>
			</div>
		</div>
	</div>	
	<div class="new_about new_margin  animated bounceDown1" style="visibility: visible; animation-name: bounceDown1;">
	<div class="new_about_left">
		<h1>关于催收宝</h1>
		<p>About cuisb.com</p>
		<div class="new_about_left_ico">
			<a id="contactEmail" href="mailto:cuisb@sunline.cn">
				<div class="new_about_ico" ontouchstart="this.classList.toggle('hover');">
					<div class="new_a_default about_1"></div>
					<div class="new_a_back about_1h"></div>
				</div>
			</a>
			<a href="http://p.qiao.baidu.com/im/index?siteid=7601972&ucid=7110060&cp=&cr=&cw=" target="_blank">
				<div class="new_about_ico" ontouchstart="this.classList.toggle('hover');">
					<div class="new_a_default about_2"></div>
					<div class="new_a_back about_2h"></div>
				</div>
			</a>
		</div>
	</div>
	<div class="new_about_right">
		<h1>领先的属地化催收平台</h1>
		<p>-</p>
		<p>公司拥有全国1500家区域催收合作机构，覆盖294个地级市，能以最快的速度分发不良资产案件到指定区域，大大提升回款率，以高科技+大数据开启互联网催收3.0时代。</p>
		<div class="new_about_left_ico">
			<a>
				<div class="new_about_ico" ontouchstart="this.classList.toggle('hover');">
					<div class="new_a_default about_more_ico"></div>
					<div class="new_a_back about_more_icoh"></div>
				</div>
			</a>
		</div>
	</div>
</div>
<div class="new_tittle_box animated bounceDown1" style="visibility: visible; animation-name: bounceDown1;">
	<div class="new_tittle">服务对象</div>
</div>
<div class="new_service new_margin">
	<h1>委托方<span>案件即时分配到欠款人最近地区，高效回款。</span></h1>
	<div class="new_entrust">
		<ul>
			<li>
				<div class="new_entrust_list">
					<div class="new_flip-container" ontouchstart="this.classList.toggle('hover');">
						<div class="new_flipper">
							<div class="new_default v1"></div>
							<div class="new_back v1h"></div>
						</div>
					</div>
					<h2><span>信用卡</span>不良处置</h2>
					<p>针对信用卡案件，提供银行级信息安全保障，专人‘定时’流程透明，管控严格。</p>
				</div>
			</li>
			<li>
				<div class="new_entrust_list">
					<div class="new_flip-container" ontouchstart="this.classList.toggle('hover');">
						<div class="new_flipper">
							<div class="new_default v2"></div>
							<div class="new_back v2h"></div>
						</div>
					</div>
					<h2><span>消费金融</span>不良处置</h2>
					<p>针对消费金融案件，因资金方和商家通常为不同机构且商家缺乏催收经验，采取打包委托方案。</p>
				</div>
			</li>
			<li>
				<div class="new_entrust_list">
					<div class="new_flip-container" ontouchstart="this.classList.toggle('hover');">
						<div class="new_flipper">
							<div class="new_default v3"></div>
							<div class="new_back v3h"></div>
						</div>
					</div>
					<h2><span>小额信贷</span>不良处置</h2>
					<p>针对小额信贷案件，金额较高，风险较大，提供以电催为主，外访为辅，同时配合司法介入。</p>
				</div>
			</li>
			<li>
				<div class="new_entrust_list">
					<div class="new_flip-container" ontouchstart="this.classList.toggle('hover');">
						<div class="new_flipper">
							<div class="new_default v4"></div>
							<div class="new_back v4h"></div>
						</div>
					</div>
					<h2><span>资产抵押</span>不良处置</h2>
					<p>针对资产抵押案件，主要以人工电话施压，必要时可采取资产处置措施，抵押物变现降低损失。</p>
				</div>
			</li>
			<li>
				<div class="new_entrust_list">
					<div class="new_flip-container" ontouchstart="this.classList.toggle('hover');">
						<div class="new_flipper">
							<div class="new_default v5"></div>
							<div class="new_back v5h"></div>
						</div>
					</div>
					<h2><span>线上小贷</span>不良处置</h2>
					<p>针对线上小贷案件，采用智能还款提醒，配合人工电话施压，防止逾期升级。</p>
				</div>
			</li>
			<li>
				<div class="new_entrust_list">
					<div class="new_flip-container" ontouchstart="this.classList.toggle('hover');">
						<div class="new_flipper">
							<div class="new_default v6"></div>
							<div class="new_back v6h"></div>
						</div>
					</div>
					<h2><span>汽车金融</span>不良处置</h2>
					<p>针对车贷行业不良资产处置，资源灵活调配、属地化派单、致力找回抵押车辆，降低风险。</p>
				</div>
			</li>
		</ul>
	</div>
</div>

<div class="new_service new_margin animated bounceDown1" style="visibility: visible; animation-name: bounceDown1;">
	<h1>处置方<span>招募区域代理人，全国派单 属地化匹配 无押金 无定金。</span></h1>
	<div class="new_disposition">
		<ul>
			<li><img src="/resources/images/sass_pic.png"/></li>
			<li><img src="/resources/images/data_pic.png"/></li>
		</ul>
	</div>
</div>
<div class="advantage_bg">
	<div class="new_advantage">
	<h1>我们的优势</h1>
		<ul>
			<li>
				<div class="new_advantage_list">
					<div class="advantage_ico"><img src="/resources/images/advantage_ico_01.png"/></div>
					<h2>属地化服务</h2>
					<p>覆盖全国294个地级市代理，智能高效对接</p>
				</div>
			</li>
			<li>
				<div class="new_advantage_list">
					<div class="advantage_ico"><img src="/resources/images/advantage_ico_02.png"/></div>
					<h2>海量委外资源</h2>
					<p>大量银行金融公司中短期案件分发</p>
				</div>
			</li>
			<li>
				<div class="new_advantage_list">
					<div class="advantage_ico"><img src="/resources/images/advantage_ico_03.png"/></div>
					<h2>高效结佣</h2>
					<p>流程透明，安全快捷互惠共赢</p>
				</div>
			</li>
			<li>
				<div class="new_advantage_list">
					<div class="advantage_ico"><img src="/resources/images/advantage_ico_04.png"/></div>
					<h2>大数据追踪</h2>
					<p>大数据+云计算追诉失联人员，让案件有迹可循</p>
				</div>
			</li>
			<li>
				<div class="new_advantage_list">
					<div class="advantage_ico"><img src="/resources/images/advantage_ico_05.png"/></div>
					<h2>双重审核</h2>
					<p>平台直接对接甲乙双方，完成双重审核</p>
				</div>
			</li>
		</ul>
	</div>
</div>

<div class="new_tittle_box animated bounceDown1" style="visibility: visible; animation-name: bounceDown1;">
	<div class="new_tittle">热门推荐</div>
</div>
<div class="new_product animated bounceDown1" style="visibility: visible; animation-name: bounceDown1;">
	<div class="new_product_head">
		<ul>
			<li class="w200">地理位置</li>
			<li class="w200">标的类型</li>
			<li class="w200">标的金额</li>
			<li class="w100">账龄</li>
			<li class="w100">代理费率</li>
			<li class="w200">日期</li>
			<li class="w200">状态</li>
		</ul>
	</div>
	<div class="new_product_list">
		<ul>
			<li class="w200"><div class="new_address"><span></span>广东省-广州市</div></li>
			<li class="w200">抵押贷款</li>
			<li class="w200"><span>268万</span></li>
			<li class="w100">M8</li>
			<li class="w100"><span>40%</span></li>
			<li class="w200">2018-05-26</li>
			<li class="w200"><div class="product_but move"><a onClick="phone_start();">招标中</a></div></li>
		</ul>
	</div>
	<div class="new_product_list new_product_gary">
		<ul>
			<li class="w200"><div class="new_address"><span></span>湖北省-宜昌市</div></li>
			<li class="w200">抵押贷款</li>
			<li class="w200"><span>190</span>万</li>
			<li class="w100">M3</li>
			<li class="w100"><span>20</span>%</li>
			<li class="w200">2018-05-25</li>
			<li class="w200"><div class="product_but "><a>已处置</a></div></li>
		</ul>
	</div>
	<div class="new_product_list">
		<ul>
			<li class="w200"><div class="new_address"><span></span>河北省-保定市</div></li>
			<li class="w200">抵押贷款</li>
			<li class="w200"><span>423万</span></li>
			<li class="w100">M4</li>
			<li class="w100"><span>30%</span></li>
			<li class="w200">2018-05-18</li>
			<li class="w200"><div class="product_but move"><a onClick="phone_start();">招标中</a></div></li>
		</ul>
	</div>
	
	<div class="new_product_list">
		<ul>
			<li class="w200"><div class="new_address"><span></span>上海市</div></li>
			<li class="w200">银行信用卡</li>
			<li class="w200"><span>1065万</span></li>
			<li class="w100">M12+</li>
			<li class="w100"><span>55%</span></li>
			<li class="w200">2018-05-18</li>
			<li class="w200"><div class="product_but move"><a onClick="phone_start();">招标中</a></div></li>
		</ul>
	</div>
	<div class="new_product_list new_product_gary">
		<ul>
			<li class="w200"><div class="new_address"><span></span>江苏省-宁波市</div></li>
			<li class="w200">抵押贷款</li>
			<li class="w200"><span>820</span>万</li>
			<li class="w100">M10</li>
			<li class="w100"><span>45</span>%</li>
			<li class="w200">2018-05-12</li>
			<li class="w200"><div class="product_but "><a>已处置</a></div></li>
		</ul>
	</div>
	<div class="new_product_list new_product_gary">
		<ul>
			<li class="w200"><div class="new_address"><span></span>广东省-深圳市</div></li>
			<li class="w200">银行信用卡</li>
			<li class="w200"><span>539</span>万</li>
			<li class="w100">M12</li>
			<li class="w100"><span>55</span>%</li>
			<li class="w200">2018-05-11</li>
			<li class="w200"><div class="product_but "><a>已处置</a></div></li>
		</ul>
	</div>
	
	<div class="new_product_list">
		<ul>
			<li class="w200"><div class="new_address"><span></span>湖南省-衡阳市</div></li>
			<li class="w200">企业信贷</li>
			<li class="w200"><span>3965万</span></li>
			<li class="w100">M5</li>
			<li class="w100"><span>30%</span></li>
			<li class="w200">2018-05-06</li>
			<li class="w200"><div class="product_but move"><a onClick="phone_start();">招标中</a></div></li>
		</ul>
	</div>
	<div class="new_product_list new_product_gary">
		<ul>
			<li class="w200"><div class="new_address"><span></span>北京市</div></li>
			<li class="w200">小额现金贷款</li>
			<li class="w200"><span>725</span>万</li>
			<li class="w100">M12+</li>
			<li class="w100"><span>60</span>%</li>
			<li class="w200">2018-04-28</li>
			<li class="w200"><div class="product_but"><a>已处置</a></div></li>
		</ul>
	</div>
	<div class="new_product_more"><a onClick="phone_start();">查看更多推荐+</a></div>
</div>
    <%@include file="/app/common/footer.jsp"%>
	<div id="phone_window_box" style="display: none;">
		<div class="phone_window_bg"></div>
		<div class="phone_window animated bounceDown1" style="visibility: visible; animation-name: bounceDown1;">
			<div class="phone_close"><a onClick="phone_close();"></a></div>
			<div class="phone_ok">
				<div class="phone_ok_ico"></div>
				<div class="phone_ok_center">
					<h1>若有合作意向，请来电咨询。</h1>
					<p>咨询电话：<span url="/sysCodeController/get-WEBSITE/contactPhone" textField="value"></span></p>
					<p>联系人：<span url="/sysCodeController/get-WEBSITE/contactName" textField="value"></span></p>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript"> var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://"); document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3F906e2ad92aed10a0115611896a9daf98' type='text/javascript'%3E%3C/script%3E")) </script>
	<script type="text/javascript">
	var index;
	var timer;
	function phone_start() {
		$('#phone_window_box').show();
		$('phone_window_bg').css({overflow:'hidden'});
		$('body').css({overflow:'hidden'});

	}
	function phone_close(){
		clearInterval(timer);
		$('#phone_window_box').hide();
		$('body').css({overflow:''});
	}
	/*banner*/
	var sl = new Sld();
        sl.init('bannerSlider', {})
        $(window).on('resize', function () {
            sl.resizeFn();
    });
	</script>
	</body>
	<%
	/** 记录访问系统首页的信息 */
	new Thread(new com.grx.cuieasy.stat.thread.VisitorStatThread(request)).start();
	%>
</html>
