package com.my.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.my.domain.Reply2VO;
import com.my.service.Reply2Service;

import lombok.extern.log4j.Log4j;

@RequestMapping("/reply2/*")
@RestController
@Log4j
public class Reply2Controller {
	
	@Autowired
	private Reply2Service s;
	
	@PostMapping(value="/register", consumes="application/json", produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> register(@RequestBody Reply2VO rvo){
		log.info("컨트롤러 register " + rvo);
		
		int result = s.register(rvo);
		
		return result==1? new ResponseEntity<>("success", HttpStatus.OK)
				         :new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
} //end of Reply2Controller