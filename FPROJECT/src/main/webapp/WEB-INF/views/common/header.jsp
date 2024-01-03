<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<header class="sticky-top">

	<div class="navbar bg-primary shadow-sm">
		<div class="container">
			<!-- 로고 -->
			<div class="col-2">
				<a href="<c:url value='/'/>"> <img
					src="<c:url value='/cdn/images/common/LogoEng.png'/>"
					style="max-width: 100%;">
				</a>
			</div>
			<!-- 검색창 -->
			<div class="col-6 offset-1">
				<form role="search">
					<input class="form-control" type="search"
						placeholder="원하는 제품 또는 지역을 검색하세요" aria-label="Search">
				</form>
			</div>
			<!-- 마이버튼 -->
			<div class="col-1  offset-1">
				<%-- 세션에서 ID를 불러옴 --%>
				<c:set var="userId" value="${sessionScope.id}" />
				<c:if test="${empty userId}">
					<div>
						<button class="btn btn-primary" data-bs-toggle="modal"
							data-bs-target="#signupModal">
							<i class="bi bi-person-fill fs-1"></i>
						</button>
					</div>
				</c:if>
				<c:if test="${not empty userId}">
					<div class="dropdown">
						<button class="btn btn-primary" data-bs-toggle="dropdown">
							<i class="bi bi-person-check-fill fs-1"></i>
						</button>
						<ul class="dropdown-menu">
							<li class="dropdown-item active">${id}님</li>
							<li><hr class="dropdown-divider"></li>
							<li><a class="dropdown-item rounded-2" href="#">마이페이지</a></li>
							<li><a class="dropdown-item rounded-2" href="#">관심목록</a></li>
							<li><a class="dropdown-item rounded-2" href="#">판매내역</a></li>
							<li><a class="dropdown-item rounded-2" href="#">구매내역</a></li>
							<li><hr class="dropdown-divider"></li>
							<li><a class="dropdown-item rounded-2" href="<c:url value='/logout'/>">로그아웃</a></li>
						</ul>
					</div>
				</c:if>
			</div>
			<!-- 메뉴버튼 -->
			<div class="col-1">
				<button class="btn btn-primary" data-bs-toggle="offcanvas"
					data-bs-target="#sidebar" aria-controls="sidebar">
					<i class="bi bi-list fs-1"></i>
				</button>
			</div>

		</div>
	</div>

</header>

<!-- 로그인X 로그인 모달 -->
<div class="modal fade" id="signupModal" tabindex="-1"
	aria-labelledby="signupModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content rounded-4 shadow">
			<div class="modal-header p-5 pb-4 border-bottom-0">
				<h1 class="fw-bold mb-0 fs-2">로그인</h1>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>

			<div class="modal-body p-5 pt-0">

				<form id="loginForm">
					<div class="form-floating mb-3">
						<input type="text" class="form-control rounded-3"
							id="floatingInput" name="id">
						<label for="floatingInput">ID</label>
					</div>
					<div class="form-floating mb-3">
						<input type="password" class="form-control rounded-3"
							id="floatingPassword" name="password">
						<label for="floatingPassword">비밀번호</label>
					</div>
					<button id="btnLogin"
						class="w-100 mb-2 btn btn-lg rounded-3 btn-primary" type="button">로그인</button>
				</form>

				<form id="joinForm" action="<c:url value='/joinMembership'/>">
					<button id="btnJoinMembership"
						class="w-100 mb-2 btn btn-lg rounded-3 btn-secondary"
						type="submit">회원가입</button>
				</form>

				<div style="text-align: center">
					<form id="findMembership" action="<c:url value='/미정'/>">
						<button id="btnFindMembership"
							class="btn btn-link type="submit">계정 찾기</button>
					</form>
				</div>


				<hr class="my-4">
				<h2 class="fs-5 fw-bold mb-3">간편 로그인</h2>
				<div id="snsLoginBtnDiv" style="text-align: center">
					<button class="w-60 mb-2 btn btn-outline-secondary rounded-3"
						type="submit" style="background-color: #06be34">
						<img src="<c:url value='/cdn/images/common/btnNaver.png'/>"
							style="max-width: 90%">
					</button>
					<button class="w-60 btn btn-outline-secondary rounded-3"
						type="submit" style="background-color: #f9e000">
						<img src="<c:url value='/cdn/images/common/btnKakao.png'/>"
							style="max-width: 90%">
					</button>
				</div>

			</div>
		</div>
	</div>
</div>

<!-- 사이드바 -->
<div class="offcanvas offcanvas-end" tabindex="-1" id="sidebar"
	aria-labelledby="sidebarLabel">
	<div class="offcanvas-header">
		<h5 class="offcanvas-title" id="sidebarLabel">Sidebar</h5>
		<button type="button" class="btn-close text-reset"
			data-bs-dismiss="offcanvas" aria-label="Close"></button>
	</div>
	<div class="offcanvas-body">
		<ul class="nav flex-column">
			<li class="nav-item"><a class="nav-link active"
				href="<c:url value='/'/>"> <i class="bi bi-house-door"></i> 메인화면
			</a></li>

			<c:if test="${not empty userId}">
				<li class="nav-item">
					<form action="/writeView" method="get">
            			<button type="submit" class="nav-link active" style="border: none; background-color: transparent; cursor: pointer;">
               				 <i class="bi bi-upload"></i> 판매하기
           				 </button>
     				</form>
				</li>
			</c:if>

		</ul>
	</div>
</div>


<!-- 스크립트 -->
<script>
    // 버튼 클릭 이벤트 리스너 등록
    $("#btnLogin").on("click", function () {
        // 로그인 폼 데이터 가져오기
        var formData = $("#loginForm").serialize();

        // 서버에 AJAX 요청
        $.ajax({
            url: "/login",
            type: "POST",
            data: formData,
            dataType: "json", // 데이터 타입을 JSON으로 명시
            success: function (data) {
                // 서버 응답 처리
                console.log(data);

                // 성공 또는 실패에 따라 동작 수행
                if (data.message === "success") {
                    // 로그인 성공 시 리다이렉트 또는 다른 동작 수행
                    window.location.href = "/";
                } else {
                    // 로그인 실패 시 에러 메시지 출력 또는 다른 동작 수행
                    console.error("로그인 실패:", data.message);
                    alert("로그인에 실패했습니다. 회원 정보를 확인하세요.");
                }
            },
            error: function (error) {
                console.error("에러:", error);
                   alert("로그인에 실패했습니다. 회원 정보를 확인하세요.");
            }
        });
    });
</script>
