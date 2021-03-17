package com.my.domain;

import lombok.Data;

@Data
public class AttachFileDTO {

	//파일업로드시 ajax, 썸네일 처리를 위한 dto
	
	private String fileName;
	private String uploadPath;
	private String uuid;
	private boolean image;
	
}
