package kr.or.ddit.ast.service;

import kr.or.ddit.enumpkg.AccessActionEnum;
import kr.or.ddit.vo.PageAccessVO;

public interface AccessPeriodService {

	/**
	 * @param acadscCont : db CODE 테이블에 SI그룹아이디로 등록된 시스템일정이 존재하는
	 * <p> STS_CODE1명을 정의된 enum으로 파라미터 전달
	 * @return VO객체 반환, (access:접근가능여부 boolean(true시 가능), action:STS_CODE1명
	 * <p> , accessPeriod:접근기간 안내문구)
	 */
	public PageAccessVO retrieveAccessPeriod(AccessActionEnum enumClass);
}
