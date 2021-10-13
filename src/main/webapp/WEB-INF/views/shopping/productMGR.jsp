<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="/resources/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="/resources/css/shopping/productMGR.css">
<title>shopping</title>
<script type="text/javascript">
$(function() {
	$(".MGR_table").slice(0, 6).show();
	if("${result3 }" == 5) {
		alert("물품 삭제에 성공했습니다.");
	}
	
	if("${result4 }" == 2) {
		alert("물품 삭제에 실패했습니다.");
	}
	
	$(".delivery1_btn").click(function(){
	    $(".delivery").val("배송 중");
	    run();
	   });
	   
	$(".delivery2_btn").click(function(){
		$(".delivery").val("배송완료");
		run();
	});
	
	if("${productUpload }" == 2) {
		alert("물품 등록에 실패했습니다.");
	}
	   
	function run(){
		$(".deliveryForm").submit();
	}

	 $(".MGR_table").on("click", ".product_delete", function() {
			var con = confirm("정말로 삭제하시겠습니까?");
			var n = $(this).val();
			
			if(con) {
				$.ajax({
					  url : "/shopping/productDelete"
					, type : "GET"
					, data : {"n" : n}
					, success : function(result){
						if (result == "success") {
							alert("상품을 삭제했습니다.");
							location.href="/shopping/productMGR";
						} else {
							alert("상품삭제에 실패했습니다.");
							location.href="/shopping/productMGR";
						}
					} 
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
	<main>
		<div id="MGR_div">
			<div id="MGR_update">
				<h2 id="MGR_product_up"><a href="/shopping/productUpload">상품 등록</a></h2>
			</div>
			<div id="MGR_sale">
			<c:if test="${not empty myProduct }">
				<div class="MGR_sale_div"><h2 class="MGR_sale">판매 중인 ${myProduct.get(0).role } 상품</h2></div>
					<table class="MGR_table">
						<tbody>
							<tr>
								<th class="MGR_th">상품번호</th>
								<td class="MGR_td1"><h4>등록일</h4></td>
								<td class="MGR_td2"><h4>상품 이미지</h4></td>
								<td id="MGR_td2"><h4>제목</h4></td>
								<td class="MGR_td3"><h4>재고</h4></td>
								<td class="MGR_td3"><h4>가격</h4></td>
								<td id="MGR_td4"><h4>수정/삭제</h4></td>
							</tr>
							<c:forEach var="myProduct" items="${myProduct }">
							<tr>
								<th><h3>${myProduct.productNum }</h3></th>
								<th><h5><fmt:formatDate value="${myProduct.productDate }" pattern="yyyy-MM-dd"/></h5></th>
								<td><img alt="img" src="${myProduct.productImg }"></td>
								<td><h5><a href="/shopping/productView?n=${myProduct.productNum }" class="MGR_menu_link">${myProduct.productTitle }</a></h5></td>
								<td class="MGR_info"><h5><fmt:formatNumber pattern="###,###,###" value="${myProduct.productQty }"/>개</h5></td>
								<td class="MGR_info"><h5><fmt:formatNumber pattern="###,###,###" value="${myProduct.productPrice }"/>원</h5></td>
								<td><a href="/shopping/myProductView?n=${myProduct.productNum }" class="product_modi"><span>수정</span></a>
								<button type="button" value="${myProduct.productNum }" class="product_delete">삭제</button></td>
							</tr>
							</c:forEach>
						</tbody>
					</table>
					<c:if test="${myProduct.size() > 4 }">
						<div id="addBtn_div">
							<button id="addBtn" onclick="moreList();">더보기</button>
						</div>
					</c:if>
			</c:if>		
					<script type="text/javascript">
						function moreList() {
						 	var startNum = $(".MGR_table tr").length;
						    var addListHtml = "";  
						    
						    $.ajax({
						          url : "/shopping/myProductMore"
						        , type : "post"
						        , dataType : "json"
						        , data : {
						        		"startNum" : startNum
						        		}
						        , success : function(data) {
						        	if(data.length < 5){
						                $("#addBtn").remove();
						            }
						        	
						        	if(data.length > 0){
						                for(var i=0; i<data.length; i++) {
						                	var qty = data[i].productQty.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
						                	var price = data[i].productPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
						                	
						                    addListHtml += "<tr>";
						                    addListHtml += "<th><h3>"+ data[i].productNum + "</h3></th>";
						                    addListHtml += "<th><h5>"+ data[i].productDate +"</h5></th>";
				                    		addListHtml += "<td><img alt='img' src='"+data[i].productImg+"'</td>";
			                    			addListHtml += "<td><h5><a href='/shopping/productView?n="+ data[i].productNum +"' class='MGR_menu_link'>"+data[i].productTitle+"</a></h5></td>";
			                    			addListHtml += "<td class='MGR_info'><h5>"+ qty +"개</h5></td>";
			                    			addListHtml += "<td class='MGR_info'><h5>"+ price +"원</h5></td>";
			                    			addListHtml += "<td><a href='/shopping/myProductView?n="+ data[i].productNum +"' class='product_modi'><span>수정</span></a>";
			                    			addListHtml += " <button type='button' value='"+data[i].productNum+"' class='product_delete'>삭제</button></td>";
			                    			addListHtml += "</tr>";
						                }
						                $(".MGR_table tr:last").after(addListHtml);
						            }
						        }
						    });
						}
					</script>
				<div id="MGR_sold_div">
					<c:if test="${not empty myProduct }">
						<div class="MGR_sale_div"><h2 class="MGR_sale">배송 해야할 ${myProduct.get(0).role } 상품</h2></div>
					</c:if>	
					<ul id="orderList">
						<c:forEach items="${OrderComesList}" var="OrderComesList">
						<c:set var="delivery" value="${OrderComesList.productInfo}"/>
							<c:if test="${delivery eq '배송준비' or delivery eq '배송 중' or delivery eq null}">
								<li>
									<div>
										<div id="MGR_left">
											<div>주문번호</div>
											<div>날짜</div>
											<div>수령인</div>
											<div>주소</div>
										</div>
										<div id="MGR_right">
											<div><a onclick="window.open('/shopping/delivery?orderID=${OrderComesList.orderID}&productInfo=${delivery }', '_blank', 
				                     		'top=140, left=300, width=750, height=700, menubar=no, toolbar=no, location=no, directories=no, status=no, scrollbars=no, copyhistory=no, resizable=no');"
											href="javascript:void(0);"> ${OrderComesList.orderID}</a></div>
											<div><fmt:formatDate value="${OrderComesList.orderDate }" pattern="yyyy-MM-dd"/></div>
											<div>${OrderComesList.orderATTN}</div>
											<div id="MGR_num">우편번호 : (${OrderComesList.address1}) ${OrderComesList.address2}${OrderComesList.address3}</div>
										</div>
										
										<div>
										<form action="/shopping/deliveryInfo" method="post" class="deliveryForm">
											<input type="hidden" name="orderID" id="order_ID" value="${OrderComesList.orderID}" />
											<input type="hidden" name="delivery" class="delivery" value="" />
											<div><h3 id="deli_id">${OrderComesList.productInfo}</h3></div>
											<div id="MGR_dv_btn_div"><span class="MGR_dv_btn"><input type="submit" class="delivery1_btn" value="배송중">
											<span class="MGR_dv_btn"><input type="submit" class="delivery2_btn" value="배송완료"></span></span></div>
										</form>
										</div>
									</div>
								</li>
							</c:if>
						</c:forEach>
					</ul>
					</div>	
							
					<div id="MGR_sold_div">
						<c:if test="${not empty myProduct }">
							<div class="MGR_sale_div"><h2 class="MGR_sale">배송 완료된 ${myProduct.get(0).role } 상품</h2></div>
						</c:if>
						<ul id="orderList">
						<c:forEach items="${OrderComesList}" var="OrderComesList">
						<c:set var="delivery" value="${OrderComesList.productInfo}"/>
							<c:if test="${delivery eq '배송완료'}">
									<li>
										<div>
											<div id="MGR_left">
												<div>주문번호</div>
												<div>날짜</div>
												<div>수령인</div>
												<div>주소</div>
											</div>
											<div id="MGR_right">
												<div><a onclick="window.open('/shopping/delivery?orderID=${OrderComesList.orderID}&productInfo=${delivery }', '_blank', 
					                     		'top=140, left=300, width=750, height=700, menubar=no, toolbar=no, location=no, directories=no, status=no, scrollbars=no, copyhistory=no, resizable=no');"
												href="javascript:void(0);"> ${OrderComesList.orderID}</a></div>
												<div><fmt:formatDate value="${OrderComesList.orderDate }" pattern="yyyy-MM-dd"/></div>
												<div>${OrderComesList.orderATTN}</div>
												<div id="MGR_num">우편번호 : (${OrderComesList.address1}) ${OrderComesList.address2}${OrderComesList.address3}</div>
											</div>
											
											<div>
													<div><h3 id="deli_id">${OrderComesList.productInfo}</h3></div>
											</div>
										</div>
									</li>
							</c:if>
						</c:forEach>
						</ul>
					</div>
					
					<div id="MGR_sold_div">
						<c:if test="${not empty myProduct }">
							<div class="MGR_sale_div"><h2 class="MGR_sale">환불 요청/완료 상품</h2></div>
						</c:if>
						<ul id="orderList">
						<c:forEach items="${OrderComesList}" var="OrderComesList">
						<c:set var="delivery" value="${OrderComesList.productInfo}"/>
							<c:if test="${delivery eq '환불요청' or delivery eq '환불완료'}">
								<li>
									<div>
										<div id="MGR_left">
											<div>주문번호</div>
											<div>날짜</div>
											<div>수령인</div>
											<div>주소</div>
										</div>
										<div id="MGR_right">
											<div><a onclick="window.open('/shopping/delivery?orderID=${OrderComesList.orderID}&productInfo=${delivery }', '_blank', 
				                     		'top=140, left=300, width=750, height=700, menubar=no, toolbar=no, location=no, directories=no, status=no, scrollbars=no, copyhistory=no, resizable=no');"
											href="javascript:void(0);"> ${OrderComesList.orderID}</a></div>
											<div><fmt:formatDate value="${OrderComesList.orderDate }" pattern="yyyy-MM-dd"/></div>
											<div>${OrderComesList.orderATTN}</div>
											<div id="MGR_num">우편번호 : (${OrderComesList.address1}) ${OrderComesList.address2}${OrderComesList.address3}</div>
										</div>
										
										<div>
												<div><h3 id="deli_id">${OrderComesList.productInfo}</h3></div>
										</div>
									</div>
								</li>
							</c:if>
						</c:forEach>
						</ul>
					</div>
			</div>
		</div>
	</main>
	<footer>
		<jsp:include page="../template/footer.jsp"/>
	</footer>
</body>
</html>
