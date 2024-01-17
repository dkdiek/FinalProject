<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!doctype html>
<html lang="en" data-bs-theme="auto">
	<!-- head -->
	<%@ include file="../../common/head.jsp" %>
	<!-- daum 좌표용 -->
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ce5959441a26bb6ca04de7134c4cc8e3&libraries=services"></script>
	<!-- body -->
	<body class="bg-body-tertiary">

		<div class="container mt-5">
			<p style="max-width:200px" class="text-center mx-auto">
		        <img class="img-fluid" src="<c:url value='/cdn/images/common/LogoKor.png'/>">
	        </p>	
			<h2 class="py-4 text-center">소셜 로그인 추가 정보 제출 (필수)</h2>
	
			<form id="frmJoin" method="POST" action="<c:url value='/joinProcess'/>">
				<div class="mb-3">
					<label for="id" class="form-label">아이디 (변경 불가)</label> 
					<input type="text" id="id" name="member_id" class="form-control" value="${result.member_id }" readonly>
				</div>
				<div class="mb-3">
					<label for="pw" class="form-label">홈페이지 비밀번호</label> 
					<input type="password" id="pw" name="member_pw" class="form-control" maxlength="12" placeholder="비밀번호 (최대 12글자)" required>
				</div>
				<div>
					<label for="pw2" class="form-label">홈페이지 비밀번호 확인</label>
					<input type="password" id="pw2" name="member_pw2" class="form-control" maxlength="12" placeholder="비밀번호 확인 (최대 12글자)" required>
				</div>
				<h5 class="fs-6 mb-3 text-danger">*해당 비밀번호는 추후 회원 정보 변경과 탈퇴에 사용됩니다</h5>
				<div class="mb-3">
					<label for="name" class="form-label">이름 (변경 불가)</label> <input type="text"
						id="name" name="member_name" class="form-control" value="${result.name }" readonly>
				</div>
				<div class="mb-3">
					<label for="phone" class="form-label">전화번호</label> <input
						type="text" id="phone" name="member_phone" class="form-control"
						placeholder="전화번호">
				</div>
				<div class="mb-3">
					<label for="email" class="form-label">이메일</label> <input type="text"
						id="email" name="member_email" class="form-control"
						placeholder="이메일">
				</div>
				
				<div class="mb-3">
					<label for="addr2" class="form-label">주소</label> <input type="text"
						id="addr2" name="member_addr2" class="form-control"
						placeholder="주소" readonly onclick="sample5_execDaumPostcode()">
					<div id="map"></div>
					<input type="hidden" id="latitude" name="latitude">
					<input type="hidden" id="longitude" name="longitude">
				</div>
				
				
				<div class="mb-3">
					<label for="addr3" class="form-label">상세 주소</label> <input
						type="text" id="addr3" name="member_addr3" class="form-control"
						placeholder="상세 주소">
				</div>
				
				<div class="form-check mt-2">
					<input id="agreeCheckbox" type="checkbox" class="form-check-input border border-primary" name="checkbox" required>
					<h6 class="form-check-label text-danger fs-6">회원 탈퇴 시, 새로마켓 홈페이지 탈퇴가 추가로 필요합니다 (필수 체크)</h6>
				</div>
				<div class="py-5 d-flex align-items-center justify-content-center">
				
					<button type="button" id="btnConfirm" class="btn btn-primary">정보 제출</button>
					<a href="/" id="btnCancel" class="btn btn-secondary ms-1">취소</a>
				</div>
			</form>
			
			<!-- Modal for ID confirmation -->
	        <div class="modal" id="idModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	            <div class="modal-dialog">
	                <div class="modal-content">
	                    <div class="modal-header">
	                        <h5 class="modal-title fs-5 fw-bold text-center" id="exampleModalLabel">아이디 중복 확인</h5>
	                    </div>
	                    <div class="modal-body">
	                        <label for="modalId" class="form-label">ID를 입력하세요 (최대 12글자)</label>
	                        <input type="text" id="modalId" class="form-control" maxlength="12">
	                        <p id="message" class="mt-2 badge text-bg-primary"></p>
	                        <p id="idAvailability" class="mt-2 badge text-bg-primary"></p><br>
	                        <button id="checkIdBtn" class="btn btn-outline-dark btn-sm mt-2">중복 확인</button>
	                    </div>
	                    <div class="modal-footer">
	                        <button id="useIdBtn" class="btn btn-primary">ID 사용</button>
	                        <button id="closeModalBtn" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
	                    </div>
	                </div>
	            </div>
	        </div>
		</div>
		<!-- footer -->
		<%@ include file="../../common/footer.jsp" %>
	
		<!-- 주소api -->
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

		                // 주소로 상세 정보를 검색
		                geocoder.addressSearch(addr, function (results, status) {
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

		                        // 주소 정보를 해당 필드에 넣는다.
		                        document.getElementById("addr2").value = addr;
		                    } else {
		                        // 주소 검색 결과가 없을 때의 처리
		                        alert("사용 불가능한 주소입니다.");
		                        document.getElementById("addr2").value = "";
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
		
			
		
		<!-- 폼 전송 -->
		<script>
			document.getElementById('btnConfirm').addEventListener('click',	function() {
						// 모든 필드의 보더 초기화
						resetBorders();
						checkForm();
					});
		</script>
		
		<!-- 폼 체크  -->
<script>
    function checkForm() {
        var id = $("#id").val();
        var pw = $("#pw").val();
        var pw2 = $("#pw2").val();
        var name = $("#name").val();
        var phone = $("#phone").val();
        var email = $("#email").val();
        var addr2 = $("#addr2").val();
        var addr3 = $("#addr3").val();
        var agreeCheckbox = $("#agreeCheckbox");

        // 필드 순서대로 확인
        if (id === "") {
            showAlert("아이디를 입력해 주세요.", "id");
        } else if (pw === "") {
            showAlert("비밀번호를 입력해 주세요.", "pw");
        } else if (pw2 === "") {
            showAlert("비밀번호 확인을 입력해 주세요.", "pw2");
        } else if (pw !== pw2) {
            showAlert("비밀번호와 비밀번호 확인이 일치하지 않습니다.", "pw");
        } else if (name === "") {
            showAlert("이름을 입력해 주세요.", "name");
        } else if (phone === "") {
            showAlert("전화번호를 입력해 주세요.", "phone");
        } else if (email === "") {
            showAlert("이메일을 입력해 주세요.", "email");
        } else if (addr2 === "") {
            showAlert("주소를 입력해 주세요.", "addr2");
        } else if (addr3 === "") {
            showAlert("상세주소를 입력해 주세요.", "addr3");
        } else if (!agreeCheckbox.prop("checked")) {
            showAlert("회원 탈퇴 시, 새로마켓 홈페이지 탈퇴가 추가로 필요합니다. (필수 체크)", "agreeCheckbox");
        } else {
            // 모든 필드가 채워져 있을 경우에는 폼 제출
            document.getElementById('frmJoin').submit();
        }
    }

    function showAlert(message, fieldId) {
        alert(message);
        $("#" + fieldId).css("border", "3px solid orange");
        $("#" + fieldId).focus();
    }

    function resetBorders() {
        // 모든 필드의 보더 초기화
        $("#id, #pw, #pw2, #name, #phone, #email, #addr2, #addr3, #agreeCheckbox").css("border", "");
    }
</script>

		
		
	</body>
</html>