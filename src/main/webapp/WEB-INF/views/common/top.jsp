<%@page import="com.dto.MemberDTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><!-- JSTL 조건문 사용할때 쓰는 core -->
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<c:set var="path" value="${pageContext.request.contextPath}"/> 
<script src="${path}/resources/js/com.js"></script>
<section class="header">
    <div class="wrap">
    
    <!-- 세션에서 로그인 정보 검사 로그인 안된 경우 -->
    <c:if test="${empty login}">
      <ul class="login_nav">
        <li><a href="loginForm">로그인</a></li><!-- loginFrom.jsp -->
        <li><a href="loginCheck/cartList">장바구니</a></li>
        <li><a href="memberForm">회원가입</a></li><!-- memberFrom.jsp / xml등록한 주소를 찾아감 -->
        </ul>
	</c:if>
	<!-- 세션에서 로그인 정보 검사 로그인 된 경우 -->
	<c:if test="${!empty login}">
		<ul class="login_nav">
			<li><a href="/shopminiMall">안녕하세요.<strong>" ${login.username} "</strong>님!</a></li>
			<li><a href="loginCheck/logout">로그아웃</a></li>
			<li><a href="loginCheck/mypage">마이페이지</a></li>
			<li><a href="loginCheck/cartList">장바구니</a></li>
		</ul>
	</c:if>
		
        <!--  메뉴부분 -->
        <ul class="gcategory">
        <!-- 매핑주소에 주소로 parmeter 전달 -->
          <li><a href="goodsList?gCategory=top">TOP</a></li>
          <li><a href="goodsList?gCategory=dress">DRESS</a></li>
          <li><a href="goodsList?gCategory=outer">OUTER</a></li>
          <li><a href="goodsList?gCategory=bottom">BOTTON</a></li>
        </ul>
    </div>
    
</section>









		

