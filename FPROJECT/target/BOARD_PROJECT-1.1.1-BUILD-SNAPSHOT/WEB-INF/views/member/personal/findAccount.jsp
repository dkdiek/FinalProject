<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!doctype html>
<html lang="en">
    <!-- head -->
    <%@ include file="../../common/head.jsp" %>
    <!-- body -->
    <body class="bg-body-tertiary">
        <!-- header -->
        <%@ include file="../../common/header.jsp" %>
        
        <!-- main -->
	<div class="container mt-5">
		<div class="row mx-auto text-center">

			<div class="col-5 bg-white border border-round mx-auto">
				<div class="fs-3 mt-5">
					<i class="bi bi-question-square me-2 py-5"></i> ID를 찾고 싶어요
				</div>
				<div class="mt-3">
					<input class="mt-2" type="text" id="id-name" name="member_name"
						placeholder="가입자 성명을 입력해 주세요"><br> <input
						class="mt-2" type="text" id="id-email" name="member_email"
						placeholder="가입자 이메일을 입력해 주세요">
				</div>
				<div class="mt-4">
					<button class="btn btn-primary mb-5" id="searchId">ID 찾기</button>
				</div>
			</div>
	

			<div class="col-5 bg-white border border-round  mx-auto">
				<div class="fs-3 mt-5">
					<i class="bi bi-question-square me-2 py-5"></i> 비밀번호를 찾고 싶어요
				</div>
				<div class="mt-3">
					<input class="mt-2" type="text" id="pw-id" name="member_id"
						placeholder="가입자 ID를 입력해 주세요"><br> <input
						class="mt-2" type="text" id="pw-email" name="member_email"
						placeholder="가입자 이메일을 입력해 주세요">
				</div>
				<div class="mt-4">
					<button class="btn btn-primary mb-5" id="searchPw">비밀번호 찾기</button>
				</div>
			</div>

		</div>
	</div>
	

	<!-- footer -->
    	<%@ include file="../../common/footer.jsp" %>
    	
    	<script>
    $(document).ready(function () {
        // ID 찾기 버튼 클릭 시
        $("#searchId").click(function () {
            var name = $("#id-name").val();
            var email = $("#id-email").val();

            // AJAX 호출
            $.ajax({
                type: "POST",
                url: "/findAccountProcess",
                contentType: 'application/json',
                data: JSON.stringify({
                    member_name: name,
                    member_email: email,
                    type: "id"
                }),
                dataType: 'json',
                success: function (response) {
                    if (response.result === "success") {
                        alert("ID 찾기 성공! 이메일을 확인하세요.");
                    } else {
                        alert("ID 찾기 실패: " + response.message);
                    }
                },
                error: function (error) {
                    alert("에러 발생: " + error.statusText);
                }
            });
        });

        // 비밀번호 찾기 버튼 클릭 시
        $("#searchPw").click(function () {
            var id = $("#pw-id").val();
            var email = $("#pw-email").val();

            // AJAX 호출
            $.ajax({
                type: "POST",
                url: "/findAccountProcess",
                contentType: 'application/json',
                data: JSON.stringify({
                    member_id: id,
                    member_email: email,
                    type: "pw"
                }),
                dataType: 'json',
                success: function (response) {
                    if (response.result === "success") {
                        alert("비밀번호 찾기 성공! 이메일을 확인하세요.");
                    } else {
                        alert("비밀번호 찾기 실패: " + response.message);
                    }
                },
                error: function (error) {
                    alert("에러 발생: " + error.statusText);
                }
            });
        });
    });
</script>

    	
    </body>
</html>