<%--
 학과장 교수가 배정결과를 학사관리자에게 제출하는 페이지
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2022. 5. 2.      김재웅      최초작성
* Copyright (c) 2022 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h3 class="h3-title">배정결과 제출</h3><hr class="hr-title">
<style>
	#mainTbl{
		vertical-align:middle;
		text-align:center;
		font-size:20px;
		width:80%;
		min-height: 80px;
	}
	#mainTbl th{
		background-color: orange;
	}
	.tr-duplicatedLine{
		background-color: red;
		color:white;
		font-weight: bold;
	}
	.table{
		border-top:2px solid black;
		width: 95%;
	}
</style>

<table class="table table-bordered" id="mainTbl">
  <tr>
    <th>소속</th><td>${department.colName } ${department.deptName }</td>
    <th>강의관</th>
    <td>${department.colGwan }</td>
  </tr>
</table>

<div class="redLine" id="btnArea">
	<input type="button" id="duplicateBtn" class="btn btn-warning" disabled="disabled" value="중복검사" />
	<input type="button" id="submitBtn" class="btn btn-success" disabled="disabled" value="배정제출" />
</div>

<table class="table table-bordered" id="dataTable">
	 <thead>
	    <tr class="tr-headLine">
	    	<th >순번</th>	
	    	<th >이수구분</th>	
	    	<th >교수명</th>	
	    	<th >강의명</th>	
	    	<th >정원</th>	
	    	<th >시수</th>	
	    	<th >강의관</th>	
	    	<th >강의실</th>	
	    	<th >시간1</th>	
	    	<th >시간2</th>
	    	<th >배정<br>상태</th>
	    </tr>
	 </thead>
	 <tbody class="text-center" id="dataListTbody">
	 
	 </tbody>
</table>
<div class="redLine" id="pageArea">
</div>


<div class="redLine" id="extraArea"></div>

<script>
var customDataCode = "<div class='div-imageWrap' id='imageWrap'><div class='div-imageInnerWrap'>";
customDataCode += "<img alt='' src='${cPath }/resources/img/noData.jpg' style='width:100%;'/></div>";
customDataCode += "<div class='div-textInnerImage'> 배정 제출할 강의가<br>없습니다.</div></div>";

let planNosForSubmit = [];
let dataListTbody = $("#dataListTbody");

let duplicated = false;
let assignListTbody = $("#assignListTbody");

let duplicateBtn = $("#duplicateBtn");
let submitBtn = $("#submitBtn");

function enrollTargetList() {
	$.ajax({
		url : "${cPath}/roomDetailSet/roomResultDataList.do",
		method : "get",
		dataType : "json",
		success : function(resp) {
			dataListTbody.empty();
			let planList = resp.targetList;
			let trTags = [];
			let count = 0;
			let assignChk = 0;
			if(planList && planList.length>0){
				$.each(planList, function(idx, plan){
					count++;
					var assignSts = plan.assignSts;
					if(assignSts == "미배정"){
						assignChk++;
					}
					let trTag = $("<tr>").attr("id", plan.planNo).addClass("tr-targetLine tr-targetHover").append(
							$("<td>").html(count)
							, $("<td>").html(plan.sjtMajor)
							, $("<td>").html(plan.userName).attr("data-user-no", plan.userNo)
							, $("<td>").html(plan.sjtName)
							, $("<td>").html(plan.planLimit)
							, $("<td>").html(plan.planTcnt)
							, $("<td>").html(plan.gwanName)
							, $("<td>").html(plan.roomNo)
							, $("<td>").html(plan.assignDt1)
							, $("<td>").html(plan.assignDt2)
							, $("<td>").html(assignSts)
					);
					trTags.push(trTag);
				});
			}else{
				let trTag = $("<tr>").append($("<td>").attr("colspan", "11").html(customDataCode));
				trTags.push(trTag);
			}
			if(assignChk == 0){
				duplicateBtn.attr("disabled", false);
			}
			dataListTbody.append(trTags);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR);
			console.log(textStatus);
			console.log(errorThrown);
		}
	});
};
enrollTargetList();

duplicateBtn.on("click", function(){
	alert("중복검사를 시작합니다.");
	let targetTrs = $(".tr-targetLine");
	let planNos = [];
	let planNosForDuple = [];
	var total = targetTrs.length;
	console.log("검사 타겟 >>>> "+total);
	
	$.each(targetTrs, function(idx, tr){
		let planNo = $(this).attr("id");
		planNosForDuple.push(planNo);
		let jsonEle = { "planNo" : planNo };
		planNosForSubmit.push(jsonEle);
		planNos.push(jsonEle);
	});
	
	let planNoList = { "planNoList" : JSON.stringify(planNos) };
	
	$.ajax({
		url : "${cPath}/roomDetailSet/assignDuplicationCheck.do",
		method : "get",
		data : planNoList,
		dataType : "json",
		success : function(resp) {
			let resultList = resp.dupleList;
			if(resultList && resultList.length > 0){
				var count = 0;
				
				$.each(resultList, function(idx, result){
					let unitDupleChk = false;
					let planNo = result.planNo;
					for(var i=0; i<planNosForDuple.length;i++){
						if(planNosForDuple[i]!=planNo){
							continue; //타겟번호와 학과강의들 번호가 일치하지 않으면 다음으로 넘어감
						}
						unitDupleChk = true;count++;//발견하면 중복 트루,중복카운트 증가 일치번호에 해당하는 중복내용칸을 빨간색으로 변경함
						$("#"+planNo).find("td:contains("+result.assignDt+")").css(
								{"background-color":"red", "color":"white", "font-weight":"bold"});
					}// 한 타겟번호에 대한 학과강의들 일치여부를 모두검사함 중복이거나 아니거나..
				});
				
				if(count==0){//중복검사 통과
					alert("중복검사를 통과했습니다.\n제출이 가능합니다.");
					console.log(planNosForDuple);
					duplicated = false;
				}else if(count%2==1){//타과와의 중복 발생
					alert("타과 배정과의 중복이 있습니다.");
					duplicated = true;
					$.each(resultList, function(idx, result){
						console.log("idx >>>> "+idx);
						let trTag = "";
						let planNo = result.planNo;
						if($("#"+planNo).attr("id")==planNo){
							total--;
						}else{
							trTag = $("<tr>").attr("id", planNo).addClass("tr-duplicatedLine").append(
									$("<td>").html(total+idx+1)
									, $("<td>").html(result.sjtMajor)
									, $("<td>").html(result.userName).attr("data-user-no", result.userNo)
									, $("<td>").html(result.sjtName)
									, $("<td>").html(result.planLimit)
									, $("<td>").html(result.planTcnt)
									, $("<td>").html(result.gwanName)
									, $("<td>").html(result.roomNo)
									, $("<td>").html(result.assignDt)
									, $("<td>").html("타과 중복").attr("colspan", "2")
							);
							dataListTbody.append(trTag);
						}
					});
				}else{//학과내에서만 중복 == 위에 포문 레드 마크업으로 해결됨
					alert("중복이 발생했습니다.");
					duplicated = true;
				}
			}else{
				alert("중복검사를 통과했습니다.\n제출이 가능합니다.");
				planNosForSubmit = planNosForDuple;
				console.log(planNosForDuple);
				duplicated = false;
			}
		submitBtn.attr("disabled", duplicated);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR);
			console.log(textStatus);
			console.log(errorThrown);
		}
	});
});


submitBtn.on("click", function(){
	if(confirm("한번 제출하시면 수정할 수 없습니다.\n제출하시겠습니까?")){
		let planNoList = { "planNoList" : JSON.stringify(planNosForSubmit)};
		console.log(planNoList);
		
		$.ajax({
			url : "${cPath}/roomDetailSet/assignSubmitProcess.do",
			method : "get",
			data : planNoList,
			dataType : "json",
			success : function(resp){
				alert("배정결과를 제출했습니다.");
				enrollTargetList();
			},
			error : function(jqXHR, textStatus, errorThrown) {
				console.log(jqXHR);
				console.log(textStatus);
				console.log(errorThrown);
			}
		});
	}
});

</script>



