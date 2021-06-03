package com.my.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.my.domain.Board2VO;
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
	public void goDetail(@RequestParam("bno") String bno, Model model) {
		log.info("컨트롤러 showDetail " + bno);
		
		//조회수 처리 
		
		model.addAttribute("bvo", s.showDetail(bno));
	}
	
	@GetMapping("/register")
	public void goRegister() {}
	
	@PostMapping("/register")
	public String register(Board2VO bvo, RedirectAttributes ra) {
		log.info("컨트롤러 register " + bvo);
		
		s.register(bvo);
		ra.addFlashAttribute("result", bvo.getBno());
		
		return "redirect:/board2/list";
	}
	
	@GetMapping("/edit")
	public void goEdit() {}
	
	@PostMapping("/edit")
	public String edit(Board2VO bvo, RedirectAttributes ra) {
		log.info("컨트롤러 edit " + bvo);
		
		if(s.editBoard(bvo)==1) {
			ra.addFlashAttribute("result", "성공");
		}
		
		return "redirect:/board2/list";
	}
	
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") String bno, RedirectAttributes ra) {
		log.info("컨트롤러 remove " + bno);
		
		if(s.removeBoard(bno)==1) {
			ra.addFlashAttribute("result", "성공");
		}
		
		return "redirect:/board2/list";
	}
}
