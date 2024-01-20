<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!doctype html>
<html lang="en" data-bs-theme="auto">
	<!-- head -->
	<%@ include file="../../common/head.jsp" %>
	<!-- body -->
	<body class="bg-body-tertiary">
		<!-- header -->
		<%@ include file="../../common/header.jsp" %>
		<!-- main -->
		<main>
			    <c:choose>
			        <c:when test="${result eq '1'}">
			            <div class="container mt-5">
							<div class="row text-center">
								<div class="col-12 text-center">
									<div class="w-25 mx-auto">
										<img class="w-50 mx-auto"
											src="<c:url value='/cdn/images/common/welcome.png'/>">
									</div>
								</div>
							</div>
							<div
								class="p-5 text-center justify-content-center bg-body-tertiary rounded-3">
								<h1 class="text-body-emphasis fs-3">회원 정보 변경에 성공하였습니다</h1>
								<p class="col-lg-8 mx-auto fs-5 text-muted">안전한 계정 정보를 위해 주기적으로 비밀번호를 변경해 주세요</p>
							</div>
			        </c:when>
			        
			        <c:when test="${result eq '0'}">
						<div class="container mt-5">
							<div class="row text-center">
								<div class="col-12 text-center">
									<div class="w-25 mx-auto">
										<img class="w-50 mx-auto"
											src="<c:url value='/cdn/images/common/notice.png'/>">
									</div>
								</div>
							</div>
							<div
								class="p-5 text-center justify-content-center bg-body-tertiary rounded-3">
								<h1 class="text-body-emphasis fs-3">회원 정보 변겨여에 실패하였습니다</h1>
								<p class="col-lg-8 mx-auto fs-5 text-muted">잠시 후 다시 회원 정보 변경을 진행해
									주세요</p>
							</div>
						</div>
					</c:when>
					
			        <c:otherwise>
			            <div class="container mt-5">
							<div class="row text-center">
								<div class="col-12 text-center">
									<div class="w-25 mx-auto">
										<img class="w-50 mx-auto"
											src="<c:url value='/cdn/images/common/notice.png'/>">
									</div>
								</div>
							</div>
							<div
								class="p-5 text-center justify-content-center bg-body-tertiary rounded-3">
								<h1 class="text-body-emphasis fs-3">오류가 발생하였습니다</h1>
								<p class="col-lg-8 mx-auto fs-5 text-muted">오류가 지속되는 경우 새로마켓 고객지원센터로 문의해 주세요</p>
							</div>
						</div>
			        </c:otherwise>
			        
			    </c:choose>
			    
			    <div class="text-center">
				    <p><a href="/">홈으로 돌아가기</a></p>
			    </div>
			
		</main>
		
		<!-- Footer -->
		<%@ include file="../../common/footer.jsp" %>
		
	</body>
</html>