<%--
* 관리자가 장학생현황을 조회하는 페이지
* [[개정이력(Modification Information)]]
* 수정일                 		수정자     			 수정내용
* ----------  	  ---------  	-----------------
* 2022. 5. 13.		고성식     		 	최초작성
* Copyright (c) 2022 by DDIT All right reserved
 --%>
<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<script type="text/javascript" src="${cPath }/resources/js/jquery.form.min.js"></script>
<style>
#processBtnBody{
		text-align: right;
}

.pagination{
	justify-content: center;
}
</style>

<h3 class="h3-title">장학생현황조회</h3><hr class="hr-title">
<div>
	<strong>학기선택</strong>
	<select id="semsNo">
		<c:forEach items="${semsdata}" var="list">
			<option value="${list}">${list}</option>
		</c:forEach>
	</select>
</div>
<hr>
<table class="table table-sm">
	<thead class="thead-dark">
		<tr>
			<th>학번</th>
			<th>이름</th>
			<th>분과대학</th>
			<th>학과</th>
			<th>장학분류</th>
			<th>승인날짜</th>
			<th>학년</th>
			<th>반</th>
			<th>전화번호</th>
			<th>이메일</th>
		</tr>
	</thead>
	<tbody id="listBody">
	</tbody>
	<tfoot>
		<tr>
			<td colspan="10">
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
var thisSems = ${sessionScope.semsVo.thisSems};
let page = "1";

//이벤트 Function
let eventFunction = function(){
	
	// 페이징 클릭 이벤트
	$("#pagingArea").on("click", "a", function(){
		page = $(this).data("page");
		selectList(page);
	});
	
	// 수강학기 변경 이벤트
	$("#semsNo").on("change", function(){
		selectList(1);
	});
};

// 리스트 조회
function selectList(page){
	var param = {
		page : 	page,
		semsNo : $("#semsNo").val()
	}
	$.ajax({
		url : "${cPath}/scholar/totalScholarStudentList.do",
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
			
			let scholarshipList = data.list;
			let trTags = [];
			if(scholarshipList && scholarshipList.length > 0){
				$.each(scholarshipList, function(idx, scholarship){
					let trTag = $("<tr>").attr("id", scholarship.userNo)
										.append(
													 $("<td>").html(scholarship.userNo)
													, $("<td>").html(scholarship.userName)
													, $("<td>").html(scholarship.colName)
													, $("<td>").html(scholarship.deptName)	
													, $("<td>").html(scholarship.stsCode1)
													, $("<td>").html(scholarship.reqDate)
													, $("<td>").html(scholarship.stuYear) 
													, $("<td>").html(scholarship.stuClass)
													, $("<td>").html(scholarship.userPhone)
													, $("<td>").html(scholarship.userMail)
										);
					trTags.push(trTag);
				});
			}else{
				let trTag = $("<tr>").html($("<td>").attr("colspan", "10").html(overNoDataCode));
				trTags.push(trTag);
			}
			
			$("#listBody").append(trTags);
			$("#pagingArea").html(data.paging.pagingHTMLBS);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR);
			console.log(textStatus);
			console.log(errorThrown);
		}
	});
	
};


$(function(){
	eventFunction();
	$("#semsNo").val(thisSems);
	selectList(1);
});
</script>