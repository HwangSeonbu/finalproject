package kr.or.ddit.vo;

import java.util.List;

import lombok.Data;

/**
 * @author 이유정
 * @since 2022. 5. 4.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2022. 5. 4.      이유정       최초작성
 * Copyright (c) 2022 by DDIT All right reserved
 * </pre>
 */
@Data
public class CalendarVO {
	private Integer acadscNo; //일정번호
	private String acadscCont; //일정내용
	private String acadscStart; //일정시작일
	private String acadscEnd; //일정종료일
	private String acadscDiv; //일정구분 
	private Integer acadscUserno; //유저번호
	
	private String acadscColor;
	private int month;
//	private String period;
	
}
