package kr.or.ddit.request.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.request.dao.RequestDAO;
import kr.or.ddit.vo.PagingVO;
import kr.or.ddit.vo.RequestVO;
import lombok.extern.slf4j.Slf4j;

/**
 * 학색 휴복학 신청 service
 * @author 고성식
 * @since 2022. 5. 4.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2022. 5. 4.    고성식			 최초 작성
 * Copyright (c) 2022 by DDIT All right reserved
 * </pre>
 */
@Service
@Slf4j
public class RequestServiceImpl implements RequestService {
	
	@Inject
	private RequestDAO dao;
	
	@Override
	public List<RequestVO> retrieveStudentLeaveRequestList(PagingVO<RequestVO> paging) {
		int totalRecord = dao.selectTotalRecord(paging);
		paging.setTotalRecord(totalRecord);
		List<RequestVO> dataList = dao.selectStudentRequestList(paging);
		paging.setDataList(dataList);
		
		log.info("{}", dataList);
		return dataList;
	}

	@Override
	public int updateLeaveSts(List<RequestVO> list) throws Exception {
		int result = 0;
		
		for(RequestVO vo : list) {
			vo.setStuCode("C102");
			result += dao.updateLeaveSts(vo);
			vo.setReqStat("B102");
			result += dao.updateLeaveReq(vo);
		}
		return result;
	}

	@Override
	public int referLeaveSts(List<RequestVO> list) throws Exception {
		int result = 0;
		
		for(RequestVO vo : list) {
			vo.setReqStat("B103");
			result += dao.updateReferLeaveSts(vo);
		}
		return result;
	}

	@Override
	public String studentLeaveRequest(RequestVO requestVO) throws Exception {
		// 해당학기 신청내역 확인 : 신청내역이 있는 경우 신청 불가 처리
		int count = dao.selectRequestLeaveStsCount(requestVO);
		
		if(count == 0) {
			dao.insertRequestLeaveSts(requestVO);
			return "휴학 신청이 완료되었습니다.";
		}else {
			return "이미 휴학 신청 했습니다.";
		}
	}

	@Override
	public List<RequestVO> retrieveStudentReturnRequestList(PagingVO<RequestVO> paging) {
		int totalRecord = dao.selectReturnTotalRecord(paging);
		paging.setTotalRecord(totalRecord);
		List<RequestVO> dataList = dao.selectStudentReturnRequestList(paging);
		paging.setDataList(dataList);
		
		log.info("{}", dataList);
		return dataList;
	}

	@Override
	public int updateReturnSts(List<RequestVO> list) throws Exception {
		int result = 0;
		
		for(RequestVO vo : list) {
			vo.setStuCode("C101");
			result += dao.updateReturnSts(vo);
			vo.setReqStat("B102");
			result += dao.updateReturnReq(vo);
		}
		return result;
	}

	@Override
	public void studentReturnRequest(RequestVO requestVO) throws Exception {
		// 해당학기 신청내역 확인 : 신청내역이 있는 경우 신청 불가 처리
		int count = dao.selectRequestReturnStsCount(requestVO);
		
		if(count == 0) {
			dao.insertRequestReturnSts(requestVO);
		}
	}

	@Override
	public List<RequestVO> selectStudentLeaveRequestList(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return dao.selectStudentLeaveRequestList(param);
	}


	

}
