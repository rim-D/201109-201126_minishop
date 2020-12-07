package com.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dao.CartDAO;
import com.dto.CartDTO;
import com.dto.OrderDTO;

@Service
public class CartSerivce {
	
	@Autowired
	CartDAO dao;
	
	public void cartAdd(CartDTO cDTO) {
		dao.cartAdd(cDTO);
	}

	public List<CartDTO> cartList(String userid) {
		List<CartDTO> list = dao.cartList(userid);
		return list;
	}
	
	public void cartUpdate(Map<String, String> map) {
		dao.cartUpdate(map);
	}

	public void cartDelete(int num) {
		dao.cartDelete(num);
	}

	public void delAllCart(ArrayList<String> list) {
		dao.delAllCart(list);	
	}

	public CartDTO orderConfirmByNum(String num) {
		CartDTO cDTO = dao.orderConfirmByNum(num);
		return cDTO;
	}

	@Transactional
	public void orderDone(OrderDTO oDTO) {
		dao.orderDone(oDTO); // 주문 저장 추가
		dao.cartDelete(oDTO.getNum()); // 장바구니 내역 삭제
	}

	public List<CartDTO> orderAllCart(ArrayList<String> list) {
		List<CartDTO> cDTO = dao.orderAllCart(list);
		return cDTO;
	}
	
	

}
