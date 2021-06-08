package com.my.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.my.domain.Reply2VO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class Reply2ServiceTest {

	@Autowired
	private Reply2Service rs;
	
	@Test
	public void insertTest() {
		
		Reply2VO rvo = new Reply2VO();
		rvo.setRno(3);
		rvo.setBno("B00010");
		rvo.setRdepth(1);
		rvo.setRid("user4");
		rvo.setReply("서비스테스트");
		rs.register(rvo);
	}
	
	
}
