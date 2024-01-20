<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!doctype html>
<html lang="en" data-bs-theme="auto">
    <!-- head -->
    <%@ include file="../../common/head.jsp" %>
    <!-- body -->
    <body class="bg-body-tertiary">
        <div class="container mt-5 col-5 mx-auto">
            <p style="max-width:200px" class="text-center mx-auto">
                <img class="img-fluid" src="<c:url value='/cdn/images/common/LogoKor.png'/>">
            </p>           

            <div id="withdrawal" class="row mt-5 text-center">
                <div id="withdrawal1">
                    <h4 class="d-flex align-items-center justify-content-center">회원 탈퇴 약관</h4>
                    <div id="withdrawal1-content">
                        <textarea id="withdrawal1-txt" class="form-control w-100" rows="20"></textarea>
                    </div>
                </div>
            </div>

            <div id="agreementRecheck" class="mt-5 d-flex align-items-center justify-content-center">
                <form>
                    <div class="form-check">
                        <input type="checkbox" class="form-check-input border border-primary" id="checkbox" name="checkbox">
                        <label for="checkbox" class="form-check-label">위의 회원 탈퇴 약관에 대한 안내에 동의합니다 (필수 체크)</label>
                    </div>
                </form>
            </div>

            <div class="py-5 d-flex align-items-center justify-content-center">
                <form id="frm1" action="<c:url value='/withdrawalProccess'/>" method="POST">
                    <button id="btnConfirm" type="button" class="btn btn-primary" onclick="confirmWithdrawal()">회원 탈퇴</button>
                    <a id="btnCancel" href="/" class="btn btn-secondary">취소</a>
                </form>
            </div>
        </div>

        <!-- footer -->
        <%@ include file="../../common/footer.jsp" %>

        <!-- 이용 약관 txt 페이지 가져오기 -->
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                // 파일 경로
                const filePath1 = "<c:url value='/cdn/document/withdrawal.txt'/>";

                // XMLHttpRequest를 사용하여 파일 읽기
                function readAndSetContent(filePath, targetElementId) {
                    const xhr = new XMLHttpRequest();
                    xhr.open('GET', filePath, true);
                    xhr.overrideMimeType('text/plain; charset=UTF-8'); // 인코딩을 명시적으로 지정
                    xhr.onreadystatechange = function () {
                        if (xhr.readyState === 4 && xhr.status === 200) {
                            const content = xhr.responseText;
                            document.getElementById(targetElementId).value = content;
                        }
                    };
                    xhr.send();
                }

                // 각 파일의 경로와 대상 텍스트 영역 ID 지정하여 호출
                readAndSetContent(filePath1, 'withdrawal1-txt');
            });
        </script>

        <script>
            function confirmWithdrawal() {
                var checkbox = document.getElementById('checkbox');

                // 체크박스가 체크되어 있지 않은 경우
                if (!checkbox.checked) {
                    alert('회원 탈퇴 약관에 동의해 주세요.');
                } else {
                    // 사용자가 확인 창에서 Yes를 선택한 경우
                    if (confirm('정말 탈퇴하시겠습니까?')) {
                        // 폼 전송
                        document.getElementById('frm1').submit();
                    }
                }
            }
        </script>
    </body>
</html>
