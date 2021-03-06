package kr.or.ddit.calendar.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.calendar.dao.CalendarDAO;
import kr.or.ddit.vo.CalendarVO;

/**
 * @author 이유정
 * @since 2022. 5. 4.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2022. 5. 4.      이유정       최초작성
 * Copyright (c) 2022 by DDIT All right reserved
 * </pre>
 */
@Service
public class CalendarServiceImpl implements CalendarService {

	@Inject
	private CalendarDAO dao;

	@Override
	public List<CalendarVO> getAllCalendar(int acadscUserno) {
		List<CalendarVO> dataList = dao.selectCalendarList(acadscUserno);
		
		for(CalendarVO eachVo : dataList) {
			String acadscColor = eachVo.getAcadscDiv().equals("B1") ? "red":"blue";
			eachVo.setAcadscColor(acadscColor);
		}
		return dataList;
	}

	@Override
	public int createCalendar(CalendarVO calendarVo) {
		return dao.insertCalendar(calendarVo);
	}

	@Override
	public CalendarVO retrieveCalendar(Integer acadscNo) {
		
		return dao.selectCalendar(acadscNo);
	}



	@Override
	public int removeCalendar(Integer acadscNo) {
		return dao.deleteCalendar(acadscNo);
		
	}

	@Override
	public int modifyCalendar(CalendarVO calendarVo) {
		return dao.updateCalendar(calendarVo);
		
	}


	
	
}
