<%--
	관리자의 강의계획신청현황 조회
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2022. 4. 29.      김재웅      최초작성
* Copyright (c) 2022 by DDIT All right reserved
 --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<h3 class="h3-title">강의계획 신청 현황</h3><hr class="hr-title">
<script type="text/javascript" src="${cPath }/resources/js/jquery.form.min.js"></script>

<style>
	.col{
		border: 1px solid black;
		height: 40px;
		padding-top: 5px;
	}
	.title{
		text-align: center;
		background-color: #dee2e6;
		font-weight: bold;
	}
	#searchArea{
		width: 95%;
		height:100px;
	}
	#btnArea{
		width: 95%;
		height:50px;
		text-align: right;
	}
	.table{
		border-top:2px solid black;
		width: 95%;
	}
	#planPageBody{
		width: 95%;
		height: 50px;border-top: 2px solid black;
		padding-top: 10px;
	}
	.pagination{
		justify-content: center;PQ
	}
	#extraArea{
		width: 95%;
		height:300px;
	}
	
	#planTable th{/*background-color:#dee2e6;*/ vertical-align: middle;}
	.text-center{text-align: center;}
	.detailBtn, .denialBtn{font-size: 8px;}
</style>

<!-- 상세보기 모달 START -->
<div class="modal fade" id="detailModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">강의계획 상세보기</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body" id="detailModalBody">
      	<div class="container">
       	  <div class="row">
		    <div class="col col-2 title">계획번호</div>
		    <div class="col col-2 cont" id="GplanNo"></div>
		    <div class="col col-2 title">교수명</div>
		    <div class="col col-2 cont" id="GuserName"></div>
		    <div class="col col-2 title">교수번호</div>
		    <div class="col col-2 cont" id="GuserNo"></div>
		  </div>
		  <div class="row">
		    <div class="col col-2 title">분과대학</div>
		    <div class="col col-4 cont" id="GcolName"></div>
		    <div class="col col-2 title">소속학과</div>
		    <div class="col col-4 cont" id="GdeptName"></div>
		  </div>
		  <div class="row">
		    <div class="col col-2 title">과목코드</div>
		    <div class="col col-2 cont" id="GsjtId"></div>
		    <div class="col col-2 title">과목명</div>
		    <div class="col col-6 cont" id="GsjtName"></div>
		  </div>
		  <div class="row">
		    <div class="col col-2 title">대상학년</div>
		    <div class="col col-1 cont" id="GplanYear"></div>
		    <div class="col col-2 title">정원</div>
		    <div class="col col-1 cont" id="GplanLimit"></div>
		    <div class="col col-2 title">강의시수</div>
		    <div class="col col-1 cont" id="GplanTcnt"></div>
		    <div class="col col-2 title">이수학점</div>
		    <div class="col col-1 cont" id="GsjtCredit"></div>
		  </div>
		  <div class="row">
		    <div class="col col-2 title">평가구분</div>
		    <div class="col col-2 cont" id="GplanEval"></div>
		    <div class="col col-2 title">과목구분</div>
		    <div class="col col-2 cont" id="GsjtMajor"></div>
		    <div class="col col-2 title">제출상태</div>
		    <div class="col col-2 cont" id="GplanSts"></div>
		  </div>
		  <div class="row">
		    <div class="col col-2 title">강의요약</div>
		    <div class="col col-10 cont" id="GplanSmry"></div>
		  </div>
		  <div class="row">
		    <div class="col col-12 title">주차설명</div>
		  </div>
		</div>
      </div>
      <div class="modal-footer">
        <button type="button" id="checkBtn" class="btn btn-primary btn-sm" data-plan-no="" data-bs-dismiss="modal">체크하고 닫기</button>
        <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>
<!-- 상세보기 모달 HTML END -->
<!-- 반려사유 모달 HTML END -->
<div class="modal fade" id="denailModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="denailModalLabel">반려사유 입력</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body" id="denailModalBody">
      	<div class="form-floating">
		  <textarea class="form-control"id="floatingTextarea" style="height: 300px"></textarea>
		  <label for="floatingTextarea">반려사유 입력</label>
		</div>
      </div>
      <div class="modal-footer">
        <button type="button" id="denialBtn" class="btn btn-danger btn-sm" data-plan-no="">반려확정</button>
        <button type="button" id="cancelBtn" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">취소</button>
      </div>
    </div>
  </div>
</div>
<!-- 반려사유 모달 HTML END -->
<div id="searchArea">
	<label style="color:blue;">분과대학</label>
	<select class="select-search-long" id="collegeSelection">
		<option selected>전체</option>
	</select>&nbsp;&nbsp;&nbsp;
	<label style="color:blue;">소속학과</label>
	<select class="select-search-long" id="departmentSelection">
		<option selected>전체</option>
	</select>&nbsp;&nbsp;&nbsp;
	<label style="color:blue;">이수구분</label>
	<select class="select-search-long" id="majorSelection">
		<option value="" selected>전체</option>
		<option value="전">전공전체</option>
		<option value="전필">전공필수</option>
		<option value="전선">전공선택</option>
		<option value="교">교양</option>
	</select>&nbsp;&nbsp;&nbsp;
	<label style="color:blue;">처리상태</label>
	<select class="select-search-short" id="statusSelection">
		<option value="" selected>전체</option>
		<option value="B105">제출</option>
		<option value="B102">승인</option>
		<option value="B103">반려</option>
	</select><br>
	<br><label style="color:blue;">단어검색</label>
	<select class="select-search-long" id="searchTypeSelection">
		<option value="" selected>전체</option>
		<option value="userName">교수명</option>
		<option value="sjtName">과목명</option>
		<option value="planSmry">강의계획명</option>
	</select>&nbsp;&nbsp;<input type="text" id="searchWordInput" value="" style="width:350px; text-align:left; padding-left:10px;" />
	&nbsp;<button type="button" id="searchBtn" class="btn btn-primary">검색</button>&nbsp;
	<button type="button" id="defaultBtn" class="btn btn-secondary">검색초기화</button><br><br>
</div>

<div id="btnArea">
	<button style="visibility:hidden;" type="button" id="realDenialBtn" data-bs-toggle="modal" data-bs-target="#denailModal"></button>
	<button type="button" id="allApproveBtn" class="btn btn-success" value="B102">선택승인</button>
	<button type="button" id="allDenialBtn" class="btn btn-danger" value="B103">선택반려</button>
</div>

<table class="table table-bordered" id="planTable">
 <thead>
    <tr class="text-center">
    	<th ><input id="checkAll" type="checkbox" /></th>	
    	<th >계획<br>번호</th>	
    	<th >처리상태</th>	
    	<th >교수명</th>	
    	<th >분과대학</th>	
    	<th >소속학과</th>	
    	<th >강의계획명</th>	
    	<th >과목명</th>	
    	<th >구분</th>	
    	<th >학점</th>	
    	<th >정원</th>	
    	<th >상세</th>	
    	<th >반려</th>	
    </tr>
 </thead>
 <tbody class="text-center" id="planListTbody">
	<tr>
		<td colspan="13">제출한 강의계획이 없습니다.</td>
	</tr>
 </tbody>
</table>
<div id="planPageBody"></div>
<div id="extraArea">
	<form id="searchForm">
	<security:csrfInput/> 
		<input type="hidden" name="holdPage"/>
		<input type="hidden" name="holdPlanSts"/>
		<input type="hidden" name="holdColName"/>
		<input type="hidden" name="holdDeptId"/>
		<input type="hidden" name="holdSjtMajor"/>
		<input type="hidden" name="holdSearchType"/>
		<input type="hidden" name="holdSearchWord"/>
	</form>
</div>





<script>
var customNoDataCode = "<div class='div-imageWrap' id='imageWrap'><div class='div-imageInnerWrap'>";
customNoDataCode += "<img alt='' src='${cPath }/resources/img/noData.jpg' style='width:100%;'/></div>";
customNoDataCode += "<div class='div-textInnerImage'> 조건에 맞는 강의계획이<br>없습니다.</div></div>";

let planListTbody = $("#planListTbody");
let planPageBody = $("#planPageBody");
let detailModalBody = $("#detailModalBody");
let gridConts = $(".cont");
let gridContainer = $(".container");

//버튼 변수--------------------------
let searchBtn = $("#searchBtn");
let checkBtn = $("#checkBtn");
let denialBtn = $("#denialBtn");
let cancelBtn = $("#cancelBtn");
let allApproveBtn = $("#allApproveBtn");
let allDenialBtn = $("#allDenialBtn");
let realDenialBtn = $("#realDenialBtn");
let defaultBtn = $("#defaultBtn");
//-------------------------------------

//모달 그리드 변수--------------------
let GplanNo    = $("#GplanNo");
let GuserName  = $("#GuserName");
let GuserNo    = $("#GuserNo");
let GcolName   = $("#GcolName");
let GdeptName  = $("#GdeptName");
let GsjtId     = $("#GsjtId");
let GsjtName   = $("#GsjtName");
let GplanYear  = $("#GplanYear");
let GplanLimit = $("#GplanLimit");
let GplanTcnt  = $("#GplanTcnt");
let GsjtCredit = $("#GsjtCredit");
let GplanEval  = $("#GplanEval");
let GsjtMajor  = $("#GsjtMajor");
let GplanSts   = $("#GplanSts");
let GplanSmry  = $("#GplanSmry");
//--------------------------------
//검색 영역 변수
let collegeSelection = $("#collegeSelection");
let departmentSelection = $("#departmentSelection");
let statusSelection = $("#statusSelection");
let majorSelection = $("#majorSelection");
let searchTypeSelection = $("#searchTypeSelection");
let searchWordInput = $("#searchWordInput");

//--hiddenInput
let holdPlanSts = $("input[name=holdPlanSts]");
let holdColName = $("input[name=holdColName]");
let holdDeptId = $("input[name=holdDeptId]");
let holdSjtMajor = $("input[name=holdSjtMajor]");
let holdSearchType = $("input[name=holdSearchType]");
let holdSearchWord = $("input[name=holdSearchWord]");
//--------------------------------

function submitPlanList(){
	let page = $("[name=holdPage]").val();
	let planSts = holdPlanSts.val();
	let colName = holdColName.val();
	let deptId = holdDeptId.val();
	let sjtMajor = holdSjtMajor.val();
	let searchType = holdSearchType.val();
	let searchWord = holdSearchWord.val();
	
	$.ajax({
		url : "${cPath}/lecReq/LectureRequestListData.do",
		method : "get",
		data:{page : page, colName:colName, deptId:deptId, sjtMajor:sjtMajor
			, planSts:planSts, searchType:searchType, searchWord:searchWord},
		dataType : "json",
		success : function(resp) {
			planListTbody.empty();
			planPageBody.empty();
			
			let paging = resp.pagingVo;
			let planList = paging.dataList;
			
			let trTags = [];
			if(planList && planList.length > 0){
				$.each(planList, function(idx, plan){
					let eachPlanSts = plan.planSts;
					let trTag = $("<tr>").attr("data-plan-no", plan.planNo);
						if(eachPlanSts == "제출"){
							trTag.append($("<td>").append($("<input>").attr("type", "checkbox")
											.attr("id", plan.planNo).addClass("checkEach")
											.attr("data-user-no", plan.userNo)
											.attr("data-user-name", plan.userName)
											.attr("data-sjt-name", plan.sjtName)
											.attr("data-sjt-id", plan.sjtId)));
						}else{
							trTag.append($("<td>"));
						}
						trTag.append($("<td>").html(plan.planNo)
										, $("<td>").html(eachPlanSts).addClass("planStsTd")
												.css("font-weight", "bold")
										, $("<td>").html(plan.userName)	
										, $("<td>").html(plan.colName)	
										, $("<td>").html(plan.deptName)	
										, $("<td>").html(plan.planSmry).addClass("text-left")
										, $("<td>").html(plan.sjtName).addClass("text-left")
										, $("<td>").html(plan.sjtMajor)	
										, $("<td>").html(plan.sjtCredit)	
										, $("<td>").html(plan.planLimit)
										, $("<td>").append($("<input>").attr("type", "button")
												.attr("value", "보기").addClass("btn btn-primary btn-sm detailBtn").attr("data-plan-no", plan.planNo)
												.attr("data-bs-toggle", "modal").attr("data-bs-target", "#detailModal"))
										)
						if(eachPlanSts == "제출"){
							trTag.append($("<td>").append($("<input>").attr("type", "button")
									.attr("value", "반려").addClass("btn btn-danger btn-sm denialBtn").attr("data-plan-no", plan.planNo))
									.attr("data-bs-toggle", "modal").attr("data-bs-target", "#denailModal"));
						}
					trTags.push(trTag);
				});
			}else{
				let trTag = $("<tr>").html(
								$("<td>").attr("colspan", "13")
										 .html(customNoDataCode)
							);
				trTags.push(trTag);
			} // if end
			planListTbody.append(trTags);
			planPageBody.html(paging.pagingHTMLBS);
			planStsColor();
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR);
			console.log(textStatus);
			console.log(errorThrown);
		}
	});
};
submitPlanList();

$(document).on("click", "#checkAll", function(){
	if($("#checkAll").is(":checked")){
		$(".checkEach").prop("checked", true);
	}else{
		$(".checkEach").prop("checked", false);
	}
});

$(document).on("click", ".checkEach", function(){
	if($("input[class=checkEach]:checked").length == $(".checkEach").length){
		$("#checkAll").prop("checked", true);
	}else{
		$("#checkAll").prop("checked", false);
	}
});

planListTbody.on("click", ".detailBtn", function(){
	let pickPlanNo = $(this).data("planNo");
	gridConts.empty();
	detailModalBody.find(".week").remove();
	
	
	$("#checkBtn").data("planNo", pickPlanNo);
	
	$.ajax({
		url : "${cPath}/lecReq/LectureRequestOneData.do",
		method : "get",
		data : {planNo : pickPlanNo},
		dataType : "json",
		success : function(resp) {
			let plan = resp.submitPlanVo;
			let wplanList = plan.wplanList;
			
			GplanNo.text(plan.planNo);
			GuserName.text(plan.userName);
			GplanSts.text(plan.planSts);
			GuserNo.text(plan.userNo);
			GsjtId.text(plan.sjtId);
			GsjtName.text(plan.sjtName);
			GplanYear.text(plan.planYear);
			GplanLimit.text(plan.planLimit);
			GplanTcnt.text(plan.planTcnt);
			GplanEval.text(plan.planEval);
			GcolName.text(plan.colName);
			GdeptName.text(plan.deptName);
			GsjtCredit.text(plan.sjtCredit);
			GsjtMajor.text(plan.sjtMajor);
			GplanSmry.text(plan.planSmry);
			
			if(wplanList && wplanList.length > 0){
				$.each(wplanList, function(idx, wPlan){
					if(wPlan.wplanW == null){
						gridContainer.append($("<div>").addClass("row week").append(
								 $("<div>").addClass("col col-12 cont").text("주차별 강의설명이 없습니다.")
								));
					}else{
						gridContainer.append($("<div>").addClass("row week").append(
												$("<div>").addClass("col col-2 title").text(wPlan.wplanW+"주차")
												, $("<div>").addClass("col col-10 cont").text(wPlan.wplanCont)
								));
					}
				});
			}else{
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR);
			console.log(textStatus);
			console.log(errorThrown);
		}
	});
});

//테이블의 반려 버튼을 누르면, 현재보고있는 강의계획 데이터를 모달 반려확정버튼에 저장한다. 텍스트 에어리아를 리셋한다.
planListTbody.on("click", ".denialBtn", function(){
	let pickPlanNo = $(this).data("planNo");
	$("#floatingTextarea").val("");
	$("#denailModalLabel").text("[계획번호 : "+pickPlanNo+"] 반려사유 입력");
	
	$("#denialBtn").data("planNo", pickPlanNo);
});

let planNos = [];
//선택 반려 버튼을 누를 경우
allDenialBtn.on("click", function(){
	
	planNos = [];
	let checkBoxes = planListTbody.find("input[class=checkEach]:checked");
	$.each(checkBoxes, function(idx, checkBox){
		let thisid = $(this).attr("id");
		planNos.push(thisid);
	});
	
	if(planNos.length > 0){
		$("#floatingTextarea").val("");
		$("#denailModalLabel").text("반려사유를 일괄 입력합니다.");
		$("#denialBtn").data("planNo", "일괄");
		realDenialBtn.trigger("click");
	}else{
		alert("반려할 계획을 선택해주세요.");
	};
});


//선택 승인 버튼을 누를 경우
allApproveBtn.on("click", function(){
	/* 플번 교번 교네임      과목네임		과목아이디
	8	51	교지현	인권과 현대사회	S15 */
	
	planNos = [];
	let checkBoxes = planListTbody.find("input[class=checkEach]:checked");
	$.each(checkBoxes, function(idx, checkBox){
		let thisid = $(this).attr("id");
		let userNo = $(this).data("userNo");
		let userName = $(this).data("userName");
		let sjtName = $(this).data("sjtName");
		let sjtId = $(this).data("sjtId");
		let targetVo = {planNo:thisid, userNo:userNo, userName:userName
				, sjtName:sjtName, sjtId:sjtId};
		planNos.push(targetVo);
	});
	
	if(planNos.length > 0){
		if(confirm("승인처리 후 변경할수 없습니다.\n"+planNos.length+"건의 강의를 승인하시겠습니까?")){
			approveUpdate(planNos);
		}
	}else{
		alert("승인할 계획을 선택해주세요.");
	};
});

//조회모달창에서 체크하고 닫기를 누르면, 현재보고있는 강의계획 체크박스를 찾아 체크한다.
checkBtn.on("click", function(){
	let pickPlanNo = $(this).data("planNo");
	$("#"+pickPlanNo).prop("checked", true);
});

//반려모달창에서 반려확정을 누르면, 반려 처리 프로세스를 진행한다.
denialBtn.on("click", function(){
	let pickPlanNo = $(this).data("planNo");
	let planDenlrsn = $("#floatingTextarea").val().trim();
	
	if(planDenlrsn == null || planDenlrsn == ""){
		alert("반려사유 입력해주세요.");
		return false;
	}
	if(confirm("반려 확정하시겠습니까?")){
		cancelBtn.trigger("click");
	}else{
		return false;
	}
	if(pickPlanNo == "일괄"){
		denialUpdate(planNos, planDenlrsn);
	}else{
		denialUpdate(pickPlanNo, planDenlrsn);
	}
});

//분과대학 체인지 이벤트 발생시
collegeSelection.on("change", function(){
	let colName = $(this).val();
	if(colName == ""){
		departmentSelection.empty();
		departmentSelection.append($("<option>").attr("value", "").text("전체"));
	}else{
		departmentListFunc(colName);
	}
	holdColName.val(colName);
	holdDeptId.val("");
});

//디파트먼트 체인지 이벤트 발생시
departmentSelection.on("change", function(){
	let deptId = $(this).val();
	let colName = $(this).data("colName");	//작동안됨(undefined)
	holdDeptId.val(deptId);
});
//처리상태 체인지 이벤트 발생시
statusSelection.on("change", function(){
	let planSts = $(this).val();
	holdPlanSts.val(planSts);
});
//전공구분  체인지 이벤트 발생시
majorSelection.on("change", function(){
	let sjtMajor = $(this).val();
	holdSjtMajor.val(sjtMajor);
});
//검색조건  체인지 이벤트 발생시
searchTypeSelection.on("change", function(){
	let searchType = $(this).val();
	holdSearchType.val(searchType);
});
//검색버튼 클릭시
searchBtn.on("click", function(){
	let searchWord = $("#searchWordInput").val();
	$("[name=holdPage]").val(1);
	holdSearchWord.val(searchWord);
	
	submitPlanList();
});
//페이지네이션 클릭시
planPageBody.on("click", "a", function(){
	let page = $(this).data("page");
	$("[name=holdPage]").val(page);
	
 	submitPlanList();
});

/* 반려처리 Ajax */
function denialUpdate(target, reason){
	let jsonEle = { "targetPlanNos" : JSON.stringify(target), "reason" : reason };
	
	$.ajax({
		url : "${cPath}/lecReq/LectureDenialProcess.do",
		method : "get",
		data : jsonEle,
		dataType : "json",
		success : function(resp) {
			let result = resp.result;
			if(result != "실패"){
				alert(result+"건의 계획을 반려했습니다.");
				submitPlanList();
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR);
			console.log(textStatus);
			console.log(errorThrown);
		}
	});
};

/* 승인처리 Ajax */
function approveUpdate(target){
	let jsonEle = { "targetPlanNos" : JSON.stringify(target) };
	
	$.ajax({
		url : "${cPath}/lecReq/LectureApproveProcess.do",
		method : "get",
		data : jsonEle,
		dataType : "json",
		success : function(resp) {
			let result = resp.result;
			if(result != "실패"){
				alert(result+"건의 계획을 승인했습니다.");
				submitPlanList();
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR);
			console.log(textStatus);
			console.log(errorThrown);
		}
	});
};

function planStsColor(){
	let planStsTds = $(".planStsTd");
	
	$.each(planStsTds, function(idx, planStsTd){
		var planSts = $(this).text();
		if(planSts == "제출"){
			$(this).css("color", "blue");
		}else if(planSts == "반려"){
			$(this).css("color", "red");
		}else{
			$(this).css("color", "green");
		}
	});
};

function CollegeListFunc(){
	$.ajax({
		url : "${cPath}/lecReq/collegeSelectionData.do",
		method : "get",
		dataType : "json",
		success : function(resp) {
			collegeSelection.empty();
			let collegeList = resp.collegeList;
			let options = [];
			if(collegeList && collegeList.length > 0){
				let option = $("<option>").attr("value","").text("전체");
				options.push(option);
				$.each(collegeList, function(idx, college){
					option = $("<option>").attr("value", college.colName).text(college.colName);
					options.push(option);
				});
			}else{
			} 
			collegeSelection.append(options);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR);
			console.log(textStatus);
			console.log(errorThrown);
		}
	});
};
CollegeListFunc();

function departmentListFunc(colName){
	$.ajax({
		url : "${cPath}/lecReq/departmentSelectionData.do",
		method : "get",
		data : {colName:colName},
		dataType : "json",
		success : function(resp) {
			departmentSelection.empty();
			
			let departList = resp.departList;
			let options = [];
			if(departList && departList.length > 0){
				let option = $("<option>").attr("value","").text("전체");
				options.push(option);
				$.each(departList, function(idx, depart){
					option = $("<option>").attr("value", depart.deptId).text(depart.deptName)
								.attr("data-col-name", depart.colName);
					options.push(option);
				});
			}else{
			} 
			departmentSelection.append(options);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR);
			console.log(textStatus);
			console.log(errorThrown);
		}
	});
};

defaultBtn.on("click", function(){
	$("select").prop("selectedIndex",0);
	$("[name=holdPage]").val(1);
	searchWordInput.val("");
	holdColName.val("");
	holdDeptId.val("");
	holdPlanSts.val("");
	holdSjtMajor.val("");
	holdSearchType.val("");
	holdSearchWord.val("");
	submitPlanList();
});
</script>









