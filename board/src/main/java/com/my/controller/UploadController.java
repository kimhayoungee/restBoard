package com.my.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.my.domain.AttachFileDTO;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Log4j
public class UploadController {

	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName){
		log.info("파일이름: " + fileName);
		
		File file = new File("C:\\upload\\" + fileName);
		log.info("파일 : " + file);
		
		ResponseEntity<byte[]> result = null;
		
		try {
			HttpHeaders header = new HttpHeaders();
			
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
			
		}catch(Exception e) {
			e.printStackTrace();	
		}
		return result;
	} //end of getFile(fileName)
	
	@PostMapping(value="/uploadAjaxAction", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<List<AttachFileDTO>> uploadAjaxPost(MultipartFile[] uploadFile) {
		
		List<AttachFileDTO> list = new ArrayList<>();
		String uploadFolder = "C:\\upload";
		//날짜별 폴더
		String uploadFolderPath = getFolder();
		
		//풀 경로
		File uploadPath = new File(uploadFolder, uploadFolderPath);
		log.info("업로드 path : " + uploadPath);
		
		if(uploadPath.exists() ==false) {
			uploadPath.mkdirs();
		}
		
		for(MultipartFile mf : uploadFile) {
			log.info("---");
			log.info("upload file 이름 : " + mf.getOriginalFilename());
			log.info("upload file 크기 : " + mf.getSize());
			
			AttachFileDTO adto = new AttachFileDTO();
			String uploadFileName = mf.getOriginalFilename();
			
			//IE has file path
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
			log.info("파일이름만 확인 : " + uploadFileName);
			
			adto.setFileName(uploadFileName);
			
			UUID uuid = UUID.randomUUID();
			uploadFileName = uuid.toString() + "_" + uploadFileName;
			
			try {
				File saveFile = new File(uploadPath, uploadFileName);
				mf.transferTo(saveFile);
				adto.setUuid(uuid.toString());
				adto.setUploadPath(uploadFolderPath);
				
				if(chkImgType(saveFile)) {
					adto.setImage(true);
					
					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));
					
					Thumbnailator.createThumbnail(mf.getInputStream(), thumbnail, 100, 100);
					
					thumbnail.close();
				}
				
				list.add(adto);
				
			}catch(Exception e) {
				log.error(e.getMessage());
			} //end of try-catch문
		} //end of for문
		
		return new ResponseEntity<>(list, HttpStatus.OK);
	} //end of uploadAjaxPost(uploadFile)
	
	@GetMapping(value="/download", produces=MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public ResponseEntity<Resource> downloadFile(@RequestHeader("User-Agent") String userAgent, String fileName){
		
		log.info("다운로드 파일 : " + fileName);
		
		Resource rs = new FileSystemResource("C:\\upload\\" + fileName);
		
		log.info("resource : " + rs);
		
		String rsName = rs.getFilename();
		String rsOriginalName = rsName.substring(rsName.indexOf("_") + 1);
		
		HttpHeaders headers = new HttpHeaders();
		
		try {
			String downloadName = null;
			if(userAgent.contains("Trident")) {
				log.info("IE browser");
				//* \\+
				downloadName = URLEncoder.encode(rsOriginalName, "UTF-8").replaceAll("\\", " ");
				
			}else if(userAgent.contains("Edge")){
				log.info("Edge browser");
				
				downloadName = URLEncoder.encode(rsOriginalName, "UTF-8");
				
			}else {
				log.info("Chrome browser");
				
				downloadName = new String(rsOriginalName.getBytes("UTF-8"), "ISO-8859-1");
			}
			
			log.info("downloadName : " + downloadName);
			headers.add("Content-Disposition", "attachment; filename=" + downloadName);
		
		}catch(UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		return new ResponseEntity<Resource>(rs, headers, HttpStatus.OK);
	} //end of downloadFile(fileName)
	
	@PostMapping("/deleteFile")
	@ResponseBody
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<String> deleteFile(String fileName, String type){
		
		log.info("deleteFile : " + fileName);
		
		File file;
		
		try {
			file = new File("C:\\upload\\" + URLDecoder.decode(fileName, "UTF-8"));
			
			file.delete();
			
			if(type.equals("image")) {
				String largeFileName = file.getAbsolutePath().replace("s_", "");
				log.info("largeFileName : " + largeFileName);
				
				file = new File(largeFileName);
				file.delete();
			}
		}catch(UnsupportedEncodingException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		
		return new ResponseEntity<String>("deleted", HttpStatus.OK);
	}
	
	private String getFolder() {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Date d = new Date();
		
		String str = sdf.format(d);
		
		return str.replace("-", File.separator);
	}
	
	private boolean chkImgType(File file) {
		
		try {
			String contentType = Files.probeContentType(file.toPath());
			
			return contentType.startsWith("image");
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return false;
	}
	
}
