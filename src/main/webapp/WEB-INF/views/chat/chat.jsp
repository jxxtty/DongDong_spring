<%@page import="com.dto.MemberDTO"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- <%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%> --%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page session="true"%>
<%

	MemberDTO dto = (MemberDTO) session.getAttribute("login");
	String userid = dto.getUserid();

%>

<body>
	<c:set var="userid" value="<%=userid %>" />
    <!-- 로그인한 상태일 경우와 비로그인 상태일 경우의 chat_id설정 -->
    <c:if test="${(userid ne '') and !(empty userid)}">
        <input type="hidden" value='${userid}' id='chat_id' />
    </c:if>
    <c:if test="${(userid eq '') or (empty userid)}">
        <input type="hidden" value='<%=userid %>'
            id='chat_id' />
    </c:if>
    <!--     채팅창 -->
    <div id="_chatbox"> <!-- style="display: none" -->
        <fieldset>
            <div id="messageWindow"></div>
            <br /> <input id="inputMessage" type="text" onkeyup="enterkey()" />
            <input type="submit" value="send" onclick="send()" />
        </fieldset>
    </div>
</body>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
    var textarea = document.getElementById("messageWindow");
    var webSocket = new WebSocket('ws://localhost:8079/broadcasting');
    var inputMessage = document.getElementById('inputMessage');
    webSocket.onerror = function(event) {
        onError(event)
    };
    webSocket.onopen = function(event) {
        onOpen(event)
    };
    webSocket.onmessage = function(event) {
        onMessage(event)
    };
    function onMessage(event) {
        var message = event.data.split("|");
        var sender = message[0];
        var content = message[1];
        if (content == "") {
        
        } else {
        	$("#messageWindow").html($("#messageWindow").html()
                    + "<p class='chat_content'>" + sender + " : " + content + "</p>");
        }
    }
    function onOpen(event) {
        $("#messageWindow").html("<p class='chat_content'>채팅에 참여하였습니다.</p>");
    }
    function onError(event) {
        alert(event.data);
    }
    function send() {
        if (inputMessage.value == "") {
        } else {
            $("#messageWindow").html($("#messageWindow").html()
                + "<p class='chat_content'>나 : " + inputMessage.value + "</p>");
        }
        webSocket.send($("#chat_id").val() + "|" + inputMessage.value);
        inputMessage.value = "";
    }
    //     엔터키를 통해 send함
    function enterkey() {
        if (window.event.keyCode == 13) {
            send();
        }
    }
    //     채팅이 많아져 스크롤바가 넘어가더라도 자동적으로 스크롤바가 내려가게함
    window.setInterval(function() {
        var elem = document.getElementById('messageWindow');
        elem.scrollTop = elem.scrollHeight;
    }, 0);
</script>
