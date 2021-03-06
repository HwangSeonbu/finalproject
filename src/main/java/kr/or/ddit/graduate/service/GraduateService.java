package kr.or.ddit.graduate.service;

import java.util.List;

import kr.or.ddit.vo.GraduateVO;
import kr.or.ddit.vo.PagingVO;

/**
 * @author 고성식
 * @since 2022. 5. 11.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2022. 5. 11.    고성식  	     최초작성
 * Copyright (c) 2022 by DDIT All right reserved
 * </pre>
 */
public interface GraduateService {

	/**
	 * 학생 목록 조회
	 * @param paging
	 * @return 검색 조건에 맞는 학생 없으면, size()==0
	 */
	public List<GraduateVO> retrieveStudentList(PagingVO<GraduateVO> paging);
	
	/**
	 * 학생 상세조회
	 * @param userNo
	 * @return
	 */
	public GraduateVO retriveStudent(Integer userNo);
	
	/**
	 * 졸업 가능 학생 리스트 조회
	 * @param paging
	 * @return
	 */
	public List<GraduateVO> retreiveTargetStudentList(PagingVO<GraduateVO> paging);
	
	
	public int updateGraduateSts(List<GraduateVO> list) throws Exception;
	
}
