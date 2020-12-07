package com.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.dto.MemberDTO;
import com.service.MemberService;


@Controller
public class LoginController {

	@Autowired
	MemberService service;
	
	// login
	@RequestMapping(value = "login")
	public String login(@RequestParam HashMap<String, String> map, Model model, HttpSession session) {
		System.out.println(map);
		MemberDTO dto = service.login(map);
		if(dto != null) {
			session.setAttribute("login", dto);
			//return "main";
			// 로그인 시 상품목록을 가져오도록 리다이렉트함
			return "redirect:/goodsList?gCategory=top";
		}else {
			model.addAttribute("msg","아이디 또는 비번이 잘못됐습니다");
			return "loginForm"; // loginForm.jsp
		}
	}
	
	
	// logout
	@RequestMapping(value = "/loginCheck/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		// .xml에 설정 main.jsp 
		// ../을 이용하여 /loginCheck의 상위 주소로 이동하여 사용
		return "redirect:../"; 
	}
	
	
	
}