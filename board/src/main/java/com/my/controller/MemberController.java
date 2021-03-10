package com.my.controller;


import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/member")
@Log4j
public class MemberController {

	@PostMapping("/login")
	public void login() {
		
	}
	
	@GetMapping("/goSignup")
	public void signup() {
		
	}
	
	@GetMapping("/goMemberupdate")
	public void memupdate() {
		
	}
	
} //end of MemberController
