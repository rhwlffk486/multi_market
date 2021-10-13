<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- 주소 api -->
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link rel="stylesheet" href="/resources/css/template/category.css">
<link rel="stylesheet" href="/resources/css/user/joinButton.css">
<title>shopping</title>
</head>
<body>
	<header>
		<jsp:include page="../template/header.jsp"/>
	</header>
	<main id="join_main">
		<div class="join_container">
			<div class="form_txtInput">
				<h2 class="sub_tit_txt">회원가입</h2>
			</div>
			<div class="join_button">
			<br><br><br><br><br>
				<a href="/user/nomalJoin" class="nomal_btn">일반 회원가입</a>
				<a href="/user/sellerJoin" class="seller_btn">기업 회원가입</a>
			</div>
		</div>
	</main>
	<footer>
		<jsp:include page="../template/footer.jsp"/>
	</footer>
</body>
</html>
