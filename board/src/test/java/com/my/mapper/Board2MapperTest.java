package com.my.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.my.domain.Board2VO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class Board2MapperTest {

	@Autowired
	private Board2Mapper bm;
	
//	@Test
	public void insertBoardTest() {
		Board2VO bvo = new Board2VO();
		bvo.setBno("0001");
		bvo.setBid("아이디");
		bvo.setBtitle("제목");
		bvo.setBcontent("내용");
		
		bm.insertBoard(bvo);
		log.info(bvo);
	}

//	@Test
	public void selectListTest() {
		bm.selectList().forEach(board -> log.info(board));
		
	}
	
//	@Test
	public void selectDetailTest() {
		Board2VO bvo = bm.selectDetail("0001");
		
		log.info(bvo);
	}
	
//	@Test
	public void updateBoardTest() {
		Board2VO bvo = new Board2VO();
		bvo.setBtitle("수정제목2");
		bvo.setBcontent("수정내용2");
		bvo.setBno("0001");
		
		bm.updateBoard(bvo);
		log.info(bvo);
	}

//	@Test
	public void deleteBoardTest() {
		bm.deleteBoard("0001");
	}
	
//	@Test
	public void updateHitTest() {
		bm.updateHit("0001");
	}
	
	
} //end of Board2MapperTest
