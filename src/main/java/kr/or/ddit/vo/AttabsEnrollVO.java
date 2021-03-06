package kr.or.ddit.vo;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class AttabsEnrollVO {

	private Integer lecSems;
	private String attabsDay;
	private Integer userNo;
	private String assignNo;
	private String attabsCode;
	private String userName;
	private Integer planNo;
	private String lecId;
	private Integer attabsNo;
	private String attabsDate;
	private Integer ojtNo;
	
	private String openLec;
	private String closeLec;
}
