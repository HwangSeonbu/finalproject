<%--qna, 댓글 페이지
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2022. 5. 20.     황선부      최초작성
* Copyright (c) 2022 by DDIT All right reserved
 --%>
<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<script type="text/javascript" src="${cPath }/resources/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${cPath }/resources/js/jquery.form.min.js"></script>
<script type="text/javascript" src="${cPath }/resources/js/simplePagination/jquery.simplePagination.js"></script>
<link type="text/css" rel="stylesheet" href="${cPath }/resources/js/simplePagination/simplePagination.css"/>
<style>
.table{
	width: 1200px;
}
#title{
	font-weight: bold;
	font-size: x-large;
	text-align: center;
}
.column{
	font-weight: bold;
	text-align: center;
}
table td:first-child{
	width: 150px;
}
#deleteForm{
	display: inline;
}
.form-floating{
	width: 1000px;
	display: inline-block;
}
#replyta{
	width: 1200px;
}
#ta{
	width: 1100px;
}
/* #replyBtn{ */
/* 	display: inline-block; */
/* } */
/* table td:second-child{ */
/* 	text-align: left; */
/* } */
</style>
<h3 class="h3-title">강의 질의 응답</h3><hr class="hr-title">

<nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item"><a href="#">home</a></li>
    <li class="breadcrumb-item"><a href="${cPath}/lecBoard/qna">목록</a></li>
    <li class="breadcrumb-item active" aria-current="page">새글</li>
  </ol>
</nav>

    <hr>
  <table class="table table-bordered">
  	<thead class="table-light">
  		<tr>
  			<td id="title" colspan="2">${board.lecboTitle}</td>
  		</tr>
  	</thead>
  	<tbody>
  		<tr>
  			<td class="column">
  			작성자
  			</td>
 	
  			<td>
  			<c:if test="${not empty board.stuName }">
  			${board.stuName }
  			</c:if>
  			<c:if test="${not empty board.proName }">
  			${board.proName }
  			</c:if>
  			</td>
  		</tr>
  		<tr>
  			<td class="column">
  			등록일
  			</td>
  			<td>
  			${board.lecboDate }
  			</td>
  		</tr>
  		<tr>
  			<td class="column">
  			조회수
  			</td>
  			<td>
  			${board.lecboHit }
  			</td>
  		</tr>
  		<tr>
  			<td class="column">
  			첨부파일
  			</td>
  			<td>
  				<c:set value="${board.attach }" var="attach"></c:set>

		  			<c:url value="/lecBoard/qna/${board.lecboNo }/attach/${attach.attchNo }"  var="downloadURL"></c:url>
					<a href="${downloadURL }">${attach.attchFname }</a>  		
  			</td>
  		</tr>
  		<tr>
  			<td colspan="2">
  			${board.lecboContent }
  			</td>
  		</tr>
  	</tbody>
  	
  	<tfoot>
  	

  	
  	</tfoot>
  </table>
  <hr>
  <button id="list">목록</button>
  <c:if test="${not empty board.stuNo }">
  <security:authentication property="principal" var="user" />
  	<c:set value="${board.stuNo }" var="userNo2"/>
  </c:if>
  <c:if test="${not empty board.proNo }">
  	<c:set value="${board.proNo }" var="userNo2"/>  
  </c:if>
  <c:if test="${userNo eq userNo2  }">
	  <button id="edit" onclick="location.href='${cPath}/lecBoard/qna/${board.lecboNo}/form'">수정</button>
<!-- 	  <button id="delete" >삭제</button> -->
	  <form id="deleteForm" method="post" action="${cPath}/lecBoard/qna/${board.lecboNo}">
		  <security:csrfInput/> 	
	  	<input type="hidden" name="_method" value="delete"/>
	  	<input type="hidden" id="lecboNo" name="lecboNo" value="${board.lecboNo }"/>
	  	<input type="submit" value="삭제"/>  
	  </form>
  </c:if>
  <hr>

  <table id="replyTable" class="table">
		  	<thead>
		  	</thead>
		  	<tbody id="tbody" class="tbody">

		  	</tbody>
  </table>
<div class="pagination"></div>
  
 	<form id="replyForm" action="${cPath}/lecBoard/qna/reply/new" method="post">
	  <security:csrfInput/> 
 	<div class="form-floating">
 	<table id="replyta">
 		<tr>
	 		<td id="ta">
	 		<textarea id="txa" name="replyContent" class="form-control" placeholder="댓글을 등록하세요"></textarea>	  
	 		<td><button id="replyBtn" type="button" class="btn btn-primary">등록</button></td>
 		</tr>
 	</table>  
	</div>
	
	  <c:if test="${user.realUser.memRole eq 'ROLE_STUDENT'}">
	  	<input id="stuNo" type="hidden" name="stuNo" value="${user.realUser.userNo}"/>
	  </c:if>
	  <c:if test="${user.realUser.memRole eq 'ROLE_PROFESSOR'}">
	  	<input id="proNo" type="hidden" name="proNo" value="${user.realUser.userNo}"/>
	  </c:if>
	  	<input id="lecboNo" type="hidden" name="lecboNo" value="${board.lecboNo }"/>
 	</form>
  <script type="text/javascript">  
  $("#list").on("click",function(){
	  location.href="${cPath}/lecBoard/qna";
  })
 let ruserNo = ${user.realUser.userNo};
  let boNo = $("#lecboNo").val();
  let tbody = $("#tbody");
  function ajaxView(){
	  $.ajax({
					url : "${cPath}/lecBoard/qna/reply",
					method : "post",
					data : {
						"boNo" : boNo
					},
					beforeSend: function (jqXHR, settings) {
				           var header = $("meta[name='_csrf_header']").attr("content");
				           var token = $("meta[name='_csrf']").attr("content");
				           jqXHR.setRequestHeader(header, token);
					},
					dataType : "json",
					success : function(resp) {
						tbody.empty();
						console.log(resp.replyBoard)
						let replyList = resp.replyBoard;
						let trTags = [];
						if(replyList && replyList.length>0){
							$.each(replyList, function(idx, reply){
								let userName="";
								let userNo="";
								let trColor="default";
								if(reply.stuName!=null)
									{userName=reply.stuName;
									userNo=reply.stuNo;
			
									}
								if(reply.proName!=null)
									{userName=reply.proName
									userNo=reply.proNo;
									trColor="#C8D7FF";
									}
								let htmlTag="";
								if(ruserNo==userNo){
									htmlTag="<input type='button' class='deleteBtn' data-reply-no='"+reply.replyNo+"' value='삭제'/>";
								}
								
								let trTag = $("<tr>").append(
														$("<td>").html(userName)
														,$("<td>").html(reply.replyContent)
														,$("<td>").html(reply.replyDate)
														,$("<td>").html(htmlTag)
													).data("userName",userName)
													.css('background',trColor);
								trTags.push(trTag);
							});
						}else{
							let trTag = $("<tr>").html(
									$("<td>").attr("colspan", "3")
											 .html("댓글이 없습니다.")
								);
							trTags.push(trTag);
						}
					
						tbody.append(trTags);
								console.log(trTags)
					},
					error : function(jqXHR, textStatus, errorThrown) {
						console.log(jqXHR);
						console.log(textStatus);
						console.log(errorThrown);
					}
				});
	  
  }
  //처음 view
  ajaxView();
  	
  	//reply insert
  $("#replyBtn").on("click",function(){

 	 let formData = $("#replyForm").serialize();
	  
  		$.ajax({
			url : "${cPath}/lecBoard/qna/reply/new",
			method : "post",
			data : formData,
				
			dataType : "json",
			success : function(resp) {
				ajaxView();
		  		$("#txa").val("");
				
			},
			beforeSend: function (jqXHR, settings) {
		           var header = $("meta[name='_csrf_header']").attr("content");
		           var token = $("meta[name='_csrf']").attr("content");
		           jqXHR.setRequestHeader(header, token);
			},
			error : function(jqXHR, textStatus, errorThrown) {
				console.log(jqXHR);
				console.log(textStatus);
				console.log(errorThrown);
			}
		});
  	})
//   /lecBoard/qna/reply/delete
	$("#tbody").on("click",".deleteBtn",function(){
		var replyNo = $(this).data("replyNo")
		$.ajax({
			url : "${cPath}/lecBoard/qna/reply/delete",
			method : "get",
			data : {
				replyNo:replyNo
			},
			dataType : "json",
			success : function(resp) {
				ajaxView();
				alert(resp.message);
					
			},
			error : function(jqXHR, textStatus, errorThrown) {
				console.log(jqXHR);
				console.log(textStatus);
				console.log(errorThrown);
			}
		});
		
	})






// 	var items = $("#table tr");
// 	var numItems = items.length;
// 	var perPage = 2;
// 	items.slice(perPage).hide();
// 	if(numItems != 0){
// 		$(".pagination").pagination({
// 			items: numItems,
// 			itemsOnPage: perPage,
// 			cssStyle: "light-theme",
// 			onPageClick: function(pageNumber) { 
// 				var showFrom = perPage * (pageNumber - 1);
// 				var showTo = showFrom + perPage;
// 				items.hide().slice(showFrom, showTo).show();
// 			}
// 		});
// 	}

  
  
  
  
  
  
  
  
  </script>