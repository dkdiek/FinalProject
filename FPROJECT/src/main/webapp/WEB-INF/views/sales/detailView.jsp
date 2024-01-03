<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!doctype html>
<html lang="en" data-bs-theme="auto">
	<!-- head -->
	<%@ include file="../common/head.jsp" %>
	<!-- body -->
	<body>
		<!-- header -->
		<%@ include file="../common/header.jsp" %>

		<div class="container mt-4">
			<h2>제목: ${boardDetail.title}</h2>
			<h3>조회수: ${boardDetail.view_cnt}</h3>
			<h3>관심수: ${boardDetail.like_cnt}</h3>
			<h3>카테고리: ${boardDetail.category}</h3>
	
			<!-- Carousel -->
			<div id="imageCarousel" class="carousel slide w-50"
				data-bs-ride="carousel">
				<div class="carousel-inner">
					<c:forEach var="img" items="${boardDetail.imgList }" varStatus="i">
						<div class="carousel-item active">
							<img src="<c:url value='/cdn/upload/${img}' />"
								class="d-block w-100">
						</div>
					</c:forEach>
				</div>
				<button class="carousel-control-prev" type="button"
					data-bs-target="#imageCarousel" data-bs-slide="prev">
					<span class="carousel-control-prev-icon" aria-hidden="true"></span>
					<span class="visually-hidden">Previous</span>
				</button>
				<button class="carousel-control-next" type="button"
					data-bs-target="#imageCarousel" data-bs-slide="next">
					<span class="carousel-control-next-icon" aria-hidden="true"></span>
					<span class="visually-hidden">Next</span>
				</button>
			</div>
	
			<p class="mt-3">내용: ${boardDetail.content}</p>
			<p>작성자: ${boardDetail.member_id}</p>
			<p>가격: ${boardDetail.price}</p>
			<p>주소: ${boardDetail.address}</p>
			<div id="map" style="width: 50%; height: 350px;"></div>
		</div>
		<!-- footer -->
		<%@ include file="../common/footer.jsp" %>
		
		<script>
			var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
			mapOption = {
				center : new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
				level : 3
			// 지도의 확대 레벨
			};
	
			// 지도를 생성합니다    
			var map = new kakao.maps.Map(mapContainer, mapOption);
	
			// 주소-좌표 변환 객체를 생성합니다
			var geocoder = new kakao.maps.services.Geocoder();
	
			// 주소로 좌표를 검색합니다
			
			geocoder
					.addressSearch(
							'${boardDetail.address}',
							function(result, status) {
								// 정상적으로 검색이 완료됐으면 
								if (status === kakao.maps.services.Status.OK) {
									var coords = new kakao.maps.LatLng(
											result[0].y, result[0].x);
									// 결과값으로 받은 위치를 마커로 표시합니다
									var marker = new kakao.maps.Marker({
										map : map,
										position : coords
									});
									// 인포윈도우로 장소에 대한 설명을 표시합니다
									var infowindow = new kakao.maps.InfoWindow(
											{
												content : '<div style="width:150px;text-align:center;padding:6px 0;">거래 희망 장소</div>'
											});
									infowindow.open(map, marker);
									// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
									map.setCenter(coords);
								}
							});
		</script>
	</body>
</html>