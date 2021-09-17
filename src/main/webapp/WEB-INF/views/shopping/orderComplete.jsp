<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/resources/css/shopping/orderComplete.css">
<title>Insert title here</title>
</head>
<body>
	<header>
		<jsp:include page="../template/header.jsp" />
	</header>
	<main id="content">
		<div class="MGR_sold_div">
			<div class="MGR_sale_div"><h2 class="MGR_sale">배송 준비 상품</h2></div>
			<ul id="orderList">
				<c:forEach items="${orderList}" var="orderList">
				<c:set var="delivery" value="${orderList.productInfo}"/>
					<c:if test="${delivery eq '배송준비' or delivery eq '배송 중'}">
						<li>
							<div>
								<span>주문번호</span>
									<a onclick="window.open('/shopping/orderView?n=${orderList.orderID}&productInfo=${delivery }', '_blank', 
		                     		'top=140, left=300, width=750, height=700, menubar=no, toolbar=no, location=no, directories=no, status=no, scrollbars=no, copyhistory=no, resizable=no');"
									href="javascript:void(0);"> ${orderList.orderID}</a>
								
								<p><span>수령인</span>${orderList.orderATTN}</p>
								<p><span>주소</span>(${orderList.address1}) ${orderList.address2}${orderList.address3}</p>
								<p><span>가격</span><fmt:formatNumber pattern="###,###,###" value="${orderList.amount}" />원</p>
							</div>
								<h3 class="orderComplete_h3">${orderList.productInfo}</h3>
						</li>
					</c:if>
				</c:forEach>
			</ul>
		</div>	
							
		<div class="MGR_sold_div">
			<div class="MGR_sale_div"><h2 class="MGR_sale">배송 완료 상품</h2></div>
			<ul id="orderList">
			<c:forEach items="${orderList}" var="orderList">
			<c:set var="delivery" value="${orderList.productInfo}"/>
				<c:if test="${delivery eq '배송완료'}">
					<li>
						<div>
							<span>주문번호</span>
								<a onclick="window.open('/shopping/orderView?n=${orderList.orderID}&productInfo=${delivery }', '_blank', 
	                     		'top=140, left=300, width=750, height=700, menubar=no, toolbar=no, location=no, directories=no, status=no, scrollbars=no, copyhistory=no, resizable=no');"
								href="javascript:void(0);"> ${orderList.orderID}</a>
							
							<p><span>수령인</span>${orderList.orderATTN}</p>
							<p><span>주소</span>(${orderList.address1}) ${orderList.address2}${orderList.address3}</p>
							<p><span>가격</span><fmt:formatNumber pattern="###,###,###" value="${orderList.amount}" />원</p>
						</div>
							<h3 class="orderComplete_h3">${orderList.productInfo}</h3>
					</li>
				</c:if>
			</c:forEach>
			</ul>
		</div>
		
		<div class="MGR_sold_div">
			<div class="MGR_sale_div"><h2 class="MGR_sale">환불 요청 상품</h2></div>
			<ul id="orderList">
			<c:forEach items="${orderList}" var="refundOrderList">
			<c:set var="productInfo" value="${refundOrderList.productInfo}"/>
				<c:if test="${productInfo eq '환불요청' or productInfo eq '환불완료'}">
					<li>
						<div>
							<span>주문번호</span>
								<a onclick="window.open('/shopping/orderView?n=${refundOrderList.orderID}&productInfo=${productInfo }', '_blank', 
	                     		'top=140, left=300, width=750, height=700, menubar=no, toolbar=no, location=no, directories=no, status=no, scrollbars=no, copyhistory=no, resizable=no');"
								href="javascript:void(0);"> ${refundOrderList.orderID}</a>
							
							<p><span>수령인</span>${refundOrderList.orderATTN}</p>
							<p><span>주소</span>(${refundOrderList.address1}) ${refundOrderList.address2}${refundOrderList.address3}</p>
							<p><span>가격</span><fmt:formatNumber pattern="###,###,###" value="${refundOrderList.amount}" />원</p>
						</div>
							<h3 class="orderComplete_h3">${refundOrderList.productInfo}</h3>
					</li>
				</c:if>
			</c:forEach>
			</ul>
		</div>
	</main>
	<footer>
		<jsp:include page="../template/footer.jsp"/>
	</footer>
</body>
</html>