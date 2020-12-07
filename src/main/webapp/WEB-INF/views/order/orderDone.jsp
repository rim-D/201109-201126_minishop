<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<script src="${path}/resources/js/jquery-3.3.1.js"></script>
<section class="order_done">
	<div class="wrap">
		<p class="order_done_box">
			<span class="delivery_icon"><i class="xi-gift-o xi-3x"></i></span>
			<b>주문해주셔서 감사합니다.</b>
			<span><strong>${oDTO.userid}</strong> 님의 <strong>${cnt}</strong>건이 주문이안전하게 처리되었습니다.</span>
		</p>
		<a class="cartlist_back" href="loginCheck/cartList">주문조회 페이지로 이동</a>
	</div>
</section>
