<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- <!DOCTYPE html>
<html>
	<head>
		<title>새로마켓</title>
		<link rel="shortcut icon" href="/cdn/images/favicon.ico" type="image/x-icon" />
    	<link rel="icon" href="/cdn/images/favicon.ico" type="image/x-icon" />
	</head>
	<body>
		<h1>회원 가입</h1>
		<div>
			<span>
				ID<input type="text">
			</span>
			<span>
				비밀번호<input type="password">
			</span>
			<span>
				비밀번호 확인<input type="password">
			</span>
			<span>
				이름<input type="text">
			</span>
			<span>
				전화번호<input type="number">
			</span>
		</div>
		
		
					
	</body>
</html> -->

<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="<c:url value='/cdn/js/daumPost.js'/>"></script>
<script type="text/javascript">
function reg() {
	var addr1 = $("#addr1").val()
	var addr2 = $("#addr2").val()
	var addr3 = $("#addr3").val()
	var addr = addr1 +"/"+addr2+"/"+addr3
	$("addr1").val(addr)
	fo.submit()
}

</script>
</head>

<body>

<form action="join" method="POST">
<input type="text" name="id" placeholder="아이디입력"><br>
<input type="password" name="pw" placeholder="비밀번호 입력"><br>
<input type="text" id="addr1" name="addr" placeholder="우편번호"><br>
<input type="button" onclick="daumPost()" value="우편주소찾기">
<input type="text" id="addr2"  placeholder="주소"><br>
<input type="text" id="addr3" placeholder="상세주소"><br>
<input type="button" onclick="reg()"value="회원가입"><br>

</form>

</body>
</html>