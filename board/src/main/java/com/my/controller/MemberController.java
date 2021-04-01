package com.my.controller;


import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.my.domain.MemberVO;
import com.my.service.MemberService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/member")
@Log4j
public class MemberController {
	
	@Autowired
	private MemberService s;
	
	@GetMapping("/signup")
	public void goSignUp() {}
	
	@PostMapping("/signup")
	public String signUp(MemberVO mvo, RedirectAttributes ra) {
		log.info("컨트롤러 signup");
		
		s.signUp(mvo);
		
		return "redirect:/";
	}
	
	@PostMapping(value="/idcheck")
	@ResponseBody
	public int idChk(@RequestParam("mid") String mid){
		log.info("컨트롤러 idChk" + mid);
		
		int result = s.idChk(mid);
		log.info("아이디 중복확인 : " + result);
		
		return result;
	}
} //end of MemberController
