package kr.or.ddit.vo;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of="userNo")
public class AdminEnrollVO {
	
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
	private String lecSems;
	
	private String enrId;
	private Integer enrSems;
	private String enrAmt;
	private String enrDue;
	private String enrDate;
	private String enrPay;
	private String schNo;
	
	private String deptEnr;
	private String enrYn;
	
	private String schAmount;
	private String enrResult;
}
