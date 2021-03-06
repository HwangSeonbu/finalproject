package kr.or.ddit.scholarship.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

import kr.or.ddit.scholarship.dao.AdminScholarshipDAO;
import kr.or.ddit.vo.AdminScholarshipVO;
import kr.or.ddit.vo.RequestVO;
import kr.or.ddit.vo.SemsVO;

/**
 * @author 고성식
 * @since 2022. 5. 9.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2022. 5. 9.    고성식		       최초작성
 * Copyright (c) 2022 by DDIT All right reserved
 * </pre>
 */
@Service
public class AdminScholarshipServiceImpl implements AdminScholarshipService {

	@Inject
	AdminScholarshipDAO dao;
	
	@Override
	public int retrieveScholarshipListTotalCount(Map<String, Object> param) {
		return dao.selectTotalRecord(param);
	}

	@Override
	public List<AdminScholarshipVO> retrieveScholarshipList(Map<String, Object> param) {
		return dao.selectScholarshipList(param);
	}

	@Override
	public int createScholarshipStu(List<RequestVO> list){
		SemsVO semsVo = (SemsVO) RequestContextHolder.getRequestAttributes()
                .getAttribute("semsVo", RequestAttributes.SCOPE_SESSION);
		int nextSems = semsVo.getNextSems();
		int result = 0;
		
		for(RequestVO vo : list) {
			vo.setEnrSems(nextSems);
			result += dao.insertScholarshipSts(vo);
			result += dao.updateEnrollSts(vo);
		}
		return result;
	}

	@Override
	public List<AdminScholarshipVO> retrieveTotalScholarshipList(Map<String, Object> param) {
		return dao.selectTotalScholarshipList(param);
	}

	@Override
	public int retrieveTotalScholarshipListCount(Map<String, Object> param) {
		return dao.selectTotalScholarshipRecord(param);
	}

	@Override
	public List<AdminScholarshipVO> retrieveEtcScholarshipList(Map<String, Object> param) {
		return dao.selectEtcScholarshipList(param);
	}

	@Override
	public int retrieveTotalEtcScholarshipListCount(Map<String, Object> param) {
		return dao.selectTotalEtcScholarshipRecord(param);
	}

	@Override
	public int updateEtcScholarship(List<AdminScholarshipVO> list) throws Exception {
		int result = 0;
		
		for(AdminScholarshipVO vo : list) {
			vo.setReqStat("B102");
			result += dao.updateEtcScholarshipSts(vo);
			result += dao.updateEtcEnrollSts(vo);
		}
		return result;
	}

	@Override
	public int referEtcScholarship(List<AdminScholarshipVO> list) throws Exception {
		int result = 0;
		
		for(AdminScholarshipVO vo : list) {
			vo.setReqStat("B103");
			result += dao.updateReferEtcScholarship(vo);
		}
		return result;
	}


	
	
	


}
