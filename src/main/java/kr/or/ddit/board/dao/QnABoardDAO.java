package kr.or.ddit.board.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.vo.PagingVO;
import kr.or.ddit.vo.QnABoardVO;
import kr.or.ddit.vo.ReplyVO;

/**
 * @author 이유정
 * @since 2022. 5. 10.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2022. 5. 10.      이유정       최초작성
 * Copyright (c) 2022 by DDIT All right reserved
 * </pre>
 */
@Mapper
public interface QnABoardDAO {
	/**
	 * 전체 게시물 수
	 * @param paging
	 * @return
	 */
	public int selectTotalQRecord(PagingVO<QnABoardVO> paging);
	/**
	 * 게시물 목록 조히 
	 * @param paging
	 * @return 조건에 맞는 레코드가 없는 경우, size()==0
	 */
	public List<QnABoardVO> selectQBoardList(PagingVO<QnABoardVO> paging);
	/**
	 * 게시물 정보 상세 조회 
	 * @param boardNo
	 * @return
	 */
	public QnABoardVO selectQBoard(String boardNo);
	/**
	 * 신규 질문게시물 등록 
	 * @param qBoard
	 * @return
	 */
	public int insertQBoard (QnABoardVO qBoard);
	/**
	 * 조회수 
	 * @param boardNo
	 */
	public void incrementHit(String boardNo);
	/**
	 * 삭제 
	 * @param boardNo
	 */
	public void deleteQBoard(String boardNo);
	/**
	 * 수정
	 * @param qBoard
	 */
	public void updateQBoard(QnABoardVO qBoard);

	
}
