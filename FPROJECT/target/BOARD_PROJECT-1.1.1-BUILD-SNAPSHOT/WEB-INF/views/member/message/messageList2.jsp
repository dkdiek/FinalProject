<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="en">
<!-- head -->
<%@ include file="../../common/head.jsp"%>

<body class="bg-body-tertiary">
	<!-- header -->
	<%@ include file="../../common/header.jsp"%>


	<div class="tab-content mt-5">
		<div class="tab-pane fade show active" id="received">
			<div class="fs-3 mt-3 mb-3 text-center">
				<i class="bi bi-chat-left-text-fill me-2"></i> 보낸 메시지함
			</div>
			<div class="text-center mb-5">
				<button class="btn btn-outline-primary btn-sm" onclick="window.location.href='/messageList'">
					받은 메시지함 이동
				</button>
			</div>
			<div
				class="container border border-secondary border-opacity-50 rounded bg-white">
				<table class="table table-class border-secondary table-hover table-sm ">
					<thead>
						<tr class="text-center">
							<th scope="col" class="col-1"><i class="bi bi-person me-1"></i><br>[받는이]</th>
							<th scope="col" class="col-6"><i class="bi bi-chat-square-quote me-1"></i><br>[메시지]</th>
							<th scope="col" class="col-2"><i class="bi bi-clock me-1"></i><br>[전송일시]</th>
							<th scope="col" class="col-2"><i class="bi bi-check-square me-1"></i><br>[받는이 읽음]</th>
							<th scope="col" class="col-1"><i class="bi bi-trash me-1"></i><br>[삭제]</th>
						</tr>
					</thead>
					<tbody>
						<!-- Add logic to fetch and display received messages here -->
						<!-- Use ${result} to iterate through the received messages -->
						<c:if test="${not empty result}">
						
						<c:forEach var="message" items="${result}">
							<c:if
								test="${message.from_id.trim().toLowerCase() eq sessionScope.id.trim().toLowerCase()}">
								<tr class="text-center">
									<td>
										<a href="#" class="btn-chat" data-value="${message.to_id.trim().toLowerCase() eq sessionScope.id.trim().toLowerCase() ? '나' : message.to_id}">
										    ${message.to_id.trim().toLowerCase() eq sessionScope.id.trim().toLowerCase() ? '나' : message.to_id}
										</a>
									</td>
									<td class="text-center">
										<button type="button" class="btn btn-link message-content-btn"
											data-bs-toggle="modal" data-bs-target="#messageModal"
											style="overflow: hidden; text-overflow: ellipsis; white-space: nowrap; max-width: 150px"
											data-idx="${message.idx}" data-content="${message.content}">
											${message.content}</button>

									</td>
									<td><c:choose>
											<c:when test="${not empty message.create_date}">
												<c:set var="formattedDate" value="${message.create_date}" />
												<fmt:formatDate pattern="yy-MM-dd HH:mm"
													value="${formattedDate}" var="formattedDate" />
                        ${formattedDate}
                    </c:when>
											<c:otherwise>
												<!-- 날짜가 null 또는 빈 경우 처리 -->
                        N/A
                    </c:otherwise>
										</c:choose>
									<td class="message-read-status"><c:choose>
											<c:when test="${message.read_yn eq 'y'}">
									            <i class="bi bi-envelope-open-heart"></i>
									        </c:when>
									        <c:when test="${message.read_yn eq 'n'}">
									            <i class="bi bi-envelope-fill"></i>
									        </c:when>
											<c:otherwise>
												<!-- Handle other cases if necessary -->
									            ${message.read_yn}
									        </c:otherwise>
										</c:choose>
									</td>
									<td>
									        <button type="button" class="btn btn-outline-danger btn-sm" onclick="deleteMessage(${message.idx})">
									            삭제
									        </button>
									    </td>

								</tr>
							</c:if>
						</c:forEach>
						</c:if>
					</tbody>
				</table>
			</div>

			<!-- 페이징 처리 -->
			<div class="row mt-3">
				    <div class="col">
				        <nav aria-label="Page navigation">
				            <ul class="pagination justify-content-center">
				            <c:if test="${not empty result}">
				            
				                <c:forEach begin="0" end="${totalPages-1}" varStatus="i">
				                    <c:set var="pageLink" value="?page=${i.index+1}" />
				
				            
								        <!-- 검색 조건이 있는 경우 -->
				                    <c:if test="${not empty param.title}">
				                        <c:set var="pageLink" value="${pageLink}&title=${param.title}" />
				                    </c:if>
				                    <c:if test="${not empty param.seller_id}">
				                        <c:set var="pageLink" value="${pageLink}&seller_id=${param.seller_id}" />
				                    </c:if>
				                    <c:if test="${not empty param.category}">
				                        <c:set var="pageLink" value="${pageLink}&category=${param.category}" />
				                    </c:if>
				                    <!-- 조건 2, 3, 4, 5, 6 추가 -->
				                    <c:if test="${not empty param.distance_from}">
				                        <c:set var="pageLink" value="${pageLink}&distance_from=${param.distance_from}" />
				                    </c:if>
				                    <c:if test="${not empty param.distance_to}">
				                        <c:set var="pageLink" value="${pageLink}&distance_to=${param.distance_to}" />
				                    </c:if>
				                    <c:if test="${not empty param.soldout_yn}">
				                        <c:set var="pageLink" value="${pageLink}&soldout_yn=${param.soldout_yn}" />
				                    </c:if>
				                    <!-- 조건 6은 seller_id이므로 이미 추가되어 있습니다. -->
				
				                    <li class="page-item ${currentPage == i.index + 1 ? 'active' : ''}">
				                        <a class="page-link" href="${pageLink}">${i.index + 1}</a>
				                    </li>
				                </c:forEach>
				                </c:if>
				            </ul>
				        </nav>
				    </div>
				</div>
	
			
			
			
			
		</div>
	</div>

	<!-- 모달 -->
	<div class="modal fade" id="messageModal" tabindex="-1" role="dialog"
		aria-labelledby="messageModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="messageModalLabel">전체 내용</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div id="fullMessageContent"></div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>

	<!-- footer -->
	<%@ include file="../../common/footer.jsp"%>
	
	<script>
		function updateMessageRead(messageIdx) {
		    console.log('전송하는 메시지 인덱스:', messageIdx);
	
		    $.ajax({
		        type: 'GET',
		        url: '/updateMessageRead',
		        data: { idx: messageIdx },
		        success: function (response) {
		            console.log('서버 응답:', response);
	
		            if (response === 'success') {
		                // 서버에서 성공적으로 처리되었을 때의 동작
		                console.log('메시지 읽음 처리 성공');
	
		                // 읽음 여부를 표시하는 요소 업데이트
		                $(`#message-${messageIdx}`).text('y');
		            } else {
		                // 서버에서 에러가 발생했을 때의 동작
		                console.error('메시지 읽음 처리 실패');
		            }
		        },
		        error: function () {
		            // AJAX 요청 실패 시의 동작
		            console.error('AJAX 요청 실패');
		        }
		    });
		}
	
		$(document).ready(function () {
		    $('.message-content-btn').on('click', function () {
		        // 선택한 메시지의 idx 값을 가져옴
		        var messageIdx = $(this).data('idx');  // data-idx로 수정
		        var readStatus = $(this).data('read-status');
	
		        // read_yn 값이 'y'인 경우 처리를 중단
		        if (readStatus === 'y') {
		            console.log('이미 읽은 메시지입니다.');
		            return;
		        }
	
		        // 서버로 해당 메시지의 idx를 전송
		        updateMessageRead(messageIdx);
		    });
		});
		
		</script>
		<script>
	    // 메시지 클릭 이벤트
	    $('.message-content-btn').on('click', function () {
	        // 선택한 메시지의 idx 값을 가져옴
	        var messageIdx = $(this).data('idx');
	        var readStatus = $(this).data('read-status');
	
	        // read_yn 값이 'y'인 경우 처리를 중단
	        if (readStatus === 'y') {
	            console.log('이미 읽은 메시지입니다.');
	            return;
	        }
	
	        // 서버로 해당 메시지의 idx를 전송
	        updateMessageRead(messageIdx);
	
	        // 모달 창에 메시지 내용을 표시
	        var messageContent = $(this).data('content');
	        $('#fullMessageContent').text(messageContent);
	        
	
	        // 기존 클릭 이벤트 중지
	        return false;
	        
		    });
		
		    // 모달 닫기 이벤트
		    $('#messageModal').on('hidden.bs.modal', function () {
		        // 페이지 리로드
		        window.location.reload();
	    	});
	        
	</script>
	<script>
	    $(document).ready(function() {
	        $(".btn-chat").click(function() {
	            var to_id = $(this).data("value");
	            var from_id = '${sessionScope.id}';
	
	            if (from_id == null || from_id === '') {
	                alert('로그인이 필요합니다');
	            } else {
	                var url = '/sendMessage?to_id=' + to_id + '&from_id=' + from_id;
	                window.open(url, '_blank', 'width=500,height=500');
	            }
	        });
	    });
	</script>
	
	<!-- 메시지 삭제 -->
		<script>
		    function deleteMessage(messageIdx) {
		        // Display a confirmation dialog
		        var confirmDelete = confirm('정말 삭제하시겠습니까?');
		
		        if (confirmDelete) {
		            console.log('삭제하는 메시지 인덱스:', messageIdx);
		
		            // AJAX를 사용하여 서버로 삭제 요청 전송
		            $.ajax({
		                type: 'POST',
		                url: '/deleteShowFromId',
		                data: { idx: messageIdx },
		                success: function (response) {
		                    console.log('서버 응답:', response);
		
		                    if (response === 'success') {
		                        // 서버에서 성공적으로 처리되었을 때의 동작
		                        alert('메시지가 삭제되었습니다');
		
		                        // 페이지 리로드
		                        location.reload();
		                    } else {
		                        // 서버에서 에러가 발생했을 때의 동작
		                        console.error('메시지 삭제 실패하였습니다');
		                    }
		                },
		                error: function () {
		                    // AJAX 요청 실패 시의 동작
		                    console.error('AJAX 요청 실패');
		                }
		            });
		        }
		    };
		</script>

	
	
</body>
</html>