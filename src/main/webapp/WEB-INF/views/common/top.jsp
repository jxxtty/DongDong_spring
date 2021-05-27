<%@page import="com.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<head>
	<script type="text/javascript" src="../js/jquery-3.3.1.js"></script>
	<script type="text/javascript">
			$(document).ready(function(){
				$("#main").click(function() {
					location.href="/";
				})
				
				$("#back").on("click", function() {
					location.href ="/";
				});
				
				$("#search").on("click", function(){
					location.href="categoryList";
				});
				
			    $("#keyword").keydown(function(e) {
				    if (e.keyCode == 13) {
				        $('form').submit();
				    }
				});
			});
	</script>
	<!-- Bootstrap css -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" 
		integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">
	<link rel="preconnect" href="https://fonts.gstatic.com">
	<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700;800&display=swap" rel="stylesheet">
	<style type="text/css">
		*{
			font-family: 'Nanum Gothic', sans-serif;
			font-size: 15px;
			font-weight : 400;
		}
		
		#imgBox {
			padding : 0;
			margin : 0;
		}
		#main{
			margin-top : 30px;
			margin-left : 20px;
		}
		
		#keyword, #search{
			margin-top:40px;
		}
		#keyword{
			border : 2px solid #8db0d7;
		}
		.ttt{
			display : flex;
		}

		.user{
			flex : left;
		}
		
		#user_section{
			margin-top : 45px;
		}
		
		#user_section a{
			margin-left : 5px;
			text-decoration: none;
			color : #8db0d7;
			font-weight : 700;
			font-size: 17px;
		}
		
		#user_section a:hover{
			margin-left : 5px;
			text-decoration: none;
			color : #316ea5;
			font-weight : 700;
			font-size: 17px;
		}
		
		
		
		#user_profile{
			margin-top : 25px;
			margin-left : 10px;
			border : 2px solid #8db0d7;
			border-radius : 10px;
			padding-top : 9px;
			padding-left : 5px;
			padding-right : 5px;
			height : 60px;
			font-size : 20px;
		}
		
		#user_profile img{
			border-radius : 10px;
		}
		
		
	</style>
</head>
<body>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf" crossorigin="anonymous"></script>

<div class="row">
	<div class="col-md-3" id="logo">
		<img id="main" src="/Dong-Dong/images/util/DongDonglogo.png" width="222" height="52" style="cursor: pointer;"/><br><br>
		<!-- 원래 값 : width="222" height="52" -->
	</div>

	<div class="col-md-5" id="search_bar">
		<form action="keywordSearch" method="get">	
    		<input type="text" name="keyword" id="keyword" class="form-control" placeholder="검색할 상품명">
		</form>
	</div>
	<div class="col-md-1" id="imgBox">
		<img src="/Dong-Dong/images/util/search_category.png" id="search" width="110" height="30" style="cursor: pointer; ">
	</div>

<%
 MemberDTO dto =(MemberDTO)session.getAttribute("login");
%>
	<div class="col-md-3 ttt">
		<div id="user_section" class="user">
<%
	if(dto !=null){ //회원인 경우
%>	
			<a href="loginCheck/mypage">mypage</a><!--수정  -->
			<a href="loginCheck/logout">로그아웃</a>
			<a href="loginCheck/postWrite">글쓰기</a>
		</div>
		<div id="user_profile" class="user">
			<%=dto.getNickName() %>
			<img src="/Dong-Dong/images/profile/<%=dto.getUserimage() %>" id="user_profileImg" width="40px" height="40px">
		</div>
<%
	} else{ //아닌경우
%>
			<a href="loginForm">로그인</a>
			<a href="MemberForm">회원가입</a><!--MVC 패턴 -->
		</div>
<%		
	}//end if~else
%>		
	</div>

</body>