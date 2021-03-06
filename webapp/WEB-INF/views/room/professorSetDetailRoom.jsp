<%--
 학과장 교수가 세부 강의실을 배정하는 페이지
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2022. 5. 2.      김재웅      최초작성
* Copyright (c) 2022 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<h3 class="h3-title">강의실 배정 처리</h3><hr class="hr-title">
<style>
	#mainTbl{
		text-align:center;
		font-size:20px;
		width:80%;
		min-height: 60px;
	}
	#mainTbl th{
		background-color: orange;
	}
	#floorSelect{
		margin-top:15px;
		margin-left:15px;
		width: 250px;
	}
	#leftArea{padding: 0px;width: 40%;
		float: left;
	}
	.card-header{
		height: 80px;
		font-size: 20px;
	}
 	#departLecBody:hover{ 
 		cursor: pointer; 
 	} 
	#rightArea{ 
 		width: 55%; 
		height:750px; 
 		float: left;
 		margin-left: 15px;
 	} 
	#pickPlan{ 
 		width: 80%; 
 		float: left;
 	} 
	#buttonBody{
		text-align:center;
		padding-top:20px;
		width: 20%; 
		height: 80px;
		float: left;
	}
	#pickTbl{
		height: 100%; 
	} 
	#rightInnerArea{
		height:100%;
	}
	#assignBtn{margin-right: 10px;}
	#roomArea{ 
		margin: 10px;
 		width: 30%; 
 		height:640px;
 		float: left;
 	} 
	#roomListBody{
 		overflow-y: scroll;  
	}
	#roomTimeTableBody{ 
		margin-top: 10px;
		padding-top: 10px;
 		width: 67%; 
 		height: 640px; 
 		float: left;
 		overflow-y: scroll; 
 	} 
	.roomClick:hover{ 
 		cursor: pointer; 
 		background-color: #D7CCC8; 
 	} 
 	#timeTable{width: 100%; height: 97%; vertical-align: middle;} 
	
	#extraArea{
		clear: both;
	}
 	#label{padding:0;} 
 	.time-lecSelect:hover{ 
 		cursor: pointer; 
 		background-color: #D7CCC8; 
 	} 

	.div-imgWrap{position: relative; width: 100%; margin: 10px auto;}
	.div-img{width: 100%; vertical-align: middle;}
	.div-imgText{
		position: absolute;
		top: 50%;
		left: 50%;
		width: 100%;
		transform: translate(-50%, -50%);
		font-size: 40px;
		text-align: center; font-weight: bold;
	}
</style>

<table class="table table-bordered" id="mainTbl"></table>

<div class="card border-info" id="leftArea">
	<div class="card-header">학과목록</div>
	<div class="card-body" >
		<table class="table table-hover">
			<thead>
				<tr>
					<th>교수</th>
					<th>강의명</th>
					<th>정원</th>
					<th>시수</th>
					<th>강의실</th>
					<th colspan="2">강의시간</th>
				</tr>
			</thead>
			<tbody id="departLecBody">
			</tbody>
		</table>
	</div>
</div>

<div class="card border-info" id="rightArea">
	<div class="blueLine" id="rightInnerArea">
		<div class="card-header redLine" id="pickPlan">
			<table class="table" id="pickTbl">
				<tr><th >배정할 강의를 선택해주세요.</th></tr>
			</table>
		</div>
		<div class="redLine" id="buttonBody">
			<form id="assignForm">
				<input type="button" class="btn btn-primary" value="배정" id="assignBtn"/>
				<input type="reset" class="btn btn-secondary" value="초기화" id="resetBtn"/>
			</form>
		</div>
		<div class="detail card border-info" id="roomArea">
				<div class="card-header">강의실 목록</div>
				<div class="card-body" id="roomListBody"></div>
		</div>
		<div class="blueLine" id="roomTimeTableBody">
			<div class="div-imgWrap" id="holdImage">
				<div class="div-img">
					<img alt="" src="${cPath }/resources/img/lecRoom.jpg" style="width:100%;opacity:0.4;"/>
				</div>
				<div class="div-imgText"> 배정하실 강의와 강의실을<br>선택해주세요.</div>
			</div>
			<table class="table table-bordered table-sm" id="timeTable">
				 <thead >
				    <tr class="text-center">
				     <th scope="col" style="width:150px">시간</th>
				     <th scope="col" style="width:300px">월</th>
				     <th scope="col" style="width:300px">화</th>
				     <th scope="col" style="width:300px">수</th>
				     <th scope="col" style="width:300px">목</th>
				     <th scope="col" style="width:300px">금</th>
				   </tr>
				 </thead>
				 <tbody class="text-center">
				   <tr style="height:16%;">
				     <th scope="row">1</th>
				 	<td class="time" id="월1"></td>
				 	<td class="time" id="화1"></td>
				 	<td class="time" id="수1"></td>
				 	<td class="time" id="목1"></td>
				 	<td class="time" id="금1"></td>
				   </tr>
				   <tr style="height:16%;">
				     <th scope="row">2</th>
				 	<td class="time" id="월2"></td>
				 	<td class="time" id="화2"></td>
				 	<td class="time" id="수2"></td>
				 	<td class="time" id="목2"></td>
				 	<td class="time" id="금2"></td>
				   </tr>
				   <tr style="height:16%;">
				     <th scope="row">3</th>
				 	<td class="time" id="월3"></td>
				 	<td class="time" id="화3"></td>
				 	<td class="time" id="수3"></td>
				 	<td class="time" id="목3"></td>
				 	<td class="time" id="금3"></td>
				   </tr>
				   <tr style="height:16%;">
				     <th scope="row">4</th>
				 	<td class="time" id="월4"></td>
				 	<td class="time" id="화4"></td>
				 	<td class="time" id="수4"></td>
				 	<td class="time" id="목4"></td>
				 	<td class="time" id="금4"></td>
				   </tr>
				   <tr style="height:16%;">
				     <th scope="row">5</th>
				 	<td class="time" id="월5"></td>
				 	<td class="time" id="화5"></td>
				 	<td class="time" id="수5"></td>
				 	<td class="time" id="목5"></td>
				 	<td class="time" id="금5"></td>
				   </tr>
				   <tr style="height:16%;">
				     <th scope="row">6</th>
				 	<td class="time" id="월6"></td>
				 	<td class="time" id="화6"></td>
				 	<td class="time" id="수6"></td>
				 	<td class="time" id="목6"></td>
				 	<td class="time" id="금6"></td>
				   </tr>
				 </tbody>
			</table>
		</div>
		
	</div>
</div>
<div class="redLine" id="extraArea">
	<input type="hidden" name="sPlanNo" readonly/>
	<input type="hidden" name="sAssignNo1" readonly />
	<input type="hidden" name="sAssignNo2" readonly/>
	<input type="hidden" name="sAssignDt1" readonly/>
	<input type="hidden" name="sAssignDt2" readonly/>
	<input type="hidden" name="sRoomNo" readonly/>
	<input type="hidden" name="sGwanName" readonly/>
</div>

<script>
let holdImage = $("#holdImage");

let departLecBody = $("#departLecBody");
let roomListBody = $("#roomListBody");
let mainTbl = $("#mainTbl");
let timeTable = $("#timeTable");
let gwanName = "";
let pickRoom = "";
let pickTcnt = "";

let sPlanNo = $("#extraArea").find("[name='sPlanNo']");
let sAssignNo1 = $("#extraArea").find("[name='sAssignNo1']");
let sAssignNo2 = $("#extraArea").find("[name='sAssignNo2']");
let sAssignDt1 = $("#extraArea").find("[name='sAssignDt1']");
let sAssignDt2 = $("#extraArea").find("[name='sAssignDt2']");
let sRoomNo = $("#extraArea").find("[name='sRoomNo']");
let sGwanName = $("#extraArea").find("[name='sGwanName']");

let timeClass = $(".time");

timeTable.hide();

$.ajax({
	url : "${cPath}/roomDetailSet/departData.do",
	method : "get",
	dataType : "json",
	success : function(resp) {
		mainTbl.empty();
		let depart = resp.department;
		gwanName = depart.colGwan;
		let trTag = "";
		if(gwanName != null){
			let gwan = depart.gwanVo;
			let deptFl = depart.deptFl;
			let sFl = gwan.gwanSfl;
			let eFl = gwan.gwanEfl;
			let code = "";
			if(deptFl == null){
				code += "<select id='floorSelect' class='form-select form-select-lg mb-3'><option>선택</option>";
				for(var i = sFl; i <= eFl; i++){
					code += "<option value='";
					code += i+"'>"+i+"층</option>";
				}
				code += "</select>";
			}else{
				code += "<select class='fixFloor form-select form-select-lg mb-3' id='floorSelect'><option value='";
				code += deptFl+"' disabled selected>"+deptFl+"층</option>";
				floorRoomDataList(deptFl);
			}
			trTag = $("<tr>").append(
									$("<th>").text("소속")	
									, $("<td>").html(depart.colName+" "+depart.deptName)	
									, $("<th>").text("강의관")	
									, $("<td>").html(gwanName)	
									, $("<th>").html("배분층")
									, $("<td>").attr("id", "floorTd").html(code)
								);
		}else{
			trTag = $("<tr>").append(
					$("<th>").text("소속")	
					, $("<td>").html(depart.colName+" "+depart.deptName)	
					, $("<td>").text("강의관이 배분되지 않아 강의실 배정이 불가합니다.").attr("colspan", "4")	
				);
		}
		mainTbl.append(trTag);
		sGwanName.val(gwanName);	//submit
	},
	error : function(jqXHR, textStatus, errorThrown) {
		console.log(jqXHR);
		console.log(textStatus);
		console.log(errorThrown);
	}
});


function floorRoomDataList(pickFl) { 
	$.ajax({
		url : "${pageContext.request.contextPath}/roomSetSub/floorRoomList.do",
		method : "get",
		data : {gwanName:gwanName
				, pickFl:pickFl},
		dataType : "json",
		success : function(resp) {
			roomListBody.empty();
			let roomList = resp.roomList;
			
			let pTags = [];
			if(roomList && roomList.length > 0){
				$.each(roomList, function(idx, room){
					let pTag = $("<p>").attr("id", room.roomNo).addClass("roomClick")
										.append($("<span>").text(room.roomNo+"호")
														  .data("room-use", room.roomUse));
					pTag.append($("<span>").text("  [정원"+room.roomLimit+"]"));
					pTags.push(pTag);
				});
			}else{
			} // if end
			roomListBody.append(pTags);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR);
			console.log(textStatus);
			console.log(errorThrown);
		}
	});
};

function departLecList() { 
	$.ajax({
		url : "${cPath}/roomDetailSet/departLectureDataList.do",
		method : "get",
		dataType : "json",
		success : function(resp) {
			departLecBody.empty();
			let departLecList = resp.departLecList;
			let trTags = [];
			if(departLecList && departLecList.length > 0){
				$.each(departLecList, function(idx, departLec){
					let code = "";
					let planNo = departLec.planNo
					let planTcnt = departLec.planTcnt;
					let assignList = departLec.assignList;
					let trTag = $("<tr>").addClass("departLecClick")
										.data("plan-no", planNo)
										.data("user-name", departLec.userName)
										.data("sjt-name", departLec.sjtName)
										.data("assign-no", departLec.assignNo)
										.data("plan-tcnt", planTcnt)
										.append(
											$("<td>").html(departLec.userName)	
											, $("<td>").html(departLec.sjtName)	
											, $("<td>").html(departLec.planLimit)	
											, $("<td>").html(planTcnt)	
											, $("<td>").html(departLec.roomNoStr).attr("id","td_"+planNo)	
										);
					if(planTcnt == 2){
						for(var i = 0; i < assignList.length; i++){
							let inputName = planNo+"_";
							let assignDt = assignList[i].assignDt;
							inputName += (i+1);
							code += "<td><input class='assignDtDefault' type='text' name='";
							code += inputName;
							code += "' style='width:50px;' readonly value='";
							code += assignDt;
							code += "'/></td>";
							
// 							$("#"+assignDt).css("background-color", "yellow").text(departLec.sjtName);
						}
					}else{
						let inputName = planNo+"_";
						let assignDt = assignList[0].assignDt;
						inputName += 1;
						code += "<td colspan='2'><input class='assignDtDefault' style='width:130px;' name='";
						code += inputName;
						code += "' type='text' readonly value='";
						code += assignDt;
						code += "'/></td>"
// 						$("#"+assignDt).css("background-color", "yellow").text(departLec.sjtName);
					}
					trTag.append(code);
					
					trTags.push(trTag);
				});
			}else{
				let trTag = $("<tr>").html(
								$("<td>").attr("colspan", "7")
										 .html("소속학과가 없습니다.")
							);
				trTags.push(trTag);
			} // if end
			departLecBody.append(trTags);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR);
			console.log(textStatus);
			console.log(errorThrown);
		}
	});
// 	colorDispatcher();
};

let pickTbl = $("#pickTbl");

$("#departLecBody").on("click", ".departLecClick", function(){
	let assignNo = $(this).data("assignNo");
	
	let userName = $(this).data("userName");
	let sjtName = $(this).data("sjtName");
	pickTcnt = $(this).data("planTcnt");
	let planNo = $(this).data("planNo");
	let pickCode = "";
	pickCode += "<tr><th id='pickTh' data-plan-no='";
	pickCode += planNo;
	pickCode += "' data-sjt-name='";
	pickCode += sjtName;
	pickCode += "'>선택</th><td>";
	pickCode += userName+", "+sjtName;
	pickCode += "</td>";
	pickCode += "<td>";
	if(pickTcnt == 2){
		pickCode += "<label><input type='radio' name='tcnt' value='1' checked/>1시수</label>";
		pickCode += "<label><input type='radio' name='tcnt' value='2'/>2시수</label></td></tr>";
	}else{
		pickCode += "<label><input type='radio' name='tcnt' value='1' checked/>1시수</label></td>";
	}
	
	pickTbl.html(pickCode);
	
	sAssignDt1.val("");
	sAssignDt2.val("");
	sRoomNo.val("");
	
	sPlanNo.val(planNo);	//submit
	sAssignNo1.val(assignNo);	//submit
	sAssignNo2.val(Number(assignNo)+1);	//submit
	timeClass.addClass("time-lecSelect");
	timeTable.hide();
	holdImage.css("display", "block");
	$(".roomClick").css("background-color", "");
});

$("#timeTable").on("click", ".time-lecSelect", function(){
	let pickTime = $(this).attr("id");
	let currTcnt = $("input[name=tcnt]:checked").val();
	
	let pickPlanNo = $("#pickTh").data("planNo");
	
	let pickSjt = $("#pickTh").data("sjtName");
	let pickPlan = pickPlanNo+"_"+currTcnt;
	
 	let targetInput = departLecBody.find("[name="+pickPlan+"]");
 	
 	let targetTd = departLecBody.find("#td_"+pickPlanNo);
 	let beforeTime = targetInput.val();
 	$("#"+beforeTime).css("background-color", "").text("");
 	$("#"+beforeTime).addClass("time-lecSelect");
 	targetInput.val(pickTime);
 	
 	targetTd.text(pickRoom);
 	
 	if(currTcnt == 1){
 		sAssignDt1.val(pickTime);	//submit
 	}else{
 		sAssignDt2.val(pickTime);	//submit
 	}
 	
 	$(this).css("background-color", "skyblue").text(pickSjt);
});

$("#resetBtn").on("click", function(pickRoom){
	departLecList();
	timeTable.hide();
	holdImage.css("display", "block");
	sAssignDt1.val("");
	sAssignDt2.val("");
	sRoomNo.val("");
});

$("#assignBtn").on("click", function(){
	let planNo = sPlanNo.val();
	let assignNo1 = sAssignNo1.val();
	let assignNo2 = sAssignNo2.val();
	let assignDt1 = sAssignDt1.val();
	let assignDt2 = sAssignDt2.val();
	let roomNo = sRoomNo.val();
	let gwanName = sGwanName.val();
	
	if(planNo == ""){
		alert("강의를 선택해주세요.");
		return false;
	}
	if(assignNo1 == "" || assignNo2== ""){
		alert("강의를 선택해주세요.");
		return false;
	}
	if(assignDt1 == ""){
		alert("1시수를 배정해주세요.");
		return false;
	}
	if(pickTcnt == 2 && assignDt2 == ""){
		alert("2시수를 배정해주세요.");
		return false;
	}
	if(roomNo == ""){
		alert("강의실을 선택해주세요.");
		return false;
	}
	if(gwanName == ""){
		alert("강의관을 선택해주세요.");
		return false;
	}
	
	$.ajax({
		url : "${cPath}/roomDetailSet/departRoomSet.do",
		method : "get",
		data : {planNo:planNo,assignNo1:assignNo1,assignNo2:assignNo2
			,assignDt1:assignDt1,assignDt2:assignDt2,roomNo:roomNo
			,gwanName:gwanName,pickTcnt:pickTcnt},
		dataType : "json",
		success : function(resp) {
			alert("배정되었습니다.");
			departLecList();
			timeTable.hide();
			holdImage.css("display", "block");
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR);
			console.log(textStatus);
			console.log(errorThrown);
		}
	});
});



function roomTimeTable(pickRoom){
	timeClass.addClass("time-lecSelect");
	
	$.ajax({
		url : "${cPath}/roomSetSub/roomTimeTable.do",
		method : "get",
		data : {roomNo:pickRoom
			, gwanName:gwanName},
		dataType : "json",
		success : function(resp) {
			let roomAssignList = resp.roomAssignList;
			if(roomAssignList && roomAssignList.length > 0){
				$.each(roomAssignList, function(idx, roomAssign){
 					$("#"+roomAssign.assignDt).css("background-color", "yellow")
 											  .html("<span>"+roomAssign.lecName+"</span><br><span>"+roomAssign.proName+"</span>")
 											  .removeClass("time-lecSelect");
				});
			}else{}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR);
			console.log(textStatus);
			console.log(errorThrown);
		}
	});
};




</script>
<script>
$(document).ready(function(){
	departLecList();
	
	mainTbl.on("change", "#floorSelect", function(){
		let pickFl = $(this).val();
		if(pickFl == "선택"){
			timeTable.hide();
			holdImage.css("display", "block");
			roomListBody.empty();
		}else{
			timeTable.hide();
			holdImage.css("display", "block");
			floorRoomDataList(pickFl);
		}
	});
	
	mainTbl.on("click", ".fixFloor", function(){
		alert("층이 배분되어 선택할 수 없습니다.");
	});
	
	roomListBody.on("click", ".roomClick", function(){
		$(".roomClick").css("background-color", "");
		pickRoom = $(this).attr("id");
		sRoomNo.val(pickRoom);	//submit
		$(this).css("background-color", "#D7CCC8");
		$(".time").css("background-color", "").text("");
		roomTimeTable(pickRoom);
		timeTable.show();
		holdImage.css("display", "none");
	});
});

</script>


