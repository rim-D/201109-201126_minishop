package com.dao;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dto.MemberDTO;

@Repository //component-scan으로 자동 빈생성
public class MemberDAO {

	@Autowired
	SqlSessionTemplate template; // 자동주입(sqlSession과 동일) db접근하게 끔 등록
	
	public void memberAdd(MemberDTO m) {
		int n = template.insert("MemberMapper.memberAdd", m); // 회원가입 완료
		System.out.println("회원가입 등록 === " + n);
	}
	
	public MemberDTO login(Map<String, String> map) {
		MemberDTO dto = template.selectOne("MemberMapper.login", map);
		return dto;
	}

	public MemberDTO mypage(String userid) {
		MemberDTO dto = template.selectOne("MemberMapper.mypage", userid);
		return dto;
	}

	public void memberUpdate(MemberDTO dto) {
		int n = template.update("MemberMapper.memberUpdate", dto);
		System.out.println("수정 === " + n);
	}

}
