package com.my.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;

import com.my.domain.AuthVO;
import com.my.domain.MemberVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class MemberMapperTest {

	@Autowired MemberMapper m;
	
//	@Test
	public void testRead() {
		
		MemberVO mvo = m.read("admin90");
		
		log.info(mvo);
		
		mvo.getAuthList().forEach(authVO -> log.info(authVO));
	}
	
//	@Test
	public void testInsertMember() {
		MemberVO mvo = new MemberVO();
		
		mvo.setMid("happy");
		mvo.setMpw("pw00");
		mvo.setMname("김하영");
		mvo.setMbirth(19940410);
		mvo.setMaddress("서울시 어쩌구");
		
		int r = m.insertMember(mvo);
		log.info(r);
		
	}
	
//	@Test
	public void testInsertAuth() {
		
		log.info(m.insertAuth("happy"));
	}
	
//	@Test
	public void testSelectId() {
		log.info(m.selectId("happy1"));
	}
} //end of MemberMapperTest
