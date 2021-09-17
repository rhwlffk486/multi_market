<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="/resources/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="/resources/css/shopping/productView.css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script type="text/javascript">
$(function() {
	$("#plus").click(function(){
		   var num = $(".num_box").val();
		   var plusNum = Number(num) + 1;
		   
		   if(plusNum >= ${viewVO.productQty}) {
		    $(".num_box").val(num);
		   } else {
		    $(".num_box").val(plusNum);          
		   }
		  });
		  
	$("#minus").click(function(){
		   var num = $(".num_box").val();
		   var minusNum = Number(num) - 1;
		   
		   if(minusNum <= 0) {
		    $(".num_box").val(num);
		   } else {
		    $(".num_box").val(minusNum);          
		   }
	});
	
	getReplyList();
	
	$(".modal_modify_btn").click(function(){
		var modifyConfirm = confirm("수정하시겠습니까?");
		
		if(modifyConfirm) {
			var data = {
					  repNum : $(this).attr("data-num")
					, repCon : $(".modal_repCon").val()
			};
			
			$.ajax({
				  url : "/shopping/modifyReply"
				, type : "post"
				, data : data
				, success : function(data) {
					if(data == 1) {
						getReplyList();
						$(".replyModal").fadeOut(200);
					}
				}
			});
		}
	});
	
	 /* cartに商品追加 */
	 $("#add_cart_btn").click(function(){
		 
		 var addCart = confirm("카트에 담으시겠습니까?");
		 if(addCart) {
			 if ("${userID}" == "로그인") {
			 alert("로그인을 해주세요.");
		 } else {
			 
			var productNum = $("#product_num").val(); 
			var productQty = $("#num_box").val();
			var userID = '${userID}';
			
			var data = {
					  productNum : productNum
					, productQty : productQty 
					, userID : userID
			};
			
			$.ajax({
				  url : "/shopping/addCart"
				, type : "post"
				, data : data
				, success : function(result){
					
					if(result == 1) {
						alert("카트 추가 완료");
						$("#num_box").val("1");
					} else {
						alert("로그인을 해주세요.");
						$("#num_box").val("1");
					}
				}
				, error : function(){
					alert("카트 추가 실패");
				}
			});
		 }
	 }
	 });
});
function getReplyList() {
		var productNum = ${viewVO.productNum};
	 $.ajax({
		      url: "/shopping/getReplyList"
		    , data: {"productNum" : productNum}
		    , type: "GET"
		    , dataType : "json"
		    , success: function (data) {
		    	var html = "";
		    	var cCnt = data.length;
		    	
		    	if (data.length > 0) {
		    		
		    		for (i=0; i<data.length; i++) {
		    			html += "<li>";
		    			html += "<div id='user_info'>";
		    			html += "<span id='view_user_id'>"+data[i].userID+"</span>";
		    			html += "<span id='date'>"+data[i].repDate+"</span>";
		    			html += "</div>";
		    			html += "<div id='reply_content'>"+data[i].repCon+"</div>";

		    			if ('${userID}' == data[i].userID) {
		    				html += "<div id='reply_UD'>";
		    				html += "<button type='button' class='modify rep_btn' data-num='"+data[i].repNum+"'>수정</button>";
		    				html += "<button type='button' class='delete rep_btn' data-num='"+data[i].repNum+"'>삭제</button>";
		    				html += "</div>";
		    			}
		    			
		    			html += "</li>";
		    			
		    			} 
		    		
			    		if (data.length > 9) {
			    			html += "<div id='addBtn_div'><button id='addBtn' onclick='moreList();'>더보기</button></div>"		
		    			}
			    		
		    		} else {
						html += "<div>";
						html += "<div id='user_info'><h6><strong>등록된 댓글이 없습니다.</strong></h6></div>";
						html += "</div>";
		    		}
		    		
		    		$("#replyList").html(html);
		    	}
	
	 });
	 $(".modal_cancel").click(function(){

		 $(".replyModal").fadeOut(200);
	 });
}

$(document).on("click", ".delete", function(){
	
	var deleteConfirm = confirm("정말로 삭제하시겠습니까?");
	
	if (deleteConfirm) {
	
	var data = {
			repNum : $(this).attr("data-num")
	};
	console.log(data);
	$.ajax({
			  url: "/shopping/deleteReply"
			, type: "post"
			, data: data
			, success: function(data) {
				if (data == 1) {
				alert("삭제되었습니다.");
				getReplyList();
				}
			}
	});
	}
});
	
function replyUp() {
	var reply = $("#reply_form").serialize();
	$.ajax({
		  type: "post"
		, url: "/shopping/productReply"
		, data: reply
		, success: function(data) {
			if(data=="success") {
				alert("등록완료");
				$("#rep_con").val("");
				getReplyList();
			} else {
				alert("실패");
			}
		}
	});
};

$(document).on("click", ".modify", function(){
	 $(".replyModal").fadeIn(200);
	 
	 var repNum = $(this).attr("data-num");
	 var repCon = $(this).parent().parent().children("#reply_content").text();
	
	 $(".modal_repCon").val(repCon);
	 $(".modal_modify_btn").attr("data-num", repNum);
});


</script>
<body>

	<header>
		<jsp:include page="../template/header.jsp" />
	</header>
	<div id="container">
		<form role="form" method="post">
			<input type="hidden" name="productNum" id="product_num" value="${viewVO.productNum}" />
		</form>
		<div id="view_detail">
			<div id="left_col">
				<img id="view_img" alt="img" src="${viewVO.productImg }">
			</div>
			<div id="right_col">
				<div>
					<h1 id="view_title">${viewVO.productTitle }</h1>
				</div>
				<div class="view price" id="view_price"><fmt:formatNumber pattern="###,###,###" value="${viewVO.productPrice }" />원</div>
				<c:if test="${viewVO.productQty > 0 }">
					<div class="view qty">재고:<fmt:formatNumber pattern="###,###,###" value="${viewVO.productQty}" />개</div>
				</c:if>
				<div class="view seller">판매자: ${viewVO.productID }</div>
				
				<c:if test="${viewVO.productQty > 0 }">
				<div>
					<span>구입 수량</span>
					<button type="button" id="plus" class="pm">+</button>
					<input type="number" id="num_box" class="num_box" min="1"
						max="${viewVO.productQty }" value="1" readonly="readonly" />
					<button type="button" id="minus" class="pm">-</button>
				</div>
				<p class="add_cart">
					<button type="button" id="add_cart_btn">카트에 담기</button>
				</p>
				</c:if>
				<c:if test="${viewVO.productQty < 0 }">
					<p>상품 수량이 부족합니다.</p>
				</c:if>
			</div>
		</div>
		<hr>
		<div id="product_content">
			${viewVO.productContent } 
		</div>
		<hr>
		<div id="reply">
			
			<c:if test="${empty userVO.userID }">
				<p>댓글 작성은<a href="/" id="view_login"> 로그인 </a>해주세요.</p>
			</c:if>
			
			<c:if test="${not empty userVO.userID }">
				<section class="replyForm">
					 <form id="reply_form" name="replyForm" method="post">
						<input type="hidden" name="productNum" value="${viewVO.productNum }">
					
						<div id="view_reply">
							<textarea name="repCon" id="rep_con"></textarea>
						</div>
						
						<div id="input_reply">
							<button type="button" onclick="replyUp();" id="reply_btn">댓글 작성</button>
						</div>
					</form>
				</section>
			</c:if>
			<hr>
			<section id="reply_list">
				<ol id="replyList">
					
				</ol>
			</section>
			<%-- <c:if test="${reply.size() >= 9 }">
				<div id="addBtn_div">
					<button id="addBtn" onclick="moreList();">더보기</button>
				</div>
			</c:if> --%>
					<script type="text/javascript">
						function moreList() {
							var productNum = ${viewVO.productNum};
						 	var startNum = $("#reply_list li").length;
						    var html = "";  
						    $.ajax({
						    	  url: "/shopping/replyMore"
							    , data: {
							    		  "productNum" : productNum
							    		, "startNum" : startNum
							    	}
							    , type: "GET"
							    , dataType : "json"
						        , success : function(data) {
						        	if(data.length < 10){
						                $("#addBtn").remove();
						            }
						        	
						        	if(data.length > 0){
						        		for (i=0; i<data.length; i++) {
							    			html += "<li>";
							    			html += "<div id='user_info'>";
							    			html += "<span id='view_user_id'>"+data[i].userID+"</span>";
							    			html += "<span id='date'>"+data[i].repDate+"</span>";
							    			html += "</div>";
							    			html += "<div id='reply_content'>"+data[i].repCon+"</div>";
							    			if ('${userID}' == data[i].userID) {
							    				html += "<div id='reply_UD'>";
							    				html += "<button type='button' class='modify rep_btn' data-num='"+data[i].repNum+"'>수정</button>";
							    				html += "<button type='button' class='delete rep_btn' data-num='"+data[i].repNum+"'>삭제</button>";
							    				html += "</div>";
							    			}
							    			html += "</li>";
							    		} 
						                $("#reply_list li:last").after(html);
						            }
						        }
						    });
						}
					</script>
		</div>
	</div>

	<div class="replyModal">
 		<div class="modalContent">
			<div>
				<textarea class="modal_repCon" name="modal_repCon"></textarea>
			</div>
	 		<div id="reply_up">
			   <button type="button" class="modal_modify_btn">수정</button>
			   <button type="button" class="modal_cancel">취소</button>
	 		</div>
 		</div>
 		<div class="modalBackground"></div>
	</div>
	<footer>
		<jsp:include page="../template/footer.jsp"/>
	</footer>
</body>
</html>