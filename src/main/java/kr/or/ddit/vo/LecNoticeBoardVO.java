package kr.or.ddit.vo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.util.HtmlUtils;

import kr.or.ddit.validate.InsertLecBoardGroup;
import kr.or.ddit.validate.UpdateLecBoardGroup;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 강의 공지 게시판 VO
 * 
 * @author 황선부
 * @since 2022. 5. 14.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * 
 *      <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2022. 5. 14.      황선부		최초작성
 * Copyright (c) 2022 by DDIT All right reserved
 *      </pre>
 */
@Data
@EqualsAndHashCode(of = "lecboNo")
//@ToString(exclude= {"lecboContent","attchList"})
public class LecNoticeBoardVO implements Serializable {
	private int rnum;

	private Integer lecboNo;
	private String lecboInfo;
	@NotEmpty(groups = { InsertLecBoardGroup.class, UpdateLecBoardGroup.class }, message = "제목을 입력해주세요.")
	private String lecboTitle;
	@NotEmpty(groups = { InsertLecBoardGroup.class, UpdateLecBoardGroup.class }, message = "내용을 입력해주세요.")
	private String lecboContent;
	private Integer lecboHit;
	private String lecboDate;
	private Integer lecSems;
	private String lecId;
	private Integer userNo;
	private String lecDiv;
	private String lecboPass;

	private List<AttchVO> attchList;

	private String userName;

	// htmlUnescaping
	public String getContentDisplay() {
		return HtmlUtils.htmlUnescape(this.lecboContent);
	}

	private int startAttNo;// 첫번째 첨부파일 번호
	// 업데이트시
	// 지울려고 하는 파일
	private int[] delAttNos;
	// 신규로 올릴 파일
	private MultipartFile[] boFiles;

	public void setBoFiles(MultipartFile[] boFiles) {
		if (boFiles == null || boFiles.length == 0)
			return;

		this.boFiles = boFiles;
		this.attchList = new ArrayList<>();
		for (MultipartFile eachFile : boFiles) {
			if (eachFile.isEmpty())
				continue;
			AttchVO attatch = new AttchVO(eachFile);
			attchList.add(attatch);

		}

	}

}
