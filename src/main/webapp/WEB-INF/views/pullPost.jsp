<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.dto.PostDTO" %>
<%
PostDTO pDto = (PostDTO)request.getAttribute("pDto");
int pPull = Integer.parseInt(pDto.getpPull());
String pDate = pDto.getpDate();
int pNum = pDto.getpNum();
String pullAvailable = (String)request.getAttribute("pullAvailable");
int calDateDay = Integer.parseInt((String)request.getAttribute("calDateDay"));

%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
		<script type="text/javascript">
    		$(document).ready(function(){
    			var pullA = "<%=pullAvailable%>";
    			var pPull = <%=pPull%>;
    			if(pullA == "T"){
					if(pPull == 3){
    					var formSubmit = document.getElementById("pullT");
    					formSubmit.onclick = function(){
    						document.pullForm.target = opener.name;
    						document.pullForm.submit();
    						self.close();
    					}
					} else {
						var formSubmit = document.getElementById("pullT");
		    			formSubmit.onclick = function(){
		    				document.pullForm.target = opener.name;
		    				document.pullForm.submit();
		    				self.close();
		    			}
					}
    			} else {
    				if(pPull == 0){
    					var write = document.getElementById("pullFWrite");
    					write.onclick = function(){
    						document.pullF.target = opener.name;
    	    				document.pullF.submit();
    						self.close();
    					}
    				}
    			}
    			
 			});//end ready
		</script>
		 <link rel="preconnect" href="https://fonts.gstatic.com">
		<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700;800&display=swap" rel="stylesheet">	
		<style type="text/css">
			* {
				font-family: 'Nanum Gothic', sans-serif;
				font-size: 15px;
				font-weight : 400;
			} 
			
			#popup {
				text-align: center;
				border : 3px solid #8db0d7;
				margin: auto;
				padding: 10px;
			}
			
			#post img{
				vertical-align : middle;
			}
			
			#post {
				text-align: center;
				border : 2px solid #8db0d7;
				border-radius : 5px;
				margin: 5px 50px;
				padding: auto;
			}
			
			.btn {
				border : 1px solid #8db0d7;
				background-color : #8db0d7;
				color : white;
				border-radius : 3px;
			}
			
		</style>
	</head>
	<body>
		
	
		<%
			if(pullAvailable.equals("T")){
				if(pPull == 3){
		%>
					<div id="popup">
					<!-- 끌올 가능(끌올 한번도 안해본사람) -->
						<div id="post">
							<p>
								<img src="/Dong-Dong/images/<%=pDto.getpImage() %>" width="70" height="70">
								<b><%=pDto.getpTitle() %></b>
							</p>
						</div>
						<form action="PostPullServlet" name="pullForm">
							<input type="hidden" value="<%=pNum %>" name="pNum">
							끌올 기능은 <b>3일 간격 3회</b>로 제한됩니다.<br>
							<br>
							현재 해당 글에대한 끌올 가능 횟수는 <%=pPull %>회 입니다.<br>
							<br>
							<input type="button" id="pullT" class="btn" value="끌올하기" style="cursor: pointer;">
							<button class="btn" onclick="window.close()" style="cursor: pointer;">취소</button>
						</form>
					</div>
		<%
				} else {
		%>
					<!-- 끌올 가능(끌올 해본사람) -->
					<div id="popup">
							<div id="post">
							<p>
								<img src="/Dong-Dong/images/<%=pDto.getpImage() %>" width="70" height="70">
								<b><%=pDto.getpTitle() %></b>
							</p>
						</div>
						<form action="PostPullServlet" name="pullForm">
							<input type="hidden" value="<%=pNum %>" name="pNum">
							끌올 기능은 <b>3일 간격 3회</b>로 제한됩니다.<br>
							<br>
							현재 해당 글에대한 끌올 가능 횟수는 <%=pPull %>회 입니다.<br>
							최근 끌올 날짜 : <%= pDate %>(<%=calDateDay %>일전)<br>
							<input type="button" id="pullT" class="btn" value="끌올하기" style="cursor: pointer;">
							<button class="btn" onclick="window.close()" style="cursor: pointer;">취소</button>
						</form>
					</div>
		<%
				}
			} else {
				if(pPull > 0){
		%>
					<div id="popup">
						<div id="post">
							<p>
								<img src="/Dong-Dong/images/<%=pDto.getpImage() %>" width="70" height="70">
								<b><%=pDto.getpTitle() %></b>
							</p>
						</div>
						<!-- 끌올 불가능(끌올 횟수는 남았으나 끌올한지 얼마안된경우) -->
						끌올 기능은 <b>3일 간격 3회</b>로 제한됩니다.<br>
						<br>
						최근 끌올 날짜 : <%= pDate %>(<%=calDateDay %>일전)<br>
						끌올이 <b>불가능</b>합니다!<br>
						<br>
						<button class="btn" onclick="window.close()" style="cursor: pointer;">확인</button>
					</div>
		<%
				} else {
		%>
					<div id="popup">
					<!-- 끌올 가능(끌올 한번도 안해본사람) -->
						<div id="post">
							<p>
								<img src="/Dong-Dong/images/<%=pDto.getpImage() %>" width="70" height="70">
								<b><%=pDto.getpTitle() %></b>
							</p>
						</div>
					<!-- 끌올 불가능(끌올 횟수가 안남음) -->
						끌올 기능은 <b>3일 간격 3회</b>로 제한됩니다.<br>
						<br>
						해당 글에대한 끌올 횟수를 모두 사용하셨습니다.<br>
						<br>
						새로 글을 작성하고 싶으시다면 글쓰기 버튼을 클릭해주세요<br>
						<form action="PostWriteUIServlet" name="pullF">
						<input type="button" class="btn" id="pullFWrite" value="글쓰기" style="cursor: pointer;">
						<button class="btn" id="pullFCancel" onclick="window.close()" style="cursor: pointer;">확인</button>
						</form>
					</div>
		<%
				}
			}
		%>
	</body>
</html>