<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<script src="${path}/resources/js/jquery-3.3.1.js"></script>
<script>
	$(document).ready(function(){
		
	 	//form 서브밋
		$("form").on("submit",function(event){		
			var userid = $("#userid").val();
			var passwd = $("#passwd").val();
			if(userid.length==0){
				alert("userid 필수")
				$("#userid").focus();
				event.preventDefault();
			}else if(passwd.length==0){
				alert("passwd 필수")
				$("#passwd").focus();
				event.preventDefault();
			}
		});
	 	
		//비번확인
		$("#passwd2").on("keyup",function(){
			var passwd = $("#passwd").val();
			var mesg = "비번 불일치";
			if(passwd == $(this).val()){
				mesg = "비번 일치";
			}
			$(".pw_result").text(mesg);
		});
			
		//이메일 선택
		$(".email_select").on("change",function(){
			var email = $(this).val();
			$("#email2").val(email);
		});
	
		$("#userid").on("keyup",function(event){	
			$.ajax({
				type : "GET",
				url : "idDuplicateCheck", // 서버주소
				dataType : "text",
				data : {
					userid : $("#userid").val()	 // 전송데이터 id
				},
				success : function(responseData, status, xhr) {
					$(".userid_result").text(responseData); // 중복여부 화면에 출력
				},
				error : function(xhr, status, error) { // 처리 실패
					console.log("error");
				}
			});
		});
 
});
</script>

<section class="member">
	<div class="wrap">
	
		<div class="memberform_box">
		
			<form action="memberAdd" method="get" class="memberform">		
				<div class="member_box">
					<label for="userid" class="text-point">* 아이디 [필수] :</label>
					<input type="text" name="userid" id="userid" class="input_box_100">
					<span class="result userid_result"></span>
				</div>
				
				<div class="member_box">
					<label for="passwd" class="text-point">* 비밀번호 [필수] :</label>
					<input type="password" id="passwd" class="input_box_100">
				</div>
				
				<div class="member_box">
					<label for="passwd">비밀번호 확인 :</label>
					<input type="password" name="passwd" id="passwd2" class="input_box_100">
					<span class="result pw_result"></span>
				</div>
				
				<div class="member_box">
					<label for="username">이름 :</label>
					<input type="text" name="username" id="username" class="input_box_100">
				</div>
				
				<div class="member_box">
					<label for="post">주소 :</label>
					<div class="post_box">
						<input type="text" name="post" id="postcode" placeholder="우편번호">
						<button type="button" onclick="execDaumPostcode()" class="member_btn find_post">우편번호 찾기</button>
					</div>
					
					<input type="text" name="addr1" id="address" class="input_box_49" placeholder="주소">
					<input type="text" name="addr2" id="detailAddress" class="input_box_49" placeholder="상세주소">
				</div>
				
				<div class="member_box">
					<label for="phone">전화번호 :</label>
					<select name="phone1" id="phone1" class="input_box">
						<option value="010">010</option>
						<option value="011">011</option>
						<option value="018">018</option>
						<option value="019">019</option>
						<option value="017">017</option>
					</select>
					<span class="hyphen">-</span>
					<input type="number" name="phone2" id="phone2" maxlength="4" class="input_box">
					<span class="hyphen">-</span>
					<input type="number" name="phone3" id="phone3" maxlength="4" class="input_box">
				</div>
				
				<div class="member_box">
					<label for="email">이메일 :</label>
					<input type="text" name="email1" id="email1" class="input_box"><span class="hyphen">@</span>
					<input type="text" name="email2" id="email2" placeholder="직접입력" class="input_box">
					<select class="email_select">
						<option value="daum.net">daum.net</option>
						<option value="naver.com">naver.com</option>
					</select>
				</div>
				
				<div class="member_box btn_box">
					<button type="submit" class="member_btn">회원가입</button>
					<button type="reset" class="member_btn">취소</button>
				</div>
			</form>
		
		</div>	
		
	</div>
</section>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
				console.log(data);
                // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 도로명 주소 변수
                var extraAddr = ''; // 도로명 조합형 주소 변수

              	//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

             	// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
    			if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                document.getElementById("detailAddress").value = extraAddr;
            
	             } else {
	                 document.getElementById("detailAddress").value = '';
	             } 

	             
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById('address').value = addr;

             	// 커서를 상세주소 필드로 이동한다.
                document.getElementById("detailAddress").focus();
            }
        }).open();
    }
</script>

