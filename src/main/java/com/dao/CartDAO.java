package com.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dto.CartDTO;
import com.dto.OrderDTO;

@Repository
public class CartDAO {
	
	@Autowired
	SqlSessionTemplate template;

	public void cartAdd(CartDTO cDTO) {
		template.insert("CartMapper.cartAdd", cDTO);
	}

	public List<CartDTO> cartList(String userid) {
		List<CartDTO> list = template.selectList("CartMapper.cartList", userid);
		return list;
	}

	public void cartUpdate(Map<String, String> map) {
		template.update("CartMapper.cartUpdate", map);
	}

	public void cartDelete(int n) {
		template.delete("CartMapper.cartDel", n);
	}

	public void delAllCart(ArrayList<String> list) {
		template.delete("CartMapper.cartAllDel", list);
	}

	public CartDTO orderConfirmByNum(String num) {
		CartDTO cDTO = template.selectOne("CartMapper.cartbyNum", num);
		return cDTO;
	}

	public void orderDone(OrderDTO oDTO) {
		template.insert("CartMapper.orderDone", oDTO);
	}

	public List<CartDTO> orderAllCart(ArrayList<String> list) {
		List<CartDTO> cDTO = template.selectList("CartMapper.cartAllNum", list);
		System.out.println("cDTO===="+cDTO);
		return cDTO;
	}

}
