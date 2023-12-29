<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
	<head>
		<meta charset="UTF-8">
		<title>새로마켓</title>
		<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
		<script src="<c:url value='/cdn/js/daumPost.js'/>"></script>
		<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	</head>
	
	<body>
		<h1>개인정보 입력</h1>
	
		<form id="frmJoin" method="POST" action="<c:url value='/joinProcess'/>">
			<input type="text" id="id" name="member_id" placeholder="아이디"><br>
			<input type="password" id="pw" name="member_pw" placeholder="비밀번호"><br>
			<input type="password" id="pw2" name="member_pw2" placeholder="비밀번호 확인"><br>
			<input type="text" id="name" name="member_name" placeholder="이름"><br>
			<input type="text" id="phone" name="member_phone" placeholder="전화번호"><br>
			<input type="text" id="email" name="member_email" placeholder="이메일"><br>
			<div id="condition_msg"></div>
			<hr>
			<input type="button" onclick="daumPost()" value="우편주소찾기">
			<input type="text" id="addr1" name="member_addr1" placeholder="우편번호"><br>
			<input type="text" id="addr2" name="member_addr2" placeholder="주소"><br>
			<input type="text" id="addr3" name="member_addr3" placeholder="상세주소"><br>
			<hr>
			<input type="button" id="btnJoinProcess" value="회원가입"><br>
		</form>
		
		<!-- 다음 주소 api -->
		<script>
			function reg() {
				var addr1 = $("#addr1").val()
				var addr2 = $("#addr2").val()
				var addr3 = $("#addr3").val()
				var addr = addr1 +"/"+addr2+"/"+addr3
				$("addr1").val(addr)
				fo.submit()
			}
		</script>
		
		<!-- 폼 전송 -->
		<script>
		    document.getElementById('btnJoinProcess').addEventListener('click', function(){
		        // 모든 필드의 보더 초기화
		        resetBorders();
		        checkForm();
		    });
		</script>
		
		<!-- 폼 체크  -->
		<script>
		    function checkForm() {
		        var id = $("#id").val();
		        var pw = $("#pw").val();
		        var pw2 = $("#pw2").val();
		        var name = $("#name").val();
		        var phone = $("#phone").val();
		        var email = $("#email").val();
		        var addr1 = $("#addr1").val();
		        var addr2 = $("#addr2").val();
		        var addr3 = $("#addr3").val();
		
		        // 필드 순서대로 확인
		        if (id === "") {
		            showAlert("아이디를 입력해 주세요.", "id");
		        } else if (pw === "") {
		            showAlert("비밀번호를 입력해 주세요.", "pw");
		        } else if (pw2 === "") {
		            showAlert("비밀번호 확인을 입력해 주세요.", "pw2");
		        } else if (pw !== pw2) {
		            showAlert("비밀번호와 비밀번호 확인이 일치하지 않습니다.", "pw");
		        } else if (name === "") {
		            showAlert("이름을 입력해 주세요.", "name");
		        } else if (phone === "") {
		            showAlert("전화번호를 입력해 주세요.", "phone");
		        } else if (email === "") {
		            showAlert("이메일을 입력해 주세요.", "email");
		        } else if (addr1 === "") {
		            showAlert("우편번호를 입력해 주세요.", "addr1");
		        } else if (addr2 === "") {
		            showAlert("주소를 입력해 주세요.", "addr2");
		        } else if (addr3 === "") {
		            showAlert("상세주소를 입력해 주세요.", "addr3");
		        } else {
		            // 모든 필드가 채워져 있을 경우에는 폼 제출
		            document.getElementById('frmJoin').submit();
		        }
		    }
		
		    function showAlert(message, fieldId) {
		        alert(message);
		        $("#" + fieldId).css("border", "1px solid red");
		        $("#" + fieldId).focus();
		    }
		
		    function resetBorders() {
		        // 모든 필드의 보더 초기화
		        $("#id, #pw, #pw2, #name, #phone, #email, #addr1, #addr2, #addr3").css("border", "");
		    }
		</script>
	</body>
</html>