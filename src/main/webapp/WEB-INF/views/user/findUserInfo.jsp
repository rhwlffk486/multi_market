<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="/resources/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="/resources/css/user/findPW.css">
<title>Insert title here</title>
<script type="text/javascript">
$(function(){
	
	if("${msg}" == 2) {
		alert("이름 혹은 핸드폰번호가 존재하지 앖습니다.");
	} 
	
	if("${msg}" == 3) {
		alert("ID 혹은 email이 존재하지 앖습니다.");
	}  
	
	$("#findID").submit(function(){
		// 이름 정규식
		var nameJ = /^[가-힣]{2,5}$/
		//모든 공백 체크 정규식
		var empJ = /\s/g;
		// 핸드폰 정규식
		var phJ = /^01\d\d{3,4}\d{4}$/;
		// 이메일 검사 정규식
		var mailJ = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	
		var name = $("#user_name").val();
		var email = $("#email_ID").val();
		
		var Fname = false;
		var Femail = false;
		
		if (name == "") {
			alert("이름을 입력해주세요.");
			$("#user_name").focus();
			return false;
		}
		
		if (nameJ.test(name) && empJ.test(name)==false) {
			Fname = true;
		} else {
			alert("이름을 제대로 입력해주세요.");
			$("#user_name").focus();
			return false;
		}
		
		if (mailJ.test(email)) {
			Femail = true;
		} else {
			alert('email을 형식에 맞게 입력해주세요.');
			$("#email_ID").focus();
			return false;
		}
		
		if (Fname == true && Femail == true) {
			return true;
		}
	})
	
	$("#findPW").submit(function(){
		//모든 공백 체크 정규식
		var empJ = /\s/g;
		//아이디 정규식
		var idJ = /^[a-z0-9]{4,12}$/;
		// 이메일 검사 정규식
		var mailJ = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	
		var userID = $("#user_ID").val();
		var email = $("#email").val();
		
		var FuserID = false;
		var Femail = false;
		
		if (userID == "") {
			alert("ID를 입력해주세요.");
			$("#user_ID").focus();
			return false;
		}
		
		if (idJ.test(userID) && empJ.test(userID)==false) {
			FuserID = true;
		} else {
			alert("ID를 공백없이 혹은 제대로 입력해주세요.");
			$("#user_ID").focus();
			return false;
		}
		
		if (mailJ.test(email)) {
			Femail = true;
		} else {
			alert('email을 형식에 맞게 입력해주세요.');
			$("#email").focus();
			return false;
		}
		
		if (FuserID == true && Femail == true) {
			return true;
		}
	}) 
});
</script>
</head>
<body>
	<header>
		<jsp:include page="../template/header.jsp"/>
	</header>
	<main id="main">
		<div class="container">
		
			<div id="find_ID">
				<h2 class="sub_tit_txt">아이디 찾기</h2>
				<form id="findID" name="findID" action="/user/findID" method="POST">
					<div class="find_form">
						<table>
							<tbody>
								<tr>
									<th><label for="user_name"><span>이름</span></label></th>
									<td><input type="text" class="td_input_sign_up"
										id="user_name" name="userName"></td>
								</tr>
								<tr>
									<th><label for="email"><span>이메일</span></label></th>
									<td><input type="text" class="form-control" id="email_ID"
										name="email" required></td>
								</tr>
							</tbody>
						</table>
						<div id="btn_wrap_div">
							<a class="btn_wrap" href="javascript:;" onclick="$('#findID').submit();">아이디 찾기</a>
						</div>
					</div>
				</form>
				</div>
				
				
				<div id="find_PW">
				<h2 class="sub_tit_txt">비밀번호 찾기</h2>
				<form id="findPW" name="findPW" action="/user/findPW" method="POST">
					<div class="find_form">
						<table>
							<tbody>
								<tr>
									<th><label for="user_ID"><span>아이디</span></label></th>
									<td><input type="text" class="td_input_sign_up"
										id="user_ID" name="userID"></td>
								</tr>
								
								<tr>
									<th><label for="email"><span>이메일</span></label></th>
									<td><input type="text" class="form-control" id="email"
										name="email" required></td>
								</tr>
							</tbody>
						</table>
						<div id="btn_wrap_div">
							<a class="btn_wrap" href="javascript:;" onclick="$('#findPW').submit();">비밀번호 찾기</a>
						</div>
					</div>
				</form>
			</div>
		</div>

	</main>
	<footer>
		<jsp:include page="../template/footer.jsp"/>
	</footer>
</body>
</html>