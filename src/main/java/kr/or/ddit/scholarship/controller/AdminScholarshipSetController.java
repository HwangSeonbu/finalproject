package kr.or.ddit.scholarship.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.grade.service.GradeService;
import kr.or.ddit.scholarship.service.AdminScholarshipService;
import kr.or.ddit.vo.AdminScholarshipVO;
import kr.or.ddit.vo.PagingVO;
import kr.or.ddit.vo.RequestVO;
import kr.or.ddit.vo.SimpleSearchVO;
import lombok.extern.slf4j.Slf4j;

/**
 * 관리자 메뉴 : 성적우수장학생 선정, 기타장학생선정
 * @author 김재웅
 * @since 2022. 4. 28.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>0
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     	--------    ----------------------
 * 2022. 4. 28.      김재웅  		     최초작성
 * 2022. 5. 10.		  고성식		     관리자 성적우수 장학생 선정
 * Copyright (c) 2022 by DDIT All right reserved
 * </pre>
 */
@Controller
@RequestMapping("/setScholar")
@Slf4j
public class AdminScholarshipSetController {

	@Inject
	private AdminScholarshipService service;
	
	@Inject
	private GradeService Gservice;
	
	@RequestMapping("setCreditScholarStudent.do")
	public String setCreditScholarStudent(Model model) {
		
		// 수강학기 리스트 조회( 성적입력 코드 활용 > 해당 로직 변경 시 확인 필요 )
		List<String> semsdata = Gservice.retrieveSemsdata();
		model.addAttribute("semsdata", semsdata);
		
		return "scholarship/adminSetCrdtScholar";
	}
	
	@RequestMapping(value="/setCreditScholarStudentList.do")
	public String setCreditScholarStudentList(
			@RequestParam(value="page", required=false, defaultValue="1") int currentPage 
			, @RequestParam(value="lecSems", required=false) String lecSems
			, @ModelAttribute("simpleCondition") SimpleSearchVO simpleCondition
			, Model model	
	) {
		log.info("setCreditScholarStudentList 도착**************************************");
		PagingVO<AdminScholarshipVO> paging = new PagingVO<>(10, 10);
		paging.setCurrentPage(currentPage);
		paging.setSimpleCondition(simpleCondition);
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("paging", paging);
		param.put("lecSems", lecSems);
		
		int totalCount = service.retrieveScholarshipListTotalCount(param);
		paging.setTotalRecord(totalCount);
		
		List<AdminScholarshipVO> list = service.retrieveScholarshipList(param);
		
		model.addAttribute("list", list);
		model.addAttribute("paging", paging);
		
		return "jsonView";
	}
	
	
	@RequestMapping(value="adminAppointScholar.do", produces=MediaType.APPLICATION_JSON_VALUE)
	public String adminAppointScholar(@RequestBody List<RequestVO> list,Model model) throws Exception {
		
		service.createScholarshipStu(list);
		
		return "jsonView";
	}
	
	
	@RequestMapping("setExtraScholarStrudent.do")
	public String setExtraScholarStrudent(Model model) {
		
		List<String> semsdata = Gservice.retrieveSemsdata();
		model.addAttribute("semsdata", semsdata);
		
		return "scholarship/adminSetExtScholar";
	}
	@RequestMapping(value="/setCreditEtcScholarStudentList.do")
	public String setCreditEtcScholarStudentList(
			@RequestParam(value="page", required=false, defaultValue="1") int currentPage 
			, @RequestParam(value="semsNo", required=false) String semsNo
			, @ModelAttribute("simpleCondition") SimpleSearchVO simpleCondition
			, Model model	
	) {
		log.info("setCreditScholarStudentList 도착**************************************");
		PagingVO<AdminScholarshipVO> paging = new PagingVO<>(10, 10);
		paging.setCurrentPage(currentPage);
		paging.setSimpleCondition(simpleCondition);
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("paging", paging);
		param.put("semsNo", semsNo);
		
		int totalCount = service.retrieveTotalEtcScholarshipListCount(param);
		paging.setTotalRecord(totalCount);
		
		List<AdminScholarshipVO> list = service.retrieveEtcScholarshipList(param);
		
		model.addAttribute("list", list);
		model.addAttribute("paging", paging);
		
		return "jsonView";
	}
	
	@RequestMapping(value="/modifyEtcScholarshipSts.do", produces=MediaType.APPLICATION_JSON_VALUE)
	public String modifyEtcScholarshipSts(@RequestBody List<AdminScholarshipVO> list) throws Exception {
		
		service.updateEtcScholarship(list);
		
		return "jsonView";
	}
	
	@RequestMapping(value="/modifyStuReferEtcScholarshipTarget.do", produces=MediaType.APPLICATION_JSON_VALUE)
	public String modifyStuReferEtcScholarshipTarget(@RequestBody List<AdminScholarshipVO> list) throws Exception{
		
		service.referEtcScholarship(list);
		
		return "jsonView";
	}
	
}
