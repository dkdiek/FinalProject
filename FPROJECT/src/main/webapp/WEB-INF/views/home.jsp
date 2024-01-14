<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!doctype html>
<html lang="en" data-bs-theme="auto">
	<!-- head -->
	<%@ include file="common/head.jsp" %>
	<!-- body -->
	<body class="bg-body-tertiary">
		<!-- header -->
		<%@ include file="common/header.jsp" %>
	
			<!-- 우리동네 글 -->
			<div class="album py-5 bg-body-tertiary">
				<div class="d-flex justify-content-center align-items-center">
					<h4>
						<span class="badge bg-primary-subtle text-primary-emphasis rounded-pill">♥Like가 증명하는</span>
					</h4>
				</div>
				<div class="d-flex justify-content-center align-items-center">
					<i class="bi bi-people fs-1"></i>
					<h4 class="text-dark fw-bold">"우리 동네, 인기 상품을 만나보세요!"</h4>
				</div>
				<div class="text-center">
					<i class="bi bi-geo-alt me-2 me-2"></i><c:out value="${memberInfo.member_addr2}" />
				</div>
				
				<div class="container">
		
					<div class="album py-3 bg-body-tertiary">
						<div class="container">
							<div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
								<c:forEach var="board" items="${boardList}">
									<div class="col">
										<div class="card shadow-sm">
											<div class="card-img-top"
												style="width: 100%; height: 300px; overflow: hidden;">
												<a href="http://localhost/detail?seq=${board.seq}"
													class="img-link"> <img
													src="<c:url value='/cdn/upload/${board.img1}'/>"
													class="img-fluid" alt="Image"
													style="width: 100%; height: 100%; object-fit: cover;">
												</a>
											</div>
											<div class="card-body" >
												<!-- card-body 내용 -->
												<div>
											        <p class="card-text fw-bold overflow-hidden text-truncate">
														<i class="bi bi-gift me-2"></i>  ${board.title}
													</p>
													<hr>
													<p class="card-text fw-bold" style="font-size:14px">
														<i class="bi bi-cash me-2"></i>  <fmt:formatNumber value="${board.price}" pattern="#,###원" />
													</p>
													<p class="card-text overflow-hidden text-truncate" style="font-size:14px">
														<i class="bi bi-geo-alt me-2"></i> ${board.address}
													</p>
													<p class="card-text" style="font-size:14px">
														<i class="bi bi-eye me-2"></i> ${board.view_cnt} <i class="bi bi-heart ms-5 me-2"></i> ${board.like_cnt}
														<i class="bi bi-car-front ms-5 me-2"></i><c:out value="${board.distance}" /> km
													</p>
													<hr>
												</div>
												<div class="d-flex justify-content-between align-items-center mt-3">
													<div class="btn-group">
														<button type="button"
															class="btn btn-sm btn-outline-secondary btn-like" data-seq="${board.seq}">
															<i class="${board.likeStatus}"></i>
														</button>
														<button type="button" class="btn btn-sm btn-outline-secondary btn-chat" data-value="${board.member_id}">
														    <i class="bi bi-chat-left-text-fill"></i>
														</button>
													</div>
													<small class="text-body-secondary">
													 	${board.formattedDifference}
													</small>
												</div>
											</div>
										</div>
									</div>
								</c:forEach>
							</div>
						</div>
					</div>
				</div>
			</div>
			

				
					
					<!-- new 판매글 -->
					<div class="album py-5 bg-body-tertiary">
						<div class="d-flex justify-content-center align-items-center">
							<h4>
								<span class="badge bg-primary-subtle text-primary-emphasis rounded-pill mb-1">~따끈따끈한 New 판매글</span>
							</h4>
						</div>
						<div class="d-flex justify-content-center align-items-center">
							<i class="bi bi-cup-hot fs-1"></i>
							<h4 class="text-dark fw-bold">"새로운 아이템을 놓치지 마세요!"</h4>
						</div>
		
						<div class="container">
		
					<div class="album py-3 bg-body-tertiary">
						<div class="container">
							<div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
								<c:forEach var="board2" items="${boardList2}">
									<div class="col">
										<div class="card shadow-sm">
											<div class="card-img-top"
												style="width: 100%; height: 300px; overflow: hidden;">
												<a href="http://localhost/detail?seq=${board2.seq}"
													class="img-link"> <img
													src="<c:url value='/cdn/upload/${board2.img1}'/>"
													class="img-fluid" alt="Image"
													style="width: 100%; height: 100%; object-fit: cover;">
												</a>
											</div>
											<div class="card-body" >
												<!-- card-body 내용 -->
												<div>
											        <p class="card-text fw-bold overflow-hidden text-truncate">
														<i class="bi bi-gift me-2"></i>  ${board2.title}
													</p>
													<hr>
													<p class="card-text fw-bold" style="font-size:14px">
														<i class="bi bi-cash me-2"></i>  <fmt:formatNumber value="${board2.price}" pattern="#,###원" />
													</p>
													<p class="card-text overflow-hidden text-truncate" style="font-size:14px">
														<i class="bi bi-geo-alt me-2"></i> ${board2.address}
													</p>
													<p class="card-text" style="font-size:14px">
														<i class="bi bi-eye me-2"></i> ${board2.view_cnt} <i class="bi bi-heart ms-5 me-2"></i> ${board2.like_cnt}
														<i class="bi bi-car-front ms-5 me-2"></i><c:out value="${board2.distance}" /> km
													</p>
													
													<hr>
												</div>
												<div class="d-flex justify-content-between align-items-center mt-3">
													<div class="btn-group">
														<button type="button" class="btn btn-sm btn-outline-secondary btn-like" data-seq="${board2.seq}">
															<i class="${board2.likeStatus}"></i>
															
														</button>
														<button type="button" class="btn btn-sm btn-outline-secondary btn-chat"  data-value="${board2.member_id}">
															<i class="bi bi-chat-left-text-fill"></i>
														</button>
													</div>
													<small class="text-body-secondary">
													 	${board2.formattedDifference}
													</small>
												</div>
											</div>
										</div>
									</div>
								</c:forEach>
							</div>
						</div>
					</div>
				</div>
			</div>
		<!-- Footer -->
		<%@ include file="common/footer.jsp"%>

		<!-- 위치가져오기테스트 -->
		<script>
			function getCurrentLocation() {
				if (navigator.geolocation) {
					navigator.geolocation.getCurrentPosition(showPosition);
				} else {
					alert("Geolocation is not supported by this browser.");
				}
			}

			function showPosition(position) {
				alert("Latitude: " + position.coords.latitude + "\nLongitude: "
						+ position.coords.longitude);
			}
		</script>
		
		<!-- 좋아요 버튼 클릭 -->
		<script>
			$(document).ready(function() {
			    // 좋아요 버튼 클릭 이벤트
			    $(".btn-like").click(function() {
			        var seq = $(this).data("seq");
	
			        // AJAX 요청
			        $.ajax({
			            type: "POST"
			            , url: "/like"
			            , dataType: "json"
			            , data: { seq: seq }
			            , success: function(data) {
			                // 서버로부터의 응답을 처리
			                if (data.message === "success_add") {
			                  
			                    location.reload();
			                } if (data.message === "success_cancel") {
			               
			                    location.reload();
			                } else if (data.message === "login_required") {
			                    alert("로그인이 필요합니다.");
			                }
			            },
			            error: function() {
			                // AJAX 요청 실패 시 처리 로직 추가
			                alert("AJAX 요청 실패");
			            }
			        });
			    });
			});
		</script>
		

		<!-- 메세지 보내기 -->
		<script>
			$(document).ready(function() {
			    $(".btn-chat").click(function() {
			        var to_id = $(this).data("value");
			        var from_id = '${sessionScope.id}';

			        if (from_id == null || from_id === '') {
			            alert('로그인이 필요합니다');
			        } else {
			        	var url = '/sendMessage?to_id=' + to_id + '&from_id=' + from_id
			            window.open(url, '_blank',  'width=500,height=500');
			        }
			    });
			});
		</script>

		
		
	</body>
</html>