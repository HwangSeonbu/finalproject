<%--
 학생의 장학생 수혜 이력 조회
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2022. 5. 2.      민진홍      최초작성
* Copyright (c) 2022 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    <%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
    <security:authentication property="principal.realUser" 
	var="authMember"/>
<h3 class="h3-title">장학생 이력 조회</h3><hr class="hr-title">
<!-- 학생카드 시작 -->
<div class="d-flex bd-highlight justify-content-center">
  <div class="p-2 w-80 bd-highlight">
  <div class="card mb-3 " style="max-width: 540px;">
  <div class="row g-0">
    <div class="col-md-4" style="padding:20px;">
       <img src="${cPath }/resources/img/ina.jpg" class="rounded rounded-circle" alt="..." height="100%" width="100%">
    </div>
    <div class="col-md-8">
      <div class="card-body fw-bold">
       						
								<ul class="myInfomation" style="border-left:3px solid #677794; list-style: none;">
									<li><strong>학번  </strong>${authMember.userNo }</li>
									<li><strong>성명  </strong>${authMember.userName }</li>
									<li><strong>학년  </strong>${authMember.stuYear }학년</li>
									<li><strong>학과  </strong>${authMember.userDepartmentName }</li>
									<li><strong>학적상태  </strong>${authMember.stuCode}</li>
								</ul>
						
      </div>
    </div>
  </div>
</div>
  </div>
</div>

<div class="container px-4">
  <div class="row gx-5">
    <div class="col">
    <div class="p-3 border bg-light">
    <div class="panel-heading">
						<span class="enrTitle">장학금이력조회</span>
					</div>
<table class="table table-hover text-center" id="enrTable">
								<colgroup>
									<col width="10%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
								</colgroup>
								<thead>
									<tr>
										<th>년도</th>
										<th>학기</th>
										<th>장학금명</th>
										<th>장학금액</th>
									</tr>
								</thead>
								<tbody>
	
								<c:forEach items="${enrollList}" var="enrollvo" >
								<tr>
								<c:set var="sems" value="${enrollvo.enrSems }" />
								<td hidden="hidden" id="enrId" class="${enrollvo.enrId }">
								${enrollvo.enrId }
								</td>
											<td>${fn:substring(sems,0,4)}</td>
											<td>${fn:substring(sems,5,6)}</td>
											<td>${enrollvo.scholarshipVo.schName }</td>
											<td><fmt:formatNumber value="${enrollvo.scholarshipVo.schAmount}" pattern="#,###" />원</td>

										
										</tr>
								</c:forEach>
									
									</tbody>
							</table>
</div>
</div>
<!-- 상세정보 나오는곳 -->
    <div class="col">
    <div class="p-3 border bg-light">
    <div class="panel-heading">
						<span class="enrTitle">장학금 상세</span>
					</div>
    	<table class="table" id="enrTable">
    	<tbody id="listbody">
    		<tr>
    			<td>장학금이력조회 목록에서 항목을 선택하시면 상세정보를 확인하실수 있습니다.</td>
    		</tr>
    	</tbody>
    	</table>
    </div>
    </div>
</div>
</div>
<!-- 학생카드 끝 -->
<script>
$("#enrTable").on("click", "tr" ,function(){
	let listBody = $("#listbody");
	let enrId = $(this).find("#enrId").attr('class');
	let trTags = [];
	<c:forEach items="${enrollList}" var="enrollvo" >
	var enrId2 = "${enrollvo.enrId}";
	
	if(enrId==enrId2){
		listBody.empty();
		
		let trTag = $("<tr>")
		.append(
			$("<th>").html("장학금명")	
			, $("<td>").html("${enrollvo.scholarshipVo.schName}")	
		);

		trTags.push(trTag);
		
		 trTag = $("<tr>")
		.append(
			 $("<th>").html("신청자격")		
			, $("<td>").html("${enrollvo.scholarshipVo.schQuali}")	
		);
		
		trTags.push(trTag);
		
		 trTag = $("<tr>")
			.append(
		 $("<th>").html("성적기준")	
		, $("<td>").html("${enrollvo.scholarshipVo.schScore}")	
			);
			
			trTags.push(trTag);
			
			trTag = $("<tr>")
			.append(
		 $("<th>").html("상세내용")	
		, $("<td>").html("${enrollvo.scholarshipVo.schContent}")
			);
			
			trTags.push(trTag);
			
			trTag = $("<tr>")
			.append(
		 $("<th>").html("등록금계")	
		, $("<td>").html("${enrollvo.enrPay}")
			);
			
			trTags.push(trTag);
	
		
		listBody.append(trTags);
		}

	</c:forEach>
});
</script>