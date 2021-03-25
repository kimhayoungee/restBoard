package com.my.mapper;

import com.my.domain.MemberVO;

public interface MemberMapper {

	public MemberVO read(String mid);
	
	public int insertMember(MemberVO mvo);
	
	public int insertAuth(String mid);
	
	public int selectId(String mid);
} //end of MemberMapper
