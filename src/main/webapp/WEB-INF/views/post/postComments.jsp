<%@page import="java.util.List"%>
<%@page import="com.dto.CommentsDTO"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	MemberDTO dto = (MemberDTO)session.getAttribute("login");
	String pNum = (String)request.getAttribute("pNum");
	String pStatus = (String)request.getAttribute("pStatus");
	boolean status = (pStatus.charAt(0)=='1'?true:false);
    List<CommentsDTO> comments = (List<CommentsDTO>)request.getAttribute("comments");
%>

<!-- Bootstrap css -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" 
	integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">
<!-- Bootstrap js -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf" crossorigin="anonymous"></script>
<style type="text/css">
#comments_div{
	text-align : left;
}
.comment form{
	display: none;
}
#profileImage{
	vertical-align: middle;
}
.footerfix{
padding-bottom: 300px;
}
</style>


<script type="text/javascript">
<%if(dto!=null) {%>
	$(document).ready(function() {
		$(".update_comment").on("click", function() {
			$(this).parent().parent().parent().find(".comment-update-form").toggle(100);
			if($(this).parent().parent().parent().find(".comment-reply-form").attr("style")=="display: block;"){
				$(this).parent().parent().parent().find(".comment-reply-form").toggle(100);
			}
		});//on
		
		$(".reply_comment").on("click", function() {
			$(this).parent().parent().parent().find(".comment-reply-form").toggle(100);
			if($(this).parent().parent().parent().find(".comment-update-form").attr("style")=="display: block;"){
				$(this).parent().parent().parent().find(".comment-update-form").toggle(100);
			}
		});//on
		
		$("form").on("submit",function(event){
			var cContent = $(this).find("textarea").val();

			if(cContent.length == 0){
				alert("댓글을 입력하세요.");
				$(this).find("textarea").focus();
				event.preventDefault();	
			}  
		});
		
		function complaintComment(id) {
			var popupWidth = 300;
			var popupHeight = 500;
			var popupX = (window.screen.width/2)-(popupWidth/2);
			var popupY= (window.screen.height/2)-(popupHeight/2);
			url = "complaint/complaintDetail.jsp?cNum="+id+"&coType=3";
			open(url,"complaintComment", 'status=no, height=' + popupHeight  + ', width=' + popupWidth  + ', left='+ popupX + ', top='+ popupY);
		}//end complaintComment
		$(".complaintComment").click(function() {
			complaintComment(this.id);
		});
	});
<%}%>
</script>
    <!-- 댓글 기능 표시 시작 지점 --------------------------------------- -->
    <div id="comments_div" class="container footerfix" style="max-width: 1100px"> <!-- 댓글 전체 div -->
       <div style="text-align : left; font-weight: bolder; margin-left: 20px"><h2>댓글 (<%=comments.size()%>)</h2></div>
       <hr>
      <%for(CommentsDTO cDTO : comments) {%>
      	<!-- 댓글 하나 하나 반복 동작 -->
      	<%if(cDTO.getcLevel()==1) {%>
      		<div class="comment my-3 p-2 bg-white rounded shadow-sm">
      	<%} else {%>
      		<div class="comment my-3 p-2 alert-secondary rounded shadow" style="padding-top: 10px; margin-left: <%=40*(cDTO.getcLevel()-1)%>px">
      	<%} %>
	      	<div id="userInfo_div"> <!-- 상단 유저 정보 div -->
	      	  <table>
	      	    <tr>
	      		  <td>
	      			<img id="profileImage" class="img-fluid rounded mb-4 mb-lg-0" src="/Dong-Dong/images/profile/<%=cDTO.getUserimage()%>" width="70px" height="">
	      		  </td>
	      		  <td >
	      			<div style="margin-left: 10px;"><h5><%=cDTO.getNickName()%></h5></div>
	      			<div style="margin-left: 10px;">
					  <%if(cDTO.getUpdateDate()==null){%>
	      				<%=(cDTO.getCreateDate()).substring(0, cDTO.getCreateDate().length()-3) %>
	      			  <%} else {%>
	      				<%=(cDTO.getUpdateDate()).substring(0, cDTO.getCreateDate().length()-3) %>(수정됨)
	      			  <%} %>
					</div>
	      		  </td>
	      		</tr>
	      	  </table>
	      	</div>
	      	
	      	
	      	<div id="comment_div"> <!-- 하단 내용 & 버튼 div -->
	      		<div style="margin-top:10px; margin-left:5px">
	      			<h5>
      				  <%=cDTO.getcContent() %>
      				</h5>
	      		</div>
	      		
	      		<div style="text-align : right">
	      		<%if(!status) {%>
	      			<%if(dto!=null) {%>
      					<a class="btn reply_comment btn-outline-primary btn-sm" href="javascript:" id="<%=cDTO.getcNum()%>">답글</a>
      				  <%if(cDTO.getUserid().equals(dto.getUserid())) {%>
      					<a class="btn update_comment btn-outline-primary btn-sm" href="javascript:" id="<%=cDTO.getcNum()%>">수정</a>
      					<a class="btn btn-outline-danger btn-sm" href="CommentsDeleteServlet?pNum=<%=pNum%>&cNum=<%=cDTO.getcNum()%>">삭제</a>
      				  <%} %>
      				<%} %>
     			<%} %>
     			<%if(dto!=null && !cDTO.getUserid().equals(dto.getUserid())) {%>
     				<a class="btn complaintComment btn-outline-danger btn-sm" href="javascript:" id="<%=cDTO.getcNum()%>">신고</a>
     			<%} %>
	      		</div>
     			<%if(!status) {%>
	      		<div>
	      		  <div class="comment-form well">
     			    <form class="comment-reply-form" action="CommentsWriteServlet" method="post">
      			  	  <label for="contactComment"></label> 
      				  <input type="hidden" name="pNum" value="<%=pNum%>"/>
      				  <input type="hidden" name="parentNum" value="<%=cDTO.getcNum()%>"/>
    			  	  <textarea rows="3" class="form-control" name="cContent" style="resize: none;"></textarea> 
      			  	  <div style="text-align : right" >
      			  	  	<input type="submit" class="btn btn-outline-primary btn-block btn-sm" value="답글"/>
      			      </div>
      			    </form>
   			      </div>
      			  <%if(dto!=null && dto.getUserid().equals(cDTO.getUserid())) %>
      			  <div class="comment-form well">
     			    <form class="comment-update-form" action="CommentsUpdateServlet" method="post">
      			  	  <label for="contactComment"></label> 
      				  <input type="hidden" name="pNum" value="<%=pNum%>"/>
      				  <input type="hidden" name="cNum" value="<%=cDTO.getcNum()%>"/>
    			  	  <textarea rows="3" class="form-control" name="cContent" style="resize: none;"></textarea> 
      			  	  <div style="text-align : right" >
      			  	  	<input type="submit" class="btn btn-outline-primary btn-block btn-sm" value="수정"/>
      			   	  </div>
      			    </form>
   			      </div>
	      		</div>
	      		<%} %>
	      	</div>
      	</div>
      <%}%>
      <%if(status) {
      }
      else if(dto==null) {%>
      <div style="margin-bottom: 10px">
    	<a class="btn btn-primary" href="LoginUIServlet">로그인 후 댓글 작성이 가능합니다.</a>
      </div>
	    <%} else  {%>
	    <div class="comment-form well" style="margin-bottom: 10px">
	     <form action="CommentsWriteServlet" method="post">
	      	<label for="contactComment"></label> 
	      	<input type="hidden" name="pNum" value="<%=pNum%>"/>
	    	<textarea rows="3" class="form-control" name="cContent" style="resize: none;"></textarea>
	    	<div style="text-align : right" >
	    		<input type="submit" class="btn btn-outline-primary btn-block btn-sm" value="댓글"/>
	    	</div>
	      </form>
	    </div>
	    <%} %>
    </div>
    
    <jsp:include page="../layout/bottom.jsp" flush="true"></jsp:include>
    

    