<%--
교수가 제출환 강의계획 목록조회
(제목을 클릭하면 점수 비중을 설정하는 jsp로 이동한다)
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2022. 4. 28.      김재웅      최초작성
* Copyright (c) 2022 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<h3 class="h3-title">강의계획 신청 현황</h3><hr class="hr-title">
<style>
	#planTable{
		width: 65%;
		table-layout: fixed;
	}
	#planTable td{
		overflow: hidden;
	}
	#planNoTh{width: 100px;}
	#planStsTh{width: 100px;}
	#sjtNameTh{width: 200px;}
	.th-numberTh{width: 70px;}
	#btnTh{width: 70px;}
	.detailBtn{font-size: 8px;}
	.col{
		border: 1px solid black;
		min-height : 40px;
		padding-top: 5px;
	}
	.title{
		text-align: center;
		background-color: #dee2e6;
		font-weight: bold;
	}
	.denialTitle{
		text-align: center;
		background-color: yellow;
		font-weight: bold;
	}
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
        <button type="button" style="display: none;" id="editBtn" class="btn btn-primary btn-sm" data-plan-no="" data-bs-dismiss="modal">재작성</button>
        <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>
<!-- 상세보기 모달 HTML END -->

<table class="table table-bordered" id="planTable">
 <thead>
    <tr class="text-center" style="vertical-align: middle;">
    	<th id="planNoTh">계획번호</th>
    	<th id="sjtNameTh">과목명</th>	
    	<th class="th-numberTh">대상<br>학년</th>	
    	<th class="th-numberTh">강의<br>시수</th>		
    	<th class="th-numberTh">정원</th>	
    	<th id="planSmryTh">강의계획명</th>	
    	<th id="planStsTh">처리상태</th>	
    	<th id="btnTh">상세<br>보기</th>	
    </tr>
 </thead>
 <tbody class="text-center" id="planListBody">
	<c:if test="${empty submitPlanList }">
		<tr>
			<td colspan="8">
				<div class="div-imageWrap" id="imageWrap">
					<div class="div-imageInnerWrap">
						<img alt="" src="${cPath }/resources/img/noData.jpg" style="width:100%;"/>
					</div>
					<div class="div-textInnerImage"> 제출한 강의계획이<br>없습니다.</div>
				</div>
			</td>
		</tr>
	</c:if>
	<c:if test="${not empty submitPlanList}">
		<c:forEach items="${submitPlanList }" var="plan">
			<tr data-plan-no="${plan.planNo }">
				<td>${plan.planNo }</td>
				<td>${plan.sjtName }</td>
				<td>${plan.planYear }</td>
				<td>${plan.planTcnt }</td>
				<td>${plan.planLimit }</td>
				<td>${plan.planSmry }</td>
				<td class="planStsTd" style="font-weight: bold;">${plan.planSts }</td>
				<td>
					<input type="button" value="보기" class="btn btn-primary btn-sm detailBtn"
						data-plan-no="${plan.planNo }" data-bs-toggle="modal" data-bs-target="#detailModal" />
				</td>
			</tr>
		</c:forEach>
	</c:if>	
 </tbody>
</table>

<script>
let detailFormURL = "${cPath}/lecPlan/LecturePlanDetailForm.do?planNo=";

let planStsTds = $(".planStsTd");
let planListBody = $("#planListBody");
let detailModalBody = $("#detailModalBody");
let gridConts = $(".cont");
let gridContainer = $(".container");
let editBtn = $("#editBtn");

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

$.each(planStsTds, function(idx, planStsTd){
	let planSts = $(this).text();
	if(planSts == "승인"){
		$(this).css("color", "green");
	}else if (planSts == "반려") {
		$(this).css("color", "red");
	}else{
		$(this).css("color", "blue");
	}
});

planListBody.on("click", ".detailBtn", function(){
	let pickPlanNo = $(this).data("planNo");
	gridConts.empty();
	detailModalBody.find("#denialH4").remove();
	detailModalBody.find(".week").remove();
	
	$("#editBtn").data("planNo", pickPlanNo);
	
	$.ajax({
		url : "${cPath}/lecPlan/LectureRequestOneData.do",
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
			}
			if(plan.planSts == "반려"){
				editBtn.css("display", "block");
				gridContainer.prepend($("<h4>").text("반려된 강의입니다. 사유를 확인해주세요.").attr("id", "denialH4")
						, $("<div>").addClass("row week").append(
								$("<div>").addClass("col col-2 denialTitle").text("반려사유")
								, $("<div>").addClass("col col-10 cont").text(plan.planDenlrsn)
					)
				);
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR);
			console.log(textStatus);
			console.log(errorThrown);
		}
	});
});

editBtn.on("click", function(){
	let targetURL = detailFormURL;
	let pickPlanNo = $(this).data("planNo");
	targetURL += pickPlanNo;

	if(targetURL)
		location.href=targetURL;
});
</script>












