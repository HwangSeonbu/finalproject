package kr.or.ddit.scholarship.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.vo.ScholarshipVO;

/**
 * 
 * @author 민진홍	
 * @since 2022. 5. 10.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2022. 5. 10.      민진홍 	최초작성
 * Copyright (c) 2022 by DDIT All right reserved
 * </pre>
 */
public interface StudentScholarshipService {
	
	public List<ScholarshipVO> studentScholarshipApplyList(); 
	
	public int studentScholarshipApply(Map<String, Object> info);
	
	public List<String> studentScholarshipAleardyApply(Map<String,Object> info);
	
	public List<Map<String,Object>> studentScholarshipReqApplyList(Map<String, Object> info);
	
	public int cancelStudentScholarshipApply(String reqId);
}
