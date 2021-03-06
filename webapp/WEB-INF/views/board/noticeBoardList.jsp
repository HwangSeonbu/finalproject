<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
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
	.span-attchMark{
		font-size: 15px; color:green;font-weight: bold;
	}
	
	.yet-read{color: blue;}
	.already-read{color: black;}
	.span-title:hover{
		text-decoration:underline !important;
		cursor: pointer !important;
		font-weight: bold !important;
	}
</style>
<h3 class="h3-title">공지사항</h3><hr class="hr-title">
<div id="searchDIV" style="float: right;" >
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
			<th>No</th>
			<th></th>
			<th id="title">제목</th>
			<th>첨부파일</th>
			<th>등록일시</th>
			<th></th>
			<th>관리자</th>
			<th></th>
			<th>조회</th>
		</tr>
	</thead>
		<tbody id="listBody">
<!--  		변수 설정하는 법 var="title" value="제목"   -->
			<c:set var="NBoardList" value="${paging.dataList }" />
<!-- 			EL결과가 참이면 실행. empty=list 또는 배열이 비어있거나, 문자열이 null 또는 빈문자열이면 참 반환 -->
			<c:if test="${empty NBoardList }">
				<tr>
					<td colspan="11">
						<div class='div-imageWrap' id='imageWrap'>
							<div class='div-imageInnerWrap'>
								<img alt='' src='${cPath }/resources/img/noData.jpg' style='width:100%;'/>
							</div>
							<div class='div-textInnerImage'> 조건에 맞는 데이터가<br>없습니다.</div>
						</div>
					</td>
				</tr>
			</c:if>
			<c:if test="${not empty NBoardList }">
<!-- 			목록을 입력 받아 목록의 갯수만큼 반복하는 반복문. items = collection 객체(List, Map) var = 사용할변수명-->
				<c:forEach items="${NBoardList }" var="NBoard" >
					<tr class="NBoardTr" data-notice-no="${NBoard.noticeNo }">
						<td id="notTitle">${NBoard.noticeNo }</td>
						<td></td>
						<td id="title2" data-notice-no="${NBoard.noticeNo }">
							<span class="span-title ${NBoard.noreadClass}">${NBoard.noticeTitle }</span></td>
						<td>
						<c:if test="${NBoard.attchCnt ne 0 }">
							<c:forEach begin="1" end="${NBoard.attchCnt }">
								<span class="span-attchMark"><i class="bi bi-file-earmark-fill"></i></span>
							</c:forEach>
						</c:if>
						</td>
						<td id="notTitle">${NBoard.noticeDate }</td>
						<td></td>
						<td id="notTitle" data-user-no=${NBoard.userNo }>${NBoard.userName }</td>
						<td></td>
						<td id="notTitle">${NBoard.noticeHit }</td>
					</tr>
				</c:forEach>
			</c:if>						
		</tbody>
		<tfoot>
			<tr>
				<td colspan="12">
					${paging.pagingHTMLBS }
					<security:authorize access="hasRole('ROLE_MANAGER')">
						<input type="button" class="btn btn-primary linkBtn" value="글쓰기"  
						onClick="location.href='${pageContext.request.contextPath }/board/BoardWriteForm'"
						/>
					</security:authorize>
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
	$("#listBody").on("click", ".span-title", function() {
		let noticeNo = $(this).parent("td").data("noticeNo");
		location.href="${pageContext.request.contextPath }/board/noticeBoardView.do?who="+noticeNo;
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
</body>
</html>
