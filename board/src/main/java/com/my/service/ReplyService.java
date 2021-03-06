package com.my.service;

import java.util.List;

import com.my.domain.Criteria;
import com.my.domain.ReplyPageVO;
import com.my.domain.ReplyVO;

public interface ReplyService {

	public int register(ReplyVO rvo);
	
	public ReplyVO getReply(int rno);
	
	public int editReply(ReplyVO rvo);
	
	public int removeReply(int rno);
	
	public List<ReplyVO> getList(Criteria cri, String bno);
	
	public ReplyPageVO getListPaging(Criteria cri, String bno);
} //end of ReplyService
