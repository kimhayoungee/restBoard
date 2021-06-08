package com.my.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.my.domain.Reply2VO;
import com.my.mapper.Board2Mapper;
import com.my.mapper.Reply2Mapper;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class Reply2ServiceImpl implements Reply2Service {

	@Autowired
	private Reply2Mapper rm;
	@Autowired
	private Board2Mapper bm;
	
	@Transactional
	@Override
	public int register(Reply2VO rvo) {
		// TODO Auto-generated method stub
		log.info("서비스 register(rvo) " + rvo);
		
		bm.updateReplyCnt(rvo.getBno());
		
		return rm.insert(rvo);
	}

	@Override
	public int edit(Reply2VO rvo) {
		// TODO Auto-generated method stub
		log.info("서비스 edit(rvo) " + rvo);
		
		return rm.update(rvo);
	}

}
