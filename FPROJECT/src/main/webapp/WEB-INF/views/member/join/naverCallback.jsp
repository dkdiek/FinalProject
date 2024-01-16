<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!doctype html>
<html lang="en" data-bs-theme="auto">
	<!-- head -->
	<%@ include file="../../common/head.jsp" %>
	
	<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
	<!-- body -->
	<body>
			<script type="text/javascript">
				var naver_id_login = new naver_id_login("azdDptdhj5zpBKzKMGuq",	"http://localhost/naverCallback");
				// 접근 토큰 값 출력
				var access_token = naver_id_login.oauthParams.access_token;
				alert(access_token)
		
				// 네이버 사용자 프로필 조회
				naver_id_login.get_naver_userprofile("naverSignInCallback()");
				// 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
				function naverSignInCallback() {
					var email = naver_id_login.getProfileData('email');
					var name = naver_id_login.getProfileData('name');
		
					alert(email)
					alert(name)
		
					// 서버로 보내서 회원 확인 및 로그인 처리하고 응답받기
					
							$.ajax({
								type : "POST",
								url : "/naverLogin",
								contentType : "application/json; charset=utf-8",
								data : JSON.stringify({
									email : email,
									name : name,
									token : access_token
								})/* ,
								success : function(responseResult) {
									// Handle the server response as needed
									if (responseResult.result == "existing_member") {
										// Redirect or perform other actions on success
										alert('회원 정보 전송 성공');
										window.location.href = "/";
									} else if (responseResult.result == "new_member") {
										// 회원이 아니면 회원 가입페이지로 보낸다
										alert('회원 가입이 필요합니다');

												 $.ajax({
													type : "POST",
													url : "/joinNaverMember",
													contentType : "application/json; charset=utf-8",
													data : JSON.stringify({
														member_id : email,
														name : name
													}),
													success : function(joinResponse) {
														// Additional logic after joining
														alert('회원 가입 성공');
														window.location.href = "/";
													},
													error : function(joinError) {
														console.error("회원 가입 에러:",
																joinError);
														window.location.href = "/errorPage?errorMessage="
																+ encodeURIComponent("에러가 발생했습니다");
													}
												});
									}
								},
								error : function(error) {
									console.error("에러:", error);
									window.location.href = "/errorPage?errorMessage="
											+ encodeURIComponent("에러가 발생했습니다");
								} */
							})
							.done(function(responseResult) {
							    // Handle the server response as needed
							    if (responseResult.result == "existing_member") {
							        // 기존 회원의 경우
							        alert('기존 회원입니다.');
							        // 다른 동작 수행...
							    } else if (responseResult.result == "new_member") {
							        // 신규 회원의 경우
							        alert('신규 회원입니다.');
							        // 다른 동작 수행...
							    }
							})
							.fail(function(error) {
							    console.error("에러:", error);
							    window.location.href = "/errorPage?errorMessage=" + encodeURIComponent("에러가 발생했습니다");
							});
		
				}	
			</script>
</body>	

		
		
</html>