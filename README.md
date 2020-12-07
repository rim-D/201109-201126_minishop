# 프로젝트 소개
스프링 MVC패턴을 이용하여 CRUD 기능 구현한 의류 쇼핑몰입니다.
프로젝트 참여율 100% 개인 프로젝트로 진행하였습니다.

# 기술스택
### 1. Front-End
`HTML5` `CSS3` `JavaScript` `Jquery`

### 2. Back-End
`OracleDB` `AWS(RDS)` `MyBatis` `Spring`

### 3. Management Tools
`Git`

# 핵심기능
## 1. 회원가입
![회원가입](https://user-images.githubusercontent.com/48913713/101374397-779d3f80-38f1-11eb-8e4e-bf96a76f94fb.gif)
- DB에서 User의 가입 여부 확인한 id로 비밀번호 유효성검사하여 회원가입

## 2. 회원가입 및 로그인&로그아웃 / 마이페이지 
![login_mypage2](https://user-images.githubusercontent.com/48913713/101370902-75d17d00-38ed-11eb-9aa5-d6e521dc3729.gif)
- 로그인 시, DB에서 아이디와 비밀번호를 회원정보여부를 확인하여 로그인
- 로그인하면 마이페이지 카테고리 생성, 마이페이지에서 정보 수정가능
- 로그아웃하면 session에 담긴 login정보는 invalidate처리됨

## 2. 장바구니
![장바구니](https://user-images.githubusercontent.com/48913713/101371840-9221e980-38ee-11eb-8844-56e16b0653d6.gif)
- 선택한 상품의 필수정보를 담아야지만 장바구니에 상품 정보등록

## 3. 장바구니 수정, 삭제, 전체삭제
![주문삭제](https://user-images.githubusercontent.com/48913713/101373024-d95caa00-38ef-11eb-899e-d2e495b87c16.gif)
- 장바구니에 담긴 상품의 수량 수정하여 총 가격 수정
- 선택한 상품군 또는 전체 선택하여 장바구니 리스트 삭제
- 선택한 상품군 또는 전체 선택하여 주문하기

## 4. 결제
![주문결제](https://user-images.githubusercontent.com/48913713/101373733-a2d35f00-38f0-11eb-9066-a245e93d5435.gif)
- 주문버튼 클릭시, 로그인된 정보를 고객정보에 출력
- 배송정보는 다른배송지롤 주문할 경우 수동으로 입력가능
- 고객의 배송지가 동일할 경우 체크박스를 통한 고객정보를 받아 동일하게 적용
- 결제 수단까지 체크 완료하면 결제하기하면 결제완료!
- 결제완료하면 로그인된 아이디와 주문건수로 결제 재확인

