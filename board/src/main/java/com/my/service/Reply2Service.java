package com.my.service;

import java.util.List;

import com.my.domain.Reply2VO;

public interface Reply2Service {

	public int register(Reply2VO rvo);
	
	public int edit(Reply2VO rvo);
	
	public Reply2VO getList(String bno);
	
	public Reply2VO getOne(int rno);
	
	public int deleteByRno(int rno);
	
	public int deleteByBno(String bno);
	
} //end of Reply2Service