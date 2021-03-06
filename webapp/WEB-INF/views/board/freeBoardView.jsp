<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2022. 5. 13.      이유정      최초작성
* Copyright (c) 2022 by DDIT All right reserved
 --%>
<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
	<head>
		<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	</head>
	<script>
	$(document).ready(function(){
		var formObj = $("form[name='freeForm']");
		//상세화면 뷰 
		$(document).on("click", ".linkBtn", function(){
			let href = $(this).data("href");
			if(href)
				location.href=href;
		}).css("cursor", "pointer");
		
		//삭제
			$("#deleteBtn").on("click", function(){
				formObj.attr("action", "${pageContext.request.contextPath }/board/freeBoardListView");
				formObj.attr("method", "post");
				formObj.submit();
			})
			
		//수정
		$("#updateBtn").on("click", function(){
			formObj.attr("action", "${pageContext.request.contextPath }/board/freeBoardEditView");
			formObj.attr("method", "post");
			formObj.submit();				
		})
	})
	</script>
	<style>
		.table-bordered{
			border: 1px solid #C0C0C0;
		}
		.span-likeMark{font-weight: bold; color:red;cursor: pointer;}
		.span-dislikeMark{font-weight: bold; color:grey;cursor: pointer;}
		#myRecommand{font-weight: bold; color:blue; font-size: 15px;}
	</style>
	<form name="freeForm" role="form" method="post">
		<input type="hidden" id="boardNo" name="boardNo" value="${fBoard.boardNo }" />
		<security:csrfInput/>
	<table class="table table-bordered">
	 <colgroup>
            <col width="15%">
            <col width="35%">
            <col width="15%">
            <col width="*">
       </colgroup>
		<tr>
			<th class="table-active">제목</th>
			<td>${fBoard.boardTitle }</td>
			<th class="table-active">조회</th>
			<td>${fBoard.boardHit }</td>
		</tr>
		<tr>
			<th class="table-active">작성자</th>
			<td>${fBoard.userName }</td>
			<th class="table-active">등록일시</th>
			<td>${fBoard.boardDate }</td>
		</tr>
		<tr>
			<th class="table-active">추천수</th>
			<td><span class="span-bolike span-likeMark" data-bolike-yn="Y"><i class="bi bi-hand-thumbs-up-fill"></i><span id="currLike">${fBoard.boardLike }</span></span>
				&nbsp;&nbsp;&nbsp;<span id="span-like"></span>
			</td>
			<th class="table-active">비추천수</th>
			<td><span class="span-bolike span-dislikeMark" data-bolike-yn="N"><i class="bi bi-hand-thumbs-down-fill"></i><span id="currDislike">${fBoard.boardDislike }</span></span>
				&nbsp;&nbsp;&nbsp;<span id="span-Dislike"></span>
			</td>
		</tr>
		<tr>
			<td colspan="4" id="boardContent" height="500">${fBoard.boardContent }</td>
		</tr>
	</table>
		<security:authentication property="principal.realUser" var="authMember"/>
		<c:if test="${authMember.userNo eq fBoard.userNo }">
		<button type="submit"  id="updateBtn" class="btn btn-primary linkBtn">수정</button>
		<button type="submit"  id="deleteBtn" class="btn btn-primary linkBtn">삭제</button>
		</c:if>
		<c:if test="${authMember.userNo ne fBoard.userNo }">
			<security:authorize access="hasRole('ROLE_MANAGER')">
				<button type="submit"  id="deleteBtn" class="btn btn-primary linkBtn">삭제</button>
			</security:authorize>
		</c:if>
		<input type="button" class="btn btn-primary linkBtn"
				data-href="<c:url value='/board/freeBoardList.do'/>"
				value="목록으로"
			/>  
</form>

		<!-- 댓글 Form -->
<div class="card my-4">
	<h5 class="card-header">댓글</h5>
		<div class="card-body">
		 <div class="container">
        	<form name="replyInsertForm">
        	<security:csrfInput/>
           		 <div class="input-group">
		               <input type="hidden" name="boardNo" value="${fBoard.boardNo}"/>
		               <input type="hidden" name="userName" value="${fBoard.userName}"/>
		               <security:authentication property="principal.realUser" var="authMember"/>
 		               <input type="hidden" name="userNo" value="${authMember.userNo}"/>  
		               <input type="text" class="form-control" id="replyContent" name="replyContent" placeholder="내용을 입력하세요.">
		               <span class="input-group-btn">
		               <button class="btn btn-default" type="button" name="replyInsertBtn">등록</button>
		               </span>
              		</div>
       		 </form>
    	</div>
    	<br>
    <div class="container">
        <div class="replyList"></div>
    </div>
	  </div>
</div>
<script>
let myRecommandMark = "<span id='myRecommand'>★</span>";

let currLike = $("#currLike");
let currDislike = $("#currDislike");

let myRecommand = "${fBoard.myRecommand}";
let spanLike = $("#span-like");
let spanDisike = $("#span-Dislike");

$("#"+myRecommand).html(myRecommandMark);


$(".span-bolike").on("click", function(){
	let bolikeYn = $(this).data("bolikeYn");
	let boardNo = $("input[name=boardNo]").val();
	
	$.ajax({
		url : "${cPath}/board/boLikeMarkUp.do",
		method : "get",
		data : {bolikeYn:bolikeYn, boardNo:boardNo},
		dataType : "json",
		success : function(resp) {
			let bolikeVo = resp.bolikeVo;
			var resultNo = bolikeVo.resultNo;
			alert(bolikeVo.resultMsg);
			let currLikeCnt = Number(currLike.text());
			let currDislikeCnt = Number(currDislike.text());
			switch(resultNo){
				case 1: currLike.text((currLikeCnt+1)); spanLike.html(myRecommandMark); break;
				case 2: currDislike.text((currDislikeCnt+1)); spanDisike.html(myRecommandMark); break;
				case 5: currLike.text((currLikeCnt+1)); spanLike.html(myRecommandMark);
					currDislike.text((currDislikeCnt-1)); spanDisike.text("");
					break;
				case 6: currLike.text((currLikeCnt-1)); spanLike.text(""); 
					currDislike.text((currDislikeCnt+1)); spanDisike.html(myRecommandMark);
					break;
				default: break;
			};
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR);
			console.log(textStatus);
			console.log(errorThrown);
		}
	});
	
});
</script>	
	
	
<%@ include file="reply.jsp" %>
