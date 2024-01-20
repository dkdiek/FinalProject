<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<head>
	<!-- 수정된 부트스트랩 CSS 파일 경로 -->
	<script src="/cdn/js/bootstrap/color-modes.js"></script>
	<script src="/cdn/js/bootstrap/bootstrap.bundle.min.js"></script>
	<link rel="canonical" href="https://getbootstrap.kr/docs/5.3/examples/album/">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@docsearch/css@3">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
	<link rel="stylesheet" href="<c:url value='/cdn/css/bootstrap/bootstrap.min.css'/>">
	<!-- favicon -->
	<link rel="shortcut icon" href="<c:url value='/cdn/images/favicon.ico'/>" type="image/x-icon" />
   	<link rel="icon" href="<c:url value='/cdn/images/favicon.ico'/>" type="image/x-icon" />
	<!-- jquery -->
  	<script src="<c:url value='/cdn/js/jquery-3.7.1.min.js'/>"></script>
  	<!-- common css -->
	<link rel="stylesheet" href="<c:url value='/cdn/css/common/common.css'/>">
	<!-- 사이드바 css -->
	<link rel="stylesheet" href="<c:url value='/cdn/css/common/sidebars.css'/>">
	<!-- 네이버 로그인api -->
	<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
	<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
	<!-- 카카오 로그인api -->
	<script type="text/javascript" src="https://developers.kakao.com/sdk/js/kakao.js"></script>
	<!-- peer js -->
	<script src="https://unpkg.com/peerjs@1.5.2/dist/peerjs.min.js"></script>
	<!-- metadata -->
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="새로마켓에서 모든 것이 새로워진다!">
	<meta name="author" content="Yongkwon Lee">
	<meta name="generator" content="Hugo 0.115.4">
	<title>새로마켓</title>
</head>