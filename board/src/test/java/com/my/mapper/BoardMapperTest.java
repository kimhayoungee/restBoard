package com.my.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.my.domain.BoardVO;
import com.my.domain.Criteria;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardMapperTest {

	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;
	
//	@Test
	public void testSelectList() {
		mapper.selectList().forEach(board -> log.info(board));
	}

//	@Test
	public void testselectListPaging() {
		
		Criteria cri = new Criteria();
		cri.setAmount(10);
		cri.setPageNum(5);
		
		mapper.selectListPaging(cri).forEach(board -> log.info(board.getBno()));
		
	}
	
//	@Test
	public void testGetNumber() {
		log.info(mapper.getNumber());
	}
	
//	@Test 
	public void testinsertBoard() {
		
		BoardVO bvo = new BoardVO();
		bvo.setBno("2");
		bvo.setBid("테스트작성자");
		bvo.setBtitle("테스트 제목입니다");
		bvo.setBcontent("테스트 내용입니다");
		
		mapper.insertBoard(bvo);
		log.info(bvo);
	}

//	@Test
	public void testSelectDetail() {
		
		BoardVO bvo = mapper.selectDetail("1");
		
		log.info(bvo);
	}
	
//	@Test
	public void testUpdateBoard() {
		
		BoardVO bvo = new BoardVO();
		bvo.setBno("1");
		bvo.setBtitle("수정된 제목입니다");
		bvo.setBcontent("수정된 내용입니다");
		
		int result = mapper.updateBoard(bvo);
		log.info("UPDATE RESULT : " + result);
	}

//	@Test
	public void testDeleteBoard() {
		
		int result = mapper.deleteBoard("3");
		
		log.info("DELETE RESULT : " + result);
	}

	@Test
	public void testSearch() {
		Criteria cri = new Criteria();
		cri.setKeyword("테스트");
		cri.setType("TC");
		
		List<BoardVO> list = mapper.selectListPaging(cri);
		
		list.forEach(board -> log.info(board));
	}
} //end of BoardMapperTest
