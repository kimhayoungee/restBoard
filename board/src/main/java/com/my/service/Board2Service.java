package com.my.service;

import java.util.List;

import com.my.domain.Board2VO;
import com.my.domain.BoardAttachVO;

public interface Board2Service {

	public void register(Board2VO bvo);
	
	public List<Board2VO> getList();
	
	public Board2VO showDetail(String bno);
	
	public int editBoard(Board2VO bvo);
	
	public int removeBoard(String bno);
	
	public int countHit(String bno);
	
	public List<BoardAttachVO> getAttachList(String bno);
	
} //end of Board2Service
