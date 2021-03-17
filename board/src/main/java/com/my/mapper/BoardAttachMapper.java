package com.my.mapper;

import java.util.List;

import com.my.domain.BoardAttachVO;

public interface BoardAttachMapper {

	public void insert(BoardAttachVO avo);
	
	public void delete(String uuid);
	
	public List<BoardAttachVO> findByBno(String bno);
	
	public void deleteAll(String bno);
	
	public List<BoardAttachVO> getOldFiles();
	
} //end of BoardAttachMapper
