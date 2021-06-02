package com.my.mapper;

import java.util.List;

import com.my.domain.Board2VO;

public interface Board2Mapper {

	//게시글 리스트 조회(페이징x, 임시)
	public List<Board2VO> selectList();
	
	//게시글 상세 조회
	public Board2VO selectDetail(String bno);
	
	//게시글 작성
	public int insertBoard(Board2VO bvo);
	
	//게시글 수정
	public int updateBoard(Board2VO bvo);
	
	//게시글 삭제
	public int deleteBoard(String bno);
	
	//조회수 카운트
	public int updateHit(String bno);
	
	
} //end of Board2Mapper
