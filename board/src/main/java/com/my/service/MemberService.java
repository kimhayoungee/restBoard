package com.my.service;

import com.my.domain.MemberVO;

public interface MemberService {

	public int registerMember(MemberVO mvo);
	
	public int idChk(String mid);
	
}
