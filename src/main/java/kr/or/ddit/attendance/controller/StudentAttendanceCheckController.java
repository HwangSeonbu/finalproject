package kr.or.ddit.attendance.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.commons.collections.MapUtils;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.attendance.service.AttendanceService;
import kr.or.ddit.grade.service.GradeService;
import kr.or.ddit.vo.AttendanceCountVO;
import kr.or.ddit.vo.LecturePeriodVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.StudentVO;
import kr.or.ddit.vo.SubjectVO;
import kr.or.ddit.vo.security.MemberVOWrapper;
import lombok.extern.slf4j.Slf4j;

/**
 * 학생이 로그인 하여 자신이 수강 중인 과목을 조회하여 해당 과목의 출석을 조회하고 대시보드로 나타느내는 컨트롤러
 * @author 주창규
 * @since 2022. 4. 26.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2022. 4. 26.      주창규       최초작성
 * 2022. 5. 06.      주창규    대시보드 기능 추가
 * 
 * Copyright (c) 2022 by DDIT All right reserved
 * </pre>
 */
@Controller
@Slf4j
@RequestMapping("/studentAttendance")
public class StudentAttendanceCheckController {
   
   @Inject
   private AttendanceService Aservice;
   
   @Inject
	private GradeService gService;
   
   //해당 학기에 대한 수강 중인 과목들을 조회하여  출석을 조회
   @RequestMapping("studentAttendanceList")
   public String studentAttendanceList(
         Model model
         , Authentication authentication
   ){
      MemberVO authMember = ((MemberVOWrapper)authentication.getPrincipal()).getRealUser();
      int userNo = authMember.getUserNo();
      
      StudentVO student =  Aservice.retrieveStudent(userNo); 
      
      student = Aservice.retrieveLecture(student);
      
      model.addAttribute("student", student);
      
      return "attendance/studentAttendanceList";
   }
   
   
 //년도와 학기를 선택 후 해당 정보를 리턴
 	@RequestMapping("semsdataForm")
 	public String gradeUpdate(
 			 Model model
 	){
 		List<String> semsdata = gService.retrieveSemsdata();
 		model.addAttribute("semsdata", semsdata);
 		return "jsonView";
 	}
   
 	//해당 학기에 대한 수강 중인 과목들을 조회하여  출석을 조회 (조회페이지)
    @RequestMapping("attendanceList")
    public String attendanceList(
    		 Model model
             , Authentication authentication
             , @RequestParam(value ="semsdata") int lecSems
       ){
          MemberVO authMember = ((MemberVOWrapper)authentication.getPrincipal()).getRealUser();
          int userNo = authMember.getUserNo();
         
          StudentVO student =  Aservice.retrieveStudent(userNo); 
          student.setLecSems(lecSems);
          student = Aservice.retrieveLecture(student);
          model.addAttribute("student", student);
          
       return "jsonView";
    }
 	
  //해당 학기에 대한 수강 중인 과목들을 조회하여  출석을 조회 (조회페이지)(대쉬보드)
    @RequestMapping("lectureList")
    public String lectureList(
    		 Model model
             , Authentication authentication
             , @RequestParam(value ="attLecId") String lecId
             , @RequestParam(value ="attLecNm") String attLecNm
       ){
    	
    	MemberVO authMember = ((MemberVOWrapper)authentication.getPrincipal()).getRealUser();
    	int userNo = authMember.getUserNo();
        
        Map<String,Object> map =new HashMap<>();
        map.put("userNo", userNo);
        map.put("lecId", lecId);
        
      Map<String, Object> attLecture = Aservice.selectStudentAttendanceCountMap(map);
      
      // 조회된 Query 정보가 null 일 경우 화면에 표시할 더미 데이터를 만들어줌.
      if (MapUtils.isEmpty(attLecture)) {
    	  attLecture = new HashMap<>();
    	  attLecture.put("TOTALCOUNT", "-");
    	  attLecture.put("ATTENDANCECOUNT", "-");
    	  attLecture.put("ABSENTCOUNT", "-");
    	  attLecture.put("EARLYLEAVECOUNT", "-");
    	  attLecture.put("TARDINESSCOUNT", "-");
    	  attLecture.put("LEC_NAME", attLecNm);
      }
      
//      int dd = Integer.parseInt("sdadsf");  // 에러 발생 테스트
      log.info("===========================attLecture{}",attLecture);
      model.addAttribute("attLecture",attLecture);
        
       return "jsonView";
    }
   
   // 수강 중인 과목들을 조회하여 출석상황을 대시보드로 조회
   @RequestMapping("studentAttendanceDashboard")
   public String studentAttendanceDashboard(
         Model model
         , Authentication authentication
   ){
      MemberVO authMember = ((MemberVOWrapper)authentication.getPrincipal()).getRealUser();
      int userNo = authMember.getUserNo();
      
      StudentVO student =  Aservice.retrieveStudent(userNo); 
      student = Aservice.retrieveLecture(student);
      
      model.addAttribute("student", student);
      return "attendance/studentAttabsDashboard";
   }
   
// 수강 중인 과목들을 조회하여 출석상황을 대시보드로 조회(ajax)
   @RequestMapping("attendanceListAjax")
   public String attendanceListAjax(
   		 Model model
            , Authentication authentication
            , @RequestParam(value ="semsdata") int lecSems
      ){
         MemberVO authMember = ((MemberVOWrapper)authentication.getPrincipal()).getRealUser();
         int userNo = authMember.getUserNo();
        
         StudentVO student =  Aservice.retrieveStudent(userNo); 
         student.setLecSems(lecSems);
         student = Aservice.retrieveLecture(student);
         model.addAttribute("student", student);
         
      return "jsonView";
   }
   
}