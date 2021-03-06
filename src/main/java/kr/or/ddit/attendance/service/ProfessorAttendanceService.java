package kr.or.ddit.attendance.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.AttabsEnrollVO;
import kr.or.ddit.vo.LectureJ;
import kr.or.ddit.vo.LectureVO;

public interface ProfessorAttendanceService {

	public List<LectureVO> retrieveProLectureList(Map<String, Integer> paramMap);
	
	
	public List<String> retrieveLecDateList(String lecId);
	
	public List<AttabsEnrollVO> retrieveAttabsStudentList(Map<String, Object> paramMap);
	
	public int modifyOrCreateAttabs(Map<String, Object> paramMap);
	public int modifyOrCreateAttabsOne(AttabsEnrollVO paramVo);

	/** 교수가 자신의 강의를 수강 중인 학생들의 출석을 조회 excel jck
	 * @param map
	 * @return
	 */
	public List<LectureJ> retrieveAttendanceLectureExcel(Map<String,Object> map);
	
	/** 교수가 자신의 강의를 수강 중인 학생들의 출석을 조회 jck
	    * @param map
	    * @return
	    */
	public List<Map<String, Object>> retrieveAttendanceLecture(Map<String,Object> map);
}
