<%--
 학생의 휴학신청현황을 처리결과와 함께 조회
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2022. 5. 2.   김재웅  	    최초작성
* 2022. 5. 11.	고성식	    기본 ui 작성
* Copyright (c) 2022 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<security:authentication property="principal.realUser" var="authMember"/>
<script type="text/javascript" src="${cPath }/resources/js/jquery.form.min.js"></script>
<h3 class="h3-title">휴학신청 처리결과 조회</h3><hr class="hr-title">
<table>
	<thead class="thead-dark">
		<div class="d-flex bd-highlight justify-content-center">
			<div class="p-2 w-80 bd-highlight">
				<div class="card mb-3 " style="max-width: 777px;">
					<div class="row g-0">
						<div class="col-md-4" style="padding: 20px;">
							<img src="${cPath }/resources/img/profile/${authMember.userSavename}" class="img-fluid rounded-start" alt="...">
						</div>
						<div class="col-md-8">
							<div class="card-body fw-bold">
								<div class="col-xs-7 col-sm-7">
									<ul class="myInfomation" style="border-left: 3px solid #677794; list-style: none;">
										<li><strong>학번 </strong>${authMember.userNo }</li>
										<li><strong>성명 </strong>${authMember.userName }</li>
										<li><strong>학과</strong>${authMember.userDepartmentName }</li>
										<li><strong>학년 </strong>${authMember.stuYear }</li>
										<li><strong>반 </strong>${authMember.stuClass }</li>
										<li><strong>휴대폰 </strong>${authMember.userPhone }</li>
										<li><strong>이메일 </strong>${authMember.userMail }</li>
										<li><strong>학적상태 </strong>${authMember.stuCode }</li>
									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>

			</div>
		</div>
	</thead>
</table>
<table>	
	<div class="card mb-3 " style="max-width: 100%;">
		<div class="col-xs-12 col-sm-12 alert text-center" style="margin-bottom: 0; color: orange; background-color: #303138;"><strong>
			가사휴학,입대휴학 이외의 학적변동은 관련서류를 구비하여 교무처로 신청해야 합니다.<br /> 
			학사 관리자는 서류 미제출시 반려할 수 있습니다.<br>
			 (문의처:042-222-8202)</strong>
		</div>
	</div>
</table>
<table class="table table-hover table-sm">
	<thead class="thead-dark">	
		<tr>
			<th>신청번호</th>
			<th>신청학기</th>
			<th>휴학사유</th>
			<th>시작일</th>
			<th>종료일</th>
			<th>신청일</th>
			<th>승인여부</th>
			<th>반려사유</th>
		</tr>
	</thead>	
	<tbody id="listBody">
	</tbody>
	<tfoot>
		<tr>
			<td colspan="8">
		    	<div id="pagingArea">
				</div>
			</td>
		</tr>
	</tfoot>
</table>
<form id="searchForm">
	<input type="hidden" name="page" />
	<input type="hidden" name="searchType" />
	<input type="hidden" name="searchWord" />
	<security:csrfInput/>
</form>
<script type="text/javascript">
	let token = $("meta[name='_csrf']").attr("content");
	let header = $("meta[name='_csrf_header']").attr("content");

	// 리스트 조회
	function selectList(){
		var params = {};
		
		$.ajax({
			url : "${cPath}/schoolReq/selectStudentLeaveRequestList.do",
			method : "post",
			data : JSON.stringify(params),
			contentType : "application/json",
			dataType : "json",
			beforeSend : function(xhr){
				if (token && header) {
					xhr.setRequestHeader(header, token);
				}
			},
			success : function(data){
				$("#listBody").empty();
				$("#pagingArea").empty();
				
				let stuLeaveRequestlist = data.list;
				let trTags = [];
				
				if(stuLeaveRequestlist.length > 0){
					$.each(stuLeaveRequestlist, function(idx, stuLeaveRequest){
						let trTag =  "<tr id=" + stuLeaveRequest.reqId + ">";
							trTag += "<td>" + stuLeaveRequest.reqId + "</td>";
							trTag += "<td>" + stuLeaveRequest.reqSms + "</td>";
							trTag += "<td>" + stuLeaveRequest.stsCode1 + "</td>";
							trTag += "<td>" + stuLeaveRequest.semsSdate + "</td>";
							trTag += "<td>" + stuLeaveRequest.semsEdate + "</td>";
							trTag += "<td>" + stuLeaveRequest.reqDate + "</td>";
							trTag += "<td>" + stuLeaveRequest.reqYn + "</td>";
							trTag += "<td>" + stuLeaveRequest.reqDenl + "</td>";
						trTags.push(trTag);
					});
				}else{
					let trTag = $("<tr>").html($("<td>").attr("colspan", "8").html(overNoDataCode));
					trTags.push(trTag);
				} // if end
				
				$("#listBody").append(trTags);
				//pagingArea.html(paging.pagingHTMLBS)
			},
			error : function(jqXHR, textStatus, errorThrown) {
				console.log(jqXHR);
				console.log(textStatus);
				console.log(errorThrown);
			}
		});
	}


	$(document).ready(function(){
		// 리스트 조회
		selectList();
		
	});

</script>