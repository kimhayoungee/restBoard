package com.my.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;

import com.my.domain.Reply2VO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class Reply2MapperTest {

	@Autowired
	private Reply2Mapper m;
	
	@Test 
	public void testInsert() {
		Reply2VO rvo = new Reply2VO();
		
		rvo.setRno(2);
		rvo.setBno("B00007");
		rvo.setRdepth(1);
		rvo.setRid("user4");
		rvo.setReply("매퍼테스트");
		
		m.insert(rvo);
	}
	
}
