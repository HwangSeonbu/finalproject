package kr.or.ddit.attendance.service;

import java.util.Map;

import kr.or.ddit.vo.StudentVO;

/**
 * 학생의 출석현황관리용 Business Logic Layer
 * 
 * @author 주창규
 * @since 2022. 4. 28.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * 
 *      <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2022. 4. 28.      작성자명       최초작성
 * Copyright (c) 2022 by DDIT All right reserved
 *      </pre>
 */
public interface AttendanceService {

	/**
	 * 학생 정보 상세 조회 (학번,이름,학부,학과,학년,학적상태)
	 * 
	 * @param userNo 조회할 아이디
	 * @return
	 */
	public StudentVO retrieveStudent(int userNo);

	/**
	 * 학생이 수강 중인 과목의 정보와 1주~16주차 출석 조회 (과목학년,과목명,교수명,주차별 출석 조회)
	 * 
	 * @param lectureVo
	 * @return
	 */
	public StudentVO retrieveLecture(StudentVO subjectVo);

	/**
	 * 학생이 수강 중인 강의의 출석현황 카운터 조회 (출석수/결석수/조퇴수/지각수) (Map)
	 * 
	 * @param attendanceVo
	 * @return
	 */
	public Map<String, Object> selectStudentAttendanceCountMap(Map<String, Object> map);

}