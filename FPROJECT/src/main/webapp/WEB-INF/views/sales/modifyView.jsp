<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!doctype html>
<html lang="en" data-bs-theme="auto">
	<!-- head -->
	<%@ include file="../common/head.jsp" %>
	<!-- css -->
	<link rel="stylesheet" href="/cdn/css/sales/writeView.css">
	<!-- daum writeView -->
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ce5959441a26bb6ca04de7134c4cc8e3&libraries=services"></script>
	<!-- body -->
	<body class="bg-body-tertiary">
		<!-- header -->
		<%@ include file="../common/header.jsp" %>
			<div class="container mt-3">
			    
					
			    	<!-- 기존 이미지 불러오는 폼 -->
					<div id="imagePreview" class="py-3">
					    <label for="imageLoading" class="form-label fw-bold">기존 첨부 사진</label><br>
					    <c:forEach var="i" begin="1" end="10">
					        <c:set var="imgProperty" value="img${i}" />
					        <c:set var="imgURL" value="${boardDetail[imgProperty]}" />
					
					        <!-- Check if the image URL is not null or empty -->
					        <c:if test="${not empty imgURL}">
					            <div class="img-container">
					                <img src="<c:url value='/cdn/upload/' />${imgURL}" class="img-thumbnail" style="width: 100px; height: 100px;">
					            </div>
					        </c:if>
					    </c:forEach>
					</div>
					
			    	<form action="/modifyBoardProcess" method="post" enctype="multipart/form-data">
		    		<!-- 제목 -->
			        <div class="mb-3">
						<label for="title" class="form-label fw-bold">제목</label>
			            <input type="text" class="form-control" id="title" name="title" placeholder="제목을 입력해 주세요" required value="${boardDetail.title}">
			        </div>
			        <!-- 가격 -->
			        <div class="mb-3">
			            <label for="price" class="form-label fw-bold">판매 가격</label>
			            <input type="number" class="form-control" id="price" name="price" placeholder="₩ 가격을 입력해 주세요" required value="${boardDetail.price}">
			        </div>
			        <!-- 설명 -->
			        <div class="mb-3">
					    <label for="description" class="form-label fw-bold">자세한 설명</label>
					    <textarea class="form-control" id="content" name="content" rows="6" placeholder="게시글 내용을 작성해 주세요 (판매 금지 물품은 게시가 제한될 수 있어요)" required>${fn:escapeXml(description)} ${boardDetail.content}</textarea>
					</div>
			        <!-- 장소 -->
					<div class="mb-3">
			            <label for="title" class="form-label fw-bold">거래 희망 장소</label>
			            <input type="text" class="form-control mb-2" id="address" name="address" placeholder="주소 검색 버튼을 눌러 거래 희망 장소를 선택해 주세요" required onclick="sample5_execDaumPostcode()" value="${boardDetail.address}">
						<!-- <input type="button" class="btn btn-primary" onclick="sample5_execDaumPostcode()" value="주소 검색 "><br>   -->
						<div id="map" class="border border-light-subtle rounded" style="width:500px;height:500px;margin-top:10px;display:none" class="rounded"></div>
 				            <input type="hidden" id="latitude" name="latitude" value="${boardDetail.latitude}">
							<input type="hidden" id="longitude" name="longitude" value="${boardDetail.longitude}">
   							<input type="hidden" name="seq" value="${boardDetail.seq}">
			        </div>
			        
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
					<div class="text-center mt-5">
					    <button type="submit" class="btn btn-primary">작성 완료</button>
						<a href="<c:url value='/'/>" class="btn btn-secondary">작성 취소</a>
					</div>
			    </form>
			</div>
			
		<!-- footer -->
		<%@ include file="../common/footer.jsp" %>
		
		<!-- 주소 빈곳 체크 추가-->
		<script>
		    var mapContainer = document.getElementById('map'); // 지도를 표시할 div
		    var mapOption = {
		        center: new daum.maps.LatLng(37.537187, 127.005476), // 지도의 중심좌표
		        level: 5 // 지도의 확대 레벨
		    };
		
		    // 지도를 미리 생성
		    var map = new daum.maps.Map(mapContainer, mapOption);
		
		    // 주소-좌표 변환 객체를 생성
		    var geocoder = new daum.maps.services.Geocoder();
		
		    // 마커를 미리 생성
		    var marker = new daum.maps.Marker({
		        position: new daum.maps.LatLng(37.537187, 127.005476),
		        map: map
		    });
		
		    function updateCoords() {
		        // 현재 마커의 좌표를 가져와서 인풋 박스에 할당
		        var position = marker.getPosition();
		        document.getElementById("latitude").value = position.getLat();
		        document.getElementById("longitude").value = position.getLng();
		    }
		
		    function sample5_execDaumPostcode() {
		        new daum.Postcode({
		            oncomplete: function (data) {
		                var addr = data.address; // 최종 주소 변수

		                // 주소 정보를 해당 필드에 넣는다.
		                document.getElementById("address").value = addr;

		                // 주소로 상세 정보를 검색
		                geocoder.addressSearch(data.address, function (results, status) {
		                    // 정상적으로 검색이 완료됐으면
		                    if (status === daum.maps.services.Status.OK) {
		                        var result = results[0]; // 첫번째 결과의 값을 활용

		                        // 해당 주소에 대한 좌표를 받아서
		                        var coords = new daum.maps.LatLng(result.y, result.x);

		                        // 지도를 보여준다.
		                        mapContainer.style.display = "block";
		                        map.relayout();

		                        // 지도 중심을 변경한다.
		                        map.setCenter(coords);

		                        // 마커를 결과값으로 받은 위치로 옮긴다.
		                        marker.setPosition(coords);

		                        // 좌표 업데이트
		                        updateCoords();
		                    } else {
		                        // 주소 검색 결과가 없을 때의 처리
		                        alert("사용 불가능한 주소입니다.");
		                        document.getElementById("address").value = "";
		                        // 기타 필요한 처리를 추가할 수 있습니다.
		                    }
		                });
		            }
		        }).open();
		    }
		
		    // 마커를 드래그할 때 발생하는 이벤트
		    daum.maps.event.addListener(marker, 'dragend', function () {
		        // 좌표 업데이트
		        updateCoords();
		    });
		</script>
		
		<!-- 기존 카테고리 체크 -->
		<script>
		    document.addEventListener('DOMContentLoaded', function() {
		        var selectedCategory = "${boardDetail.category}";
		
		        // 선택된 카테고리에 해당하는 라디오 버튼을 찾아 체크
		        var radioButtons = document.getElementsByName('category');
		        for (var i = 0; i < radioButtons.length; i++) {
		            if (radioButtons[i].value === selectedCategory) {
		                radioButtons[i].checked = true;
		                break;
		            }
		        }
		    });
		</script>
	</body>
</html>