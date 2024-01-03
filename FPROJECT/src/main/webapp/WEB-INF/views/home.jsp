<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!doctype html>
<html lang="en" data-bs-theme="auto">
	<!-- head -->
	<%@ include file="common/head.jsp" %>
	<!-- body -->
	<body>
	<!-- header -->
	<%@ include file="common/header.jsp" %>
	<!-- main -->
	<main>
		<div class="album py-5 bg-body-tertiary">
			<div class="container">
	
				<div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
					<div class="col">
						<div class="card shadow-sm">
							<svg class="bd-placeholder-img card-img-top" width="100%"
								height="225" xmlns="http://www.w3.org/2000/svg" role="img"
								aria-label="Placeholder: Thumbnail"
								preserveAspectRatio="xMidYMid slice" focusable="false">
											<title>Placeholder</title><rect width="100%" height="100%" fill="#55595c" />
											<text x="50%" y="50%" fill="#eceeef" dy=".3em">Thumbnail</text></svg>
							<div class="card-body">
								<p class="card-text">세탁세제</p>
								<p class="card-text">10,000원</p>
								<p class="card-text">인천 계양구 계양1동</p>
								<p class="card-text">관심 21.채팅14</p>
								<div class="d-flex justify-content-between align-items-center">
									<div class="btn-group">
										<button type="button" class="btn btn-sm btn-outline-secondary">
											<i class="bi bi-heart-fill"></i>
										</button>
										<button type="button" class="btn btn-sm btn-outline-secondary">
											<i class="bi bi-chat-left-text-fill"></i>
										</button>
									</div>
									<small class="text-body-secondary">9 분전</small>
								</div>
							</div>
						</div>
					</div>
	
				</div>
			</div>
		</div>
		<!-- 위치가져오기 테스트 -->
		<button onclick="getCurrentLocation()">Get Current Location</button>
	</main>
		
		<!-- Footer -->
		<%@ include file="common/footer.jsp" %>
		
		<script>
		<!-- 위치가져오기테스트 -->
		
		    function getCurrentLocation() {
		        if (navigator.geolocation) {
		            navigator.geolocation.getCurrentPosition(showPosition);
		        } else {
		            alert("Geolocation is not supported by this browser.");
		        }
		    }
		
		    function showPosition(position) {
		        alert("Latitude: " + position.coords.latitude + 
		              "\nLongitude: " + position.coords.longitude);
		    }
		</script>
		
	</body>
</html>