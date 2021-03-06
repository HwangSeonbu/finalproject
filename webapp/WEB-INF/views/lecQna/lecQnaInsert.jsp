<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2022. 5. 20.      작성자명      최초작성
* Copyright (c) 2022 by DDIT All right reserved
 --%>
<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<script type="text/javascript" src="${cPath}/resources/js/fullckeditor/ckeditor.js"></script>
<style>
#buttonDiv{
	margin : 5px auto;
	width : 300px;
}
th{
	width: 200px;
	text-align: left;
	margin: 20px
}
#t,#c{
	font-size : large;
	color : red;
}
 .errorMessage{ 
 	display:none;		
} 
</style>
<h3 class="h3-title">강의 qna 글 등록</h3><hr class="hr-title">
<hr>

<form:form modelAttribute="board" method="post" enctype="multipart/form-data" class="border">
	<form:hidden path="lecboNo"/>
	<table class="table">
		<tr>
			<th>글제목</th>
			<td><form:input path="lecboTitle" class="form-control"  />
				<form:errors id="t" path="lecboTitle" class="error " cssClass="errorMessage" element="span" /></td>
		</tr>
		<tr>
			<th>글내용</th>
			<td><form:textarea path="lecboContent" class="form-control" />
				<form:errors id="c"  path="lecboContent" class="error" cssClass="errorMessage" element="span" /></td>
		</tr>
		<tr>
			<th>첨부파일 등록</th>
			<td>
				<input type="file" name="boFile" class="form-control"/>			
			</td>
		</tr>
		<tr>
			
			<td colspan="2">
				<div id=buttonDiv>
					<form:button type="submit" class="btn btn-success">저장</form:button>
					<form:button type="reset" class="btn btn-secondary linkBtn"
					data-href="${cPath }/lecBoard/qna">목록으로</form:button>
				</div>
			</td>
		</tr>
	</table>
</form:form>
<script  type="text/javascript">
$(document).ready(function(){
	
    var name = $(".errorMessage").html();
//     console.log("=========== ", typeof name);
//     console.log("=========== ", name);
//     console.log("=========== ", typeof name != "undefined");
    
    if (typeof name != 'undefined'){
    	if ("" != name || null != name){
//     		var newName = name.substring(0,name.length-1)
        	alert(name);	
        }	
    }
    
     
}); // end ready()
CKEDITOR.replace('lecboContent',{height: 800 
// 	,filebrowserImageUploadUrl : "${cPath}/board/image?type=image"
});
</script>