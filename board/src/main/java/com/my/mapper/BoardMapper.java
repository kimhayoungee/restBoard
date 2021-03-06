package com.my.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.context.annotation.Configuration;

import com.my.domain.BoardVO;
import com.my.domain.Criteria;

public interface BoardMapper {

	public List<BoardVO> selectList();
	
	public List<BoardVO> selectListPaging(Criteria cri);
	
	public String getNumber(); //채번 
	
	public int insertBoard(BoardVO bvo);
	
	public BoardVO selectDetail(String bno);
	
	public int updateBoard(BoardVO bvo);
	
	public int deleteBoard(String bno);
	
	public int getTotalCount(Criteria cri);
	
	public void updateReplyCnt(@Param("bno") String bno, @Param("amount") int amount);
	
} //end of BoardMapper
