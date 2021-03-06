package kr.or.ddit.attendance.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

import kr.or.ddit.attendance.dao.AttendanceDAO;
import kr.or.ddit.vo.AttendanceCountVO;
import kr.or.ddit.vo.LecturePeriodVO;
import kr.or.ddit.vo.SemsVO;
import kr.or.ddit.vo.StudentVO;
import kr.or.ddit.vo.SubjectVO;
import lombok.extern.slf4j.Slf4j;

/**
 * @author 주창규
 * @since 2022. 4. 28.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * 
 *      <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2022. 4. 28.      주창규       최초작성
 * Copyright (c) 2022 by DDIT All right reserved
 *      </pre>
 */
@Service
@Slf4j
public class AttendanceServiceImpl implements AttendanceService {

	@Inject
	private AttendanceDAO aDao;
	

	// 학생 정보 상세 조회 (학번,이름,학부,학과,학년,학적상태)
	@Override
	public StudentVO retrieveStudent(int userNo) {

		StudentVO studentDetail = aDao.selectStudentDetail(userNo);
		log.info("------------------------------studentDetail--{}", studentDetail);

		return studentDetail;
	}

	// 학생이 수강 중인 과목의 정보와 1주~16주차 출석 조회 (과목학년,과목명,교수명,주차별 출석 조회, 출석현황별 카운트)
	@Override
	public StudentVO retrieveLecture(StudentVO studentVo) {
		int lecSems = 0;
		
		if(studentVo.getLecSems() == null) {
			SemsVO semsVo = (SemsVO) RequestContextHolder.getRequestAttributes().getAttribute("semsVo",
					RequestAttributes.SCOPE_SESSION);
			lecSems = semsVo.getThisSems();
		}else {
			lecSems = studentVo.getLecSems();
		}
		
		studentVo.setLecSems(lecSems); // 이번학기 이거나 클라이언트가 선택학기
		
		int startDate = aDao.selectStartDate(lecSems);
		studentVo.setStartDate(startDate);

		List<SubjectVO> lectureList = aDao.selectStudentLecture(studentVo);

		for (SubjectVO subjectVo : lectureList) {

			// 여러 과목들 중에서 포문이 도는 하나의 과목에 대한 출석정보를 불러오려고 필요한 파라미터를 세팅
			studentVo.setLecId(subjectVo.getLecId());

			// 그 세팅한 파라미터 가지고 지금 포문이 도는 과목에 대한 출석리스트를 불러옴
			List<LecturePeriodVO> lecturePeriodList = aDao.selectStudentLecturePeriod(studentVo);

			// 역시 그 세팅한 파라미터 가지고 이번에는 지금 포문이 도는 과목에 대한 출석카운트를 불러오려고 함
			AttendanceCountVO attendanceCountVo = aDao.selectStudentAttendanceCount(studentVo);

			// 포문이 돌고있는 하나의 과목VO에 출석리스트를 담을수 있는 속성에다가 출석리스트를 담음
			subjectVo.setLecturePeriodList(lecturePeriodList);

			// 포문이 돌고있는 하나의 과목VO에 이번에는 출석카운트를 담을수 있는 속성에다가 출석카운트를 담아야함
			subjectVo.setAttendanceCountVo(attendanceCountVo);

		}

		studentVo.setSubjectList(lectureList);
		return studentVo;
	}

	/* (non-Javadoc)
	 * @see kr.or.ddit.attendance.service.AttendanceService#selectStudentAttendanceCountMap(java.util.Map)
	 */
	@Override
	public Map<String, Object> selectStudentAttendanceCountMap(Map<String, Object> map) { 
		
		Map<String, Object> result = aDao.selectStudentAttendanceCountMap(map);
		
		log.debug("selectStudentAttendanceCountMap : ", result);
		
		return result;
	}


	
	
	

}
