<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!doctype html>
<html lang="en">
    <!-- head -->
    <%@ include file="../common/head.jsp" %>
    <!-- daum detailView -->
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ce5959441a26bb6ca04de7134c4cc8e3&libraries=services"></script>
	<body class="bg-body-tertiary">
	    <!-- header -->
	    <%@ include file="../common/header.jsp" %>

		<div class="container mt-5 rounded border border-secondary border-opacity-50 bg-body">
		
			<div class="row">
				<!-- Carousel -->
				<div id="imageCarousel" class="carousel carousel-dark slide col-12 col-md-6 mx-auto" data-bs-ride="carousel">
				    
					    <div class="carousel-inner border rounded mt-5 " >
					       <%-- <c:forEach var="img" items="${boardDetail.imgList}" varStatus="i">
					            <div class="carousel-item ${i.index == 0 ? 'active' : ''}">
					                <img src="<c:url value='/cdn/upload/${img}' />"
					                    class="d-block w-100 img-fluid carousel-image"
					                    style="object-fit: cover; object-position: center center; height: 500px; width: 500px;"
					                    data-bs-toggle="modal"
					                    data-bs-target="#imageModal"
					                    data-bs-slide-to="${i.index}">
					                <!-- Additional data-bs attributes are added to open the modal and specify the selected image index -->
					            </div>
					        </c:forEach>  --%>
					        <c:forEach var="img" items="${boardDetail.imgList}" varStatus="i">
							    <c:if test="${not empty img}">
							        <div class="carousel-item ${i.index == 0 ? 'active' : ''}">
							            <img src="<c:url value='/cdn/upload/${img}' />"
							                class="d-block w-100 img-fluid carousel-image"
							                style="object-fit: cover; object-position: center center; height: 500px; width: 500px;"
							                data-bs-toggle="modal"
							                data-bs-target="#imageModal"
							                data-bs-slide-to="${i.index}">
							        </div>
							    </c:if>
							</c:forEach>


				    	</div>
				    	<c:if test="${fn:length(boardDetail.imgList) > 1}">
						    <div class="carousel-indicators">
						        <c:forEach var="img" items="${boardDetail.imgList}" varStatus="i">
						            <c:if test="${not empty img}">
						                <button type="button" data-bs-target="#imageCarousel" data-bs-slide-to="${i.index}" class="${i.index == 0 ? 'active' : ''}" aria-label="Slide ${i.index + 1}"></button>
						            </c:if>
						        </c:forEach>
						    </div>
						    <div class="carousel-control-prev " type="button" data-bs-target="#imageCarousel" data-bs-slide="prev">
						        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
						        <span class="visually-hidden">Previous</span>
						    </div>
						    <div class="carousel-control-next" type="button" data-bs-target="#imageCarousel" data-bs-slide="next">
						        <span class="carousel-control-next-icon" aria-hidden="true"></span>
						        <span class="visually-hidden">Next</span>
						    </div>
						</c:if>
					</div>

					<!-- Modal -->
					<div class="modal" id="imageModal" tabindex="-1" aria-labelledby="imageModalLabel" aria-hidden="true">
					    <div class="modal-dialog">
					        <div class="modal-content">
					            <div class="modal-header">
					            ${boardDetail.title}
					                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					            </div>
					            <div class="modal-body">
					                <img src="#" class="d-block w-100 img-fluid" id="modalImage">
					            </div>
					        </div>
					    </div>
					</div>
					
					<div class="col-5 me-5  mt-5">
						<a href="<c:url value='/search?category=${boardDetail.category}'/>" style="text-decoration:none" class="text-dark">
							<h2 class="fs-6 py-4"><i class="bi bi-tag me-2"></i> ${boardDetail.category} <i class="bi bi-link"></i></h2>
						</a>
						<h2 class="fs-3 fw-bold mb-3">${boardDetail.title}</h2>
						<span class="fs-2 fw-bold"> <fmt:formatNumber value="${boardDetail.price}" pattern="#,###" /></span> <span> 원</span>
						<hr class="my-4">
						<a href="<c:url value='/search?seller_id=${boardDetail.member_id}'/>" style="text-decoration:none" class="text-dark">
							<p class="fs-6 mt-3"> <i class="bi bi-person-square me-2"></i>  ${boardDetail.member_id} <i class="bi bi-link"></i></p>
						</a>
						<p class="fs-6"> <i class="bi bi-geo-alt  me-2"> </i> ${boardDetail.address}</p>
						<h3 class="fs-6 mt-3"><i class="bi bi-eye  me-2"></i> ${boardDetail.view_cnt} <i class="bi bi-heart ms-5 me-2"></i> ${boardDetail.like_cnt}</h3>
						<h3 class="fs-6"></h3>
						<hr class="my-4">
						<%-- 모든 멤버 메뉴 --%>
						<c:if test="${boardDetail.soldout_yn eq 'n'}">
							<button class="btn btn btn-primary btn-chat" type="button" data-value="${boardDetail.member_id}">
								<i class="bi bi-chat-right-text-fill me-2"></i> 메시지 보내기
							</button>
							<button class="btn btn-secondary btn-like" data-seq="${boardDetail.seq}" type="button">
								<i class="${boardDetail.likeStatus} me-2"></i> 관심 상품
							</button>
						</c:if>
						<c:if test="${boardDetail.soldout_yn eq 'y'}">
							<span class="badge rounded-pill text-bg-secondary fs-6 fw-medium"> <i class="bi bi-alarm me-2"></i></i>판매 완료되었습니다 </span>
						</c:if>
						
						<%-- 작성자 admin 메뉴 --%>
						<c:if test="${boardDetail.soldout_yn eq 'n'}">
							<c:if test="${sessionScope.id eq boardDetail.member_id}">
								<hr class="my-4">
								<i class="bi bi-person-lock fs-5 me-2"></i>
								<button class="btn btn-outline-danger" id="btnModify">수정</button>
								<button class="btn btn-outline-danger" onclick="deleteBoard(${boardDetail.seq})">삭제</button>
								<button class="btn btn-outline-primary" onclick="markAsSoldOut(${boardDetail.seq})">판매완료</button>
								
								<form id="frmModify" action="/modifyBoardView" method="get">
								    <input type="hidden" name="seq" id="seqHiddenInput" value="${boardDetail.seq}">
								    <input type="hidden" name="member_id" id="memberIdHiddenInput" value="${boardDetail.member_id}">
								</form>
								
							</c:if>
						</c:if>
						<c:if test="${boardDetail.soldout_yn eq 'y'}">
							<c:if test="${sessionScope.id eq boardDetail.member_id}">
								<hr class="my-4">
								<button class="btn btn-outline-danger" onclick="deleteBoard(${boardDetail.seq})">삭제</button>
								<button class="btn btn-outline-danger">판매완료 처리한 게시물입니다</button>
							</c:if>
						</c:if>
						
					</div>
					
				</div>
				<hr class="mt-5">
				<div class="row">
					<div class="alert alert-primary col-10 mx-auto" role="alert">
					 	<p class="fs-5 text-center"><i class="bi bi-brightness-alt-high-fill"></i> 거래 전 주의사항 안내</p>
						<p class="fs-6 text-center">판매자가 별도의 메신저로 결제링크를 보내거나 직접 송금을
							유도하는 경우 사기일 가능성이 높으니<br> 거래를 자제해 주시고 새로마켓 고객센터로 신고해 주시기 바랍니다.
						</p>
					</div>
					<div class="text-center">
						<span class="badge rounded-pill text-bg-secondary fs-6 mt-3 fw-medium"> <i class="bi bi-card-checklist me-2"></i>상세설명 </span>
					</div>
					<div class="offset-1 mt-2 col-xs-12">
						<p class="fs-6 mt-3" style="white-space: pre-line">${boardDetail.content}</p>
					</div>
					<hr class="mt-5">
					<div class="text-center">
						<span class="badge rounded-pill text-bg-secondary fs-6 mt-3 fw-medium"> <i class="bi bi-geo-alt me-2"></i>거래희망 장소 </span>
					</div>
					<div class="mb-5 text-center">
						<div id="map" class="mt-3 col-10 mx-auto border rounded mt-3" style="height: 350px;"></div>
						<span style="font-size: 14px"> ${boardDetail.address}</span>
					</div>
				</div>
			</div>
			<div class="text-center mt-3">
				<button class="btn btn-secondary" onclick="history.go(-1);">뒤로 가기</button>
				<button class="btn btn-secondary" onclick="window.location.href='<c:url value='/'/>'">메인 페이지</button>
			</div>
			
			<!-- footer -->
		    <%@ include file="../common/footer.jsp" %>
			
			<!-- 카카오 지도 -->
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
		        geocoder.addressSearch(
		            '${boardDetail.address}',
		            function(result, status) {
		                // 정상적으로 검색이 완료됐으면 
		                if (status === kakao.maps.services.Status.OK) {
		                    var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
		                    // 결과값으로 받은 위치를 마커로 표시합니다
		                    var marker = new kakao.maps.Marker({
		                        map : map,
		                        position : coords
		                    });
		                    
		                    // 인포윈도우로 장소에 대한 설명을 표시합니다
		                    var infowindow = new kakao.maps.InfoWindow({
		                        content : '<div style="width:150px;text-align:center;padding:6px 0;">거래 희망 장소</div>'
		                    });
		                    infowindow.open(map, marker);
		                    // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
		                    map.setCenter(coords);
		                }
		            }
		        );
		    </script>
		    
		    <!-- 이미지 클릭 확대 -->
		    <script>
			    // JavaScript to handle image click and update modal content
			    document.addEventListener('DOMContentLoaded', function () {
			        const carouselImages = document.querySelectorAll('.carousel-image');
			        const modalImage = document.getElementById('modalImage');
			        const imageModal = new bootstrap.Modal(document.getElementById('imageModal'));
			
			        carouselImages.forEach((image, index) => {
			            image.addEventListener('click', () => {
			                modalImage.src = image.src;
			                imageModal.show();
			            });
			        });
			
			        imageModal._element.addEventListener('shown.bs.modal', function () {
			            // The modal is open, backdrop should be present
			            document.body.classList.add('modal-open');
			        });
			
			        imageModal._element.addEventListener('hidden.bs.modal', function () {
			            // The modal is hidden, remove the backdrop
			            document.body.classList.remove('modal-open');
			        });
			    });
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
			
			<!-- 판매 완료 처리 -->
			<script>
			    function markAsSoldOut(seq) {
			     	// POST 요청을 보내는 부분
			        $.ajax({
			        	 type: "POST"
		            	, url: "/soldout"
			            , dataType: "json"
			            , data: { seq: seq }
			            , success: function(response) {
			                if (response.message === "success") {
			                    location.reload();
			                } else if (response.message === "not_found") {
			                    alert("게시물을 찾을 수 없습니다")
			                } else {
			                    alert("에러가 발생했습니다")
			                }
			            },
			            error: function(error) {
		                    alert("에러가 발생했습니다")
			            },
			        });
			    }
			    </script>
			    
			    <!-- 게시물 삭제 처리 -->
				<script>
				    function deleteBoard(seq) {
				     	// POST 요청을 보내는 부분
				        $.ajax({
				        	 type: "POST"
			            	, url: "/deleteBoard"
				            , dataType: "json"
				            , data: { seq: seq }
				            , success: function(response) {
				                if (response.message === "success") {
				                	alert('게시물이 삭제되었습니다')
				                    window.location.href = "/search";
									//이전페이지로 리다이렉트 시켜 새로고침
				                } else if (response.message === "not_found") {
				                    alert("게시물을 찾을 수 없습니다")
				                } else {
				                    alert("에러가 발생했습니다")
				                }
				            },
				            error: function(error) {
			                    alert("에러가 발생했습니다")
				            },
				        });
				    }
				</script>
				
				<!--  게시물 수정 처리  -->
				<script>
				    document.getElementById('btnModify').addEventListener('click', function() {
				        // 클릭 시 폼 제출
				        document.getElementById('frmModify').submit();
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
