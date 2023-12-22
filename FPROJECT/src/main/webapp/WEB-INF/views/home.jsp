<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
	<head>
		<title>새로마켓</title>
		<link rel="shortcut icon" href="/cdn/images/favicon.ico" type="image/x-icon" />
    	<link rel="icon" href="/cdn/images/favicon.ico" type="image/x-icon" />
	</head>
	<body>
	
		<div id="top" style="text-align:center; background-color:green">
			<span id="top-logo-span" style="text-align:center;">
				<img id="top-logo" style="width:50px" src="<c:url value='/cdn/images/common/logo.png'/>">
			</span>
			<span id="top-search-span">
				<input id="top-search-input" type="text" >
				<input id="btnMainSearch"type="button" value="검색">
			</span>
			<span id="top-menu">
				로그인
				로그아웃
				<a href="/member/join/joinMember">
					<span>회원가입</span>
				</a>
			</span>
		</div>
		
		<div id="menu" style="text-align:center; background-color:red">
			카테고리
			우리동네
			판매하기
		<div>
		
		<div id="content" style="text-align:center; background-color:green">
		
			<span id="product-package">
			
				<span id="product-img">
					<img style="width:300px" id="top-logo" src="<c:url value='/cdn/images/sample/dummy.jpg'/>">
				</span>
				<span id="product-name">
					물품명 더미
				</span>
				<span id="product-price">
					1000원
				</span>
				<span id="product-location">
					서울 강서구 1동
				</span>
				<span id="product-upload">
					10분전
				</span>
				
			</span>
			
			<span id="product-package">
			
				<span id="product-img">
					<img style="width:300px" id="top-logo" src="<c:url value='/cdn/images/sample/dummy.jpg'/>">
				</span>
				<span id="product-name">
					물품명 더미
				</span>
				<span id="product-price">
					1000원
				</span>
				<span id="product-location">
					서울 강서구 1동
				</span>
				<span id="product-upload">
					10분전
				</span>
				
			</span>
			
			<span id="product-package">
			
				<span id="product-img">
					<img style="width:300px" id="top-logo" src="<c:url value='/cdn/images/sample/dummy.jpg'/>">
				</span>
				<span id="product-name">
					물품명 더미
				</span>
				<span id="product-price">
					1000원
				</span>
				<span id="product-location">
					서울 강서구 1동
				</span>
				<span id="product-upload">
					10분전
				</span>
				
			</span>
			
		</div>	
		
	</body>
</html>
