package com.my.controller;

import static org.springframework.test.web.client.match.MockRestRequestMatchers.queryParam;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.google.gson.Gson;
import com.my.domain.ReplyVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml", 
					   "file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@Log4j
public class ReplyControllerTest {

	@Autowired
	private WebApplicationContext wac;
	
	private MockMvc mm;
	
	@Before
	public void setup() {
		this.mm = MockMvcBuilders.webAppContextSetup(wac).build();
	}
	
//	@Test
	public void registerTest() throws Exception{
		
		ReplyVO rvo = new ReplyVO();
		rvo.setBno("655308");
		rvo.setRid("new하영");
		rvo.setReply("컨트롤러 댓글내용");
		
		String jsonStr = new Gson().toJson(rvo);
		
		mm.perform(post("/reply/register").contentType(MediaType.APPLICATION_JSON).content(jsonStr));
	}
	
//	@Test
	public void getList() throws Exception{
		mm.perform(MockMvcRequestBuilders.get("/reply/page/655308/1"));
	}
	
//	@Test
	public void edit() throws Exception{
		
		ReplyVO rvo = new ReplyVO();
		rvo.setRno(11);;
		rvo.setReply("수정 테스트");
		
		String jsonStr = new Gson().toJson(rvo);
		
		mm.perform(post("/reply/edit").contentType(MediaType.APPLICATION_JSON).content(jsonStr));
		
	}
	
	@Test
	public void remove() throws Exception{
		mm.perform(MockMvcRequestBuilders.get("/reply/remove/11"));
	}
} //end of ReplyControllerTest
