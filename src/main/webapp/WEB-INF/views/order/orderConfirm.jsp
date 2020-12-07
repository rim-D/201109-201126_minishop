<%@page import="com.dto.MemberDTO"%>
<%@page import="com.dto.CartDTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<script src="${path}/resources/js/jquery-3.3.1.js"></script>
<script>
$(document).ready(function(){
	
	//주소지 처리 
	$("#same").on("click", function(){
		
		if(this.checked){
			
			$("#orderName").val($("#mname").val());
			$("#postcode").val($("#mpost").val());
			$("#address").val($("#maddress1").val());
			$("#detailAddress").val($("#maddress2").val());
			$("#phone").val($("#mphone").val());
			
		}else{
			$("#orderName").val("");
			$("#sample4_postcode").val("");
			$("#sample4_roadAddress").val("");
			$("#sample4_jibunAddress").val("");
			$("#phone").val();
		}
	});
	
});
</script>
<section class="orderCon">
	<div class="wrap">
	
		<h2>주문상품</h2>
		<!-- hidden 처리-->
		<form name="myForm" action="loginCheck/orderDone" method="get">
			<table class="orderConfirm">
				<caption class="blind">주문상품 확인</caption>
				<colgroup>
					<col style="width: 15%;">
					<col style="width: 50%;">
					<col style="width: 15%;">
					<col style="width: 10%;">
					<col style="width: 15%;">
				</colgroup>
				<thead>
					<tr>
						<th scope="col">주문번호</th>
						<th scope="col">상품정보</th>
						<th scope="col">판매가</th>
						<th scope="col">수량</th>
						<th scope="col">합계</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="cDTO" items="${list}">
					<tr>
						<td>${cDTO.num}</td>
						<td class="goods_info clearfix">
							<div class="goods_info_box">
								<div class="goods_cover">
									<img src="${path}/resources/images/items/${cDTO.gImage}.gif" class="cartlist_img"/>
								</div>
								<div class="goods_description">
									<span class="goods_title">
										${cDTO.gName} ( ${cDTO.gCode} )
										<em>[옵션 : 사이즈(${cDTO.gSize}), 색상(${cDTO.gColor})]</em>
									</span>
								</div>
							</div>
							
						</td>
						<td class="won gPrice">${cDTO.gPrice}</td>
						<td class="cartAmount_box">
							<input type="text" name="cartAmount" id="cartAmount${cDTO.num}" value="${cDTO.gAmount}" maxlength="3" size="3">
			            </td>
						<td>
							<span id="sum${cDTO.num}" class="won total_price">${cDTO.gPrice * cDTO.gAmount}</span>
							<input type ="hidden" name="orderNum" value="${cDTO.num}"><!-- cart주문번호 -->
						</td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
			<!--  고객 정보 시작-->
			<div class="customer_info_wrap">
				<div class="customer_title">
					<h3 class="title">고객정보</h3>
				</div>
			
				<div class="customer_info">
					<dl>
						<dt class="float-left"><strong>이름</strong></dt>
						<dd><input type="text" id="mname" value="${mDTO.username}"></input></dd>
					</dl>
					<dl>
						<dt class="float-left"><strong>우편번호</strong></dt>
						<dd><input type="text" id="mpost" value="${mDTO.post}" readonly></dd>
					</dl>
					<dl>
						<dt class="float-left"><strong>주소</strong></dt>
						<dd>
							<input type="text" id="maddress1" value="${mDTO.addr1}" readonly>
							<input type="text" id="maddress2" value="${mDTO.addr2}" readonly>
						</dd>
					</dl>
					<dl>
						<dt class="float-left"><strong>휴대전화</strong></dt>
						<dd>
							<input type="text" id="mphone" value="${mDTO.phone1}${mDTO.phone2}${mDTO.phone3}">
						</dd>
					</dl>
				</div>
			</div>
			<input type="checkbox" name="same" id="same" class="delivery-chk"> 배송지가 동일할 경우 선택하세요.
			<!--  배송지 정보 시작-->
			<div class="delivery_info_wrap">
				
				<div class="customer_title">
					<h3 class="title">배송지 정보</h3>
				</div>
			
				<div class="customer_info">
					<dl>
						<dt class="float-left"><strong>이름</strong></dt>
						<dd><input type="text" name="orderName" id="orderName" value=""></dd>
					</dl>
					<dl>
						<dt class="float-left"><strong>우편번호</strong></dt>
						<dd>
							<input type="text" name="post" id="postcode" placeholder="우편번호">
							<input type="button" onclick="execDaumPostcode()" class="delivery_btn find_post" value="우편번호 찾기">
						</dd>
					</dl>
					<dl>
						<dt class="float-left"><strong>주소</strong></dt>
						<dd>
							<input type="text" name="addr1" id="address" class="input_box_49" placeholder="주소" value="">
							<input type="text" name="addr2" id="detailAddress" class="input_box_49" placeholder="상세주소" value="">
						</dd>
					</dl>
					<dl>
						<dt class="float-left"><strong>휴대전화</strong></dt>
						<dd>
							<input type="text" id="phone" name="phone" value="">
						</dd>
					</dl>
				</div>
			</div>
			
			<div class="payment_wrap">
				<h3 class="title">결제 수단</h3>
				<div class="payment">
					<input type="radio" name="payMethod" value="신용카드" checked>신용카드
					<input type="radio" name="payMethod" value="계좌이체">계좌이체
					<input type="radio" name="payMethod" value="무통장 입금">무통장 입금
				</div>
				<div class="payment-btn_box">
					<input type="button" value="취소" onclick="javascript:history.back()" class="payment-btn reset-btn reset">	
					<input type="submit" value="결제하기" class="payment-btn">
					
				</div>
			</div>

		</form>
	
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


 // 가격콤마
 const price1 = document.querySelector('.gPrice');
 const price2 = document.querySelector('.total_price');

 let priceComma = function(priceList){
 	priceList.innerText = com.comma(priceList.innerText);
 };

 priceComma(price1);
 priceComma(price2);
</script>