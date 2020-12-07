package com.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.dto.GoodsDTO;
import com.service.GoodsSerivce;

@Controller
public class GoodsController {

	@Autowired
	GoodsSerivce service;

	@RequestMapping(value = "/goodsList")
	public ModelAndView goodsList(String gCategory) {
		if(gCategory == null) {
			gCategory = "top"; // 데이터가 없을 경우 기본값 설정
		}
		List<GoodsDTO> list = service.goodsList(gCategory);
		ModelAndView mav = new ModelAndView();
		// request.setAttribute("goodsList", list);와 동일
		mav.addObject("goodsList", list);
		mav.setViewName("main"); // main.jsp

		return mav;
	}
	
	@RequestMapping(value = "/goodsRetrieve") // 뷰의 주소
	@ModelAttribute("goodsRetrieve") //데이터의 키값 -> jsp에서 gDTO를 goodsRetrieve로 불러올 수 있음
	public GoodsDTO goodsRetrieve(String gCode) {
		GoodsDTO gDTO = service.goodsRetrieve(gCode);
		return gDTO;
	}


	
}
