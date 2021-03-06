package kr.or.ddit.lecqna.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.lecboard.service.LecBoardService;
import kr.or.ddit.lecqna.dao.LecQnaReplyDAO;
import kr.or.ddit.lecqna.service.LecQnaReplyService;
import kr.or.ddit.lecqna.service.LecQnaService;
import kr.or.ddit.vo.AttchVO;
import kr.or.ddit.vo.ClassVO;
import kr.or.ddit.vo.LecNoticeBoardVO;
import kr.or.ddit.vo.LecQnaReplyVO;
import kr.or.ddit.vo.LecqnaVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.PagingVO;
import kr.or.ddit.vo.QnABoardVO;
import kr.or.ddit.vo.SimpleSearchVO;
import kr.or.ddit.vo.security.MemberVOWrapper;
import lombok.extern.slf4j.Slf4j;

@RequestMapping("/lecBoard/qna")
@Controller
@Slf4j
public class LecQnaRetrieveController {
	@Inject
	private LecQnaService qnaService;
	@Inject
	private LecBoardService service;
	@Inject
	private LecQnaReplyService replyService;
	
	@GetMapping
	public String boardListview(
			Model model
			,HttpSession session
			,Authentication authentication
			) {
		
		
		ClassVO classVO = (ClassVO) session.getAttribute("classVO");
		

		model.addAttribute("lecId", classVO.getLecId());
		model.addAttribute("lecSems",classVO.getLecSems());
		model.addAttribute("lecMap", service.retrieveOneLec(classVO.getLecId()));
		
		return "lecQna/lecQnaList";
		
		
	}
	@ResponseBody
	@GetMapping(produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public PagingVO<LecqnaVO> pagingList(
			@RequestParam(value="page", required=false, defaultValue="1") int currentPage
			, @ModelAttribute("simpleCondition") SimpleSearchVO simpleCondition 			
			,HttpServletRequest req
			) {
		HttpSession session = req.getSession();
		ClassVO classVO = (ClassVO) session.getAttribute("classVO");
		LecqnaVO lecqna = new LecqnaVO();
		lecqna.setLecSems(classVO.getLecSems());
		lecqna.setLecId(classVO.getLecId());
		
		PagingVO<LecqnaVO> paging = new PagingVO<>(10, 5);
		paging.setDetailCondition(lecqna);
		log.info("classVO.getLecId()=======>{}",classVO.getLecId());
		paging.setLecId(classVO.getLecId());
		paging.setCurrentPage(currentPage);
		paging.setSimpleCondition(simpleCondition);
		qnaService.retrieveBoardList(paging);
		
		return paging;
	}
	@GetMapping("{boNo}")
	public String boardView(@PathVariable int boNo, Model model
			,Authentication authentication) {
		LecqnaVO board = qnaService.retrieveBoard(boNo);
		List<LecQnaReplyVO> replyBoard = replyService.retrieveLecQnaReplyList(boNo);
		model.addAttribute("board",board);
		MemberVO member = ((MemberVOWrapper)authentication.getPrincipal()).getRealUser();
		model.addAttribute("userNo",member.getUserNo());
		
		log.info("{}",board);
		return "lecQna/lecQnaView";
	}
	@PostMapping("reply")
	public String boardReplyView(@RequestParam("boNo") int boNo, Model model) {
		
		List<LecQnaReplyVO> replyBoard = replyService.retrieveLecQnaReplyList(boNo);
		
		model.addAttribute("replyBoard",replyBoard);
		log.info("replyBoard{}",replyBoard);
		
		return "jsonView";
	}
	@GetMapping("{lecboNo}/attach/{attchNo}")
	public String downLoad(@PathVariable int attchNo, Model model) {
		AttchVO attach = qnaService.downloadAttach(attchNo);
		
		model.addAttribute("attch", attach);
		
		
		return "boardDownloadView";
	}

	
}















