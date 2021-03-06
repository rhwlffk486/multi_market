<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="UTF-8">	
<script type="text/javascript" src="/resources/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="/resources/css/template/category.css">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap" rel="stylesheet">

<!-- summernote -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
<title>shopping</title>
<script type="text/javascript">
$(function() {
	function slideMenu() {
		var activeState = $("#header_menu_container .header_menu_list")
				.hasClass("active");
		$("#header_menu_container .header_menu_list").animate({
			left : activeState ? "0%" : "-100%"
		}, 400);
	}
	$("#hearder_menu_wrapper").click(function(event) {
		event.stopPropagation();
		$("#hearder_hamburger_menu").toggleClass("open");
		$("#header_menu_container .header_menu_list").toggleClass("active");
		slideMenu();

		$("body").toggleClass("overflow-hidden");
	});

	$(".header_menu_list").find(".h_accordion-toggle").click(function() {
			$(this).next().toggleClass("open").slideToggle("fast");
			$(this).toggleClass("active-tab").find(".menu-link")
					.toggleClass("active");

			$(".header_menu_list .h_accordion-content").not($(this).next())
					.slideUp("fast").removeClass("open");
			$(".header_menu_list .h_accordion-toggle").not(jQuery(this))
					.removeClass("active-tab").find(".menu-link")
					.removeClass("active");
	});
	
}); // jQuery load
</script>
</head>
<body>
		<div class="wrap">${category3 }
			<div id="header_menu_container">
				<div id="hearder_menu_wrapper">
					<div id="hearder_hamburger_menu">
						<span></span><span></span><span></span>
					</div>
				</div>
			<ul class="header_menu_list accordion">
				<c:forEach items="${category1 }" var="item1">
					<li class="h_toggle h_accordion-toggle">
					<a href="/shopping/product?name=${item1.cateCode }&orderBy=desc" class="menu-link">${item1.cateName }</a></li>
					<ul class="header_menu_submenu h_accordion-content">
						<c:forEach items="${category2 }" var="item2">
							<c:if test="${item2.cateCodeRef == item1.cateCode }">
								<li><a class="head" href="/shopping/product?name=${item2.cateCode }&orderBy=desc">${item2.cateName }</a></li>
							</c:if>
						</c:forEach>
					</ul>
				</c:forEach>
			</ul>

			<div class="header">
				<div id="header_form">
				<form action="/user/login" method="post">
				<ul class="hearder_nav">
					<c:if test="${empty userVO.userID }">
					<li class="header_li"><a id="header_home" href="/">Home</a></li>
					<li><span class="login">ID</span><input type="text" name="userID" class="login_txt">
						<span class="login">PW</span><input type="password" name="userPW" class="login_txt">
						<input type="submit" id="login_btn" value="?????????"></li>
					<li class="header_li"><a class="li_first" href="/user/findUserInfo">ID/PW??????</a></li>
					<li class="header_li"><a class="li_first" href="/user/join">????????????</a></li>
					</c:if>
					<c:if test="${not empty userVO.userID }">
					<li><a href="/">Home</a></li>
					<li><span id="login_user_id">${userID }???</span></li>
					<li><a class="li" href="/user/mypage">???????????????</a></li>
					<li><a class="li" href="/shopping/productMGR">????????????</a></li>
					<li><a class="li" href="/shopping/cartList">????????????</a></li>
					<li><a class="li" href="/shopping/orderComplete">???????????????</a></li>
					<li><a class="li" href="/user/logout">????????????</a></li>
					</c:if>
				</ul>
				</form>
				</div>
				<div class="intro_bg">
				</div>
				<div class="search" id="searchArea">
					<input type="hidden" id="orderBy" value="desc">
					<div id="search_div">
						<select id="serachSelect" name="searchType">
							<option value="used">????????????</option>
							<option value="title">??????</option>
							<option value="content">??????</option>
							<option value="title_content">??????+??????</option>
						</select>
					</div>
						<input type="text" name="keyWord" placeholder=" ???? Search...">
						<button id="search_btn">??????</button>
				</div>
				<script type="text/javascript">
					document.getElementById("search_btn").onclick = function () {
					let searchType = document.getElementsByName("searchType")[0].value;
					let keyWord =  document.getElementsByName("keyWord")[0].value;
					let orderBy = $("#orderBy").val();
					
					location.href = "/shopping/productSearch?searchType=" + searchType + "&keyWord=" + keyWord + "&orderBy=" + orderBy;
				};
				</script>
			</div>
			</div>
		</div>
	<!-- </div> -->
	<hr>
</body>
</html>
