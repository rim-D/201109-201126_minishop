<%@page import="com.dto.GoodsDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<script src="${path}/resources/js/jquery-3.3.1.js"></script>

<section class="goods">
	<div class="wrap">
	
		<ul class="goods_list">
		<!-- request에서 데이터 얻은 후  모든 멤버변수를 변수에 저장  후 표에 출력해줌-->
		<!-- "goodList"키의 ArrayList get해서 for문 동작시 방하나의 goodsDTO를 "dto"로 저장, status:인덱스번호 -->
		<c:forEach var="dto" items="${goodsList}" varStatus="status">
			<li>
				<a href="goodsRetrieve?gCode=${dto.gCode}"> 
					<span class="goods_img"><img src="${path}/resources/images/items/${dto.gImage}.gif"></span>
					<span class="goods_detail_box">
						<span class="goods_name">${dto.gName}<em>${dto.gContent}</em></span>
						<span class="goods_price">${dto.gPrice}</span>
					</span>
				</a>
			</li>
		</c:forEach>
		</ul>
	
	</div>
</section>
<script type="text/javascript">
	document.querySelectorAll(".goods_price").forEach(function(span){
		span.innerText = com.comma(span.innerText);
	});
</script>




