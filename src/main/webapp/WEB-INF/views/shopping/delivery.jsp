<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/resources/css/shopping/orderView.css">
<script type="text/javascript" src="/resources/jquery-3.6.0.min.js"></script>
<title>Insert title here</title>
</head>
<script type="text/javascript">
$(function(){
	$("#select_refund_btn").click(function(){
		var refundConfirm = confirm("정말 환불 하시겠습니까?");
		if(refundConfirm) {
			var param = [];
			/* $(".check_box:checked").each(function(i){
				
				var data = {						
						  productNum : $(this).attr("data-product")
						, orderID : $('.order_ID').attr("value")
						, refund : $('#select_refund_btn').attr("value")
				}
				
				param.push(data);
			}); */
			
			$(".orderView_div").each(function(){
				
				var data = {						
						  productNum : $('.product_num').val()
						, productQty : $('.product_qty').val()
						, orderID : $('.order_ID').attr("value")
						, refund : $('#select_refund_btn').attr("value")
				}
				
				param.push(data);
			});
				var jsonData = JSON.stringify(param);
			    jQuery.ajaxSettings.traditional = true;
			
			$.ajax({
				  url : "/shopping/refund"
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
						alert("로그인을 해주세요.");
					}
				}
			});
		}
	});
});

</script>
<body>
	<div id="refund_div">
		<c:forEach items="${orderDelivery }" var="orderDelivery">
			<div class="orderView_div">
				<input type="hidden" class="product_num" value="${orderDelivery.productNum }">
				<input type="hidden" class="product_qty" value="${orderDelivery.productQty }">
				<input type="hidden" class="order_ID" value="${orderDelivery.orderID }">
				<input type="hidden" data-product_refund="환불완료">
				<input type="checkbox" class="check_box" style="display:none" checked="checked" data-product="${orderDelivery.productNum },${orderDelivery.productQty }">
				
				<div class="orderView_left"><img src="${orderDelivery.productImg }"></div>
				<div class="orderView_right">
					<div><span>상품명: </span>${orderDelivery.productTitle }</div>
					<div><span>주문 ID: </span>${orderDelivery.orderID }</div>
					<div><span>수량: </span><fmt:formatNumber pattern="###,###,###" value="${orderDelivery.productQty }"/>개</div>
					<div><span>개당 금액: </span><fmt:formatNumber pattern="###,###,###"  value="${orderDelivery.productPrice }"/>원</div>
				</div>
				<c:set var="sum" value="${sum + (orderDelivery.productPrice * orderDelivery.productQty) }"/>
				<c:set var="order_ID" value="${orderDelivery.orderID}"/>	
			</div>
			<c:set var="productInfo" value="${orderDelivery.productInfo }"></c:set>
		</c:forEach>
	</div>
			<div id="sum_cash"><span>합계 금액: </span><fmt:formatNumber pattern="###,###,###" value="${sum }"/>원</div>
		<c:if test="${productInfo eq '환불요청' }">		
			<div id="delete_btn">
				<button type="button" id="select_refund_btn" value="환불완료">환불완료</button>
			</div>
		</c:if>
</body>
</html>