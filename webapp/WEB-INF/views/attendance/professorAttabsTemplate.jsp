<%--
 교수의 출석부 조회 페이지
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
	#titleDiv {
	   margin: 10px;
	}
</style>
<style>
	#titleTable {
	    height: auto;
	}
	th {
 	  text-align: center; 
	  vertical-align : middle;
	}
	td {
 	  text-align: center; 
	  vertical-align : middle;
	}
</style>
<h3 class="h3-title">출석부</h3><hr class="hr-title">
<select name="semsdataSelection" id="semsdataSelectionId">
	<option>학기를 선택하세요</option>
</select>
<select name="lectureSelection" id="lectureSelectionId">
	<option>강의를 선택하세요</option>
</select>
<table class="table table-bordered" id = "titleTable">
	<thead class="thead-dark">
		<tr id ="titleTr">
			<th>학년</th>
			<th>학번</th>
			<th>이름</th>
			<th colspan="2">1주</th>
			<th colspan="2">2주</th>
			<th colspan="2">3주</th>
			<th colspan="2">4주</th>
			<th colspan="2">5주</th>
			<th colspan="2">6주</th>
			<th colspan="2">7주</th>
			<th colspan="2">8주</th>
			<th colspan="2">9주</th>
			<th colspan="2">10주</th>
			<th colspan="2">11주</th>
			<th colspan="2">12주</th>
			<th colspan="2">13주</th>
			<th colspan="2">14주</th>
			<th colspan="2">15주</th>
			<th colspan="2">16주</th>
		</tr>
	</thead>
	<tbody id =attBody>
		<tr><td colspan="34">
		<div class='div-imageWrap' id='imageWrap'>
			<div class='div-imageInnerWrap'>
				<img alt='' src='${cPath }/resources/img/noData.jpg' style='width:100%;'/></div>
			<div class='div-textInnerImage'> 학기와 강의를 <br>선택하세요.</div>
		</div>
		</td></tr>
	</tbody>
	<tfoot>
		<tr>
			<button type="submit" id="excelBtn" class="btn btn-primary btn-sm" onClick="alert('학기와 강의를 선택해주세요')"  style="float: right;">Excel</button>
		</tr>
	<c:if test="${not empty attendanceList}">
		<button type="submit" class="btn btn-primary btn-sm" onClick="location.href='${cPath}/templateAttabs/attExcel'"  style="float: right;">Excel</button>
	</c:if>
	</tfoot>
</table>
<div id="extraArea"></div>
<script>
let semsdataSelection = $("#semsdataSelectionId");
let lectureSelection = $("#lectureSelectionId");
let attBody = $("#attBody");
//년도와 학기를 조회
function startAjax(){
	$.ajax({
		url :"${pageContext.request.contextPath}/studentGrade/semsdataForm",
		method : "get",
		dataType : "json",
		success : function(resp) {
			semsdataSelection.empty();
			let semsdataList = resp.semsdata;
			
			let options = [];
			options.push($("<option>").attr("value","")
					.attr("selected", false)
					.text(" 학기 선택").css("color", "blue"));
			
			$(semsdataList).each(function(index,semsdata ){
				let option = $("<option>").attr("value",semsdata)
										  .text(semsdata.substr(0,4)+"년"+semsdata.substr(5,6)+"학기");
				options.push(option);
					});
			
			semsdataSelection.append(options);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR);
			console.log(textStatus);
			console.log(errorThrown);
		}
	});
};
startAjax();


semsdataSelection.on("change",function(){
	let semsdata = $(this).val();
	if(semsdata == ""){
		alert("데이터가  존재하지 않습니다!");
	}else{
		lecture(semsdata); //년도 학기
	}
});

function lecture(semsdata){
	$.ajax({
		url :"${pageContext.request.contextPath}/studentGrade/selectLecture",
		method : "get",
		data : {semsdata:semsdata},
		dataType : "json",
		success : function(resp) {
			lectureSelection.empty();
			let lectureList = resp.professorLecture;
			let options = [];
			options.push($("<option>").attr("value","")
					.attr("selected", false)
					.text("과목 선택").css("color", "blue"));
			$(lectureList).each(function(index, lecture ){
				let option = $("<option>").attr("value",lecture.PLAN_SEMS)
										  .attr("class",lecture.LEC_ID)
										  .text(lecture.LEC_NAME);
				options.push(option);
					});
			lectureSelection.append(options);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR);
			console.log(textStatus);
			console.log(errorThrown);
		}
	});
};

lectureSelection.on("change",function(){
	lecSems = $("#semsdataSelectionId option:selected").val();
	lecId = $("#lectureSelectionId option:selected").attr("class");
	if(lecSems =="" || lecId == ""){
		alert("데이터가  존재하지 않습니다!");
	}else{
		attendance(lecSems, lecId); 
	}
});

function attendance(lecSems, lecId){
	$.ajax({
		url :"${cPath}/templateAttabs/attendanceList",
		method : "get",
		data : {lecSems:lecSems, lecId:lecId},
		dataType : "json",
		success : function(resp) {
			attBody.empty();
			let attBodyList = resp.attendanceList;
			let trTags = [];
			let userNo = 0;
			if(attBodyList && attBodyList.length > 0){
			$('#excelBtn').attr('onclick',"location.href='${cPath}/templateAttabs/attExcel?lecSems="+lecSems+"&lecId="+lecId+"'");
				let trTag = $("<tr>");
				let num = 0;
				$.each(attBodyList, function(idx,att){
					let attabsDate = att.ATTABS_DATE;
					if(att.USER_NO != userNo){
						if(num>0){
							num = 36 - num;
						}
		 				for(let i = 1; i < num; i++ ){
		 					trTag.append($("<td>").html("-"));
		 				}						
						trTags.push(trTag);
						trTag = $("<tr>");
						trTag.append($("<td>").html(att.STU_YEAR)
							,$("<td>").html(att.USER_NO)
							,$("<td>").html(att.USER_NAME));
						num =3;
					}
						trTag.append(
							$("<td>").html(att.ATTABS_CODE )
								     .attr("value",att.ATTABS_DATE)
								     .attr("title",att.ATTABS_CODE +"일:"+ + attabsDate).attr("data-toggle", "popover").attr("data-bs-trigger", "hover focus")
								     
						);
						userNo = att.USER_NO;
						num++;
				});
			}else{
				$('#excelBtn').attr('onclick',"alert('검색자료가 없습니다.')");
				let trTag = $("<tr>").append($("<td>").attr("colspan", "11").text("검색자료가없습니다"));
				trTags.push(trTag);
				}
				attBody.append(trTags);
			},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR);
			console.log(textStatus);
			console.log(errorThrown);
		}
	});
};

// $(function(){
// 	attBody.find("[data-toggle='popover']").popover();
// });

</script>



















