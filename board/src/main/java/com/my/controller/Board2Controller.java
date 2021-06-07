package com.my.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.my.domain.Board2VO;
import com.my.domain.BoardAttachVO;
import com.my.service.Board2Service;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/board2/*")
@Log4j
public class Board2Controller {

	@Autowired
	private Board2Service s;
	
	@GetMapping("/list")
	public String getList(Model model) {
		log.info("컨트롤러 getList");
		
		model.addAttribute("boardList", s.getList());
		return "board2/list";
	}
	
	@GetMapping("/detail")
	public void goDetail(@RequestParam("bno") String bno, Model model, Principal principal) {
		log.info("컨트롤러 showDetail " + bno);
		
		Board2VO bvo = s.showDetail(bno);
		
		//조회수 처리 
		String loginId = principal.getName();
		String writer = bvo.getBid();
		if(!loginId.equals(writer)) s.countHit(bno);
		
		model.addAttribute("bvo", bvo);
	}
	
	@GetMapping("/register")
	public void goRegister() {}
	
	@PostMapping("/register")
	public String register(Board2VO bvo, RedirectAttributes ra) {
		log.info("컨트롤러 register " + bvo);
		
		if(bvo.getAttachList() !=null) {
			bvo.getAttachList().forEach(attach -> log.info(attach));
		}
		
		s.register(bvo);
		ra.addFlashAttribute("result", bvo.getBno());
		
		return "redirect:/board2/list";
	}
	
	@GetMapping("/edit")
	public void goEdit(@RequestParam("bno") String bno, Model model) {
		log.info("컨트롤러 goEdit(bno) " + bno);
		
		model.addAttribute("bvo", s.showDetail(bno));
	}
	
	@PostMapping("/edit")
	@PreAuthorize("principal.username == #bvo.writer")
	public String edit(Board2VO bvo, RedirectAttributes ra) {
		log.info("컨트롤러 edit " + bvo);
		
		if(bvo.getAttachList() !=null) {
			bvo.getAttachList().forEach(attach -> log.info(attach));
		}		
		
		if(s.editBoard(bvo)==1) {
			ra.addFlashAttribute("result", "성공");
		}
		
		return "redirect:/board2/list";
	}
	
	@PostMapping("/remove")
	@PreAuthorize("principal.username == #bvo.writer")
	public String remove(@RequestParam("bno") String bno, RedirectAttributes ra) {
		log.info("컨트롤러 remove " + bno);
		
		List<BoardAttachVO> atList = s.getAttachList(bno);
		
		if(s.removeBoard(bno)==1) {
			deleteFiles(atList);
			
			ra.addFlashAttribute("result", "성공");
		}
		
		return "redirect:/board2/list";
	}
	
	@GetMapping(value="/attachlist", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> getAttachList(String bno){
		log.info("컨트롤러 getAttachList " + bno);
		
		return new ResponseEntity<>(s.getAttachList(bno), HttpStatus.OK);
	}
	
	private void deleteFiles(List<BoardAttachVO> atList) {
		if(atList ==null || atList.size()==0) return;
		log.info("컨트롤러 deleteFile " + atList);
		
		atList.forEach(attach -> {
			try {
				Path file = Paths.get("C:\\upload\\" + attach.getUploadPath() + "\\" + attach.getUuid() + "_" + attach.getFileName());
				
				Files.deleteIfExists(file);
				
				if(Files.probeContentType(file).startsWith("image")) {
					Path thumbNail = Paths.get("C:\\upload\\" + attach.getUploadPath() + "\\s_" + attach.getUuid() + "_" + attach.getFileName());
					
					Files.delete(thumbNail);
				}
			}catch(Exception e ) {
				log.error("파일 삭제 에러 : " + e.getMessage());
			}
		});
	} //end of deleteFiles()
	
} //end of Board2Controller
