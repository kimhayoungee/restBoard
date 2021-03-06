package com.my.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.my.domain.Criteria;
import com.my.domain.ReplyPageVO;
import com.my.domain.ReplyVO;
import com.my.mapper.BoardMapper;
import com.my.mapper.ReplyMapper;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class ReplyServiceImpl implements ReplyService {

	@Autowired
	private ReplyMapper m;
	@Autowired
	private BoardMapper bm;
	
	@Transactional
	@Override
	public int register(ReplyVO rvo) {
		// TODO Auto-generated method stub
		log.info("서비스 register(rvo) " + rvo);
		
		bm.updateReplyCnt(rvo.getBno(), 1);
		
		return m.insert(rvo);
	}

	@Override
	public ReplyVO getReply(int rno) {
		// TODO Auto-generated method stub
		log.info("서비스 getReply(rno) " + rno);
		
		return m.select(rno);
	}

	@Override
	public int editReply(ReplyVO rvo) {
		// TODO Auto-generated method stub
		log.info("서비스 editReply(rvo) " + rvo);
		
		return m.update(rvo);
	}

	@Transactional
	@Override
	public int removeReply(int rno) {
		// TODO Auto-generated method stub
		log.info("서비스 removeReply(rno) " + rno);
		
		ReplyVO rvo = m.select(rno);
		bm.updateReplyCnt(rvo.getBno(), -1);
		
		return m.delete(rno);
	}

	@Override
	public List<ReplyVO> getList(Criteria cri, String bno) {
		// TODO Auto-generated method stub
		log.info("서비스 getList(cri, bno) " + cri + " " + bno);
		
		return m.getListPaging(cri, bno);
	}

	public ReplyPageVO getListPaging(Criteria cri, String bno) {
		log.info("서비스 getListPaging(cri, bno) " + cri + " " + bno);
		
		return new ReplyPageVO(m.getCount(bno), m.getListPaging(cri, bno));
	}
} //end of ReplyServiceImpl
