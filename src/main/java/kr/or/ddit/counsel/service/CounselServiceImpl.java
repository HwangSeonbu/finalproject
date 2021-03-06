package kr.or.ddit.counsel.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.counsel.dao.CounselDAO;
import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.exception.PKNotFoundException;
import kr.or.ddit.vo.CounselVO;
import kr.or.ddit.vo.PagingVO;
import kr.or.ddit.vo.ProCounselVO;
import kr.or.ddit.vo.QuestionAnswerVO;
import kr.or.ddit.vo.QuestionVO;
import kr.or.ddit.vo.SCounselVO;
import lombok.extern.slf4j.Slf4j;
/**counselService 구현체
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
@Service
@Slf4j
public class CounselServiceImpl implements CounselService {
	@Inject
	private CounselDAO dao;
	
	@Override
	public List<SCounselVO> retreiveCounselStu(PagingVO<SCounselVO> paging) {
		//총 레코드 수
		int totalRecord = dao.stuCounselTotalRecord(paging);
		paging.setTotalRecord(totalRecord);
		List<SCounselVO> counselList = dao.studentSelectCounselList(paging);
		paging.setDataList(counselList);
		log.info("{}",counselList);
		
		return counselList;
	}

	@Override
	public List<QuestionVO> listQuestion() {
	
		List<QuestionVO> list = dao.selectQuestion();
	
		return list;
	}




	@Override
	public ServiceResult createCounsel(CounselVO counsel) {
		ServiceResult sr=null;
		//1. counsel table insert
		
	
		
		int cRowcnt = dao.insertReqCounsel(counsel);
		if(cRowcnt>0) {
			List<String> answerList = new ArrayList<>();
			answerList.add(counsel.getR1());
			answerList.add(counsel.getR2());
			answerList.add(counsel.getR3());
			answerList.add(counsel.getR4());
			answerList.add(counsel.getR5());
			answerList.add(counsel.getR6());
			answerList.add(counsel.getR7());
			answerList.add(counsel.getR8());
			answerList.add(counsel.getQaLong());
			
			//2. QA table insert(다중 문답 insert)	
			int qaRowcnt=0;
			int num=0;
			for(int i=1; i<=8; i++) {
				QuestionAnswerVO qaVO = new QuestionAnswerVO();
				String questNo = "r"+(num+1);
				String ansNo = answerList.get(i-1);
				log.info("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~{}",ansNo);
				qaVO.setAnsNo(ansNo);
				qaVO.setQuestNo(questNo);
				qaRowcnt=dao.insertQA(qaVO);
				
				num++;
			}
			//장문 저장
			QuestionAnswerVO qaVO = new QuestionAnswerVO();
			String qaLong = answerList.get(8);
			qaVO.setAnsNo("LONG");
			qaVO.setQaLong(qaLong);
			qaVO.setQuestNo("r9");			
			if(dao.insertQA(qaVO)>0) {
				num++;
			}
			log.info("numnumnumnumnumnumnumnumnumnumnumnumnumnumnumnum{}",num);
			if(num==9) {
				sr= ServiceResult.OK;
			}
		}else {
			sr=ServiceResult.FAIL;
		}
		return sr;
	}

	
	@Override
	public List<ProCounselVO> retreiveCounselPro(PagingVO<ProCounselVO> paging) {
		//총 레코드 수
		int totalRecord = dao.proCounselTotalRecord(paging);
		paging.setTotalRecord(totalRecord);
		List<ProCounselVO> dataList = dao.proSelectCounselList(paging);
		
		paging.setDataList(dataList);
		
		return dataList;
	}

	@Override
	public ProCounselVO retreiveOneCounselStudent(Integer userNo) {
		
		log.info("**************************");
		ProCounselVO result = dao.selectOneCounselStudent(userNo);
		if(result==null)
			throw new PKNotFoundException(userNo+"에 해당하는 학번이 없습니다.");
		
		return result;
	}

	@Override
	public Map<String, Object> retreiveOneReqCounsel(String cnslId) {
		Map<String, Object> qaMap = new HashMap<>();
		List<QuestionAnswerVO>qaList = dao.selectOneReqCounsel(cnslId);
		if(qaList==null)
			throw new PKNotFoundException(cnslId+"에 해당하는 신청번호가 없습니다.");
		for(int i=0; i<=qaList.size()-1; i++) {
			qaMap.put("cnslDate", qaList.get(i).getCnslDate());
			//Map<-문,답
			if(qaList.get(i).getAnsNo().equals("LONG")){
				qaMap.put(qaList.get(i).getQuestNo(), qaList.get(i).getQaLong());
			}else {
				qaMap.put(qaList.get(i).getQuestNo(), qaList.get(i).getAnsNo());							
			}
		}
		
			
		return qaMap;
	}
	
	public List<String> retreiveOneLogCounsel(String cnslId, ProCounselVO counsel){
		List<String> aList = new ArrayList<>();
		List<QuestionAnswerVO>qaList = dao.selectOneReqCounsel(cnslId);
		if(qaList==null)
			throw new PKNotFoundException(cnslId+"에 해당하는 신청번호가 없습니다.");
		for(int i=0; i<=qaList.size()-1; i++) {
			
			counsel.setDyDate(qaList.get(i).getDyDate());
			//Map<-문,답
			if(qaList.get(i).getAnsNo().equals("LONG2")){
				counsel.setL3(qaList.get(i).getQaLong());
				log.info("!!!!!!!!!!!!!!!!!!!!!!!!!!!!{}",counsel.getL3());
			}else if(qaList.get(i).getAnsNo().equals("LONG")) {
				continue;
			}			
			else{
				aList.add(qaList.get(i).getAnsNo());
			}
		}
		return aList;
		
	}

	@Override
	public ServiceResult createCounselLog(CounselVO counselVO) {
		ServiceResult sr = ServiceResult.OK;
		String cnslId = counselVO.getCnslId();
		int result1 = dao.updatedyDate(counselVO);
		
		if(result1>0) {
		
			int num = 0;
	
			//L1 insert
			List<String> b1 = counselVO.getL1();
			for(String b1small : b1) {
				QuestionAnswerVO qaVO = new QuestionAnswerVO();
				qaVO.setCnslId(cnslId);
				qaVO.setQuestNo("L1");
				qaVO.setAnsNo(b1small);
				log.info("************{}****************",qaVO.getQuestNo());
				num += dao.insertCounselLog(qaVO);	
			}
			//L2 insert
			List<String>b2 = counselVO.getL2();
			for(String b2small : b2) {
				QuestionAnswerVO qaVO = new QuestionAnswerVO();
				qaVO.setCnslId(cnslId);
				qaVO.setQuestNo("L2");
				qaVO.setAnsNo(b2small);
				
				num += dao.insertCounselLog(qaVO);	
			}
			
			//qaLong insert
			QuestionAnswerVO qaVO = new QuestionAnswerVO();
			String qaLong = counselVO.getL3();
			if(qaLong==null) {
				qaLong="";
			}			
			qaVO.setCnslId(cnslId);
			qaVO.setQuestNo("L3");
			qaVO.setQaLong(qaLong);
			qaVO.setAnsNo("LONG2");
			int result = dao.insertCounselLog(qaVO);
			if(result>0) {
				num++;
			}
			//insert성공 수
			int insertSize =b1.size()+b2.size()+1;
			if(num!=insertSize) {
				sr=ServiceResult.FAIL;
			}
			
			
		}else {
			sr=ServiceResult.FAIL;
		}
		return sr;
	}

	@Override
	public ServiceResult modifyCounselLog(CounselVO counselVO) {
		//cnslId입력.
		//delete
		ServiceResult fResult=null;
		int result = dao.deleteCounselLog(counselVO.getCnslId());
		//insert
		if(result>0) {			
			ServiceResult sr = createCounselLog(counselVO);
			
			if(sr.equals(ServiceResult.OK)) {
				fResult=ServiceResult.OK;
			}else {
				fResult=ServiceResult.FAIL;
			}
		}else {
			fResult=ServiceResult.FAIL;
		}
		return fResult;
	}

	@Override
	public ServiceResult deleteCounselLog(String cnslId) {
		ServiceResult result = null;
		CounselVO counsel= new CounselVO();
		counsel.setCnslId(cnslId);
		counsel.setDyDate("");
		log.info("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%{}",cnslId);
		int dresult =  dao.updatedyDate(counsel);
		
		int rowcnt = 0;
		if(dresult>0) {			
			rowcnt = dao.deleteCounselLog(cnslId);
		}
		
		return result = rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public ServiceResult modifyMessageInfo(CounselVO counsel) {
		//counselVO에서 날짜 장소 조합해야함.
		ServiceResult result = null;
		
		int rowcnt = dao.updateMessageInfo(counsel);
		
		if(rowcnt>0) {
			result =ServiceResult.OK;
		}else {
			result = ServiceResult.FAIL;
		}
		return result;
	}




}














