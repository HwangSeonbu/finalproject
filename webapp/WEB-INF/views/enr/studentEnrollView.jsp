<%--
  학생의 등록금고지서를 pdf형식으로 조회
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2022. 5. 2.      김재웅      최초작성
* 2022. 5. 4. 	민진홍 	PDF출력
* Copyright (c) 2022 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<script src="${cPath }/resources/js/jspdf/html2canvas.js"></script>
<security:authentication property="principal.realUser" 
	var="authMember"/>

    <script src="${cPath }/resources/js/jspdf/jspdf.min.js"></script>

      <br>
<h2 style="font-weight:700; ">등록금 고지서</h2>
<div class="container pdfwpqkf" style="height: 500px;">
<div id="pdfDiv" style="margin-left: 300px;">
 <!-- pdf 생성 영역 부분 -->
<!--  등록금정보 -->
<div style="border: 1px dotted; padding: 10px;">
<c:set var="enroll" value="enrollVo"/>
<c:choose>
 <c:when test="${not empty enroll}">
 <h6 id="tableCaption"> 등록금 내역 </h6>
 <table class="enroll">

	<tbody>
		<tr>
			<th>대학(원)</th>
			<td>대덕인재대학교</td>
		</tr>
		
		<tr>
			<th>학번</th>
			<td>${authMember.userNo }</td>
		</tr>
		
		<tr>
			<th>학생이름</th>
			<td>${authMember.userName }</td>
		</tr>
			
		<tr>
			<th>학기</th>
			<td>${enrollVo.enrSems }</td>
		</tr>
			
		<tr>
			<th>등록금</th>
			<td>${enrollVo.enrAmt }원</td>
		</tr>
			
		<tr>
			<th>납부기한</th>
			<td>${enrollVo.enrDue }</td>
		</tr>
		
		<tr>
			<th>납부방법</th>
			<td>1. 신한은행 전국 각지점 방문 납부 <br> 2. 신한은행 가상계좌로 입금</td>

		</tr>
		<tr style="border: 3px solid black;"> 
			<th>가상계좌</th>
			<td style="font-weight: bold;">신한은행 123-4444-5677-1 대덕인재대학교</td>
		</tr>
		<tr style="border: 3px solid black;">
			<th>등록금계</th>
			<td style="font-weight: bold; text-align: right;">${enrollVo.enrPay }원</td>
		</tr>
		
		
	</tbody>
</table>

<!--  장학금정보 -->
 <c:if test="${not empty schVo}">
  <h6 id="tableCaption"> 장학금 내역 </h6>
  <table class="scholarship">
  	<tr>
  		<th>장학금명</th>
  		<td>${schVo.schName}</td>
  	</tr>
  	<tr>
  		<th>감면금액</th>
  		<td>${schVo.schAmount}원</td>
  	</tr>
  	<tr>
  		<th>감면 후 금액</th>
  		<td>${enrollVo.enrPay}원</td>
  		
  	</tr>
  	
  </table>
 </c:if>

 <hr id="clearFloat">
 <span style="color: red; font-size: 13px;">
 * 장학금 혜택 등으로 계 금액이 0원 이라도 은행에서 등록을 필해야 함.
 <br>* 등록금계 금액은 장학금혜택 감면 후 내야할 최종금액임.
 </span>
 <br>
<img alt="" src="${cPath }/resources/img/enrolllogo.png" height="140px;">
	 </c:when>
	<c:otherwise>
		<h5>등록금 고지서 정보가 없습니다.</h5>

	</c:otherwise>
 </c:choose>
<!-- pdf 생성 영역 부분 -->
</div> 
</div>
</div>
  
  <hr id="clearFloat">
  <br>
<!--   pdf다운로드 버튼 활성화 -->
  <c:if test="${not empty enroll}">
  <button id="savePdfBtn" class="btn btn-primary">PDF다운로드</button>
  </c:if>
  
<!--   pdf다운로드 버튼 비활성화-->
  <c:if test="${empty enroll}">
  <button id="savePdfBtn" disabled="disabled" class="btn btn-primary">PDF다운로드</button>
  </c:if>
  
  
  
  
  
  
   <script>
  
    $(document).on('click','#savePdfBtn',function() {
	   html2canvas($('.pdfwpqkf')[0],{
		    height: 800
		}).then(function(canvas) {
		   // 캔버스를 이미지로 변환 
		   let imgData = canvas.toDataURL('image/jpg');
		   let margin = 10; 
		   // 출력 페이지 여백설정 
		   let imgWidth = 200 - (10 * 2);
		   // 이미지 가로 길이(mm) A4 기준
		   let pageHeight = imgWidth * 1.414;
		   // 출력 페이지 세로 길이 계산 A4 기준
		   let imgHeight = canvas.height * imgWidth / canvas.width;
		   let heightLeft = imgHeight; let doc = new jsPDF('p', 'mm');
		   let position = margin; 
		   // 첫 페이지 출력 
		   doc.addImage(imgData, 'PNG', margin, position, imgWidth, imgHeight);
		   heightLeft -= pageHeight;
		   // 한 페이지 이상일 경우 루프 돌면서 출력
		   while (heightLeft >= 20) { 
			   position = heightLeft - imgHeight;
			   doc.addImage(imgData, 'PNG', 0, position, imgWidth, imgHeight);
			   doc.addPage(); heightLeft -= pageHeight; }
		   // 파일 저장
		   doc.save('등록금고지서.pdf'); 
		   });
    });

   </script>
		   




   