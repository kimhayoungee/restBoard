package com.my.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.my.domain.BoardVO;
import com.my.domain.Criteria;
import com.my.mapper.BoardMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
//@AllArgsConstructor
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardMapper m;

	@Override
	public List<BoardVO> getList(Criteria cri){
		log.info("서비스 getList(pvo) " + cri);
		
		return m.selectListPaging(cri);
	}

	@Override
	public void register(BoardVO bvo) {
		// TODO Auto-generated method stub
		log.info("서비스 register(bvo) " + bvo);
		
		bvo.setBno(m.getNumber()); //채번
		m.insertBoard(bvo);
		
	}

	@Override
	public BoardVO showDetail(String bno) {
		// TODO Auto-generated method stub
		log.info("서비스 showDetail(bno) " + bno);
		
		return m.selectDetail(bno);
	}

	@Override
	public int editBoard(BoardVO bvo) {
		// TODO Auto-generated method stub
		log.info("서비스  editBoard(bvo) " +bvo);
		
		return m.updateBoard(bvo);
	}

	@Override
	public int removeBoard(String bno) {
		// TODO Auto-generated method stub
		log.info("서비스 removeBoard(bno) " + bno);
		
		return m.deleteBoard(bno);
	}
	
	public int getTotal(Criteria cri) {
		log.info("서비스 getTotal(cri) " + cri);
		
		return m.getTotalCount(cri);
	}

}
