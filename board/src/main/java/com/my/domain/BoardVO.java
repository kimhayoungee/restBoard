package com.my.domain;

import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class BoardVO {
	
	private String bno;
	private String bid;
	private String btitle;
	private String bcontent;
	private String bfile;
	private Date bregdate;
	private Date bupdatedate;
	private String bdeleteyn;
	private int breplycnt;
	
	private List<AttachVO> attachList;
}
