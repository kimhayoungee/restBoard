package com.my.mapper;

import com.my.domain.Reply2VO;

public interface Reply2Mapper {

	public int insert(Reply2VO rvo);
	
	public Reply2VO select(int rno);
	
	public int update(Reply2VO rvo);
	
	public int deleteBybno(int bno);
	
	public int deleteByrno(int rno);
	
	//댓글삭제시 대댓글삭제 로직 고민 
	
} //end of ReplyMapper
