package kr.or.ddit.homework.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.vo.AttchVO;
import kr.or.ddit.vo.HwkVO;
import kr.or.ddit.vo.LecHomeworkVO;
import kr.or.ddit.vo.PagingVO;

/**과제 게시판 Service
 * @author 황선부
 * @since 2022. 5. 24.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2022. 5. 24.      황선부       최초작성
 * Copyright (c) 2022 by DDIT All right reserved
 * </pre>
 */
public interface HomeworkService {
	public List<LecHomeworkVO> retrieveHomeworkList(PagingVO<LecHomeworkVO> paging);
	
	public LecHomeworkVO retrieveHomework(Integer lechwkNo);
	
	public ServiceResult createHomework(LecHomeworkVO lecwhk);
	
	public AttchVO downloadAttach(Integer attchNo);
	public ServiceResult modifyHomework(LecHomeworkVO homwork);
	
	public ServiceResult deleteHomwork(LecHomeworkVO homwork);
	
	public HwkVO retrieveHwOne(Integer hwkNo);
	
	public ServiceResult createHwk(HwkVO hwk);
	
	public HwkVO retreiveHwOneByStuNo(HwkVO hwk);
	
	public ServiceResult modifyHwk(HwkVO hwk);
	
	public ServiceResult createGradingHwk(HwkVO hwk);
	
	public LecHomeworkVO retrieveMainHW(String lecId);
	
	public List<Map<String, Object>> retrieveEvaHw(int stuNo);

	public ServiceResult modifyClsHwk(Map<String, Object>map);

}
