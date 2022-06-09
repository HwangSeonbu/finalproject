/**
 * 
 */
package kr.or.ddit.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

/**
 * @author 민진홍
 * @since 2022. 4. 27.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2022. 4. 27.      작성자명       최초작성
 * 2022. 5. 06.    김재웅		 planSems 타입 Integer로 변경
 * Copyright (c) 2022 by DDIT All right reserved
 * </pre>
 */

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class PlanVO {
	private Integer planNo;
	private Integer userNo;
	private String sjtId;
	private String sjtName;
	private String planSts;
	private Integer planYear;
	private Integer planLimit;
	private Integer planTcnt;
	private String planEval;
	private String planDenlrsn;
	private String planSmry;
	private Integer planSems;
	private String deptId;
}
