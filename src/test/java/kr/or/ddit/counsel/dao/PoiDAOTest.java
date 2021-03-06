package kr.or.ddit.counsel.dao;

import static org.junit.Assert.assertNotNull;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.inject.Inject;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.util.CellRangeAddress;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.ContextHierarchy;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.counsel.service.CounselService;
import kr.or.ddit.vo.PagingVO;
import kr.or.ddit.vo.ProCounselVO;
import lombok.extern.slf4j.Slf4j;

/**poi로 excel 다운로드 하기 위한 단위 테스트
 * @author 황선부
 * @since 2022. 5. 12.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2022. 5. 12.      황선부       최초작성
 * Copyright (c) 2022 by DDIT All right reserved
 * </pre>
 */
@RunWith(SpringRunner.class)
@ContextHierarchy({
	@ContextConfiguration("file:webapp/WEB-INF/spring/*-context.xml")//상위 컨테이너
	,@ContextConfiguration("file:webapp/WEB-INF/spring/appServlet/*-context.xml")//하위 컨테이너
})
@WebAppConfiguration
@Slf4j
@Transactional//테스트과정의 트랜잭션은 자동 롤백!!중요!!//단위테스트간 서로 영향을 주지 않도록 트랜잭션 관리함.테스트하고 svn에 커밋해야함!!
public class PoiDAOTest {
	@Inject
	private CounselService service;
	
	
	@Test
	public void testExcelCounsel() throws FileNotFoundException, IOException {
		
		//조건
		PagingVO<ProCounselVO> paging = new PagingVO<ProCounselVO>();
		paging.setProNo(11);		
		
		//실행
		List<ProCounselVO> pList = service.retreiveCounselPro(paging);
		
		
		//결과예측
		assertNotNull(pList);
		
		//excelTest
		String target = "상담관리";
		
		HSSFWorkbook workbook = new HSSFWorkbook();

		HSSFSheet sheet = workbook.createSheet(target);
		
		//title
		HSSFRow titRow = null;
		HSSFRow titRow2 = null;
		//col
		HSSFRow colRow = null;
		//content
		HSSFRow contRow = null;
		
		//style
		HSSFCellStyle titleStyle = columnStyle(workbook);
		HSSFCellStyle contStyle = contStyle(workbook);
		HSSFCellStyle titStyle = titleStyle(workbook);
		
		int rowCount = 0;
        int cellCount = 0;
        
        //create title
        titRow = sheet.createRow(0);
        Cell titCell = titRow.createCell(0);
        titCell.setCellValue("학생 상담 관리");
        

        
        //date
		titRow2 = sheet.createRow(++rowCount);
        Cell dateCell = titRow2.createCell(8);
        
		Date date = new Date();

        SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        dateCell.setCellValue("현재시간 : "+dateFormatter.format(date));
        
        SimpleDateFormat dateFileName = new SimpleDateFormat("yyyyMMdd");
        String fileName = "counsel."+dateFileName.format(date);
        
        rowCount=2;      
        colRow = sheet.createRow(rowCount++);
        
        //create column
        colRow.createCell(cellCount++).setCellValue("상담번호");
        colRow.createCell(cellCount++).setCellValue("학번");
        colRow.createCell(cellCount++).setCellValue("이름");
        colRow.createCell(cellCount++).setCellValue("학과번호");
        colRow.createCell(cellCount++).setCellValue("학과명");
        colRow.createCell(cellCount++).setCellValue("학적상태");
        colRow.createCell(cellCount++).setCellValue("상담예약 일/시간");
        colRow.createCell(cellCount++).setCellValue("전화번호");
        colRow.createCell(cellCount++).setCellValue("등록상담일");
		
        //범위가 딱 맞아야함.
        for(int i=0; i<cellCount ; i++) {
        	HSSFCell titcell = colRow.getCell(i);
        	titcell.setCellStyle(titleStyle);    	
        }
        
        
        //cell 병합
        sheet.addMergedRegion(new CellRangeAddress(
        		0
        		, 0
        		, 0
        		, cellCount-1));
        //title style
        titCell.setCellStyle(titStyle);


        
        //data cell 불러오기
        for(int i=0; i<pList.size();i++) {
        	cellCount=0;
        	ProCounselVO counsel = pList.get(i);
        	contRow = sheet.createRow(rowCount++);
        	contRow.createCell(cellCount++).setCellValue(counsel.getCnslId());
            contRow.createCell(cellCount++).setCellValue(counsel.getUserNo());
            contRow.createCell(cellCount++).setCellValue(counsel.getUserName());
            contRow.createCell(cellCount++).setCellValue(counsel.getDeptId());
            contRow.createCell(cellCount++).setCellValue(counsel.getDeptName());
            contRow.createCell(cellCount++).setCellValue(counsel.getStuCode());
            contRow.createCell(cellCount++).setCellValue(counsel.getCnslDay());
            contRow.createCell(cellCount++).setCellValue(counsel.getUserPhone());
            contRow.createCell(cellCount++).setCellValue(counsel.getCnslDate());
        	

            for(int j=0; j<cellCount ; j++) {
            	HSSFCell contCell = contRow.getCell(j);
            	contCell.setCellStyle(contStyle);    	
            }
        }
        
        //컬럼 사이즈
        for (int i = 0; i <  pList.size(); i++){
            sheet.autoSizeColumn(i);
            sheet.setColumnWidth(i, (sheet.getColumnWidth(i)) + 1000);
        }
		// Write the output to a file
		try (OutputStream fileOut = new FileOutputStream("d:/poi/"+fileName+".xls")) {
		    workbook.write(fileOut);
		
		}
		
	}
	private HSSFCellStyle titleStyle(HSSFWorkbook workbook) {
		HSSFCellStyle HeadStyle = workbook.createCellStyle();
		
		//제목 폰트
        HSSFFont font = workbook.createFont();
        font.setFontHeightInPoints((short)15);
//        font.setFontName("굴림");
        font.setBoldweight((short)font.BOLDWEIGHT_BOLD);
		HeadStyle.setFont(font);
		
		HeadStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		HeadStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		HeadStyle.setFillForegroundColor(HSSFColor.LIGHT_YELLOW.index);
//		HeadStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
//		HeadStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
//		HeadStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
//		HeadStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
		HeadStyle.setFillPattern(CellStyle.SOLID_FOREGROUND);

		
		return HeadStyle;
	}
	//column style
	private HSSFCellStyle columnStyle(HSSFWorkbook workbook) {
		HSSFCellStyle style = workbook.createCellStyle();
		
		style.setBorderBottom(HSSFCellStyle.BORDER_THIN);  //테두리 종류들
		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(HSSFCellStyle.BORDER_THIN);	
				
		style.setVerticalAlignment(CellStyle.VERTICAL_CENTER); //중앙 정렬(위~아래)
		style.setAlignment(CellStyle.ALIGN_CENTER);  //중앙정렬(좌~우)		

		style.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());  //채우기 선택
		style.setFillPattern(CellStyle.SOLID_FOREGROUND);  //채우기 적용(이거안하면 안채운다)
		
		return style;
	}
	//title style
	private HSSFCellStyle contStyle(HSSFWorkbook workbook) {
		HSSFCellStyle style = workbook.createCellStyle();
		
		style.setBorderBottom(HSSFCellStyle.BORDER_THIN);  //테두리 종류들
		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(HSSFCellStyle.BORDER_THIN);	
				
		style.setVerticalAlignment(CellStyle.VERTICAL_CENTER); //중앙 정렬(위~아래)
		style.setAlignment(CellStyle.ALIGN_CENTER);  //중앙정렬(좌~우)		

//		style.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());  //채우기 선택
//		style.setFillPattern(CellStyle.SOLID_FOREGROUND);  //채우기 적용(이거안하면 안채운다)	
		return style;
	}
	
}
