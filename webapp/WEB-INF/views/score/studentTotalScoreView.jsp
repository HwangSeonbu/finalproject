<%--
	학생이 성적을 종합적으로 볼수 있는 페이지
* [[개정이력(Modification Information)]]
* 수정일                 수정자      	수정내용
* ----------  ---------  -----------------
* 2022. 5. 2.   김재웅      	최초작성
* 2022. 5. 3. 	민진홍     	성적조회페이지 작성
* Copyright (c) 2022 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
      <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
        <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    <%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
    <security:authentication property="principal.realUser" 
	var="authMember"/>
<style>
/* 이미지 흐림현상제거 */
img{
image-rendering: -webkit-optimize-contrast;
transform: translateZ(0);
backface-visibility: hidden;
}
</style>
<h5 class="fw-bold text-muted">성적총괄조회</h5>
<br>

<!-- <div class="container"> -->
<div class="row row-cols-2">
<div class="col-4">
  <div class="bd-highlight">
  <div class="card" style="max-width: 540px;">
  <div class="row g-0">
    <div class="col-md-4" style="padding:20px;">
      <img src="${cPath }/resources/img/ina.jpg" class="rounded rounded-circle" alt="..." height="100%" width="100%">
    </div>
    <div class="col-md-8">
      <div class="card-body fw-bold">
       							<div class="col-xs-7 " >
								<ul class="myInfomation" style="border-left:3px solid #677794; list-style: none;">
									<li><strong>학번  </strong>${authMember.userNo }</li>
									<li><strong>성명  </strong>${authMember.userName }</li>
									<li><strong>학년  </strong>${authMember.stuYear }학년</li>
									<li><strong>학과  </strong>${authMember.userDepartmentName }</li>
									<li><strong>학적상태  </strong>${authMember.stuCode}</li>
								</ul>
							</div>
      </div>
    </div></div>
  </div>
</div>
  
  </div>
  <!--   한칸 -->
<!--   <div class="p-2 flex-shrink-1 bd-highlight align-self-center"> -->
<!--   <div class="row row-cols-1 row-cols-md-3 g-1"> -->
     <div class="row row-cols-4">
<!--   한칸 -->
<div class="col">
  <div class="bd-highlight align-self-center">
  <div class="card border-dark mb-3 text-center" style="width: 12rem;">
  <div class="card-header fw-bold">졸업요건학점</div>
  <div class="card-body">
    <h5 class="card-title text-danger">120</h5>
  </div>
</div>
</div>
  </div>
  <!--   한칸 -->
<div class="col">
  <div class="card border-dark mb-3 text-center" style="width: 12rem;">
  <div class="card-header fw-bold">총 취득학점</div>
  <div class="card-body">
    <h5 class="card-title text-primary">${totalMap.totalCredit}</h5>
  </div>
  </div>
</div>  
  <!--   한칸 -->
<div class="col">
<!--   <div class="p-2 flex-shrink-1 bd-highlight align-self-center"> -->
  <div class="card border-dark mb-3 text-center" style="width: 12rem;">
  <div class="card-header fw-bold">총 평점평균</div>
  <div class="card-body">
    <h5 class="card-title text-primary">${totalMap.totalRsCrdt}</h5>
  </div>
</div>
  </div>
<!--   한칸 -->

<!--   <div class="p-2 flex-shrink-1 bd-highlight align-self-center"> -->
<div class="col">
  <div class="card border-dark mb-3 text-center" style="width: 12rem;">
  <div class="card-header fw-bold">총 배점평균</div>
  <div class="card-body">
    <h5 class="card-title text-primary">${totalMap.totalRsRct }</h5>
  </div>

  </div></div>
  <!--   한칸 -->
<!--   한칸 -->
<div class="col">
  <div class="bd-highlight align-self-center">
  <div class="card border-dark mb-3 text-center" style="width: 12rem;">
  <div class="card-header fw-bold">중간고사평균</div>
  <div class="card-body">
    <h5 class="card-title text-dark">${totalMap.totalMiddle }</h5>
  </div>
</div>
</div>
  </div>
  <!--   한칸 -->
<!--   한칸 -->
<div class="col">
  <div class="bd-highlight align-self-center">
  <div class="card border-dark mb-3 text-center" style="width: 12rem;">
  <div class="card-header fw-bold">기말고사평균</div>
  <div class="card-body">
    <h5 class="card-title text-dark">${totalMap.totalFinal }</h5>
  </div>
</div>
</div>
  </div>
  <!--   한칸 -->
<!--   한칸 -->
<div class="col">
  <div class="bd-highlight align-self-center">
  <div class="card border-dark mb-3 text-center" style="width: 12rem;">
  <div class="card-header fw-bold">출석점수평균</div>
  <div class="card-body">
    <h5 class="card-title text-dark">${totalMap.totalAttend }</h5>
  </div>
</div>
</div>
  </div>
  <!--   한칸 -->
<!--   한칸 -->
<div class="col">
  <div class="bd-highlight align-self-center">
  <div class="card border-dark mb-3 text-center" style="width: 12rem;">
  <div class="card-header fw-bold">과제점수평균</div>
  <div class="card-body">
    <h5 class="card-title text-dark">${totalMap.totalAssignment }</h5>
  </div>
</div>
</div>
  </div>
  <!--   한칸 -->
</div>
</div>
<!-- </div> -->
<!-- </div> -->
<br>
<div class="table-header">
<h5>학기별 성적</h5>
</div>

	<div class="table-responsive">
					<table class="table table-bordered border-5 table-hover table-list th-line table-center text-center">
						<thead>
							<tr>
								<th rowspan="2">학년도</th>
								<th rowspan="2">학기</th>
								<th rowspan="2">신청학점</th>
								<th colspan="4">취득학점</th>
								<th colspan="2">최종성적</th>
								<th rowspan="2">학기별<br>상세조회</th>
							</tr>
							<tr>
							    <th>전공필수</th>
							    <th>전공선택</th>
							    <th>교양</th>
							    <th>계</th>
								<th>평점평균</th>
								<th>배점평균</th>

							</tr>
						</thead>
<!-- 						<tfoot> -->
<!-- 							<tr> -->
<!-- 								<td colspan="2">합계</td> -->
<!-- 								<td>86</td> -->
<!-- 								<td>11</td> -->
<!-- 								<td>59(3)</td> -->
<!-- 								<td>15</td> -->
<!-- 								<td>0</td> -->
<!-- 								<td></td> -->
<!-- 								<td></td> -->
<!-- 								<td></td> -->
<!-- 							</tr> -->
<!-- 						</tfoot> -->
						<tbody>
						<c:forEach items="${scoreList}" var="score">
							<tr>
									
										<td>${fn:substring(score.sems,0,4)}</td>
											
										<td>${fn:substring(score.sems,5,6)}</td>
										<td>${score.applyCredit }</td>
										<td>${score.majorA }</td>
										<td>${score.majorB }</td>
										<td>${score.majorC }</td>
										<td>${score.credit  }</td>
										<td>${score.crdt }</td>
										<td>${score.rct }</td>
										<td><a href="javascript:openWindowPop('${cPath }/stuScore/myScoreView.do?sems=${score.sems}', 'popup');">
											<button class="btn btn-xs btn-primary">보기</button>
											</a>
										</td>
										
									</tr>
									
							</c:forEach>
								</tbody>
					</table>
				</div>
<script type = "text/javascript">
   function openWindowPop(url, name){
        var options = 'top=100, left=650, width=800, height=815, status=no, menubar=no, toolbar=no, resizable=no';
        window.open(url, name, options);
    }
</script>

<!-- -- -->


						