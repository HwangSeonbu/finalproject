package kr.or.ddit.ast.dao;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.AcadscVO;

@Mapper
public interface AccessPeriodDAO {

	public AcadscVO selectAccessPeriod(AcadscVO vo);
	
	
}
