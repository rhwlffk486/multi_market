<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&display=swap" rel="stylesheet">

<script type="text/javascript" src="/resources/jquery-3.6.0.min.js"></script>

<link rel="stylesheet" href="/resources/css/template/main.css">
</head>
<script type="text/javascript">
$(function(){
	var today = new Date();   

	var year = today.getFullYear(); // 년도
	var month = today.getMonth() + 1;  // 월
	var date = today.getDate();  // 날짜
	
	var day = (year+"/" + month+"/" + date);
		
	$.ajax({
		  url : "/shopping/todayProduct"
		, type : "post"
		, dataType : "json"
		, data : {
			day : day
		}
		, success: function(result){
					console.log(result);
			var html1 = "";
			var html2 = "";
			if (result.length > 0) {
				for (i=0; i<result.length; i++) {
					if (result[i].role == '기업') {
						var price1 = result[i].productPrice;
						var price = price1.format();
						html1 += "<div class='product_column'>"
						html1 += "<a href='/shopping/productView?n=" + result[i].productNum+ "'class='product_img'>";
						html1 += "<img alt='img' src='"+ result[i].productImg +"' >";
						html1 += "<div class='product_content'>";
	 					html1 += "<h4 class='product_h4'>"+ result[i].productTitle + "</h4>";
	 					html1 += "<p class='product_p'>";	
	 				 	html1 += "<strong class='product_st'>" + price + "</strong>원";
	 					html1 += "</p>";
	 					html1 += "</div>";
	 					html1 += "</a>";
	 					html1 += "</div>"
					} else {
						var price1 = result[i].productPrice;
						var price = price1.format();
 						html2 += "<div class='product_column'>"
						html2 += "<a href='/shopping/productView?n=" + result[i].productNum+ "'class='product_img'>";
						html2 += "<img alt='img' src='"+ result[i].productImg +"' >";
						html2 += "<div class='product_content'>";
						html2 += result[i].role;
	 					html2 += "<h4 class='product_h4'>"+ result[i].productTitle + "</h4>";
	 					html2 += "<p class='product_p'>";	
	 					html2 += "<strong class='product_st'>" + price + "</strong>원";
	 					html2 += "</p>";
	 					html2 += "</div>";
	 					html2 += "</a>";
	 					html2 += "</div>"
					}
				}
				
			}
 					$("#product_CP1").html(html1);
					$("#product_CP2").html(html2);
 					
		}
	});
	
	console.log(${todayProduct});
});

//숫자형식에 대한 추가
Number.prototype.format = function(){
    if(this==0) return 0;
    var reg = /(^[+-]?\d+)(\d{3})/;
    var n = (this + '');
    while (reg.test(n)) n = n.replace(reg, '$1' + ',' + '$2');
    return n;
};

//문자에 대한 기능 추가
String.prototype.format = function(){
    var num = parseFloat(this);
    if( isNaN(num) ) return "0"; 
    return num.format();
};
</script>
<body>

	<div id="homepage-slider" class="st-slider">

    <input type="radio" class="cs_anchor radio" name="slider" id="slide1"/>
    <input type="radio" class="cs_anchor radio" name="slider" id="slide2"/>
    <input type="radio" class="cs_anchor radio" name="slider" id="slide3"/>
    <input type="radio" class="cs_anchor radio" name="slider" id="play1" checked=""/>
    <div class="images">
		<div class="images-inner">
			<div class="image-slide">
				<div class="image bg-yellow" style="background-color:#eee6c4;">
					<div class="com_new"><p class="p_top">새로들어온 제품</p></div>
					<div id="product_CP1"></div>
				</div>
			</div>
			<div class="image-slide">
				<div class="image bg-blue" style="background-color:#98937e;">
					<div class="com_new"><p class="p_top">새로들어온 중고 제품</p></div>
				  	<div id="product_CP2"></div>
				</div>
			</div>
			<div class="image-slide">
				<div class="image bg-red" style="background-color:#4a483e;">
					
				</div>
			</div>
		</div>
	</div>
    <div class="labels">
      
        <div class="fake-radio">
          <label for="slide1" class="radio-btn"></label>
          <label for="slide2" class="radio-btn"></label>
          <label for="slide3" class="radio-btn"></label>
        </div>
    </div>
</div>
  	<div id="test"></div>
</body>
</html>