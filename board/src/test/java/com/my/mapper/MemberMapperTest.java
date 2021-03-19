package com.my.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;

import com.my.domain.MemberVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class MemberMapperTest {

	@Autowired MemberMapper m;
	
	@Test
	public void testRead() {
		
		MemberVO mvo = m.read("admin90");
		
		log.info(mvo);
		
		mvo.getAuthList().forEach(authVO -> log.info(authVO));
	}
	
	
} //end of MemberMapperTest
