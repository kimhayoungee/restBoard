package com.my.mapper;

import java.util.List;
import java.util.stream.IntStream;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;

import com.my.domain.Criteria;
import com.my.domain.ReplyVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ReplyMapperTest {

	@Autowired
	private ReplyMapper m;
	
//	@Test
	public void testMapper() {
		log.info(m);
	}
	
	private String[] bnoList = {"655308", "655307", "655306", "655305", "655304"};
	
	
//	@Test
	public void testInsert() {
		
		IntStream.rangeClosed(1, 10).forEach(i ->{
			ReplyVO rvo = new ReplyVO();
			
			rvo.setBno(bnoList[i%5]);
			rvo.setReply("댓글테스트" + i);
			rvo.setRid("happy" + i);
			
			m.insert(rvo);
		});
		
	}
	
//	@Test
	public void testSelect() {
		
		ReplyVO rvo = m.select(1);
		
		log.info(rvo);
		
	}
	
//	@Test
	public void testUpdate() {
		
		ReplyVO rvo = new ReplyVO();
		rvo.setRno(1);
		rvo.setReply("댓글내용 수정합니다");
		
		int result = m.update(rvo);
		log.info("수정확인 : " + result);
		
	}
	
//	@Test
	public void testDelete() {
		
		int result = m.delete(1);
		log.info("삭제확인: " + result);
		
	}
	
	@Test
	public void testGetListPaging() {
		Criteria cri = new Criteria(2, 10);
		
		m.getListPaging(cri, "655308").forEach(reply -> log.info(reply));
		
		
	}
} //end of ReplyMapperTest
