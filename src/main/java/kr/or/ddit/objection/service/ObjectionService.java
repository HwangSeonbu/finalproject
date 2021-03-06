package kr.or.ddit.objection.service;

import java.util.List;
import java.util.Map;


/**
 * @author 학생의 출석인정현황관리용 Business Logic Layer
 * @since 2022. 4. 29.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2022. 4. 29.      주창규       최초작성
 * Copyright (c) 2022 by DDIT All right reserved
 * </pre>
 */
public interface ObjectionService {

	/** 학생이 자신의 출석인정신청현황목록을 조회
	 * @param userNo
	 * @return
	 */
	public List<Map<String, Object>> retrieveStudentAttendanceObjection(Map<String, Object> map);
}
