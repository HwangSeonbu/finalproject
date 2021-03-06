package kr.or.ddit.ast.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.ast.service.AssessmentService;
import kr.or.ddit.vo.AstResultVO;
import kr.or.ddit.vo.AstVO;
import kr.or.ddit.vo.OrderVO;
import kr.or.ddit.vo.SemsVO;

/**
 * 관리자가 평가결과를 조회할 수 있는 컨트롤러
 * @author 작성자명
 * @since 2022. 4. 29.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2022. 4. 29.      김재웅       최초작성
 * Copyright (c) 2022 by DDIT All right reserved
 * </pre>
 */
@Controller
@RequestMapping("/astResult")
public class AssesmentResultRetrieveController {

	@Inject
	AssessmentService service;
	
	@RequestMapping("AstResultList.do")
	public String AstResultList() {
		return "admin/adminAstCompleteList";
	}
	
	
	@RequestMapping("proResData.do")
	public String proResData(Model model
			, @RequestParam(value="exceptRate", required=false, defaultValue="0") int exceptRate
			, @RequestParam(value="orderBy", required=false) String orderBy) {
		OrderVO vo = new OrderVO();
		vo.setExceptRate(exceptRate);
		vo.setOrderBy(orderBy);
		
		List<AstResultVO> resList = service.retrieveProAstResultList(vo);
		model.addAttribute("resList", resList);
		return "jsonView";
	}
	
	@RequestMapping("lecResData.do")
	public String lecResData(Model model
			, @RequestParam(value="exceptRate", required=false, defaultValue="0") int exceptRate
			, @RequestParam(value="orderBy", required=false) String orderBy) {
		OrderVO vo = new OrderVO();
		vo.setExceptRate(exceptRate);
		vo.setOrderBy(orderBy);
		
		List<AstResultVO> resList = service.retrieveLecAstResultList(vo);
		model.addAttribute("resList", resList);
		return "jsonView";
	}
	
	
	
	@RequestMapping("ProfessorAstResultList.do")
	public String ProfessorAstResultList(Model model) {
		
		return "admin/adminProfessorAstResultList";
	}
	
	@RequestMapping("ProfessorAstResultData.do")
	public String ProfessorAstResultData(Model model
			, @RequestParam(value="exceptRate", required=false, defaultValue="0") int exceptRate
			, @RequestParam(value="orderBy", required=false) String orderBy) {
		OrderVO vo = new OrderVO();
		vo.setExceptRate(exceptRate);
		vo.setOrderBy(orderBy);
		List<AstResultVO> compList = service.retrieveProAstCompResult(vo);
		model.addAttribute("compList", compList);
		
		return "jsonView";
	}
	@RequestMapping("ProfessorDetailResultData.do")
	public String ProfessorDetailResultData(Model model, HttpSession session
				, @RequestParam Integer proNo) {
		SemsVO semsVo = (SemsVO) session.getAttribute("semsVo");
		int lecSems = semsVo.getThisSems();
		
		AstVO vo = new AstVO();
		vo.setProNo(proNo);
		vo.setLecSems(lecSems);
		
		vo = service.retrieveProAstDetailResult(vo);
		model.addAttribute("astVo", vo);
		
		return "jsonView";
	}
	
	
	
	
	
	@RequestMapping("LectureAstResultList.do")
	public String LectureAstResultList() {
	
		return "admin/adminLectureAstResultList";
	}
	
	@RequestMapping("LectureAstResultData.do")
	public String LectureAstResultData(Model model
			, @RequestParam(value="exceptRate", required=false, defaultValue="0") int exceptRate
			, @RequestParam(value="orderBy", required=false) String orderBy) {
		OrderVO vo = new OrderVO();
		vo.setExceptRate(exceptRate);
		vo.setOrderBy(orderBy);
		
		List<AstResultVO> compList = service.retrieveLecAstCompResult(vo);
		model.addAttribute("compList", compList);
		
		return "jsonView";
	}
	
	@RequestMapping("LectureDetailResultData.do")
	public String LectureDetailResultData(Model model, HttpSession session
				, @RequestParam String lecId) {
		SemsVO semsVo = (SemsVO) session.getAttribute("semsVo");
		int lecSems = semsVo.getThisSems();
		
		AstVO vo = new AstVO();
		vo.setLecId(lecId);
		vo.setLecSems(lecSems);
		
		vo = service.retrieveLecAstDetailResult(vo);
		model.addAttribute("astVo", vo);
		
		return "jsonView";
	}
}














