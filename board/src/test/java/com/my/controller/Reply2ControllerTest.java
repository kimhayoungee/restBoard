package com.my.controller;

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
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.google.gson.Gson;
import com.my.domain.Reply2VO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	                   "file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@Log4j
public class Reply2ControllerTest {
	
	@Autowired
	private WebApplicationContext wac;
	private MockMvc mm;
	
	@Before
	public void setup() {
		this.mm = MockMvcBuilders.webAppContextSetup(wac).build();
	}
	
	@Test
	public void registerTest() throws Exception{
		
		Reply2VO rvo = new Reply2VO();
		rvo.setRno(4);
		rvo.setBno("B00010");
		rvo.setRdepth(1);
		rvo.setRid("user5");
		rvo.setReply("컨트롤러테스트2");		
		
		String jsonStr = new Gson().toJson(rvo);
		mm.perform(post("/reply2/register").contentType(MediaType.APPLICATION_JSON).content(jsonStr));
		
	}
	
} //end of Reply2ControllerTest
