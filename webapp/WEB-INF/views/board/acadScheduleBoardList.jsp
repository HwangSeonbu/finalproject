<%--
   학사일정게시판
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2022. 4. 29.      김재웅      최초작성
* 2022. 5. 4.      이유정      수정
* Copyright (c) 2022 by DDIT All right reserved
 --%>
<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<style>
.nav-link2{
   color:#696969;
   font-size: 20px;   
   text-decoration-line: none;
}
.calen_box {
    min-height: 170px;
    padding: 35px 0;
    border-bottom: 1px dashed #808080;
    font-size: 15px;
    color: #464646;
}
ol, ul {
    list-style: none;
}
.acadScClick:hover{
	text-decoration:underline; 
	color: 	#4169E1;
	cursor: pointer;
}
.year{
	font-size: 50px;
}
</style>
<script>
$(document).on("click", ".acadScClick", function() {
	let acadscNo = $(this).data('acadscNo');
	location.href="${pageContext.request.contextPath }/board/acadScheduleView.do?who="+acadscNo;
})
</script>
<h3 class="h3-title">학사일정</h3><hr class="hr-title">
 <nav class="navbar navbar-expand-sm ">
  <div class="container-fluid">
        <b class="year">2022</b>
        <a class="nav-link2" href="#">전체</a>
        <a class="nav-link2" href="#">1월</a>
        <a class="nav-link2" href="#">2월</a>
        <a class="nav-link2" href="#">3월</a>
        <a class="nav-link2" href="#">4월</a>
        <a class="nav-link2" href="#">5월</a>
        <a class="nav-link2" href="#">6월</a>
        <a class="nav-link2" href="#">7월</a>
        <a class="nav-link2" href="#">8월</a>
        <a class="nav-link2" href="#">9월</a>
        <a class="nav-link2" href="#">10월</a>
        <a class="nav-link2" href="#">11월</a>
        <a class="nav-link2" href="#">12월</a>
   </div>
</nav>
<hr>
<body>
<c:forEach begin="1" end="12" varStatus="status">
	<div class="calen_box d-flex row">
		<div class="f1_month col-2">
		<c:set var="acadScList" value="${acadScList }" />
	   <c:if test="${not empty acadScList}" > 	
	      <img src="${pageContext.request.contextPath }/resources/img/${status.index }.png" width="200" height="180"/>
	   </c:if>
		</div>	
		<div class="fr_list col-10">
	      <c:forEach items="${acadScList }" var="acadSc">
				<c:if test="${acadSc.month eq status.index}" > 
					     <ul>
					      	<li class="acadScClick" data-acadsc-no="${acadSc.acadscNo }">
						        	<c:if test="${acadSc.acadscStart eq acadSc.acadscEnd}" > 
						        		 <strong>${acadSc.acadscStart }</strong> 
						        	</c:if>  
						        	<c:if test="${acadSc.acadscStart ne acadSc.acadscEnd}" > 
						        		 <strong>${acadSc.acadscStart } ~ ${acadSc.acadscEnd }</strong> 
						        	</c:if>   	
										 <span class="list"> ▶ ${acadSc.acadscCont }</span>
							</li>
					     </ul>
				</c:if>
				<c:if test="${acadSc.month ne status.index}" > 
				</c:if>
	      </c:forEach>
		</div>
	</div>
</c:forEach>
<br>
</body>
<style>
.monthName{
   width: 150px;
   text-align: center;
}
</style>