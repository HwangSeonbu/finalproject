package kr.or.ddit.counsel.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.CounselVO;
import kr.or.ddit.vo.DepartmentVO;
import kr.or.ddit.vo.PagingVO;
import kr.or.ddit.vo.ProCounselVO;
import kr.or.ddit.vo.ProfessorVO;
import kr.or.ddit.vo.QuestionAnswerVO;
import kr.or.ddit.vo.QuestionVO;
import kr.or.ddit.vo.SCounselVO;
import kr.or.ddit.vo.StudentVO;
/**
 * 상담신청 DAO
 * @author 황선부
 * @since 2022. 5. 3.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2022. 5. 3.      황선부       최초작성
 * Copyright (c) 2022 by DDIT All right reserved
 * </pre>
 */
@Mapper
public interface CounselDAO {
	//학생
	//1.학생 상담테이블가져오기
	//2.상담신청 등록
	//3.insert 질문답 등록
	//교수
	
/**상담 이력 조회 (학생 한명의 이력조회)
 * @param paging
 * @return List, null
 */
public List<SCounselVO> studentSelectCounselList(PagingVO<SCounselVO> paging);	
/**학생상담테이블 레코드 수 조회
 * @param paging
 * @return 
 */
public int stuCounselTotalRecord(PagingVO<SCounselVO> paging);

/**상담문 출력
 * @return 
 */
public List<QuestionVO> selectQuestion();

public List<DepartmentVO> selectdepartment();

public List<ProfessorVO> selectProfessor(String deptId);

/**학생 상담 신청 등록
 * @param counselVO
 * @return
 */
public int insertReqCounsel(CounselVO counselVO);

/**학생 상담 문답 등록
 * @param qaVO
 * @return
 */
public int insertQA(QuestionAnswerVO qaVO);

/**교수의 학생 상담이력 조회
 * @param paging
 * @return
 */
public List<ProCounselVO> proSelectCounselList(PagingVO<ProCounselVO> paging);

/**교수의 상담이력조회 레코드 조회
 * @param paging
 * @return 
 */
public int proCounselTotalRecord(PagingVO<ProCounselVO> paging);

/**상담신청서 조회
 * @param 학생번호 userNo
 * @return
 */
public QuestionAnswerVO selectReqCounsel(Integer userNo);


//상담번호->학생번호->상담조회
//학생 vo
//param 학생아이디만 
/**학생 상세조회
 * @param userNo
 * @return {@link StudentVO}
 */
public ProCounselVO selectOneCounselStudent(Integer userNo);



//post 전달-> 아이디, 상담번호
//상담번호
/**상담번호 문답 조회
 * @param cnslId
 * @return 
 */
public List<QuestionAnswerVO> selectOneReqCounsel(String cnslId);

/**날짜 업데이트
 * @param dyDate
 * @return
 */

public int updatedyDate(CounselVO counselVO);
/**상담일지 등록
 * @param qaVO
 * @return
 */
public int insertCounselLog(QuestionAnswerVO qaVO);
/**상담일지 조회
 * @param qaVO
 * @return
 */
public QuestionAnswerVO selectCounsellog(QuestionAnswerVO qaVO);


/**상담일지 수정
 * @param qaVO
 * @return
 */
public int updateCounselLog(QuestionAnswerVO qaVO);

/**상담일지 삭제
 * @param cnslId
 * @return
 */
public int deleteCounselLog(String cnslId);

/**상담 예정일, 상담 장소 insert
 * @param counsel
 * @return 
 */
public int updateMessageInfo(CounselVO counsel);

}




