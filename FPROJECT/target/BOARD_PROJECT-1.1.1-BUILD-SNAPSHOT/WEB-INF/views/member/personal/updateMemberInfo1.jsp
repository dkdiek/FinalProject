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
			  			
			 <div class="mx-auto col-md-6 col-lg-4 py-5">
			    <div class="text-center">회원 정보 변경을 위해 비밀번호를 입력해 주세요.</div>
			    <div class="frmCheckAccount">
			        <input type="hidden" id="member_id"value="${sessionScope.id}">
			        <input type="password" class="form-control rounded-3" id="member_pw">
			    </div>
			    <button id="btnCheckAccount" class="w-100 mb-2 btn btn-lg rounded-3 btn-primary" type="button">확인  </button>
			</div>
        
        <!-- footer -->
        <%@ include file="../../common/footer.jsp" %>
        <form id="frm1" action="<c:url value='/updateMemberInfo2'/>" method="post"></form>
     	<script>
	       $(document).ready(function () {
	    	    $("#btnCheckAccount").click(function () {
	    	        var memberId = $("#member_id").val();
	    	        var memberPw = $("#member_pw").val();
	
	    	        $.ajax({
	    	            type: "POST",
	    	            url: "/checkMemberAccount",
	    	            contentType: 'application/json', // JSON 형식으로 전송
	    	            data: JSON.stringify({
	    	                member_id: memberId,
	    	                member_pw: memberPw
	    	            }),
	    	            dataType: 'json',
	    	            success: function (response) {
	    	                console.log(response);
	    	                if (response.message =='confirm') {
	    	                    console.log('success');
	    	                	$('#frm1').submit();
	    	                } else {
	    	                    // 실패한 경우 errorPage.jsp로 리다이렉션 또는 다른 처리
	    	                    if (response.message === "fail") {
	    	                        window.location.href = "/errorPage";
	    	                    } else {
	    	                        // 다른 실패 상황에 대한 처리
	    	                        console.error("기타 에러가 발생했습니다: " + response.message);
	    	                    }
	    	                }
	    	            },
	    	            error: function (error) {
	    	            	window.location.href = '/errorPage';
	    	                console.error("에러가 발생했습니다 다시 시도해 주세요");
	    	            }
	    	        });
	    	    });
	    	});
		</script>
		
		
    </body>
</html>