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
	/* var jsonData = JSON.parse('${category}'); */
	
/* 	for (var i=0; i<jsonData.length; i++) {
		if (jsonData[i].cateCode == 100*(i+1)) {
			console.log("hi");
			for (var j=0; j<jsonData.length; j++) {
				if (jsonData[j].cateCodeRef == 100*(i+1))
				console.log("hello");
			}
		}
	} */
}); // jQuery load
</script>
</head>
<body>

	<div class="wrap">
		<!-- <div class="intro_bg"> -->
			<div id="header_menu_container">
				<div id="hearder_menu_wrapper">
					<div id="hearder_hamburger_menu">
						<span></span><span></span><span></span>
					</div>
				</div>
			<ul class="header_menu_list accordion">
				<li class="h_toggle h_accordion-toggle">
				<a href="/shopping/product?name=100&orderBy=desc" class="menu-link">패션 의류</a></li>
				<ul class="header_menu_submenu h_accordion-content">
					<li><a class="head" href="/shopping/product?name=101&orderBy=desc">신발</a></li>
					<li><a class="head" href="/shopping/product?name=102&orderBy=desc">구두</a></li>
					<li><a class="head" href="/shopping/product?name=103&orderBy=desc">바지</a></li>
					<li><a class="head" href="/shopping/product?name=104&orderBy=desc">치마</a></li>
					<li><a class="head" href="/shopping/product?name=105&orderBy=desc">셔츠</a></li>
					<li><a class="head" href="/shopping/product?name=106&orderBy=desc">티셔츠</a></li>
					<li><a class="head" href="/shopping/product?name=107&orderBy=desc">아웃도어</a></li>
					<li><a class="head" href="/shopping/product?name=108&orderBy=desc">모자</a></li>
					<li><a class="head" href="/shopping/product?name=109&orderBy=desc">기타</a></li>
				</ul>
				<li class="h_toggle h_accordion-toggle">
				<a href="/shopping/product?name=200&orderBy=desc" class="menu-link">뷰티</a></li>
				<ul class="header_menu_submenu h_accordion-content">
					<li><a class="head" href="/shopping/product?name=201&orderBy=desc">메이크업</a></li>
					<li><a class="head" href="/shopping/product?name=202&orderBy=desc">향수</a></li>
					<li><a class="head" href="/shopping/product?name=203&orderBy=desc">헤어</a></li>
					<li><a class="head" href="/shopping/product?name=204&orderBy=desc">네일</a></li>
					<li><a class="head" href="/shopping/product?name=205&orderBy=desc">기타</a></li>
				</ul>
				<li class="h_toggle h_accordion-toggle">
				<a href="/shopping/product?name=300&orderBy=desc" class="menu-link">식품</a></li>
				<ul class="header_menu_submenu h_accordion-content">
					<li><a class="head" href="/shopping/product?name=301&orderBy=desc">고기</a></li>
					<li><a class="head" href="/shopping/product?name=302&orderBy=desc">과일</a></li>
					<li><a class="head" href="/shopping/product?name=303&orderBy=desc">채소</a></li>
					<li><a class="head" href="/shopping/product?name=304&orderBy=desc">수산물</a></li>
					<li><a class="head" href="/shopping/product?name=305&orderBy=desc">음료</a></li>
					<li><a class="head" href="/shopping/product?name=306&orderBy=desc">인스턴트</a></li>
					<li><a class="head" href="/shopping/product?name=307&orderBy=desc">쌀</a></li>
					<li><a class="head" href="/shopping/product?name=308&orderBy=desc">기타</a></li>
				</ul>
				<li class="h_toggle h_accordion-toggle">
				<a href="/shopping/product?name=400&orderBy=desc" class="menu-link">주방용품</a></li>
				<ul class="header_menu_submenu h_accordion-content">
					<li><a class="head" href="/shopping/product?name=401&orderBy=desc">주방가전</a></li>
					<li><a class="head" href="/shopping/product?name=402&orderBy=desc">주방기구</a></li>
					<li><a class="head" href="/shopping/product?name=403&orderBy=desc">일회용품</a></li>
				</ul>
				<li class="h_toggle h_accordion-toggle">
				<a href="/shopping/product?name=500&orderBy=desc" class="menu-link">생활용품</a></li>
				<ul class="header_menu_submenu h_accordion-content">
					<li><a class="head" href="/shopping/product?name=501&orderBy=desc">세면물품</a></li>
					<li><a class="head" href="/shopping/product?name=502&orderBy=desc">집용품</a></li>
					<li><a class="head" href="/shopping/product?name=503&orderBy=desc">세탁용품</a></li>
					<li><a class="head" href="/shopping/product?name=504&orderBy=desc">욕실용품</a></li>
					<li><a class="head" href="/shopping/product?name=505&orderBy=desc">주방물품</a></li>
					<li><a class="head" href="/shopping/product?name=506&orderBy=desc">기타</a></li>
				</ul>
				<li class="h_toggle h_accordion-toggle">
				<a href="/shopping/product?name=600&orderBy=desc" class="menu-link">가전용품</a></li>
				<ul class="header_menu_submenu h_accordion-content">
					<li><a class="head" href="/shopping/product?name=601&orderBy=desc">침구</a></li>
					<li><a class="head" href="/shopping/product?name=602&orderBy=desc">가구</a></li>
					<li><a class="head" href="/shopping/product?name=603&orderBy=desc">수납</a></li>
					<li><a class="head" href="/shopping/product?name=604&orderBy=desc">욕실용품</a></li>
					<li><a class="head" href="/shopping/product?name=605&orderBy=desc">기타</a></li>
				</ul>
				<li class="h_toggle h_accordion-toggle">
				<a href="/shopping/product?name=700&orderBy=desc" class="menu-link">인테리어</a></li>
				<ul class="header_menu_submenu h_accordion-content">
					<li><a class="head" href="/shopping/product?name=701&orderBy=desc">TV</a></li>
					<li><a class="head" href="/shopping/product?name=702&orderBy=desc">냉장고</a></li>
					<li><a class="head" href="/shopping/product?name=703&orderBy=desc">컴퓨터</a></li>
					<li><a class="head" href="/shopping/product?name=704&orderBy=desc">세탁기</a></li>
					<li><a class="head" href="/shopping/product?name=705&orderBy=desc">청소기</a></li>
					<li><a class="head" href="/shopping/product?name=706&orderBy=desc">기타</a></li>
				</ul>
				<li class="h_toggle h_accordion-toggle">
				<a href="/shopping/product?name=800&orderBy=desc" class="menu-link">스포츠</a></li>
				<ul class="header_menu_submenu h_accordion-content">
					<li><a class="head" href="/shopping/product?name=801&orderBy=desc">홈트레이닝</a></li>
					<li><a class="head" href="/shopping/product?name=802&orderBy=desc">수영</a></li>
					<li><a class="head" href="/shopping/product?name=803&orderBy=desc">골프</a></li>
					<li><a class="head" href="/shopping/product?name=804&orderBy=desc">자전거</a></li>
					<li><a class="head" href="/shopping/product?name=805&orderBy=desc">킥보드</a></li>
					<li><a class="head" href="/shopping/product?name=806&orderBy=desc">낚시</a></li>
					<li><a class="head" href="/shopping/product?name=807&orderBy=desc">등산</a></li>
					<li><a class="head" href="/shopping/product?name=808&orderBy=desc">기타</a></li>
				</ul>
				<li class="h_toggle h_accordion-toggle">
				<a href="/shopping/product?name=900&orderBy=desc" class="menu-link">자동차용품</a></li>
				<ul class="header_menu_submenu h_accordion-content">
					<li><a class="head" href="/shopping/product?name=901&orderBy=desc">인테리어</a></li>
					<li><a class="head" href="/shopping/product?name=902&orderBy=desc">세차</a></li>
					<li><a class="head" href="/shopping/product?name=903&orderBy=desc">차량부품</a></li>
					<li><a class="head" href="/shopping/product?name=904&orderBy=desc">오토바이</a></li>
					<li><a class="head" href="/shopping/product?name=905&orderBy=desc">기타</a></li>
				</ul>
				<li class="h_toggle h_accordion-toggle">
				<a href="/shopping/product?name=1000&orderBy=desc" class="menu-link">도서/음반</a></li>
				<ul class="header_menu_submenu h_accordion-content">
					<li><a class="head" href="/shopping/product?name=1001&orderBy=desc">유아</a></li>
					<li><a class="head" href="/shopping/product?name=1002&orderBy=desc">소설</a></li>
					<li><a class="head" href="/shopping/product?name=1003&orderBy=desc">초중참고서</a></li>
					<li><a class="head" href="/shopping/product?name=1004&orderBy=desc">외국어</a></li>
					<li><a class="head" href="/shopping/product?name=1005&orderBy=desc">대학교제</a></li>
					<li><a class="head" href="/shopping/product?name=1006&orderBy=desc">만화</a></li>
					<li><a class="head" href="/shopping/product?name=1007&orderBy=desc">기타</a></li>
				</ul>
				<li class="h_toggle h_accordion-toggle">
				<a href="/shopping/product?name=1100&orderBy=desc" class="menu-link">완구/문구</a></li>
				<ul class="header_menu_submenu h_accordion-content">
					<li><a class="head" href="/shopping/product?name=1101&orderBy=desc">케릭터완구</a></li>
					<li><a class="head" href="/shopping/product?name=1102&orderBy=desc">영아완구</a></li>
					<li><a class="head" href="/shopping/product?name=1103&orderBy=desc">로봇</a></li>
					<li><a class="head" href="/shopping/product?name=1104&orderBy=desc">블록</a></li>
					<li><a class="head" href="/shopping/product?name=1105&orderBy=desc">물놀이</a></li>
					<li><a class="head" href="/shopping/product?name=1106&orderBy=desc">야외완구</a></li>
					<li><a class="head" href="/shopping/product?name=1107&orderBy=desc">실내완구</a></li>
					<li><a class="head" href="/shopping/product?name=1108&orderBy=desc">보드</a></li>
					<li><a class="head" href="/shopping/product?name=1109&orderBy=desc">조립</a></li>
					<li><a class="head" href="/shopping/product?name=1110&orderBy=desc">기타</a></li>
				</ul>
				<li class="h_toggle h_accordion-toggle">
				<a href="/shopping/product?name=1200&orderBy=desc" class="menu-link">반려동물용품</a></li>
				<ul class="header_menu_submenu h_accordion-content">
					<li><a class="head" href="/shopping/product?name=1201&orderBy=desc">사무용품</a></li>
					<li><a class="head" href="/shopping/product?name=1202&orderBy=desc">학용품</a></li>
					<li><a class="head" href="/shopping/product?name=1203&orderBy=desc">엽서</a></li>
					<li><a class="head" href="/shopping/product?name=1204&orderBy=desc">필기류</a></li>
					<li><a class="head" href="/shopping/product?name=1205&orderBy=desc">기타</a></li>
				</ul>
				<li class="h_toggle h_accordion-toggle">
				<a href="/shopping/product?name=1300&orderBy=desc" class="menu-link">반려동물용품</a></li>
				<ul class="header_menu_submenu h_accordion-content">
					<li><a class="head" href="/shopping/product?name=1301&orderBy=desc">강아지물품</a></li>
					<li><a class="head" href="/shopping/product?name=1302&orderBy=desc">고양이물품</a></li>
					<li><a class="head" href="/shopping/product?name=1303&orderBy=desc">관상어물품</a></li>
					<li><a class="head" href="/shopping/product?name=1304&orderBy=desc">가축물품</a></li>
					<li><a class="head" href="/shopping/product?name=1305&orderBy=desc">기타</a></li>
				</ul>
				<li class="h_toggle h_accordion-toggle">
				<a href="/shopping/product?name=1400&orderBy=desc" class="menu-link">기타</a></li>
				<ul class="header_menu_submenu h_accordion-content">
					<li><a class="head" href="/shopping/product?name=1401&orderBy=desc">건강기능식품</a></li>
					<li><a class="head" href="/shopping/product?name=1402&orderBy=desc">여성용건강식품</a></li>
					<li><a class="head" href="/shopping/product?name=1403&orderBy=desc">남성용건강식품</a></li>
					<li><a class="head" href="/shopping/product?name=1404&orderBy=desc">임산부건강식품</a></li>
					<li><a class="head" href="/shopping/product?name=1405&orderBy=desc">헬스</a></li>
					<li><a class="head" href="/shopping/product?name=1406&orderBy=desc">영양제</a></li>
					<li><a class="head" href="/shopping/product?name=1407&orderBy=desc">다이어트</a></li>
					<li><a class="head" href="/shopping/product?name=1408&orderBy=desc">기타</a></li>
				</ul>
			</ul>


			<div class="header">
				<div id="header_form">
				<form action="/user/login" method="post">
				<ul class="hearder_nav">
					<c:if test="${empty userVO.userID }">
					<li class="header_li"><a id="header_home" href="/">Home</a></li>
					<li><span class="login">ID</span><input type="text" name="userID" class="login_txt">
						<span class="login">PW</span><input type="password" name="userPW" class="login_txt">
						<input type="submit" id="login_btn" value="로그인"></li>
					<li class="header_li"><a class="li_first" href="/user/findUserInfo">ID/PW찾기</a></li>
					<li class="header_li"><a class="li_first" href="/user/join">회원가입</a></li>
					</c:if>
					<c:if test="${not empty userVO.userID }">
					<li><a href="/">Home</a></li>
					<li><span id="login_user_id">${userID }님</span></li>
					<li><a class="li" href="/user/mypage">마이페이지</a></li>
					<li><a class="li" href="/shopping/productMGR">상품관리</a></li>
					<li><a class="li" href="/shopping/cartList">장바구니</a></li>
					<li><a class="li" href="/shopping/orderComplete">주문리스트</a></li>
					<li><a class="li" href="/user/logout">로그아웃</a></li>
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
							<option value="used">중고물품</option>
							<option value="title">제목</option>
							<option value="content">내용</option>
							<option value="title_content">제목+내용</option>
						</select>
					</div>
						<input type="text" name="keyWord" placeholder=" 🔎 Search...">
						<button id="search_btn">검색</button>
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
