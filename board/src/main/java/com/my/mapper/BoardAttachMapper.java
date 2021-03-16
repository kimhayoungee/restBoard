package com.my.mapper;

import java.util.List;

import com.my.domain.AttachVO;

public interface BoardAttachMapper {

	public void insert(AttachVO avo);
	
	public void delete(String uuid);
	
	public List<AttachVO> findByBno(String bno);
	
} //end of BoardAttachMapper
