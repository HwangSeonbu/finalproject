package kr.or.ddit.ast.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

import kr.or.ddit.ast.dao.AssessmentDAO;
import kr.or.ddit.vo.AstLecVO;
import kr.or.ddit.vo.AstProVO;
import kr.or.ddit.vo.AstResultVO;
import kr.or.ddit.vo.AstVO;
import kr.or.ddit.vo.OrderVO;
import kr.or.ddit.vo.ProfessorLectureVO;
import kr.or.ddit.vo.SemsVO;

@Service
public class AssessmentServiceImpl implements AssessmentService {

	@Inject
	AssessmentDAO dao;
	
	@Override
	public List<AstLecVO> retrieveAstTargetLecList(Map<String, Integer> paramMap) {
		List<AstLecVO> targetList = dao.selectAstTargetLecList(paramMap);
		for(AstLecVO eachVo : targetList) {
			String astYn = eachVo.getAstCnt() > 0 ? "완료":"미완료";
			eachVo.setAstYn(astYn);
		}
		return targetList;
	}

	@Override
	public List<AstProVO> retrieveAstTargetProList(Map<String, Integer> paramMap) {
		List<AstProVO> targetList = dao.selectAstTargetProList(paramMap);
		for(AstProVO eachVo : targetList) {
			String astYn = eachVo.getAstCnt() > 0 ? "완료":"미완료";
			eachVo.setAstYn(astYn);
		}
		return targetList;
	}

	@Override
	public int createAssessment(Map<String, Object> paramMap) {
		String lecId = null;
		Integer proNo = null;
		
		int userNo = (int) paramMap.get("userNo");
		int lecSems = (int) paramMap.get("thisSems");
		String astAnswer = (String) paramMap.get("qList");
		String astEtc = (String) paramMap.get("opnion");
		String astDiv = (String) paramMap.get("flag");
		if(astDiv.equals("강의")) {
			lecId = (String) paramMap.get("lecId");
		}else {
			proNo = (Integer) paramMap.get("proNo");
		}
		
		String[] answerArr = astAnswer.split(",");
		double astScore = 0;
		for(String eachAnswer : answerArr) {
			astScore += Double.parseDouble(eachAnswer);
		}
		astScore = Math.round(astScore/(answerArr.length*5.0)*10000)/100.0;
		AstVO vo = new AstVO();
		vo.setAstScore(astScore);
		vo.setAstDiv(astDiv);
		vo.setLecId(lecId);
		vo.setLecSems(lecSems);
		vo.setUserNo(userNo);
		vo.setAstEtc(astEtc);
		vo.setProNo(proNo);
		vo.setAstAnswer(astAnswer);
		
		dao.insertAssessment(vo);
		return 0;
	}

	@Override
	public List<AstResultVO> retrieveProAstResultList(OrderVO vo) {
		SemsVO semsVo = (SemsVO) RequestContextHolder.getRequestAttributes()
                .getAttribute("semsVo", RequestAttributes.SCOPE_SESSION);
		int thisSems = semsVo.getThisSems();
		vo.setThisSems(thisSems);
		
		List<AstResultVO> resultList = dao.selectProAstResultList(vo);
		
		for(AstResultVO eachVo : resultList) {
			double realpers = eachVo.getLecRealpers();
			double astpers = eachVo.getAstPers();
			double comRate = 0.0;
			if(realpers!=0) {
				comRate = (astpers/realpers);
				comRate = Math.round(comRate*10000)/100.0;
				eachVo.setAstComprate(""+comRate+"%");
			}else {
				eachVo.setAstComprate("-");
			}
		}
		
		return resultList;
	}

	@Override
	public List<AstResultVO> retrieveLecAstResultList(OrderVO vo) {
		SemsVO semsVo = (SemsVO) RequestContextHolder.getRequestAttributes()
                .getAttribute("semsVo", RequestAttributes.SCOPE_SESSION);
		int thisSems = semsVo.getThisSems();
		vo.setThisSems(thisSems);
		
		List<AstResultVO> resultList = dao.selectLecAstResultList(vo);
		
		for(AstResultVO eachVo : resultList) {
			double realpers = eachVo.getLecRealpers();
			double astpers = eachVo.getAstPers();
			double comRate = 0.0;
			if(realpers!=0) {
				comRate = (astpers/realpers);
				comRate = Math.round(comRate*10000)/100.0;
				eachVo.setAstComprate(""+comRate+"%");
			}else {
				eachVo.setAstComprate("-");
			}
		}
		return resultList;
	}

	@Override
	public List<AstResultVO> retrieveProAstCompResult(OrderVO vo) {
		SemsVO semsVo = (SemsVO) RequestContextHolder.getRequestAttributes()
                .getAttribute("semsVo", RequestAttributes.SCOPE_SESSION);
		int thisSems = semsVo.getThisSems();
		vo.setThisSems(thisSems);
		List<AstResultVO> compList = dao.selectProAstCompResult(vo);
		for(AstResultVO eachVo : compList) {
			if(eachVo.getAstComprate().equals("-")) {
				eachVo.setAstScore(0);
			}
		}
		return compList;
	}

	@Override
	public List<AstResultVO> retrieveLecAstCompResult(OrderVO vo) {
		SemsVO semsVo = (SemsVO) RequestContextHolder.getRequestAttributes()
                .getAttribute("semsVo", RequestAttributes.SCOPE_SESSION);
		int thisSems = semsVo.getThisSems();
		vo.setThisSems(thisSems);
		List<AstResultVO> compList = dao.selectLecAstCompResult(vo);
		for(AstResultVO eachVo : compList) {
			if(eachVo.getAstComprate().equals("-")) {
				eachVo.setAstScore(0);
			}
		}
		return compList;
	}

	
	
	@Override
	public AstVO retrieveLecAstDetailResult(AstVO vo) {
		List<String> astEtcList = new ArrayList<>();
		List<Double> astAnswerList = new ArrayList<>();
		double[] answerSum = new double[13];
		
		List<AstVO> resList = dao.selectLecAstDetailResult(vo);
		int resLength = resList.size();
		if(resLength == 0) {
			return vo;
		}
		double resultScore = 0.0;
		
		for(AstVO eachVo : resList) {
			resultScore += eachVo.getAstScore();
			if(eachVo.getAstEtc() != null) {
				astEtcList.add(eachVo.getAstEtc());
			}
			double[] answers = eachVo.getAnswerFlArr();
			int answersLength = answers.length;
			
			for(int i=0; i<answersLength; i++) {
				answerSum[i] += answers[i];
			}
		}
		resultScore = Math.round(resultScore/resLength*100)/100.0;
		vo.setAstScore(resultScore);
		vo.setAstEtcList(astEtcList);
		
		for(int i=0; i<answerSum.length; i++) {
			astAnswerList.add(Math.round(answerSum[i]/resLength*100)/100.0);
		}
		
		vo.setAstAnswerList(astAnswerList);
		return vo;
	}

	@Override
	public AstVO retrieveProAstDetailResult(AstVO vo) {
		List<String> astEtcList = new ArrayList<>();
		List<Double> astAnswerList = new ArrayList<>();
		double[] answerSum = new double[13];
		
		List<AstVO> resList = dao.selectProAstDetailResult(vo);
		int resLength = resList.size();
		if(resLength == 0) {
			return vo;
		}
		double resultScore = 0.0;
		
		for(AstVO eachVo : resList) {
			resultScore += eachVo.getAstScore();
			if(eachVo.getAstEtc() != null) {
				astEtcList.add(eachVo.getAstEtc());
			}
			double[] answers = eachVo.getAnswerFlArr();
			int answersLength = answers.length;
			
			for(int i=0; i<answersLength; i++) {
				answerSum[i] += answers[i];
			}
		}
		resultScore = Math.round(resultScore/resLength*100)/100.0;
		vo.setAstScore(resultScore);
		vo.setAstEtcList(astEtcList);
		
		for(int i=0; i<answerSum.length; i++) {
			astAnswerList.add(Math.round(answerSum[i]/resLength*100)/100.0);
		}
		
		vo.setAstAnswerList(astAnswerList);
		return vo;
	}

}
