package kr.or.ddit.lecture.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.lecboard.service.LecBoardService;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.security.MemberVOWrapper;
import lombok.extern.slf4j.Slf4j;

/**
 * 강의게시판의 세부 페이지 이동
 * <p>강의게시판 메인
 * <p>강의게시판 자료실
 * <p>강의게시판 과제제출
 * <p>강의게시판 자유게시판
 * @author 김재웅
 * @since 2022. 4. 28.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2022. 4. 28.      김재웅       최초작성
 * 2022. 5. 13.		 황선부	 강의게시판 메인페이지(분기페이지)작성
 * Copyright (c) 2022 by DDIT All right reserved
 * </pre>
 */
@Slf4j
@Controller
public class LectureBoardRetrieveController {
	
	@Autowired
	private LecBoardService service;
	
	@RequestMapping("/lecBoard/tempLectureBoardView.do")
	public String tempLectureBoardView(
			Authentication authentication
			,Model model
			,HttpServletRequest req
			) {		
		MemberVO member
		 = ((MemberVOWrapper)authentication.getPrincipal()).getRealUser();
		
		int userNo = member.getUserNo();
		log.info("========================userNO:{}",userNo);
		String role = member.getMemRole();
		List<Map<String, Object>> lecList = new ArrayList<>();
		switch (role) {
		case "ROLE_STUDENT":
			lecList = service.retrieveLectureListOfStu(userNo);
			break;
		case "ROLE_PROFESSOR":
			lecList = service.retrieveLectureListOfPro(userNo);
			break;
		}
		model.addAttribute("lecList", lecList);
		
		return "lecBoard/tempLecBoard";
	}
}








