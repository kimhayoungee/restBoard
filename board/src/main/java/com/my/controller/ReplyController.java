package com.my.controller;

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

import com.my.domain.Criteria;
import com.my.domain.ReplyPageVO;
import com.my.domain.ReplyVO;
import com.my.service.ReplyService;

import lombok.extern.log4j.Log4j;

@RequestMapping("/reply/*")
@RestController
@Log4j
public class ReplyController {

	@Autowired
	private ReplyService s;
	
	@PostMapping(value="/register", consumes="application/json", produces= {MediaType.TEXT_PLAIN_VALUE})
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<String> register(@RequestBody ReplyVO rvo){
		log.info("컨트롤러 register");
		
		int result = s.register(rvo);
		log.info("댓글 등록 : " + result);
	
		return result==1? new ResponseEntity<>("success", HttpStatus.OK)
				         :new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value="/page/{bno}/{pageNum}", produces= {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<ReplyPageVO> getList(@PathVariable("bno") String bno, @PathVariable("pageNum") int pageNum){
		log.info("컨트롤러 getList");
		
		Criteria cri = new Criteria(pageNum, 10);
		
		return new ResponseEntity<>(s.getListPaging(cri, bno), HttpStatus.OK);
	}
	
	@PostMapping(value="edit", consumes="application/json", produces= {MediaType.TEXT_PLAIN_VALUE})
	@PreAuthorize("principal.username == #rvo.rid")
	public ResponseEntity<String> edit(@RequestBody ReplyVO rvo){
		log.info("컨트롤러 edit");
			
		int result = s.editReply(rvo);
		log.info("댓글 수정: " + result);
		
		return result==1? new ResponseEntity<>("success", HttpStatus.OK)
					     :new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@PostMapping(value="/remove/{rno}", consumes="application/json", produces= {MediaType.TEXT_PLAIN_VALUE})
	@PreAuthorize("principal.username == #rvo.rid")
	public ResponseEntity<String> remove(@RequestBody ReplyVO rvo, @PathVariable("rno") int rno){
		log.info("컨트롤러 remove");
		
		int result = s.removeReply(rno);
		log.info("댓글 삭제: " + result);
		
		return result==1? new ResponseEntity<>("success", HttpStatus.OK)
				         :new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value="{rno}", produces= {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<ReplyVO> get(@PathVariable("rno") int rno){
		log.info("컨트롤러 get");
		
		return new ResponseEntity<>(s.getReply(rno), HttpStatus.OK);
	}
} //end of ReplyController
