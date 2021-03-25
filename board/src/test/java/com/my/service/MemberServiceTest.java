package com.my.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.my.domain.MemberVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class MemberServiceTest {

	@Autowired
	private MemberService s;
	
//	@Test
	public void testRegisterMember() {
		MemberVO mvo = new MemberVO();
		mvo.setMid("ohio");
		mvo.setMpw("pw00");
		mvo.setMname("신효섭");
		mvo.setMaddress("몰라");
		mvo.setMbirth(19921211);
		
		log.info(s.registerMember(mvo));
	}
	
	@Test
	public void testIdChk() {
		log.info(s.idChk("ohio1"));
	}
	
}
