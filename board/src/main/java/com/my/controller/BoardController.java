package com.my.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.my.domain.BoardVO;
import com.my.domain.Criteria;
import com.my.domain.PageVO;
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
			model.addAttribute("pageMaker", new PageVO(total,cri));
			return "board/list";
		}
		
		//페이지 이동
		@GetMapping("/register")
		public void goRegister() {
			
		}
		
		@PostMapping("/register")
		public String register(BoardVO bvo, RedirectAttributes ra) {
			log.info("컨트롤러 register " + bvo);
			
			if(bvo.getAttachList() !=null) {
				bvo.getAttachList().forEach(attach -> log.info(attach));
			}
			
			log.info("======================");
			
			//s.register(bvo);
			//ra.addFlashAttribute("result", bvo.getBno());
			
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
			
			if(s.removeBoard(bno)==1) {
				ra.addFlashAttribute("result", "성공");
			}
			
			return "redirect:/board/list" + cri.getListLink();
		}
		

} // end of BoardController