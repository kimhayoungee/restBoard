package com.my.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.my.domain.MemberVO;
import com.my.mapper.MemberMapper;
import com.my.security.domain.CustomUser;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class CustomUserDetailsService implements UserDetailsService {
	
	@Autowired
	private MemberMapper m;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		// TODO Auto-generated method stub
		
		log.warn("Load User By username: " + username);
		
		//userName means mid
		MemberVO mvo = m.read(username);
		
		log.warn("queried by member mapper: " + mvo);
		
		return mvo == null? null : new CustomUser(mvo);
	}

} 
