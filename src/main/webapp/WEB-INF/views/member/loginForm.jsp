<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<script src="${path}/resources/js/jquery-3.3.1.js"></script>
<script>
<!-- id, 패스워드 입력 검사 후 진행하도록  작성  -->
$(document).ready(function(){

	$("form").on("submit", function(event) {
		var userid = $("#userid").val();
		var passwd = $("#passwd").val();
		
		if(userid.length == 0){
			alert("아이디를 입력하세요");
			console.log(1);
			$("#userid").focus();
			console.log(2);
			event.preventDefault();
		}else if(passwd.length == 0){
			alert("패스워드 입력하세요");
			$("#passwd").focus();
			event.preventDefault();
		};
	});
	
});
	
</script>


<section class="login_form">
	<div class="wrap">
	
		<form action="login" method="get" class="login">
			<div class="loginfrom_box">
				<label for="userid">아이디</label> 
				<input type="text" name="userid" id="userid" placeholder="아이디를 입력하세요">
			</div>
			<div class="loginfrom_box">
				<label for="passwd">비밀번호</label> 
				<input type="password" name="passwd" id="passwd" placeholder="비밀번호를 입력하세요">
			</div>
			<div class="loginfrom_box">
				<input type="submit" value="로그인">
				<input type="reset"value="취소">
			</div>
			<a href="MemberIdSearchUIServlet">아이디찾기</a>
		</form>
		
	</div>
</section>
