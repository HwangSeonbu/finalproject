package kr.or.ddit.vo;

import java.io.Serializable;
import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author 황선부
 * @since 2022. 5. 9.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2022. 5. 9.      황선부       최초작성  <- 이부분 작성하면서 코딩 진행해주세요~
 * Copyright (c) 2022 by DDIT All right reserved
 * </pre>
 */
@Data
@EqualsAndHashCode(of="questNo")
public class QuestionVO implements Serializable {
	private String questNo;
	private String questContent;
	
	private List<QuestionAnswerVO> qaVO;
}
