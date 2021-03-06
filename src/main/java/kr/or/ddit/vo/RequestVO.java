package kr.or.ddit.vo;



import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 신청(Request)에 대한 VO
 * @author 고성식
 * @since 2022. 5. 4.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2022. 5. 4.    고성식			최초 작성
 * Copyright (c) 2022 by DDIT All right reserved
 * </pre>
 */
@Data
@EqualsAndHashCode(of="reqId")
public class RequestVO {
	
	private int rnum;
	private String reqId;
	
	private Integer userNo;
	private Integer reqSms;
	private String reqRsn;
	private String reqStart;
	private String reqEnd;
	private String reqDenl;
	private String reqDate;
	private String reqDiv;
	
	private String deptId;
	private Integer stuYear;
	private String stuClass;
	private String stuCode;
	private String stuCdtEarn;
	private Integer stuGduCdt;
	private String stuGduDate;
	
	private String userPass;
	private String userName;
	private String userGender;
	private String userPhone;
	private String userAddr;
	private String userReg1;
	private Integer userReg2;
	private String userMail;
	private String userSavename;
	private String userDate;
	private String userCode;	
	private String memRole;
	
	private String stsCode1;
	private String deptName;
	private String colName;
	
	private String semsSdate;
	private String semsEdate;
	
	private String reqStat;
	private Integer lecSems;
	
	private Integer enrSems;
	
	private String reqYn;
	
	private String reqCode;
	
	
}
