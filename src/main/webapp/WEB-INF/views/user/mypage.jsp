<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- 주소 api -->
<script	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="/resources/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="/resources/css/template/category.css">
<link rel="stylesheet" href="/resources/css/user/mypage.css">
<link rel="stylesheet" href="/resources/css/user/joinButton.css">
<title>shopping</title>
<script type="text/javascript">
if ("${result}" == 3) {
	alert("회원탈퇴에 실패하셨습니다. 다시 시도해주세요.");
}

function deleteUser(){
	var cf = confirm("정말 탈퇴하시겠습니가?");
	
	if (cf == true) {
		location.href="/user/deleteUser";
		alert("탈퇴 완료됬습니다.");
		
	} else {
		alert("취소하셨습니다.")
		return false;
	}
	
}

</script>
</head>
<body>
	<header>
		<jsp:include page="../template/header.jsp"/>
	</header>
	<main id="main">
		<div class="container">
			<div class="form_txtInput">
				<h2 class="sub_tit_txt">마이페이지</h2>
			<c:if test="${userVO.role eq '중고' }">	
			<div class="join_button">		
				<a href="/user/nomalUpdate" class="nomal_btn">회원 수정</a>
				<a href="javascript:;" onclick="deleteUser();" class="seller_btn">회원 탈퇴</a>
			</div>
			</c:if>
			<c:if test="${userVO.role eq '기업' }">
			<div class="join_button">
				<a href="/user/sellerUpdate" class="nomal_btn">회원 수정</a>
				<a href="javascript:;" onclick="deleteUser();" class="seller_btn">회원 탈퇴</a>
			</div>
			</c:if>
			</div>
		</div>
	</main>
	<footer>
		<jsp:include page="../template/footer.jsp"/>
	</footer>
</body>
</html>
