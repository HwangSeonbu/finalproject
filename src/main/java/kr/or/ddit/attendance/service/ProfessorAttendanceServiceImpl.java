package kr.or.ddit.attendance.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.attendance.dao.ProfessorAttendanceDAO;
import kr.or.ddit.utils.OpenCloseLectureUtils;
import kr.or.ddit.vo.AttabsEnrollVO;
import kr.or.ddit.vo.LectureJ;
import kr.or.ddit.vo.LectureVO;
import kr.or.ddit.vo.SemsVO;

/**
 * @author 작성자명
 * @since 2022. 5. 24.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * 
 *      <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2022. 5. 14.      김재웅       최초작성
 * 2022. 5. 24.      주창규       출석부추가
 * Copyright (c) 2022 by DDIT All right reserved
 *      </pre>
 */
@Service
public class ProfessorAttendanceServiceImpl implements ProfessorAttendanceService {

	@Inject
	ProfessorAttendanceDAO dao;

	@Override
	public List<LectureVO> retrieveProLectureList(Map<String, Integer> paramMap) {
		return dao.selectProLectureList(paramMap);
	}

	@Override
	public List<String> retrieveLecDateList(String lecId) {
		SemsVO semsVo = (SemsVO) RequestContextHolder.getRequestAttributes().getAttribute("semsVo",
				RequestAttributes.SCOPE_SESSION);
		int thisSems = semsVo.getThisSems();
		int year = thisSems / 100;
		int semester = thisSems % 100;

		Map<String, String> openClose = dao.selectOpenCloseLecDate(thisSems);

		String defaultStartDate1 = "" + year + "-03-01";
		String defaultEndDate1 = "" + year + "-06-30";
		String defaultStartDate2 = "" + year + "-09-01";
		String defaultEndDate2 = "" + year + "-12-31";

		String openLec = openClose.get("OPEN_LEC");
		String closeLec = openClose.get("CLOSE_LEC");

		if (openLec == null || openLec.isEmpty()) {
			if (semester == 1) {
				openLec = defaultStartDate1;
			} else {
				openLec = defaultStartDate2;
			}
		}
		if (closeLec == null || openLec.isEmpty()) {
			if (semester == 1) {
				closeLec = defaultEndDate1;
			} else {
				closeLec = defaultEndDate2;
			}
		}

//		OpenCloseLectureUtils ocUtils = new OpenCloseLectureUtils();
//		Map<String, String> openClose = ocUtils.openCloseLectureDate();

		AttabsEnrollVO paramVo = new AttabsEnrollVO();
		paramVo.setLecId(lecId);
		paramVo.setOpenLec(openLec);
		paramVo.setCloseLec(closeLec);

//		paramVo.setOpenLec(openClose.get("openLec"));
//		paramVo.setCloseLec(openClose.get("closeLec"));

		return dao.selectLecDateList(paramVo);
	}

	@Override
	public List<AttabsEnrollVO> retrieveAttabsStudentList(Map<String, Object> paramMap) {
		SemsVO semsVo = (SemsVO) RequestContextHolder.getRequestAttributes().getAttribute("semsVo",
				RequestAttributes.SCOPE_SESSION);
		int thisSems = semsVo.getThisSems();
		Map<String, String> openClose = dao.selectOpenCloseLecDate(thisSems);
		int year = thisSems / 100;
		int semester = thisSems % 100;
		String defaultStartDate1 = "" + year + "-03-01";
		String defaultEndDate1 = "" + year + "-06-30";
		String defaultStartDate2 = "" + year + "-09-01";
		String defaultEndDate2 = "" + year + "-12-31";

		String openLec = openClose.get("OPEN_LEC");
		String closeLec = openClose.get("CLOSE_LEC");

		if (openLec == null || openLec.isEmpty()) {
			if (semester == 1) {
				openLec = defaultStartDate1;
			} else {
				openLec = defaultStartDate2;
			}
		}
		if (closeLec == null || openLec.isEmpty()) {
			if (semester == 1) {
				closeLec = defaultEndDate1;
			} else {
				closeLec = defaultEndDate2;
			}
		}

		AttabsEnrollVO vo = new AttabsEnrollVO();
		vo.setLecId(String.valueOf(paramMap.get("lecId")));
		vo.setLecSems(Integer.parseInt(String.valueOf(paramMap.get("lecSems"))));
		vo.setPlanNo(Integer.parseInt(String.valueOf(paramMap.get("planNo"))));
		vo.setAttabsDate(String.valueOf(paramMap.get("attabsDate")));
		vo.setOpenLec(openLec);
		vo.setCloseLec(closeLec);

		List<AttabsEnrollVO> studentList = dao.selectAttabsStudentList(vo);

		return studentList;
	}

	@Override
	public int modifyOrCreateAttabs(Map<String, Object> paramMap) {
		SemsVO semsVo = (SemsVO) RequestContextHolder.getRequestAttributes().getAttribute("semsVo",
				RequestAttributes.SCOPE_SESSION);

		int resCnt = 0;
		String targetList = paramMap.get("targetList").toString();
		String targetListReplace = targetList.replaceAll("&quot;", "\"");

		ObjectMapper mapper = new ObjectMapper();

		List<AttabsEnrollVO> dataList = new ArrayList<>();

		try {
			dataList = mapper.readValue(targetListReplace, new TypeReference<ArrayList<AttabsEnrollVO>>() {
			});
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}

		for (AttabsEnrollVO eachVo : dataList) {
			eachVo.setLecSems(semsVo.getThisSems());
			resCnt += dao.updateOrInsertAttabs(eachVo);
		}

		return resCnt;
	}

	@Override
	public int modifyOrCreateAttabsOne(AttabsEnrollVO paramVo) {
		SemsVO semsVo = (SemsVO) RequestContextHolder.getRequestAttributes().getAttribute("semsVo",
				RequestAttributes.SCOPE_SESSION);

		int resCnt = 0;
		paramVo.setLecSems(semsVo.getThisSems());

		resCnt = dao.updateOrInsertAttabs(paramVo);

		return resCnt;
	}

//	교수가 자신의 강의를 수강 중인 학생들의 출석을 조회 jck
	@Override
	public List<LectureJ> retrieveAttendanceLectureExcel(Map<String, Object> map) {
		return dao.selectAttendanceLectureExcel(map);
	}

//  교수가 자신의 강의를 수강 중인 학생들의 출석을 조회 jck
	@Override
	public List<Map<String, Object>> retrieveAttendanceLecture(Map<String, Object> map) {
		return dao.selectAttendanceLecture(map);
	}
}
