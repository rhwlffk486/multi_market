<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap"
	rel="stylesheet">
<script type="text/javascript" src="/resources/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="/resources/css/template/category.css">
<title>shopping</title>
<script type="text/javascript">
	if ("${result}" == 2) {
		alert("회원정보 수정에 성공하셨습니다.\n다시로그인해주세요.");
	}
	
	if ("${productUpload}" == 1) {
		alert("상품 등록에 성공하셨습니다.");
	}
	
	if ("${orderResult}"== 1) {
		alert("주문 완료 되었습니다.");
	}
	
	if ("${msg}"== 1) {
		alert("입력해주신 email로 아이디를 발송했습니다.");
	}
	
	if ("${msg}"== 4) {
		alert("입력해주신 email로 임시비밀번호를 발송했습니다.");
	}
	
	if ("${joinResult}" == 1) {
		alert("회원가입에 성공하셨습니다!\n로그인을 진행해주세요!")
	}
</script>
</head>
<body>
	<c:if test="${result eq 1}">
		<script type="text/javascript">
			alert("아이디 혹은 비밀번호를 다시 확인해주세요.");
			location.href = "http://localhost/";
		</script>
	</c:if>	
	<header>
		<jsp:include page="template/header.jsp"/>
	</header>
	
	<main>
		<jsp:include page="template/main.jsp"/>
	</main>
	<footer>
		<jsp:include page="template/footer.jsp"/>
	</footer>
</body>
</html>
