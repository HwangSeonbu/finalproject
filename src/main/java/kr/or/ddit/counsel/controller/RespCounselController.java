package kr.or.ddit.counsel.controller;

import java.util.Map;

import javax.inject.Inject;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.counsel.service.CounselService;
import kr.or.ddit.vo.CounselVO;
import kr.or.ddit.vo.PagingVO;
import kr.or.ddit.vo.ProCounselVO;
import kr.or.ddit.vo.SimpleSearchVO;
import kr.or.ddit.vo.security.MemberVOWrapper;
import lombok.extern.slf4j.Slf4j;

/**교수가 상담관리하는 컨트롤러
 * @author 황선부
 * @since 2022. 4. 29.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2022. 4. 29.      황선부       최초작성
 * Copyright (c) 2022 by DDIT All right reserved
 * </pre>
 */
@Controller
@RequestMapping("/respCounsel")
@Slf4j
public class RespCounselController {
	@Inject
	private CounselService service;
	
	@RequestMapping("/requestView")
	public String listView1(
			@RequestParam(value="page",required=false, defaultValue="1") int currentPage
			,@ModelAttribute("simpleCondition") SimpleSearchVO simpleCondition
			,Model model
			,Authentication authentication
			) {
			//상담관리 페이지
			String userNo
			 = ((MemberVOWrapper)authentication.getPrincipal()).getUsername();
			
			int proNo = Integer.parseInt(userNo);			
			
			PagingVO<ProCounselVO> paging = new PagingVO<>(15, 20);
			paging.setProNo(proNo);
			paging.setCurrentPage(currentPage);
			paging.setSimpleCondition(simpleCondition);
			
			service.retreiveCounselPro(paging);
			
			CounselVO counsel = new CounselVO();
			
			//message 전달 받을 vo
			model.addAttribute("counselVO",counsel);
			model.addAttribute("paging", paging);
			
		
		return "counsel/respCounsel1";
	}
	

}



















