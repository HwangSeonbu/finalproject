<%--상담 완료 현황 조회
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2022. 4. 29. 황선부      최초작성
* Copyright (c) 2022 by DDIT All right reserved
 --%>
<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!--     	model.addAttribute("counselVO", counselVO); -->
<!-- 		model.addAttribute("qaList", qaList); -->
<style>
#stuTable td{
	border:1px solid black;
}
img{
	width: 150px;
	height: 150px;
}
/* #leftDiv,#rightDiv{ */
/* 	border: 3px solid blue; */
/* } */
#stuTable{
	width: 650px;
	border: 2px double black;
}
tr td:first-child{
	width: 75px;
}
tr td:second-child{
	width: 100px;
}

#stuTable td{
	font-size: 1.1em;
	border: 1px solid black;
	text-align: center;
}
.th{
	background-color: 	#FFB432;
}
#name{
	width:80px;
}
#depart{
	width:120px;
}
#rightDiv{
	height:100px;
}

</style>
<h3 class="h3-title">상담 상세 페이지</h3><hr class="hr-title">

<div id="container" class="container">
  <div id="row" class="row">
    <div class="col" id="leftDiv">
   		<table id="stuTable" border="1">
   			<tr>
   				<td rowspan="2">
   				<spring:eval expression="@appInfo.studentImages" var="studentImages"/>
   				<img src="${cPath}/resources/img/profile/${counselVO.userSavename}"/>
   				</td>
   				<td id="name0" class="th">이름</td>
   				<td id="name">${counselVO.userName }</td>
   				<td class="th">소속</td>
   				<td id="depart">${counselVO.deptName }</td>
   				<td class="th">학번</td>
   				<td>${counselVO.userNo }</td>
   			</tr>
   			<tr>
   				
   				<td class="th">학적상태</td>
   				<td colspan="2">${counselVO.codeName }</td>
   				<td class="th">상담접수일</td>
   				<td colspan="2">${counselVO.cnslDate }</td>
   			</tr>
   		</table>
   		
   		<div>
   		<table id="inputTable" class="table table-hover" >
		        	<tr>
		        		<td id="r1">
		        		<nav class="navbar navbar-light" style="background-color: #FFB432;">
						  학업
						</nav>
				        	1.자신의 전공에 대한 만족도는 어떠합니까?<br>
				        		<div class="form-check form-check-inline">
								  <input class="form-check-input" type="radio" name="r1" id="inlineRadio1" value="A21" >
								  <label class="form-check-label" for="inlineRadio1">매우 그렇다</label>
								</div>
								<div class="form-check form-check-inline">
								  <input class="form-check-input" type="radio" name="r1" id="inlineRadio2" value="A22">
								  <label class="form-check-label" for="inlineRadio2">그렇다</label>
								</div>
								<div class="form-check form-check-inline">
								  <input class="form-check-input" type="radio" name="r1" id="inlineRadio3" value="A23">
								  <label class="form-check-label" for="inlineRadio3">보통</label>
								</div>
								<div class="form-check form-check-inline">
								  <input class="form-check-input" type="radio" name="r1" id="inlineRadio4" value="A24">
								  <label class="form-check-label" for="inlineRadio4">아니다</label>
								</div>
								<div class="form-check form-check-inline">
								  <input class="form-check-input" type="radio" name="r1" id="inlineRadio5" value="A25">
								  <label class="form-check-label" for="inlineRadio5">매우 아니다</label>
								</div>      		
		        		</td>
		        	</tr>
		        	<tr>
		        		<td id="r2">
			        		2.전과 또는 편입을 생각해본적이 있는가?<br>
			        		<div class="form-check form-check-inline">
							  <input class="form-check-input" type="radio" name="r2" id="inlineRadio6" value="A11">
							  <label class="form-check-label" for="inlineRadio6">예</label>
							</div>
							<div class="form-check form-check-inline">
							  <input class="form-check-input" type="radio" name="r2" id="inlineRadio7" value="A12">
							  <label class="form-check-label" for="inlineRadio7">아니오</label>
							</div>
		        		</td>     	
		        	</tr>
		        	
		        	 <tr>
		        		<td id="r3">
				        	3.귀하는 현재 복수(부)전공을 하고(또는 할 계획이) 있습니까?<br>
				        	<div class="form-check form-check-inline">
							  <input class="form-check-input" type="radio" name="r3" id="inlineRadio8" value="A11">
							  <label class="form-check-label" for="inlineRadio8">예</label>
							</div>
							<div class="form-check form-check-inline">
							  <input class="form-check-input" type="radio" name="r3" id="inlineRadio9" value="A12">
							  <label class="form-check-label" for="inlineRadio9">아니오</label>
							</div>
		        		</td>     	
		        	</tr>
		        	<tr>
		        		<td id="r4">
				        	4.자신의 진로계획은 무엇입니까?<br>
		        				<div class="form-check form-check-inline">
								  <input class="form-check-input" type="radio" name="r4" id="inlineRadio10" value="A21">
								  <label class="form-check-label" for="inlineRadio10">매우 그렇다</label>
								</div>
								<div class="form-check form-check-inline">
								  <input class="form-check-input" type="radio" name="r4" id="inlineRadio11" value="A22">
								  <label class="form-check-label" for="inlineRadio11">그렇다</label>
								</div>
								<div class="form-check form-check-inline">
								  <input class="form-check-input" type="radio" name="r4" id="inlineRadio12" value="A23">
								  <label class="form-check-label" for="inlineRadio12">보통</label>
								</div>
								<div class="form-check form-check-inline">
								  <input class="form-check-input" type="radio" name="r4" id="inlineRadio13" value="A24">
								  <label class="form-check-label" for="inlineRadio13">아니다</label>
								</div>
								<div class="form-check form-check-inline">
								  <input class="form-check-input" type="radio" name="r4" id="inlineRadio14" value="A24">
								  <label class="form-check-label" for="inlineRadio14">매우 아니다</label>
								</div>
		        		</td>
		        	</tr>
		        	 <tr>
		        		<td id="r5">
				        	5.학업의 장애요소가 있습니까?<br>
				        	<div class="form-check form-check-inline">
							  <input class="form-check-input" type="radio" name="r5" id="inlineRadio15" value="A11">
							  <label class="form-check-label" for="inlineRadio15">예</label>
							</div>
							<div class="form-check form-check-inline">
							  <input class="form-check-input" type="radio" name="r5" id="inlineRadio16" value="A12">
							  <label class="form-check-label" for="inlineRadio16">아니오</label>
							</div>     					
		        		</td>
		        	</tr>
		        	<tr>
		        		<td id="r6">
				        	6.자신의 진로계획은 무엇입니까?<br>
						        <div class="form-check form-check-inline">
								  <input class="form-check-input" type="radio" name="r6" id="inlineRadio17" value="A51">
								  <label class="form-check-label" for="inlineRadio17">대학원 진학</label>
								</div>
								<div class="form-check form-check-inline">
								  <input class="form-check-input" type="radio" name="r6" id="inlineRadio18" value="A52">
								  <label class="form-check-label" for="inlineRadio18">취업</label>
								</div>
								<div class="form-check form-check-inline">
								  <input class="form-check-input" type="radio" name="r6" id="inlineRadio19" value="A53">
								  <label class="form-check-label" for="inlineRadio19">군복무</label>
								</div>
								<div class="form-check form-check-inline">
								  <input class="form-check-input" type="radio" name="r6" id="inlineRadio20" value="A54">
								  <label class="form-check-label" for="inlineRadio20">기타</label>
								</div>    				
		        		</td>
		        	</tr>
					<tr>
						<td id="r7">
		        		<nav class="navbar navbar-light" style="background-color: #FFB432	;">
						  진로 및 취업
						</nav>			
							7.귀하는 본인의 학과에 대한 학문성격, 졸업 후 전망 등에 대해 잘 알고 있다고 생각합니까?<br>
								<div class="form-check form-check-inline">
								  <input class="form-check-input" type="radio" name="r7" id="inlineRadio21" value="A21">
								  <label class="form-check-label" for="inlineRadio21">매우 그렇다</label>
								</div>
								<div class="form-check form-check-inline">
								  <input class="form-check-input" type="radio" name="r7" id="inlineRadio22" value="A22">
								  <label class="form-check-label" for="inlineRadio22">그렇다</label>
								</div>
								<div class="form-check form-check-inline">
								  <input class="form-check-input" type="radio" name="r7" id="inlineRadio23" value="A23">
								  <label class="form-check-label" for="inlineRadio23">보통</label>
								</div>
								<div class="form-check form-check-inline">
								  <input class="form-check-input" type="radio" name="r7" id="inlineRadio24" value="A24">
								  <label class="form-check-label" for="inlineRadio24">아니다</label>
								</div>
								<div class="form-check form-check-inline">
								  <input class="form-check-input" type="radio" name="r7" id="inlineRadio25" value="A24">
								  <label class="form-check-label" for="inlineRadio25">매우 아니다</label>
								</div> 
						</td>
					</tr>
					
					<tr>
						<td id="r8">
		        			8.귀하는 언제부터 본격적인 취업(진학)준비를 할 계획입니까(혹은 하였습니까?)<br>
							<div class="form-check form-check-inline">
							  <input class="form-check-input" type="radio" name="r8" id="inlineRadio26" value="A21">
							  <label class="form-check-label" for="inlineRadio26">1학년</label>
							</div>
							<div class="form-check form-check-inline">
							  <input class="form-check-input" type="radio" name="r8" id="inlineRadio27" value="A22">
							  <label class="form-check-label" for="inlineRadio27">2학년</label>
							</div>
							<div class="form-check form-check-inline">
							  <input class="form-check-input" type="radio" name="r8" id="inlineRadio28" value="A23">
							  <label class="form-check-label" for="inlineRadio28">3학년</label>
							</div>
							<div class="form-check form-check-inline">
							  <input class="form-check-input" type="radio" name="r8" id="inlineRadio29" value="A24">
							  <label class="form-check-label" for="inlineRadio34">4학년</label>
							</div>
						</td>
					</tr>   
					<tr>
						<td id="r9">
							9.상담내용 및 특이사항<br>
			<textarea class="form-control" name="qaLong" aria-label="With textarea" style="height: 200px">${qaMap.r9}</textarea>       						
						</td>
					</tr>
			
		        </table>
   		
   		
   		</div>

<%--    		<c:choose> --%>
<%--    			<c:when test="${qaMap.r1 eq 'A21' }"> --%>
<!--    			TEST OK111 -->
<%--    			</c:when> --%>
<%--    			<c:otherwise> --%>
<!--    			TEST OK222 -->
<%--    			</c:otherwise> --%>
<%--    		</c:choose> --%>
    </div>
    <div class="col" id="rightDiv">
    
    
    
    <c:if test="${divergence eq 'INSERT'}">
		<jsp:include page="/WEB-INF/views/counsel/counselLogInsert.jsp"></jsp:include>   
    </c:if>
    <c:if test="${divergence eq 'VIEW'}">
		<jsp:include page="/WEB-INF/views/counsel/counselLogView.jsp"></jsp:include>   
    </c:if>
    
    
    
    </div>
  </div>
 </div>
 
 <script>
// 	<c:if test="${not empty message }">
// 	alert("${message}");
// 	</c:if>
$('#r1 input[value="${qaMap.r1}"]').attr("checked","checked");
$('#r2 input[value="${qaMap.r2}"]').attr("checked","checked");
$('#r3 input[value="${qaMap.r3}"]').attr("checked","checked");
$('#r4 input[value="${qaMap.r4}"]').attr("checked","checked");
$('#r5 input[value="${qaMap.r5}"]').attr("checked","checked");
$('#r6 input[value="${qaMap.r6}"]').attr("checked","checked");
$('#r7 input[value="${qaMap.r7}"]').attr("checked","checked");
$('#r8 input[value="${qaMap.r8}"]').attr("checked","checked");
	
$("#inputTable").find("input, select, textarea").attr("disabled","true");					
 						
 
 </script>