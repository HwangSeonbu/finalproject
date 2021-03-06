package kr.or.ddit.student.service;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.vo.PagingVO;
import kr.or.ddit.vo.StudentVO;

/**
 * studentService
 * @author 고성식
 * @since 2022. 4. 26.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2022. 4. 26.   고성식  	 	    최초작성 
 * 													 
 * Copyright (c) 2022 by DDIT All right reserved
 * </pre>
 */
public interface StudentService {
	/**
	 * 학생 목록 조회
	 * @param paging
	 * @return 검색 조건에 맞는 학생 없으면, size()==0
	 */
	public List<StudentVO> retrieveStudentList(PagingVO<StudentVO> paging);
	
	/**
	 * 학생 상세조회
	 * @param userNo
	 * @return
	 */
	public StudentVO retriveStudent(Integer userNo);
	
	/**
	 * 학생등록
	 * @param student
	 * @return
	 */
	public void studentUpload(MultipartFile file) throws IOException;
}
