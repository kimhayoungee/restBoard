package com.my.domain;

import lombok.Data;

@Data
public class AttachVO {

	//db에 들어갈 파일을 위한 vo 
	
	private String uuid;
	private String uploadPath;
	private String fileName;
	private boolean fileType;
	private String bno;
	
} //end of FileVO
