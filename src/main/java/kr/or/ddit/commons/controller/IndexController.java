package kr.or.ddit.commons.controller;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

/**
 * index페이지 controller
 * @author 고성식
 * @since 2022. 4. 23.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2022. 4. 23.    고성식	       최초작성  <- 이부분 작성하면서 코딩 진행해주세요~
 * Copyright (c) 2022 by DDIT All right reserved
 * </pre>
 */
@Slf4j
@Controller
public class IndexController {
	@RequestMapping("/index.do")
	public String index(HttpServletResponse resp
						,HttpSession session) {
		session.removeAttribute("sideMenuListSession");
		session.removeAttribute("topMenuList");
		session.setAttribute("thisSemester", 202201);
	
		return "forward:/login/loginForm.do";
	}
}
