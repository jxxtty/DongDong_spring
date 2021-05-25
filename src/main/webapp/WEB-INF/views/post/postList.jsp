<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.dto.PostDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.dto.PageDTO"%>

 <%
 	List<PostDTO> list = (List<PostDTO>)request.getAttribute("postList");	
 
	int curPage = 1;
 	int totalPage = (int)request.getAttribute("totalPage");

 	if(request.getParameter("curPage") != null) {
 		curPage = Integer.parseInt((String)request.getAttribute("curPage"));
 	}
	
	
	String keyword = (String)request.getAttribute("keyword");
	String category = (String)request.getAttribute("category");
	HashMap categoryMap = (HashMap)request.getAttribute("categoryMap");
	if(keyword != null){
%>



	<div id="mesg"><b><%= keyword %></b>로 검색한 결과 <b><%=list.size() %></b>개가 검색되었습니다.</div>
<%
	}

	if(category != null){
		String value = (String)categoryMap.get(category);
%>
	<div id="mesg"><b><%= value %></b> 카테고리 - <b><%=list.size() %></b>개가 검색되었습니다.</div>
<%
	}
%>
<head>	
<!-- Bootstrap css -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" 
		integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">

<style type="text/css"> 

.all {
	width:1950px;
	height:1700px;
	margin: 0 auto;
}
.center {
	text-align: center;
	width:1430px;
	height:1550px;
	margin:0 auto;
}
.container {
	margin: 0 auto;
	 width:1220px;
	height:1580px;
	display:grid;
	 grid-template-columns: 1fr 1fr 1fr 1fr;
	 grid-template-rows: 390px 390px 390px 390px;
}

.card {
	width: 288px; 
	height: 380px;
}
#mesg{
	text-align : center;
}
ul {
    list-style:none;
    margin:0;
    padding:0;
}

li {
	display:inline;
	float: left;
	width: 21%;
    border: 0;
}

.page_wrap {
	text-align: center;
	font-size:0;
}
.page_nation{
	display:inline-block;
}
.page_nation a {
   display:block;
   margin:0 3px;
   float:left;
   border:1px solid #e6e6e6;
   width:28px;
   height:28px;
   line-height:28px;
   text-align:center;
   background-color:#fff;
   font-size:13px;
   color:#999999;
   text-decoration:none;
}
</style> 
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="../js/jquery.twbsPagination.js" type="text/javascript"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js"
	 integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf" crossorigin="anonymous"></script>


</head>
<body>
<div class="all">
	<div class="center">
		<div class="container ">
			
<!-- Bootstrap js -->
	

<%

for(int i=1;i<=list.size();i++){
	PostDTO dto = list.get(i-1);
	String pTitle = dto.getpTitle();
	String pContent = dto.getpContent();
	int pPrice = dto.getpPrice();
	String pImage = dto.getpImage();
	String pDate = dto.getpDate();
	String addr = dto.getAddr();
	int pNum = dto.getpNum();
	
	// 가격에 1000단위에 쉼표를 붙여 줍니다.
    DecimalFormat formatter = new DecimalFormat("###,###");
    String price = formatter.format(pPrice);
    
	// 게시물올린시간 과거로 계산하는 코드
	int pDateDiff = Integer.parseInt(dto.getpDateDiff());
	String pDateResult = null;
	
	if ((pDateDiff / 1440) >= 1){
		pDateResult =(pDateDiff / 1440)+ "일전";
	 }	
	else if
		((pDateDiff / 60) >= 1){
		pDateResult =(pDateDiff / 60)+ "시간전";
	}
	else if
	(pDateDiff >= 1) {
		pDateResult = (pDateDiff)+ "분전";	
	}
	else {
		pDateResult = "방금";
		
	}
%>
<script>
$(document).ready(function(){ 
	$("#card"+<%=pNum %>).on("click",function(){
		location.href="PostDetailServlet?pNum=<%=pNum %>";
	})
	
})
</script>
		
		<div class="card col-lg-7" id="card<%=pNum %>" style="background-color: white; width: 288px; height: 380px; cursor: pointer;">
			<img class="card-img-top rounded mb-4 mb-lg-0" src="/Dong-Dong/images/<%=pImage %>" alt="Responsive image" style="max-width:288px; height:285px;" >
				<div class="card-body" style="width:288px; height:70px;">
				      <h6 class="card-title" style="height:35px;"><%=pTitle%></h6>
				        <h5 class="price"><%=price %>원</h5><small class="text-muted" style="position: absolute; right: 0px; bottom: 0px;"><%=pDateResult%></small>
				</div><!-- card-body -->
	    </div><!-- card -->
<%  
}//end for
%>
		</div><!-- container -->
	</div><!-- center -->
</div><!-- all  -->
<div class="page_wrap">
	<div class="page_nation">	
<%
	for (int j=1; j<=totalPage; j++) {
		if (keyword != null){
%>
			<a href='KeywordSearchServlet?keyword=<%=keyword %>&curPage=<%=j %>'><%=j %></a>	
<% 
		}
%>

<%				
		if (category != null){
%>			
		<a href='CategorySearchServlet?category=<%=category %>&curPage=<%=j %>'><%=j %></a>	
<% 
		}
%> 
<% 
		if (category == null && keyword == null) {
			%>
		
		<a href='main?curPage=<%=j %>'><%=j %></a>


<%	
		}
}	
%>
		</div>
</div>
</body>	 