package com.my.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ReplyVO {

	private int rno;
	private String bno;
	private String rid;
	private String reply;
	private Date replydate;
	private Date rupdatedate;
	private String rdeleteyn;
	
	
}
