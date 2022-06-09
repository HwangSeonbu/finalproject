package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;

import lombok.Data;
/**
 * 1주~16주 출석현황을 보기 위한 VO
 * @author 주창규
 * @since 2022. 5. 2.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2022. 5. 2.      주창규       최초작성
 * Copyright (c) 2022 by DDIT All right reserved
 * </pre>
 */
@Data
public class LecturePeriodVO {

	private int period;	//강의 주차
	private String attabsDate;	//수강일자
	private String attabsCode;	//출석 상태
	private String lecName;		//강의명
	private String lecId; 		//강의 아이디
	
	
}