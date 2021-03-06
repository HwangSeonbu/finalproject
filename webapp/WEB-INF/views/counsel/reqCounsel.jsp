<%--학생회원이 교수에게 상담을 신청하는 페이지
* [[개정이력(Modification Information)]]
* 수정일                 수정자           수정내용
* ----------  ---------  -----------------
* 2022. 4. 28.   황선부       최초작성
* Copyright (c) 2022 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>  
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<h3 class="h3-title">상담 이력 조회</h3><hr class="hr-title">
	<button id="regigBtn" class="btn btn-info" data-bs-toggle="modal" data-bs-target="#registerModal">상담신청하기</button>
	<table class="table table-striped">
	
		<thead class="thead-dark">
			<tr>
				<th>일련번호</th>
				<th>예정상담시간</th>
				<th>예정상담장소</th>
				<th>학과</th>
				<th>희망교수명</th>
				<th>상담접수일</th>
				<th>상담일</th>
			</tr>
		</thead>
		<tbody>
			<c:set var="counselList" value="${paging.dataList }" />
			<c:if test="${empty counselList }">
				<tr>
					<td colspan="8">조건에 맞는 회원이 없음.</td>
				</tr>
			</c:if>
			<c:if test="${not empty counselList}">
				<c:forEach items="${counselList}" var="counsel">
					<tr class="counselTr" data-mem-id="${counsel.cnslId }">				
						<td>${counsel.rnum }</td>
<%-- 						<td>${counsel.sems }</td> --%>
						<c:if test="${empty counsel.cnslDay }">
						<td>날짜 미정</td>
						</c:if>
						<c:if test="${not empty counsel.cnslDay }">
							<td>${counsel.cnslDay }</td>						
						</c:if>						
						<c:if test="${empty counsel.cnslDay }">
							<td>장소 미정</td>
						</c:if>
						<c:if test="${not empty counsel.cnslDay }">
							<td>${counsel.cnslLo}</td>						
						</c:if>						
						<td>${counsel.deptName}</td>
						<td>${counsel.userName }</td>
						<td>${counsel.cnslDate }</td>
						<td>${counsel.dyDate }</td>
					</tr>
				</c:forEach>
			</c:if>	
		</tbody>
		<tfoot>
			<tr>
			<td colspan="8">
				${paging.pagingHTMLBS }
			</td>
			</tr>
		</tfoot>
	</table>
	<form id="searchForm">
		<input type="hidden" name="page" />
	</form> 

		<!-- Modal -->
		<div class="modal" id="registerModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
		  <div class="modal-dialog modal-dialog-scrollable">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLabel">상담신청서</h5>
		        <button id="but1" type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body" class="card">
		        <form id="registerForm" action="${pageContext.request.contextPath }/reqCounsel/register" method="post">     
		        	상담 희망 교수<div id="getProName">	
		        	<security:csrfInput/>        	
			        	<select name="deptId" class="form-select" aria-label="Default select example">
			        			<option value="">희망학과</option>
				        	<c:forEach items="${departList}" var="depart">
				        		<option value="${depart.deptId}">${depart.deptName}</option>
				        	</c:forEach>
			        	</select>
			        	<select name="proNo" id="proNo" class="form-select" aria-label="Default select example">
			        		
			        	</select>        	
		        	</div>
		        	<br>
		        <table class="table table-hover" >
		        	<tr>
		        		<td>
		        		<nav class="navbar navbar-light" style="background-color: #e3f2fd;">
						  학업
						</nav>
				        	1.자신의 전공에 대한 만족도는 어떠합니까?<br>
				        		<div class="form-check form-check-inline">
								  <input class="form-check-input" type="radio" name="r1" id="inlineRadio1" value="A21">
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
		        		<td>
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
		        		<td>
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
		        		<td>
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
		        		<td>
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
		        		<td>
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
						<td>
		        		<nav class="navbar navbar-light" style="background-color: #e3f2fd;">
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
						<td>
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
						<td>
							9.상담내용 및 특이사항(필수아님)<br>
							<textarea class="form-control" name="qaLong" aria-label="With textarea" style="height: 100px"></textarea>       						
						</td>
					</tr>
			
		        </table>
		        </form>
			
		      </div>
		      <div class="modal-footer">
		        <button type="button" id="submitBtn" class="btn btn-primary">상담신청하기</button>
		        <button type="button" id="exitBtn" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
		      </div>
		    </div>
		  </div>
		</div>


<script type="text/javascript">
// 	$(".memberTr").on("click", function(){
// 		 let memId = $(this).data('memId');
// 		 location.href="${pageContext.request.contextPath }/member/memberView.do?who="+memId;
// 	}).css('cursor', 'pointer');
// 	<c:if test="${not empty message }">
// 	alert("${message}");
// 	</c:if>
	
	let registerForm = $("#registerForm");
	const searchForm = $("#searchForm");
	const searchDIV = $("#searchDIV").on("click", "[type=button]", function(){
		let inputs = searchDIV.find(":input[name]");
		$(inputs).each(function(index, ipt){
			let name = this.name;
			let value = $(this).val();
			searchForm.find("[name="+name+"]").val(value);
		});
		searchForm.submit();
	});
	$(".pagination").on("click", "a", function(){
		let page = $(this).data("page");
		searchForm.find("[name=page]").val(page);
		searchForm.submit();
	});

	$("#submitBtn").on("click",function(){
		
		if($("input:radio[name=r1]:checked").length < 1){
		    alert("설문항목에 선택해주세요.");
		    event.preventDefault();
		    return false;
		}
		if($("input:radio[name=r2]:checked").length < 1){
		    alert("설문항목에 선택해주세요.");
		    event.preventDefault();
		    return false;
		}
		if($("input:radio[name=r3]:checked").length < 1){
		    alert("설문항목에 선택해주세요.");
		    event.preventDefault();
		    return false;
		}

		if($("input:radio[name=r4]:checked").length < 1){
		    alert("설문항목에 선택해주세요.");
		    event.preventDefault();
		    return false;
		}
		if($("input:radio[name=r5]:checked").length < 1){
		    alert("설문항목에 선택해주세요.");
		    event.preventDefault();
		    return false;
		}
		if($("input:radio[name=r6]:checked").length < 1){
		    alert("설문항목에 선택해주세요.");
		    event.preventDefault();
		    return false;
		}
		if($("input:radio[name=r7]:checked").length < 1){
		    alert("설문항목에 선택해주세요.");
		    event.preventDefault();
		    return false;
		}
		if($("input:radio[name=r8]:checked").length < 1){
		    alert("설문항목에 선택해주세요.");
		    event.preventDefault();
		    return false;
		}
		registerForm.submit();
	})
	$("#exitBtn").on("click",function(){
		$("#registerModal").hide();
		registerForm[0].reset();
	})
	let proTag =$("[name=deptId]").on("change",function(){
			let selectedDeptId = $(this).val();
			
			$.ajax({
				url : "${cPath}/reqCounsel/getProList.do",
				data : {
					deptId:selectedDeptId
				},
				dataType : "json",
				success : function(resp) {
					$("[name=proNo]").empty();
					console.log(resp)
					let proList = resp;
					let options = [];
					options.push($("<option>").attr("value","").text("교수명"));
					$(proList).each(function(index, pro){
						let option = $("<option>").attr("value", pro.proNo)
												.text(pro.userName)
						options.push(option);
					})
					$("[name=proNo]").append(options);					
				},
				error : function(jqXHR, textStatus, errorThrown) {
					console.log(jqXHR);
					console.log(textStatus);
					console.log(errorThrown);
				}
			});
	});

	

</script>