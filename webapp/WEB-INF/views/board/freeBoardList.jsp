<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2022. 5. 13.      이유정      최초작성
* Copyright (c) 2022 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<style>
	.pagination{
		justify-content: center;
	}
	#title{
		width: 800px;
		text-align: center;
	}
	.table-active{
		text-align: center;
	}
	#title2{
		width: 800px;
	}
	#notTitle{
		text-align: center;
	}
	.span-replyCnt{
		font-weight: bold; color:orange;
	}
	.span-likeMark{font-weight: bold; color:red;}
	.span-dislikeMark{font-weight: bold; color:grey;}
	
	.yet-read{color: blue;}
	.already-read{color: black;}
	.span-title:hover{
		text-decoration:underline !important;
		cursor: pointer !important;
		font-weight: bold !important;
	}
</style>
<h3 class="h3-title">자유게시판</h3><hr class="hr-title">
<div id="searchDIV" style="float: right;">
	<select name="searchType">
		<option value>전체</option>
		<option value="NAME">제목</option>
		<option value="USERNAME">작성자</option>
	</select>
	<input type="text" style="width: 330px;" name="searchWord" />
	<input type="button" value="검색" />
</div>
<br><br>
<table class="table">
	<thead class="table-active">
		<tr>
			<th>글번호</th>
			<th>학번/사번</th>
			<th id="title">제목</th>
			<th>작성자</th>
			<th>조회수</th>
			<th>추천수</th>
			<th>비추천수</th>
			<th>작성일자</th>
		</tr>
	</thead>
		<tbody id="listBody">
			<c:set var="FBoardList" value="${paging.dataList }" />
			<c:if test="${empty FBoardList }">
				<tr>
					<td colspan="7">조건에 맞는 회원이 없음.</td>
				</tr>
			</c:if>
			<c:if test="${not empty FBoardList }">
				<c:forEach items="${FBoardList }" var="FBoard">
					<tr class="FBoardTr">
						<td id="notTitle">${FBoard.boardNo}</td>
						<td id="notTitle">${FBoard.userNo}</td>
						<td id="title2" data-board-no="${FBoard.boardNo }">
							<span class="span-title ${FBoard.boreadClass}">${FBoard.boardTitle}</span>
							<span class="span-title span-replyCnt">[${FBoard.replyCnt}]</span>
						</td>
						<td id="notTitle">${FBoard.userName}</td>
						<td id="notTitle">${FBoard.boardHit}</td>
						<td id="notTitle"><span class="span-likeMark"><i class="bi bi-hand-thumbs-up-fill"></i>${FBoard.boardLike}</span></td>
						<td id="notTitle"><span class="span-dislikeMark"><i class="bi bi-hand-thumbs-down-fill"></i>${FBoard.boardDislike}</span></td>
						<td id="notTitle">${FBoard.boardDate}</td>	
					</tr>
				</c:forEach>
			</c:if>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="12">
				${paging.pagingHTMLBS }
		</td>
			</tr>
		</tfoot>
</table>
<input type="button" class="btn btn-primary linkBtn" value="글쓰기"  
onClick="location.href='${pageContext.request.contextPath }/board/freeBoardWriteForm'"
/>
<form id="searchForm">
	<input type="hidden" name="page" />
	<input type="hidden" name="searchType" />
	<input type="hidden" name="searchWord" />
</form>
<script type="text/javascript">
	$("#listBody").on("click", ".span-title", function() {
		let boardNo = $(this).parent("td").data('boardNo');
		location.href="${pageContext.request.contextPath }/board/freeBoardView.do?who="+boardNo;
	});
	
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






