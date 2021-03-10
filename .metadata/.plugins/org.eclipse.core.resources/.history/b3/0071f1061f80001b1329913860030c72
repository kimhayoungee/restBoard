package com.my.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.my.domain.BoardVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardServiceTest {
	
	@Autowired
	private BoardService service;
	
//	@Test
	public void testRegister() {
		
		BoardVO bvo = new BoardVO();
		bvo.setBtitle("서비스 제목입니다");
		bvo.setBcontent("서비스 내용입니다");
		bvo.setBid("happy");
		service.register(bvo);
		
		log.info("글번호확인 : " + bvo.getBno());
		
	}
	
//	@Test
	public void testGetBoardList() {
		service.getList().forEach(board -> log.info(board));
	}

//	@Test
	public void testShowDetail() {
		log.info(service.showDetail("1"));
	}
	
//	@Test
	public void testEditBoard() {
		
		BoardVO bvo = new BoardVO();
		bvo.setBno("1");
		bvo.setBtitle("서비스 수정된 제목입니다");
		bvo.setBcontent("서비스 수정된 내용입니다");
		
		log.info("수정 : " + service.editBoard(bvo));
	}
	
	@Test
	public void testRemoveBoard() {
		
		log.info("삭제 : " + service.removeBoard("1"));
	}
} //end of BoardServiceTest
