<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>dongdong market-Home</title>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700;800&display=swap" rel="stylesheet">
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#main").click(function() {
			location.href="main";
		})
	})//end ready
</script>
<style type="text/css">
	
	footer
	* {
		font-family: 'Nanum Gothic', sans-serif;
		font-size: 15px;
		font-weight : 400;
	}
	
	main{
		padding-top : 10px;
		z-index : 2;
	}
	
	
	header {
		/* background-image : url('/Dong-Dong/images/util/main.jpg');
		background-repeat : no-repeat;
		background-size : cover; */
		margin : 0;
		padding : 0;
		position : fixed;
		top : 0;
		left : 0;
		right : 0;
		z-index : 1;
		text-align : center;
		height : 114px;
		background-color : white;
	}
	
	#main_img{
		margin : 0;
		padding : 0;
		background-image : url('/Dong-Dong/images/util/main.jpg');
		background-repeat : no-repeat;
		background-size : cover;
		z-index : 1;
		width : 100%;
		height : 500px;
	}
</style>
</head>
<body>
<%
	String withdrawal = (String)session.getAttribute("withdrawal");
	if(withdrawal != null){
%>
	<script type = "text/javascript">
		alert('<%=withdrawal %>');
	</script>
<%
	//
	session.removeAttribute("withdrawal");
	session.removeAttribute("login");
	}
%>


<%
	String mesg = (String)session.getAttribute("mesg");
	if(mesg != null){
%>
	<script type = "text/javascript">
		alert('<%=mesg %>');
	</script>
<%
	//
	session.removeAttribute("mesg");
	}
%>

<header>
	<jsp:include page="common/top.jsp" flush="true"></jsp:include><br>
</header>
<div id="main_img"></div>
<main>
	<jsp:include page="post/postList.jsp" flush="true"></jsp:include><br>
</main>
<footer>
	<jsp:include page="layout/bottom.jsp" flush="true"></jsp:include><br>
	</footer>
</body>
</html>