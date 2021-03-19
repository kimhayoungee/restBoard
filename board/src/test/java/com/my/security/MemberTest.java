package com.my.security;

import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml"
					  ,"file:src/main/webapp/WEB-INF/spring/security-context.xml" })
@Log4j
public class MemberTest {
	
	@Autowired
	private PasswordEncoder pe;
	@Autowired
	private DataSource ds;
	
//	@Test
	public void testInsertMember() {
		String sql = "insert into khy_member(mid, mpw, mname) values(?, ?, ?)";
		
		for(int i=0;i<100;i++) {
			Connection c = null;
			PreparedStatement ps = null;
			
			try {
				
				c = ds.getConnection();
				ps = c.prepareStatement(sql);
				
				ps.setString(2, pe.encode("pw" + i));
				
				if(i <80) {
					
					ps.setString(1, "user" + i);
					ps.setString(3, "일반사용자" + i);
				
				}else if(i <90) {
					
					ps.setString(1, "manager" + i);
					ps.setString(3, "운영자" + i);
					
				}else {
					
					ps.setString(1, "admin" + i);
					ps.setString(3, "관리자" + i);
					
				}
				
				ps.executeUpdate();
				
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(ps !=null) try {ps.close();}catch(Exception e) {}
				if(c !=null) try {c.close();}catch(Exception e) {}
			}
		} //end of for
		
	} //end of testInsertMember()
	
	@Test
	public void testInsertAuth() {
		
		String sql = "insert into khy_member_auth (mid, auth) values (?, ?)";
		
		for(int i=0;i<100;i++) {
			
			Connection c = null;
			PreparedStatement ps = null;
			
			try{
				
				c = ds.getConnection();
				ps = c.prepareStatement(sql);
				
				if(i <80) {
					
					ps.setString(1, "user" + i);
					ps.setString(2, "ROLE_USER");
					
				}else if(i <90) {
					
					ps.setString(1, "manager" + i);
					ps.setString(2, "ROLE_MEMBER");
					
				}else {
					
					ps.setString(1, "admin" + i);
					ps.setString(2, "ROLE_ADMIN");
				}
				ps.executeUpdate();
				
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(ps !=null) try {ps.close();}catch(Exception e) {}
				if(c !=null) try {c.close();}catch(Exception e) {}				
			}
		} //end of for
		
	} //end of testInsertAuth()
}
