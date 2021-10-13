<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="/resources/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="/resources/css/shopping/product.css">
<title>shopping</title>
</head>
<script type="text/javascript">


$(function(){
	$("#product_used").on("click", function(){
		$("#product_CP").css("display", "none");
		$("#product_US").css("display", "grid");
		$("#product_used").css("display", "none");
		$("#product_company").css("display", "inline-block");
	});

	$("#product_company").on("click", function(){
		$("#product_CP").css("display", "grid");
		$("#product_US").css("display", "none");
		$("#product_used").css("display", "inline-block");
		$("#product_company").css("display", "none");
	});
});

</script>
<body>
	<header>
		<jsp:include page="../template/header.jsp" />
	</header>
	<main>
		<div id="main_header">
			<div id="product_sort">
				<a href="/shopping/product?name=${name}&orderBy=desc" class="product_sort">최신순 | </a>
				<a href="/shopping/product?name=${name}&orderBy=priceAsc" class="product_sort">낮은 가격 | </a>
				<a href="/shopping/product?name=${name}&orderBy=priceDesc" class="product_sort">높은가격</a>
			</div>
		
		<div id="product_container">
			<div id="product_CP">
				<c:forEach var="product" items="${product }">
					<c:set var="role" value="${product.role }"/>
						<input type="hidden" value="<c:out value="${product.role }"/>">
						<div class="product_column">
							<a class="product" href="/shopping/productView?n=${product.productNum }" class="product_img">
								<img alt="img" src="${product.productImg }">
							<div class="product_content">
							<c:if var="rolew" test="${role eq '중고' }">"${product.role }제품"</c:if>
								<h4 class="product_h4">${product.productTitle }</h4>
								<p class="product_p">
								<strong class="product_st"><fmt:formatNumber pattern="###,###,###" value="${product.productPrice }"/></strong>원
								</p>
							</div>
							</a>
						</div>
				</c:forEach>
			</div>
		</div>
				<c:if test="${empty product }">
					<div>등록된 상품이 없습니다.</div>
				</c:if>
		<div id="page_div">
			<ul>
				<c:if test="${pageMaker.prev}">
					<li><a href="product?name=${name }${pageMaker.makeQuery(pageMaker.startPage - 1)}">이전</a></li>
				</c:if>

				<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
					<li><a href="product?name=${name }${pageMaker.makeQuery(idx)}&orderBy=${orderBy}">${idx}</a></li>
				</c:forEach>
				
				<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
					<li><a href="product?name=${name }${pageMaker.makeQuery(pageMaker.endPage + 1)}">다음</a></li>
				</c:if>
			</ul>
		</div>
		</div>
	</main>
	<footer>
		<jsp:include page="../template/footer.jsp"/>
	</footer>
</body>

</html>