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
		<div class="container mt-5">
		 	<p style="max-width:200px" class="text-center mx-auto">
		        <img class="img-fluid" src="<c:url value='/cdn/images/common/LogoKor.png'/>">
	        </p>			
	
			<div id="agreement" class="row mt-5">
				<div id="agreement1" class="col-md-6">
					<h4 class="d-flex align-items-center justify-content-center">이용약관</h4>
					<div id="agreement1-content">
						<textarea id="agreement1-txt" class="form-control w-100" rows="20"></textarea>
					</div>
					<form>
						<div class="form-check mt-2 ">
							<input id="agreeCheckbox1" type="checkbox"
								class="form-check-input border border-primary" name="checkbox">
							<label for="agreeCheckbox1" class="form-check-label">위
								이용약관에 동의합니다 (필수 체크)</label>
						</div>
					</form>
				</div>
	
				<div id="agreement2" class="col-md-6">
					<h4 class="d-flex align-items-center justify-content-center">개인정보
						수집 및 이용에 대한 안내</h4>
					<div id="agreement2-content">
						<textarea id="agreement2-txt" class="form-control w-100" rows="20"></textarea>
					</div>
					<form>
						<div class="form-check mt-2">
							<input id="agreeCheckbox2" type="checkbox"
								class="form-check-input border border-primary" name="checkbox">
							<label for="agreeCheckbox2" class="form-check-label ">위의
								개인정보 수집 및 이용에 대한 안내에 동의합니다 (필수 체크)</label>
						</div>
					</form>
				</div>
			</div>
	
			<div id="agreementRecheck"
				class="mt-5 d-flex align-items-center justify-content-center">
				<form>
					<div class="form-check">
						<input type="checkbox"
							class="form-check-input border border-primary" name="checkbox">
						<label for="checkbox" class="form-check-label">위의 이용약관 및
							개인정보 수집 및 이용에 대한 안내에 동의합니다 (필수 체크)</label>
					</div>
				</form>
			</div>
	
			<div class="py-5 d-flex align-items-center justify-content-center">
				<form id="frm1" action="<c:url value='/joinMembership2'/>" method="GET">
					<button id="btnConfirm" type="button" class="btn btn-primary">확인</button>
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
	            const filePath1 = "<c:url value='/cdn/document/agreement1.txt'/>";
	            const filePath2 = "<c:url value='/cdn/document/agreement2.txt'/>";
	
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
	            readAndSetContent(filePath1, 'agreement1-txt');
	            readAndSetContent(filePath2, 'agreement2-txt');
	        });
	    </script>
	
		<!-- 이용 약관 스크롤 체크 -->
		<script>
	        function checkAgreement(agreementTxt, agreeCheckbox) {
	            agreeCheckbox.addEventListener('click', function (event) {
	                if (agreementTxt.scrollTop !== (agreementTxt.scrollHeight - agreementTxt.clientHeight)) {
	                    event.preventDefault();
	                    alert('약관 및 안내를 다 읽고 동의해 주세요.');
	                }
	            });
	        }
	
	        var agreementTxt1 = document.getElementById('agreement1-txt');
	        var agreeCheckbox1 = document.getElementById('agreeCheckbox1');
	        checkAgreement(agreementTxt1, agreeCheckbox1);
	
	        var agreementTxt2 = document.getElementById('agreement2-txt');
	        var agreeCheckbox2 = document.getElementById('agreeCheckbox2');
	        checkAgreement(agreementTxt2, agreeCheckbox2);
	    </script>
	
		<!-- 이용 약관 모두 체크 확인 -->
		<script>
	        document.getElementById('btnConfirm').addEventListener('click', function () {
	            // 각 체크박스의 상태를 확인
	            var checkboxes = document.getElementsByName('checkbox');
	
	            // 모든 체크박스가 선택되었는지 확인
	            var allChecked = true;
	            for (var i = 0; i < checkboxes.length; i++) {
	                if (!checkboxes[i].checked) {
	                    allChecked = false;
	                    break;
	                }
	            }
	
	            if (allChecked) {
	                // 모든 체크박스가 선택되었을 경우 페이지 이동
	                document.getElementById('frm1').submit();
	            } else {
	                // 선택되지 않은 항목이 있다면 알림창 표시
	                alert('모든 항목에 동의해 주세요.');
	            }
	        });
	
	        document.getElementById('btnCancel').addEventListener('click', function () {
	            // 취소 버튼 클릭 시 홈페이지로 이동
	            window.location.href = '/';
	        });
	    </script>
	</body>
</html>