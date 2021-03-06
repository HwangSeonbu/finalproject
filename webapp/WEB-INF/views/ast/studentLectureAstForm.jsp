
<%--
 학생이 강의평가를 등록할 수 있는 페이지
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2022. 5. 2.      김재웅      최초작성
* Copyright (c) 2022 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
	a{text-decoration-line: none;}
	a:hover{font-weight: bold;}
	tr-pickTarget a{color:yellow;font-weight: bold;}
	.table{width: 95%; border-top:2px solid black;}
</style>
<h3 class="h3-title">강의평가 등록</h3><hr class="hr-title">

		<table class="table table-bordered" id="dataTable">
			 <thead>
			    <tr class="tr-headLine">
			    	<th >강의<br>번호</th>	
			    	<th >교수명</th>	
			    	<th >이수<br>구분</th>	
			    	<th >이수<br>학점</th>	
			    	<th >과목명</th>	
			    	<th >시수</th>	
			    	<th >평가<br>기준</th>	
			    	<th >강의명</th>	
			    	<th >평가<br>상태</th>	
			    	<th >평가일시</th>	
			    </tr>
			 </thead>
			 <tbody class="text-center" id="dataListTbody">
			 <c:set value="${lecList }" var="lecList"/>
			 <c:if test="${not empty lecList}">
			 	<c:forEach items="${lecList }" var="lec">
			 	<!-- case : tr-targetLine tr-targetHover class remove -->
			 	<tr id="${lec.planNo }" class="" data-lec-id="${lec.lecId }">
			 		<td>${lec.lecId }</td>
			 		<td>${lec.proName }</td>
			 		<td>${lec.sjtMajor }</td>
			 		<td>${lec.sjtCredit }</td>
			 		<td>${lec.lecName }</td>
			 		<td>${lec.planTcnt }</td>
			 		<td>${lec.planEval }</td>
			 		<c:if test="${lec.astCnt eq 0 }">
				 		<td><a href="${cPath }/astEnroll/lecAstDetailForm.do?lecId=${lec.lecId }" 
				 			data-lec-id="${lec.lecId }" class="a-targetClick" style="font-weight:bold;">${lec.planSmry }</a></td>
				 		<td style="font-weight:bold; color:red;">${lec.astYn }</td>
			 		</c:if>
			 		<c:if test="${lec.astCnt ne 0 }">
				 		<td>${lec.planSmry }</td>
				 		<td style="font-weight:bold; color:green;">${lec.astYn }</td>
			 		</c:if>
			 		<td>${lec.astDateFormat }</td>
			 	</tr>
			 	</c:forEach>
			 </c:if>
			 </tbody>
		</table>




