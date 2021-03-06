package kr.or.ddit.vo;

import java.util.List;
import java.util.Map;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

/**
 * @author 김재웅
 * @since 2022. 5. 10.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2022. 5. 10.      김재웅       최초작성(강의계획서 작성 양식을 채우는 데이터)
 * 2022. 5. 12.		 김재웅        추가(colName 속성 추가)
 * Copyright (c) 2022 by DDIT All right reserved
 * </pre>
 */
@Data
@EqualsAndHashCode(of="planNo")
@ToString
public class PlanEditVO{

	private String deptId;
	private String sjtId;
	private Integer planLimit;
	private Integer planSems;
	private String deptName;
	private String colName;
	private String planSts;
	private Integer planTcnt;
	private Integer sjtGrade;
	private String sjtName;
	private String userName;
	private Integer planNo;
	private Integer userNo;
	private String planEval;
	private Integer sjtCredit;
	private String planSmry;
	private Integer planYear;
	private String sjtMajor;
	private String planDenlrsn;
	
	private List<WplanVO> wPlanList;
	
	private List<Map<String, Object>> wPlanMapList;
}
