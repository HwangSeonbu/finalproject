package kr.or.ddit.homework.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.homework.dao.HomeworkDAO;
import kr.or.ddit.homework.service.HomeworkService;
import kr.or.ddit.validate.HomeworkInsertGroup;
import kr.or.ddit.validate.InsertLecQnaGroup;
import kr.or.ddit.vo.ClassVO;
import kr.or.ddit.vo.LecHomeworkVO;
import kr.or.ddit.vo.LecqnaVO;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@RequestMapping("/homework/{boNo}")
@Controller
public class HomeWorkUpdateController {
	@Inject
	private HomeworkService service;

	@RequestMapping("form")
	public String updateForm(@PathVariable int boNo, Model model) {
		LecHomeworkVO hw = service.retrieveHomework(boNo);
		model.addAttribute("homework", hw);

		return "homework/hwUpdateForm";
	}
	@PostMapping
	public String updateProcess(
			@Validated(HomeworkInsertGroup.class) @ModelAttribute("homework") LecHomeworkVO homework
			,@PathVariable int boNo
			,BindingResult errors
			,Model model
			,RedirectAttributes redirectAttributes
			,HttpSession session
			) {	
		homework.setLechwkNo(boNo);
		String viewName=null;
		if(!errors.hasErrors()) {
			ServiceResult result = service.modifyHomework(homework);
			switch (result) {
				case FAIL:
				viewName="homework/hwUpdateForm";
				model.addAttribute("message", "서버 오류입니다.");
				break;
				default:
					redirectAttributes.addFlashAttribute("success", homework);
					redirectAttributes.addFlashAttribute("message", "수정성공함");
					viewName = "redirect:../homework";
					break;
				}
			
		}else {
			viewName="homework/hwUpdateForm";
			model.addAttribute("message", "제목이나 글을 입력하세요");
//			redirectAttributes.addFlashAttribute("message", "제목이나 글을 입력하세요");
		}
		return viewName;
	}
	
}
