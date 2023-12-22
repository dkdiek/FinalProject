<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
	<head>
		<title>새로마켓</title>
		<link rel="shortcut icon" href="/cdn/images/favicon.ico" type="image/x-icon" />
    	<link rel="icon" href="/cdn/images/favicon.ico" type="image/x-icon" />
	</head>
	<body>
		<h1>회원 가입</h1>
		
		<div id="agreement">
		
			<div id="agreement1">
				<h3>이용약관</h3>
				<div id="agreement1-content"></div>
				<form>
				    <label>
				        <input type="checkbox" name="checkbox"> 위 이용약관에 동의합니다
				    </label>
				</form>
			</div>
			
			<div id="agreement2">
				<h3>개인정보 수집 및 이용에 대한 안내</h3>
				<div id="agreement2"></div>
				<form>
				    <label>
				        <input type="checkbox" name="checkbox"> 위의 개인정보 수집 및 이용에 대한 안내에 동의합니다
				    </label>
				</form>
			</div>
		
		</div>
		
		<div id="agreementRecheck">
			<form>
			    <label>
			        <input type="checkbox" name="checkbox"> 위의 이용약관 및 개인정보 수집 및 이용에 대한 안내에 동의합니다.
			    </label>
			</form>
		</div>
		
		<div>
			<form id="frm1" action="<c:url value='/member/join/joinMember2'/>" method="GET">
				<input id="btnConfirm" name="confirm" type="button" value="확인">
				<input id="btnCancel" type="button" value="취소">
			</form>
		</div>
		
	</body>
	
	<script>
    document.getElementById('btnConfirm').addEventListener('click', function () {
        // 각 체크박스의 상태를 확인
        var checkboxes = document.getElementsByName('checkbox');

        // 모든 체크박스가 선택되었는지 확인
        var allChecked = true;
        for (var i = 0; i < checkboxes.length; i++) {
            if (!checkboxes[i].checked) {
                allChecked = false;
                break;
            }
        }

        if (allChecked) {
            // 모든 체크박스가 선택되었을 경우 페이지 이동
            document.getElementById('frm1').submit();
        } else {
            // 선택되지 않은 항목이 있다면 알림창 표시
            alert('모든 항목에 동의해 주세요.');
        }
    });

    document.getElementById('btnCancel').addEventListener('click', function () {
        // 취소 버튼 클릭 시 홈페이지로 이동
        window.location.href = '/';
    });
</script>

</html>