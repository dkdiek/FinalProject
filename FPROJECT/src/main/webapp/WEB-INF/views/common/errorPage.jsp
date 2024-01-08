<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!doctype html>
<html lang="en">
    <!-- head -->
    <%@ include file="../common/head.jsp" %>
    <!-- body -->
    <body class="bg-body-tertiary">
        <!-- header -->
        <%@ include file="../common/header.jsp" %>
        <!-- main -->
            <!-- 조회 결과가 없을 때의 메시지 -->
             <div class="container my-5">
			    <div class="row">
			        <div class="col-12 d-flex justify-content-center">
			            <p class="col-2 mt-3">
			                <img class="img-fluid" src="<c:url value='/cdn/images/common/notice.png'/>">
			            </p>
			        </div>
			    </div>
			    <div class="p-5 text-center justify-content-center bg-body-tertiary rounded-3">
			        <h1 class="text-body-emphasis">오류가 발생하였습니다</h1>
			        <p class="col-lg-8 mx-auto fs-5 text-muted">
			            ${errorMessage}
			        </p>
			    </div>
			</div>
        <!-- footer -->
        <%@ include file="../common/footer.jsp" %>
    </body>
</html>