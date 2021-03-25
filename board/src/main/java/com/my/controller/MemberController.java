package com.my.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;


import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/member")
@Log4j
public class MemberController {

	@PostMapping("/login")
	public void login() {
		
	}
	
	@GetMapping("/signup")
	public void signup() {
		
	}
	
	@GetMapping("/update")
	public void memupdate() {
		
	}
	
} //end of MemberController
