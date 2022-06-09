<%--
* [[개정이력(Modification Information)]]
* 수정일                 		수정자     			 수정내용
* ----------  		---------  	-----------------
* 2022. 5. 3.		고성식    		 최초작성
* Copyright (c) 2022 by DDIT All right reserved
 --%>
<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="${cPath }/resources/js/jspdf/html2canvas.js"></script>
<script src="${cPath }/resources/js/jspdf/jspdf.min.js"></script>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<div id="contAreaBox">
		<div class="panel">
			<div class="panel-body">
				<h3 class="h3-title">신입생등록</h3><hr class="hr-title">
				<a href="${cPath }/resources/excelTemplate/신입생일괄등록파일양식.xlsx" download="" class="btn btn-primary btn-sm"
					style="float: right; max-width: 20%;">양식파일다운로드</a>
				<br>
				<br>
				<div class="card mb-3 " style="max-width: 100%; text-align: center;">
					<div class="col-xs-12 col-sm-12 alert text-center"
						style="margin-bottom: 0; color: orange; background-color: #303138; text-align: center;"><strong>양식파일을 다운로드 하시고
						파일내에 있는 모든 항목들을 채워서 업로드하셔야 정상적으로 등록됩니다.<br>
						학생 등록시 학번은 자동 부여 됩니다!</strong></div>
				</div>
			</div>
		</div><hr>
	<form id="form1" name="file" method="post" enctype="multipart/form-data" onsubmit="return false">
		<input type="file" name="file" id="uploadFile"  style="border-style: dotted; display: inline-block; text-align: center;"/> 
		<a href="javascript:void(0);" onclick="excelUploadProcess()" class="btn btn-primary btn-sm" >신입생등록</a>
		<security:csrfInput/>
	</form>
</div>
<hr>
<a href="#" onclick="javascript:history.go(-1);" class="btn btn-danger btn-sm" style="float: right;">이전화면</a>

<script>
function excelUploadProcess(){


	var form = $('#form1')[0];
    var formData = new FormData(form);
	var excelList = new FormData(document.getElementById('form1'));
 
    $.ajax({
        url : "${cPath}/student/studentInsert.do",
        type : "POST",
        data : formData,
        dataType : "json",
        contentType : false,
        processData : false,
    }).done(function(data){
    	let dataList = data.dataList;
    	$.each(dataList, function(idx, vo){
        	console.log(vo);
    	});
    	alert("신입생 등록이 완료 되었습니다!");
    });

}


</script>