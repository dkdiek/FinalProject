<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!doctype html>
<html lang="en">
    <!-- head -->
    <%@ include file="../common/head.jsp" %>
    <!-- body -->
    <body>
        <!-- header -->
        <%@ include file="../common/header.jsp" %>
        <!-- main -->
        <div class="container mt-4">
            <div class="row">
                <table class="table">
                    <thead>
                        <tr>
                            <th scope="col">이미지</th>
                            <th scope="col">제목</th>
                            <th scope="col">주소</th>
                            <th scope="col">가격</th>
                            <th scope="col">작성일</th>
                            <th scope="col">조회수</th>
                            <th scope="col">좋아요</th>
                            <!-- 추가적인 필요한 정보 표시 -->
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="board" items="${boardList}">
                            <tr>
                                <td><img src="<c:url value='/cdn/upload/${board.img1}' />" alt="Image" style="max-width: 100px;"></td>
                                <td><a href="<c:url value='/detail?seq=${board.seq}' />">${board.title}</a></td>
                                <td>${board.address}</td>
                                <td>${board.price}</td>
                                <td>${board.create_date}</td>
                                <td>${board.view_cnt}</td>
                                <td>${board.like_cnt}</td>
                                <!-- 추가적인 필요한 정보 표시 -->
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
    
            <!-- 페이징 처리 -->
            <div class="row">
                <div class="col">
                    <nav aria-label="Page navigation">
                        <ul class="pagination justify-content-center">
                            <c:forEach begin="1" end="${totalPages}" varStatus="i">
                                <li class="page-item ${currentPage == i.index + 1 ? 'active' : ''}">
                                    <a class="page-link" href="?page=${i.index + 1}">${i.index + 1}</a>
                                </li>
                            </c:forEach>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
        
        <!-- footer -->
        <%@ include file="../common/footer.jsp" %>
    </body>
</html>
