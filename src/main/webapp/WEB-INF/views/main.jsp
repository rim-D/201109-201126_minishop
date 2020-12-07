<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/> 
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>MiniShop 메인페이지입니다</title>
	<link rel="stylesheet" href="${path}/resources/css/reset.css">
	<link rel="stylesheet" href="${path}/resources/css/common.css">
	<link rel="stylesheet" href="${path}/resources/css/main.css">
	<script src="${path}/resources/js/com.js"></script>
<!-- 
	memberAdd에서 success문구 가져옴
	model.addAttribute("success", "회원가입 성공");
 -->
<c:if test="${!empty success}">
	<script>
		alert("${success}");  /* 회원가입성공의 문구 출력 */
	</script>
</c:if>

</head>
<body>
	<jsp:include page="common/top.jsp" flush="true"/>
	<jsp:include page="goods/goodsList.jsp" flush="true"/>
</body>
</html>