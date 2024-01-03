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
		<!-- header -->
		<%@ include file="../../common/header.jsp" %>
		<!-- main -->
		<main>
			<h1>회원가입 결과</h1>
    
			    <c:choose>
			        <c:when test="${result eq '1'}">
			            <p>회원가입이 성공적으로 완료되었습니다.</p>
			        </c:when>
			        <c:when test="${result eq '0'}">
			            <p>회원가입 중 오류가 발생했습니다. 다시 시도해 주세요.</p>
			        </c:when>
			        <c:otherwise>
			            <p>알 수 없는 오류가 발생했습니다.</p>
			        </c:otherwise>
			    </c:choose>
			    
			    <p><a href="/">홈으로 돌아가기</a></p>
			
		</main>
		
		<!-- Footer -->
		<%@ include file="../../common/footer.jsp" %>
		
	</body>
</html>