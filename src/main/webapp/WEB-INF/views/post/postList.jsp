<%@page import="com.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.dto.PostDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.dto.PageDTO"%>

<%
	
	List<PostDTO> list = (List<PostDTO>) request.getAttribute("postList");
	int curPage = 1;
	int totalPage = (int) request.getAttribute("totalPage");
	int blockPerPage = (int)request.getAttribute("blockPerPage");
	int prevPageBlock = (int)request.getAttribute("prevPageBlock");
	int nextPageBlock = (int)request.getAttribute("nextPageBlock");
	MemberDTO member = (MemberDTO)request.getSession().getAttribute("login");
	if (request.getParameter("curPage") != null) {
		curPage = Integer.parseInt((String) request.getAttribute("curPage"));
	}

	String keyword = (String) request.getAttribute("keyword");
	String category = (String) request.getAttribute("category");
	HashMap categoryMap = (HashMap) request.getAttribute("categoryMap");
	if (keyword != null) {
%>



<div id="mesg">
	<b><%=keyword%></b>로 검색한 결과 <b><%=list.size()%></b>개가 검색되었습니다.
</div>
<%
	}

	if (category != null) {
		String value = (String) categoryMap.get(category);
%>
<div id="mesg">
	<b><%=value%></b> 카테고리 - <b><%=list.size()%></b>개가 검색되었습니다.
</div>
<%
	}
%>
<head>
<!-- Bootstrap css -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6"
	crossorigin="anonymous">

<style type="text/css">


.all {
	width: 1950px;
	height: auto;
	margin: 0 auto;
}

.center {
	text-align: center;
	width: 1430px;
	height: auto;
	margin: 0 auto;
}

.container {
	width: 1220px;
	height: auto;
	display: grid;
	grid-template-columns: 1fr 1fr 1fr 1fr;
	grid-template-rows: 390px;
}

.card {
	margin-bottom: 10px;
	width: 288px;
	height: 380px;
}

#mesg {
	text-align: center;
}

.page_nation a:active {
	background-color: #d0eefb;
}

.page_wrap {
	width: auto;
	text-align: center;
	font-size: 0;
}

.page_center {
	text-align: center;
}

.page_nation {
	width: 300px;
	margin-left: 80px;
	display: inline-block;
	text-align: center;
}

.page_nation a {
	display: block;
	margin: 0 3px;
	float: left;
	border: 1px solid #e6e6e6;
	width: 28px;
	height: 28px;
	line-height: 28px;
	text-align: center;
	background-color: #fff;
	font-size: 13px;
	color: #999999;
	text-decoration: none;
}

img#MOVE_TOP_BTN {
	position: fixed;
	right: 2%;
	bottom: 50px;
	display: none;
	z-index: 999;
}

#followquick {
	position: absolute;
	top: 160px;
	right: 50%;
	float: left;
	text-align: center;
	margin-right: -850px;
	margin-top: 500px;
}

.current {
	color: red;
}

#favorite{
	font-family: 'Nanum Gothic', sans-serif;
	font-size: 16px;
	font-weight: 700;
	color: #8db0d7 !important;
	text-decoration: none;
}
@media (min-width:300px) and (max-width: 991.98px){
  .container{
  	grid-template-columns: 1fr;
  	margin: 0 1px;
  	height: auto;
  	max-width: 500px;
  }
   .page_nation {
	width: 300px;
	margin-left: -190px;
	margin-right: 300px;
	display: inline-block;
	text-align: center;
}
#followquick {
	position: absolute;
	top: 160px;
	right: 50%;
	float: left;
	text-align: center;
	margin-right: -330px;
	margin-top: 500px;
}
}
 @media (min-width:992px) and (max-width: 1199.98px){
  .container{
  	grid-template-columns: 1fr 1fr;
  	margin: 0 1px;
  	height: auto;
  	max-width: 630px;
  }
  .page_nation {
	width: 300px;
	margin-left: -80px;
	margin-right: 100px;
	display: inline-block;
	text-align: center;
}
#followquick {
	position: absolute;
	top: 160px;
	right: 50%;
	float: left;
	text-align: center;
	margin-right: -510px;
	margin-top: 500px;
}
}
  @media (min-width:1200px) and (max-width: 1560px){
  .container{
  	grid-template-columns: 1fr 1fr 1fr;
  	margin: 0 1px;
  	height: auto;
  	max-width: 920px;
  }
.page_nation {
	width: 300px;
	margin-left: 90px;
	display: inline-block;
	text-align: center;
}
#followquick {
	position: absolute;
	top: 160px;
	right: 50%;
	float: left;
	text-align: center;
	margin-right: -700px;
	margin-top: 500px;
}
}
@media (min-width:1561.98px) and (max-width: 2400px){
  .page_nation {
	width: 300px;
	margin-left: 90px;
	display: inline-block;
	text-align: center;
}
}
</style>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf"
	crossorigin="anonymous"></script>
<script>
 $(function() {
	$(window).scroll(function(){
		var scrollTop = $(document).scrollTop();
		if (scrollTop < 160) {
		 scrollTop = 160;
		} 
		$("#followquick").stop();
		$("#followquick").animate( { "top" : scrollTop });
		if (scrollTop > 1300) {
			scrollTop = 1300;
		}
		$("#followquick").stop();
		$("#followquick").animate( { "top" : scrollTop });
	}); //window scroll
 });//전체


$(function() { //top 버튼 처리
$(window).scroll(function() {
    if ($(this).scrollTop() > 800) {
        $('#MOVE_TOP_BTN').fadeIn();
    } else {
        $('#MOVE_TOP_BTN').fadeOut();
    } //else {
});//window scroll

$("#MOVE_TOP_BTN").click(function() {
    $('html, body').animate({
        scrollTop : 0
    }, 400);
    return false;
	}); //click function
}); //전체 })

</script>
</head>
<body>

<% 
	/* if(list2 != null){  */
		if(member != null){
%>
	
	<div id="followquick" class="border border-4" style="max-width: 116px; max-height:450px; text-align:center;"><a href="/loginCheck/FavoriteList" id="favorite">&nbsp;관심 목록</a>
 <%
 	List<PostDTO> list2 = (List<PostDTO>)request.getAttribute("favoriteList");
	for(int k=0; k<list2.size(); k++){
		if(k==3){
			break;
		}
	PostDTO dto = list2.get(k);
	String pImage = dto.getpImage();
	int pNum = dto.getpNum();
	String pTitle = dto.getpTitle();
	String userid = dto.getUserid();
%>

	<div class="card border border-3" style="max-width:107px; height:117px;">
	      <a href="postDetail?pNum=<%=pNum %>">
      <img class="card-img-top" src="/Dong-Dong/images/<%=pImage %>" alt="Responsive image" style="max-width:110px; height:110px; display: block; margin: auto;" ></a>
      </div><!-- card -->
    	
      
<%
	}// for
 }//if
%>   
</span>
 	</div><!--찜목록 위젯 설정-->
 
	<img id="MOVE_TOP_BTN" src="/Dong-Dong/images/util/topbutton.png"
		href="#" style="width: 75px; height: 75px;"><!-- 최상단으로 갈수있는 top버튼 -->
	<div class="all">
		<!-- 여기서부터 -->
		<div class="center">
			<div class="container">
			

				<!-- Bootstrap js -->


				<%
					for (int i = 1; i <= list.size(); i++) {
						PostDTO dto = list.get(i - 1);
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

						if ((pDateDiff / 1440) >= 1) {
							pDateResult = (pDateDiff / 1440) + "일전";
						} else if ((pDateDiff / 60) >= 1) {
							pDateResult = (pDateDiff / 60) + "시간전";
						} else if (pDateDiff >= 1) {
							pDateResult = (pDateDiff) + "분전";
						} else {
							pDateResult = "방금";

						}
				%>
<script>
$(document).ready(function(){ 
	$("#card"+<%=pNum%>).on("click",function(){
		location.href="postDetail?pNum=<%=pNum%>";
	});
});
</script>

				<div class="card" id="card<%=pNum%>"
					style="background-color: white; width: 288px; height: 380px; cursor: pointer;">
					<img class="card-img-top" src="/Dong-Dong/images/<%=pImage%>"
						alt="Responsive image" style="max-width: 288px; height: 285px;">
					<div class="card-body" style="width: 288px; height: 70px;">
						<h5 class="card-title" style="height: 35px;"><%=pTitle%></h5>
						<h4 class="price"><%=price%>원
						</h4>
						<small class="text-muted"
							style="position: absolute; right: 0px; bottom: 0px;"><%=pDateResult%></small>
					</div>
					<!-- card-body -->
				</div>
				<!-- card -->
				<%
					} //end for
				%>
			
				
			</div>
			<!-- container -->

		</div>
		<!-- center -->
	</div>
	<!-- all  -->
	<!-- 여기까지 -->
	<br/>
	
	<div class="page_wrap">
	<div class="page center">
		<div class="page_nation" id="page_nation">	
<!-- 이전버튼 구현 카테고리검색 / 키워드검색 / 메인에서 일반적인 이전버튼  -->
<%	
	if (category != null && curPage != 0 && curPage != 1){ 
%>	
	<div class="paginate previous" id="paginate previous"><a href='categorySearch?category=<%=category %>&curPage=<%=prevPageBlock-1%>'>◁</a></div>

<%
	}
%>	

<%	
	if (keyword != null && curPage != 0 && curPage != 1){ 
%>	
	<div class="paginate previous" id="paginate previous"><a href='keywordSearch?keyword=<%=keyword %>&curPage=<%=prevPageBlock-1%>'>◁</a></div>

<%
	}
%>	

<% 
	if(category == null && keyword == null && curPage != 0 && curPage != 1) {
		
%>
	<div class="paginate previous" id="paginate previous"><a href='?curPage=<%=prevPageBlock-1%>'>◁</a></div>
		
<%
	} //if curPage 이전 
%>

<%
		//페이지 번호 처리
 		if(nextPageBlock > totalPage){
			nextPageBlock = totalPage;
		} 

		for (int j=prevPageBlock; j<=nextPageBlock; j++) {
			
%>
<% 
		if (category == null && keyword == null) {
%>

		<a href='?curPage=<%=j %>'><%=j %></a>	
<%
		}
%>

			
			
<% 				
				
		if (keyword != null){
%>
			<a href='keywordSearch?keyword=<%=keyword %>&curPage=<%=j %>'><%=j %></a>	
<% 			
			
		}// if keyword != null
%>

<%				
		if (category != null){
%>			
		<a href='categorySearch?category=<%=category %>&curPage=<%=j %>'><%=j %></a>	
		
<% 
		}//if category != null
%> 



<%	
				
}	//전체 for
%>
<!-- 다음버튼 구현 카테고리검색 / 키워드검색 / 메인에서 일반적인 다음버튼  -->
<%	
	if (category != null && totalPage > nextPageBlock){
		if(totalPage != 1){
%>	
	<div class="paginate next"><a href='categorySearch?category=<%=category %>&curPage=<%=nextPageBlock+1%>'>▷</a></div>

<%
		}
	}
%>	

<%	
	if (keyword != null && totalPage > nextPageBlock){ 
		if(totalPage != 1){
%>	
	<div class="paginate next"><a href='keywordSearch?keyword=<%=keyword %>&curPage=<%=nextPageBlock+1%>'>▷</a></div>

<%
	}
}

%>	

<% 
	if(category == null && keyword == null && totalPage > nextPageBlock) {
			
%>			
 	<div class="paginate next"><a href='?curPage=<%=nextPageBlock+1%>'>▷</a></div>
<%

	} //if curPage 다음
%>
		</div> <!--page_nation  -->
		</div> <!--page center  -->
</div><!-- page_wrap  -->
<br/>
</body>	 
