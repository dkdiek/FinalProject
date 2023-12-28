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
		<link rel="canonical"
			href="https://getbootstrap.kr/docs/5.3/examples/album/">
		<link rel="stylesheet"
			href="https://cdn.jsdelivr.net/npm/@docsearch/css@3">
		<link rel="stylesheet"
			href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
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
		<!-- <svg xmlns="http://www.w3.org/2000/svg" class="d-none">
	      <symbol id="check2" viewBox="0 0 16 16">
	        <path
				d="M13.854 3.646a.5.5 0 0 1 0 .708l-7 7a.5.5 0 0 1-.708 0l-3.5-3.5a.5.5 0 1 1 .708-.708L6.5 10.293l6.646-6.647a.5.5 0 0 1 .708 0z" />
	      </symbol>
	      <symbol id="circle-half" viewBox="0 0 16 16">
	        <path
				d="M8 15A7 7 0 1 0 8 1v14zm0 1A8 8 0 1 1 8 0a8 8 0 0 1 0 16z" />
	      </symbol>
	      <symbol id="moon-stars-fill" viewBox="0 0 16 16">
	        <path
				d="M6 .278a.768.768 0 0 1 .08.858 7.208 7.208 0 0 0-.878 3.46c0 4.021 3.278 7.277 7.318 7.277.527 0 1.04-.055 1.533-.16a.787.787 0 0 1 .81.316.733.733 0 0 1-.031.893A8.349 8.349 0 0 1 8.344 16C3.734 16 0 12.286 0 7.71 0 4.266 2.114 1.312 5.124.06A.752.752 0 0 1 6 .278z" />
	        <path
				d="M10.794 3.148a.217.217 0 0 1 .412 0l.387 1.162c.173.518.579.924 1.097 1.097l1.162.387a.217.217 0 0 1 0 .412l-1.162.387a1.734 1.734 0 0 0-1.097 1.097l-.387 1.162a.217.217 0 0 1-.412 0l-.387-1.162A1.734 1.734 0 0 0 9.31 6.593l-1.162-.387a.217.217 0 0 1 0-.412l1.162-.387a1.734 1.734 0 0 0 1.097-1.097l.387-1.162zM13.863.099a.145.145 0 0 1 .274 0l.258.774c.115.346.386.617.732.732l.774.258a.145.145 0 0 1 0 .274l-.774.258a1.156 1.156 0 0 0-.732.732l-.258.774a.145.145 0 0 1-.274 0l-.258-.774a1.156 1.156 0 0 0-.732-.732l-.774-.258a.145.145 0 0 1 0-.274l.774-.258c.346-.115.617-.386.732-.732L13.863.1z" />
	      </symbol>
	      <symbol id="sun-fill" viewBox="0 0 16 16">
	        <path
				d="M8 12a4 4 0 1 0 0-8 4 4 0 0 0 0 8zM8 0a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-1 0v-2A.5.5 0 0 1 8 0zm0 13a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-1 0v-2A.5.5 0 0 1 8 13zm8-5a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1h2a.5.5 0 0 1 .5.5zM3 8a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1h2A.5.5 0 0 1 3 8zm10.657-5.657a.5.5 0 0 1 0 .707l-1.414 1.415a.5.5 0 1 1-.707-.708l1.414-1.414a.5.5 0 0 1 .707 0zm-9.193 9.193a.5.5 0 0 1 0 .707L3.05 13.657a.5.5 0 0 1-.707-.707l1.414-1.414a.5.5 0 0 1 .707 0zm9.193 2.121a.5.5 0 0 1-.707 0l-1.414-1.414a.5.5 0 0 1 .707-.707l1.414 1.414a.5.5 0 0 1 0 .707zM4.464 4.465a.5.5 0 0 1-.707 0L2.343 3.05a.5.5 0 1 1 .707-.707l1.414 1.414a.5.5 0 0 1 0 .708z" />
	      </symbol>
	    </svg>
	
		<div
			class="dropdown position-fixed bottom-0 end-0 mb-3 me-3 bd-mode-toggle">
			<button
				class="btn btn-bd-primary py-2 dropdown-toggle d-flex align-items-center"
				id="bd-theme" type="button" aria-expanded="false"
				data-bs-toggle="dropdown" aria-label="Toggle theme (auto)">
				<svg class="bi my-1 theme-icon-active" width="1em" height="1em">
					<use href="#circle-half"></use></svg>
				<span class="visually-hidden" id="bd-theme-text">Toggle theme</span>
			</button>
			<ul class="dropdown-menu dropdown-menu-end shadow"
				aria-labelledby="bd-theme-text">
				<li>
					<button type="button"
						class="dropdown-item d-flex align-items-center"
						data-bs-theme-value="light" aria-pressed="false">
						<svg class="bi me-2 opacity-50 theme-icon" width="1em" height="1em">
							<use href="#sun-fill"></use></svg>
						Light
						<svg class="bi ms-auto d-none" width="1em" height="1em">
							<use href="#check2"></use></svg>
					</button>
				</li>
				<li>
					<button type="button"
						class="dropdown-item d-flex align-items-center"
						data-bs-theme-value="dark" aria-pressed="false">
						<svg class="bi me-2 opacity-50 theme-icon" width="1em" height="1em">
							<use href="#moon-stars-fill"></use></svg>
						Dark
						<svg class="bi ms-auto d-none" width="1em" height="1em">
							<use href="#check2"></use></svg>
					</button>
				</li>
				<li>
					<button type="button"
						class="dropdown-item d-flex align-items-center active"
						data-bs-theme-value="auto" aria-pressed="true">
						<svg class="bi me-2 opacity-50 theme-icon" width="1em" height="1em">
							<use href="#circle-half"></use></svg>
						Auto
						<svg class="bi ms-auto d-none" width="1em" height="1em">
							<use href="#check2"></use></svg>
					</button>
				</li>
			</ul>
		</div> -->
	
	
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
							<button class="w-100 mb-2 btn btn-lg rounded-3 btn-secondary"
								type="submit">회원가입</button>
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
						</form>
					</div>
				</div>
			</div>
		</div>
		
		<main>
	
		<section class="py-5 text-center container">
			<div class="row py-lg-5">
				<div class="col-lg-6 col-md-8 mx-auto">
					<h1 class="fw-light">새로 마켓</h1>
					<p class="lead text-body-secondary">Something short and leading
						about the collection below—its contents, the creator, etc. Make it
						short and sweet, but not too short so folks don’t simply skip over
						it entirely.</p>
					<p>
						<a href="#" class="btn btn-primary my-2">지금 보러가기</a> <a href="#"
							class="btn btn-secondary my-2">쇼핑하기</a>
					</p>
				</div>
			</div>
		</section>
	
		<div class="album py-5 bg-body-tertiary">
			<div class="container">
	
				<div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
					<div class="col">
						<div class="card shadow-sm">
							<svg class="bd-placeholder-img card-img-top" width="100%"
								height="225" xmlns="http://www.w3.org/2000/svg" role="img"
								aria-label="Placeholder: Thumbnail"
								preserveAspectRatio="xMidYMid slice" focusable="false">
								<title>Placeholder</title><rect width="100%" height="100%"
									fill="#55595c" />
								<text x="50%" y="50%" fill="#eceeef" dy=".3em">Thumbnail</text></svg>
							<div class="card-body">
								<p class="card-text">세탁세제</p>
								<p class="card-text">10,000원</p>
								<p class="card-text">인천 계양구 계양1동</p>
								<p class="card-text">관심 21.채팅14</p>
								<div class="d-flex justify-content-between align-items-center">
									<div class="btn-group">
										<button type="button" class="btn btn-sm btn-outline-secondary">View</button>
										<button type="button" class="btn btn-sm btn-outline-secondary">Edit</button>
									</div>
									<small class="text-body-secondary">9 분전</small>
								</div>
							</div>
						</div>
					</div>
					<div class="col">
						<div class="card shadow-sm">
							<svg class="bd-placeholder-img card-img-top" width="100%"
								height="225" xmlns="http://www.w3.org/2000/svg" role="img"
								aria-label="Placeholder: Thumbnail"
								preserveAspectRatio="xMidYMid slice" focusable="false">
								<title>Placeholder</title><rect width="100%" height="100%"
									fill="#55595c" />
								<text x="50%" y="50%" fill="#eceeef" dy=".3em">Thumbnail</text></svg>
							<div class="card-body">
								<p class="card-text">This is a wider card with supporting
									text below as a natural lead-in to additional content. This
									content is a little bit longer.</p>
								<div class="d-flex justify-content-between align-items-center">
									<div class="btn-group">
										<button type="button" class="btn btn-sm btn-outline-secondary">View</button>
										<button type="button" class="btn btn-sm btn-outline-secondary">Edit</button>
									</div>
									<small class="text-body-secondary">9 mins</small>
								</div>
							</div>
						</div>
					</div>
					<div class="col">
						<div class="card shadow-sm">
							<svg class="bd-placeholder-img card-img-top" width="100%"
								height="225" xmlns="http://www.w3.org/2000/svg" role="img"
								aria-label="Placeholder: Thumbnail"
								preserveAspectRatio="xMidYMid slice" focusable="false">
								<title>Placeholder</title><rect width="100%" height="100%"
									fill="#55595c" />
								<text x="50%" y="50%" fill="#eceeef" dy=".3em">Thumbnail</text></svg>
							<div class="card-body">
								<p class="card-text">This is a wider card with supporting
									text below as a natural lead-in to additional content. This
									content is a little bit longer.</p>
								<div class="d-flex justify-content-between align-items-center">
									<div class="btn-group">
										<button type="button" class="btn btn-sm btn-outline-secondary">View</button>
										<button type="button" class="btn btn-sm btn-outline-secondary">Edit</button>
									</div>
									<small class="text-body-secondary">9 mins</small>
								</div>
							</div>
						</div>
					</div>
	
					<div class="col">
						<div class="card shadow-sm">
							<svg class="bd-placeholder-img card-img-top" width="100%"
								height="225" xmlns="http://www.w3.org/2000/svg" role="img"
								aria-label="Placeholder: Thumbnail"
								preserveAspectRatio="xMidYMid slice" focusable="false">
								<title>Placeholder</title><rect width="100%" height="100%"
									fill="#55595c" />
								<text x="50%" y="50%" fill="#eceeef" dy=".3em">Thumbnail</text></svg>
							<div class="card-body">
								<p class="card-text">This is a wider card with supporting
									text below as a natural lead-in to additional content. This
									content is a little bit longer.</p>
								<div class="d-flex justify-content-between align-items-center">
									<div class="btn-group">
										<button type="button" class="btn btn-sm btn-outline-secondary">View</button>
										<button type="button" class="btn btn-sm btn-outline-secondary">Edit</button>
									</div>
									<small class="text-body-secondary">9 mins</small>
								</div>
							</div>
						</div>
					</div>
					<div class="col">
						<div class="card shadow-sm">
							<svg class="bd-placeholder-img card-img-top" width="100%"
								height="225" xmlns="http://www.w3.org/2000/svg" role="img"
								aria-label="Placeholder: Thumbnail"
								preserveAspectRatio="xMidYMid slice" focusable="false">
								<title>Placeholder</title><rect width="100%" height="100%"
									fill="#55595c" />
								<text x="50%" y="50%" fill="#eceeef" dy=".3em">Thumbnail</text></svg>
							<div class="card-body">
								<p class="card-text">This is a wider card with supporting
									text below as a natural lead-in to additional content. This
									content is a little bit longer.</p>
								<div class="d-flex justify-content-between align-items-center">
									<div class="btn-group">
										<button type="button" class="btn btn-sm btn-outline-secondary">View</button>
										<button type="button" class="btn btn-sm btn-outline-secondary">Edit</button>
									</div>
									<small class="text-body-secondary">9 mins</small>
								</div>
							</div>
						</div>
					</div>
					<div class="col">
						<div class="card shadow-sm">
							<svg class="bd-placeholder-img card-img-top" width="100%"
								height="225" xmlns="http://www.w3.org/2000/svg" role="img"
								aria-label="Placeholder: Thumbnail"
								preserveAspectRatio="xMidYMid slice" focusable="false">
								<title>Placeholder</title><rect width="100%" height="100%"
									fill="#55595c" />
								<text x="50%" y="50%" fill="#eceeef" dy=".3em">Thumbnail</text></svg>
							<div class="card-body">
								<p class="card-text">This is a wider card with supporting
									text below as a natural lead-in to additional content. This
									content is a little bit longer.</p>
								<div class="d-flex justify-content-between align-items-center">
									<div class="btn-group">
										<button type="button" class="btn btn-sm btn-outline-secondary">View</button>
										<button type="button" class="btn btn-sm btn-outline-secondary">Edit</button>
									</div>
									<small class="text-body-secondary">9 mins</small>
								</div>
							</div>
						</div>
					</div>
	
					<div class="col">
						<div class="card shadow-sm">
							<svg class="bd-placeholder-img card-img-top" width="100%"
								height="225" xmlns="http://www.w3.org/2000/svg" role="img"
								aria-label="Placeholder: Thumbnail"
								preserveAspectRatio="xMidYMid slice" focusable="false">
								<title>Placeholder</title><rect width="100%" height="100%"
									fill="#55595c" />
								<text x="50%" y="50%" fill="#eceeef" dy=".3em">Thumbnail</text></svg>
							<div class="card-body">
								<p class="card-text">This is a wider card with supporting
									text below as a natural lead-in to additional content. This
									content is a little bit longer.</p>
								<div class="d-flex justify-content-between align-items-center">
									<div class="btn-group">
										<button type="button" class="btn btn-sm btn-outline-secondary">View</button>
										<button type="button" class="btn btn-sm btn-outline-secondary">Edit</button>
									</div>
									<small class="text-body-secondary">9 mins</small>
								</div>
							</div>
						</div>
					</div>
					<div class="col">
						<div class="card shadow-sm">
							<svg class="bd-placeholder-img card-img-top" width="100%"
								height="225" xmlns="http://www.w3.org/2000/svg" role="img"
								aria-label="Placeholder: Thumbnail"
								preserveAspectRatio="xMidYMid slice" focusable="false">
								<title>Placeholder</title><rect width="100%" height="100%"
									fill="#55595c" />
								<text x="50%" y="50%" fill="#eceeef" dy=".3em">Thumbnail</text></svg>
							<div class="card-body">
								<p class="card-text">This is a wider card with supporting
									text below as a natural lead-in to additional content. This
									content is a little bit longer.</p>
								<div class="d-flex justify-content-between align-items-center">
									<div class="btn-group">
										<button type="button" class="btn btn-sm btn-outline-secondary">View</button>
										<button type="button" class="btn btn-sm btn-outline-secondary">Edit</button>
									</div>
									<small class="text-body-secondary">9 mins</small>
								</div>
							</div>
						</div>
					</div>
					<div class="col">
						<div class="card shadow-sm">
							<svg class="bd-placeholder-img card-img-top" width="100%"
								height="225" xmlns="http://www.w3.org/2000/svg" role="img"
								aria-label="Placeholder: Thumbnail"
								preserveAspectRatio="xMidYMid slice" focusable="false">
								<title>Placeholder</title><rect width="100%" height="100%"
									fill="#55595c" />
								<text x="50%" y="50%" fill="#eceeef" dy=".3em">Thumbnail</text></svg>
							<div class="card-body">
								<p class="card-text">This is a wider card with supporting
									text below as a natural lead-in to additional content. This
									content is a little bit longer.</p>
								<div class="d-flex justify-content-between align-items-center">
									<div class="btn-group">
										<button type="button" class="btn btn-sm btn-outline-secondary">View</button>
										<button type="button" class="btn btn-sm btn-outline-secondary">Edit</button>
									</div>
									<small class="text-body-secondary">9 mins</small>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	
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