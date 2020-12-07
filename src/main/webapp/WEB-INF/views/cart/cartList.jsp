<%@page import="com.dto.CartDTO"%>
<%@page import="com.dto.GoodsDTO"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<script src="${path}/resources/js/jquery-3.3.1.js"></script>
<script>

	// 총합
	function finalTotal(){
		var totalSum = 0;
		$(".goodsTotal").each(function(index, data){
			totalSum += Number.parseInt($(data).text());
		});
		$(".cartlist_Total").text(totalSum);
	};

	$(document).ready(function(){
		// 총합
		finalTotal();
		
		// 주문하기
		$(".orderBtn").on("click", function(){
			if($(".check:checked").length == 0){
				alert("선택하신 상품을 체크해주세요");
			} else {
				$("form").attr("action","loginCheck/orderAllCart");
				$("form").submit();
			}
		});

		// 전체 주문
		$(".orderAllCart").on("click", function(){
			$("form").attr("action","loginCheck/orderAllCart");
			$("form").submit();
		});
		
		// 전체삭제
		$(".delAllCart").on("click", function(){
			$("form").attr("action","loginCheck/delAllCart");
			$("form").submit();
		});
		
		// 전체선택
		$("#allCheck").on("click", function(){
			var result = this.checked;
			console.log(result);
			$(".check").each(function(i, data){
				console.log(this);
				this.checked = result;
			});
		});

		// 삭제
		$(".delBtn").on("click", function(){
			var num = $(this).attr("data-num");
			var thisNum = $(this);
			$.ajax({
				type: "GET",
				url: "loginCheck/cartDelete",
				dataType: "text",
				data: {
					num: num
				},
				success: function(responseData, status, xhr) {
					thisNum.parents().filter("tr").remove(); // tr태그 삭제 비동기처리
					finalTotal();
				},
				error : function(xhr, status, error) {
					console.log("error");
				}
			});
		});

		// 수량 수정
		$(".updateBtn").on("click", function(){
			var num = $(this).attr("data-num"); // 번호가져오기 ${cDTO.num}
			var gPrice = $(this).attr("data-price"); // 가격 가져오기
			var gAmount = $("#cartAmount"+num).val(); // 수량 가져오기
			
			console.log("amount = "+gAmount);
			$.ajax({
				type: "GET",
				url: "loginCheck/cartUpdate",
				dataType: "text",
				data: {
					num : num, // 카트번호
					gAmount: gAmount, // 수정한 수량전송
				},
				success: function(responseData, status, xhr) {
					var total = parseInt(gAmount) * parseInt(gPrice); // 성공시 합계만 변경함
					$("#sum"+num).text(total); // 가격 * 수량으로 변경
					finalTotal();
				},
				error : function(xhr, status, error) {
					console.log("error");
				}
			});
		});

	});
</script>
 <section class="cart">
    <div class="wrap">
    
    	<h2>장바구니</h2>

		<form name="myForm">
			<table class="cartlist">
			<caption class="blind">주문내역</caption>
				<colgroup>
					<col style="width: 10%;">
					<col style="width: 10%;">
					<col style="width: 30%;">
					<col style="width: 15%;">
					<col style="width: 10%;">
					<col style="width: 25%;">
				</colgroup>
				<thead>
					<tr>
						<th scope="col"><input type="checkbox" name="allCheck" id="allCheck"><label for="allCheck" class="blind">전체선택</label></th>
						<th scope="col">주문번호</th>
						<th scope="col">상품정보</th>
						<th scope="col">판매가</th>
						<th scope="col">수량</th>
						<th scope="col">합계</th>
					</tr>
				</thead>
				<tbody>
				<!-- items는 ra.addFlashAttribute("list", list);의 list -->
	        	<c:forEach var="cDTO" items="${list}" varStatus="status"> 
					<tr>
						<td><input type="checkbox" name="check" id="allCheck" class="check" value="${cDTO.num}"></td>
						<td><span>${cDTO.num}</span></td>
						<td class="goods_info clearfix">
							<div class="goods_cover">
								<img src="${path}/resources/images/items/${cDTO.gImage}.gif" class="cartlist_img"/>
							</div>
							<div class="goods_description">
								<span class="goods_title">
									${cDTO.gName} ( ${cDTO.gCode} )
									<em>[옵션 : 사이즈(${cDTO.gSize}), 색상(${cDTO.gColor})]</em>
								</span>
							</div>
						</td>
						<td class="won gPrice">${cDTO.gPrice}</td>
						<td class="test">
							<input type="text" name="cartAmount" id="cartAmount${cDTO.num}" value="${cDTO.gAmount}" maxlength="3" size="3">
				            <input type="button" value="수정" class="updateBtn" data-num="${cDTO.num}" data-price="${cDTO.gPrice}"/>
			            </td>
						<td>
							<span id="sum${cDTO.num}" class="goods_total won">${cDTO.gPrice * cDTO.gAmount}</span>
				            <input type="button" value="주문" class="orderBtn">
				            <input type="button" value="삭제" class="delBtn reset" data-num="${cDTO.num}">
						</td>
					</tr>
				</c:forEach> 
				</tbody>
			</table>
		
			<div class="product_button_box">
				<button type="button" class="orderAllCart">전체 주문하기</button>
				<button type="button" class="delAllCart">전체 삭제하기</button>
			    <a class="a_black" href="goodsList?gCategory=top">계속 쇼핑하기 </a>
			</div>
		</form>
 

    </div>
</section>
<script>
// 가격콤마
const price1 = document.querySelector('.gPrice');
const price2 = document.querySelector('.goods_total');

let priceComma = function(priceList){
	priceList.innerText = com.comma(priceList.innerText);
};

priceComma(price1);
priceComma(price2);
</script>

    