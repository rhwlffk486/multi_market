<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="/resources/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="/resources/css/shopping/uploadProduct.css">

<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
<script src="/resources/summernote/lang/summernote-ko-KR.js"></script>
<title>shopping</title>
<script type="text/javascript">
$(function() {
	var cateSelect1 = false;
	var cate_select2 = false;
	var jsonData = JSON.parse('${category}');

	var cate1Arr = new Array();
	var cate1Obj = new Object();

	// 1차 분류 셀렉트 박스에 삽입할 데이터 준비
	for (var i = 0; i < jsonData.length; i++) {

		if (jsonData[i].level == "1") {
			cate1Obj = new Object(); //초기화
			cate1Obj.cateCode = jsonData[i].cateCode;
			cate1Obj.cateName = jsonData[i].cateName;
			cate1Arr.push(cate1Obj);
		}
	}

	// 1차 분류 셀렉트 박스에 데이터 삽입
	var cate1Select = $("#category1")

	for (var i = 0; i < cate1Arr.length; i++) {
		cate1Select.append("<option value='" + cate1Arr[i].cateCode + "'>"
				+ cate1Arr[i].cateName + "</option>");
		cateSelect1 = true;
	}

	$(document).on("change", "#category1",function() {
						var cate2Arr = new Array();
						var cate2Obj = new Object();
						var select1 = $('#category1').val();
						
						if (select1 == 100) {
							$('.Uname').css('width', '360px');
							$('.Ucate3').css('display', 'inline-block');
						} else {
							$('.Uname').css('width', '483px');
							$('.Ucate3').css('display', 'none');
						}
						// 2차 분류 셀렉트 박스에 삽입할 데이터 준비
						for (var i = 0; i < jsonData.length; i++) {

							if (jsonData[i].level == "2") {
								cate2Obj = new Object(); //초기화
								cate2Obj.cateCode = jsonData[i].cateCode;
								cate2Obj.cateName = jsonData[i].cateName;
								cate2Obj.cateCodeRef = jsonData[i].cateCodeRef;
								cate2Arr.push(cate2Obj);
							}
						}

						var cate2Select = $("#category2");

						for (var i = 0; i < cate2Arr.length; i++) {
							cate2Select.append("<option value='" + cate2Arr[i].cateCode + "'>" + cate2Arr[i].cateName + "</option>");
						}
					});

$(document).on("change", "#category1", function(){

	 var cate2Arr = new Array();
	 var cate2Obj = new Object();
	 
	 // 2차 분류 셀렉트 박스에 삽입할 데이터 준비
	 for(var i = 0; i < jsonData.length; i++) {
	  
	  if(jsonData[i].level == "2") {
	   cate2Obj = new Object();  //초기화
	   cate2Obj.cateCode = jsonData[i].cateCode;
	   cate2Obj.cateName = jsonData[i].cateName;
	   cate2Obj.cateCodeRef = jsonData[i].cateCodeRef;
	   
	   cate2Arr.push(cate2Obj);
	  }
	 }
	 
	 var cate2Select = $("#category2");
	 
	 
	 cate2Select.children().remove();

	 $("option:selected", this).each(function(){
	  
	  var selectVal = $(this).val();  
	  cate2Select.append("<option value=''>전체</option>");
	  for(var i = 0; i < cate2Arr.length; i++) {
	   if(selectVal == cate2Arr[i].cateCodeRef) {
	    cate2Select.append("<option value='" + cate2Arr[i].cateCode + "'>"
	         + cate2Arr[i].cateName + "</option>");
	   }
	  }
	  
	 });
	 
	});
$(document).on("change", "#category2", function(){
	var cate3Select = $("#category3");
	var select2 = $('#category2').val();

	if (select2 == 101 || select2 == 102 || select2 == 103 || select2 == 104 || select2 == 105 || select2 == 106 || select2 == 107 || select2 == 108 || select2 == 109 ) {
		$('.Uname').css('width', '360px');
		$('#category3').css('display', 'inline-block');
		cate3Select.children().remove();
	} 
});
	var toolbar = [
			// 글꼴 설정
			[ 'fontname', [ 'fontname' ] ],
			// 글자 크기 설정
			[ 'fontsize', [ 'fontsize' ] ],
			// 굵기, 기울임꼴, 밑줄,취소 선, 서식지우기
			[
					'style',
					[ 'bold', 'italic', 'underline', 'strikethrough',
							'clear' ] ],
			// 글자색
			[ 'color', [ 'forecolor', 'color' ] ],
			// 표만들기
			[ 'table', [ 'table' ] ],
			// 글머리 기호, 번호매기기, 문단정렬
			[ 'para', [ 'ul', 'ol', 'paragraph' ] ],
			// 줄간격
			[ 'height', [ 'height' ] ],
			// 그림첨부, 링크만들기, 동영상첨부
			[ 'insert', [ 'picture', 'link', 'video' ] ],
			// 코드보기, 확대해서보기, 도움말
			[ 'view', [ 'codeview', 'fullscreen', 'help' ] ] ];

	var setting = {
			height : 300,
			minHeight : null,
			maxHeight : null,
			focus : true,
			lang : 'ko-KR',
			toolbar : toolbar,
			callbacks : { //여기 부분이 이미지를 첨부하는 부분
				onImageUpload : function(files, editor, welEditable) {
					for (var i = files.length - 1; i >= 0; i--) {
						uploadSummernoteImageFile(files[i], this);
					}
				}
			}
	};

	$('#summernote').summernote(setting);

	$("#product_price").keyup(function() {
		this.value = this.value.replace(/[^0-9]/g, '');
		this.value = this.value.replace(/,/g, '');
		this.value = this.value.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	});// product_name_price

	$("#product_qty").keyup(function() {
		this.value = this.value.replace(/[^0-9]/g, '');
		this.value = this.value.replace(/,/g, '');
		this.value = this.value.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	});// product_name_price

	$(".upload_back_btn").click(function(){
		  location.href = "/shopping/productMGR";
		 }); 
/* 	var selectCateCode = ${productVO.cateCode};
	var selectCateCodeRef = ${productVO.cateCodeRef};
	var selectCateName = ${productVO.cateName}; */

});
function uploadSummernoteImageFile(file, el) {
	data = new FormData();
	data.append("file", file);
	$.ajax({
		data : data,
		type : "POST",
		url : "/shopping/uploadSummernoteImageFile",
		contentType : false,
		enctype : 'multipart/form-data',
		processData : false,
		success : function(data) {
			$(el).summernote('editor.insertImage', data.url);
		}
	});
}

function formOnclick() {
	var productTitle = false;
	var productPrice = false;
	var produtQty = false;
	var productContent = false;
	var productImg = false;
	var cateSelect2 = false;
	
	var select2 = $('#category2').val();
	var name = $('#product_title').val();
	var price = $('#product_price').val();
	var qty = $('#product_qty').val();
	var content = $('#summernote').summernote('code');
	var img = $('#product_img').val();

	if (select2 > 0) {
		$('.Pcate').css('display', 'none');
		cateSelect2 = true;
	} else {
		$('.Pcate').css('display', 'block');
		$('.Pcate').css('color', 'red');
		cateSelect2 = false;
	} 
	
	if (name) {
		$('.Pname').css('display', 'none');
		productTitle = true;
	} else {
		$('.Pname').css('display', 'inline-block');
		$('.Pname').css('color', 'red');
		productTitle = false;
	}

	if (price != 0) {
		$('.Pprice').css('display', 'none');
		productPrice = true;
	} else {
		$('.Pprice').css('display', 'inline-block');
		$('.Pprice').css('color', 'red');
		productPrice = false;
	}

	if (qty != 0) {
		$('.Pqty').css('display', 'none');
		produtQty = true;
	} else {
		$('.Pqty').css('display', 'inline-block');
		$('.Pqty').css('color', 'red');
		produtQty = false;
	}

	if (content != "<p><br></p>") {
		$('.Pcontent').css('display', 'none');
		productContent = true;
	} else {
		$('.Pcontent').css('display', 'inline-block');
		$('.Pcontent').css('color', 'red');
		productContent = false;
	}

	if (img) {
		$('.Pimg').css('display', 'none');
		productImg = true;
	} else {
		$('.Pimg').css('display', 'inline-block');
		$('.Pimg').css('color', 'red');
		productImg = false;
	}

	var imgFile = $("#product_img").val();
	var imgPoint = imgFile.lastIndexOf('.');
	var imgType = imgFile.substring(imgPoint + 1, imgFile.length);
	var imgTest = imgType.toLowerCase();

	if (imgTest == 'jpg' || imgTest == 'jpeg' || imgTest == 'gif' || imgTest == 'png' || imgTest == 'bmp') {
	} else {
		$('.Pimg_type').css('display', 'inline-block');
		$('.Pimg_type').css('color', 'red');
		productImg = false;
	}

	if (cateSelect2 && productTitle && productPrice && productContent && productImg) {
		alert('물품 수정 완료하였습니다.');
		return true;
	} else {
		alert('내용을 확인해주세요.');
		return false;
	}
};


</script>

</head>
<body>
	<header>
		<jsp:include page="../template/header.jsp" />
	</header>
	<main>
		<div id="uplode_title">
			<h3 id="uplode_h3">상품수정</h3>
		</div>
		<form id="uplode_form" method="post" enctype="multipart/form-data" action="/shopping/productModify">
			<input type="hidden" name="productNum" value="${productVO.productNum }">
			<div class="uplode form_row">
				<div class="uplode_form Ucate">
				<div class="uplode_check Pcate">상품분류를 해주세요.</div>
					<label for="product_category_no"><strong>상품분류 1차분류</strong></label>
					<select name="category1" id="category1" class="form-control">
						<option value="">전체</option>
					</select>
				</div>

				<div class="uplode_form Ucate">
					<label for="product_category_no"><strong>상품분류 2차분류</strong></label>
					<select name="category2" id="category2" class="form-control">
					</select>
				</div>

				<div class="uplode_form Ucate3">
					<label for="product_category_no"><strong>상품 사이즈</strong></label>
					<input type="text" name="category3" id="category3" class="form-control">
				</div>
				
				<div class="uplode_form Uname">
					<label for="product_title"><strong>상품명</strong></label><span
						class="uplode_check Pname">상품명을 입력해주세요.</span>
						<input type="text" class="form-control" name="productTitle" id="product_title"
						value="${productVO.productTitle }">
				</div>

				<div class="uplode_form Uqty">
					<span class="uplode_check Pqty">수량을 입력해주세요.</span> 
					<label for="product_qty"><strong>상품 수량</strong></label> 
					<input type="text" class="form-control" name="productQty" id="product_qty" 
					value="${productVO.productQty }">
				</div>

				<div class="uplode_form Uprice">
					<span class="uplode_check Pprice">가격을 입력해주세요.</span> 
					<label for="product_price"><strong>상품 가격</strong></label>
					<input type="text" class="form-control" name="productPrice" id="product_price" 
					value="${productVO.productPrice }">
				</div>

				<div class="uplode_form Ucontent" id="Ucontent">
					<label><strong>상품 페이지 내용</strong></label>
					<span class="uplode_check Pcontent">상품내용을 입력해주세요.</span>
					<textarea id="summernote" name="content">${productVO.productContent }</textarea>
				</div>

				<div class="uplode_form Uimg">
					<div><label for="product_img"><strong>섬네일 이미지 업로드</strong></label></div>
					<span class="uplode_check Pimg">상품이미지를 넣어주세요.</span> 
					<input type="file" name="productImg" id="product_img" accept=".jpg, .jpeg, .gif, .png, .bmp"> 
					<img src="${thumModify.thumbNail }">
					<span class="uplode_check Pimg_type">이미지는 jpg, jpeg, gif, png, bmp만 가능합니다.</span>
				</div>
			</div>
			<div class="uplode_form Ubtn">
				<input type="submit" id="upload_btn" value="상품수정" onclick="return formOnclick()">
				<input type="button" id="upload_back_btn" class="upload_back_btn" value="취소">
				<input type="submit" id="delete_Btn" class="upload_back_btn" value="삭제">
			</div>
		</form>
	</main>
	<footer>
		<jsp:include page="../template/footer.jsp"/>
	</footer>
</body>
</html>
