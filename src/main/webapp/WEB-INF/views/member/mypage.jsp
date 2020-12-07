<%@page import="com.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
</head>
<body>
<section>
	<div class="wrap">
		<!-- MemberController 주소 변경 -->
		<form action="loginCheck/memberUpdate" method="get" class="mypage_from">
			<h3>내정보</h3>
			<div class="input_box">
				<label for="userid">아이디</label>
				<input type="text" name="userid" id="userid" class="input_s" value="${login.userid}">
			</div>
			<div class="input_box">
				<label for="username">이름</label>
				<input type="text" name="username" id="username" class="input_s" value="${login.username}">
			</div>
			<div class="input_box">
				<label for="post">주소</label>
				<input type="text" name="post" id="postcode" class="input_s" placeholder="" value="${login.post}">
				<input type="text" name="addr1" id="address" class="input_l" placeholder="도로명주소" value="${login.addr1}">
				<input type="text" name="addr2" id="detailAddress" class="input_l" placeholder="지번주소" value="${login.addr2}">
			</div>
			<div class="input_box">
				<label for="phone">전화번호</label>
				<select name="phone1" id="phone" class="input_s">
					<option value="017" <c:if test="${login.phone1=='010'}">selected</c:if> >010</option>
					<option value="017" <c:if test="${login.phone1=='011'}">selected</c:if> >011</option>
					<option value="017" <c:if test="${login.phone1=='016'}">selected</c:if> >016</option>
				</select> - <input type="text" name="phone2" id="phone" class="input_s" value="${login.phone2}"> - <input type="text" name="phone3" id="phone" class="input_s" value="${login.phone3}">
			</div>
			<div class="input_box">
				<label for="email">이메일</label>
				<input type="text" name="email1" id="email" class="email1" value="${login.email1}"> @ <input type="text" name="email2" id="email" class="email2" value="${login.email2}">
			</div>
			<div class="update_btn_box">
				<input type="submit" name="submit" id="update_btn" value="수정">
				<input type="reset" name="del" id="del" value="취소">
			</div>
			
		</form>
	</div>
</section>
<script type="text/javascript">
	const submit = document.getElementById("update_btn");
	submit.addEventListener("click", function(e){
		console.log(1);
		const email1 = document.querySelector(".email1").value;
		const email2 = document.querySelector(".email2").value;
		console.log(email1);
		if(email1.length == 0 || email2.length == 0){
			e.preventDefault();
			alert("수정 완료되었습니다");
		}
	});
</script>

</body>
</html>