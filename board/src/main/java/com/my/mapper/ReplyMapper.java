package com.my.mapper;

import com.my.domain.ReplyVO;

public interface ReplyMapper {

	public int insert(ReplyVO rvo);
	
	public ReplyVO select(int rno);
	
	public int update(ReplyVO rvo);
	
	public int delete(int rno);
} //end of ReplyMapper
