package kr.or.ddit.scholarship.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.AdminScholarshipVO;
import kr.or.ddit.vo.RequestVO;

/**
 * 장학생을 선발하는 DAO
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
@Mapper
public interface AdminScholarshipDAO {
	
	/**
	 * 성적우수장학생 List
	 * @param vo
	 * @return
	 */
	public List<AdminScholarshipVO> selectScholarshipList(Map<String, Object> param);
	
	/**
	 * @param paging
	 * @return
	 */
	public int selectTotalRecord(Map<String, Object> param);
	
	/**
	 * 성적우수 장학생 승인 
	 * @param vo
	 * @return
	 */
	public int insertScholarshipSts(RequestVO vo);
	
	public int updateEnrollSts(RequestVO vo);
	
	/**
	 * 모든 장학생 List
	 * @param param
	 * @return
	 */
	public List<AdminScholarshipVO> selectTotalScholarshipList(Map<String, Object> param);
	
	/**
	 * @param paging
	 * @return
	 */
	public int selectTotalScholarshipRecord(Map<String, Object> param);
	
	/**
	 * 기타 장학생 List
	 * @param vo
	 * @return
	 */
	public List<AdminScholarshipVO> selectEtcScholarshipList(Map<String, Object> param);
	
	/**
	 * 
	 * @param paging
	 * @return
	 */
	public int selectTotalEtcScholarshipRecord(Map<String, Object> param);
	
	/**
	 * 기타 장학생 승인
	 * @param vo
	 * @return
	 */
	public int updateEtcScholarshipSts(AdminScholarshipVO vo);
	public int updateEtcEnrollSts(AdminScholarshipVO vo);
	
	/**
	 * 기타 장학생 반려했을때 반려사유
	 * @param vo
	 * @return
	 */
	public int updateReferEtcScholarship(AdminScholarshipVO vo);
	
}
