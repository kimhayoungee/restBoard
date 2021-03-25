package com.my.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.my.domain.MemberVO;
import com.my.mapper.MemberMapper;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberMapper m;
	
	@Override
	@Transactional
	public int registerMember(MemberVO mvo) {
		// TODO Auto-generated method stub
		log.info("서비스 registerMember(mvo) " + mvo);
		
		int r_m = m.insertMember(mvo);
		int r_a = m.insertAuth(mvo.getMid());
		
		if(r_m==1 && r_a==1) return 1;
		else return 0;
	}

	@Override
	public int idChk(String mid) {
		// TODO Auto-generated method stub
		log.info("서비스 idChk(mid) " + mid);
		
		return m.selectId(mid);
	}

} //end of MemberServiceImpl
