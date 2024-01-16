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
			<div class="col-5 offset-1">
			    <form id="searchForm" role="search" action="/search" method="GET" class="d-flex align-items-center">
			        <input class="form-control" type="search" name="title" placeholder="어떤 상품을 찾으시나요?" aria-label="Search">
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
							<li><a class="dropdown-item rounded-2" href="<c:url value='/likeList'/>">관심 목록</a></li>
							<li><a class="dropdown-item rounded-2" href="<c:url value='/search?seller_id=${sessionScope.id}'/>">판매 내역</a></li>
							<li><hr class="dropdown-divider"></li>
							<li><a class="dropdown-item rounded-2" href="<c:url value='/updateMemberInfo'/>">회원 정보 변경</a></li>
							<li><a class="dropdown-item rounded-2" href="<c:url value='/withdrawal'/>">회원 탈퇴</a></li>
							<li><hr class="dropdown-divider"></li>
							
							<c:set var="loginType" value="${sessionScope.loginType}" />
							<!-- 카카오 로그아웃 -->
							<c:if test="${loginType eq 'Kakao'}">
								<li>
									<a class="dropdown-item rounded-2" href="javascript:void(0);" id="logoutBtnK">카카오 로그아웃</a>
								</li>
							</c:if>
							<!-- 일반 로그아웃 -->
							<c:if test="${loginType eq 'Home'}">
								<li>
									<a class="dropdown-item rounded-2" href="javascript:void(0);" id="logoutBtn">로그아웃</a>
								</li>
							</c:if>
						</ul>
					</div>
				</c:if>
			</div>
			<c:if test="${not empty userId}">
			
			<!-- 메시지버튼 -->
			<div class="col-1">
				<button id="btnMsg" class="btn btn-primary">
					<i class="bi bi-chat-left-text-fill fs-3"></i>
				</button>
			</div>
			</c:if>
			<!-- 메뉴버튼 -->
			<div class="col-1">
				<button class="btn btn-primary" data-bs-toggle="offcanvas" data-bs-target="#sidebar" aria-controls="sidebar">
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
					<form id="findMembership" action="<c:url value='/findAccount'/>">
						<button id="btnFindMembership" class="btn btn-link type="submit">계정 찾기</button>
					</form>
				</div>


				<hr class="my-4">
				<h2 class="fs-5 fw-bold mb-3">간편 로그인</h2>
				<div id="snsLoginBtnDiv" style="text-align: center">
					<!-- 네이버 로그인 -->
					<div class="social-login" id="naver_id_login">
						<a href="#no" title="네이버ID로 로그인" class="naver-login" id="naverLogin">
							<button class="w-60 mb-2 btn btn-outline-secondary rounded-3" type="button" style="background-color: #06be34">
						   	 <img src="<c:url value='/cdn/images/common/btnNaver.png'/>" style="max-width: 90%">
							</button>
						</a>
					</div>
					<!-- 카카오 로그인 -->
					<button class="w-60 btn btn-outline-secondary rounded-3" style="background-color: #f9e000" onclick="javascript:kakaoLogin()">
						<img src="<c:url value='/cdn/images/common/btnKakao.png'/>" style="max-width: 90%">
					</button>
				</div>

			</div>
		</div>
	</div>
</div>

<!-- 사이드바 -->
<div class="offcanvas offcanvas-end bg-body-tertiary" tabindex="-1" id="sidebar" aria-labelledby="sidebarLabel" style="width: 280px;">

<div class="d-flex flex-column flex-shrink-0 p-3 bg-body-tertiary" style="width: 280px;">
    <div class="d-flex align-items-center mb-3 mb-md-0 me-md-auto link-body-emphasis text-decoration-none" onclick="closeSidebar()">
      <svg class="bi pe-none me-2" width="40" height="32"></svg>
      <span class="fs-4"><i class="bi bi-list me-2"></i> MENU</span>
    </div>
    <hr>
    <ul class="nav nav-pills flex-column mb-auto">
      <li class="nav-item">
        <a  class="nav-link active" aria-current="page">
          <svg class="bi pe-none me-2" width="16" height="16"> </svg>
          	<c:if test="${empty id}">
			    <i class="bi bi-person-fill me-2"></i> 비회원
			</c:if>
			<c:if test="${not empty id}">
			    <i class="bi bi-person-check-fill me-2"></i> ${id}
			</c:if>
        </a>
      </li>
      <li>
        <a href="<c:url value='/'/>" class="nav-link link-body-emphasis">
          <svg class="bi pe-none me-2" width="16" height="16"></svg>
         	홈 화면
        </a>
      </li>
      <li>
        <a href="<c:url value='/writeView'/>" class="nav-link link-body-emphasis">
          <svg class="bi pe-none me-2" width="16" height="16"></svg>
         	 판매글 작성
        </a>
      </li>
      <hr>
      <!-- 하드코딩된 카테고리 목록 -->
      <c:set var="categoryList" value="${fn:split('디지털기기,가구/인테리어,유아동,생활가전,생활/주방,가공식품,스포츠/레저,취미/게임/음반,뷰티/미용,식물,반려동물용품,티켓/교환권,도서,유아도서,기타 중고물품', ',')}"/>

		<c:forEach var="category" items="${categoryList}">
		    <li>
		        <a href="http://localhost/search?title=&distance_from=&distance_to=&soldout_yn=&category=${category}" class="nav-link link-body-emphasis">
		            <svg class="bi pe-none me-2" width="16" height="16"></svg>
		            ${category}
		        </a>
		    </li>
		</c:forEach>

    </ul>
    <hr>
  </div>
 </div>

	<!-- 로그인 스크립트 -->
	<script>
	    // 버튼 클릭 이벤트 리스너 등록
	    $("#btnLogin").on("click", function () {
	        // 로그인 폼 데이터 가져오기
	        var formData = $("#loginForm").serialize();
	
	        // 현재 페이지 URL 가져오기
	        var currentUrl = window.location.href;
	
	        // 로그인 폼 데이터에 현재 페이지 URL 추가
	        formData += "&returnUrl=" + encodeURIComponent(currentUrl);
	
	        // 서버에 AJAX 요청
	        $.ajax({
	            url: "/login",
	            type: "POST",
	            data: formData,
	            dataType: "json",
	            success: function (data) {
	                // 서버 응답 처리
	
	                if (data.message === "success") {
	                    // 로그인 성공 시 리다이렉트 또는 다른 동작 수행
	                    if (data.returnUrl) {
	                        // 리다이렉트 URL이 있으면 해당 URL로 이동
	                        window.location.href = data.returnUrl;
	                    } else {
	                        // 리다이렉트 URL이 없으면 기본 페이지로 이동
	                        window.location.href = "/";
	                    }
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
	
	
	<!-- 로그아웃 -->
	<script>
	  $(document).ready(function () {
	    // 일반멤버
	    $("#logoutBtn").on("click", function () {
	      // 현재 페이지 URL 가져오기
	      var pageUrl = window.location.href;
	      
	      // 로그아웃 요청
	      $.ajax({
	        url: "/logout",
	        type: "GET",
	        data: { pageUrl: pageUrl }, // 페이지 URL 전달
	        success: function () {
	          // 로그아웃 성공 시 리다이렉트 또는 다른 동작 수행
	          window.location.reload(); // 현재 페이지 새로고침
	        },
	        error: function (error) {
	          console.error("에러:", error);
	          alert("로그아웃에 실패했습니다.");
	        }
	      });
	    });
	    //카카오멤버
	    $("#logoutBtnK").on("click", function () {
	        // 현재 페이지 URL 가져오기
	        var returnUrl = window.location.href;
	        
	        // 로그아웃 요청
	        $.ajax({
	          url: "/logout",
	          type: "GET",
	          data: { returnUrl: returnUrl }, // 페이지 URL 전달
	          success: function () {
	            // 로그아웃 성공 시 리다이렉트 또는 다른 동작 수행
	              window.location.href = "https://kauth.kakao.com/oauth/logout?client_id=ce5959441a26bb6ca04de7134c4cc8e3&logout_redirect_uri=http://localhost/logout";
	          },
	          error: function (error) {
	            console.error("에러:", error);
	            alert("로그아웃에 실패했습니다.");
	          }
	        });
	      });
	    
	    
	    
	  });
	</script>
	
	<!-- 검색창 폼 섭밋 -->
	<script>
		function handleSearch(event) {
		    if (event.key === 'Enter') {
		        submitSearchForm();
		    }
		}
		
		function submitSearchForm() {
		    document.getElementById("searchForm").submit();
		}
	</script>
	
	<!-- 메세지버튼 -->
	<script>
	
	btnMsg.addEventListener('click', function() {
	    window.location.href = '/messageList'})
	    
	</script>

	<!-- 카카오 로그인!!!!!!!!!!!!!!!!!!!!!! 팝업으로 안나오게수정!!!!!!!!!!!!!!!!!!!!!!! -->
		<script type="text/javascript">
		    Kakao.init('ce5959441a26bb6ca04de7134c4cc8e3');
		    function kakaoLogin() {
		        Kakao.Auth.login({
		            success: function (response) {
		                Kakao.API.request({
		                    url: '/v2/user/me',
		                    //로그인성공
		                    success: function (response) {
		                        $.ajax({
		    			            type: "POST"
		    			            , url: "/kakaoLogin"
		    			            , dataType: "json"
		    	                    , contentType: "application/json"  // 추가된 부분
		    			            , data: JSON.stringify({ response: response })
		    			            , success: function(data) {
		    			                // 서버로부터의 응답을 처리
		    			                if (data.message === "success") {
			    			                alert('카카오 계정 로그인 되었습니다')  
			    			                location.reload();
		    			                } else {
		    			                if (data.message === "redirect") {
			    			                alert('새로마켓 이용을 위해 최초 1회 추가 정보 입력이 진행됩니다') 
			    			                /* window.location.href = '/joinKakaoMember?member_id=' + data.member_id; */
			    			            	 // 폼 엘리먼트를 동적으로 생성
			    			                var form = document.createElement("form");
			    			                form.method = "post";
			    			                form.action = "/joinKakaoMember";
		
			    			                // hidden input 엘리먼트를 생성하고 값을 설정
			    			                var memberIdInput = document.createElement("input");
			    			                memberIdInput.type = "hidden";
			    			                memberIdInput.name = "member_id";
			    			                memberIdInput.value = data.member_id;
		
			    			                // 폼에 hidden input을 추가
			    			                form.appendChild(memberIdInput);
		
			    			                // body에 폼을 추가하고 전송
			    			                document.body.appendChild(form);
			    			                form.submit();
		    			                } else {
		    			                    alert("회원 정보를 찾을 수 없습니다");
		    			                }
		    			            }
		    			            },
		    			            error: function() {
		    			                // AJAX 요청 실패 시 처리 로직 추가
		    			                alert("서버에 장애가 발생하였습니다");
		    			            }
		    			        });
		                        
		                    },
		                    //로그인실패 
		                    fail: function (error) {
		                        alert(JSON.stringify(error))
		                    }
		                })
		            },
		            //로그인 에러
		            fail: function (error) {
		                alert(JSON.stringify(error))
		            },
		        })
		    }
		</script>
		<!-- 네이버로그인 버튼수정필요!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
		<script>
			var naver_id_login = new naver_id_login("azdDptdhj5zpBKzKMGuq", "http://localhost/naverCallback");
		  	var state = naver_id_login.getUniqState();
		  	<!--naver_id_login.setButton("white", 2,40);-->
		  	naver_id_login.setDomain("http://localhost");
		  	naver_id_login.setState(state);
		  	naver_id_login.init_naver_id_login();
		</script>
		
		
		