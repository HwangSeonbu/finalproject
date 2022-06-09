<%--
	
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2022. 4. 29.      김재웅      최초작성
* Copyright (c) 2022 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h3 class="h3-title">학과 강의층 배분</h3><hr class="hr-title">

<style>
	select[name=collegeSelection]{
		width: 300px;
	}
	select[name=floorSelection]{
		width: 95%;
		margin: 10px;
	}
	.card-header{
		height: 80px;
		font-size: 20px;
	}
	#mainDepartBody{
		padding: 0px;
		width: 35%;
		float: left;
	}
 	#gwanBody{ 
 		width: 60%; 
		height:750px; 
/*   		border: 1px solid blue;   */
 		float: left;
 		margin-left: 15px;
 	} 
	.collegeClick{
		font-weight:bold;
	}
	.departClick:hover{
		cursor: pointer;
		font-weight:bold;
	}
	.detail {
/*  		border: 1px solid red;  */
	}
	#departmentBody{
	 	width: 95%;
	 	height:570px;
	 	margin-left: 10px;
	 	margin-top: 20px;
	}
	#roomCard{
		 overflow-y: scroll;
	}
	
	#gwanViewBody{
		width: 65%;
	 	height:300px;
	 	float: left;
	 	margin-bottom: 15px;
	}
	
	#buttonBody{
		text-align:center;
		width: 30%;
	 	height:200px;
	 	margin-top: 50px;
	 	margin-left: 15px;
		float: left;
	}
	#gwanDetailBody{
		width: 100%;
	 	height: 330px;
	 	clear: both;
	}
	input[type=text]{
		text-align:center;
		font-size:20px;
		width: 90%;
		height: 50px;
		margin-top: 15px;
	}
	#assignBtn{margin-top: 15px; margin-right: 20px;}
	#resetBtn{margin-top: 15px;}

	
	#assignContainer1{
		width: 35%;
		height:100%;
/*  		border: 1px solid blue;  */
		float: left;
	}
	#assignContainer2{
		width: 65%;
		height:100%;
/* 		border: 1px solid blue;  */
		float: left;
	}
	#gwanBodyInnerArea{
/*  		border: 1px solid red;  */
		height:95%;
		margin-top: 10px;
	}

</style>

<select name="collegeSelection" id="collegeSelectionId"
	class="form-select form-select-lg mb-3">
</select>


<div class="card border-info" style="max-width: 25rem;" id="mainDepartBody">
	<div class="card-header"><span class="collegeClick">학과목록</span></div>
	<div class="card-body" >
		<table class="table table-bordered table-hover">
		 <thead>
		    <tr class="text-center">
		    	<th>학과명</th>	
		    	<th>배정관</th>	
		    	<th>배정층</th>	
		    </tr>
		 </thead>
		 <tbody class="text-center" id="departBody">
		 	<tr><td colspan="3">분과대학을 선택해주세요.</td></tr>
		 </tbody>
		</table>
	</div>
</div>




<div class="card border-info" id="gwanBody">
	<div class="card-header"><span class="collegeClick" id="pickDepart">소속학과를 선택해주세요.</span></div>
	
	<div id="gwanBodyInnerArea">
		<div id="assignContainer1">
			<select name="floorSelection" id="floorSelectionId"
				class="form-select form-select-lg mb-3">
		 		<option>소속학과 필요</option>
		 	</select>
		 	<div class="detail card border-info" id="departmentBody">
				<div class="card-header">강의실현황</div>
				<div class="card-body" id="roomCard">
					<p>강의관 층을 선택해주세요.</p>
				</div>
			</div>
		</div>
		
		<div id="assignContainer2">
			<div class="detail card border-info" id="gwanViewBody">
				<div class="card-header">강의관 현황</div>
				<div class="card-body" id="gwanViewCard"></div>
			</div>
			<div class="detail" id="buttonBody">
				<form id="assignForm">
					<input type="text" name="deptName" readonly/>
					<input type="hidden" name="deptId" readonly />
					<input type="text" name="deptFlName" readonly />
					<input type="hidden" name="deptFl" readonly/>
					<input type="button" class="btn btn-primary" value="배분" id="assignBtn"/>
					<input type="reset" class="btn btn-secondary" value="취소" id="resetBtn"/>
				</form>
			</div>
			<div class="detail card border-info" id="gwanDetailBody">
				<div class="card-header">강의관 세부정보</div>
				<div class="card-body" id="gwanDetailCard"></div>
			</div>
		</div>
	</div>
</div>



<script>
let collegeSelection = $("#collegeSelectionId");
let floorSelection = $("#floorSelectionId");

let inputdeptName = $("input[name=deptName]");
let inputdeptFlName = $("input[name=deptFlName]");
let inputdeptFl = $("input[name=deptFl]");
let inputdeptId = $("input[name=deptId]");

function collegeAjax(){
	$.ajax({
		url : "${pageContext.request.contextPath}/roomSet/collegeDataForm.do",
		method : "get",
		dataType : "json",
		success : function(resp) {
			collegeSelection.empty();
			let collegeList = resp.collegeList;
			
			let options = [];
			options.push($("<option>").attr("value", "")
						.attr("selected", false)
						.text("분과대학 선택").css("color", "blue"));
			
			$(collegeList).each(function(index, college){
				let option = $("<option>").attr("value", college.colName)
										  .text(college.colName);
				options.push(option);
			});
			
			collegeSelection.append(options);
// 			$(prodLguTag).val("${paging.detailCondition.prodLgu}");
// 			$(prodLguTag).trigger("change");			
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR);
			console.log(textStatus);
			console.log(errorThrown);
		}
	});
};
collegeAjax();

let departBody = $("#departBody");

let colName = "";
collegeSelection.on("change", function(){
	colName = $(this).val();
	$("#resetBtn").trigger("click");
	
	if(colName == ""){
		let trTag = "<tr><td colspan='3'>분과대학을 선택해주세요.</td></tr>";
		departBody.empty();
		departBody.append(trTag);
	}else{
		departAjax(colName);
	}
	$('#pickDepart').load(location.href+' #pickDepart');
// 	$('#floorSelectionId').load(location.href+' #floorSelectionId');
	floorSelection.empty();
	floorSelection.append($("<option>").text("소속학과 필요"));
	$("#roomCard").empty();
	$("#roomCard").append($("<p>").text("강의관 층을 선택해주세요."));
});

function departAjax(colName){
	$.ajax({
		url : "${pageContext.request.contextPath}/roomSet/collegeDepartDataList.do",
		method : "get",
		data : {colName:colName},
		dataType : "json",
		success : function(resp) {
			departBody.empty();
			let departList = resp.departList;
			
			let trTags = [];
			if(departList && departList.length > 0){
				let flag = false;
				$.each(departList, function(idx, depart){
					let colGwan = depart.colGwan;
					let deptFlFix = depart.deptFl;
					if(deptFlFix == null) deptFlFix = "미정";
					if(colGwan == '미정'){
						flag = true;
						let trTag = $("<tr>").addClass("departBlock")
											 .append(
											 	 $("<td>").html(depart.deptName)	
											 	 , $("<td>").html(depart.colGwan)	
												 , $("<td>").html(deptFlFix)	
											 );
						trTags.push(trTag);
					}else{
						let trTag = $("<tr>").addClass("departClick")
											.data("dept-id", depart.deptId)
											.data("col-name", depart.colName)
											.data("gwan-sfl", depart.gwanSfl)
											.data("gwan-efl", depart.gwanEfl)
											.data("dept-name", depart.deptName)
											.data("col-gwan", depart.colGwan)
											.data("dept-fl-fix", deptFlFix)
											.append(
												$("<td>").html(depart.deptName)	
												, $("<td>").html(depart.colGwan)	
												, $("<td>").html(deptFlFix)	
											);
						trTags.push(trTag);
					}
				});
				if(flag){
					let blockCode = $("<span>").text("강의관 배분이 필요합니다.")
					  .css("color","red");
					let trTag = $("<tr>").append(
						 					$("<td>").html(blockCode)
						 		  					 .attr("colspan", "3")
								);
					departBody.append(trTag);
				}
			}else{
				let trTag = $("<tr>").html(
								$("<td>").attr("colspan", "3")
										 .html("소속학과가 없습니다.")
							);
				trTags.push(trTag);
			} // if end
			departBody.append(trTags);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR);
			console.log(textStatus);
			console.log(errorThrown);
		}
	});
};

let pickDepart = $("#pickDepart");
$("#departBody").on("click", ".departClick", function(){
	let deptName = $(this).data("deptName");
	let deptId = $(this).data("deptId");
	let colName = $(this).data("colName");
	let gwanSfl = $(this).data("gwanSfl");
	let gwanEfl = $(this).data("gwanEfl");
	let deptFlFix = $(this).data("deptFlFix");
	let colGwan = $(this).data("colGwan");
	
	inputdeptName.val(deptName);
	inputdeptId.val(deptId);
	inputdeptFl.val("");
	
	let code = "";
	pickDepart.empty();
	code += colName;
	code += "   ";
	code += deptName;
	code += "<span style='font-size:15px;'>  ";
	code += colGwan+",  ";
	code += "현재 배정 층 : [ ";
	code += deptFlFix;
	code += " ]</span>";
	pickDepart.html(code);
	pickDepart.data("gwan-name", colGwan);
	
	$("#roomCard").empty();
	$("#roomCard").append($("<p>").text("강의관 층을 선택해주세요."));
	
	$.ajax({
		url : "${pageContext.request.contextPath}/roomSetSub/gwanFloorList.do",
		method : "get",
		data : {gwanName:colGwan
				, gwanSfl:gwanSfl
				, gwanEfl:gwanEfl},
		dataType : "json",
		success : function(resp) {
			floorSelection.empty();
			let gwanVo = resp.gwanVo;
			let floorList = gwanVo.floorList;
			
			let options = [];
			options.push($("<option>").attr("value", "")
						.text("강의관 층 선택").css("color", "blue"));
			options.push($("<option>").attr("value", "0")
					.text("초기화").css("color", "red"));
			$(floorList).each(function(index, level){
				let option = $("<option>").attr("value", level)
										  .text(level+"층");
				options.push(option);
			});
			
			floorSelection.append(options);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR);
			console.log(textStatus);
			console.log(errorThrown);
		}
	});
});

let roomCard = $("#roomCard");

floorSelection.on("change", function(){
	let gwanName = pickDepart.data("gwanName");
	let pickFl = $(this).val();
	inputdeptFl.val(pickFl);
	inputdeptFlName.val(pickFl+"층");
	
	$.ajax({
		url : "${pageContext.request.contextPath}/roomSetSub/floorRoomList.do",
		method : "get",
		data : {gwanName:gwanName
				, pickFl:pickFl},
		dataType : "json",
		success : function(resp) {
			roomCard.empty();
			let roomList = resp.roomList;
			
			let pTags = [];
			if(roomList && roomList.length > 0){
				$.each(roomList, function(idx, room){
					let pTag = $("<p>").append($("<span>").text(room.roomNo+"호")
														  .addClass("roomClick")
														  .attr("id", room.roomNO)
														  .data("room-use", room.roomUse));
					pTag.append($("<span>").text("  [정원"+room.roomLimit+"]"));
					pTags.push(pTag);
				});
			}else{
			} // if end
			roomCard.append(pTags);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR);
			console.log(textStatus);
			console.log(errorThrown);
		}
	});
});


$("#assignBtn").on("click", function(event){
	
	let deptName = inputdeptName.val().trim();
	let deptFl = inputdeptFl.val().trim();
	let deptId = inputdeptId.val().trim();
	
	if(deptName=="") 
		alert("소속학과를 선택하세요.");
	
	if(deptFl=="")
		alert("강의관 층을 선택하세요");
	
	if(deptName!="" && deptFl!=""){
		if(confirm(deptId+"/"+deptFl)){
			$.ajax({
				url : "${pageContext.request.contextPath}/roomSet/departFloorSet.do",
				method : "get",
				data : {deptId:deptId,
						deptFl:deptFl},
				dataType : "json",
				success : function(resp) {
					alert(resp.result);
					collegeAjax();
					collegeSelection.val(colName).trigger("change");
				},
				error : function(jqXHR, textStatus, errorThrown) {
					console.log(jqXHR);
					console.log(textStatus);
					console.log(errorThrown);
				}
			});
		};
	};
});
</script>