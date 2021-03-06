package kr.or.ddit.lecboard.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.ClassVO;
import kr.or.ddit.vo.LecNoticeBoardVO;
import kr.or.ddit.vo.PagingVO;
import kr.or.ddit.vo.UserVO;

/**강의 질의응답 게시판
 * @author 황선부
 * @since 2022. 5. 13.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2022. 5. 13.      황선부       최초작성
 * Copyright (c) 2022 by DDIT All right reserved
 * </pre>
 */
@Mapper
public interface LecBoardDAO {
	/** 한 학생의 당 학기 수강 과목 불러오기
	 * @param stuNo 학번
	 * @return List<Map<String, Object>>
	 */
	public List<Map<String, Object>> selectLectureListOfStu(int stuNo);
	
	
	public List<Map<String, Object>> selectLectureListOfPro(int userNo);
	
	
	/**board main페이지의 수강 학생 조회
	 * @param classVO(required=lecSems,lecId)
	 * @return List<UserVO>
	 */
	public List<UserVO> selectLecUserList(ClassVO classVO);
	
	/**해당 아이디의 해당 강의 수강여부 조회
	 * @param classVO
	 * @return
	 */
	public int selectAuthenLecUserNo(ClassVO classVO);
	
	/**페이징 totalSelect
	 * @param paging
	 * @return
	 */
	public int selectTotalLecBoardRecord(PagingVO<LecNoticeBoardVO> paging);
	
	/**공지 사항 List 조회
	 * @param paging
	 * @return
	 */
	public List<LecNoticeBoardVO> selectLecBoard(PagingVO<LecNoticeBoardVO> paging);
	
	/**
	 * @param lecboardVO
	 * @return
	 */
	public LecNoticeBoardVO selectOneLecBoard(Integer lecboNo);
	/**lecbo 조회수 증가
	 * @param boNo
	 */
	public void incrementHit(Integer lecboNo);
	
	/**강의 공지사항 insert
	 * @param lecBoardVO
	 * @return
	 */
	public int insertLecNoticeBoard(LecNoticeBoardVO lecBoardVO);
	
	/**강의 공지사항 UPDATE
	 * @param lecBoardVO
	 * @return
	 */
	public int updateLecNoticeboard(LecNoticeBoardVO lecBoardVO);
	
	/**강의 공지사항 DELETE
	 * @param lecNoticeBoardVO
	 * @return
	 */
	public int deleteBoard(LecNoticeBoardVO lecNoticeBoardVO);
	
	/**강의 명, 강의교수 구하기
	 * @param lecId
	 * @return
	 */
	public Map<String, Object> selectOneLec(String lecId); 
	
	public List<Map<String , Object>> selectOneLecStus(String lecId);
}

//질문답변
//중복.
//강의 자료
//과제
