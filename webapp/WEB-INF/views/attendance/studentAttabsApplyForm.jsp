<%--
 학생이 연도와학기를 선택하여 출석인정현황을 조회하고, 신청 가능한 페이지
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2022. 5. 2.      김재웅      최초작성
  2022. 5. 23.     주창규      jsp 용도 변경
* Copyright (c) 2022 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<h3 class="h3-title"> 출석인정 신청현황 조회 및 신청 </h3><hr class="hr-title">
<div>
	<select name="semsdataSelection" id="semsdataSelectionId">
		<option>학기 선택</option>
	</select>
</div>

<table class="table table-striped">
	<thead class="thead-dark">
		<tr>
			<th>NO</th>
			<th>학년</th>
			<th>학번</th>
			<th>강의번호</th>
			<th>강의명</th>
			<th>교수명</th>
			<th>결석사유</th>
			<th>결석일자</th>
			<th>신청일</th>
			<th>승인여부</th>
		</tr>
	</thead>
	<tbody id="listBody">
	</tbody>
	<tfoot>
		
	</tfoot>
</table>
<script>
let semsdataSelection = $("#semsdataSelectionId");
let listBody = $("#listBody");
//학기조회
function startAjax(){
	$.ajax({
		url :"${cPath}/applyAttabs/semsdataForm",
		method : "get",
		dataType : "json",
		success : function(resp) {
			semsdataSelection.empty();
			let semsdataList = resp.semsdata;
			let userNo = resp.userNo;
			let options = [];
			options.push($("<option>").attr("value","")
					.attr("selected", false)
					.text("학기 선택 ").css("color", "blue"));
			$(semsdataList).each(function(index,semsdata ){
				let option = $("<option>").attr("value",semsdata)
									      .attr("class",userNo)
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
	let userNo = $("#semsdataSelectionId option:selected").attr("class");
	alert(semsdata);
	alert(userNo);
	if(semsdata == "" || userNo == ""){
		alert("데이터가  존재하지 않습니다!");
	}else{
		attObjectionlist(semsdata,userNo); //년도 학기
	}
});

function attObjectionlist(semsdata,userNo){
	alert("여기");
	$.ajax({
		url :"${cPath}/applyAttabs/attabsApplyForm",
		method : "get",
		data : {semsdata:semsdata, userNo:userNo},
		dataType : "json",
		success : function(resp) {
			listBody.empty();
			let listBodyList = resp.studentAttendanceObjectionList;
			alert(listBodyList);
			let trTags = [];
			if(listBodyList && listBodyList.length > 0){
				$.each(listBodyList, function(idx,list){
					let trTag = $("<tr>").append(
							$("<td>").html(list.RNUM)
							,$("<td>").html(list.STU_YEAR)
							,$("<td>").html(list.LEC_SEMS)
							,$("<td>").html(list.USER_NO)
							,$("<td>").html(list.LEC_ID)
							,$("<td>").html(list.LEC_NAME)
							,$("<td>").html(list.PRO_NAME)
							,$("<td>").html(list.OJT_TITLE)
							,$("<td>").html(list.ATTABS_DATE)
							,$("<td>").html(list.OJT_DATE)
							,$("<td>").html(list.STATECODE)
					);
					trTags.push(trTag);
					});
				
				}else{
					let trTag = $("<tr>").append($("<td>").attr("colspan", "11").text("검색자료가없습니다"));
					trTags.push(trTag);
				}
			listBodyList.append(trTags);
				
			},
			error : function(jqXHR, textStatus, errorThrown) {
				alert("실패");
				console.log(jqXHR);
				console.log(textStatus);
				console.log(errorThrown);
			}
		});
	};
							
</script>						
							
							
							
							
							