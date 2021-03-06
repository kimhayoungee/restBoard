package com.my.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.my.domain.BoardAttachVO;
import com.my.domain.BoardVO;
import com.my.domain.Criteria;
import com.my.mapper.BoardAttachMapper;
import com.my.mapper.BoardMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
//@AllArgsConstructor
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardMapper m;

	@Autowired
	private BoardAttachMapper am; 
	
	@Override
	public List<BoardVO> getList(Criteria cri){
		log.info("서비스 getList(cri) " + cri);
		
		return m.selectListPaging(cri);
	}

	@Transactional
	@Override
	public void register(BoardVO bvo) {
		// TODO Auto-generated method stub
		log.info("서비스 register(bvo) " + bvo);
		
		bvo.setBno(m.getNumber()); //채번
		m.insertBoard(bvo);
		
		if(bvo.getAttachList() ==null || bvo.getAttachList().size() <=0) {
			return;
		}
		
		bvo.getAttachList().forEach(attach -> {
			attach.setBno(bvo.getBno());
			am.insert(attach);
		});
	}

	@Override
	public BoardVO showDetail(String bno) {
		// TODO Auto-generated method stub
		log.info("서비스 showDetail(bno) " + bno);
		
		return m.selectDetail(bno);
	}

	@Transactional
	@Override
	public int editBoard(BoardVO bvo) {
		// TODO Auto-generated method stub
		log.info("서비스  editBoard(bvo) " +bvo);
		
		am.deleteAll(bvo.getBno());
		
		int editResult = m.updateBoard(bvo);
		
		if(editResult==1 && bvo.getAttachList() !=null && bvo.getAttachList().size() >0) {
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
		
		return m.deleteBoard(bno);
	}
	
	public int getTotal(Criteria cri) {
		log.info("서비스 getTotal(cri) " + cri);
		
		return m.getTotalCount(cri);
	}
	
	public List<BoardAttachVO> getAttachList(String bno){
		log.info("서비스 getAttachList(bno) " + bno);
		
		return am.findByBno(bno);
	}

} //end of BoardServiceImpl
