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

var userAddress1 = false;
	//사용할 function명 적어주기
	function findAddr() {
		daum.postcode.load(function() {
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
		// 계좌번호 정규식
		var accJ = /^[0-9]*$/;
		// 사업자 등록번호 정규식
		var bnsJ = /^[0-9-]{12,12}$/;
		
		var userPW = false;
		var pwCheck = false;
		var phone = false;
		var userAddress3 = false;
		var email = false;
		var businessNumber = false;
		var BKname = true;
		var accountNumber = false;

		$("#user_PW").keyup(function() {
			if (pwJ.test($("#user_PW").val())&& empJ.test($("#user_PW").val()) == false) {
				$("#pwCheck").html('');
				userPW = true;
			} else {
				$("#pwCheck").html('4~12자 사이의 영어와 숫자만 가능합니다.');
				$('#pwCheck').css('color', 'red');
				userPW = false;
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
				$("#phoneCheck").html("공백 또는'-'없이 숫자만 입력해주세요.");
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
		
		$("#business_number").keyup(function() {
			var key = event.charCode || event.keyCode || 0;
            $text = $(this); 
            if (key !== 8 && key !== 9) {
                if ($text.val().length === 3) {
                    $text.val($text.val() + '-');
                }
                if ($text.val().length === 6) {
                    $text.val($text.val() + '-');
                }
                if ($text.val().length == 12){
                businessNumber = true;
                }
            }
            
            if (bnsJ.test($("#business_number").val())&&empJ.test($("#business_number").val())==false) {
            	$("#bnsCheck").html('');
            	businessNumber = true;
            } else {
            	$("#bnsCheck").html('사업자 등록 번호를 숫자로 입력해주세요.');
            	$("#bnsCheck").css('color', 'red');
            	businessNumber = false;
            }
		});
		
		$("#select").change(function() {
            if ($("select").val() == '선택하세요') {
            	BKname = false;
            }
            
            if ($("#select").val() == 'other') {
                $("#BKname").attr("disabled", false);
                $("#BKname").val("");
                $("#BKname").focus();
                BKname = true;
	        } else {
	            $("#BKname").val($("#select").val());
	            BKname = true;
	        }
            
	    });
		
		
		$("#account").keyup(function() {
			if (accJ.test($("#account").val())&&empJ.test($("#account").val())==false) {
				$("#accountCheck").html('');
				accountNumber = true;
			} else {
				$("#accountCheck").html("공백 또는'-'없이 숫자만 입력해주세요.");
				$("#accountCheck").css('color', 'red');
				accountNumber = false;
			}
		});
		
		if ($("#phone").val!=null) {
			phone = true;
		}
		
		if ($("#userAddress1").val!=null) {
			userAddress1 = true;
		}
		
		if ($("#userAddress3").val!=null) {
			userAddress3 = true;
		}
		
		if ($("#email").val!=null) {
			email = true;
		}
		
		if ($("#business_number").val!=null) {
			businessNumber = true;
		}
		
		if ($("#accountNumber").val!=null) {
			accountNumber = true;
		}
		
		$("#signFrm").submit(function() {
			
			if ($("#BKname").val() == "") {
	        	alert("은행을 확인해주세요.");
	        	BKname = false;
	        }
			
			if (userPW == false) {
				alert("비밀번호를 확인해주세요.");
				return false;
			} else if (pwCheck == false) {
				alert("비밀번호 확인란을 확인해주세요.");
				return false;
			} else if (phone == false) {
				alert("핸드폰을 확인해주세요.");
				return false;
			} else if (userAddress1 == false) {
				alert("주소검색을 해주세요.");
				return false;
			} else if (userAddress3 == false) {
				alert("상세주소르 확인해주세요.");
				return false;
			} else if (email == false) {
				alert("Email을 확인해주세요.");
				return false;
			} else if (BKname == false) {
				alert("은행명을 확인해주세요.");
				return false; 
			} else if (businessNumber == false) {
				alert("사업자 번호를 확인해주세요.");
				return false;
			} else if (accountNumber == false) {
				alert("계좌 번호를 확인해주세요.");
				return false;
			}
		});
	});
</script>
</head>
<body>
	<header>
		<jsp:include page="../template/header.jsp"/>
	</header>
	<main id="main">
		<div class="container">
			<div class="form_txtInput">
				<h2 class="sub_tit_txt">정보수정</h2>
				<p class="exTxt">기업 회원 페이지 입니다.</p>

				<form id="signFrm" name="signFrm" action="/user/update" method="POST">
					<div class="join_form">
						<table>
							<colgroup>
								<col width="30%" />
								<col width="auto" />
							</colgroup>

							<tbody>
								<tr>
									<th><input type="hidden" name="role" value="기업"></th>
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
									<td><input type="text" class="td_input_sign_up" id="phone" name="phone" maxlength="13" value="${userVO.phone }"></td>
									<td><div class="check_font" id="phoneCheck"></div></td>
								</tr>

								<tr>
									<th><span>주소</span></th>
									<td><input type="text" name="userAddress1" id="userAddress1" placeholder="우편번호 입력" readonly class='box' value="${userVO.address1 }"/>
										<input id="Addr_btn" type="button" value="주소 검색" onclick="findAddr()"></td>
									<td><div class="check_font" id="Addr1Check"></div></td>
								</tr>
								<tr>
									<th></th>
									<td><input type="text" name="userAddress2" id="userAddress2" placeholder="주소 입력" readonly class='box' value="${userVO.address2 }"/></td>
									<td><input type="text" id="userAddress3" name="userAddress3" value="${userVO.address3 }"></td>
										<td><div class="check_font" id="Addr3Check"></div></td>
								</tr>

								<tr>
									<th><label for="email"><span>이메일</span></label></th>
									<td><input type="text" class="form-control" id="email" name="email" required value="${userVO.email }"></td>
									<td><div class="check_font" id="emailCheck"></div></td>
								</tr>
								
								<tr>
									<th><label for="business_number"><span>사업자 번호</span></label></th>
									<td><input type="text" class="form-control" id="business_number" name="businessNumber" maxlength="12" value="${userVO.businessNumber }" ></td>
									<td><div class="check_font" id="bnsCheck"></div></td>
								</tr>
								
								<tr>
									<th><label for="BK"><span>계좌 번호</span></label>
										<select id="select" class="select">
											<option value="선택하세요">선택하세요.</option>
								 			<option value="국민은행">국민은행</option>
								 			<option value="우리은행">우리은행</option>
								 			<option value="신한은행">신한은행</option>
								 			<option value="하나은행">하나은행</option>
								 			<option value="SC제일은행">SC제일은행</option>
								 			<option value="한국씨티은행">한국씨티은행</option>
								 			<option value="other">직접입력</option>
										</select>
									</th>
									<td><input type="text" id="BKname" name="BKname" value="${userVO.bank }">
									<input type="text" id="account" name="account" class="form-control" name="email" required value="${userVO.accountNumber }"></td>
									<td><div class="check_font" id="accountCheck"></div></td>
								</tr>
							</tbody>
						</table>
						<div id="txt">
							<span>표시는 필수적으로 입력해주셔야 가입이 가능합니다.</span>
						</div>
						<div id="btn_wrap_div">
							<a class="btn_wrap" href="javascript:;" onclick="$('#signFrm').submit();">정보수정</a>
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
