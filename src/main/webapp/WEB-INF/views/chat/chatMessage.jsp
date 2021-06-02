<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<meta charset="UTF-8">
<title>Chatting</title>
<style>
* {
	margin: 0;
	padding: 0;
}

.container {
	width: 500px;
	margin: 0 auto;
	padding: 25px
}

.container h1 {
	text-align: left;
	padding: 5px 5px 5px 15px;
	color: #FFBB00;
	border-left: 3px solid #FFBB00;
	margin-bottom: 20px;
}

.chating {
	background-color: #000;
	width: 500px;
	height: 500px;
	overflow: auto;
}

.chating .me {
	color: #F6F6F6;
	text-align: right;
}

.chating .others {
	color: #FFE400;
	text-align: left;
}

input {
	width: 330px;
	height: 25px;
}

</style>
</head>

<script type="text/javascript">
	$(document).ready(connect);
	var stompClient = null;
	var userId = $('#userId').val();
	var chatId = $("#chatid").val();

	function connect() {
		console.log("connected");
		var sockJS = new SockJS('/sockJS');
		var urlSubscribe = '/subscribe/' + chatid;
		stompClient = Stomp.over(sockJS);
		stompClient.connect({}, function() {
			stompClient.subscribe(urlSubscribe, function(output) {
				showBroadcastMessage(createTextNode(JSON.parse(output.body)));
			});
		}, function(err) {
			alert('error' + err);
		});
	};

	function sendBroadcast(json) {
		stompClient.send('/send/chatMessage', {}, JSON.stringify(json));
	}

	function getTime() {
		var today = new Date();
		var date = today.getFullYear() + '년 ' + (today.getMonth() + 1) + '월 '
				+ today.getDate() + '일';
		var minutes = today.getMinutes() + "";
		if (minutes.length == 1)
			minutes = '0' + minutes;
		var time = today.getHours() + ":" + minutes;
		var datetime = date + ' ' + time;
		return datetime;
	}

	function send() {
		var content = $('#message').val();
		var datetime = getTime();
		sendBroadcast({
			'userId' : userId,
			'message' : content,
			'sendtime' : datetime,
			'chatId' : chatId
		});
		$('#message').val("");
	}

	var inputMessage = document.getElementById('message');
	inputMessage.addEventListener('keyup', function enterSend(event) {
		if (event.keyCode === null) {
			event.preventDefault();
		}
		if (event.keyCode === 13) {
			send();
		}
	});

	function createTextNode(messageObj) {
		return '<p><div class="row alert alert-info"><div class="col_8">'
				+ messageObj.fromname + '</div><div class="col_4 text-right">'
				+ messageObj.message + '</div><div>' + messageObj.sendtime
				+ '</div></p>';
	}

	function showBroadcastMessage(message) {
		$("#content").html($("#content").html() + message);
	}
</script>
<body>
	<div id="container" class="container">
		<h1>채팅</h1>
		<input type="hidden" id="sessionId" value="">

		<div id="chating" class="chating"></div>

		<div id="Msg">
			<table class="inputTable">
				<tr>
					<th>메시지</th>
					<th><input id="message" placeholder="보내실 메시지를 입력하세요."></th>
					<th><button onclick="send()" id="send">보내기</button>
						<input type="hidden" value="${login.userId()}" id="userId"/>
						<input type="hidden" value="${chatId}" id="chatId"/>
					</th>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>