package kr.or.ddit.commons.controller;

import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.vo.TempFinalMenuVO;
import kr.or.ddit.vo.TempMenuVO;
import kr.or.ddit.vo.TempSideMenuVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class MainProfessorController {
	
	List<TempSideMenuVO> sideMenuList;
	private static TempSideMenuVO sidemenu1_1;
	private static TempSideMenuVO sidemenu1_2;
	private static TempSideMenuVO sidemenu1_3;
	private static TempSideMenuVO sidemenu1_4;
	
	private static TempSideMenuVO sidemenu2_1;
	private static TempSideMenuVO sidemenu2_2;
	private static TempSideMenuVO sidemenu2_3;
	
	private static TempSideMenuVO sidemenu3_1;
	private static TempSideMenuVO sidemenu3_2;
	private static TempSideMenuVO sidemenu3_3;
	
	private static TempSideMenuVO sidemenu4_1;
	private static TempSideMenuVO sidemenu4_2;
	
	private static TempSideMenuVO sidemenu5_1;
	
	private static TempSideMenuVO sidemenu6_1;
	
	static {
		//1번메뉴
		sidemenu1_1 = new TempSideMenuVO("강의시간표", "lecView/lectureTimeTableView.do");
		sidemenu1_2 = new TempSideMenuVO("진행강의현황조회", "lecView/lectureList.do");
		sidemenu1_3 = new TempSideMenuVO("강의게시판", "lecBoard/tempLectureBoardView.do");
		TempFinalMenuVO finalmenu1_4_1 = new TempFinalMenuVO("강의계획서작성", "lecPlan/LecturePlanForm.do");
		TempFinalMenuVO finalmenu1_4_2 = new TempFinalMenuVO("강의계획신청현황", "lecPlan/LecturePlanList.do");
		List<TempFinalMenuVO> finalmenuList1_4 = 
				Arrays.asList(finalmenu1_4_1, finalmenu1_4_2);
		sidemenu1_4 = new TempSideMenuVO("강의계획관리", finalmenuList1_4);
		
		//2번메뉴
		sidemenu2_1 = new TempSideMenuVO("성적처리기준관리", "stdScore/StandardScoreForm.do");
		TempFinalMenuVO finalmenu2_2_1 = new TempFinalMenuVO("중간고사성적입력", "testScore/middleScoreForm.do");
		TempFinalMenuVO finalmenu2_2_2 = new TempFinalMenuVO("기말고사성적입력", "testScore/finalScoreForm.do");
		TempFinalMenuVO finalmenu2_2_3 = new TempFinalMenuVO("성적입력현황조회", "saveScore/saveScoreList.do");
		TempFinalMenuVO finalmenu2_2_4 = new TempFinalMenuVO("최종성적입력", "totalScore/totalScoreForm.do");
		List<TempFinalMenuVO> finalmenuList2_2 = 
				Arrays.asList(finalmenu2_2_1, finalmenu2_2_2, finalmenu2_2_3, finalmenu2_2_4);
		sidemenu2_2 = new TempSideMenuVO("시험성적입력", finalmenuList2_2);
		sidemenu2_3 = new TempSideMenuVO("성적이의신청현황", "ojtView/objectionScoreList.do");
		
		//3번메뉴
		TempFinalMenuVO finalmenu3_1_1 = new TempFinalMenuVO("출석부", "templateAttabs/templateView.do");
		TempFinalMenuVO finalmenu3_1_2 = new TempFinalMenuVO("학생별출결현황조회", "proAttabs/attabsList.do");
		List<TempFinalMenuVO> finalmenuList3_1 = 
				Arrays.asList(finalmenu3_1_1, finalmenu3_1_2);
		sidemenu3_1 = new TempSideMenuVO("출결현황조회", finalmenuList3_1);;
		sidemenu3_2 = new TempSideMenuVO("출결등록관리", "enrollAttabs/attabsObjectionForm.do");
		sidemenu3_3 = new TempSideMenuVO("출석인정신청현황", "enrollAttabs/attabsObjectionList.do");
		
		//4번메뉴
		sidemenu4_1 = new TempSideMenuVO("상담신청관리", "respCounsel/requestView");
		sidemenu4_2 = new TempSideMenuVO("상담완료현황", "respCounsel/endView");
		
		//5번메뉴
		sidemenu5_1 = new TempSideMenuVO("개인자료실", "archive/go");
		
		//6번메뉴
		TempFinalMenuVO finalmenu6_1_1 = new TempFinalMenuVO("강의실배정처리", "roomDetailSet/detailRoomForm.do");
		TempFinalMenuVO finalmenu6_1_2 = new TempFinalMenuVO("배정결과제출", "roomDetailSet/roomResultList.do");
		List<TempFinalMenuVO> finalmenuList6_1 = 
				Arrays.asList(finalmenu6_1_1, finalmenu6_1_2);
		sidemenu6_1 = new TempSideMenuVO("강의실배정", finalmenuList6_1);
	}

	@RequestMapping("/professorMain.do")
	public String topMenuHandler(Model model, HttpSession session){
		log.info("topMenuHandler 도착 ======================================");
		session.removeAttribute("sideMenuListSession");
		
		session.setAttribute("userType", "교수");
		session.setAttribute("userName", "김교수");
		session.setAttribute("userDepartment", "컴퓨터공학과");
		session.setAttribute("userGrade", "1학년");
		
		TempMenuVO topMenu1 = new TempMenuVO("강의관리", 1);
		TempMenuVO topMenu2 = new TempMenuVO("성적관리", 2);
		TempMenuVO topMenu3 = new TempMenuVO("출결관리", 3);
		TempMenuVO topMenu4 = new TempMenuVO("상담관리", 4);
		TempMenuVO topMenu5 = new TempMenuVO("개인자료실", 5);
		TempMenuVO topMenu6 = new TempMenuVO("강의실배정관리", 6);
		
		List<TempMenuVO> topMenuList = Arrays.asList(topMenu1, topMenu2, topMenu3,
				topMenu4, topMenu5, topMenu6);
		
		session.setAttribute("topMenuList", topMenuList);
		return "temp/proMainPage";
	}
	
	@RequestMapping("temp/professorSide.do")
	public String leftMenuHandler(
			@RequestParam String menuNo
			, Model model, HttpSession session) {
		int menuNumber = Integer.parseInt(menuNo);
		
		log.info("leftMenuHandler가 받은 파라미터 ===>{}", menuNumber);
		
		switch (menuNumber) {
		case 1: sideMenuList = Arrays.asList(sidemenu1_1, sidemenu1_2
					, sidemenu1_3, sidemenu1_4);
			break;
		case 2: sideMenuList = Arrays.asList(sidemenu2_1, sidemenu2_2, sidemenu2_3);
			break;
		case 3: sideMenuList = Arrays.asList(sidemenu3_1, sidemenu3_2, sidemenu3_3);
			break;
		case 4: sideMenuList = Arrays.asList(sidemenu4_1, sidemenu4_2);
			break;
		case 5: sideMenuList = Arrays.asList(sidemenu5_1);
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


















