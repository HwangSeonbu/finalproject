package kr.or.ddit.vo;

import lombok.Data;

@Data
public class BoLikeVO {

	private Integer bolikeNo;
	private Integer BoardNo;
	private Integer userNo;
	private String bolikeYn;
	private String resultMsg;
	private Integer resultNo;
}
