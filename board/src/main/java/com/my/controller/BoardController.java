package com.my.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.my.domain.BoardAttachVO;
import com.my.domain.BoardVO;
import com.my.domain.Criteria;
import com.my.domain.BoardPageVO;
import com.my.service.BoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/board/*")
@Log4j
public class BoardController {

		@Autowired
		private BoardService s;
		
		@GetMapping("/list")
		public String getList(Criteria cri, Model model) {
			log.info("컨트롤러 getList");
			
			int total = s.getTotal(cri);
			
			model.addAttribute("boardList", s.getList(cri));
			model.addAttribute("pageMaker", new BoardPageVO(total,cri));
			return "board/list";
		}
		
		//페이지 이동
		@GetMapping("/register")
		@PreAuthorize("isAuthenticated()")
		public void goRegister() {
			
		}
		
		@PostMapping("/register")
		@PreAuthorize("isAuthenticated()")
		public String register(BoardVO bvo, RedirectAttributes ra) {
			log.info("컨트롤러 register " + bvo);
			
			if(bvo.getAttachList() !=null) {
				bvo.getAttachList().forEach(attach -> log.info(attach));
			}
			
			s.register(bvo);
			ra.addFlashAttribute("result", bvo.getBno());
			
			return "redirect:/board/list";
		}
		
		@GetMapping({"/detail", "/edit"})
		public void goDetail(@RequestParam("bno") String bno, @ModelAttribute("cri") Criteria cri, Model model) {
			log.info("컨트롤러 showDetail 혹은 edit" + bno);
			
			model.addAttribute("bvo", s.showDetail(bno));
		}		
		
		@PostMapping("/edit")
		public String editBoard(BoardVO bvo, @ModelAttribute("cri") Criteria cri, RedirectAttributes ra) {
			log.info("컨트롤러 editBoard " + bvo);
			
			if(s.editBoard(bvo)==1) {
				ra.addFlashAttribute("result", "성공");
			}
			
			return "redirect:/board/list" + cri.getListLink();
		}
	
		@PostMapping("/remove")
		public String removeBoard(@RequestParam("bno") String bno, @ModelAttribute("cri") Criteria cri, RedirectAttributes ra) {
			log.info("컨트롤러 removeBoard " + bno);
			
			List<BoardAttachVO> atList = s.getAttachList(bno);
			
			if(s.removeBoard(bno)==1) {
				deleteFiles(atList);
				
				ra.addFlashAttribute("result", "성공");
			}
			
			return "redirect:/board/list" + cri.getListLink();
		}
		
		@GetMapping(value="/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
		@ResponseBody
		public ResponseEntity<List<BoardAttachVO>> getAttachList(String bno){
			log.info("컨트롤러 getAttachList " + bno);
			
			return new ResponseEntity<>(s.getAttachList(bno), HttpStatus.OK);
		}
		
		private void deleteFiles(List<BoardAttachVO> atList) {
			if(atList ==null || atList.size() ==0) return;
			log.info("컨트롤러 deleteFile " + atList);
			
			atList.forEach(attach -> {
				try {
					Path file = Paths.get("D:\\upload\\" + attach.getUploadPath() + "\\" + attach.getUuid() + "_" + attach.getFileName());
					
					Files.deleteIfExists(file);
					
					if(Files.probeContentType(file).startsWith("image")) {
						Path thumbNail = Paths.get("D:\\upload\\" + attach.getUploadPath() + "\\s_" + attach.getUuid() + "_" + attach.getFileName());
						
						Files.delete(thumbNail);
					}
				}catch(Exception e) {
					log.error("파일삭제 에러: " + e.getMessage());
				}
				
			}); //end of forEach
		}
		
} // end of BoardController