package kr.or.ddit.commons.controller;

import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.TempFinalMenuVO;
import kr.or.ddit.vo.TempMenuVO;
import kr.or.ddit.vo.TempSideMenuVO;
import kr.or.ddit.vo.security.MemberVOWrapper;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class MainStudentController {
	
	List<TempSideMenuVO> sideMenuList;
	private static TempSideMenuVO sidemenu1_1;
	private static TempSideMenuVO sidemenu1_2;
	
	private static TempSideMenuVO sidemenu2_1;
	private static TempSideMenuVO sidemenu2_2;
	private static TempSideMenuVO sidemenu2_3;
	private static TempSideMenuVO sidemenu2_4;
	
	private static TempSideMenuVO sidemenu3_1;
	private static TempSideMenuVO sidemenu3_2;
	
	private static TempSideMenuVO sidemenu4_1;
	private static TempSideMenuVO sidemenu4_2;
	private static TempSideMenuVO sidemenu4_3;
	
	private static TempSideMenuVO sidemenu5_1;
	private static TempSideMenuVO sidemenu5_2;
	private static TempSideMenuVO sidemenu5_3;
	
	private static TempSideMenuVO sidemenu6_1;
//	private static TempSideMenuVO sidemenu6_2;
	
	static {
		//1번메뉴
		TempFinalMenuVO finalmenu1_1_1 = new TempFinalMenuVO("등록금고지서조회", "enr/enrollView.do");
		TempFinalMenuVO finalmenu1_1_2 = new TempFinalMenuVO("등록금납부현황", "enr/enrollPayList.do");
		List<TempFinalMenuVO> finalmenuList1_1 = Arrays.asList(finalmenu1_1_1, finalmenu1_1_2);
		sidemenu1_1 = new TempSideMenuVO("등록금관리", finalmenuList1_1);
		
		TempFinalMenuVO finalmenu1_2_1 = new TempFinalMenuVO("장학금안내", "scholarship/scholarInfo.do");
		TempFinalMenuVO finalmenu1_2_2 = new TempFinalMenuVO("장학생이력조회", "scholarship/scholarshipList.do");
		TempFinalMenuVO finalmenu1_2_3 = new TempFinalMenuVO("장학금신청", "applyScholar/scholarApplyForm.do");
		List<TempFinalMenuVO> finalmenuList1_2 = 
				Arrays.asList(finalmenu1_2_1, finalmenu1_2_2, finalmenu1_2_3);
		sidemenu1_2 = new TempSideMenuVO("장학금관리", finalmenuList1_2);
		
		//2번메뉴
		sidemenu2_1 = new TempSideMenuVO("수강시간표", "sugang/timeTableView.do");
		sidemenu2_2 = new TempSideMenuVO("수강현황조회", "sugang/sugangList.do");
		sidemenu2_3 = new TempSideMenuVO("강의게시판", "lecBoard/tempLectureBoardView.do");
		
		TempFinalMenuVO finalmenu2_4_1 = new TempFinalMenuVO("시간표미리보기", "sugang/preTimeTableView.do");
		TempFinalMenuVO finalmenu2_4_2 = new TempFinalMenuVO("수강신청", "lecture/view");
		List<TempFinalMenuVO> finalmenuList2_4 = 
				Arrays.asList(finalmenu2_4_1, finalmenu2_4_2);
		sidemenu2_4 = new TempSideMenuVO("수강신청", finalmenuList2_4);
		
		//3번메뉴
		TempFinalMenuVO finalmenu3_1_1 = new TempFinalMenuVO("나의출결대시보드", "studentAttendance/studentAttendanceDashboard");
		TempFinalMenuVO finalmenu3_1_2 = new TempFinalMenuVO("강의별출결현황조회", "studentAttendance/studentAttendanceList");
		List<TempFinalMenuVO> finalmenuList3_1 = 
				Arrays.asList(finalmenu3_1_1, finalmenu3_1_2);
		sidemenu3_1 = new TempSideMenuVO("출결현황조회", finalmenuList3_1);;
		
		TempFinalMenuVO finalmenu3_2_1 = new TempFinalMenuVO("강의별출석인정신청", "applyAttabs/attabsApplyForm.do");
		TempFinalMenuVO finalmenu3_2_2 = new TempFinalMenuVO("출석인정신청처리결과조회", "applyAttabs/attabsApplyList.do");
		List<TempFinalMenuVO> finalmenuList3_2 = 
				Arrays.asList(finalmenu3_2_1, finalmenu3_2_2);
		sidemenu3_2 = new TempSideMenuVO("출석인정신청", finalmenuList3_2);
		
		//4번메뉴
		TempFinalMenuVO finalmenu4_1_1 = new TempFinalMenuVO("종합성적조회", "stuScore/myScoreView.do");
		TempFinalMenuVO finalmenu4_1_2 = new TempFinalMenuVO("학기별최종성적조회", "stuScore/totalScoreList.do");
		List<TempFinalMenuVO> finalmenuList4_1 = 
				Arrays.asList(finalmenu4_1_1, finalmenu4_1_2);
		sidemenu4_1 = new TempSideMenuVO("성적조회", finalmenuList4_1);
		TempFinalMenuVO finalmenu4_2_1 = new TempFinalMenuVO("성적이의신청", "ojtScore/objectionScoreForm.do");
		TempFinalMenuVO finalmenu4_2_2 = new TempFinalMenuVO("이의신청결과조회", "ojtScore/objectionScoreResultList.do");
		List<TempFinalMenuVO> finalmenuList4_2 = 
				Arrays.asList(finalmenu4_2_1, finalmenu4_2_2);
		sidemenu4_2 = new TempSideMenuVO("성적이의신청", finalmenuList4_2);
		TempFinalMenuVO finalmenu4_3_1 = new TempFinalMenuVO("강의평가등록", "astEnroll/LectureEnrollForm.do");
		TempFinalMenuVO finalmenu4_3_2 = new TempFinalMenuVO("교수평가등록", "astEnroll/ProfessorEnrollForm.do");
		List<TempFinalMenuVO> finalmenuList4_3 = 
				Arrays.asList(finalmenu4_3_1, finalmenu4_3_2);
		sidemenu4_3 = new TempSideMenuVO("평가등록", finalmenuList4_3);
		
		//5번메뉴
		TempFinalMenuVO finalmenu5_1_1 = new TempFinalMenuVO("휴학신청", "schoolReq/leaveSchoolForm.do");
		TempFinalMenuVO finalmenu5_1_2 = new TempFinalMenuVO("휴학신청처리결과조회", "schoolReq/leaveSchoolList.do");
		List<TempFinalMenuVO> finalmenuList5_1 = 
				Arrays.asList(finalmenu5_1_1, finalmenu5_1_2);
		sidemenu5_1 = new TempSideMenuVO("휴학", finalmenuList5_1);
		sidemenu5_2 = new TempSideMenuVO("복학", "schoolReq/returnSchoolForm.do");
		TempFinalMenuVO finalmenu5_3_1 = new TempFinalMenuVO("졸업유예신청", "schoolReq/graduateDelayForm.do");
		TempFinalMenuVO finalmenu5_3_2 = new TempFinalMenuVO("졸업유예신청처리결과조회", "schoolRes/graduateDelayList.do");
		List<TempFinalMenuVO> finalmenuList5_3 = 
				Arrays.asList(finalmenu5_3_1, finalmenu5_3_2);
		sidemenu5_3 = new TempSideMenuVO("졸업", finalmenuList5_3);
		
		//6번메뉴
		sidemenu6_1 = new TempSideMenuVO("상담신청하기", "reqCounsel/view");
//		sidemenu6_2 = new TempSideMenuVO("상담신청결과조회", "temp/tempPage.do");
	}

	@RequestMapping("/studentMain.do")
	public String topMenuHandler(Model model, HttpSession session, Authentication authentication ){
		log.info("topMenuHandler 도착 ======================================");
		session.removeAttribute("sideMenuListSession");
		
		MemberVO authMember = ((MemberVOWrapper)authentication.getPrincipal()).getRealUser();
		authMember.getUserType();
//		session.setAttribute("userNo", 1);
//		session.setAttribute("userType", "학생");
//		session.setAttribute("userName", "민진홍");
//		session.setAttribute("userDepartment", "컴퓨터공학과");
//		session.setAttribute("userGrade", "1학년");
		
		TempMenuVO topMenu1 = new TempMenuVO("등록/장학", 1);
		TempMenuVO topMenu2 = new TempMenuVO("수강관리", 2);
		TempMenuVO topMenu3 = new TempMenuVO("출결관리", 3);
		TempMenuVO topMenu4 = new TempMenuVO("성적/평가", 4);
		TempMenuVO topMenu5 = new TempMenuVO("학적관리", 5);
		TempMenuVO topMenu6 = new TempMenuVO("상담관리", 6);
		
		List<TempMenuVO> topMenuList = Arrays.asList(topMenu1, topMenu2, topMenu3,
				topMenu4, topMenu5, topMenu6);
		
		session.setAttribute("topMenuList", topMenuList);
		return "temp/mainPage";
	}
	
	@RequestMapping("temp/studentSide.do")
	public String leftMenuHandler(
			@RequestParam String menuNo
			, Model model, HttpSession session) {
		int menuNumber = Integer.parseInt(menuNo);
		
		log.info("leftMenuHandler가 받은 파라미터 ===>{}", menuNumber);
		
		switch (menuNumber) {
		case 1: sideMenuList = Arrays.asList(sidemenu1_1, sidemenu1_2);
			break;
		case 2: sideMenuList = Arrays.asList(sidemenu2_1, sidemenu2_2
					, sidemenu2_3, sidemenu2_4);
			break;
		case 3: sideMenuList = Arrays.asList(sidemenu3_1, sidemenu3_2);
			break;
		case 4: sideMenuList = Arrays.asList(sidemenu4_1, sidemenu4_2, sidemenu4_3);
			break;
		case 5: sideMenuList = Arrays.asList(sidemenu5_1, sidemenu5_2, sidemenu5_3);
			break;
		case 6: sideMenuList = Arrays.asList(sidemenu6_1);
			break;
		default: sideMenuList = null;
			break;
		}
		session.setAttribute("sideMenuListSession", sideMenuList);
		model.addAttribute("sideMenuList", sideMenuList);
		
		return "jsonView";
	}

//	@RequestMapping("temp/tempPage.do")
//	public String tempView() {
//		return "temp/tempView";
//	}
}


















