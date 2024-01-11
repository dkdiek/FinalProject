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
		<div class="container mt-5"><!-- 전체 -->
       		<div class="row"><!-- 필터+검색리스트+페이지 -->
	        	<!-- 필터 -->
	        	<div class="col-4">
	        		<!-- 카테고리 선택 -->
	        		<!-- 카테고리 -->
					<div class="container mt-4">
						<label for="category" class="form-label fw-bold">카테고리</label>
						<div class="row">
							<div class="col-md-4">
								<div class="form-check" >
									<input class="form-check-input" type="radio" name="category"
										id="digital" value="디지털기기" required> <label
										class="form-check-label" for="digital">디지털기기</label>
								</div>
								<div class="form-check">
									<input class="form-check-input" type="radio" name="category"
										id="furniture" value="가구/인테리어"> <label
										class="form-check-label" for="furniture">가구/인테리어</label>
								</div>
								<div class="form-check">
									<input class="form-check-input" type="radio" name="category"
										id="baby" value="유아동"> <label class="form-check-label"
										for="baby">유아동</label>
								</div>
								<div class="form-check">
									<input class="form-check-input" type="radio" name="category"
										id="womenClothing" value="여성의류"> <label
										class="form-check-label" for="womenClothing">여성의류</label>
								</div>
								<div class="form-check">
									<input class="form-check-input" type="radio" name="category"
										id="womenAccessories" value="여성잡화"> <label
										class="form-check-label" for="womenAccessories">여성잡화</label>
								</div>
								<div class="form-check">
									<input class="form-check-input" type="radio" name="category"
										id="menFashion" value="남성패션/잡화"> <label
										class="form-check-label" for="menFashion">남성패션/잡화</label>
								</div>
							</div>
	
							<div class="col-md-4">
								<!-- 두 번째 열의 라디오 버튼들 추가 -->
								<div class="form-check">
									<input class="form-check-input" type="radio" name="category"
										id="homeAppliances" value="생활가전"> <label
										class="form-check-label" for="homeAppliances">생활가전</label>
								</div>
								<div class="form-check">
									<input class="form-check-input" type="radio" name="category"
										id="livingKitchen" value="생활/주방"> <label
										class="form-check-label" for="livingKitchen">생활/주방</label>
								</div>
								<div class="form-check">
									<input class="form-check-input" type="radio" name="category"
										id="processedFood" value="가공식품"> <label
										class="form-check-label" for="processedFood">가공식품</label>
								</div>
								<div class="form-check">
									<input class="form-check-input" type="radio" name="category"
										id="sportsLeisure" value="스포츠/레저"> <label
										class="form-check-label" for="sportsLeisure">스포츠/레저</label>
								</div>
								<div class="form-check">
									<input class="form-check-input" type="radio" name="category"
										id="hobbyGameMusic" value="취미/게임/음반"> <label
										class="form-check-label" for="hobbyGameMusic">취미/게임/음반</label>
								</div>
								<div class="form-check">
									<input class="form-check-input" type="radio" name="category"
										id="beautyCare" value="뷰티/미용"> <label
										class="form-check-label" for="beautyCare">뷰티/미용</label>
								</div>
							</div>
	
							<div class="col-md-4">
								<!-- 세 번째 열의 라디오 버튼들 추가 -->
								<div class="form-check">
									<input class="form-check-input" type="radio" name="category"
										id="plants" value="식물"> <label class="form-check-label"
										for="plants">식물</label>
								</div>
								<div class="form-check">
									<input class="form-check-input" type="radio" name="category"
										id="petSupplies" value="반려동물용품"> <label
										class="form-check-label" for="petSupplies">반려동물용품</label>
								</div>
								<div class="form-check">
									<input class="form-check-input" type="radio" name="category"
										id="ticketsVouchers" value="티켓/교환권"> <label
										class="form-check-label" for="ticketsVouchers">티켓/교환권</label>
								</div>
								<div class="form-check">
									<input class="form-check-input" type="radio" name="category"
										id="books" value="도서"> <label class="form-check-label"
										for="books">도서</label>
								</div>
								<div class="form-check">
									<input class="form-check-input" type="radio" name="category"
										id="babyBooks" value="유아도서"> <label
										class="form-check-label" for="babyBooks">유아도서</label>
								</div>
								<div class="form-check">
									<input class="form-check-input" type="radio" name="category"
										id="otherUsedItems" value="기타 중고물품"> <label
										class="form-check-label" for="otherUsedItems">기타 중고물품</label>
								</div>
							</div>
						</div>
					</div>
	        		
	        	</div>
	        	
	        	<!-- 검색 리스트 -->
				<div class=" col-8"><!-- 검색리스트+페이지 -->
	        	
					<div class="container">
					    <div>
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
						
					</div><!-- 검색리스트+페이지 -->
				</div><!-- 필터+검색리스트+페이지 -->
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