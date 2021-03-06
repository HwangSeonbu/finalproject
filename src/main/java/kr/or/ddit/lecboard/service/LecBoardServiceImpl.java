package kr.or.ddit.lecboard.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.inject.Inject;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.exception.PKNotFoundException;
import kr.or.ddit.lecboard.dao.AttachDAO;
import kr.or.ddit.lecboard.dao.LecBoardDAO;
import kr.or.ddit.utils.PasswordUtils;
import kr.or.ddit.vo.AttchVO;
import kr.or.ddit.vo.ClassVO;
import kr.or.ddit.vo.LecNoticeBoardVO;
import kr.or.ddit.vo.PagingVO;
import kr.or.ddit.vo.UserVO;
import lombok.extern.slf4j.Slf4j;

/**강의 게시판 ServiceImpl
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
@Slf4j
@Service
public class LecBoardServiceImpl implements LecBoardService {
	
	@Inject
	private LecBoardDAO boardDAO;
	@Autowired
	private AttachDAO attachDAO;
	
	@Value("#{appInfo.attatchPath}")
	private File saveFolder;
	
	@Override
	public List<Map<String, Object>> retrieveLectureListOfStu(int stuNo) {
		
		List<Map<String,Object>> result = boardDAO.selectLectureListOfStu(stuNo);
		if(result==null)
			throw new PKNotFoundException(stuNo+"에 해당하는 학번이 없습니다.");
		
		return result;
	}
	@Override
	public List<Map<String, Object>> retrieveLectureListOfPro(int userNo) {
		List<Map<String,Object>> result = boardDAO.selectLectureListOfPro(userNo);
		if(result==null)
			throw new PKNotFoundException(userNo+"에 해당하는 교수번호가 없습니다.");
		
		return result;
	}

	@Override
	public List<UserVO> retrieveLecUserList(ClassVO classVO) {
		List<UserVO> userList = boardDAO.selectLecUserList(classVO);
		return userList;
	}

	@Override
	public ServiceResult retrieveLecAuthenUser(ClassVO classVO) {
		ServiceResult sr = null;
		int count = boardDAO.selectAuthenLecUserNo(classVO);

		return count>0 ? ServiceResult.OK : ServiceResult.FAIL;	
	}

	@Override
	public void retrieveLecBoard(PagingVO<LecNoticeBoardVO> paging) {
		int totalRecord = boardDAO.selectTotalLecBoardRecord(paging);
		paging.setTotalRecord(totalRecord);
		List<LecNoticeBoardVO> dataList = boardDAO.selectLecBoard(paging);
		paging.setDataList(dataList);
	}

	@Override
	public LecNoticeBoardVO retrieveOneLecBoard(Integer lecboNo) {
		LecNoticeBoardVO board =boardDAO.selectOneLecBoard(lecboNo);
		if(board==null) {
			throw new PKNotFoundException(String.format("%d 번 글이 없음.", lecboNo));
		}
		boardDAO.incrementHit(lecboNo);
		
		return board;
	}
	@Override
	public ServiceResult createlecBoard(LecNoticeBoardVO lecNotice) {
		int rowcnt = boardDAO.insertLecNoticeBoard(lecNotice);
		ServiceResult result = null;
		if(rowcnt > 0) {
			uploadAttatches(lecNotice);
		}
		return rowcnt>0?ServiceResult.OK:ServiceResult.FAIL;
		
	}
	private void uploadAttatches(LecNoticeBoardVO board) {
		List<AttchVO> attatchList = board.getAttchList();
		if(attatchList==null || attatchList.isEmpty())
			return;
		attachDAO.insertAttach(board);
		attatchList.forEach((attach)->{
			try {
				attach.saveTo(saveFolder);
			}catch(IOException e) {
				throw new RuntimeException(e);
			}
		});
		
	}
	@Override
	public AttchVO downloadAttach(Integer attchNo) {
		AttchVO attch = attachDAO.selectAttach(attchNo);
		if(attch==null) 
			throw new PKNotFoundException(String.format("%d 번 파일이 없음", attchNo));
		return attch;
	}
	@Override
	public ServiceResult modifyBoard(LecNoticeBoardVO lecNotice) {
		LecNoticeBoardVO saved = boardDAO.selectOneLecBoard(lecNotice.getLecboNo());
		ServiceResult result = null;
		
//		if(authenticate(lecNotice,saved)) {
			int rowcnt = boardDAO.updateLecNoticeboard(lecNotice);
			if(rowcnt>0) {
				deleteAttaches(lecNotice);
				uploadAttatches(lecNotice);
				
				result = ServiceResult.OK;
			}else {
				result = ServiceResult.FAIL;
			}
//		}else {
//			result = ServiceResult.INVALIDPASSWORD;
//		}
		return result;
	}
	
	private void deleteAttaches(LecNoticeBoardVO board) {
		
		int[] delAttNos = board.getDelAttNos();
		log.info("delAttNos : ========>>>{}",delAttNos);
		if(delAttNos==null || delAttNos.length==0) return;
		
		
		List<String> saveNames= Arrays.stream(delAttNos).mapToObj((delAttNo) -> 
			{return attachDAO.selectAttach(delAttNo).getAttchSname();}).collect(Collectors.toList());
		
		attachDAO.deleteAttaches(board);
		saveNames.forEach((saveName)->{
			FileUtils.deleteQuietly(new File(saveFolder,saveName));
		});
		
	}
//	private boolean authenticate(LecNoticeBoardVO input, LecNoticeBoardVO saved) {
//		return PasswordUtils.passwordMatcher(input.getLecboPass(), saved.getLecboPass());
//	}
	@Override
	public ServiceResult removeBoard(LecNoticeBoardVO board) {
		LecNoticeBoardVO lecboVO = boardDAO.selectOneLecBoard(board.getLecboNo());
		ServiceResult result = null;
		
		log.info("lecboVO=>>>{}",lecboVO);
		List<AttchVO> attachList = lecboVO.getAttchList();
//		List<AttchVO> attachList = new ArrayList<>();
		log.info("attachList=>>>{}",attachList);
		int[] delAttNos = attachList.stream().mapToInt((attach)->attach.getAttchNo()).toArray();
		log.info("delAttNos=>>>{}",delAttNos);
		lecboVO.setDelAttNos(delAttNos);
		
		deleteAttaches(lecboVO);
		
		int rowcnt = boardDAO.deleteBoard(board);
		
		return rowcnt>0?ServiceResult.OK:ServiceResult.FAIL;
	}
	@Override
	public Map<String, Object> retrieveOneLec(String lecId) {
		return boardDAO.selectOneLec(lecId);
	}
	@Override
	public List<Map<String, Object>> retrieveOneLecStus(String lecId) {
		
		return boardDAO.selectOneLecStus(lecId);
	}

	



}
