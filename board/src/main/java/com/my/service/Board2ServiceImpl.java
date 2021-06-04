package com.my.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.my.domain.Board2VO;
import com.my.mapper.Board2Mapper;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class Board2ServiceImpl implements Board2Service {

	@Autowired
	private Board2Mapper bm;
	
	
	@Override
	public void register(Board2VO bvo) {
		// TODO Auto-generated method stub
		log.info("서비스 register(bvo)" + bvo);
		
		bvo.setBno(bm.getNumber());
		bm.insertBoard(bvo);
		
		//첨부파일 추가
		
	}

	@Override
	public List<Board2VO> getList() {
		// TODO Auto-generated method stub
		log.info("서비스 getList()");
		
		return bm.selectList();
	}

	@Override
	public Board2VO showDetail(String bno) {
		// TODO Auto-generated method stub
		log.info("서비스 showDetail(bno) " + bno);
		Board2VO bvo = bm.selectDetail(bno);
		
		//조회수 처리 컨트롤러에서? 서비스에서? 
		
		return bvo;
	}

	@Override
	public int editBoard(Board2VO bvo) {
		// TODO Auto-generated method stub
		log.info("서비스 editBoard(bvo) + " + bvo);
		
		return bm.updateBoard(bvo);
	}

	@Override
	public int removeBoard(String bno) {
		// TODO Auto-generated method stub
		log.info("서비스 removeBoard(bno) " + bno);
		
		return bm.deleteBoard(bno);
	}

	@Override
	public int countHit(String bno) {
		// TODO Auto-generated method stub
		log.info("서비스 countHit(bno) " + bno);
		
		return bm.updateHit(bno);
	}

}
