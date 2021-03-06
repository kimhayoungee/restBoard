package com.my.task;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.my.domain.BoardAttachVO;
import com.my.mapper.BoardAttachMapper;

import lombok.extern.log4j.Log4j;

@Component
@Log4j
public class FileChkTask {

	@Autowired
	private BoardAttachMapper  m;
	
	@Scheduled(cron="0 0 2 * * *")
	public void chkFiles() {
		log.warn("file check task run ==============");
		
		List<BoardAttachVO> atList = m.getOldFiles();
		
		List<Path> fileListPaths = atList.stream().map(vo -> Paths.get("C:\\upload", vo.getUploadPath(), vo.getUuid() + "_" + vo.getFileName()))
								   .collect(Collectors.toList());
		
		//썸네일
		atList.stream().filter(vo -> vo.isFileType() == true).map(vo -> Paths.get("C:\\upload", vo.getUploadPath(), "s_"+vo.getUuid()+"_"+vo.getFileName()))
		 .forEach(p -> fileListPaths.add(p));
		
		log.warn("=================================================");
		
		fileListPaths.forEach(p -> log.warn(p));
		
		File targetDir = Paths.get("C:\\upload", getFolderYesterday()).toFile();
		
		File[] removeFiles = targetDir.listFiles(file -> fileListPaths.contains(file.toPath()) == false);
		
		log.warn("---------------------------------------------------------");
		for(File file : removeFiles) {
			log.warn(file.getAbsolutePath());
			file.delete();
		}
		
	}
	
	private String getFolderYesterday() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Calendar cal = Calendar.getInstance();
		
		cal.add(Calendar.DATE, -1);
		
		String str = sdf.format(cal.getTime());
		
		return str.replace("-", File.separator);
	}
	
} //end of FileChkTask
