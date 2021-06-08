package com.my.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class Reply2VO {

	private int rno;
	private String bno;
	private int rupperno;
	private int rdepth;
	private String rid;
	private String reply;
	private String rdeleteyn;
	private Date replydate;
	private Date rupdatedate;
	
	private List<Reply2VO> list;
}
