<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<head>
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
					var title = $("#title").val();
					var content = $("#content").val();
					var price = $("#price").val();
					var file = $("#photo").val();
					var category = $("#category option:selected").val();		
					
					if(title.length == 0){
						alert("글제목은 필수입니다.");
						$("#title").focus();
						event.preventDefault();	
					} else if(category.length == 4){
						alert("카테고리 선택은 필수입니다.");
						$("#category").focus();
						event.preventDefault();	
					} else if(!file){
						alert("사진첨부는 필수입니다.");
						$("#photo").focus();
						event.preventDefault();	
					} else if(content.length == 0){
						alert("글내용은 필수입니다.");
						$("#content").focus();
						event.preventDefault();
					} else if(price.length == 0){
						alert("가격은 필수입니다.");
						$("#price").focus();
						event.preventDefault();	
					}
				});
				
				$("#back").on("click", function() {
					location.href ="main";
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
</head>


<body>
<!-- Bootstrap js -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf" crossorigin="anonymous"></script>
	<form action="PostWriteServlet" method="post" enctype="multipart/form-data">
		<!-- 글 제목 입력 -->
		<div class="row" >
			<div class="col-md-3 col-sm-2"></div>
			<div class="mb-3 col-md-6 col-sm-8">
    			<input type="text" name="title" id="title" class="form-control"
    				aria-describedby="emailHelp" placeholder="상품명을 포함한 글 제목" maxlength="30">
  			</div>
  			<div class="col-md-3 col-sm-2"></div>
  		</div>
  		
  		<!-- 카테고리 선택 -->
  		<div class="row">
  			<div class="col-md-3 col-sm-2"></div>
			<div class="col-md-6 col-sm-8 mb-3">
				<select class="form-select" aria-label="Default select example" name="category" id="category">
  					<option value="none" selected>카테고리 선택</option>
  					<option value="D">[Digital]: 디지털, 가전</option>
					<option value="H">[House]: 가구, 인테리어</option>
					<option value="BY">[BABY]: 유아동</option>
					<option value="L">[Living]: 생활, 가공식품</option>
					<option value="S">[Sports]: 스포츠, 레저</option>
					<option value="W">[Woman]: 여성의류, 여성잡화</option>
					<option value="M">[Man]: 남성의류, 남성잡화</option>
					<option value="G">[Game]: 게임, 취미</option>
					<option value="BT">[Beauty]: 뷰티, 미용</option>
					<option value="PET">[Pet]: 반려동물용품</option>
					<option value="BK">[Book]: 도서</option>
					<option value="T">[Tickets]: 티켓</option>
					<option value="P">[Plant]: 식물</option>
					<option value="E">[ETC] : 기타</option>
				</select>
			</div>
  			<div class="col-md-3 col-sm-2"></div>
  		</div>
  		
		
		<br>
		<!-- 미리보기 사진 -->
		<img id="thumbnail" src="/Dong-Dong/images/util/thumbnail.png"  /><br>
	
 		<div class="row">
 			<div class="col-md-3 col-sm-2"></div>
			<div class="mb-3 col-md-6 col-sm-8">
  				<label for="formFile" class="form-label">판매할 상품 사진</label>
  				<input class="form-control" type="file" id="photo" name="photo" 
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
  				<textarea class="form-control" name="content" id="content" rows="10"
  					placeholder="자세한 상품 설명과 거래 방법을 작성하세요" maxlength="300"></textarea>
			</div>
			<div class="col-md-3 col-sm-2"></div>
		</div>	
			
		<!-- <input type="text" id="price" name="price" placeholder="상품가격"><br>
		 -->
		 <div class="row">
 			<div class="col-md-3 col-sm-2"></div>
			<div class="mb-3 col-md-6 col-sm-8">
    			<input type="text" name="price" id="price" class="form-control"
    				aria-describedby="price" placeholder="상품가격" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="10">
  			</div>
  			<div class="col-md-3 col-sm-2"></div>
  		</div>
  		
		<input type="submit" value="글쓰기" class="btn btn-outline-info">
		<input type="reset" value="다시입력" class="btn btn-outline-info">
		<button type="button" id="back" class="btn btn-outline-info">돌아가기</button>
	</form>
</body>