package kr.or.ddit.lecqna.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.lecqna.service.LecQnaService;
import kr.or.ddit.validate.InsertLecQnaGroup;
import kr.or.ddit.vo.ClassVO;
import kr.or.ddit.vo.LecqnaVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.security.MemberVOWrapper;
import lombok.extern.slf4j.Slf4j;
/**강의게시판 qna controller
 * @author 황선부
 * @since 2022. 5. 20.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2022. 5. 20.      황선부       최초작성
 * Copyright (c) 2022 by DDIT All right reserved
 * </pre>
 */
@Slf4j
@RequestMapping("/lecBoard/qna/new")
@Controller
public class LecQnaInsertController {
	@Autowired
	private LecQnaService service;
	
	@ModelAttribute("board")
	public LecqnaVO board() {
		return new LecqnaVO();
	}
	@GetMapping
	public String insertForm() {
		return "lecQna/lecQnaInsert";
	}
	@PostMapping
	public String createLecQna(
			@Validated(InsertLecQnaGroup.class) @ModelAttribute("board") LecqnaVO board
			,BindingResult errors
			,Model model
			,HttpSession session
			,RedirectAttributes redirectattributes
			,Authentication authen
			) {

		ClassVO classVO = (ClassVO) session.getAttribute("classVO");
		board.setLecId(classVO.getLecId());
		board.setLecSems(classVO.getLecSems());
		String viewName = "redirect:../qna";
		
		MemberVO member = ((MemberVOWrapper)authen.getPrincipal()).getRealUser();
		
		String memRole = member.getMemRole();

		if(memRole.equals("ROLE_STUDENT"))
			board.setStuNo(member.getUserNo());
		else if(memRole.equals("ROLE_PROFESSOR"))
			board.setProNo(member.getUserNo());
		
		
		
		if(!errors.hasErrors()) {
			ServiceResult result = service.createBoard(board);
			if(result.equals(ServiceResult.FAIL)) {
				viewName="redirect:new";
				redirectattributes.addFlashAttribute("message", "서버오류, 잠시 뒤 실행하세요");
			}
		}else {
			redirectattributes.addFlashAttribute("board", board);
			viewName="lecQna/lecQnaInsert";
			log.info("===================board{}",board);
			}
	return viewName;
	}


}
