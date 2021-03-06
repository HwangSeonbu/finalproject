<%--
 학사관리자가 현재 등록금 납부 현황을 조회하는 페이지
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2022. 5. 2.   김재웅	      최초작성
* 2022. 5. 25.	고성식	   기본 ui 작성
* Copyright (c) 2022 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<script type="text/javascript" src="${cPath }/resources/js/jquery.form.min.js"></script>    
<h3 class="h3-title">등록금납부현황조회</h3><hr class="hr-title">
<style>
th{
	border-bottom: 1px solid #444444;
	text-align:center;
}

#action_in{
	text-align: right;
}

.pagination{
		justify-content: center;
}
</style>
	<div class="action_in">
		<select id="enrSems">
			<c:forEach items="${semsdata}" var="list">
				<option value="${list}">${list}</option>
			</c:forEach>
		</select>
		<button type="submit" class="btn btn-primary btn-sm" onclick="confirmCreditEnrollStudent();">등록금납부확인</button>
	</div>
	<br>
<table class="table table-hover table-sm" >
	<thead>
		<tr>
			<th scope="col" class="frst">
			<input type="checkbox" id="chkalltop" title="선택" class="check _click"></th>
			<th>학번</th>
			<th>이름</th>
			<th>분과대학</th>
			<th>학과</th>
			<th>학년</th>
			<th>학반</th>
			<th>등록금액 (원)</th>
			<th>장학금액 (원)</th>
			<th>실납부금액 (원)</th>
			<th>휴대폰</th>
			<th>이메일</th>
			<th>납부여부</th>
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
let token = $("meta[name='_csrf']").attr("content");
let header = $("meta[name='_csrf_header']").attr("content");
let listBody = $("#listBody");
var nextSems = ${sessionScope.semsVo.nextSems};
let page = "1";

//이벤트 Function
let eventFunction = function(){
	
	// 체크박스 전체선택 이벤트
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
	$("#enrSems").on("change", function(){
		selectList(1);
	});
};

function selectList(page){
	var param = {
		page : 	page,
		enrSems : $("#enrSems").val()
	}
	$.ajax({
		url : "${cPath}/adminEnroll/setFinalCreditEnrollList.do",
		method : "post",
		data : param,
		dataType : "json",
		beforeSend : function(xhr) {
			if (token && header) {
				xhr.setRequestHeader(header, token);
			}
		},
		success : function(data) {
			$("#listBody").empty();
			
			let enrollList = data.list;
			let trTags = [];
			if(enrollList && enrollList.length > 0){
				$.each(enrollList, function(idx, enroll){
					var visibility = enroll.enrYn == 'N101' ? "visibile": "hidden"
					let trTag = $("<tr>").attr("id", enroll.userNo)
										.append(
													$("<td>").append($("<input>")
															.attr("type", "checkbox").attr("name", "chk")
															.attr("class","${enroll.userNo}").css("visibility", visibility)
													)
													, $("<td>").html(enroll.userNo).attr("style","text-align:center;")
													, $("<td>").html(enroll.userName).attr("style","text-align:center;")
													, $("<td>").html(enroll.colName).attr("style","text-align:center;")	
													, $("<td>").html(enroll.deptName).attr("style","text-align:center;")	
													, $("<td>").html(enroll.stuYear).attr("style","text-align:center;")
													, $("<td>").html(enroll.stuClass).attr("style","text-align:center;")
													, $("<td>").html(enroll.deptEnr).attr("style","text-align:center;")
													, $("<td>").html(enroll.schAmount).attr("style","text-align:right;")
													, $("<td>").html(enroll.enrResult).attr("style","text-align:right;")
													, $("<td>").html(enroll.userPhone).attr("style","text-align:center;")
													, $("<td>").html(enroll.userMail).attr("style","text-align:center;")
													, $("<td>").html(enroll.stsCode1).attr("style","text-align:center;")
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

function confirmCreditEnrollStudent(){
	let enrNos = []
	let enrNoList = {};
	let names = listBody.find('input[name="chk"]:checked');
	
	if(names.length == 0){
		alert("등록금납부 확인 학생을 선택해주세요");
		return false;
	}
	
	$.each(names, function(idx, name){
		let thisName = $(this).parents("tr").attr("id");
		let thisEnr = $(this).parents('tr').children().eq(9).text();
		let jsonEle = {
			"userNo" : thisName
			,"enrPay" : thisEnr
			,"enrSems" : $("#enrSems").val()
		};
		
		enrNos.push(jsonEle);
	});
	
	// 등록금 부과 처리
	$.ajax({
		url : "${cPath}/adminEnroll/adminAppointFinalEnroll.do",
		method : "post",
		data : JSON.stringify(enrNos),
		contentType : "application/json",
		dataType : "json",
		beforeSend : function(xhr) {
			if (token && header) {
				xhr.setRequestHeader(header, token);
			}
		},
		success : function(resp) {
			alert(enrNos.length+"명에게 등록금부과 완료");
			selectList(1);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR);
			console.log(textStatus);
			console.log(errorThrown);
		}
	});  
	
}

$(function(){
	eventFunction();
	$("#enrSems").val(nextSems);
	selectList(1);
});

</script>