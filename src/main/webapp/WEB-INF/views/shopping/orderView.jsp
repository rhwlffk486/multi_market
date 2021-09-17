<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="/resources/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="/resources/css/shopping/orderView.css">
<title>주문 상세 보기</title>
</head>
<script type="text/javascript">
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
	
	$("#select_refund_btn").click(function(){
		var refundConfirm = confirm("정말 환불 하시겠습니까?");

		if(refundConfirm) {
			var param = [];
			$(".check_box:checked").each(function(i){
			
				var data = {
						  productNum : $(this).attr("data-cart_num")
					    , orderID : $('#order_ID').attr("value")
						, productInfo : $('#select_refund_btn').attr("value")
				}
				
				param.push(data);
			});
				var jsonData = JSON.stringify(param);
			    jQuery.ajaxSettings.traditional = true;
			
			$.ajax({
				  url : "/shopping/refundPlz"
				, type : "post"
				, dataType: "json"
				, data : {
					"jsonData" : jsonData
				}
				, success : function(result) {
					if (result == 1) {
						alert("환불 요청 완료");
						window.opener.location.reload();
					    window.close();
					} else {
						alert("환불할 상품을 선택해주세요!");
					}
				}
			});
		}
	});

});
</script>
<body>
	<div class="orderView_div">
		<c:forEach items="${orderViewVO }" var="orderViewVO">
			<c:set var="productInfo" value="${orderViewVO.productInfo}"/>
			<c:if test="${productInfo eq '배송완료'}">
				<div id="cart_check_box">
					<input type="checkbox" class="check_box" data-cart_num="${orderViewVO.productNum }"><label for="check_box">환불</label>
				</div>
			</c:if>
			<div class="orderView_left"><a class="product" onclick="window.open('/shopping/productView?n=${orderViewVO.productNum }', '_blank', 
		                     		'top=140, left=300, width=1400, height=1280, menubar=no, toolbar=no, location=no, directories=no, status=no, scrollbars=no, copyhistory=no, resizable=no');"><img src="${orderViewVO.productImg }"></a></div>
			<div class="orderView_right">
				<input type="hidden" id="product_qty" value="${orderViewVO.productQty }">
				<input type="hidden" id="order_ID" value="${orderViewVO.orderID }">
				<div><span>주문 날짜: </span><fmt:formatDate value="${orderViewVO.orderDate }" pattern="yyyy-MM-dd"/></div>
				<div><span>상품명: </span>${orderViewVO.productTitle }</div>
				<div><span>수량: </span><fmt:formatNumber pattern="###,###,###" value="${orderViewVO.productQty }"/>개</div>
				<div><span>가격: </span><fmt:formatNumber pattern="###,###,###" value="${orderViewVO.productPrice }"/>원</div>
			</div>
		</c:forEach>
			<c:if test="${productInfo eq '배송완료'}">
				<div id="cart_all_check">
					<input type="checkbox" id="all_check"><label for="all_check">전체 선택</label>
				</div>
				<div id="delete_btn">
					<button type="button" id="select_refund_btn" value="환불요청">환불요청</button>
				</div>
			</c:if>
	</div>
</body>
</html>