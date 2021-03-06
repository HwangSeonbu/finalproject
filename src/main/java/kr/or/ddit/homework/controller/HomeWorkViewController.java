package kr.or.ddit.homework.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.apache.http.HttpResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.homework.service.HomeworkService;
import kr.or.ddit.lecboard.service.LecBoardService;
import kr.or.ddit.vo.AttchVO;
import kr.or.ddit.vo.ClassVO;
import kr.or.ddit.vo.HwkVO;
import kr.or.ddit.vo.LecHomeworkVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.security.MemberVOWrapper;
import lombok.extern.slf4j.Slf4j;
/**과제 게시판 상세 페이지 컨트롤러
 * @author 황선부
 * @since 2022. 5. 24.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2022. 5. 24.      황선부       최초작성
 * Copyright (c) 2022 by DDIT All right reserved
 * </pre>
 */
@Slf4j
@RequestMapping("/homework")
@Controller
public class HomeWorkViewController {
	@Autowired
	private HomeworkService service;
	@Inject
	private LecBoardService lecService;
	
	@GetMapping("{lechwkNo}")
	public String hwView(
			@PathVariable int lechwkNo
			,Model model
			,Authentication authentication
			,HttpSession session
			) {
		log.info("lechwkNo==========>>>>>{}",lechwkNo);
		LecHomeworkVO hw = service.retrieveHomework(lechwkNo);
		log.info("homework===========>>>>{}",hw);
		model.addAttribute("homework", hw);
		MemberVO member = ((MemberVOWrapper)authentication.getPrincipal()).getRealUser();
		String role = member.getMemRole();
	
		if(role.equals("ROLE_STUDENT")) {
			int userNo = member.getUserNo();
			HwkVO hwk = new HwkVO();
			hwk.setStuNo(userNo);
			hwk.setLechwkNo(lechwkNo);
			HwkVO hwk2 = service.retreiveHwOneByStuNo(hwk);
			model.addAttribute("hwk", hwk2);		
		}
		ClassVO classVO = (ClassVO) session.getAttribute("classVO");
		
		
		model.addAttribute("lecId", classVO.getLecId());
		model.addAttribute("lecSems",classVO.getLecSems());
		
		return "homework/hwView";
	}
	
	@GetMapping("{lechwkNo}/attach/{attchNo}")
	public String downLoad(@PathVariable int attchNo, Model model) {
		AttchVO attach = service.downloadAttach(attchNo);
		
		model.addAttribute("attch", attach);
		
		
		return "boardDownloadView";
	}
	
	@GetMapping("{lechwkNo}/stu/{hwkNo}")
	public String hwView(
			@PathVariable int lechwkNo
			,@PathVariable int hwkNo
			,Model model
//			,HttpResponse resp
			) {
		//제출된 과제 정보
		HwkVO hwk = service.retrieveHwOne(hwkNo);
		//해야될 과제 정보
		LecHomeworkVO hw = service.retrieveHomework(lechwkNo);
		
		
		
		model.addAttribute("hwk", hwk);
		model.addAttribute("hw", hw);
		
//		resp.setHeader("X-Frame-Options", "SAMEORIGIN");
		
		log.info("hw=======>{}",hw);
		return "/homework/hwOneView";
	}
	
	@GetMapping("hwAttach/{attchNo}")
	public String hwAttachDownload(@PathVariable("attchNo") int attchNo
			,Model model
			) {
		AttchVO attach = service.downloadAttach(attchNo);
		
		model.addAttribute("attch", attach);
		
		
		return "homeworkDownloadView";
	}
}
