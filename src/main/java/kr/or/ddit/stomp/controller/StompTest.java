package kr.or.ddit.stomp.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.commons.lang3.StringUtils;
import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.util.HtmlUtils;

import kr.or.ddit.stomp.dao.MessageDAO;
import kr.or.ddit.stomp.service.MessageService;
import kr.or.ddit.sugang.service.LectureApplyViewService;
import kr.or.ddit.sugang.service.LectureApplyViewServiceImpl;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.security.MemberVOWrapper;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@Controller
public class StompTest {
	
	@Inject
	private MessageService service; 
	
	@Inject
	private MessageDAO dao;

	@GetMapping("/stompEcho")
	public String stompTest1() {
		return "/stomp/stompEcho";
	}
	
	@GetMapping("/stompPush")
	public String stompTest2() {
		return "/stomp/stompPush";
	}
	
	@GetMapping("/stompDM")
	public String stompTest3() {
		return "/stomp/stompOneToOne";
	}
	
	@GetMapping("/messageUserList2")
	public String stompTest4() {
		return "/stomp/messageUserList";
	}
	
	
	/**
	 * 친구목록
	 * @param authentication
	 */
	@GetMapping("/messageUserList")
	@ResponseBody
	public List<MemberVO> messageUserList(Authentication authentication,Model model,
			@RequestParam(value="userTypeList[]", required=false) List<String> userTypeList,
			@RequestParam(value="deptName", required=false) String deptName,
			@RequestParam(value="searchName", required=false) String searchName
			) {
		MemberVO authMember
		= ((MemberVOWrapper)authentication.getPrincipal()).getRealUser();
		int userNo = authMember.getUserNo();
		String userTypeStudent = null;
		String userTypeProfessor = null;
		String userTypeManager = null;
		if(deptName == "학과") {
			deptName = null;
		}
		if(searchName == "" || StringUtils.isBlank(searchName)) {
			searchName = null;
		}
		
		log.info("deptName = {} , searchName = {}", deptName,searchName);
		if(userTypeList != null || deptName != null || searchName != null) {
			List<MemberVO> messageUserList = new ArrayList<>();
			
			if(!(userTypeList == null) && userTypeList.contains("학생")) {
				userTypeStudent = "ROLE_STUDENT";
				Map<String,Object> map = new HashMap<>();
				map.put("userType", userTypeStudent);
				map.put("deptName", deptName);
				map.put("searchName", searchName);
				map.put("userNo", userNo);
				messageUserList.addAll(dao.messageUserListSearch(map));
			}
			if(!(userTypeList == null) && userTypeList.contains("교수")) {
				userTypeProfessor = "ROLE_PROFESSOR";		
				Map<String,Object> map = new HashMap<>();
				map.put("userType", userTypeProfessor);
				map.put("deptName", deptName);
				map.put("searchName", searchName);
				map.put("userNo", userNo);
				messageUserList.addAll(dao.messageUserListSearch(map));
			}
			if(!(userTypeList == null) && userTypeList.contains("학사관리자")) {
				userTypeManager = "ROLE_MANAGER";	
				Map<String,Object> map = new HashMap<>();
				map.put("userType", userTypeManager);
				map.put("deptName", deptName);
				map.put("searchName", searchName);
				map.put("userNo", userNo);
				messageUserList.addAll(dao.messageUserListSearch(map));
			}
			if(userTypeList == null){
			
			
			Map<String,Object> map = new HashMap<>();
			map.put("userType", userTypeManager);
			map.put("deptName", deptName);
			map.put("searchName", searchName);
			map.put("userNo", userNo);
			messageUserList.addAll(dao.messageUserListSearch(map));
			}
			return messageUserList;
			
		}else {	
		List<MemberVO> messageUserList = dao.messageUserList(userNo);
//		model.addAttribute("messageList",messageList);
		
		return messageUserList;	
		}
	}
	
	/**
	 * 받은메시지
	 * @param authentication
	 */
	@GetMapping("/messageList")
	@ResponseBody
	public List<Map<String,Object>> messageList(Authentication authentication,Model model) {
		MemberVO authMember
		= ((MemberVOWrapper)authentication.getPrincipal()).getRealUser();
		int userNo = authMember.getUserNo();
		List<Map<String,Object>> messageList = dao.messageList(userNo);
		
//		model.addAttribute("messageList",messageList);
		
		return messageList;
	}
	
	/**
	 * 보낸메시지
	 * @param authentication
	 */
	@GetMapping("/sendMessageList")
	@ResponseBody
	public List<Map<String,Object>> sendMessageList(Authentication authentication,Model model) {
		MemberVO authMember
		= ((MemberVOWrapper)authentication.getPrincipal()).getRealUser();
		int userNo = authMember.getUserNo();
		List<Map<String,Object>> messageList = dao.sendMessageList(userNo);
//		model.addAttribute("messageList",messageList);
		
		return messageList;
	}
	
	/**
	 * 메시지읽음처리
	 * @param authentication
	 * @throws IOException 
	 */
	@GetMapping(value="/messageReadFlag")
	@ResponseBody
	public int messageReadFlag(@RequestParam("memoNo") String memoNo,Authentication authentication,Model model) throws IOException {
		MemberVO authMember
		= ((MemberVOWrapper)authentication.getPrincipal()).getRealUser();
		int userNo = authMember.getUserNo();
		int memoNo2 = Integer.parseInt(memoNo);
		int rs = dao.messageReadFlag(userNo, memoNo2);
		if(rs!=1) {
			throw new IOException();
		}
		return rs;
	}
	
	
	/**
	 * 메시지삭제처리
	 * @param authentication
	 * @throws IOException 
	 */
	@GetMapping(value="/messageDelete")
	@ResponseBody
	public int messageDelete(@RequestParam("memoNo") String memoNo,Authentication authentication,Model model) throws IOException {
		MemberVO authMember
		= ((MemberVOWrapper)authentication.getPrincipal()).getRealUser();
		int userNo = authMember.getUserNo();
		int memoNo2 = Integer.parseInt(memoNo);
		int rs = dao.messageDelete(userNo, memoNo2);
		if(rs!=1) {
			throw new IOException();
		}
		return rs;
	}
	
	
	
	/**
	 * 받은메시지 개수
	 * @param authentication
	 */
	@GetMapping("/messageCount")
	@ResponseBody
	public int messageCount(Authentication authentication,Model model) {
		MemberVO authMember
		= ((MemberVOWrapper)authentication.getPrincipal()).getRealUser();
		int userNo = authMember.getUserNo();
		int messageCount = dao.messageCount(userNo);
//		model.addAttribute("messageList",messageList);
		
		return messageCount;
		
		
	}
	
	/**
	 * 메세지보내기
	 * @param map
	 * @param authentication
	 * @return
	 */
	@PostMapping("/sendMessage")
	@ResponseBody
	public Map<String,Object> sendMessage(@RequestBody Map<String,Object> map, Authentication authentication) {
		MemberVO authMember
		 = ((MemberVOWrapper)authentication.getPrincipal()).getRealUser();
		log.info("넘어오냐~~~~~~~~~~~~~~~~? {}", map.toString());
		map.put("senderNo", authMember.getUserNo());
		service.MessageSend(map);
		return map;
	}

	
	/**
	 * DEPT_NAME 리스트조회 (학과이름)
	 * @return
	 */
	@GetMapping(value="messageDeptNameList", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<Map<String,String>> deptNameList(){
		return dao.messageDeptNameList();
	}
}
