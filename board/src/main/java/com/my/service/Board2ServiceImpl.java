package com.my.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.my.domain.Board2VO;
import com.my.domain.BoardAttachVO;
import com.my.mapper.Board2Mapper;
import com.my.mapper.BoardAttachMapper;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class Board2ServiceImpl implements Board2Service {

	@Autowired
	private Board2Mapper bm;
	
	@Autowired
	private BoardAttachMapper am;
	
	@Transactional
	@Override
	public void register(Board2VO bvo) {
		// TODO Auto-generated method stub
		log.info("서비스 register(bvo)" + bvo);
		
		bvo.setBno(bm.getNumber());
		bm.insertBoard(bvo);
		
		if(bvo.getAttachList() ==null || bvo.getAttachList().size() <=0) {
			return;
		}
		
		bvo.getAttachList().forEach(attach -> {
			attach.setBno(bvo.getBno());
			am.insert(attach);
		});
		
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
		
		return bvo;
	}

	@Transactional
	@Override
	public int editBoard(Board2VO bvo) {
		// TODO Auto-generated method stub
		log.info("서비스 editBoard(bvo) + " + bvo);
		
		//파일 전체 삭제 후 변경된 것으로 다시 업로드 
		am.deleteAll(bvo.getBno());
		
		int editResult = bm.updateBoard(bvo);
		
		if(editResult ==1 && bvo.getAttachList() !=null && bvo.getAttachList().size() >0) {
			bvo.getAttachList().forEach(attach -> {
				attach.setBno(bvo.getBno());
				am.insert(attach);
			});
		}
		
		return editResult;
	}

	@Transactional
	@Override
	public int removeBoard(String bno) {
		// TODO Auto-generated method stub
		log.info("서비스 removeBoard(bno) " + bno);
		
		am.deleteAll(bno);
		return bm.deleteBoard(bno);
	}

	@Override
	public int countHit(String bno) {
		// TODO Auto-generated method stub
		log.info("서비스 countHit(bno) " + bno);
		
		return bm.updateHit(bno);
	}

	@Override
	public List<BoardAttachVO> getAttachList(String bno) {
		// TODO Auto-generated method stub
		log.info("서비스 getAttachList(bno) " + bno);
		
		return am.findByBno(bno);
	}
	

}
