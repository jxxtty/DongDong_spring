<%@page import="com.dto.PostDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript" src="../js/jquery-3.3.1.js"></script>
<script type="text/javascript">
		function readURL(input){
			if(input.files && input.files[0]){
				var reader = new FileReader();
				reader.onload = function(e){
					$("#thumbnail").attr('src', e.target.result);
					$("#thumbnail").attr('height', '100');
					$("#thumbnail").attr('width', '100');
				}
				reader.readAsDataURL(input.files[0]);
			}
		}
		$(document).ready(function(){
			$("form").on("submit",function(event){
				var pTitle = $("#pTitle").val();
				var pContent = $("#pContent").val();
				var pPrice = $("#pPrice").val();
				var file = $("#photo").val();
				var pCategory = $("#pCategory option:selected").val();		

				if(pTitle.length == 0){
					alert("글제목은 필수입니다.");
					$("#pTitle").focus();
					event.preventDefault();	
				} else if(pCategory.length == 4){
					alert("카테고리 선택은 필수입니다.");
					$("#pCategory").focus();
					event.preventDefault();	
				} else if(pContent.length == 0){
					alert("글내용은 필수입니다.");
					$("#pContent").focus();
					event.preventDefault();
				} else if(pPrice.length == 0){
					alert("가격은 필수입니다.");
					$("#pPrice").focus();
					event.preventDefault();	
				}
			});
		
			$("#back").on("click", function() {
				location.href ="PostDetailServlet?pNum="+$("#pNum").val();
			});
		});
</script>
	<!-- Bootstrap css -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" 
		integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">

	<style type="text/css">
	*{
		text-align : center;
	}
	</style>
	
	<!-- Bootstrap js -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf" crossorigin="anonymous"></script>
	<form action="../loginCheck/postUpdate" method="post" enctype="multipart/form-data">
		<input type="hidden" id="pNum" name="pNum" value="${postRetrieve.pNum}">
		<!-- <input type="text" id="title" name="title" placeholder="상품명을 포함한 글 제목"> -->
		<div class="row" >
			<div class="col-md-3 col-sm-2"></div>
			<div class="mb-3 col-md-6 col-sm-8">
    			<input type="text" name="pTitle" id="pTitle" class="form-control"
    				aria-describedby="emailHelp" value="${postRetrieve.pTitle}">
  			</div>
  			<div class="col-md-3 col-sm-2"></div>
  		</div>
  		
  		<div class="row">
  			<div class="col-md-3 col-sm-2"></div>
			<div class="col-md-6 col-sm-8 mb-3">
				<select class="form-select" aria-label="Default select example" name="pCategory" id="pCategory">
  					<option value="D" <c:if test="${postRetrieve.pCategory eq 'D'}">selected</c:if>>[Digital]: 디지털, 가전</option>
  					<option value="H" <c:if test="${postRetrieve.pCategory  eq 'H'}">selected</c:if>>[House]: 가구, 인테리어</option>
  					<option value="BY" <c:if test="${postRetrieve.pCategory  eq 'BY'}">selected</c:if>>[BABY]: 유아동</option>
  					<option value="L" <c:if test="${postRetrieve.pCategory  eq 'L'}">selected</c:if>>[Living]: 생활, 가공식품</option>
  					<option value="S" <c:if test="${postRetrieve.pCategory  eq 'S'}">selected</c:if>>[Sports]: 스포츠, 레저</option>
  					<option value="W" <c:if test="${postRetrieve.pCategory  eq 'W'}">selected</c:if>>[Woman]: 여성의류, 여성잡화</option>
					<option value="M" <c:if test="${postRetrieve.pCategory  eq 'M'}">selected</c:if>>[Man]: 남성의류, 남성잡화</option>
					<option value="G" <c:if test="${postRetrieve.pCategory  eq 'G'}">selected</c:if>>[Game]: 게임, 취미</option>
					<option value="BT" <c:if test="${postRetrieve.pCategory eq 'BT'}">selected</c:if>>[Beauty]: 뷰티, 미용</option>
					<option value="PET" <c:if test="${postRetrieve.pCategory  eq 'PET'}">selected</c:if>>[Pet]: 반려동물 용품</option>
					<option value="BK" <c:if test="${postRetrieve.pCategory  eq 'BK'}">selected</c:if>>[Book]: 도서</option>
					<option value="T" <c:if test="${postRetrieve.pCategory  eq 'T'}">selected</c:if>>[Tickets]: 티켓</option>
					<option value="P" <c:if test="${postRetrieve.pCategory  eq 'P'}">selected</c:if>>[Plant]: 식물</option>
					<option value="E" <c:if test="${postRetrieve.pCategory  eq 'E'}">selected</c:if>>[ETC] : 기타</option>
				</select>
			</div>
  			<div class="col-md-3 col-sm-2"></div>
  		</div>
  		
		
		<br>
		
		<img id="thumbnail" src="/Dong-Dong/images/${postRetrieve.pImage}" width="400px"/><br>
 		<div class="row">
 			<div class="col-md-3 col-sm-2"></div>
			<div class="mb-3 col-md-6 col-sm-8">
  				<label for="formFile" class="form-label">판매할 상품 사진</label>
  				<input class="form-control" type="file" id="photo" name="file" 
  					accept="image/gif,image/jpg,image/png,image/jpeg" onchange="readURL(this);">
			</div>
			<div class="col-md-3 col-sm-2"></div>
		</div>
		<!-- <textarea id="content" name="content"
			placeholder="자세한 상품설명과 거래방법을 명시하세요" cols="30" rows="30"></textarea><br>
			 -->
			 
		<div class="row">
 			<div class="col-md-3 col-sm-2"></div>
			<div class="mb-3 col-md-6 col-sm-8">
  				<textarea class="form-control" name="pContent" rows="10" id="pContent"
  					placeholder="자세한 상품 설명과 거래 방법을 작성하세요" style="resize: none;">${postRetrieve.pContent}</textarea>
			</div>
			<div class="col-md-3 col-sm-2"></div>
		</div>	
			
		<!-- <input type="text" id="price" name="price" placeholder="상품가격"><br>
		 -->
		 <div class="row">
 			<div class="col-md-3 col-sm-2"></div>
			<div class="mb-3 col-md-6 col-sm-8">
    			<input type="text" name="pPrice" id="price" class="form-control"
    				aria-describedby="price" placeholder="상품가격" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="10" value="${postRetrieve.pPrice}">
  			</div>
  			<div class="col-md-3 col-sm-2"></div>
  		</div>
  		
		<input type="submit" value="수정하기" class="btn btn-outline-info">
		<button type="button" id="back" class="btn btn-outline-info">돌아가기</button>
	</form>