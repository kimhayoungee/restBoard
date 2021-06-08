package com.my.service;

import java.util.List;

import com.my.domain.Reply2VO;

public interface Reply2Service {

	public int register(Reply2VO rvo);
	
	public int edit(Reply2VO rvo);
	
	public Reply2VO getList(String bno);
	
} //end of Reply2Service