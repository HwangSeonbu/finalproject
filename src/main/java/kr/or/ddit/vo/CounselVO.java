package kr.or.ddit.vo;

import java.io.Serializable;
import java.util.List;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotBlank;
import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.web.util.HtmlUtils;

import kr.or.ddit.validate.CounselLogGroup;
import kr.or.ddit.validate.InsertCounselLogGroup;
import kr.or.ddit.validate.InsertReqGroup;
import kr.or.ddit.validate.MessageGroup;
import kr.or.ddit.validate.UpdateGroup;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**CNSL테이블 객체를 담을 VO
 * @author 황선부
 * @since 2022. 4. 28.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2022. 4. 28.      황선부       최초작성
 * Copyright (c) 2022 by DDIT All right reserved
 * </pre>
 */
@Data
@EqualsAndHashCode(of= "cnslId")
public class CounselVO implements Serializable {
	private int rnum;
	@NotNull
	private String cnslId;
	
	
	private int stuNo;
	private String userName;
	private Integer proNo;
	
	private String cnslDate;
	
	private String dyDate;
	
	private String cnslDay;
	@NotEmpty(groups=MessageGroup.class)
	private String cnslLo;
	
	private StudentVO stuVO;	
	private ProfessorVO proVO;
	
	//상담설문
	@NotNull(groups=InsertReqGroup.class)
	private String r1;
	@NotNull(groups=InsertReqGroup.class)
	private String r2;
	@NotNull(groups=InsertReqGroup.class)
	private String r3;
	@NotNull(groups=InsertReqGroup.class)
	private String r4;
	@NotNull(groups=InsertReqGroup.class)
	private String r5;
	@NotNull(groups=InsertReqGroup.class)
	private String r6;
	@NotNull(groups=InsertReqGroup.class)
	private String r7;
	@NotNull(groups=InsertReqGroup.class)
	private String r8;
	private String qaLong;
	
	//상담일지
	@NotEmpty(groups=InsertCounselLogGroup.class)
	private List<String> l1;
	@NotEmpty(groups=InsertCounselLogGroup.class)
	private List<String> l2;
	
	
	private String l3;
	
	private String deptName;
	private int userNo;
	
	//메시지
	@NotEmpty(groups=MessageGroup.class)
	private String date;
	@NotEmpty(groups=MessageGroup.class)
	private String time;
	
	public String getCnslDay() {
		return this.date + " " + this.time;
	}
	
		
	private String userPhone;
	
	public String getL3Display() {
		
		return HtmlUtils.htmlUnescape(this.l3);
	}
	
}














