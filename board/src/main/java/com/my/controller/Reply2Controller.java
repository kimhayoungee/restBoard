package com.my.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
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
		log.info("댓글 등록 : " + result);
		
		return result==1? new ResponseEntity<>("success", HttpStatus.OK)
				         :new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@PostMapping(value="/edit", consumes="application/json", produces= {MediaType.TEXT_PLAIN_VALUE})
	@PreAuthorize("principal.username == #rvo.rid")
	public ResponseEntity<String> edit(@RequestBody Reply2VO rvo){
		log.info("컨트롤러 edit " + rvo);
		
		int result = s.edit(rvo);
		log.info("댓글 수정 : " + result);
		
		return result==1? new ResponseEntity<>("success", HttpStatus.OK)
				         :new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value="/list/{bno}", produces= {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<Reply2VO> getList(@PathVariable("bno") String bno){
		log.info("컨트롤러 getList " + bno);
		
		return new ResponseEntity<>(s.getList(bno), HttpStatus.OK);
	}
	
	@GetMapping(value="{rno}", produces= {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<Reply2VO> getOne(@PathVariable("rno") int rno){
		log.info("컨트롤러 getOne " + rno);
		
		return new ResponseEntity<>(s.getOne(rno), HttpStatus.OK);
	}
	
	@PostMapping(value="/remove/{rno}", consumes="application/json", produces= {MediaType.TEXT_PLAIN_VALUE})
	@PreAuthorize("principal.username == #rvo.rid")
	public ResponseEntity<String> removeByRno(@PathVariable("rno") int rno){
		log.info("컨트롤러 removeByRno " + rno);
		
		int result = s.deleteByRno(rno);
		
		return result==1? new ResponseEntity<>("success", HttpStatus.OK)
				         :new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
} //end of Reply2Controller