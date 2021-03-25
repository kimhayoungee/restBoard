package com.my.controller;

import static org.springframework.test.web.client.match.MockRestRequestMatchers.queryParam;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.patch;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

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

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
					   "file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@Log4j
@WebAppConfiguration
public class MemberControllerTest {

	@Autowired
	private WebApplicationContext wac;
	
	private MockMvc mm;
	
	@Before
	public void setup() {
		this.mm = MockMvcBuilders.webAppContextSetup(wac).build();
	}
	
//	@Test
	public void testSignUp() throws Exception{
		
		String result = mm.perform(MockMvcRequestBuilders.post("/member/signup")
					      .param("mid", "nothingisincomplete")
					      .param("mpw", "pw00")
					      .param("mname", "기마영")
					      .param("mbirth", "19940202")
					      .param("maddress", "경기도 와부읍")
				       ).andReturn().getModelAndView().getViewName();
		log.info(result);
	}
	
	@Test
	public void testIdChk() throws Exception{
		
		log.info(
			mm.perform(MockMvcRequestBuilders.get("/member/idcheck").param("mid", "nothingisincomplete1"))
			.andReturn().getModelAndView().getModelMap()
		
		);
	}
	
} //end of MemberControllerTest
