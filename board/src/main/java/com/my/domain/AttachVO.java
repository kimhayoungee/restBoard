package com.my.domain;

import lombok.Data;

@Data
public class AttachVO {

	private String uuid;
	private String uploadPath;
	private String fileName;
	private boolean fileType;
	private String bno;
	
} //end of FileVO
