<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- 주소 api -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link rel="stylesheet" href="/resources/css/template/category.css">
<title>shopping</title>
<script type="text/javascript">
if ("${result}" == 2) {
	alert("회원정보 수정에 성공하셨습니다.\n다시로그인해주세요.");
}

var userAddress1 = false;
	//사용할 function명 적어주기
	function findAddr() {
		daum.postcode
				.load(function() {
					new daum.Postcode(
							{
								oncomplete : function(data) {
									// 각 주소의 규칙에 따라 주소 조합
									// 가져올 변수가 없을때는 공백을 가지기 때문에 이를 참고해 분기한다고 한다
									var addr = ''; //주소 변수

									// 사용자가 선택한 주소타입(도로명/지번)에 따라 해당 값 가져오기
									// 만약 사용자가 도로명 주소를 선택했을 때
									if (data.userSelectedType == 'R') {
										addr = data.roadAddress;
										// 만약 사용자가 구주소를 선택했을 때
									} else {
										addr = data.jibunaddress;
									}

									// 우편번호
									document.getElementById('userAddress1').value = data.zonecode;
									console.log($("#userAddress1").val());
									userAddress1 = true;
									console.log(userAddress1);
									// 주소정보
									document.getElementById('userAddress2').value = addr;
								}
							}).open();
				});
	}
	//form 유효성 검사
	$(function() {
		$("#back_btn").click(function(){
			  location.href = "/";
		 }); 
		// 이름 정규식
		var nameJ = /^[가-힣]{2,5}$/
		//모든 공백 체크 정규식
		var empJ = /\s/g;
		//아이디 정규식
		var idJ = /^[a-z0-9]{4,12}$/;
		// 비밀번호 정규식
		var pwJ = /^[A-Za-z0-9]{4,12}$/;
		// 핸드폰 정규식
		var phJ = /^01\d\d{3,4}\d{4}$/;
		// 주소 정규식
		var addJ = /^[A-Za-z0-9가-힣\s]{1,25}$/;
		// 이메일 검사 정규식
		var mailJ = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		
		var test= 1;
		
		var user_name = false;
		var idCheck = false;
		var user_PW = false;
		var pwCheck = false;
		var phone = false;
		var userAddress3 = false;
		var email = false;
		var nickname = false;
		
		$("#user_name").keyup(function(){
			if (nameJ.test($("#user_name").val())&&empJ.test($("#user_name").val())==false) {
				$("#nameCheck").html('');
				user_name = true;
			}else{
				$("#nameCheck").html('2~5사이의 한글 이름을 적어주세요.');	
				$("#nameCheck").css('color', 'red');
				user_name = false;
				}
		}); 
		
		$("#user_ID").keyup(function() {
			var id = document.getElementById('user_ID').value;

			if (idJ.test(id)&& empJ.test(id) == false) {
				$.ajax({
						url : "/user/idCheck",
						type : "post",
						data : {
							"userID" : id
						},
						success : function(data) {
							if (data == "yes") {
								document.getElementById('idCheck').innerHTML = "";
								idCheck = true;
							} else {
								document.getElementById('idCheck').innerHTML = "중복된 ID가 존재합니다.";
								document.getElementById('idCheck').style.color = "red";
								idCheck = false;
							}
						}
					});
			} else {
				document.getElementById('idCheck').innerHTML = "4~12자 사이<br>소문자와 숫자만 가능합니다.";
				document.getElementById('idCheck').style.color = "red";
				idCheck = false;
			}
		});
		
		$("#user_PW").keyup(function() {
			if (pwJ.test($("#user_PW").val())&& empJ.test($("#user_PW").val()) == false) {
				$("#pwCheck").html('');
				user_PW = true;
			} else {
				$("#pwCheck").html('4~12자 사이의 영어와 숫자만 가능합니다.');
				$('#pwCheck').css('color', 'red');
				user_PW = false;
			}
		});

		$("#PW_Check").keyup(function() {
			var pwd1 = $("#user_PW").val();
			var pwd2 = $("#PW_Check").val();

			if (pwd1 == pwd2) {
				$("#pwChkChk").html('');
				pwCheck = true;
			} else {
				$("#pwChkChk").html('같은 비밀번호를 입력해주십시오.');
				$('#pwChkChk').css('color', 'red');
				pwCheck = false;
			}
		});
		
		$("#phone").keyup(function() {
			if (phJ.test($("#phone").val())) {
				$("#phoneCheck").html('');
				phone = true;
			} else {
				$("#phoneCheck").html("공백 또는'-'없이 숫자로 입력해주세요.");
				$("#phoneCheck").css('color', 'red');
				phone = false;
			}
		});
		
		$("#userAddress3").keyup(function(){
			if (addJ.test($("#userAddress3").val())) {
				$("#Addr3Check").html('');
				userAddress3 = true;
			} else {
				$("#Addr3Check").html('상세주소를 정확히 입력해주세요.');
				$("#Addr3Check").css('color', 'red');
				userAddress3 = false;
			}
		});
		
		$("#email").keyup(function(){
			if (mailJ.test($("#email").val())&&empJ.test($("#email").val())==false) {
				$("#emailCheck").html('');
				email = true;
			} else {
				$("#emailCheck").html('email을 형식에 맞게 입력해주세요.');
				$("#emailCheck").css('color', 'red');
				email = false;
			}
		});
		
		$("#signFrm").submit(function() {
			if (user_name == false) {
				alert("이름을 확인해 주세요.");
				return false;
			} else if (idCheck == false) {
				alert("아이디를 확인해주세요");
				return false;
			} else if (user_PW == false) {
				alert("비밀번호를 확인해주세요");
				return false;
			} else if (pwCheck == false) {
				alert("비밀번호 확인란을 확인해주세요");
				return false;
			} else if (phone == false) {
				alert("핸드폰을 확인해주세요");
				return false;
			} else if (userAddress1 == false) {
				alert("주소검색을 해주세요.");
				return false;
			} else if (userAddress3 == false) {
				alert("상세주소르 확인해주세요");
				return false;
			} else if (email == false) {
				alert("Email을 확인해주세요");
				return false;
			}
		});
	});
</script>
<style>
.td_Addr_sign_up {
	width: 400px;
}
</style>
</head>
<body>
	<header>
		<jsp:include page="../template/header.jsp"/>
	</header>
	<main id="main">
		<div class="container">
			<div class="form_txtInput">
				<h2 class="sub_tit_txt">회원가입</h2>
				<p class="exTxt">일반 회원 페이지 입니다.</p>

				<form id="signFrm" name="signFrm" action="/user/join" method="POST">
					<div class="join_form">
						<table>
							<tbody>
								<tr>
									<th><input type="hidden" name="role" value="중고"></th>
								</tr>
								<tr>
									<th><label for="user_name"><span>이름</span></label></th>
									<td><input type="text" class="td_input_sign_up" id="user_name" name="userName"></td>
									<td><div class="check_font" id="nameCheck"></div></td>
								</tr>
								<tr>
									<th><label for="user_ID"><span>아이디</span></label></th>
									<td><input type="text" class="td_input_sign_up" id="user_ID" name="userID"></td>
									<td><div class="check_font" id="idCheck"></div></td>
								</tr>
								<tr>
									<th><label for="user_PW"><span>비밀번호</span></label></th>
									<td><input type="password" class="td_input_sign_up" id="user_PW" name="userPW"></td>
									<td><div class="check_font" id="pwCheck"></div></td>
								</tr>
								<tr>
									<th><label for="PW_Check"><span>비밀번호 확인</span></label></th>
									<td><input type="password" class="td_input_sign_up" id="PW_Check"></td>
									<td><div class="check_font" id="pwChkChk"></div></td>
								</tr>
								<tr>
									<th><label for="phone"><span>핸드폰 번호</span></label></th>
									<td><input type="text" class="td_input_sign_up" id="phone" name="phone"></td>
									<td><div class="check_font" id="phoneCheck"></div></td>
								</tr>
								<tr>
									<th><span>주소</span></th>
									<td><input type="text" name="userAddress1" id="userAddress1" placeholder="우편번호 입력" readonly class='box' />
										<input id="Addr_btn" type="button" value="주소 검색" onclick="findAddr()"></td>
									<td><div class="check_font" id="Addr1Check"></div></td>
								</tr>
								<tr>
									<th></th>
									<td><input type="text" name="userAddress2" id="userAddress2" placeholder="주소를 입력" readonly class='box' /></td>
									<td><input type="text" id="userAddress3" name="userAddress3" placeholder="상세 주소를 입력하세요" /></td>
									<td><div class="check_font" id="Addr3Check"></div></td>
								</tr>
								<tr>
									<th><label for="email"><span>이메일</span></label></th>
									<td><input type="text" class="form-control" id="email" name="email" required></td>
									<td><div class="check_font" id="emailCheck"></div></td>
								</tr>
							</tbody>
						</table>

						<div id="txt">
							<span>표시는 필수적으로 입력해주셔야 가입이 가능합니다.</span>
						</div>
						<div id="btn_wrap_div">
							<a class="btn_wrap" href="javascript:;" onclick="$('#signFrm').submit();">회원가입</a>
							<input type="button" id="back_btn" class="btn_wrap" value="취소">
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
