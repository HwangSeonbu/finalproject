<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2022. 4. 26.      이유정      최초작성
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
	.span-answerWait{font-weight: bold; color:orange;}
	.span-answerComplete{font-weight: bold; color:green;}
</style>
<h3 class="h3-title">질문/답변게시판</h3><hr class="hr-title">
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
<table class="table table-hover">
	<thead class="table-active">
		<tr>
			<th>글번호</th>
			<th>학번/사번</th>
			<th id="title">제목</th>
			<th>작성자</th>
			<th>조회수</th>
			<th>작성일자</th>
		</tr>
	</thead>
		<tbody id="listBody">
			<c:set var="QBoardList" value="${paging.dataList }" />
			<c:if test="${empty QBoardList }">
				<tr>
					<td colspan="6">
						<div class='div-imageWrap' id='imageWrap'>
							<div class='div-imageInnerWrap'>
								<img alt='' src='${cPath }/resources/img/noData.jpg' style='width:100%;'/>
							</div>
							<div class='div-textInnerImage'> 조건에 맞는 데이터가<br>없습니다.</div>
						</div>
					</td>
				</tr>
			</c:if>
			<c:if test="${not empty QBoardList }">
				<c:forEach items="${QBoardList }" var="QBoard">
					<tr class="QBoardTr" data-board-no="${QBoard.boardNo }">
						<td id="notTitle">${QBoard.boardNo}</td>
						<td id="notTitle">${QBoard.userNo}</td>
						<td id="title2"><span class="${QBoard.spanClass}">${QBoard.answerMark}</span> ${QBoard.boardTitle}</td>
						<td id="notTitle">${QBoard.userName}</td>
						<td id="notTitle">${QBoard.boardHit}</td>
						<td id="notTitle">${QBoard.boardDate}</td>	
					</tr>
				</c:forEach>
			</c:if>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="12">
				${paging.pagingHTMLBS }
				<input type="button" class="btn btn-primary linkBtn" value="글쓰기"  
				onClick="location.href='${pageContext.request.contextPath }/board/qnaBoardWriteForm'"
				/>
				</td>
			</tr>
		</tfoot>
</table>
<form id="searchForm">
	<input type="hidden" name="page" />
	<input type="hidden" name="searchType" />
	<input type="hidden" name="searchWord" />
</form>
<script type="text/javascript">
	$("#listBody").on("click", ".QBoardTr", function() {
		let boardNo = $(this).data('boardNo');
		location.href="${pageContext.request.contextPath }/board/qnaBoardView.do?who="+boardNo;
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
</body>
</html>