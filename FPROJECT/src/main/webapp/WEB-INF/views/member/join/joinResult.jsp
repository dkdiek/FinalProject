<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!doctype html>
<html lang="en" data-bs-theme="auto">
	<head>
		<!-- 수정된 부트스트랩 CSS 파일 경로 -->
		<script src="/cdn/js/bootstrap/color-modes.js"></script>
		<script src="/cdn/js/bootstrap/bootstrap.bundle.min.js"></script>
		<link rel="canonical" href="https://getbootstrap.kr/docs/5.3/examples/album/">
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@docsearch/css@3">
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
		<link href="/cdn/css/bootstrap/bootstrap.min.css" rel="stylesheet">
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta name="description" content="새로마켓에서 모든 것이 새로워진다!">
		<meta name="author" content="Yongkwon Lee">
		<meta name="generator" content="Hugo 0.115.4">
		<title>새로마켓</title>
		
		
		<style>
			.bd-placeholder-img {
				font-size: 1.125rem;
				text-anchor: middle;
				-webkit-user-select: none;
				-moz-user-select: none;
				user-select: none;
			}
			
			@media ( min-width : 768px) {
	
				.bd-placeholder-img-lg {
					font-size: 3.5rem;
				}
			}
			
			.b-example-divider {
				width: 100%;
				height: 3rem;
				background-color: rgba(0, 0, 0, .1);
				border: solid rgba(0, 0, 0, .15);
				border-width: 1px 0;
				box-shadow: inset 0 .5em 1.5em rgba(0, 0, 0, .1), inset 0 .125em .5em
					rgba(0, 0, 0, .15);
			}
			
			.b-example-vr {
				flex-shrink: 0;
				width: 1.5rem;
				height: 100vh;
			}
			
			.bi {
				vertical-align: -.125em;
				fill: currentColor;
			}
			
			.nav-scroller {
				position: relative;
				z-index: 2;
				height: 2.75rem;
				overflow-y: hidden;
			}
			
			.nav-scroller .nav {
				display: flex;
				flex-wrap: nowrap;
				padding-bottom: 1rem;
				margin-top: -1px;
				overflow-x: auto;
				text-align: center;
				white-space: nowrap;
				-webkit-overflow-scrolling: touch;
			}
			
			.btn-bd-primary { -
				-bd-violet-bg: #712cf9; -
				-bd-violet-rgb: 112.520718, 44.062154, 249.437846; -
				-bs-btn-font-weight: 600; -
				-bs-btn-color: var(- -bs-white); -
				-bs-btn-bg: var(- -bd-violet-bg); -
				-bs-btn-border-color: var(- -bd-violet-bg); -
				-bs-btn-hover-color: var(- -bs-white); -
				-bs-btn-hover-bg: #6528e0; -
				-bs-btn-hover-border-color: #6528e0; -
				-bs-btn-focus-shadow-rgb: var(- -bd-violet-rgb); -
				-bs-btn-active-color: var(- -bs-btn-hover-color); -
				-bs-btn-active-bg: #5a23c8; -
				-bs-btn-active-border-color: #5a23c8;
			}
			
			.bd-mode-toggle {
				z-index: 1500;
			}
		</style>
	
	
	</head>
	<body>
		<header data-bs-theme="light" class="sticky-top">
		    <div class="navbar navbar-dark bg-primary shadow-sm">
		        <div class="container">
		            <!-- 로고 -->
		            <span style="width: 20%">
		            	<a href="<c:url value='/'/>">
			                <img src="<c:url value='/cdn/images/common/LogoEng.png'/>" style="width: 100%">
		            	</a>
		            </span>
		
		            <!-- 공백 -->
		           <span style="width: 10%;"></span>
		
		            <!-- 검색창 -->
		            <span style="width: 50%;">
		                <form role="search" style="width: 100%;">
		                    <input class="form-control" type="search" placeholder="원하는 제품 또는 지역을 검색하세요" aria-label="Search">
		                </form>
		            </span>
		
		            <!-- 공백 -->
		            <span style="width: 10%;"></span>
		
		            <!-- 버튼 -->
		            <span style="width: 10%;">
		                <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#signupModal">
		                    <i class="bi bi-person-fill fs-2"></i>
		                </button>
		                <!-- 메뉴버튼 -->
		                <button class="btn btn-primary">
		                    <i class="bi bi-list  fs-2"></i>
		                </button>
		            </span>
		        </div>
		    </div>
		</header>
	
		<!-- 로그인 모달 -->
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
									id="floatingInput" name="id" placeholder="name@example.com"> <label
									for="floatingInput" >ID</label>
							</div>
							<div class="form-floating mb-3">
								<input type="password" class="form-control rounded-3"
									id="floatingPassword" name="password" placeholder="Password"> <label
									for="floatingPassword" >비밀번호</label>
							</div>
							<button id="btnLogin"  class="w-100 mb-2 btn btn-lg rounded-3 btn-primary"
								type="button">로그인</button>
						</form>
						
						<form id="joinForm" action="<c:url value='/joinMembership'/>">
							<button id="btnJoinMembership" class="w-100 mb-2 btn btn-lg rounded-3 btn-secondary"
								type="submit">회원가입</button>
						</form>
						
							계정 찾기
							<hr class="my-4">
							<h2 class="fs-5 fw-bold mb-3">간편 로그인</h2>
							<button
								class="w-100 py-2 mb-2 btn btn-outline-secondary rounded-3"
								type="submit" style="background-color: #2DB400">
								<svg class="bi me-1" width="16" height="16">
									<use xlink:href="#twitter"></use></svg>
								네이버로 로그인
							</button>
							<button
								class="w-100 py-2 mb-2 btn btn-outline-secondary rounded-3"
								type="submit" style="background-color: #f9e000">
								<svg class="bi me-1" width="16" height="16">
									<use xlink:href="#facebook"></use></svg>
								카카오로 로그인
							</button>
							<button
								class="w-100 py-2 mb-2 btn btn-outline-secondary rounded-3"
								type="submit">
								<svg class="bi me-1" width="16" height="16">
									<use xlink:href="#github"></use></svg>
								구글 로그인
							</button>
					
					</div>
				</div>
			</div>
		</div>
		
		<main>
			<h1>회원가입 결과</h1>
    
			    <c:choose>
			        <c:when test="${result eq '1'}">
			            <p>회원가입이 성공적으로 완료되었습니다.</p>
			        </c:when>
			        <c:when test="${result eq '0'}">
			            <p>회원가입 중 오류가 발생했습니다. 다시 시도해 주세요.</p>
			        </c:when>
			        <c:otherwise>
			            <p>알 수 없는 오류가 발생했습니다.</p>
			        </c:otherwise>
			    </c:choose>
			    
			    <p><a href="/">홈으로 돌아가기</a></p>
			
		</main>
		
		<!-- Footer -->
		<footer class="text-body-secondary py-5">
			<div class="container">
				<p class="float-end mb-1">
					<a href="#">Back to top</a>
				</p>
				<p>
				대표 박새로이<br>
				사업자번호 135-37-00238<br>
				주소 서울특별시 구로구 디지털로 10길 25, 1209호<br>
				전화 1544-9796<br>
				고객문의 cs@daangnservice.com<br>
				</p>
			</div>
		</footer>
		
		<script>
		    // 로그인 버튼을 찾아서 이벤트 리스너 추가
		    document.getElementById("btnLogin").addEventListener("click", function() {
		        // 이벤트 핸들러 내에서 로그인 폼 데이터를 가져와서 서버로 전송
		        var formData = new FormData(document.getElementById("loginForm"));
		
		        fetch("/login", {
		            method: "POST",
		            body: formData
		        })
		        .then(response => {
		            if (!response.ok) {
		                throw new Error("서버 응답이 실패했습니다.");
		            }
		            return response.json();
		        })
		        .then(data => {
		            // 서버 응답 처리
		            console.log(data);
		
		            // 성공 또는 실패에 따라 동작 수행
		            if (data.message === "로그인에 성공했습니다.") {
		                // 로그인 성공 시 리다이렉트 또는 다른 동작 수행
		                window.location.href = "/home";
		            } else {
		                // 로그인 실패 시 에러 메시지 출력 또는 다른 동작 수행
		                console.error("로그인 실패:", data.message);
		            }
		        })
		        .catch(error => console.error("에러:", error));
		    });
		</script>
	</body>
</html>