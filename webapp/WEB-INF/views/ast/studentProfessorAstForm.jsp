
<%--
 학생이 교수평가를 등록할 수 있는 페이지
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
<h3 class="h3-title">교수평가 등록</h3><hr class="hr-title">

		<table class="table table-bordered" id="dataTable">
			 <thead>
			    <tr class="tr-headLine">
			    	<th >교수<br>번호</th>	
			    	<th >분과대학</th>	
			    	<th >학과</th>	
			    	<th >성별</th>	
			    	<th >직책</th>	
			    	<th >수강 강의</th>	
			    	<th >교수명</th>	
			    	<th >평가<br>상태</th>	
			    	<th >평가일시</th>	
			    </tr>
			 </thead>
			 <tbody class="text-center" id="dataListTbody">
			 <c:set value="${proList }" var="proList"/>
			 <c:if test="${not empty proList}">
			 	<c:forEach items="${proList }" var="pro">
			 	<!-- case : tr-targetLine tr-targetHover class remove -->
			 	<tr id="${pro.userNo }" class="" data-dept-id="${pro.deptId }">
			 		<td>${pro.userNo }</td>
			 		<td>${pro.colName }</td>
			 		<td>${pro.deptName }</td>
			 		<td>${pro.userGender }</td>
			 		<td>${pro.proJob }</td>
			 		<td>${pro.lecName }</td>
			 		<c:if test="${pro.astCnt eq 0 }">
				 		<td><a href="${cPath }/astEnroll/proAstDetailForm.do?userNo=${pro.userNo }" 
				 			data-user-no="${pro.userNo }" class="a-targetClick" style="font-weight:bold;">${pro.userName }</a></td>
				 		<td style="font-weight:bold; color:red;">${pro.astYn }</td>
			 		</c:if>
			 		<c:if test="${pro.astCnt ne 0 }">
			 			<td>${pro.userName }</td>
			 			<td style="font-weight:bold; color:green;">${pro.astYn }</td>
			 		</c:if>
			 		<td>${pro.astDateFormat }</td>
			 	</tr>
			 	</c:forEach>
			 </c:if>
			 </tbody>
		</table>
