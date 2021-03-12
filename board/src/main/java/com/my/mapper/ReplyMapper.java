package com.my.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.my.domain.Criteria;
import com.my.domain.ReplyVO;

public interface ReplyMapper {

	public int insert(ReplyVO rvo);
	
	public ReplyVO select(int rno);
	
	public int update(ReplyVO rvo);
	
	public int delete(int rno);
	
	public List<ReplyVO> getListPaging(@Param("cri") Criteria cri, @Param("bno") String bno);
	
	public int getCount(String bno);
} //end of ReplyMapper
