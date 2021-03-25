package com.my.service;

import com.my.domain.MemberVO;

public interface MemberService {

	public int signUp(MemberVO mvo);
	
	public int idChk(String mid);
	
}
