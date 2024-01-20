<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!doctype html>
<html lang="en" data-bs-theme="auto">
	<!-- head -->
	<%@ include file="../../common/head.jsp" %>
	<!-- body -->
	<body>
		
			<%--네이버 로그인 후 정보 받아서 컨트롤러로 넘기는 브릿지 페이지 
				<form id="naverLoginFrm" method="post" action="<c:url value='/naverLogin'/>">
				<input type="text" name="member_id" id="member_id" value="1">
				<input type="text" name="name" id="name" value="1">
				<input type="text" name="token" id="token" value="1">
			</form> --%>
	
			<script type="text/javascript">
				var naver_id_login = new naver_id_login("azdDptdhj5zpBKzKMGuq",	"http://3.34.20.9/naverCallback");
				var email = naver_id_login.getProfileData('email');
				var name = naver_id_login.getProfileData('name')
				var access_token = naver_id_login.oauthParams.access_token;
				
				function naverSignInCallback() {
					email = naver_id_login.getProfileData('email');
					name = naver_id_login.getProfileData('name');
					access_token = naver_id_login.oauthParams.access_token;
				
				}
					/* alert(email)
					alert(name)
					alert(access_token) */
				
				naver_id_login.get_naver_userprofile("naverSignInCallback()");
				
				
				// 폼 데이터 설정
			    var formData = {
			        member_id: email,
			        name: name,
			        token: access_token
			    };

			    // 동적으로 폼 생성
			    var form = document.createElement('form');
			    form.method = 'POST';
			    form.action = "<c:url value='/naverLogin'/>";

			    // 폼 데이터를 폼에 추가
			    for (var key in formData) {
			        if (formData.hasOwnProperty(key)) {
			            var inputField = document.createElement('input');
			            inputField.type = 'hidden';
			            inputField.name = key;
			            inputField.value = formData[key];
			            form.appendChild(inputField);
			        }
			    }

			    // 폼을 body에 추가하고 서버로 전송
			    document.body.appendChild(form);
			    form.submit();
				
			</script>
			
	
			
	</body>	
</html>