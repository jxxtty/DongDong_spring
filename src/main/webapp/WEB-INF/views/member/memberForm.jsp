<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<head>
<jsp:include page="Header.jsp" />
</head>

<script type="text/javascript" src="js/jquery-3.3.1.js"></script>
<script type="text/javascript">

$(document).ready(function(){
//form 서브밋 - 아이디 중복( 닉네임 중복), 비밀번호 불일치
//이름,전화번호,주소 입력바람 
$("form").on("submit",function(event){
	console.log("aaa");
 var userid = $("#userid").val();
 var passwd = $("#passwd").val();
 var passwd2 = $("#passwd2").val();
 var nickName = $("#nickName").val();
 var username =$("#username").val();
 var phone =$("#phone").val();
 var addr =$("#addr").val();
 
 var result = $("#result").text();
 var result3 = $("#result3").text();
 var result4 = $("#result4").text();
 
 		if(nickName.length==0){
			alert("닉네임을 입력해주세요.")
			$("#nickName").focus();
			event.preventDefault();	
			
 		}else if(result3 != "닉네임 사용가능"){
			alert("닉네임 중복되었습니다.")
 			$("#nickName").focus();
 			event.preventDefault();		
		
 		}else if(userid.length==0){
 			alert("아이디 입력해주세요.")
 			$("#userid").focus();
 			event.preventDefault();		
			
 		}else if(result != "아이디 사용 가능"){
			alert("아이디가 중복되었습니다.")
 			$("#userid").focus();
 			event.preventDefault();		
		
		}else if(passwd.length==0){
			alert("패스워드 입력해주세요.")
			$("#passwd").focus();
			event.preventDefault();
		
		}else if(passwd!=passwd2){
			alert("패스워드가 일치하지 않습니다.")
			$("#passwd").focus();
			event.preventDefault();
		
		}else if (result4 !="인증완료"){
			alert("이메일 인증해 주세요.")
			event.preventDefault();
		
		}else if(username.length==0){
			alert("이름을 입력해주세요.")
			$("#username").focus();
			event.preventDefault();
		
		}else if(phone.length==0){
			alert("전화번호 입력해주세요.")
			$("#phone").focus();
			event.preventDefault();
		
		}else if(addr.length==0){
			alert("주소를 입력해주세요.")
			$("#addr").focus();
			event.preventDefault();
		}

 		
 		
 		
		
	});
	
//비번확인
$("#passwd2").on("keyup",function(){
	var passwd = $("#passwd").val();
	var mesg = "패스워드 불일치";
	if(passwd == $(this).val()){
		mesg = "패스워드 일치";
	}
	$("#result2").text(mesg);
});

//id체크 
 $("#userid").on("keyup",function(event){
	 $.ajax({
			type : "GET",
			url : "MemberIdCheckServlet",
			dataType : "text",
 			data : {
				userid : $("#userid").val()
			}, 
			success : function(responseData, status, xhr) {
			    console.log(responseData);
				$("#result").text(responseData);
			},
			error : function(xhr, status, error) {
				console.log("error");
			}
		});
});

//nickName체크 
 $("#nickName").on("keyup",function(event){
	 $.ajax({
			type : "GET",
			url : "MembernickNameCheckServlet",
			dataType : "text",
 			data : {
				nickName : $("#nickName").val()
			}, 
			success : function(responseData, status, xhr) {
			    console.log(responseData);
				$("#result3").text(responseData);
			},
			error : function(xhr, status, error) {
				console.log("error");
				event.preventDefault();
		}
	});
});

	function maileAuth() {
		// 자식창 중앙 정렬
		var popupWidth = 500;
		var popupHeight = 200;
		//오류 주의...
		var popupX = (window.screen.width / 2) - (popupWidth / 2);
		// 만들 팝업창 width 크기의 1/2 만큼 보정값으로 빼줌
		var popupY= (window.screen.height / 2) - (popupHeight / 2);
		// 만들 팝업창 height 크기의 1/2 만큼 보정값으로 빼줌
		url = "emailAuth.jsp"
		open(url,"confirm", 'status=no, height=' + popupHeight  + ', width=' + popupWidth  + ', left='+ popupX + ', top='+ popupY);
	}
	//닉네임 체크 //이메일 값 넘겨주기
	$("#mailAuth").click(function() {
		maileAuth();
	})

}); //end doc
 
</script>    


	<div class="container">
	<div class="row">
	<div class="col-sm-100 text-center" >
	<div class="col-sm-50"><!--가로 넓이 -->
	<div class="col-sm-50"><!--세로 길이 -->
	
	
<form action="MemberAddServlet" method="get">
  <div class="container" >
        <div class="py-3 text-center">
             <img class="d-block mx-auto mb-2" src="/Dong-Dong/images/util/DongDonglogo2.png" alt="" width="300" height="300"> 
            <h1>회원가입</h1>
        </div>
        
<table class="table table-boardered">
<tr>
<th><h3>닉네임</h3></th>
<td colspan="3"style="width:20%;"><input type="text" class="form-control" name="nickName" id="nickName" style="width:700px;height:50px" placeholder="닉네임 입력"><span id="result3"/></td>
</tr>

<tr>
<th><h3>아이디</h3></th>
<td colspan="3"style="width:20%;"><input type="text" class="form-control"  name="userid" id="userid" style="width:700px;height:50px" placeholder="아이디 입력"><span id="result"/></td>
</tr>

<tr>
<th><h3>패스워드</h3></th>
<td colspan="3"style="width:20%;"><input type="text" class="form-control" name="passwd" id="passwd" style="width:700px;height:50px" placeholder="비밀번호 입력"></td>
</tr>

<tr>
<th><h3>패스워드 확인</th>
<td colspan="3"style="width:20%;"><input type="password" class="form-control" name="passwd2" id="passwd2" style="width:700px;height:50px"><span id="result2"/></td>		
</tr>

<tr>
<th><h3>이름</h3></th>
<td colspan="3"style="width:20%;"><input type="text" class="form-control" name="username" id="username" style="width:700px;height:50px" placeholder="이름"></td>		
</tr>

<tr>
<th><h3>전화번호</h3></th>
<td colspan="3"style="width:20%;"><input type="tel" class="form-control" name="phone" id ="phone" style="width:700px;height:50px"placeholder="전화번호" ></td>		
</tr>

<tr>
<th><h3>주소</h3></th>
<td colspan="3" style="width:20%;" ><input type="text" class="form-control"name="addr" id="addr" style="width:700px;height:50px" placeholder="주소"></td>		
</tr>

<tr>
<th><h3>이메일</h3></th>
<td  style="width:20%;"><input type="text" class="form-control" name="email1"style="width:315px;height:50px"></td>
<td>@</td>
<td><input type="text" class="form-control" name="email2"style="width:315px;height:50px">
<button type="button" id="mailAuth"class="btn btn-info">메일 인증</button><span id="result4" text=""></span></td>		
</tr>
			
	<tr>
	<th/>
	<td colspan="3">
	<input type="submit" class="btn btn-info" value="회원가입"> 
	<input type="reset" class="btn btn-danger" value="취소">
	<!-- <th/><th/> -->
	</td>
	</tr>






<!-- <span id="guide" style="color:#999"></span>

이메일 : <input type="text" name="email1" >@
       <input type="text" name="email2"  placeholder="직접입력">
       <select>
        <option value="daum.net">daum.net</option>
        <option value="naver.com">naver.com</option>
       </select>
	<button type="button" id="mailAuth">메일 인증</button><span id="result4" text=""></span>
      
<input type="submit" value="회원가입">
<input type="reset" value="취소">
-->


</table>
</form>
</div></div></div></div></div>