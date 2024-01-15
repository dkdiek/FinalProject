<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!doctype html>
<html lang="en">
	<!-- head -->
	<%@ include file="../../common/head.jsp"%>
	<body class="bg-body-tertiary">
		<div class="container mt-4">
			<div class="row">
				<div class="col-md-6 offset-md-3">
					<div class="fs-4 text-center">
						<i class="bi bi-chat-left-text-fill me-2 fs-6"></i>메시지 보내기
					</div>
					<hr>
	
					<!-- 판매자 정보 표시 -->
					<div class="mb-3">
						<p>수신자: ${info.to_id} 님</p>
						<p>작성자: ${info.from_id} 님</p>
					</div>
	
					<!-- 쪽지 내용 입력 폼 -->
						<div class="mb-5">
							<label for="content" class="form-label">내용:</label>
							<textarea class="form-control" id="content" name="content"
								rows="7" required></textarea>
						</div>
						<input type="hidden" id="to_id" name="to_id" value="${info.to_id} ">
						<input type="hidden" id="from_id" name="from_id" value="${info.from_id} ">
	
						<!-- 전송 및 취소 버튼 -->
						<div class="mb-2 text-center">
							<button type="button" class="btn btn-primary" id="btnSubmit">전송</button>
							<button type="button" class="btn btn-secondary" onclick="cancel()">취소</button>
						</div>
					<form method="POST" action="<c:url value='/sendMessageProcess'/>" id="frmInfo">
					</form>
				</div>
			</div>
		</div>
	
		<script>
		    $(document).ready(function() {
		        $("#btnSubmit").click(function() {
		            var to_id = $('#to_id').val();
		            var from_id = $('#from_id').val();
		            var content = $('#content').val();
		
		            $.ajax({
		                type: "POST",
		                url: "/sendMessageProcess",
		                data: JSON.stringify({
		                    to_id: to_id,
		                    from_id: from_id,
		                    content: content
		                }),
		                contentType: "application/json; charset=utf-8",
		                dataType: "json"
		            }).done(function(response) {
		                if (response.message === "success") {
		                    alert("메시지 전송 완료");
		    				window.open('', '_self').close();

		                } else {
		                    alert("메시지 전송 실패");
		    				window.open('', '_self').close();

		                }
		            });
		        });
		    });
		    
		    function cancel() {
				window.open('', '_self').close();
			}
		</script>

	
	
	</body>
</html> --%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!doctype html>
<html lang="en">
    <!-- head -->
    <%@ include file="../../common/head.jsp"%>
    <body class="bg-body-tertiary">
        <div class="container mt-4">
            <div class="row">
                <div class="col-md-6 offset-md-3">
                    <div class="fs-4 text-center">
                        <i class="bi bi-chat-left-text-fill me-2 fs-6"></i>메시지 보내기
                    </div>
                    <hr>

                    <!-- 판매자 정보 표시 -->
                    <div class="mb-3">
                        <p>수신자: ${info.to_id} 님</p>
                        <p>작성자: ${info.from_id} 님</p>
                    </div>

                    <!-- 쪽지 내용 입력 폼 -->
                    <div class="mb-5">
                        <label for="content" class="form-label">내용:</label>
                        <textarea class="form-control" id="content" name="content" rows="7" required></textarea>
                    </div>
                    <input type="hidden" id="to_id" name="to_id" value="${info.to_id}">
                    <input type="hidden" id="from_id" name="from_id" value="${info.from_id}">

                    <!-- 전송 및 취소 버튼 -->
                    <div class="mb-2 text-center">
                        <button type="button" class="btn btn-primary" id="btnSubmit">전송</button>
                        <button type="button" class="btn btn-secondary" id="btnCancel"">취소</button>
                    </div>
                    <form method="POST" action="<c:url value='/sendMessageProcess'/>" id="frmInfo"></form>
                </div>
            </div>
        </div>

        <script>
            $(document).ready(function() {
                $("#btnSubmit").click(function() {
                    var to_id = $('#to_id').val();
                    var from_id = $('#from_id').val();
                    var content = $('#content').val();

                    $.ajax({
                        type: "POST",
                        url: "/sendMessageProcess",
                        data: JSON.stringify({
                            to_id: to_id,
                            from_id: from_id,
                            content: content
                        }),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json"
                    }).done(function(response) {
                        if (response.message === "success") {
                            alert("메시지 전송 완료");
                            // Reload the parent page after closing the modal
                            window.opener.location.reload();
                            window.close();
                        } else {
                            alert("메시지 전송 실패");
                            window.close();
                        }
                    });
                });
            });
            
            $(document).ready(function() {
                $("#btnCancel").click(function() {
                	   window.opener.location.reload();
                       window.close();
                })
             })
        </script>
    </body>
</html>
