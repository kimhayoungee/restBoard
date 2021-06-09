package com.my.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.my.domain.Reply2VO;

public interface Reply2Mapper {

	public int insert(Reply2VO rvo);
	
	public int update(Reply2VO rvo);
	
	public List<Reply2VO> selectList(@Param("bno") String bno);
	
	public Reply2VO select(int rno);
	
	public int deleteByRno(int rno);
	
	public int deleteBybno(int bno);
	
	//댓글삭제시 대댓글삭제 로직 고민
	
} //end of ReplyMapper
