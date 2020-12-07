package com.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
// import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.dto.GoodsDTO;
import com.dto.MemberDTO;
import com.service.GoodsSerivce;
import com.service.MemberService;

@Controller
public class MemberController {
	
	@Autowired // service자동주입
	MemberService service;
	
	@Autowired
	GoodsSerivce gService;
	
//	@RequestMapping(value = "memberAdd")
//	public String memberAdd(MemberDTO m, Model model) { // form에서 넘어온 데이터를 MemberDTO에 자동저장
//		System.out.println(m);
//		service.memberAdd(m); // 회원가입 성공
//		model.addAttribute("success", "회원가입 성공"); // main.jsp에 전달하여 출력
//		return "main"; // main.jsp
//	}
	
	@RequestMapping(value = "memberAdd")
	public ModelAndView memberAdd(MemberDTO m) { // form에서 넘어온 데이터를 MemberDTO에 자동저장
		System.out.println(m);
		List<GoodsDTO> list = gService.goodsList("top");
		service.memberAdd(m); // 회원가입 성공
		ModelAndView mav = new ModelAndView();
		mav.addObject("goodsList", list);
		mav.addObject("success", "회원가입 성공"); // main.jsp에 전달하여 출력
		mav.setViewName("main");
		return mav; // main.jsp
	}
	
	
	
	// /loginCheck가 있는 경우에는 인터셉터에서 로그인 인증 후 페이지 이동하게끔 함
	@RequestMapping(value = "/loginCheck/mypage")
	public String mypage(HttpSession session) {
		// 세션에서 id 얻기
		// db에서 id에 해당하는 DTO정보 얻기 myPage(사용자 id이용)
		// dto정보 콘솔에 출력
		MemberDTO dto = (MemberDTO) session.getAttribute("login");
		String userid = dto.getUserid();
		dto = service.mypage(userid);
		System.out.println(userid);
		session.setAttribute("login", dto);
		return "redirect:../mypage"; // xml에 지정된  mypage.jsp로 이동
		// servlet-context에 등록
		// return "mypage"로 등록 시에는 
		// @RequestMapping(value = "/loginCheck/mypage")이 
		// http://localhost:8085/shopminiMall/loginCheck/mypage으로 찍힘
		// redirect:../mypage로 했을 시에는 http://localhost:8085/shopminiMall/mypage로 찍힘
	}
	
	
	
	// 회원가입 아이디 중복체크 msg 출력
	// 응답에 대한 한글 처리 필수
	@RequestMapping(value = "/idDuplicateCheck", produces = "text/plain; charset=UTF-8")
	@ResponseBody
	public String idDuplicateCheck(String userid) {
		MemberDTO dto = service.mypage(userid);
		System.out.println(userid);
		String msg = "아이디 사용 가능";
		if(dto != null) {
			msg = "아이디 중복";
		}
		return msg; // 메세지 전달 -  리턴페이지 아님
	}
	
	
	@RequestMapping(value ="loginCheck/memberUpdate")
	public String memberUpdate(MemberDTO dto) {
		System.out.println("memberUpdate/////" + dto);
		service.memberUpdate(dto); // 회원정보 업데이트
		System.out.println("update=====" + dto);
		return "redirect:../loginCheck/mypage";
	}
	
}
