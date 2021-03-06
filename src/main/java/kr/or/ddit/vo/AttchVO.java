package kr.or.ddit.vo;

import java.io.File;
import java.io.IOException;
import java.util.UUID;


import org.apache.commons.io.FileUtils;
import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;

/**
 * @author 이유정
 * @since 2022. 5. 10.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2022. 5. 9.      이유정       최초작성  <- 이부분 작성하면서 코딩 진행해주세요~
 * Copyright (c) 2022 by DDIT All right reserved
 * </pre>
 */
@Data
@EqualsAndHashCode(of="attchNo")
@ToString(exclude="adaptee")
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class AttchVO {
	
	private MultipartFile adaptee;
	public AttchVO(MultipartFile adaptee) {
		super();
		this.adaptee = adaptee;
		this.attchFname = adaptee.getOriginalFilename();
		this.attchSname = UUID.randomUUID().toString();
		this.attchMime = adaptee.getContentType();
		this.attchSize = adaptee.getSize();
		this.attchFsize = FileUtils.byteCountToDisplaySize(attchSize);
	}
	
	private Integer attchNo; //첨부파일번호
	private String boardNo; //자유글번호
	private Integer noticeNo; //글번호
	private Integer userNo; //유저번호
	private String attchFname; //첨부파일이름
	private String attchSname; //저장명
	private String attchMime; //저장형식
	private Long attchSize; //파일사이즈
	private String attchFsize; //팬시사이즈
	private Integer attchDhit; //다운로드수
	private Integer lecboNo; //게시번호
	private Integer planNo; //계획번호
	private Integer ojtNo; //자유글번호
	private Integer userNo2; //교수번호
	
	private Integer lecqnaNo;//qna번호
	
	public void saveTo(File projectFolder) throws IOException {

//		WebApplicationContext context = ContextLoader.getCurrentWebApplicationContext();
//		log.info("context==>{}",context);
//		Resource saveFolderRes = context.getResource(projectFolder.getPath());
//		if(!saveFolderRes.exists()) {
////			Resource saveFolderRes = context.getResource(saveFolderURL);
//			log.info("projectFolder:{}",saveFolderRes);
//			projectFolder.mkdirs();
//		}
		
		if(adaptee==null || adaptee.isEmpty()) 
			return;
		
		adaptee.transferTo(new File(projectFolder, attchSname));
	}
}
