package kr.or.ddit.counsel.controller;

import java.util.HashMap;

import javax.inject.Inject;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.counsel.service.CounselService;
import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.validate.MessageGroup;
import kr.or.ddit.validate.UpdateGroup;
import kr.or.ddit.vo.CounselVO;
import lombok.extern.slf4j.Slf4j;
import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;
@Slf4j
@Controller
public class CounselMessageController {
	@Inject
	private CounselService service;
	
	@PostMapping("/respCounsel/message")
	public String message(
			@Validated(MessageGroup.class) @ModelAttribute("counsel")CounselVO counsel
			,BindingResult errors
			,Model model
			,RedirectAttributes redirectAttribute
			) {
		//param = 날짜,시간,장소,전화번호,이름,cnsl_id
		log.info("{}",counsel.toString());
		
		if(!errors.hasErrors()) {

			Long successCount = messageSend(counsel);
			
			
			if(successCount>0) {
				ServiceResult result = service.modifyMessageInfo(counsel);
				if(ServiceResult.OK.equals(result)) {
					redirectAttribute.addFlashAttribute("message", "메시지가 전송되었습니다.");
					//model.addAttribute("message", "상담 일지가 등록되었습니다.");
					
				}else {
					redirectAttribute.addFlashAttribute("message", "서버 오류 입니다. 잠시 후에 다시 시도하세요.");
				}				
			}
		}else {
			redirectAttribute.addFlashAttribute("message", "입력사항을 입력하세요");
		}
		
		
		return "redirect:requestView";
	}
	
	//message send
	private Long messageSend(CounselVO counsel) {
		
		// String api_key = "NCSC1MY5HP0I6PBZ";
		  String api_key = "NCSE3RBVBQ7OJMTA";
		 //   String api_secret = "S968MOWCSSRJ4GCLAF4AFSUHIKGQYZ8P";
		    String api_secret = "5ZSBRBMBFPD2IK58ATA7CCWPAKTBACFF";
		    Message coolsms = new Message(api_key, api_secret);

		    // 4 params(to, from, type, text) are mandatory. must be filled
		    HashMap<String, String> params = new HashMap<String, String>();
//		    String starName = name.substring(0,1)+"*"+name.substring(2);
		    String starName = counsel.getUserName().substring(0,1)+"*"+counsel.getUserName().substring(2);
		    params.put("to", counsel.getUserPhone());
		    params.put("from", "01047257313");
		    params.put("type", "LMS");
		    params.put("text", "[대덕 인재 대학교]["+starName+"님의 상담 일시 및 장소 안내]"+ counsel.getCnslDay()+"-"+counsel.getCnslLo() + "입니다.상담시간에 늦지 않게 와주시기 바랍니다.");
		    params.put("app_version", "test app 1.2"); // application name and version
		    Long successCount = 0L;
		    try {
		      JSONObject obj = (JSONObject) coolsms.send(params);
		      successCount = (Long) obj.get("success_count");
		      if(successCount>0) {
		    	  log.info("*******************성공");
		      }else {
		    	  log.info("*******************실패");
		      }
		      	log.info("successCount:{},{}",successCount,obj.toString());     
		    } catch (CoolsmsException e) {
		      log.info("e.getMessage() : {}",e.getMessage());
		      System.out.println(e.getMessage());
		      log.info("e.getCode() : {}",e.getCode());
		    }
		    return successCount;
	}
	
	
}
