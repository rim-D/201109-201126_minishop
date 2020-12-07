<%@page import="com.dto.CartDTO"%>
<%@page import="com.dto.MemberDTO"%>
<%@page import="com.dto.GoodsDTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<c:if test="${!empty msg}">
	<script>
		alert("${msg}상품을 장바구니 담았습니다");
	</script>
</c:if>
<% if(session.getAttribute("msg") != null){
		session.removeAttribute("msg");
} %>
<script type="text/javascript" src="${path}/resources/js/jquery-3.3.1.js"></script>
<section class="product">
    <div class="wrap clearfix">
        <form name="goodRetrieveForm" method="GET" class="good_retrieve">
		<!-- hidden  tag생성 -->
		<!-- 화면에는 보이지 않고 정보만 넘겨주는 역할 hideen -->
	
		<input type="hidden" name="gImage" value="${goodsRetrieve.gImage}">
		<input type="hidden" name="gCode" value="${goodsRetrieve.gCode}">
		<input type="hidden" name="gName" value="${goodsRetrieve.gName}">
		<input type="hidden" name="gPrice" value="${goodsRetrieve.gPrice}">

        <div class="product_cover float-left">
            <img src="${path}/resources/images/items/${goodsRetrieve.gImage}.gif"/>
        </div>

        <div class="product_description float-right">
                <div class="product_title">
                    <div class="icons">
                        <img src="${path}/resources/images/icon_201809202124583100.gif" alt="BEST">
                        <img src="${path}/resources/images/icon_201809202125035400.gif" alt="NEW">
                    </div>
                    <h2 class="title">${goodsRetrieve.gName}</h2>
                    <p>(해외배송 가능상품)</p>
                </div>
                
                <div class="product_info">
                	<dl>
	                    <dt class="float-left">상품</dt>
	                    <dd><strong>( ${goodsRetrieve.gCode} ) ${goodsRetrieve.gName}</strong></dd>
                    </dl>
                    <dl>
	                    <dt class="float-left">소비자가</dt>
	                    <dd><strong class="gPrice">${goodsRetrieve.gPrice}</strong></dd>
                    </dl>
                    <dl>
	                    <dt class="float-left">판매가</dt>
	                    <dd><strong class="red gPrice_sale">${goodsRetrieve.gPrice}</strong></dd>
                    </dl>
                    <dl>
                        <dt class="float-left"><label for="delivery_price">배송비</label></dt>
                        <dd>
                            <select name="delivery_price" id="delivery_price">
                                <option value="선결제" selected>주문시 결제(선결제)</option>
                                <option value="후결제">수령시 결제(착불)</option>
                            </select>
                         
                        </dd>
                    </dl>
                    <dl>
                        <dt class="float-left"><label for="gSize">사이즈</label></dt>
                        <dd>
                            <select class="select_change" size="1" name="gSize" id="gSize">
								<option value="사이즈선택" selected>사이즈선택</option>
								<option value="L">L</option>
								<option value="M">M</option>
								<option value="S">S</option>
							</select>
                        </dd>
                    </dl>
                    <dl>
                        <dt class="float-left"><label for="gColor">color</label></dt>
                        <dd>
                            <select class="select_change" size="1" name="gColor" id="gColor">
								<option selected value="색상선택">색상선택</option>
								<option value="navy">navy</option>
								<option value="black">black</option>
								<option value="ivory">ivory</option>
								<option value="white">white</option>
								<option value="gray">gray</option>
							</select>
                        </dd>
                    </dl>
                    <dl>
                        <dt class="float-left">재고수량</dt>
                        <dd class="order-btn">
                            <input type="text" name="gAmount" id="gAmount" class="number" value="1">
                            <button type="button" class="increase">+</button>
                            <button type="button" class="decrease">-</button>
                        </dd>
                    </dl>
                </div>
                <div class="btn-area">
                    <button type="submit" class="btn buy-btn" onclick="reqCheck('order')">BUY IT NOW</button>
                    <button type="submit" class="btn cart-btn">ADD TO CART</button>
                </div>
            </div>
        </form>
    </div>
</section>
<script>
// 가격콤마
const price1 = document.querySelector('.gPrice');
const price2 = document.querySelector('.gPrice_sale');

let priceComma = function(priceList){
	priceList.innerText = com.comma(priceList.innerText);
};

priceComma(price1);
priceComma(price2);

// 숫자 추가 삭제 버튼
const number = document.querySelector('.number');
const increase = document.querySelector('.increase');
const decrease = document.querySelector('.decrease');


increase.onclick = () => {
    const current = parseInt(number.value);
    number.value = current + 1;
};

decrease.onclick = () => {
    const current = parseInt(number.value);
    if (current > 1) {
        number.value = current - 1;
    } else {
        alert('최소주문량은 1개입니다.');
    }
    
};


// 카트 버튼 클릭 시, 정보 유효성검사
const cart = document.querySelector('.cart-btn');
const gSize = document.getElementById('gSize');
const gColor = document.getElementById('gColor');
const form = document.querySelector('.good_retrieve');


cart.onclick = () => {

	if(gSize.options[gSize.selectedIndex].value == "사이즈선택"){
		alert("사이즈를 선택하세요");
		return false;
	}
	if(gColor.options[gColor.selectedIndex].value == "색상선택"){
		alert("색상을 선택하세요");
		return false;
	}

	form.setAttribute("action", "loginCheck/cartAdd");// 인터셉터를 통해 로그인 인증 되어있을 경우만 장바구니에 담김
	
};

</script>

    