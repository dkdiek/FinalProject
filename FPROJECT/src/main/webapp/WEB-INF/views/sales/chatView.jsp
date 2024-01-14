<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
	<title>SPRING_PROJECT</title>
	<script src="/resources/js/jquery-2.1.1.min.js"></script>
	<script type="text/javascript">
	
	
	    $(function(){
	    	
			var seller_id = "${infoMap.seller_id}";
	    	var buyer_id = "${infoMap.buyer_id}";
	    	 console.log("Seller ID:", seller_id);
    	    console.log("Buyer ID:", buyer_id);
			var ws = new WebSocket("ws://192.168.111.1/chatView");

			ws.onopen = function(){
			};
			
			ws.onclose = function(){
			};
			
			ws.onmessage = function(message){
				$("#log").append(message.data).append("<br/>");
				$("#message").val("")
			};
			
			ws.onerror = function(event){
				alert("에러발생");
			};
			
			$("#form").submit(function(){
				ws.send($("#message").val());
				return false;
			});
	    });
	    
	</script>
		<body>
		<a href="/">HOME</a>
		<br>
		<h1>웹소켓 채팅</h1>
		<div id="log"></div>
		<p></p>
	  	<form id="form" action="#">
			<input type="text" id="message" />
			<input type="submit" id="send" value="전송" />
		</form>   
	</body>
</html>
