package com.my.domain;

import java.util.Date;

import lombok.Data;

@Data
public class Board2VO {

	private String bno;
	private String bid;
	private String btitle;
	private String bcontent;
	private Date bregdate;
	private Date bupdatedate;
	private int breplycnt;
	private int bhit;
	private String bdeleteyn;
	
	private int battachcnt;
	//첨부파일 추가
	
}
