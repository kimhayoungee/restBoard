package com.my.domain;

import java.util.Date;

import lombok.Data;

@Data
public class BoardVO {
	
	private String bno;
	private String bid;
	private String btitle;
	private String bcontent;
	private String bfile;
	private Date bregdate;
	private Date bupdatedate;
	private String bdeleteyn;
	
}
