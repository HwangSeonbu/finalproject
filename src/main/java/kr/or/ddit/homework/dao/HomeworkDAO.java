package kr.or.ddit.homework.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.EvaStandardVO;
import kr.or.ddit.vo.HwkVO;
import kr.or.ddit.vo.LecHomeworkVO;
import kr.or.ddit.vo.PagingVO;
import lombok.extern.slf4j.Slf4j;

/**과제 게시판 dao
 * @author 황선부
 * @since 2022. 5. 23.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2022. 5. 23.      황선부       최초작성
 * Copyright (c) 2022 by DDIT All right reserved
 * </pre>
 */

@Mapper
public interface HomeworkDAO {
	//조회 페이징
	public List<LecHomeworkVO> homeworkList(PagingVO<LecHomeworkVO> paging);
	//조회 totalcount
	public int totalHomeworkList(PagingVO<LecHomeworkVO>paging);
	//상세 조회
	public LecHomeworkVO homework(int lechwkNo);
	//조회수
	public int updateHit(int leckwkNo);
	//insert
	public int insertHomework(LecHomeworkVO hw);
	public int insertEva(LecHomeworkVO hw);
	//update
	public int updateHomework(LecHomeworkVO hw);
	public int updateEva(LecHomeworkVO hw);
	
	public int updateEva2(EvaStandardVO eva);
	
	//delete
	public int deleteHomework(LecHomeworkVO hw);
	public int deleteEva(LecHomeworkVO hw);
	
	//채점뷰
	public HwkVO selectHw(int hwkNo);
	
	//insert-hwk
	public int insertHwk(HwkVO hwk);
	
	public HwkVO selectHwByStuNo(HwkVO hwk);
	
	public int updateHwk(HwkVO hwk);
	
	//채점 insert(update)
	public int updateGradingHwk(HwkVO hwk);
	
	public int selectMaxLechhwkNo(String lecId);
	
	public List<Map<String, Object>> selectEvaHw(int stuNo);
	
	public int updateClsHwk(Map<String, Object>map);
}




















