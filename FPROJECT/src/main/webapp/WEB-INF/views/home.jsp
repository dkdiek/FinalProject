<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!doctype html>
<html lang="en" data-bs-theme="auto">
	<!-- head -->
	<%@ include file="common/head.jsp" %>
	<style>
	    .card-link {
	        text-decoration: none;
	    }
	</style>
	
	<!-- body -->
	<body>
		<!-- header -->
		<%@ include file="common/header.jsp" %>
		<!-- main -->
		<main>
		<!-- 우리동네 글 -->
		<div class="album py-5 bg-body-tertiary">
			<div class="d-flex justify-content-center">
				<h4>
					<span class="badge bg-primary-subtle text-primary-emphasis rounded-pill">우리동네 판매글</span>
				</h4>
			</div>
			<div class="container">

				<div class="album py-5 bg-body-tertiary">
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
										<div class="card-body"
											style="height: 225px; overflow: hidden;">
											<!-- card-body 내용 -->
											<p class="card-text">${board.title}</p>
											<p class="card-text">${board.price}원</p>
											<p class="card-text">${board.address}</p>
											<p class="card-text">${board.like_cnt}</p>
											<div
												class="d-flex justify-content-between align-items-center">
												<div class="btn-group">
													<button type="button"
														class="btn btn-sm btn-outline-secondary">
														<i class="bi bi-heart-fill"></i>
													</button>
													<button type="button"
														class="btn btn-sm btn-outline-secondary">
														<i class="bi bi-chat-left-text-fill"></i>
													</button>
												</div>
												<small class="text-body-secondary createDate"
													data-create-date="${board.create_date}">${board.create_date}</small>
											</div>
										</div>
									</div>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>
		</main>
		<!-- new 판매글 -->
		<div class="album py-5 bg-body-tertiary">
			<div class="d-flex justify-content-center">
				<h4>
					<span
						class="badge bg-primary-subtle text-primary-emphasis rounded-pill">New
						판매글</span>
				</h4>
			</div>
			<div class="container">

				<div class="album py-5 bg-body-tertiary">
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
										<div class="card-body"
											style="height: 225px; overflow: hidden;">
											<!-- card-body 내용 -->
											<p class="card-text">${board.title}</p>
											<p class="card-text">${board.price}원</p>
											<p class="card-text">${board.address}</p>
											<p class="card-text">${board.like_cnt}</p>
											<div
												class="d-flex justify-content-between align-items-center">
												<div class="btn-group">
													<button type="button"
														class="btn btn-sm btn-outline-secondary">
														<i class="bi bi-heart-fill"></i>
													</button>
													<button type="button"
														class="btn btn-sm btn-outline-secondary">
														<i class="bi bi-chat-left-text-fill"></i>
													</button>
												</div>
												<small class="text-body-secondary createDate"
													data-create-date="${board.create_date}">${board.create_date}</small>
											</div>
										</div>
									</div>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>
		</main>
		<!-- Footer -->
		<%@ include file="common/footer.jsp" %>
		
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
		<!-- 게시 시간 차이 계산 -->
		<script>
		    function calculateTimeDifference() {
		        // 각 createDate 엘리먼트에 대해 시간 차이 계산 및 표시
		        const createDateElements = document.getElementsByClassName("createDate");

		        for (let i = 0; i < createDateElements.length; i++) {
		            const createDateElement = createDateElements[i];
		            const createDate = createDateElement.getAttribute("data-create-date");
		            const createDateObj = new Date(createDate);

		            // 현재 날짜와 시간을 가져오기
		            const currentDate = new Date();

		            // 시간 차이 계산 (밀리초 단위)
		            const timeDifference = currentDate - createDateObj;

		            // 시간 차이를 분 단위로 변환
		            const minutesDifference = Math.floor(timeDifference / (1000 * 60));

		            // 분 단위로 표시
		            createDateElement.innerText = `${minutesDifference} 분전`;
		        }
		    }

		    // 페이지 로드 시에 한 번 실행
		    window.onload = function() {
		        calculateTimeDifference();
		    };
		</script>
	</body>
</html>