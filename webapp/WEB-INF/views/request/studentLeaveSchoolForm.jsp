<%--
 학생이 휴학신청을 할 수 있는 페이지
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2022. 5. 2.   김재웅 	     최초작성
* 2022. 5. 10.  고성식	  기본 ui 작성
* Copyright (c) 2022 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<security:authentication property="principal.realUser" var="authMember"/>
<h3 class="h3-title">휴학 신청</h3><hr class="hr-title">
	<div class="col-xs-12 col-sm-12 alert text-center" style="margin-bottom:0; color: orange; background-color: #303138;"><strong>
		가사휴학,입대휴학 이외의 학적변동은 관련서류를 구비하여 교무처 또는 학과사무실로 신청해야 합니다.<br />
                                (문의처:042-222-8202)
	</strong></div>
	<br>
	<!-- Button trigger modal -->
	<h6 class="text-center"><strong> *휴학신청시 유의사항을 꼭 읽어 주세요* </strong></h6>
	<div>
		<button type="button" class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#staticBackdrop" style="float: right" >휴학신청 유의사항</button>
	</div>
	<br><br>
	
	
	<!-- 유의사항 Modal -->
	<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="staticBackdropLabel">휴학신청자 유의사항 및 필수 준수사항 안내</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	       	*재학기간 중 가사휴학은 총 4회를 초과할 수 없음.<br><br>
		*일반휴학(가사/신병/임신출산육아) 기간은 1년이며, 1회에 한하여 연장휴학할 수 있으며, 휴학절차를 이행해야 함.<br><br>
		*일반휴학(가사,신병) 기간중 군 입영이 확정된 경우는 반드시 입대휴학으로 변경 처리해야 함<br><br>
		*복학대상 학기별 입대휴학 변경신청은 입대일자가 개강 3주차 이내인 경우에 한하여 변경처리가 가능하며 경과일 이후인 경우는 가사휴학(연장휴학) 처리 또는 복학(등록완료) 후 입대휴학 신청해야 함.<br><br>
		*입대휴학 후 변동사항(귀향조치, 의가사제대, 대체복무처리, 만기제대, 재입대 예정자 포함 등) 발생 시는 반드시 교무처에 고지 하여야 하며, 미신고로 인한 불이익 발생 시 본인 책임이므로 각별히 유의해야 함.<br><br>
		*입대휴학 신청은 입대일자로 부터 7일 이내 해당일 부터 신청<br><br>
		*휴학기간 중 주소, 연락처(본인 및 보호자 전화번호)가 변경된 경우는 개인정보변경(학생포털시스템/개인정보관리) 처리 또는 교무처로 연락하여 소정절차에 의거 변경 처리해야 함.<br><br>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-primary btn-sm" data-bs-dismiss="modal">닫기</button>
	      </div>
	    </div>
	  </div>
	</div>
<!-- 	Modal 종료 -->
<table class="table table-boardered" border="1">
	<tr>
		<th>◽ 학번</th>
		<td>
			<input class="form-control"  type="text" id="userNo" name="userNo" value="${authMember.userNo }" readonly="readonly"/>
			<span></span>
		</td>
	</tr>
	<tr>
		<th>◽ 이름</th>
		<td>
			<input class="form-control"  type="text" id="userName" name="userName" value="${authMember.userName }" readonly="readonly"/>
			<span></span>
		</td>
	</tr>
	<tr>
		<th>◽ 학과</th>
		<td>
			<input class="form-control"  type="text" id="userDepartmentName" name="userDepartmentName" value="${authMember.userDepartmentName }" readonly="readonly"/>
			<span></span>
		</td>
	</tr>
	<tr>
		<th>◽ 반</th>
		<td>
			<input class="form-control"  type="text" id="stuClass" name="stuClass" value="${authMember.stuClass }" readonly="readonly"/>
			<span></span>
		</td>
	</tr>
	<tr>
		<th>◽ 학년</th>
		<td>
			<input class="form-control"  type="text" id="stuYear" name="stuYear" value="${authMember.stuYear }" readonly="readonly"/>
			<span></span>
		</td>
	</tr>
	<tr>
		<th>◽ 휴학사유</th>
			<td>
				<input class="form-check-input" type="radio" name="leaveRadio" id="A001Btn" value="A001">
				<label class="form-check-label" for="A001Btn"><strong>군휴학</strong></label>
				
				<input class="form-check-input" type="radio" name="leaveRadio" id="A002Btn" value="A002">
				<label class="form-check-label" for="A002Btn"><strong>가사휴학</strong></label>
				&nbsp;&nbsp;<strong style="color:red;">✔휴학사유를 선택해 주세요</strong>
				
			</td>
	</tr>
	<tr>
		<th>◽ 휴학신청학기</th>
		<td>
			<select id="lecSems">
				<c:forEach items="${semsdata}" var="list">
					<option value="${list}">${list}</option>
				</c:forEach>
			</select> 학기
		</td>
	</tr>
</table>
<hr>
<h6 style="text-align:center"><strong> ✔휴학 신청후 7일 이내 교무처 또는 학과 사무실로 증빙서류를 꼭 제출 바랍니다✔ </strong></h6>
<hr>
<div style="float: right">
	<input type="submit" class="btn btn-success btn-sm" onclick="requestLeaveStudent();" value="✔휴학신청">
	<input type="button" class="btn btn-secondary btn-sm" onclick="javascript:history.go(-1);" value="뒤로" >
</div>
<script>
let token = $("meta[name='_csrf']").attr("content");
let header = $("meta[name='_csrf_header']").attr("content");
var thisSems = ${sessionScope.semsVo.nextSems};

$(function(){
	$("#lecSems").val(thisSems);
});

// 이벤트 Function
var eventFunction = function(){
	$("#applyBtn").on("click", function(){
		
	});
	
}


// 신청하기
function requestLeaveStudent(){
	
	let jsonEle = {
		"userNo" : $("#userNo").val(),
		"reqSms" : $("#lecSems").val(),
		"reqRsn" : $("input[name='leaveRadio']:checked").val()
	};

	$.ajax({
		url : "${cPath}/schoolReq/requestLeaveSchoolStu",
		type : "post",
		data : JSON.stringify(jsonEle),
		contentType : "application/json",
		dataType : "json",
		beforeSend : function(xhr) {
			if (token && header) {
				xhr.setRequestHeader(header, token);
			}
		},
		success : function(resp) {
			alert(resp.resMsg);
			location.reload();

		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR);
			console.log(textStatus);
			console.log(errorThrown);
		}

	});
	
};
</script>
