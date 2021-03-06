package kr.or.ddit.vo;

import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

/**
 * @author 고성식
 * @since 2022. 4. 26.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2022. 4. 26.   고성식    	   최초작성
 * 2022. 5. 06    황선부             Integer pro -> paging 처리 위한 파라미터
 * 2022. 5. 09.   주창규             과목에 대학 리스트, 출석 이의신청에 대한 리스트,출석에대한 리스트 추가
 * Copyright (c) 2022 by DDIT All right reserved
 * </pre>
 */
@Data
@EqualsAndHashCode(of="userNo")
@NoArgsConstructor
public class StudentVO {
	
	public StudentVO(Integer userNo, String userPass) {
		super();
		this.userNo = userNo;
		this.userPass = userPass;
	}
	
	private int rnum;
	private Integer userNo;
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
	private Integer lecSems;	//학기
	private String lecId;		//과목명 아이디
	private int startDate;		//강의 시작날짜
	private String lecName;		//강의명
	private String proName;		//교수명
	private int acadscSems;		//날짜
	private int sjtGrade;		//과목에대한 학기
	
	private List<SubjectVO> subjectList;//강의에 대한 리스트
	
	
	private List<ObjectionVO> attendanceObjectList; //출석 이의 신청에 대한 리스트
	
	private List<LecturePeriodVO> lecturePeriodList;	//강의1주~16주 출석 여부를 담은  list
	//has a 관계
	private UserVO user;
	
	private DepartmentVO department;
	
	//has many 관계
	private List<CounselVO> counselList;
	
	//counsel paging 처리
	private Integer pro;
	
}
