<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2022. 5. 11.      이유정      최초작성
* Copyright (c) 2022 by DDIT All right reserved
 --%>
<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<script type="text/javascript" src="${cPath }/resources/js/ckeditor/ckeditor.js"></script>
	<head>
		<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	</head>
	<script>
	$(document).ready(function(){
		var formObj = $("form[name='qnaForm']");
		//상세화면 뷰 
		$(document).on("click", ".linkBtn", function(){
			let href = $(this).data("href");
			if(href)
				location.href=href;
		}).css("cursor", "pointer");
		
		//삭제
			$("#deleteBtn").on("click", function(){
				formObj.attr("action", "${pageContext.request.contextPath }/board/qnaBoardListView");
				formObj.attr("method", "post");
				formObj.submit();
			})
			
		//수정
		$("#updateBtn").on("click", function(){
			formObj.attr("action", "${pageContext.request.contextPath }/board/qnaBoardEditView");
			formObj.attr("method", "post");
			formObj.submit();				
		})
	})
	</script>
	<style>
		.table-bordered{
			border: 1px solid #C0C0C0;
		}
	</style>
	<form name="qnaForm" role="form" method="post">
		<input type="hidden" id="boardNo" name="boardNo" value="${qBoard.boardNo }" />
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
			<td>${qBoard.boardTitle }</td>
			<th class="table-active">조회</th>
			<td>${qBoard.boardHit }</td>
		</tr>
		<tr>
			<th class="table-active">작성자</th>
			<td>${qBoard.userName }</td>
			<th class="table-active">등록일시</th>
			<td>${qBoard.boardDate }</td>
		</tr>
		<tr>
			<td colspan="4" id="boardContent" height="500">${qBoard.boardContent }</td>
		</tr>
	</table>
		<security:authentication property="principal.realUser" var="authMember"/>
		<c:if test="${authMember.userNo eq qBoard.userNo}">
		<button type="submit"  id="updateBtn" class="btn btn-primary linkBtn">수정</button>
		<button type="submit"  id="deleteBtn" class="btn btn-primary linkBtn">삭제</button>
		</c:if>
		<input type="button" class="btn btn-primary linkBtn"
				data-href="<c:url value='/board/qnaBoardList.do'/>"
				value="목록으로"
			/>  
</form>
		<!-- 댓글 Form -->
<div class="card my-4">
	<h5 class="card-header">댓글</h5>
		<div class="card-body">
		 <div class="container">
	<security:authorize access="hasRole('ROLE_MANAGER')">			
        	<form name="replyInsertForm">
        	<security:csrfInput/>
           		 <div class="input-group">
		               <input type="hidden" name="boardNo" value="${qBoard.boardNo}"/>
		               <input type="hidden" name="userName" value="${qBoard.userName}"/>
		               <security:authentication property="principal.realUser" var="authMember"/>
 		               <input type="hidden" name="userNo" value="${authMember.userNo}"/>  
		               <input type="text" class="form-control" id="replyContent" name="replyContent" placeholder="내용을 입력하세요.">
		               <span class="input-group-btn">
		               <button class="btn btn-default" type="button" name="replyInsertBtn">등록</button>
		               </span>
              		</div>
       		 </form>
        </security:authorize>
    	</div>
    	<br>
    <div class="container">
        <div class="replyList"></div>
    </div>
	  </div>
</div>
	
<%@ include file="reply.jsp" %>

 
