package kr.or.ddit.vo;

import lombok.Data;

/**
 * @author 작성자명
 * @since 2022. 5. 9.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2022. 5. 9.      작성자명       최초작성  <- 이부분 작성하면서 코딩 진행해주세요~
 * Copyright (c) 2022 by DDIT All right reserved
 * </pre>
 */
@Data
public class AssignVO {

	private String assignNo;
	private Integer planNo;
	private String assignDay;
	private String assignTime;
	private Integer roomNo;
	private String gwanName;
	private String proName;
	private String assignDt;
	
	private String lecName;
	private Integer planSems;
}
