package com.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dto.CartDTO;
import com.dto.MemberDTO;
import com.dto.OrderDTO;
import com.service.CartSerivce;
import com.service.MemberService;

@Controller
public class CartController {

	@Autowired
	CartSerivce cService;
	
	@Autowired
	MemberService mService;
	
	@RequestMapping(value = "/loginCheck/cartAdd")
	public String cartAdd(CartDTO cDTO, HttpSession session) { // 파싱
		MemberDTO mDTO = (MemberDTO) session.getAttribute("login"); // 세션에서 회원정보 얻기
		cDTO.setUserid(mDTO.getUserid()); // 회원정보에서 id를 꺼내 cDTO에 넣기
		session.setAttribute("msg", cDTO.getgCode());
		cService.cartAdd(cDTO); // db insert
		return "redirect:../goodsRetrieve?gCode="+cDTO.getgCode(); // 리다이렉션
	}
	
	@RequestMapping(value = "/loginCheck/cartList")
	public String cartList(CartDTO cDTO, HttpSession session, RedirectAttributes ra) {
		MemberDTO mDTO = (MemberDTO) session.getAttribute("login");
		System.out.println("mDTO===="+ mDTO);
		cDTO.setUserid(mDTO.getUserid());
		List<CartDTO> list = cService.cartList(cDTO.getUserid());
		ra.addFlashAttribute("list", list); // 리다이렉트시 데이터 유지
		return "redirect:../cartList"; // servlet-context등록
	}
	

	
//	@RequestMapping(value = "loginCheck/cartUpdate")
//	@ResponseBody
//	public void cartUpdate(String num, String gAmount) {
//		System.out.println("num==="+ num + "gAmount====" + gAmount );
//		HashMap<String, Integer> map = new HashMap<String, Integer>();
//		map.put("num", Integer.parseInt(num));
//    	map.put("gAmount", Integer.parseInt(gAmount));
//    	
//    	service.cartUpdate(map);
//	}
	
	@RequestMapping(value = "loginCheck/cartUpdate")
	@ResponseBody
	public void cart(@RequestParam Map<String, String> map) {
		System.out.println(map);
		cService.cartUpdate(map);
	}
	
	@RequestMapping(value = "loginCheck/cartDelete")
	@ResponseBody
	public void cartDelete(int num) {
		System.out.println("num===" +  num);
		cService.cartDelete(num);
	}
	
	@RequestMapping(value = "loginCheck/delAllCart")
	public String delAllCart(@RequestParam("check") ArrayList<String> list) {
		System.out.println("list===" + list);
		cService.delAllCart(list);
		return "redirect:../loginCheck/cartList";
	}
	
	@RequestMapping(value = "loginCheck/orderAllCart")
	public String orderAllCart(@RequestParam("check") ArrayList<String> list, HttpSession session, RedirectAttributes ra) {
		System.out.println("list===" + list);
		MemberDTO mDTO = (MemberDTO) session.getAttribute("login");
		String userid = mDTO.getUserid();
		mDTO = mService.mypage(userid);
		System.out.println(mDTO);
		List<CartDTO> cList = cService.orderAllCart(list);
		ra.addFlashAttribute("list", cList);
		for (CartDTO c : cList) {
			System.out.println(c);
		}
		ra.addFlashAttribute("mDTO", mDTO);
		return "redirect:../orderConfirm";
	}
	
//	@RequestMapping(value = "loginCheck/orderConfirm")
//	public String orderConfirm(String num, HttpSession session, RedirectAttributes ra) {
//		System.out.println(num);
//		MemberDTO mDTO = (MemberDTO) session.getAttribute("login");
//		String userid = mDTO.getUserid();
//		mDTO = mService.mypage(userid); // 사용자 정보 가져오기
//		CartDTO cDTO = cService.orderConfirmByNum(num); // 장바구니 정보 가져오기
//		ra.addFlashAttribute("mDTO", mDTO); // request에 회원 정보저장
//		ra.addFlashAttribute("cDTO", cDTO); // request에 카트 정보저장
//		
//		return "redirect:../orderConfirm";
//	}
	                
	@RequestMapping(value = "loginCheck/orderDone")
	public String orderDone(@RequestParam("orderNum") ArrayList<String> list, OrderDTO oDTO, HttpSession session, RedirectAttributes ra) {
		MemberDTO mDTO = (MemberDTO) session.getAttribute("login");
		String userid = mDTO.getUserid();
		oDTO.setUserid(userid);
		List<CartDTO> cList = cService.orderAllCart(list);
		for (CartDTO cDTO : cList) {
			oDTO.setNum(cDTO.getNum());
			oDTO.setgCode(cDTO.getgCode());
			oDTO.setgName(cDTO.getgName());
			oDTO.setgPrice(cDTO.getgPrice());
			oDTO.setgSize(cDTO.getgSize());
			oDTO.setgColor(cDTO.getgColor());
			oDTO.setgAmount(cDTO.getgAmount());
			oDTO.setgImage(cDTO.getgImage());
			
			cService.orderDone(oDTO); // tx처리 (cService에서)
			System.out.println("cList===="+cDTO);
		}
		System.out.println("oDTO===="+oDTO);
		ra.addFlashAttribute("cnt", cList.size());
		ra.addFlashAttribute("oDTO", oDTO);
		return "redirect:../orderDone"; // servlet-context.xml에 등록
	}

}
