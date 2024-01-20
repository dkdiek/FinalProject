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
		<div class="d-flex justify-content-center align-items-center mt-5">
			<h4>
				<span class="badge bg-primary-subtle text-primary-emphasis rounded-pill">♥ ${id}님의 관심 리스트</span>
			</h4>
		</div>
		<div class="container mt-5">
			<div class="row">
				<c:forEach var="like" items="${likeList}">
					<div class="col-2 rounded-circle">
					    <div class="position-relative" style="width: 200px; height: 200px; overflow: hidden;">
					        <!-- 이미지 -->
					        <a href="<c:url value='detail?seq=${like.seq}'/>">
					            <img class="rounded-circle" src="<c:url value='cdn/upload/${like.img1}'/>" alt="Image 1" class="img-fluid" style="width: 100%; height: 100%; object-fit: cover;">
					        </a>
					        
					        <!-- 텍스트 배경 -->
					        <div class="position-absolute top-50 start-50 translate-middle text-center fs-6" style="z-index: 2; color: #fff; background-color: rgba(0, 0, 0, 0.5); padding: 10px;">
					            ${like.title}
					        </div>
					    </div>
					</div>


				    
				</c:forEach>
			</div>
		</div>

		<!-- footer -->
        <%@ include file="../../common/footer.jsp" %>
        
        <!-- 디테일로 링크 -->
        <script>
		    function redirectToDetail(seq) {
		        window.location.href = '<c:url value="/detail?seq=" />' + seq;
		    }
		</script>
		<script>
		    document.addEventListener('DOMContentLoaded', function() {
		        var trElements = document.querySelectorAll('.custom-pointer');
		
		        trElements.forEach(function(trElement) {
		            // 마우스 오버 시 이벤트 리스너 추가
		            trElement.addEventListener('mouseover', function() {
		                // 포인터 스타일 변경
		                trElement.style.cursor = 'pointer';
		            });
		
		            // 마우스 아웃 시 이벤트 리스너 추가 (원래 스타일로 복원)
		            trElement.addEventListener('mouseout', function() {
		                // 포인터 스타일 원래대로 복원
		                trElement.style.cursor = 'default';
		            });
		        });
		    });
		</script>
               
    </body>
</html>