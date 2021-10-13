<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<html>
<head>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap" rel="stylesheet">
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>


<script type="text/javascript" src="/resources/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="/resources/css/template/category.css">
<link rel="stylesheet" href="/resources/css/shopping/cartList.css">
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<title>shopping</title>
<script type="text/javascript">

var userAddress1 = false;
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
$(function(){
	$("#all_check").click(function(){
		var check = $("#all_check").prop("checked");
		if(check) {
			$(".check_box").prop("checked", true);
		} else {
			$(".check_box").prop("checked", false);
		}
	});
	
	$(".check_box").click(function(){
		$("#all_check").prop("checked", false);
	});
	
	$("#select_delete_btn").click(function(){
		var deleteconfirm = confirm("정말 삭제하시겠습니까?");
		
		if(deleteconfirm) {
			var checkArr = new Array();
			
			$(".check_box:checked").each(function(){
				checkArr.push($(this).attr("data-cart_num"));
			});
			
			$.ajax({
				  url : "/shopping/deleteCart"
				, type : "post"
				, data : {
					check_box : checkArr
				}
				, success : function(result) {
					if (result == 1) {
						alert("삭제 완료");						
						location.href="/shopping/cartList";
					} else {
						alert("로그인을 해주세요.");
					}
				}
			});
		}
	});
	
	$(".cart_delete_btn").click(function(){
		var deleteconfirm = confirm("정말 삭제하시겠습니까?");
		if(deleteconfirm) {
			var checkArr = new Array();
			
			checkArr.push($(this).attr("data-cart_num"));
			
			$.ajax({
				  url : "/shopping/deleteCart"
				, type : "post"
				, data : {
					check_box : checkArr
				}
				, success : function(result) {
					if (result == 1) {
						alert("삭제 완료");						
						location.href="/shopping/cartList";
					} else {
						alert("로그인을 해주세요.");
					}
				}
			});
		}
	});
	
	$(".product_oder_btn").click(function(){
		$("#cart_orderInfo").slideDown();
		$(".product_oder_btn").slideUp();
	});
	
	$(".cart_cancel_btn").click(function(){
		$("#cart_orderInfo").slideUp();
		$(".product_oder_btn").slideDown();
	});
	
	var userName = false
	var phone = false;
	var userAddress3 = false;
	
	// 이름 정규식
	var nameJ = /^[가-힣]{2,5}$/
	//모든 공백 체크 정규식
	var empJ = /\s/g;
	// 핸드폰 정규식
	var phJ = /^01\d\d{3,4}\d{4}$/;
	// 주소 정규식
	var addJ = /^[A-Za-z0-9가-힣\s]{1,25}$/;
	
	$("#user_name").keyup(function(){
		if (nameJ.test($("#user_name").val())&&empJ.test($("#user_name").val())==false) {
			$("#nameCheck").html('');
			userName = true;
		}else{
			$("#nameCheck").html('2~5사이의 한글 이름을 적어주세요.');	
			$("#nameCheck").css('color', 'red');
			userName = false;
			}
	}); 
	
	$("#order_phone").keyup(function() {
		if (phJ.test($("#order_phone").val())) {
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
	
	
	$('#signFrm').on("click",function(){
		if (userName == false) {
			alert("이름을 확인해 주세요.");
			return false;
		} else if (phone == false) {
			alert("폰을 확인해주세요");
			return false;
		} else if (userAddress1 == false) {
			alert("주소검색을 해주세요.");
			return false;
		} else if (userAddress3 == false) {
			alert("상세주소르 확인해주세요");
			return false;
		}
			var oAddress2 = $('#userAddress2').val();
			var oAddress3 = $('#userAddress3').val();
			
		
			var amount = $('#input_sum').val();
			var oName = $('#user_name').val();
			var oPhone =$('#order_phone').val();
			var oEmail = $('#order_email').val();
			var oPost = $('#userAddress1').val();
			var oAddress = oAddress2 + oAddress3;
			
		if(userName==true && phone==true && userAddress1==true && userAddress3==true) {
			//가맹점 식별코드
			IMP.init('imp59413122');
			IMP.request_pay({	
			    pg : 'kcp',
			    merchant_uid: 'merchant_' + new Date().getTime(),
			    pay_method : 'card',
			    name : "멀티마켓 상품", //결제창에서 보여질 이름
			    amount : amount, //실제 결제되는 가격
			    buyer_name : oName,
			    buyer_tel : oPhone,
			    buyer_email: oEmail,
			    buyer_addr : oAddress,
			    buyer_postcode : oPost,
			}, function(rsp) {
				console.log(rsp);
			    if ( rsp.success ) {
			    	var msg = '결제가 완료되었습니다.';
			        msg += '고유ID : ' + rsp.imp_uid;
			        msg += '결제 금액 : ' + rsp.paid_amount;
			        msg += '카드 승인번호 : ' + rsp.apply_num;
			        msg += '상점 거래ID : ' + rsp.merchant_uid;
			        
			        $.ajax({
			        	  url : "/shopping/order"
			        	, type : "post"
			        	, data : {
			        		 	  orderATTN : oName
					        	, orderPhone : oPhone
					        	, address1 : oPost
					        	, address2 : oAddress2
					        	, address3 : oAddress3
					        	, amount: rsp.paid_amount
			        	}
			        	, success : function(result){
			        		if(result == 'y') {
			        			location.herf = "/";
			        		}
			        	}
			        });
			        
			    } else {
			    	 var msg = '결제에 실패하였습니다.';
			         msg += '에러내용 : ' + rsp.error_msg;
			    }
			    alert(msg);
			});
		}
	});
});
</script>
</head>
<body>
	<header>
		<jsp:include page="../template/header.jsp"/>
	</header>
	<main id="cart_content">
		<div id="cart_select_div">
			<div id="cart_all_check">
				<input type="checkbox" id="all_check"><label for="all_check">전체 선택</label>
			</div>
			<div id="delete_btn">
				<button type="button" id="select_delete_btn">선택 물품 삭제</button>
			</div>
		</div>
		<div id="empty_cartList">
			<c:if test="${empty cartList[0].cartNum }">
				${noCart }
			</c:if>
		</div>
		<ul id="cart_ul">
		<c:set var="sum" value="0"/>
		<c:forEach items="${cartList }" var="cartList">
			<li id="cart_li">
				<div id="cart_check_box">
					<input type="checkbox" name="check_box" class="check_box" data-cart_num="${cartList.cartNum }">
				</div>
				<div id="product_img"><a class="product" href="/shopping/productView?n=${cartList.productNum }" class="product_img"><img src="${cartList.productImg }"></a></div>
				<div id="product_info">
					<p id="cart_p">
						<span class="product_name">상품명: ${cartList.productTitle }</span>
						<span>가격: <fmt:formatNumber pattern="###,###,###" value="${cartList.productPrice }"/></span>
						<span>수량: <fmt:formatNumber pattern="###,###,###" value="${cartList.productQty }"/></span>
						<span>합계 금액: <fmt:formatNumber pattern="###,###,###" value="${cartList.productPrice * cartList.productQty }"/></span>
					</p>
					<div id="cart_delete">
						<button type="button" class="cart_delete_btn" data-cart_num="${cartList.cartNum }">삭제</button>
					</div>
				</div>
			</li>
			
		<c:set var="sum" value="${sum + (cartList.productPrice * cartList.productQty) }"/>
		</c:forEach>
		</ul>
	<div id="cart_order_div">
		<div id="cart_sum">
			장바구니 합계 : <fmt:formatNumber pattern="###,###,###" value="${sum }"/>원
		</div>
		<div id="cart_order_btn">
			<button type="button" class="product_oder_btn">주문하러가기</button>
		</div>
	</div>
	<div id="cart_orderInfo">
			<input type="hidden" id="input_sum" name="amount" value="${sum }">
			
			<div class="cart_order_input">
				<label for="user_name"><span>주문자</span></label>
				<input type="text" name="orderATTN" id="user_name" class="td_input_sign_up">
				<div class="check_font" id="nameCheck"></div>
			</div>
									
			<div class="cart_order_input">
				<label for="cart_order_phone"><span>연락처</span></label>
				<input type="text" name="orderPhone" id="order_phone" class="td_input_sign_up">
				<div class="check_font" id="phoneCheck"></div>
			</div>
			
			<div class="cart_order_input">
				<label for="cart_order_phone"><span>이메일</span></label>
				<input type="text" name="orderEmail" id="order_email" class="td_input_sign_up">
				<div class="check_font" id="phoneCheck"></div>
			</div>
			
			<div class="cart_order_input">
				<label for=cart_address1><span>우편번호</span></label>
				<input type="text" name="address1" id="userAddress1" class="td_input_sign_up" readonly class='box'>
				<input id="Addr_btn" type="button" value="주소 검색" onclick="findAddr()">
				<div class="check_font" id="Addr1Check"></div>
			</div>
				
			<div class="cart_order_input">
				<label for="cart_address2"><span>주소</span></label>
				<input type="text" name="address2" id="userAddress2" class="td_input_sign_up" placeholder="주소를 입력" readonly class='box' />
			</div>
				
			<div class="cart_order_input">
				<label for="cart_address3"><span>상세주소</span></label>
				<input type="text" name="address3" id="userAddress3" class="td_input_sign_up" placeholder="상세 주소를 입력하세요">
				<div class="check_font" id="Addr3Check"></div>
			</div>
				
			<div class="cart_order_input">
				<input type="button" class="cart_cancel_btn" value="결제하기" id="signFrm">
				<button type="button" class="cart_cancel_btn" >취소</button> 
			</div>
		<!-- </form> -->
			<div id="cart_txt">
				<span>표시는 필수적으로 입력해주셔야 <p id="cart_sp">주문</p>이 가능합니다.</span>
			</div>
	</div>
	</main>
	<footer>
		<jsp:include page="../template/footer.jsp"/>
	</footer>
</body>
</html>
