package kr.or.ddit.vo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.util.HtmlUtils;

import kr.or.ddit.validate.HomeworkInsertGroup;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**강의 과제 게시판 vo
 * @author 황선부
 * @since 2022. 5. 23.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2022. 5. 23.      황선부       최초작성
 * Copyright (c) 2022 by DDIT All right reserved
 * </pre>
 */
@Data
@EqualsAndHashCode(of="leckwkNo")
public class LecHomeworkVO implements Serializable {
	
	private Integer lechwkNo;
	private Integer lecSems;
	private String lecId;
	private String userNo;
	@NotEmpty(groups=HomeworkInsertGroup.class, message = "과제명을 입력해주세요.")
	private String lechwkName;
	@NotEmpty(groups=HomeworkInsertGroup.class, message = "과제내용을 입력해주세요")
	private String lechwkCont;
	@NotEmpty(groups=HomeworkInsertGroup.class, message = "마감일을 입력해주세요.")
	private String lechwkDate;
	private String lechwkCode;
	private String registDate;
	
	private int rowcnt;
	
	//총 배점
	private int totalPoints;
	//평균 점수
	private int avgPoints;
	//평가 완료 인원
	private int complete;
	
	private int hit;
	
	private String lecName;

	
	private AttchVO attach;
	
	//homework List
	private List<HwkVO> hwkList;
	
	//evaluation List
	private List<EvaStandardVO> evaList;
	
	private int submitRate;
	
	public String getHtmlContent() {
		return HtmlUtils.htmlUnescape(this.lechwkCont);		
	}
	//제출 인원
	private Integer submittedStu;
	//전체 인원
	private Integer wholeStu;
	
	public String getJspLechwkDate() {
//		return this.lechwkDate.substring(0, 10);
		return this.lechwkDate.replace("/", "-");
	}

//	private List<String> setStd;
//	private List<Integer> setScore;
	
	
	
//	public void setEvaList() {
//		List<EvaStandardVO> evaList = new ArrayList<>();
//		EvaStandardVO eva = new EvaStandardVO();
//		
//		for(String std: setStd) {
//			eva.setEvaStd(std);
//		}
//		for(Integer score:setScore) {
//			eva.setEvaScore(score);
//		}		
//		
//		this.evaList = evaList;
//	}
	
	//지울려고 하는 파일
	private Integer delAttNo;	
	//신규로 올릴 파일
	private MultipartFile boFile;
		
	public void setBoFile(MultipartFile boFile) {
		if(boFile==null || boFile.isEmpty()) return;
		
		this.boFile = boFile;
		
		this.attach = new AttchVO(boFile);		
	}
}

