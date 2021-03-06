<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2022. 5. 9.      작성자명      최초작성
* Copyright (c) 2022 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
  <meta charset="utf-8">
 <meta name="viewport" content="width=device-width, initial-scale=1">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<security:authentication property="principal.realUser" var="authMember"/>
  <style>
   .box {
	    width: 150px;
	    height: 150px; 
	    border-radius: 70%;
	    overflow: hidden;
	    background-color: black;
	    margin-left: 28px;
	}
  .iconBox:not(h4) {
      text-align: center;
      width: 400px;
      height: 262px;
      color: #FF8C00;
    /*   transition: all 0.5s linear; */
      float:left;
      cursor: pointer;
  }
  
   .iconBox:not(h4) {
   	text-decoration: none;
   }

  .iconBox:hover{
    /*  transform :  rotateY( 360deg ); */
   
   }  
   
   a:hover{
  	color: #D2691E; 
  }
  .mainSomething1{
     height: 465px;
     margin-top: 20px;
     margin-left: 3%
    
  }
   .mainSomething2{
      width: 560px;
      height: 450px;
      margin-left: 7%;
      margin-top: 20px;
  }
  
  #noTitle{
  	border-bottom: solid 2px gray;
  }
  
  .main-item{
     border: solid 1px gray;
  }
  .plus{
     color: black;
     cursor: pointer;
  }

  
  .footer_container {
    position: relative;
    background: #BDBDBD;
    text-align: center;
    color: white;
    font-size: 12px;
    margin-top: 3%;
  }
  
  .navbar-brand{
  	color:white;
  }
  .myInfomation {
    padding-left: 1rem;
    margin-top: 6px;
   }
	#table{
		width: 10px;
	}
	
  </style>

<nav class="navbar navbar-expand-sm" style="background-color: #5d5d5d">
  <a class="navbar-brand">&emsp;공지사항</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse justify-content-between" id="collapsibleNavbar">
<!--     <ul class="navbar-nav"> -->
<!--       <li class="nav-item"> -->
<!--         <a class="nav-link" href="#" style="color:white">2022 6월 15일 파이썬개강이욤</a> -->
<!--       </li>  -->
<!--     </ul> -->
		<marquee style="font-size:20px;color:white;">
      		[2022년 6월 14일] 전자정부표준프레임워크 기반 풀-스택 개발자 양성과정 최종 프로젝트 발표</marquee>
    <div class="d-flex">
	        <a class="beford-link" style="color:white"><i class="bi bi-chevron-left fa-2x" href="#"></i></a>
	        <a class="after-link" style="color:white"><i class="bi bi-chevron-right fa-2x" href="#"></i></a>
    </div>
  </div>  
</nav>
<br>

<div class="d-flex justify-content-between">
<div style="width: 258px;margin-left: 2%; height: 577px;">
  <div class="card">
  	<div class="img">  	
    	<img class="card-img-top" src="${cPath }/resources/img/profile/${authMember.userSavename}" style="width:256px; height: 320px;">
  	</div>
    <div class="card-body" style="padding: 10%; height: 248px;" >
       <ul class="myInfomation" style="border-left: 3px solid #677794; list-style: none; width: 250px;">
             <li><strong>사번 </strong>${authMember.userNo }</li>
             <li><strong>성명 </strong>${authMember.userName }</li>
             <li><strong>직급 </strong>${authMember.userJob }</li>
             <li><strong>입사일 </strong>${authMember.userIndate }</li>
	   </ul>
   </div>
</div>          
</div>
  <table class="table table-bordered" id="table">
      <tr>
        <td> <a  class="iconBox" >
         		<i class="bi bi-receipt fa-9x" onClick="location.href='${pageContext.request.contextPath }/setEnroll/enrollSetForm.do'"></i>
				<h4>등록금관리</h4></a>
		</td>
        <td> <a  class="iconBox">
        		<i class="bi bi-pencil-square fa-9x" onClick="location.href='${pageContext.request.contextPath }/completeScore/testScoreCompleteList.do'"></i>
			   <h4>성적입력관리</h4></a>
		</td>
        <td>  <a  class="iconBox"><i class="bi bi-file-earmark-text fa-9x"  onClick="location.href='${pageContext.request.contextPath }/req/leaveSchoolList.do'"></i>
			  <h4>휴복학신청관리</h4></a>
		</td>
      </tr>
      <tr>
       <td> <a  class="iconBox"><i class="bi bi-mortarboard-fill fa-9x" onClick="location.href='${pageContext.request.contextPath }/targetGraduate/graduateTargetList.do'"></i>
			<h4>졸업대상자관리</h4></a>
		</td>
        <td> <a  class="iconBox"><i class="bi bi-person-video3 fa-9x" onClick="location.href='${pageContext.request.contextPath }/roomSet/collegeForm.do'"></i>
		   	  <h4>강의실관리</h4></a></td>
        <td><a  class="iconBox"><i class=" bi bi-calendar2-week fa-9x" onClick="location.href='${pageContext.request.contextPath }'"></i>
			<h4>시스템 일정 등록 </h4></a>
		</td>
      </tr>
  </table>
</div>

<div class="row" style="display: grid; grid-template-columns: 1047px 534px;">
      <div class="mainSomething1">
        <jsp:include page="../calendar/calendarView.jsp" flush="true"/>
      </div>
      <div class="mainSomething2">
         <h3 id="noTitle">공지사항 &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
         &emsp;
         <a class="plus"><i class="bi bi-plus-lg" onClick="location.href='${pageContext.request.contextPath }/board/noticeListView.do'"></i></a></h3>
         <p></p>
         <ul class="nav nav-pills flex-column" id="mainNoticeListBody">
         </ul>
      </div>
      <hr class="d-sm-none">
    </div>
</div>
<style>
	.span-title:hover{
		text-decoration:underline !important;
		cursor: pointer !important;
		font-weight: bold !important;
	}
</style>
<script>
let mainNoticeListBody = $("#mainNoticeListBody");
	
const MAINNOTICEURL = "${cPath}/board/noticeBoardView.do?who=";
var liStyle = {"margin-top":"20px", "height":"50px", "vertical-align":"middle", "font-size":"20px"};
	$.ajax({
		url : "${cPath}/mainNoticeList",
		method : "get",
		dataType : "json",
		success : function(resp) {
			mainNoticeListBody.empty();
			let noticeList = resp.noticeList;
			let liTags = [];
			$.each(noticeList, function(idx, notice){
				var eachUrl = MAINNOTICEURL+notice.noticeNo;
				var noreadYn = notice.noreadClass;
				var spanMark = noreadYn=="읽음"?"black":"red";
				var spanColor = noreadYn=="읽음"?"black":"blue";
				let liTag = $("<li>").addClass("main-item").css(liStyle).append(
						$("<a>").addClass("nav-link span-title").css("color", "black")
							.attr("href", eachUrl).append(
									$("<span>").text("["+noreadYn+"]  ").css("color", spanMark).css("font-weight", "bold")
									, $("<span>").text(notice.noticeTitle).css("color", spanColor)
									, $("<span>").text(notice.noticeDate).css("float", "right")
							)
				);
				liTags.push(liTag);
			});
			mainNoticeListBody.append(liTags);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR);
			console.log(textStatus);
			console.log(errorThrown);
		}
	});
</script>
<!-- <div class="footer_container">
	<div class="foot_menu">
	</div>
	<p class="company_info"></p>
	<br>
	대전광역시 중구 계룡로 846, 3-4층<br>
	<span> 대표번호 : 042-222-8202 </span>
	<span> / FAX : 070-8768-2972</span>
	<p>
		COPYRIGHT © 2020 (재)대덕인재대학교 ALL RIGHTS RESERVED.
	</p>
	<br>
</div> -->