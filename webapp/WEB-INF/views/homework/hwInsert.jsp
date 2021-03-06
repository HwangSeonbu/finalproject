<%--
* 과제 출제 양식 view
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2022. 5. 24.      황선부      최초작성
* Copyright (c) 2022 by DDIT All right reserved
 --%>
<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<script type="text/javascript" src="${cPath}/resources/js/fullckeditor/ckeditor.js"></script>
<style>
#col1{
	
	padding: 10px;
	display: inline-block;
	
}
.sp{

	font-size:23px;
/* 	font-weight: bold; */
}
 .errorMessage{ 
 	display:none;		
} 
</style>
<h3 class="h3-title">과제 출제하기</h3>
<hr class="hr-title">
<form:form action="${cPath }/homework/new/insert" method="post" modelAttribute="homework" 
			enctype="multipart/form-data">

	<div class="row">
	<div id="col1" class="col-7" border="1">
	<table>
		<tr>	
			<td><span class="sp">과제명</span>
				<form:input path="lechwkName" class="form-control" />
				<form:errors path="lechwkName" class="error" cssClass="errorMessage" element="span" /></td>
		</tr>
		<tr>
		
			<td><span class="sp">과제내용</span>
<%-- 			<form:input path="lechwkCont" class="form-control" /> --%>
				<form:textarea path="lechwkCont"/>
				<form:errors path="lechwkCont" class="error" cssClass="errorMessage" element="span" /></td>
		</tr>
		
	</table>
	</div>
	<div class="col-sm-4" border="1">
		<table >
		<tr>
			<td><span class="sp">마감일</span>
			<form:input type="date" path="lechwkDate" class="form-control" />
			<form:errors path="lechwkDate" class="error" cssClass="errorMessage" element="span" /></td>
		</tr>
		<tr>
			
			<td>
				<span class="sp">첨부파일</span>
				<input type="file" name="boFile" class="form-control"/>			
			</td>
		</tr>
	</table>
	<hr>
	<br>
	<h5>Rubrics</h5>
	루브릭(평가기준표)으로 채점 루브릭을 만들어 과제 채점에 활용할 수 있습니다. 학생의 과제 조회시 선택한 루브릭을 표시합니다. 
	(최대 다섯개까지의 채점기준을 만들 수 있습니다.)
		<table id="evaTb" >
			<tr>	
				<th>#</th>
				<th>평가기준</th>
				<th>배점</th>
			</tr>	
			<tr id="sample" class="evaTr">
				<td class="evaTd">1</td>
				<td><input class="form-control" type="text" name="evaList[0].evaStd" required/></td>
				<td><input class="form-control evaScore" type="text" name="evaList[0].evaScore" required/></td>
			</tr>			
					
		</table>
				<button  id="evaBtn" type="button" class="btn btn-secondary">+</button>
				<button  id="minusBtn" type="button" class="btn btn-secondary">-</button>
	<hr>
	<h3>총점수 : <span id="score"></span></h3>
	<br>
	<div class="d-grid gap-2 col-6 mx-auto">
  <button type="submit" class="btn btn-primary" type="button">등록하기</button>
	</div>
	
	
	</div>
	</div>
</form:form>
<script>
$(document).ready(function(){
	
    var name = $(".errorMessage").html();    
    if (typeof name != 'undefined'){
    	if ("" != name || null != name){
        	alert(name);	
        }	
    }
    
     
}); // end ready()

let sample = $("#sample")
let evaTb =$("#evaTb")

$(document).on('change','.evaScore',function(){
	
	let sum = 0;
	let value = 0;
	let arr = evaTb.find(".evaScore")
	console.log(arr)
	let num = arr.length
	$(arr).each(function(idx){
		value = parseInt($(this).val())
		if(isNaN(value)){
			value=0;
			console.log(value)
		}
		sum = parseInt(sum)+value;
		
	}) 
	$("#score").text(sum);
})


$("#evaBtn").on("click",function(){
	let arr = evaTb.find("tr.evaTr")
	let num = arr.length
	
	if(num>=5){
		alert("최대 평가기준은 5개 입니다.");
		return false;
	}
	let newTr = sample.clone();
	newTr.prop("id","eva_"+num)
	
	console.log(newTr.find("input"))
	let inputs = newTr.find("input")
	inputs.val("");
	
	let evaTd = newTr.find(".evaTd")
	evaTd.html(num+1)
	
	$.each(inputs, function(ipx,input){
		let name = $(input).attr("name");
		let replace = name.replace(/\d+/,num)
		$(input).attr("name",replace)
		
	})
	$("#evaTb").append(newTr);
})
$("#minusBtn").on("click",function(){
	let arr = evaTb.find("tr.evaTr")
	let num = arr.length
	if(num==1){
		alert("최소 평가기준은 1개입니다.")
		return false;
	}
	$("#evaTb tr").eq(num).remove();
	num = num-1
	
	let sum = 0;
	let value = 0;
	$(".evaScore").each(function(idx){
		value = parseInt($(this).val())
		if(isNaN(value)){
			value=0;
			console.log(value)
		}
		sum = parseInt(sum)+value;
		
	}) 
	$("#score").text(sum);
	
})


CKEDITOR.replace('lechwkCont',{height: 800 
// 	,filebrowserImageUploadUrl : "${cPath}/board/image?type=image"
});
</script>