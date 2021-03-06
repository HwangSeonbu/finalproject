<%--
*과제게시판 리스트
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2022. 4. 29.      황선부      최초작성
* Copyright (c) 2022 by DDIT All right reserved
 --%>
<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<style>
	th, td{
		text-align: center;
	}
	.title, #search0{
		text-align: left;
	}
	#searchD{
 		border : 1px soid black;
		width: 40%;
		margin: auto;
	}
	#paigngN{
		width: 300px;
		margin: auto;
	}
	#searchDIV{
		width: 1000px;
		margin: auto;
	}
	table{
		width: 80%;
	}
	

</style>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
		  <div class="container-fluid">
		    <div class="collapse navbar-collapse" id="navbarText">  
		      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
		            <li class="nav-item dropdown">
		          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
		            ${lecMap.LEC_NAME }
		          </a>
		          <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
		            <li><a class="dropdown-item" href="#">Action</a></li>
		            <li><a class="dropdown-item" href="#">Another action</a></li>
		            <li><hr class="dropdown-divider"></li>
		            <li><a class="dropdown-item" href="#">Something else here</a></li>
		          </ul>
		        </li>
		        <li class="nav-item">
		          <a class="nav-link" aria-current="page" href="${cPath }/lecBoard/main?lecSems=${lecSems}&lecId=${lecId}">Home</a>
		        </li>
		        <li class="nav-item">
		          <a class="nav-link" href="${cPath }/lecBoard/notice">강의공지</a>
		        </li>
		        <li class="nav-item">
		          <a class="nav-link" href="${cPath }/lecBoard/qna">질문과 답변</a>
		        </li>
		        <li class="nav-item">
		          <a class="nav-link active" href="${cPath }/homework">과제 게시판</a>
		        </li>
		      </ul>
		      <span class="navbar-text">
<!-- 		        문화인류학 -->
		      </span>
		    </div>
		  </div>
	</nav>
<br>
<h3 class="h3-title">과제 게시판</h3><hr class="hr-title">
	  <security:authorize access="hasRole('ROLE_PROFESSOR')">
		<input class="btn btn-primary" type="button" onclick="location.href='${cPath}/homework/new'" value="과제 생성하기"/>	
       </security:authorize>
<table class="table table-bordered">
	<thead class="thead thead-dark table-responsive-sm">
		<tr>
			<th width="6%">과제번호</th>
			<th>글제목</th>
			<th width="10%">마감일</th>
			<th width="10%">과제등록일</th>
			<th width="5%">조회수</th>
			<th width="10%">마감여부</th>
		</tr>
	</thead>
	<tbody id="listBody">
	<c:set value="${paging.dataList }" var="board"></c:set>
		<c:if test="${empty board }">
			<tr>
				<td colspan="6">등록된 과제가 없습니다.</td>
			</tr>
		</c:if>
		
		<c:if test="${not empty board }">
		<c:forEach items="${board }" var="hw">
			<tr class="homworkTr" data-hw-no="${hw.lechwkNo }" data-code="${hw.lechwkCode }">
				<td class="ntd">${hw.lechwkNo}</td>
				<td class="title">${hw.lechwkName }</td>
				<td>${hw.lechwkDate }</td>
				<td>${hw.registDate }</td>		
				<td>${hw.hit }</td>
				<td>${hw.lechwkCode }</td>
			</tr>
		</c:forEach>
		</c:if>
	</tbody>
	<tfoot>
		<tr>
		<td id="search0" colspan="8" >
			<div id="paigngN" class="col-md-auto">
				${paging.pagingHTMLBS }
			</div>
			<div id="searchDIV" >
				<select hidden="true" name="searchType">
<!-- 					<option value>전체</option> -->
					<option value="NAME">이름</option>
<!-- 					<option value="ADDRESS">주소</option> -->
				</select>
				<div id="searchD" class="row">
					<div class="col-8">
						<input 	type="text" class="form-control" placeholder="과제명을 검색하세요" name="searchWord" />				
					</div>
					<div class="col col-lg">
						<button type="button" class="btn btn-primary">
							검색
						</button>
					</div>
				</div>
			</div>
		</td>
		</tr>
	</tfoot>
</table>
<form id="searchForm">
	<input type="hidden" name="page" />
	<input type="hidden" name="searchType" />
	<input type="hidden" name="searchWord" />
</form>











<!-- Button trigger modal -->
<button hidden="true" id="btn" type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">
  Launch demo modal
</button>

<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel"><h6>대덕인재대학교 종합정보시스템<h6></h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
       	<h5 align="center">과제 제출기한이 지났습니다</h5>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<script type="text/javascript">
$(function(){
	$("#listBody").find('tr[data-code="CLOSED"]').find("td:last").css("color","red");
})
	$(".homworkTr").on("click", function(e){
		let code = $(this).find("td:last").text();
		  <security:authorize access="hasRole('ROLE_STUDENT')">
				if(code == "CLOSED")
					{			
					$("#btn").click();
					e.preventDefalt();
					}
	       </security:authorize>
		 let lechwkNo = $(this).data('hwNo');
		 location.href="${cPath }/homework/"+lechwkNo;
	}).css('cursor', 'pointer');
	
	$("[name=searchType]").val("${paging.simpleCondition.searchType}");
	$("[name=searchWord]").val("${simpleCondition.searchWord}");
	
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
</script>