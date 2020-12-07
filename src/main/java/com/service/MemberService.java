package com.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.MemberDAO;
import com.dto.MemberDTO;

@Service //component-scan으로 자동 빈생성
public class MemberService {
	
	@Autowired // bean 자동주입
	MemberDAO dao;
	
	
	// 회원가입
	public void memberAdd(MemberDTO m) { 
		dao.memberAdd(m); // DTO전달
	}
	
	public MemberDTO login(Map<String, String> map) {
		MemberDTO dto = dao.login(map);
		return dto;
	}

	public MemberDTO mypage(String userid) {
		MemberDTO dto = dao.mypage(userid);
		return dto;
	}

	public void memberUpdate(MemberDTO dto) {
		dao.memberUpdate(dto);
	}
}
