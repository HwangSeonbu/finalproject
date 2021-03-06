package kr.or.ddit.commons.controller;

import java.util.Iterator;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.ServletContextEvent;
import javax.servlet.http.HttpSession;

import org.springframework.context.ApplicationEvent;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.commons.listener.CommandVO;
import kr.or.ddit.commons.service.MainInformationService;
import kr.or.ddit.commons.service.MenuService;
import kr.or.ddit.commons.service.MyPageService;
import kr.or.ddit.commons.service.MyPageServiceImpl;
import kr.or.ddit.stomp.MessageType;
import kr.or.ddit.stomp.MessageVO;
import kr.or.ddit.utils.PasswordUtils;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.MenuSideVO;
import kr.or.ddit.vo.MenuTopVO;
import kr.or.ddit.vo.NoticeBoardVO;
import kr.or.ddit.vo.SemsVO;
import kr.or.ddit.vo.security.MemberVOWrapper;
import lombok.extern.slf4j.Slf4j;
import oracle.net.aso.p;

/**
 * 
 * @author 민진홍
 * @since 2022. 5. 13.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2022. 5. 13.      민진홍       메뉴
 * Copyright (c) 2022 by DDIT All right reserved
 * </pre>
 */
@Slf4j
@Controller
public class MainController {
	@Inject
	private ApplicationEventPublisher eventPublisher;
	
	@Inject
	private MenuService service;
	
	@Inject
	private MainInformationService infoService;
	
	@Inject
	private PasswordEncoder passwordEncoder;
	
	@Inject
	private MyPageService myPageService;
	

	public static class Testevent extends ApplicationEvent{

		public Testevent(CommandVO<?> source) {
			super(source);
			
		}
		
	}
	
	@GetMapping("/main.do")
	public String mainPageView(Model model,Authentication authentication, HttpSession session,RedirectAttributes redirectAttributes) {
		MemberVO authMember = ((MemberVOWrapper)authentication.getPrincipal()).getRealUser();
		session.removeAttribute("nowTopMenu");
		session.setAttribute("menuTop", "");
		if(passwordEncoder.matches(authMember.getUserReg1(), authMember.getUserPass())) {
			redirectAttributes.addFlashAttribute("firstLoginMessage","최초로그인, 비밀번호 변경");
			return "redirect:/myPage";
		}
		String userType = authMember.getUserType();
		if(session.getAttribute("topMenuList") == null) {
			List<MenuTopVO> menuList = service.retrieveTopMenuList();
			model.addAttribute("topMenuList",menuList);
			session.setAttribute("topMenuList",menuList);
		}
		
		//=========================================================================
		MessageVO messagevo = MessageVO.builder()
				.data(authMember).sender("로그인")
				.data(authMember)
				.messageType(MessageType.LOGIN)
				.message("로그인했용!!!")
				.build();
		Testevent event =  new Testevent(new CommandVO<MessageVO>(messagevo, "/topic/echoed"));
		eventPublisher.publishEvent(event);
				//=========================================================================
				
		SemsVO semsVo = infoService.retrieveSemsData();
		// 학기 되돌리기
		/*
		semsVo.setPrevSems(201902);
		semsVo.setThisSems(202001);
		semsVo.setNextSems(202002);
		*/
		session.setAttribute("semsVo", semsVo);
		
		if(userType.equals("학사관리자")) {
			return "temp/adminMainPage";
		}else if(userType.equals("교수")) {
			return "temp/proMainPage";
		}else if(userType.equals("학생")) {
			return "temp/mainPage";
		}
		return "/login/loginForm.do"; 
	}
	
	@RequestMapping("/sideMenu.do")
	public String leftMenuHandler(
			@RequestParam String menuTop
			, Model model, HttpSession session, Authentication authentication) {
		List<MenuSideVO> sideMenuList = service.selectSideMenuList(menuTop);
		if(menuTop.trim().equals("T12")) {
			MemberVO authMember = ((MemberVOWrapper)authentication.getPrincipal()).getRealUser();
			String proJob = authMember.getUserJob();
			if(!proJob.equals("학과장")) {
				for(Iterator<MenuSideVO> it=sideMenuList.iterator(); it.hasNext();){
					MenuSideVO eachVo = it.next();
		            if(eachVo.getMenuId().equals("M113")) {
		            	it.remove(); break;
		            }
		        }
			}
		}
		
		session.setAttribute("sideMenuList", sideMenuList);
		
		session.setAttribute("menuTop", menuTop);
		model.addAttribute("sideMenuList", sideMenuList);
		
		return "jsonView";
	}
	
	/**
	 * 마이페이지
	 * @return
	 */
	@GetMapping("/myPage")
	public String myPageView() {
		return "temp/myPage";
	}
	
	/**
	 * 마이페이지 입장시 비밀번호 확인
	 * @param plainPass
	 * @param authentication
	 * @return
	 */
	@PostMapping(value="/myPageValidate", produces = "application/text; charset=UTF-8")
	@ResponseBody
	public String myPageValidation(@RequestParam("plainPass") String plainPass,
			Authentication authentication) {
		MemberVO authMember = ((MemberVOWrapper)authentication.getPrincipal()).getRealUser();
		boolean rs = passwordEncoder.matches(plainPass, authMember.getUserPass());
	

		if(rs) {
			log.info("검증성공");
		return "검증성공";
		}else {
			log.info("검증실패");
			return "검증실패";
		}
	}
	
	/**
	 * 수정후 저장하기
	 */
	@PostMapping("/editMyInfo")
	public String editMyInfo(MemberVO vo,Model model,RedirectAttributes redirectAttributes,@RequestParam("userAddr2") String userAddr2) {
		vo.setUserAddr(vo.getUserAddr()+" "+userAddr2);
		int rs = myPageService.editMyInfo(vo);
		if(rs == 1) {
			redirectAttributes.addFlashAttribute("myPageMessage","변경성공! 다시 로그인하세요!");
			redirectAttributes.addFlashAttribute("myPageSuccess","success");
			return "redirect:/myPage";
		}else {
			redirectAttributes.addFlashAttribute("myPageMessage","변경실패! 다시 확인해주세용ㅠ");			
			return "redirect:/myPage";
		}
		
	}
	
	@RequestMapping("/mainNoticeList")
	public String mainNoticeList(Model model, Authentication authentication) {
		MemberVO authMember = ((MemberVOWrapper)authentication.getPrincipal()).getRealUser();
		int userNo = authMember.getUserNo();
		
		List<NoticeBoardVO> noticeList = infoService.retrieveMyNoticeList(userNo);
		model.addAttribute("noticeList", noticeList);
		
		return "jsonView";
	}

}
