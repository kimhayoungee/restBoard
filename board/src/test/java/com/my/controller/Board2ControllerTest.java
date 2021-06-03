package com.my.controller;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
					   "file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@Log4j
@WebAppConfiguration
public class Board2ControllerTest {
	
	@Autowired
	private WebApplicationContext wac;
	private MockMvc mm;
	
	@Before
	public void setup() {
		this.mm = MockMvcBuilders.webAppContextSetup(wac).build();
	}
	
//	@Test
	public void getListTest() throws Exception{
		log.info(mm.perform(MockMvcRequestBuilders.get("/board2/list")).andReturn().getModelAndView().getModelMap());
	}
	
//	@Test 
	public void registerTest() throws Exception{
		String result = mm.perform(MockMvcRequestBuilders.post("/board2/register")
				          .param("btitle", "컨트롤러 테스트 제목")
				          .param("bcontent", "내용")
				          .param("bid", "user2")
				        ).andReturn().getModelAndView().getViewName();
		log.info(result);
	}
	
//	@Test
	public void showDetailTest() throws Exception{
		log.info(mm.perform(MockMvcRequestBuilders.get("/board2/detail").param("bno", "0001")
			    ).andReturn().getModelAndView().getModelMap());
	}
	
//	@Test
	public void editBoardTest() throws Exception{
		log.info(mm.perform(MockMvcRequestBuilders.post("/board2/edit").param("bno", "0001")
				 .param("btitle", "리더스키")
				 .param("bcontent", "언제가지")).andReturn().getModelAndView().getViewName());
	}
	
//	@Test
	public void removeBoardTest() throws Exception{
		log.info(mm.perform(MockMvcRequestBuilders.post("/board2/remove").param("bno", "0001")
				).andReturn().getModelAndView().getViewName());
	}
}
