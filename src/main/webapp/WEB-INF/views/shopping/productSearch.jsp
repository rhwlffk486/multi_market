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


	});
	console.log('${product}');
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
				<a href="/shopping/productSearch?searchType=${searchType}&keyWord=${keyWord }&orderBy=desc" class="product_sort">최신순 | </a>
				<a href="/shopping/productSearch?searchType=${searchType}&keyWord=${keyWord }&orderBy=priceAsc" class="product_sort">낮은 가격 | </a>
				<a href="/shopping/productSearch?searchType=${searchType}&keyWord=${keyWord }&orderBy=priceDesc" class="product_sort">높은가격</a>
			</div>
		</div>
		<div id="product_container">
			<div id="product_CP">
				<c:forEach var="product" items="${product }">
						
						<div class="product_column">
							<a class="product" href="/shopping/productView?n=${product.productNum }" class="product_img">
								<img alt="img" src="${product.productImg }">
							<div class="product_content">
								"${product.role }제품"<h4 class="product_h4">${product.productTitle }</h4>
								<p class="product_p">
									<strong class="product_st">${product.productPrice }</strong>원
								</p>
							</div>
							</a>
						</div>
					
					</c:forEach>
					
			</div>
				<c:if test="${empty product }">
					<div>등록된 상품이 없습니다.</div>
				</c:if>
			</div>
		
		<div id="page_div">
			<ul>
				<c:if test="${pageMaker.prev}">
					<li><a href="/shopping/productSearch?num=${pageMaker.makeQuery(pageMaker.startPage - 1)}">이전</a></li>
				</c:if>

				<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="num">
					<c:if test="${select != num}">
						<a href="/shopping/productSearch?searchType=${searchType }&keyWorld=${keyWorld}&${pageMaker.makeQuery(num)}&orderBy=${orderBy}">${num}</a>
					</c:if>    
					
					<c:if test="${select == num}">
						<b>${num}</b>
					</c:if>
				</c:forEach>

				<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
					<li><a href="/shopping/productSearch?num=${pageMaker.makeQuery(pageMaker.endPage + 1)}">다음</a></li>
				</c:if>
			</ul>
		</div>
	</main>
</body>
<footer>
		<jsp:include page="../template/footer.jsp"/>
</footer>
</html>