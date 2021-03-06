<%--
  교수평가, 강의평가 평가별 진행현황 조회
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
<%-- <link rel="stylesheet" href="${cPath }/resources/js/tablesorter-master/dist/css/theme.default.min.css"> --%>
<%-- <script type="text/javascript" src="${cPath}/resources/js/tablesorter-master/dist/js/jquery.tablesorter.js"></script> --%>
<%-- <script type="text/javascript" src="${cPath}/resources/js/tablesorter-master/dist/js/jquery.tablesorter.widgets.js"></script> --%>
<style>
	.text-center{text-align: center;}
	a {text-decoration-line: none;}
	a:hover{font-weight: bold;}
	.navActive{background-color: orange;}
	.table{
		border-top:2px solid black;
		width: 95%;
	}
	#btnArea{margin-bottom: 15px;}
	#orderComment{color:red; font-size: 18px; font-weight: bold;}
</style>
<h3 class="h3-title">평가별 진행현황 조회</h3><hr class="hr-title">

<ul class="nav nav-tabs">
	<li class="nav-item">
	  <a id="lecRes" class="nav-link" href="#" style="color:black">강의평가</a>
	</li>
	<li class="nav-item">
	  <a id="proRes" class="nav-link" href="#" style="color:black">교수평가</a>
	</li>
</ul>
<br>
<div class="redLine" id="btnArea">
	<span id="orderComment">*이름순으로 정렬중입니다.&nbsp;</span>
	<button type="button" class="btn btn-primary orderBtn" data-except-rate="0"><i class="bi bi-sort-alpha-down"></i> 이름순</button>
	<button type="button" class="btn btn-success orderBtn" data-except-rate="-1" value="DESC"><i class="bi bi-sort-down"></i> 진행률 높은순</button>
	<button type="button" class="btn btn-warning orderBtn" data-except-rate="101" value="ASC"><i class="bi bi-sort-down-alt"></i> 진행률 낮은순</button>
</div>

<table class="table table-bordered" id="dataTable">
	 <thead>
	    <tr id="trTitle" class="tr-headLine">
	    </tr>
	 </thead>
	  <tbody class="text-center" id="dataListTbody">
	 
	 </tbody>
</table>
<div class="redLine" id="extraArea">
	<form id="searchForm">
	<security:csrfInput/> 
		<input type="hidden" name="holdExceptRate"/>
		<input type="hidden" name="holdOrderBy"/>
	</form>
</div>

<script>
let astFlag = true;
let dataDomination = $("#dataDomination");
let lecRes = $("#lecRes");
let proRes = $("#proRes");

let trTitle = $("#trTitle");
let dataListTbody = $("#dataListTbody");

let orderBtn = $(".orderBtn");
let orderComment = $("#orderComment");

let holdExceptRate = $("input[name=holdExceptRate]");
let holdOrderBy = $("input[name=holdOrderBy]");

const proResultTr = "<th >교수<br>번호</th><th >교수명</th><th >성별</th><th >직책</th><th >진행<br>강의수</th><th >수강<br>인원</th><th >평가<br>인원</th><th >진행률</th>";	
const lecResultTr = "<th >강의<br>번호</th><th >강의명</th><th >교수명</th><th >분과대학</th><th >소속학과</th><th >수강<br>인원</th><th >평가<br>인원</th><th >진행률</th>";	


proRes.on("click", function(){
	astFlag = false;
	lecRes.parent("li").removeClass("navActive");
	$(this).parent("li").addClass("navActive");
	proResList();
	dataDomination.show();
});

lecRes.on("click", function(){
	astFlag = true;
	proRes.parent("li").removeClass("navActive");
	$(this).parent("li").addClass("navActive");
	lecResList();
	dataDomination.show();
});

function lecResList(){
	let exceptRate = holdExceptRate.val();
	let orderBy = holdOrderBy.val();
	
	$.ajax({
		url : "${cPath}/astResult/lecResData.do",
		method : "get",
		data : {exceptRate:exceptRate, orderBy:orderBy},
		dataType : "json",
		success : function(resp) {
			let resList = resp.resList;
			trTitle.empty();
			dataListTbody.empty();
			trTitle.html(lecResultTr);
			let trTags = [];
			$.each(resList, function(idx, res){
				let trTag = $("<tr>").addClass("tr-targetLine tr-targetHover").append($("<td>").text(res.lecId)
								, $("<td>").text(res.lecName).addClass("text-right")
								, $("<td>").text(res.userName)
								, $("<td>").text(res.colName)
								, $("<td>").text(res.deptName)
								, $("<td>").text(res.lecRealpers)
								, $("<td>").text(res.astPers)
								, $("<td>").text(res.astComprate)
				);
				trTags.push(trTag);
			});
			dataListTbody.append(trTags);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR);
			console.log(textStatus);
			console.log(errorThrown);
		}
	});
	if(orderBy=="DESC"){
		orderComment.text("*진행률 높은순으로 정렬중입니다.\t");
	}else if(orderBy=="ASC"){
		orderComment.text("*진행률 낮은순으로 정렬중입니다.\t");
	}else{
		orderComment.text("*이름순으로 정렬중입니다.\t");
	}
};




function proResList(){
	let exceptRate = holdExceptRate.val();
	let orderBy = holdOrderBy.val();
	
	$.ajax({
		url : "${cPath}/astResult/proResData.do",
		method : "get",
		data : {exceptRate:exceptRate, orderBy:orderBy},
		dataType : "json",
		success : function(resp) {
			let resList = resp.resList;
			trTitle.empty();
			dataListTbody.empty();
			trTitle.html(proResultTr);
			let trTags = [];
			$.each(resList, function(idx, res){
				let trTag = $("<tr>").addClass("tr-targetLine tr-targetHover").append($("<td>").text(res.userNo)
								, $("<td>").text(res.userName)
								, $("<td>").text(res.userGender)
								, $("<td>").text(res.proJob)
								, $("<td>").text(res.lecCnt)
								, $("<td>").text(res.lecRealpers)
								, $("<td>").text(res.astPers)
								, $("<td>").text(res.astComprate)
				);
				trTags.push(trTag);
			});
			dataListTbody.append(trTags);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR);
			console.log(textStatus);
			console.log(errorThrown);
		}
	});
	if(orderBy=="DESC"){
		orderComment.text("*진행률 높은순으로 정렬중입니다.\t");
	}else if(orderBy=="ASC"){
		orderComment.text("*진행률 낮은순으로 정렬중입니다.\t");
	}else{
		orderComment.text("*이름순으로 정렬중입니다.\t");
	}
};
$("#lecRes").trigger("click"); 

orderBtn.on("click", function(){
	let exceptRate = $(this).data("exceptRate");
	let orderBy = $(this).val();
	
	holdExceptRate.val(exceptRate);
	holdOrderBy.val(orderBy);
	
	if(astFlag){
		lecResList();
	}else{
		proResList();
	}
});

// $("#dataTable").tablesorter();
// $("#dataTable").tablesorter({ sortList: [[0,0], [1,0]] });
</script>








