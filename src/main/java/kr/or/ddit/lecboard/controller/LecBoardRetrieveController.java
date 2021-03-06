package kr.or.ddit.lecboard.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.homework.service.HomeworkService;
import kr.or.ddit.lecboard.service.LecBoardService;
import kr.or.ddit.lecqna.service.LecQnaService;
import kr.or.ddit.vo.ClassVO;
import kr.or.ddit.vo.LecHomeworkVO;
import kr.or.ddit.vo.LecqnaVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.security.MemberVOWrapper;
import lombok.extern.slf4j.Slf4j;

/**lecBoard Main page
 * main page - 영역 분리하여 공지사항, 최근 과제 게시판, 과제에 대한 최근 피드백을 모두 나타냄.
 * @author 황선부
 * @since 2022. 5. 13.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2022. 5. 13.      황선부       최초작성
 * Copyright (c) 2022 by DDIT All right reserved
 * </pre>
 */
@Slf4j
@Controller
public class LecBoardRetrieveController {
	
	@Autowired
	private LecBoardService service;
	@Inject
	private LecQnaService qnaService;
	@Inject
	private HomeworkService hwService;
	@GetMapping("/lecBoard/main")
	public String lecBoardMain(
		Authentication authentication
		,HttpServletResponse resp
		,HttpServletRequest req
		,HttpSession session
		,Model model
			) throws IOException {
		//시큐리티
		
		String viewName = null;
		
		//1. 강의 수강하는 학생이 아니면 session으로 접근제한(강의 수강 학생 전체 불러오기 나중에 main에서 재활용)
		MemberVO member
		 = ((MemberVOWrapper)authentication.getPrincipal()).getRealUser();
		
		int userNo = member.getUserNo();
		if(member.getMemRole().equals("ROLE_STUDENT")) {
			
			List<Map<String, Object>>list = qnaService.retrieveMyQuestion(userNo);
			List<Map<String, Object>>evaList = hwService.retrieveEvaHw(userNo);
			
			model.addAttribute("myQnaList", list);
			model.addAttribute("evaList", evaList);
		}
		
		ClassVO classVO =new ClassVO();
		
		int lecSems = Integer.parseInt(req.getParameter("lecSems"));
		String lecId = req.getParameter("lecId");	
			classVO.setLecSems(lecSems);
			classVO.setUserNo(userNo);
			classVO.setLecId(lecId);			
			session.setAttribute("classVO", classVO);				
			
			
			Map<String, Object> map = new HashMap<>();
			map.put("lecId", classVO.getLecId());
			List<LecqnaVO> qnaList = qnaService.retrieveUnanswerd(map);
		
		log.info("lecId:{}",classVO.getLecId());
		LecHomeworkVO homework = hwService.retrieveMainHW(lecId);
		List<Map<String, Object>> stuList = service.retrieveOneLecStus(lecId);
		
		
		model.addAttribute("stuList", stuList);
		model.addAttribute("homework", homework);
		model.addAttribute("lecMap", service.retrieveOneLec(classVO.getLecId()));
		model.addAttribute("lecId", classVO.getLecId());
		model.addAttribute("lecSems",classVO.getLecSems());
		model.addAttribute("qnaList",qnaList);
	
		//session에 lecSems, userNo, lecId를 넣어 관리함.

		//2. 페이징처리		
		return "lecBoard/lecBoardMain";
	}
}
