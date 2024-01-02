<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!doctype html>
<html lang="en" data-bs-theme="auto">
	<head>
		<!-- 수정된 부트스트랩 CSS 파일 경로 -->
		<script src="/cdn/js/bootstrap/color-modes.js"></script>
		<script src="/cdn/js/bootstrap/bootstrap.bundle.min.js"></script>
		<link rel="canonical" href="https://getbootstrap.kr/docs/5.3/examples/album/">
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@docsearch/css@3">
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
		<link rel="stylesheet" href="/cdn/css/bootstrap/bootstrap.min.css" rel="stylesheet">
		<!-- favicon -->
		<link rel="shortcut icon" href="/cdn/images/favicon.ico" type="image/x-icon" />
    	<link rel="icon" href="/cdn/images/favicon.ico" type="image/x-icon" />
		<!-- daum -->
		<script src="<c:url value='/cdn/js/daumPost.js'/>"></script>
		<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
   	  	
   	  	<script src="/cdn/js/jquery-3.7.1.min.js"></script>
   	  	   		<link rel="stylesheet" href="/cdn/css/home.css">
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta name="description" content="새로마켓에서 모든 것이 새로워진다!">
		<meta name="author" content="Yongkwon Lee">
		<meta name="generator" content="Hugo 0.115.4">
		<title>새로마켓</title>
	</head>
	</head>
	
	<body class="bg-light">

    <div class="container py-5">
        <h1 class="mb-4">회원 가입</h1>

        <form id="frmJoin" method="POST" action="<c:url value='/joinMembership2'/>">
            <div class="mb-3">
                <label for="id" class="form-label">아이디</label>
                <input type="text" id="id" name="member_id" class="form-control" placeholder="아이디">
            </div>
            <div class="mb-3">
                <label for="pw" class="form-label">비밀번호</label>
                <input type="password" id="pw" name="member_pw" class="form-control" placeholder="비밀번호">
            </div>
            <div class="mb-3">
                <label for="pw2" class="form-label">비밀번호 확인</label>
                <input type="password" id="pw2" name="member_pw2" class="form-control" placeholder="비밀번호 확인">
            </div>
            <div class="mb-3">
                <label for="name" class="form-label">이름</label>
                <input type="text" id="name" name="member_name" class="form-control" placeholder="이름">
            </div>
            <div class="mb-3">
                <label for="phone" class="form-label">전화번호</label>
                <input type="text" id="phone" name="member_phone" class="form-control" placeholder="전화번호">
            </div>
            <div class="mb-3">
                <label for="email" class="form-label">이메일</label>
                <input type="text" id="email" name="member_email" class="form-control" placeholder="이메일">
            </div>

            <div class="mb-3">
                <button type="button" onclick="daumPost()" class="btn btn-primary me-2">우편 주소 찾기</button>
            </div>
            <div class="mb-3">
                <label for="addr1" class="form-label">우편번호</label>
                <input type="text" id="addr1" name="member_addr1" class="form-control" placeholder="우편번호" readonly>
            </div>
            <div class="mb-3">
                <label for="addr2" class="form-label">주소</label>
                <input type="text" id="addr2" name="member_addr2" class="form-control" placeholder="주소" readonly>
            </div>
            <div class="mb-3">
                <label for="addr3" class="form-label">상세 주소</label>
                <input type="text" id="addr3" name="member_addr3" class="form-control" placeholder="상세 주소">
            </div>

            <div class="mb-3">
                <button type="button" id="btnConfirm" class="btn btn-primary">확인</button>
                <a href="/" id="btnCancel" class="btn btn-secondary">취소</a>
            </div>
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