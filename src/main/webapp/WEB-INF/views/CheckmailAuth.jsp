<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 체크를 만들어야 합니다. -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
    $(document).ready(function(){
		$("button").click(function() {
			var authnum = $("#Authnum").val();
			var mailAuth = "인증완료"
			
			if ( authnum != "p1s45asd8zxc") {
				alert("인증 실패");
				event.preventDefault();	
				window.close(); 
			}else {
				alert("인증되었습니다.")
				opener.$("#result4").text(mailAuth); 
				window.close(); 
			}
		});
 });
</script>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700;800&display=swap" rel="stylesheet">	
<style type="text/css">
	* {
		font-family: 'Nanum Gothic', sans-serif;
		font-size: 15px;
		font-weight : 400;
	}
</style>
</head>
<body>

<h4><input id="Authnum" type="text" placeholder="인증번호 입력"></input></h4>
<button>확인</button>


</body>
</html>