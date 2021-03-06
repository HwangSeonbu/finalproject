package kr.or.ddit.lecture.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.lecture.service.ProfessorLectureService;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.ProfessorLectureVO;
import kr.or.ddit.vo.ProfessorVO;
import kr.or.ddit.vo.security.MemberVOWrapper;

/**
 * 교수의 당학기 진행강의 시간표, 진행강의현황 목록조회
 * @author 김재웅
 * @since 2022. 4. 28.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2022. 4. 28.      김재웅       최초작성
 * Copyright (c) 2022 by DDIT All right reserved
 * </pre>
 */
@Controller
@RequestMapping("/lecView")
public class LectureRetrieveController {

	@Inject
	ProfessorLectureService service;
	
	@RequestMapping("lectureTimeTableView.do")
	public String lectureTimeTableView() {
		
		return "lecture/professorLecTimeTable";
	}
	
	@RequestMapping("lectureTimeTableDataView.do")
	public String lectureTimeTableDataView(Model model, Authentication authentication) {
		MemberVO loginProVo = ((MemberVOWrapper) authentication.getPrincipal()).getRealUser();
		ProfessorVO vo = new ProfessorVO();
		vo.setProNo(loginProVo.getUserNo());
		
		List<ProfessorLectureVO> proLectureList = service.retrieveProLectureTimeTable(vo);
		
		model.addAttribute("proLectureList", proLectureList);
		return "jsonView";
	}
	
	
	@RequestMapping("lectureList.do")
	public String lectureList() {
		
		return "lecture/professorLecList";
	}
	
	@RequestMapping("lectureDataList.do")
	public String lectureDataList(Model model
			,Authentication authentication) {
		MemberVO member = ((MemberVOWrapper)authentication.getPrincipal()).getRealUser();
		int userNo = member.getUserNo();
		
		ProfessorVO vo = new ProfessorVO();
		
		vo.setProNo(userNo);
		List<ProfessorLectureVO> proLectureList = service.retrieveProLectureList(vo);
		
		model.addAttribute("proLectureList", proLectureList);
		return "jsonView";
	}
}










