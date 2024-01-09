<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!doctype html>
<html lang="en">
    <!-- head -->
    <%@ include file="../../common/head.jsp" %>
    <!-- body -->
    <body class="bg-body-tertiary">
        <!-- header -->
        <%@ include file="../../common/header.jsp" %>
        <!-- main -->
			  			
			 <div class="mx-auto col-md-6 col-lg-4 py-5" >

				<form id="loginForm">
					<div class="text-center">회원 정보 변경을 위해 비밀번호를 입력해 주세요.</div>
					<div class="frmCheckAccount" method="post">
						<input type="hidden" id="member_id" name="member_id" value="${sessionScope.id}">
						<input type="password" class="form-control rounded-3" id="member_pw" name="member_pw">
						<label for="password">비밀번호</label>
					</div>
					<button id="btnSubmit"
						class="w-100 mb-2 btn btn-lg rounded-3 btn-primary" type="button">확인</button>
				</form>
			 
			</div>
        
        <!-- footer -->
        <%@ include file="../../common/footer.jsp" %>
        
       <script>
		    $(document).ready(function () {
		        $("#btnSubmit").click(function () {
		            var memberId = $("#member_id").val();
		            var memberPw = $("#member_pw").val();
		
		            $.ajax({
		                type: "POST",
		                url: "/checkMemberAccount", // 전송할 서버 URL
		                data: {
		                    member_id: memberId,
		                    member_pw: memberPw
		                },
		                success: function (response) {
		                    // 서버로부터의 응답 처리
		                    console.log(response);
		                },
		                error: function (error) {
		                    // 오류 발생 시 처리
		                    console.error("에러가 발생했습니다 다시 시도해 주세요");
		                }
		            });
		        });
		    });
		</script>
               
    </body>
</html>