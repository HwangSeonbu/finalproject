<!--  [[개정이력(Modification Information)]]       -->
<!--  수정일      		  수정자  	   수정내용               -->
<!--  ==========   ======    ==============        -->
<!--  2022. 5. 17.   고성식  	   최초작성              -->
<!--  Copyright (c) 2022 by DDIT All right reserved -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<script type="text/javascript" src="${cPath }/resources/js/jquery.form.min.js"></script>
<h3 class="h3-title">기타장학생 선정</h3><hr class="hr-title">
<style>
#processBtnBody{
		text-align: right;
}

.pagination{
	justify-content: center;
}
</style>
<!-- 반려사유 모달 HTML START -->
<div class="modal fade" id="denailModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="denailModalLabel">반려사유 입력</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body" id="denailModalBody">
      	<div class="form-floating">
		  <textarea class="form-control" id="floatingTextarea" style="height: 300px"></textarea>
		  <label for="floatingTextarea">반려사유 입력</label>
		</div>
      </div>
      <div class="modal-footer">
        <button type="button" id="denialBtn" class="btn btn-danger btn-sm" data-req-id="">반려확정</button>
        <button type="button" id="cancelBtn" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">취소</button>
      </div>
    </div>
  </div>
</div>
<!-- 반려사유 모달 HTML END -->
    
<div>
	<select id="semsNo">
		<c:forEach items="${semsdata}" var="list">
			<option value="${list}">${list}</option>
		</c:forEach>
	</select>
</div>
<div id="processBtnBody">
	<button type="submit" class="btn btn-primary btn-sm" onclick="getCheckboxValue();">선택승인</button>&nbsp;
	<button type="button" class="btn btn-danger btn-sm denialBtn" data-bs-toggle="modal" data-bs-target="#denailModal">선택반려</button>
	<button style="visibility:hidden;" type="button" id="realDenialBtn" data-bs-toggle="modal" data-bs-target="#denailModal"></button>
</div>
<table class="table table-hover table-sm">
<thead class="thead-dark">
		<tr>
			<th scope="col" class="frst">
			<input type="checkbox" id="chkalltop" title="선택" class="check _click"></th>
			<th>요청번호</th>
			<th>학번</th>
			<th>이름</th>
			<th>분과대학</th>
			<th>학과</th>
			<th>학년</th>
			<th>반</th>
			<th>요청날짜</th>
			<th>장학코드</th>
			<th>장학종류</th>
			<th>요청학기</th>
			<th>요청상태</th>
			<th>반려</th>
		</tr>
	</thead>
	<tbody id="listBody">
	</tbody>
	<tfoot>
		<tr>
			<td colspan="13">
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
<script>
let listBody = $("#listBody");
let pagingArea = $("#pagingArea");
let token = $("meta[name='_csrf']").attr("content");
let header = $("meta[name='_csrf_header']").attr("content");
let floatingTextarea = $("floatingTextarea");
//버튼
let searchBtn = $("#searchBtn");
let checkBtn = $("#checkBtn");
let cancelBtn = $("#cancelBtn");
let allApproveBtn = $("#allApproveBtn");
let allDenialBtn = $("#allDenialBtn");
let realDenialBtn = $("#realDenialBtn");
let denialBtn = $("denialBtn");
var thisSems = ${sessionScope.semsVo.nextSems};
let page = "1";

// 이벤트 Function
var eventFunction = function(){
	$("#chkalltop").click(function() {
		if($("#chkalltop").is(":checked")) $("input[name=chk]").prop("checked", true);
		else $("input[name=chk]").prop("checked", false);
	});
	
	// 페이징 클릭 이벤트
	$("#pagingArea").on("click", "a", function(){
		page = $(this).data("page");
		selectList(page);
	});
	
	// 수강학기 변경 이벤트
	$("#semsNo").on("change", function(){
		selectList(1);
	});
	
	$("#confrimBtn").click(function(){
		 getCheckboxValue();
	});
	
	// 모달창 종료 시 이벤트
	$("#denailModal").on('hide.bs.modal', function () {
		$("#denailModalLabel").text("반려사유 입력");
		$("#denialBtn").data("reqId", "");
	});
	
	// 반려 버튼 이벤트 : 모달창 show > 확정반려 버튼에 reqId 값을 넣어준다.
	$(".denialBtn").on("click", function(){
		let pickReqId = $(this).data("reqId");
		let pickUserName = $(this).data("userName");
		
		$("#floatingTextarea").val("");
		
		if(pickReqId != null){
			$("#denailModalLabel").text("[학생 : "+pickUserName+"] 반려사유 입력");
		}
		
		$("#denialBtn").data("reqId", pickReqId)
	});
}

// 리스트 조회
function selectList(page){
	var param = {
		page : page,
		semsNo : $("#semsNo").val()
	}
	
	$.ajax({
		url : "${cPath}/setScholar/setCreditEtcScholarStudentList.do",
		method : "post",
		data : param,
		dataType : "json",
		beforeSend : function(xhr) {
			if (token && header) {
				xhr.setRequestHeader(header, token);
			}
		},
		success : function(data){
			$("#listBody").empty();
			
			let etcScholarshipList = data.list;
			let trTags = [];
			if(etcScholarshipList && etcScholarshipList.length > 0){
				$.each(etcScholarshipList, function(idx, etcScholarship){
					var visibility = etcScholarship.reqCode == 'B101' ? "visibile": "hidden"
					let trTag = $("<tr>").attr("id", etcScholarship.userNo)
										.append(
													$("<td>").append($("<input>")
															.attr("type", "checkbox").attr("name", "chk").css("visibility", visibility)
													)
													, $("<td>").html(etcScholarship.reqId)
													, $("<td>").html(etcScholarship.userNo)
													, $("<td>").html(etcScholarship.userName)
													, $("<td>").html(etcScholarship.colName)
													, $("<td>").html(etcScholarship.deptName)	
													, $("<td>").html(etcScholarship.stuYear) 
													, $("<td>").html(etcScholarship.stuClass)
													, $("<td>").html(etcScholarship.reqDate)
													, $("<td>").html(etcScholarship.stsId)
													, $("<td>").html(etcScholarship.stsCode1)
													, $("<td>").html(etcScholarship.semsNo)
													, $("<td>").html(etcScholarship.reqStat1)
													, $("<td>").append(
															$("<input>").attr("type", "button")
																.attr("class", "btn btn-danger btn-sm denialBtn").attr("data-bs-target","#denailModal")
																.attr("data-bs-toggle","modal")
																.attr("data-req-id", etcScholarship.reqId).attr("data-user-name", etcScholarship.userNo)
																.attr("value", '반려').css("visibility", visibility))
										);
					trTags.push(trTag);
				});
			}else{
				let trTag = $("<tr>").html($("<td>").attr("colspan", "13").html(overNoDataCode));
				trTags.push(trTag);
			}
			$("#listBody").append(trTags);
			$("#pagingArea").html(data.paging.pagingHTMLBS);
			$("#chkalltop").prop("checked", false);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR);
			console.log(textStatus);
			console.log(errorThrown);
		}
	});
	
};

//승인 버튼 눌렀을 때 이벤트
function getCheckboxValue(){
	// 선택된 목록 가져오기
	let scholarNos = [];
	let scholarNosList = {};
	
	let names = listBody.find('input[name="chk"]:checked');
	
	// 기타장학생 승인 할 학생이 체크되었는지 확인
	if(names.length == 0){
		alert("승인할 학생을 선택해 주세요.");
		return false;
	}
	
	// 기타장학생을 승인할 학생을 추출
	$.each(names, function(idx,name){
		let thisName = $(this).parents("tr").attr("id");
		let thisReqId = $(this).parents('tr').children().eq(1).text();
		let thisSchNo = $(this).parents('tr').children().eq(9).text();
		let thisSems = $("#semsNo").val();
		
// 		let this
		let jsonEle = {
			"userNo" : thisName
			,"reqId" : thisReqId
			,"enrSems" : thisSems
			,"schNo" : thisSchNo
		};
		
		scholarNos.push(jsonEle);
	});
	
	//승인 처리
	$.ajax({
		url : "${cPath}/setScholar/modifyEtcScholarshipSts.do",
		method : "post",
		data : JSON.stringify(scholarNos),
		contentType : "application/json",
		dataType : "json",
		beforeSend : function(xhr){
			if (token && header) {
				xhr.setRequestHeader(header, token);
			}
		},
		success : function(resp){
			alert(scholarNos.length+"명을 장학생으로 선택 완료");
			selectList(1);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR);
			console.log(textStatus);
			console.log(errorThrown);
		}
	});
}

//반려확정 이벤트 : pickReqId 있으면 개인반려, 없으면 선택된 학생들 반려
$(document).on("click", ".denialBtn", function(){
	let pickReqId = $(this).data("reqId");
	//$("#denialBtn").data("reqId", pickReqId);
	$("#denialBtn").attr("data-req-id", pickReqId);
});


$("#denialBtn").click(function(){
	let pickReqId = $("#denialBtn").data("reqId");
	console.log(pickReqId);
	let reqDenl = $("#floatingTextarea").val();
	let etcSchNos = [];
	let etcSchNosList = {};
	
// 	return false;
	
	if(pickReqId != ""){	// 개인 반려
		let jsonEle = {
	  		"reqId" : pickReqId
	  		,"reqDenl" : reqDenl
	  	};
	  	
		etcSchNos.push(jsonEle);
	}else{					// 선택(여러명) 반려
		let reqIds = listBody.find('input[name="chk"]:checked');
		
		// 반려 할 학생이 체크되었는지 확인
		if(reqIds.length ==0){
			alert("반려 할 학생을 선택해 주세요.");
			return false;
		}
		 
		// 반려할 승인할 학생을 추출
		$.each(reqIds, function(idx, name){
			let reqId = $(this).parents("tr").attr("id");
			
		  	let jsonEle = {
		  		"reqId" : reqId
		  		,"reqDenl" : reqDenl
		  	};
		  	
		  	etcSchNos.push(jsonEle);
	 	});
	}

	//반려처리
	if(etcSchNos.length > 0){
		$.ajax({
			url : "${cPath}/setScholar/modifyStuReferEtcScholarshipTarget.do",
			method : "post",
			data : JSON.stringify(etcSchNos),
			contentType : "application/json",
			dataType : "json",
			beforeSend : function(xhr){
				if (token && header) {
					xhr.setRequestHeader(header, token);
				}
			},
			success : function(resp){
				$("#denailModal").hide();
				alert("반려처리되었습니다.");
				searchForm.submit();
			},
			error : function(jqXHR, textStatus, errorThrown) {
				console.log(jqXHR);
				console.log(textStatus);
				console.log(errorThrown);
			}
		});
	};
	
});


$(function(){
	eventFunction();
	$("#semsNo").val(thisSems);
	selectList(1);
});


</script>