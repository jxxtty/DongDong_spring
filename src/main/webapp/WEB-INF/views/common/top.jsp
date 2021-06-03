<%@page import="com.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<head>
	<script type="text/javascript" src="../js/jquery-3.3.1.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.2/sockjs.min.js" integrity="sha512-2hPuJOZB0q6Eu4RlRRL2/8/MZ+IoSSxgDUu+eIUNzHOoHLUwf2xvrMFN4se9mu0qCgxIjHum6jdGk/uMiQoMpQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
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
			
			// 1트. session에서 login정보를 받아와서 로그인 된 경우에만 소켓에 연결한다.
			var isLogin = $("#id").val();
			console.log("isLogin??? " + isLogin);
			 
			
			var stompClient = null;
			if(isLogin){
				var sockJS = new SockJS('/sockJS');
				var urlSubscribe = '/subscribe/alarm/' + ${login.userid}; // 세션에 저장되어있는login정보에서 userid를 추출해서 연결
				stompClient = Stomp.over(sockJS);
				console.log("socket에 연결됐음", stompClient);
				stompClient.connect({},function(){
					stompClient.subscribe(urlSubscribe, function(alarm){
						// 구독해서 넘어오는 데이터(alarm)를 JSON으로 파싱해서 content에 저장
						var content = JSON.parse(alarm.body);
						console.log("정보가 제대로 넘어왓닝?",content); // 제대로 연결돼서 넘어왔는지 확인
						//var sender = content.sender; // 알림을 보낸사람(ex.내가 작성한 글에 댓글을 남긴사람)
						//var type = content.type; // 댓글인지 주문서인지 채팅인지
						var info = content.info; // 댓글인경우 -> 어떤글에 댓글단건지 pNum이 넘어온다.
						var html = viewToUser(content, info);
						
					});
				});
			}
		});
		
		function viewToUser(){ // 받아온 데이터를 파싱해서 화면에 뿌려줄 코드를 작성한다.
			
		}
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


	<div class="col-md-3 ttt">
		<div id="user_section" class="user">

	<input type="hidden" id="id" value="${login.userid}">
	<c:if test="${!empty login}">
		
			<a href="/mypage">mypage</a>
			<a href="loginCheck/logout">로그아웃</a>
			<a href="loginCheck/postWrite">글쓰기</a>
			<a href="chatRoom">채팅</a>
		</div>
		<div id="user_profile" class="user">
			${login.nickName}
			<img src="/Dong-Dong/images/profile/${login.userimage}" id="user_profileImg" width="40px" height="40px">
		</div>
	</c:if>
	<c:if test="${empty login}">
			<a href="loginForm">로그인</a>
			<a href="MemberForm">회원가입</a><!--MVC 패턴 -->
		</div>
	</c:if>
	</div>
	
	<div class="toast" role="alert" aria-live="assertive" aria-atomic="true">
  		<div class="toast-body">
    		Hello, world! This is a toast message.
    	<div class="mt-2 pt-2 border-top">
      	<button type="button" class="btn btn-primary btn-sm">Take action</button>
      	<button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="toast">Close</button>
    </div>
  </div>
</div>
	
</body>