package kr.or.ddit.attendance.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.attendance.service.ProfessorAttendanceService;
import kr.or.ddit.vo.AttabsEnrollVO;
import kr.or.ddit.vo.LectureVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.SemsVO;
import kr.or.ddit.vo.security.MemberVOWrapper;

@Controller
@RequestMapping("/enrollAttabs")
public class ProfessorAttabsProcessController {
	
	@Inject
	ProfessorAttendanceService service;
	
	/**
	 * 교수 출결등록 기본페이지 이동(기본데이터 : 강의리스트)
	 * @param model
	 * @param authentication
	 * @return
	 */
	@RequestMapping("attabsObjectionForm.do")
	public String attabsObjectionForm(Model model, Authentication authentication
			, HttpSession session) {
		
		MemberVO loginProVo = ((MemberVOWrapper) authentication.getPrincipal()).getRealUser();
		SemsVO semsVo = (SemsVO) session.getAttribute("semsVo");
		Map<String, Integer> paramMap = new HashMap<String, Integer>();
		
		paramMap.put("lecSems", semsVo.getThisSems());
		paramMap.put("userNo", loginProVo.getUserNo());
		
		List<LectureVO> proLectureList = service.retrieveProLectureList(paramMap);
		
		model.addAttribute("proLectureList", proLectureList);
		
		return "attendance/professorAttabsInsert";
	}
	
	/**
	 * 강의별 강의요일에 맞는 날짜 데이터 리스트
	 * @param model
	 * @param lecId
	 * @return
	 */
	@RequestMapping("attabsDateListData.do")
	public String attabsDateListData(Model model, @RequestParam String lecId) {
		
		//개강날짜와 종강날짜는 xml 하드코딩된 상태
		List<String> dateList = service.retrieveLecDateList(lecId);
		model.addAttribute("dateList", dateList);
		
		return "jsonView";
	}
	
	/**
	 * 강의를 선택하면 해당 강의 수강하는 학생 리스트
	 * @param model
	 * @param lecId
	 * @param attabsDate
	 * @param planNo
	 * @return
	 */
	@RequestMapping("attabsStudentListData.do")
	public String attabsStudentListData(Model model, @RequestParam String lecId
			,@RequestParam String attabsDate, @RequestParam Integer planNo
			, HttpSession session) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		SemsVO semsVo = (SemsVO) session.getAttribute("semsVo");
		paramMap.put("lecSems", semsVo.getThisSems());
		paramMap.put("lecId", lecId);
		paramMap.put("attabsDate", attabsDate);
		paramMap.put("planNo", planNo);
		
		List<AttabsEnrollVO> studentList = service.retrieveAttabsStudentList(paramMap);
		model.addAttribute("studentList", studentList);
		
		return "jsonView";
	}
	
	@RequestMapping("attabsInsertOrUpdate.do")
	public String attabsInsertOrUpdate(Model model, @RequestParam Map<String, Object> parameters) {
		int resCnt = 0;
		resCnt = service.modifyOrCreateAttabs(parameters);
		if(resCnt > 0) {
		}else {
			
		}
		return "jsonView";
	}
	
	@RequestMapping("attabsInsertOrUpdateOne.do")
	public String attabsInsertOrUpdateOne(Model model, @ModelAttribute AttabsEnrollVO paramVo) {
		int resCnt = 0;
		resCnt = service.modifyOrCreateAttabsOne(paramVo);
		if(resCnt > 0) {
		}else {
			
		}
		return "jsonView";
	}
	
	
	@RequestMapping("attabsObjectionList.do")
	public String attabsObjectionList() {
		
		return "attendance/professorArrabsApplyList";
	}
}




