package kr.or.ddit.vo;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 학생의 수강 VO
 * @author 김재웅
 * @since 2022. 5. 9.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2022. 5. 9.      김재웅       최초작성 + 학기 속성 추가
 * Copyright (c) 2022 by DDIT All right reserved
 * </pre>
 */
@Data
@EqualsAndHashCode(of="userNo")
public class StudentSugangVO {
	private String deptId;
	private String colName;
	private String sjtId;
	private String deptName;
	private String gwanName;
	private String assignDt;
	private String userName;
	private String stuCode;
	private String lecId;
	private Integer planNo;
	private Integer roomNo;
	private String userGender;
	private Integer userNo;
	private String stuYear;
	private String userType;
	private String proName;
	private String sjtCredit;
	private String lecName;
	private String sjtMajor;
	private String proNo;
	
	private Integer prevSems;
	private Integer thisSems;
	private Integer nextSems;
}
