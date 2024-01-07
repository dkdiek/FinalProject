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
        <c:choose>
	        <c:when test="${empty boardList}">
	            <!-- 조회 결과가 없을 때의 메시지 -->
	             <div class="container mt-5">
				    <div class="row text-center">
					    <div class="col-12 text-center">
					    	<div class="w-25 mx-auto">
						        <img class="w-50 mx-auto" src="<c:url value='/cdn/images/common/notice.png'/>">
					    	</div>
					    </div>
					</div>
				    <div class="p-5 text-center justify-content-center bg-body-tertiary rounded-3">
				        <h1 class="text-body-emphasis fs-3">조건에 맞는 게시물이 없습니다</h1>
				        <p class="col-lg-8 mx-auto fs-5 text-muted">
				            다른 조건으로 다시 검색해 주세요
				        </p>
				    </div>
				</div>
	        </c:when>
        	<c:otherwise>
        	
			<div class="container mt-5 col-6">
			    <div class="row ">
			        <table class=" table table-borderless table-hover table-sm  table-striped border border-secondary border-opacity-50 rounded">
			            <tbody>
			                <c:forEach var="board" items="${boardList}">
			                    <tr onclick="redirectToDetail(${board.seq})" class="custom-pointer">
			                        <td style="width: 100px; height: 100px; overflow: hidden;">
			                            <img src="<c:url value='/cdn/upload/${board.img1}' />" alt="Image" style="width: 100%; height: 100%; object-fit: cover;">
			                        </td>
			                        <td class="overflow-hidden text-truncate fs-6" style=" vertical-align: middle" >
			                        	 <span class="fw-bold ms-4"> ${board.title}</span>
			                        	 <c:if test="${board.soldout_yn eq 'y'}">
											<span class="badge rounded-pill text-bg-primary fw-medium" style="font-size:13px">판매 완료</span>
										</c:if>
			                        	 <br>
			                        	<i class="bi bi-cash ms-4 me-2"></i> <fmt:formatNumber value="${board.price}" pattern="#,###원" /><br>
			                        	<i class="bi bi-geo-alt ms-4 me-2"></i> ${board.address}	
		                        	</td>
		                        	<td class="overflow-hidden text-truncate fs-6" style=" vertical-align: middle" >
			                        	<i class="bi bi-heart me-2"></i> ${board.like_cnt}<br>
			                        	<i class="bi bi-eye me-2"></i> ${board.view_cnt}<br>
			                        	<i class="bi bi-clock me-2"></i>
			                        	<span class="text-body-secondary">
										 	<c:out value="${board.formattedDifference}" />
										</span>
		                        	</td>
			                    </tr>
			                </c:forEach>
			            </tbody>
			        </table>
			    </div>
			</div>
	
					<!-- 페이징 처리 -->
					<div class="row">
					    <div class="col">
					        <nav aria-label="Page navigation">
					            <ul class="pagination justify-content-center">
					                <c:forEach begin="0" end="${totalPages-1}" varStatus="i">
					                    <c:set var="pageLink" value="?page=${i.index+1}" />
					
					                    <!-- 검색 조건이 있는 경우 -->
					                    <c:if test="${not empty param.title}">
					                        <c:set var="pageLink" value="${pageLink}&title=${param.title}" />
					                    </c:if>
					                    <c:if test="${not empty param.seller_id}">
					                        <c:set var="pageLink" value="${pageLink}&seller_id=${param.seller_id}" />
					                    </c:if>
					                    <c:if test="${not empty param.category}">
					                        <c:set var="pageLink" value="${pageLink}&category=${param.category}" />
					                    </c:if>
					
					                    <li class="page-item ${currentPage == i.index + 1 ? 'active' : ''}">
					                        <a class="page-link" href="${pageLink}">${i.index + 1}</a>
					                    </li>
					                </c:forEach>
					            </ul>
					        </nav>
					    </div>
					</div>
			</c:otherwise>
        </c:choose>
        <!-- footer -->
        <%@ include file="../common/footer.jsp" %>
        
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