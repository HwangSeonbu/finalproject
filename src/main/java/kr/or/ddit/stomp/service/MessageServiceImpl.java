/**
 * 
 */
package kr.or.ddit.stomp.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;

import kr.or.ddit.stomp.dao.MessageDAO;
import lombok.extern.slf4j.Slf4j;

/**
 * @author 민진홍
 * @since 2022. 5. 25.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2022. 5. 25.      민진홍       최초작성
 * Copyright (c) 2022 by DDIT All right reserved
 * </pre>
 */
@Slf4j
@Service
public class MessageServiceImpl implements MessageService {

	@Inject
	private MessageDAO dao;
	
	@Override
	public int MessageSend(Map<String, Object> map) {
		dao.messageSendInsert(map);
		List<String> receiverList = (List<String>) map.get("receiver");
		for(String reciever : receiverList) {
			log.info("reciever:{}",reciever);
			log.info("Integer.parseInt(String.valueOf(reciever)){}",Integer.parseInt(String.valueOf(reciever)));
		dao.messageReceiverInsert(Integer.parseInt(String.valueOf(reciever)));
		
		}
		return 1;
	}
	
}
