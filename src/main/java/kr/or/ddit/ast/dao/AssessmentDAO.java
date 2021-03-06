package kr.or.ddit.ast.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.AstLecVO;
import kr.or.ddit.vo.AstProVO;
import kr.or.ddit.vo.AstResultVO;
import kr.or.ddit.vo.AstVO;
import kr.or.ddit.vo.LectureVO;
import kr.or.ddit.vo.OrderVO;
import kr.or.ddit.vo.ProfessorLectureVO;

@Mapper
public interface AssessmentDAO {
	public List<AstLecVO> selectAstTargetLecList(Map<String, Integer> paramMap);
	
	public List<AstProVO> selectAstTargetProList(Map<String, Integer> paramMap);
	
	public LectureVO selectAstTargetLecOne(String lecId);
	public ProfessorLectureVO selectAstTargetProOne(Map<String, Integer> paramMap);
	
	public int insertAssessment(AstVO vo);
	
	
	public List<AstResultVO> selectProAstResultList(OrderVO vo);
	public List<AstResultVO> selectLecAstResultList(OrderVO vo);
	
	public List<AstResultVO> selectProAstCompResult(OrderVO vo);
	public List<AstResultVO> selectLecAstCompResult(OrderVO vo);
	
	public List<AstVO> selectLecAstDetailResult(AstVO vo);
	public List<AstVO> selectProAstDetailResult(AstVO vo);
}
