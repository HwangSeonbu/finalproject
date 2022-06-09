package kr.or.ddit.attendance.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.AttabsEnrollVO;
import kr.or.ddit.vo.LectureJ;
import kr.or.ddit.vo.LectureVO;

/**
 * 교수 입장에서 출결관련 프로세스 처리
 * @author 김재웅
 * @since 2022. 5. 16.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2022. 5. 16.      김재웅       최초작성
 * 2022. 5. 24.      주창규       출석부추가
 * Copyright (c) 2022 by DDIT All right reserved
 * </pre>
 */
@Mapper
public interface ProfessorAttendanceDAO {

	/**
	 * 교수의 이번학기 강의리스트(현재(20220516-김재웅) 출결페이지를 위한 쿼리)
	 * @return
	 */
	public List<LectureVO> selectProLectureList(Map<String, Integer> paramMap);
	
	
	/**
	 * 교수의 어떤 강의의 유효한(해당 강의의 배정 요일에 해당하는 일자) 출결 날짜 리스트
	 * @param lecId
	 * @return
	 */
	public List<String> selectLecDateList(AttabsEnrollVO vo);
	
	public List<AttabsEnrollVO> selectAttabsStudentList(AttabsEnrollVO vo);
	
	public int updateOrInsertAttabs(AttabsEnrollVO vo);
	
	public Map<String, String> selectOpenCloseLecDate(int thisSems);

	/** 교수가 자신의 강의를 수강 중인 학생들의 출석을 조회 excel jck
	 * @param map
	 * @return
	 */
	public List<LectureJ> selectAttendanceLectureExcel(Map<String,Object> map);
	
	/** 교수가 자신의 강의를 수강 중인 학생들의 출석을 조회 jck
	    * @param map
	    * @return
	    */
	public List<Map<String, Object>> selectAttendanceLecture(Map<String,Object> map);
}














