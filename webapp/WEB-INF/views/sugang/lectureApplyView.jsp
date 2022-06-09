	<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2022. 4. 26.      작성자명      최초작성
* 2022. 4. 27. 			민진홍			수정
* Copyright (c) 2022 by DDIT All right reserved
 --%>
<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<security:authentication property="principal.realUser" 
	var="authMember"/>
	<style>
	.planDetails .col{
		border: 1px solid gray;
		height: 40px;
		padding-top: 5px;
	}
	.planDetails .title{
		font-weight: bold;
	}
	.lecturePlanView{
		text-align : left;
		font-weight: bold;
		cursor: pointer;
	}
	.sugangTableMark{
		right: 15px !important;
		top: 5px !important;
		color:#dc3545;
	}
	#nbspid{
	 text-align: left;
	}
	</style>
<h3 class="h3-title">수강신청</h3><hr class="hr-title">

<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery.form.min.js"></script>
<script>
// 		alert("${lectureApplyMessage1}");
$(document).ready(function () {
	

		  var Toast = Swal.mixin({
                    toast: true,
                    position: 'center-center',
                    showConfirmButton: false,
                    timer: 2000,
                    timerProgressBar: true,
                    didOpen: (toast) => {
                        toast.addEventListener('mouseenter', Swal.stopTimer),
                        toast.addEventListener('mouseleave', Swal.resumeTimer)
                    }
                })

<c:if test="${not empty lectureApplyMessage1 }">
                Toast.fire({
                    icon: 'error',
                    title: '${lectureApplyMessage1}'
                });
	</c:if>
<c:if test="${not empty lectureApplyMessage2 }">
                Toast.fire({
                    icon: 'success',
                    title: '${lectureApplyMessage2}'
                });
	</c:if>
<c:if test="${not empty lectureApplyMessage3 }">
                Toast.fire({
                    icon: 'success',
                    title: '${lectureApplyMessage3}'
                });
	</c:if>
});
	</script>
 <div class="row">
<div class="col-4">
	<div class="p-3 border bg-light">
<div class="card">
  <div class="card-header">
    내정보
  </div>
    <div class="card-body">
			<ul	style="border-left: 3px solid #677794; list-style: none; padding-left:1rem;" id="myInformation">
				<li><strong>학번 : </strong>${authMember.userNo }</li>
				<li><strong>성명 : </strong>${authMember.userName }</li>
				<li><strong>학년 : </strong>${authMember.stuYear }학년</li>
				<li><strong>학과 : </strong>${authMember.userDepartmentName }</li>
				<li><strong>학적상태 : </strong>${authMember.stuCode}</li>
				
			</ul>
</div>
		</div>
	</div>

<div class="d-inline-flex p-2 bd-highlight">
<table id="searchDIV">
	<tr>
	<td>
	개설과목 검색
	</td>
		<td>
		<select name="deptName" class="form-select">
		</select>
		</td>
		<td>
		<select name="sjtMajor" class="form-select">
  <option selected value="">이수구분</option>
  <option value="전필">전공필수</option>
  <option value="전선">전공선택</option>
  <option value="교양">교양</option>
</select>
		</td>
				<td>
		<select name="sjtGrade" class="form-select">
  <option selected value="">학년</option>
  <option value="1">1학년</option>
  <option value="2">2학년</option>
  <option value="3">3학년</option>
		</select>
		</td>	
	</tr>
	<tr >
		<td colspan="5">
	<div class="input-group mb-3">
  <input type="text" class="form-control" placeholder="과목명 검색" name="sjtName"/>
  <button class="btn btn-outline-secondary btn-sm" type="button" id="searchBtn">검색</button>
</div>
		</td>
	</tr>
</table>
	</div>
	</div>


<div class="col">
	<div class="p-3 border bg-light" style="height:90%;">
 <table id="schedule" style="height: 100%;" class="align-middle text-center table-bordered border-secondary">
  <colgroup>
        <col width="30px"/>
        <col width="100px"/>
        <col width="100px"/>
        <col width="100px"/>
        <col width="100px"/>
        <col width="100px"/>
    </colgroup>
  <tr style="height: 20px;">
    <th>/</th>
    <th>월</th>
    <th>화</th>
    <th>수</th>
    <th>목</th>
    <th>금</th>
  </tr>
  <tr>
    <th id="period1">1</th>
     <td id="mon1"></td>
     <td id="tue1"></td>
     <td id="wed1"></td>
     <td id="thu1"></td>
     <td id="fri1"></td>
  </tr>
  <tr>
    <th id="period2">2</th>
     <td id="mon2"></td>
     <td id="tue2"></td>
     <td id="wed2"></td>
     <td id="thu2"></td>
     <td id="fri2"></td>
  </tr>
  <tr>
    <th id="period3">3</th>
     <td id="mon3"></td>
     <td id="tue3"></td>
     <td id="wed3"></td>
     <td id="thu3"></td>
     <td id="fri3"></td>
  </tr>
  <tr>
    <th id="period4">4</th>
     <td id="mon4"></td>
     <td id="tue4"></td>
     <td id="wed4"></td>
     <td id="thu4"></td>
     <td id="fri4"></td>
  </tr>
  <tr>
    <th id="period5">5</th>
     <td id="mon5" ></td>
     <td id="tue5"></td>
     <td id="wed5"></td>
     <td id="thu5"></td>
     <td id="fri5"></td>
  </tr>
  <tr>
 	<th id="period6">6</th>
     <td id="mon6"></td>
     <td id="tue6"></td>
     <td id="wed6"></td>
     <td id="thu6"></td>
     <td id="fri6"></td>
  </tr>
 
</table>
</div>

</div>
</div>
<!-- </form> -->
<!-- 서치폼 -->
<form id="searchForm" action="${pageContext.request.contextPath }/lecture/planList" method="get" hidden="hidden">
	<input type="text" name="deptName"/>
	<input type="text" name="sjtMajor"/>
	<input type="number" name="sjtGrade"/>
	<input type="text" name="sjtName"/>
</form>


<div class="d-flex bd-highlight" style="padding-bottom: 5rem;">

<!-- 개설강의시작 -->
<div class="p-2 w-90 bg-light">
<div id="sugangTable">
<div class="position-relative">
<ul class="nav nav-tabs" id="myTab" role="tablist">
  <li class="nav-item" role="presentation">
    <button class="nav-link active" id="home-tab" data-bs-toggle="tab" data-bs-target="#home" type="button" role="tab" aria-controls="home" aria-selected="true">개설강의</button>
  </li>
  <li class="nav-item" role="presentation">
    <button class="nav-link" id="profile-tab" data-bs-toggle="tab" data-bs-target="#profile" type="button" role="tab" aria-controls="profile" aria-selected="false">찜강의</button>
  </li>
</ul>
	<p class="position-absolute top-0 end-0 sugangTableMark"><small>*교과목명 클릭시 강의계획서를 볼 수 있어요.</small></p> 
</div>
<!-- 	<p class="top-0 end-0" style="float: right;"><small>*교과목명 클릭시 강의계획서를 볼 수 있어요.</small></p>  -->
<div class="tab-content" id="myTabContent">
  <div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
  <table class="table table-hover align-middle border-secondary sugangTable hoverSugangTable ">
  <thead>
		<tr class="align-middle text-center">
			<th>찜강</th>
			<th>강의번호</th>
			<th>대상학년</th>
			<th>교과목명</th>
			<th>이수구분</th>
			<th>학점</th>
			<th>교수이름</th>
			<th>강의시간</th>
			<th>신청/제한인원</th>
			<th>신청</th>
		</tr>
	</thead>

	<tbody id="listbody">
		
	</tbody>
</table>
  </div>
  
  
  
  <div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab"> 
  <table class="table table-hover">
 <thead>
		<tr class="align-middle text-center">
			<th>찜강</th>
			<th>강의번호</th>
			<th>대상학년</th>
			<th>교과목명</th>
			<th>이수구분</th>
			<th>학점</th>
			<th>교수이름</th>
			<th>강의시간</th>
			<th>신청/제한인원</th>
			<th>신청</th>
		</tr>
	</thead>
	<tbody id="listbody3">
		
	</tbody>
</table>
  </div>
</div>
</div>
</div>
<!-- 개설강의끝 -->

<!-- 신청한내역시작 -->
<div class="p-2 bg-light" id="sugangTable2">
<table class="table table-hover divInTable">

	<thead>
		<tr class="align-middle text-center text-nowrap">
			<th>찜강</th>
			<th>강의번호</th>
			<th>학년</th>
			<th>교과목명</th>
			<th>학점</th>
			<th>교수명</th>
			<th>신청</th>
		</tr>
	</thead>
	<tbody id="listbody2">
	
	</tbody>
</table>
</div>
</div>
<!-- 신청한내역끝 -->


<!-- 상세보기 모달 START -->
<div class="modal fade" id="detailModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">강의계획 상세보기</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body" id="detailModalBody">
      	<div class="container planDetails">
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
        <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>
<!-- 상세보기 모달 HTML END -->
<script type="text/javascript">
const VIEWURLPTRN = "${pageContext.request.contextPath}/lecture/apply?lecId=%V&lecSems=%C&lecCredit=%D";
const VIEWURLPTRN2 = "${pageContext.request.contextPath}/lecture/cancel?lecId=%V&lecSems=%C";

let searchDIV = $("#searchDIV");
let listBody = $("#listbody");
let listBody3 = $("#listbody3");

//수강목록조회
let searchForm = $("#searchForm").ajaxForm({
	dataType:"json" // Accept(request)/Content-Type(response)
	, success:function(paging){
		//수강신청목록 시작
		listBody.empty();

		let trTags = [];
		if(paging && paging.length > 0){
			$.each(paging, function(idx, data){
				let viewURL = VIEWURLPTRN.replace("%V", data.LEC_ID).replace("%C", data.LEC_SEMS).replace("%D", data.SJT_CREDIT);
				let trTag = $("<tr>").addClass("align-middle text-center text-nowrap linkBtn "+data.LEC_ID+"")
									.data("href", viewURL)
									.append(
											//찜강인데 복잡하긴한데 좀 뭐 그냥 내맘이지..
										$("<td>").html($("<a>").addClass("bi" +(data.CART_ID == null ? " bi-star" :  " bi-star-fill"))
												.attr("href","${pageContext.request.contextPath}/lecture/"+(data.CART_ID == null ? "cartInsert" :  "cartDelete")+"?lecId="+data.LEC_ID+"&lecSems="+data.LEC_SEMS))
										, $("<td>").html(data.LEC_ID)	
										, $("<td>").html(data.SJT_GRADE)	
										, $("<td>").html("&nbsp&nbsp&nbsp&nbsp&nbsp"+data.SJT_NAME).addClass('lecturePlanView').attr('id',data.PLAN_NO).attr("data-plan-no", data.PLAN_NO)
										.attr("data-bs-toggle", "modal").attr("data-bs-target", "#detailModal")	
										, $("<td>").html(data.SJT_MAJOR)	 
										, $("<td>").html(data.SJT_CREDIT)	
										, $("<td>").html(data.USER_NAME)	
										, $("<td>").html(data.LEC_TIME)	
										, $("<td>").html(data.LEC_PERS+"/"+data.PLAN_LIMIT)	
										, $("<td>").html($("<button>").addClass("btn btn-primary btn-sm applyBtn").html("신청하기"))
// 										val(data.LEC_ID)
									);
				trTags.push(trTag);
			});
		}else{
			let trTag = $("<tr>").html(
							$("<td>").attr("colspan", "10")
									 .html("조건에 맞는 데이터가 없음.")
						);
			trTags.push(trTag);
		} // if end
		
		listBody.append(trTags);
		//수강신청목록 끝
		
		//찜강의 탭
		listBody3.empty();

		let trTags2 = [];
		if(paging && paging.length > 0){
			$.each(paging, function(idx, data){
				let viewURL = VIEWURLPTRN.replace("%V", data.LEC_ID).replace("%C", data.LEC_SEMS).replace("%D", data.SJT_CREDIT);
				if(data.CART_ID != null){
				let trTag = $("<tr>").addClass("align-middle text-center text-nowrap linkBtn")
									.data("href", viewURL)
									.append(
											//찜강인데 복잡하긴한데 좀 뭐 그냥 내맘이지..
										$("<td>").html($("<a>").addClass("bi" +(data.CART_ID == null ? " bi-star" :  " bi-star-fill"))
												.attr("href","${pageContext.request.contextPath}/lecture/"+(data.CART_ID == null ? "cartInsert" :  "cartDelete")+"?lecId="+data.LEC_ID+"&lecSems="+data.LEC_SEMS))
										, $("<td>").html(data.LEC_ID)	
										, $("<td>").html(data.SJT_GRADE)	
										, $("<td>").html(data.SJT_NAME)	
										, $("<td>").html(data.SJT_MAJOR)	 
										, $("<td>").html(data.SJT_CREDIT)	
										, $("<td>").html(data.USER_NAME)	
										, $("<td>").html(data.LEC_TIME)	
										, $("<td>").html(data.LEC_PERS+"/"+data.PLAN_LIMIT)	
										, $("<td>").html($("<button>").addClass("btn btn-primary btn-sm applyBtn").html("신청하기"))
// 										val(data.LEC_ID)
									);
				trTags2.push(trTag);
				}
			});
		}else{
			let trTag = $("<tr>").html(
							$("<td>").attr("colspan", "10")
									 .html("조건에 맞는 데이터가 없음.")
						);
			trTags2.push(trTag);
		} // if end
		
		listBody3.append(trTags2);
		//찜강의 끝

		
	} // success end
	, resetForm : false
}).submit();

//deptName 학과 조회
$.ajax({
	url : "${pageContext.request.contextPath}/lecture/deptNameList",
	dataType : "json",
	success : function(resp) {
		let options = [];
		options.push($("<option>").attr("value", "").text("학과"));
		$(resp).each(function(index, data){
			let option = $("<option>").attr("value", data.DEPT_NAME)
									  .text(data.DEPT_NAME);
			options.push(option);
		});
		searchDIV.find("[name=deptName]").append(options);
		//이 밑에꺼는 학과 골랐을때 옆에 메뉴도 바꾸고싶으면 만들까..?
// 		$(prodLguTag).val("${paging.detailCondition.prodLgu}");
// 		$(prodLguTag).trigger("change");			
	},
	error : function(jqXHR, textStatus, errorThrown) {
		console.log(jqXHR);
		console.log(textStatus);
		console.log(errorThrown);
	}
});


$(document).on("click", ".applyBtn", function(){
	let href = $(this).parents("tr").data("href");
	if(href)
		location.href=href;
}).css("cursor", "pointer");

$(document).on("click", ".cancelBtn", function(){
	let href = $(this).parents("tr").data("href");
	if(href)
		location.href=href;
}).css("cursor", "pointer");

let listBody2 = $("#listbody2");

//수강완료목록조회
$.ajax({
	url : "${pageContext.request.contextPath}/lecture/alreadyAppliedList",
	dataType : "json",
	success : function(paging) {
		listBody2.empty();
		let creditSum = 0;
		let trTags = [];
		if(paging && paging.length > 0){
			$.each(paging, function(idx, data){
				let viewURL = VIEWURLPTRN2.replace("%V", data.LEC_ID).replace("%C", data.PLAN_SEMS);
				let trTag = $("<tr>").addClass("align-middle text-center linkBtn")
									.data("href", viewURL)
									.append(
											$("<td>").html($("<a>").addClass("bi" +(data.CART_ID == null ? " bi-star" :  " bi-star-fill"))
													.attr("href","${pageContext.request.contextPath}/lecture/"+(data.CART_ID == null ? "cartInsert" :  "cartDelete")+"?lecId="+data.LEC_ID+"&lecSems="+data.PLAN_SEMS))
										, $("<td>").html(data.LEC_ID)	
										, $("<td>").html(data.PLAN_YEAR)	
										, $("<td>").html("&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp"+data.LEC_NAME).attr('id','nbspid')	
										, $("<td>").html(data.SJT_CREDIT)	 
										, $("<td>").html(data.PRO_NAME)	
										, $("<td>").html($("<button>").addClass("btn btn-primary btn-sm cancelBtn").html("철회하기"))

									);
				trTags.push(trTag);	
				creditSum += data.SJT_CREDIT;
			});

			
		}else{
			let trTag = $("<tr>").html(
							$("<td>").attr("colspan", "10")
									 .html("조건에 맞는 데이터가 없음.")
						);
			trTags.push(trTag);
		} // if end
		//<li><strong>학적상태 : </strong>${authMember.stuCode}</li>
		$('#myInformation').append(
			$("<li>").append(
					$("<strong>").html("신청한 학점 : ")
					).append(creditSum+'점').css("color","#0d6efd")	
			,$("<li>").append(
					$("<strong>").html("신청가능한 학점 : ")
					).append((21-creditSum)+'점').css("color","#0d6efd")	
		)	
		
		listBody2.append(trTags);

	},
	error : function(jqXHR, textStatus, errorThrown) {
		console.log(jqXHR);
		console.log(textStatus);
		console.log(errorThrown);
	}, resetForm : false
});

// 시간표
$.ajax({
	url : "${pageContext.request.contextPath}/lecture/lectureScheduleList",
	dataType : "json",
	success : function(paging) {
		let trTags = [];
		if(paging && paging.length > 0){
			$.each(paging, function(idx, data){
				
				
				let scheduleId = Object.keys(data);
				let scheduleVal = Object.values(data);
				
				$('#'+scheduleId).text(scheduleVal)
				
				
			});
				
// 			시간표 색칠하기...
					let tdLength = $('#schedule td').length;
					var colorList = [];
					colorList.push("#ecc369");
					colorList.push("#f08676");
					colorList.push("#70a5e9");
					colorList.push("#75ca87");
					colorList.push("#a6c96f");
					colorList.push("#7ad1c0");
					colorList.push("#f08676");
					colorList.push("#9d86e0");
					colorList.push("#fbaa69");
					
					
							var colorCode = 0;
					for(i = 0; i < tdLength; i++){
						if(colorCode > 7){
							colorCode = 0;
						}
					let tdText = [];
				
						if($('#schedule td').eq(i).text() != ""){
						tdText.push($('#schedule td').eq(i));
						for(j=1; j < tdLength; j++){
							if($('#schedule td').eq(i).text() == $('#schedule td').eq(j).text()){
								tdText.push($('#schedule td').eq(j));
							}
						}

						for(k = 0; k < tdText.length; k++){
							tdText[k].css("background-color",colorList[colorCode]);
							}
							colorCode++;
					
						}
						
					}		
			
		}	
		listBody2.append(trTags);

	},
	error : function(jqXHR, textStatus, errorThrown) {
		console.log(jqXHR);
		console.log(textStatus);
		console.log(errorThrown);
	}, resetForm : false
});


//서치폼
$("#searchBtn").on("click", function(){
	let inputs = searchDIV.find("[name]");
	$(inputs).each(function(index, ipt){
//			console.log(this.name)
		let name = this.name;
		let value = $(this).val();
		searchForm.find("[name="+name+"]").val(value);
	});
	searchForm.submit();
});


//강의신청 테이블이랑 시간표 동기화
$(document).ready(function(){
$('#listbody').on('mouseenter','tr',function(){

	let hoverTr = $(this).find('td').eq(7).text();
	let hoverText = []; 
	hoverText = hoverTr.split(',');
	var textLength = 2;
	if(hoverText[1] == null){		
		textLength = 1;
	}
	var day = "";
	var cssbefore = [];
	for(i=0; i<textLength; i++){
		 day = hoverText[i].charAt(0);
			if(day == "월"){
				hoverText[i] = "mon"+hoverText[i].charAt(1);
				cssbefore[i] = $('#'+hoverText[i]).css("background-color");
		$('#'+hoverText[i]).css("background-color","#777777");		
			}
		//end if
			if(day == "화"){
				hoverText[i] = "tue"+hoverText[i].charAt(1);
				cssbefore[i] = $('#'+hoverText[i]).css("background-color");
		$('#'+hoverText[i]).css("background-color","#777777");
			}
		//end if
			if(day == "수"){
				hoverText[i] = "wed"+hoverText[i].charAt(1);
				cssbefore[i] = $('#'+hoverText[i]).css("background-color");
		$('#'+hoverText[i]).css("background-color","#777777");
			}
		//end if	
			if(day == "목"){
				hoverText[i] = "thu"+hoverText[i].charAt(1);
				cssbefore[i] = $('#'+hoverText[i]).css("background-color");
		$('#'+hoverText[i]).css("background-color","#777777");
			}
		//end if	
			if(day == "금"){
				hoverText[i] = "fri"+hoverText[i].charAt(1);
				cssbefore[i] = $('#'+hoverText[i]).css("background-color");
		$('#'+hoverText[i]).css("background-color","#777777");
			}
		//end if	
			$('#listbody').on('mouseleave','tr',function(){
	 			$('#'+hoverText[0]).css("background-color",cssbefore[0]);
	 			$('#'+hoverText[1]).css("background-color",cssbefore[1]);
	 			});
	} //end fordd
});


});

//강의계획서
$(document).on('click','.lecturePlanView',function(){
	let planNo = $(this).attr('id'); 
	$.ajax({
		url : "${cPath}/lecture/lecturePlanView",
		method : "get",
		data : {'planNo' : planNo},
		dataType : "json",
		success : function(resp) {
			let plan = resp.submitPlanVo;
			let wplanList = plan.wplanList;
			$("#GplanNo").text(plan.planNo)
			$("#GuserName").text(plan.userName);
			$("#GuserNo").text(plan.userNo);
			$("#GcolName").text(plan.colName);
			$("#GdeptName").text(plan.deptName);
			$("#GsjtId").text(plan.sjtId);
			$("#GsjtName").text(plan.sjtName);
			$("#GplanYear").text(plan.planYear);
			$("#GplanLimit").text(plan.planLimit);
			$("#GplanTcnt").text(plan.planTcnt);
			$("#GsjtCredit").text(plan.sjtCredit);
			$("#GplanEval").text(plan.planEval);
			$("#GsjtMajor").text(plan.sjtMajor);
			$("#GplanSts").text(plan.planSts);
			$("#GplanSmry").text(plan.planSmry);
			
			if(wplanList && wplanList.length > 0){
				$('.week').empty();
				$.each(wplanList, function(idx, wPlan){
					if(wPlan.wplanW == null){
						$('.planDetails').append($("<div>").addClass("row week").append(
								 $("<div>").addClass("col col-12 cont").text("주차별 강의설명이 없습니다.")
								));
					}else{
						$('.planDetails').append($("<div>").addClass("row week").append(
												$("<div>").addClass("col col-2 title").text(wPlan.wplanW+"주차")
												, $("<div>").addClass("col col-10 cont").text(wPlan.wplanCont)
								));
					}
				});
			}
		
	},
	error : function(jqXHR, textStatus, errorThrown) {
		console.log(jqXHR);
		console.log(textStatus);
		console.log(errorThrown);
	}
	});

});
</script>




