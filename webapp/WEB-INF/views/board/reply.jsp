<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2022. 5. 12.      이유정     최초작성
* Copyright (c) 2022 by DDIT All right reserved
 --%>
<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<security:csrfMetaTags/>

<script>
//if문으로 boardNo이 있으면 질문게시판 댓글로 가고, boardNo이 없으면 무조건 자유게시판 댓글로 가라!  
// var boardNo = '${qBoard.boardNo }'; //게시글 번호

let boardNo = "";


// <c:set var="boardNo" value="'${qBoard.boardNo }"/>
	<c:if test="${not empty qBoard}">
		//지금은 질문게시판 댓글 보려고 하는 중, 여기서 지금 보드넘버 가져오면됨 /여기서는 큐보드 쓰기
		boardNo = "${qBoard.boardNo}";
	</c:if>
	<c:if test="${empty qBoard}">
		//지금은 자유게시판 댓글 보려고 하는 중, 여기서 지금 보드넘버 가져오면됨 / 여기서는 에프보드쓰기
		boardNo = "${fBoard.boardNo}";
// 		<c:set var="boardNo" value="${fBoard.boardNo }" />
	</c:if>	


$('[name=replyInsertBtn]').click(function() {
	var insertData = $('[name=replyInsertForm]').serialize(); //commentInsertForm의 내용을 가져옴
	replyInsert(insertData); // Insert 함수 호출(아래에 있음)
})

// 댓글 목록 -- 수정삭제 버튼 아예 없어짐 ..
function replyList() {
	$.ajax({
		url : '${cPath}/board/list',
		type : 'get',
		data : {'boardNo' : boardNo},
		success : function(data) {
			var a ='';
			$.each(data, function(key, value) {
                a += '<div class="replyArea" style="border-bottom:1px solid darkgray; margin-bottom: 15px;">';
                a += '<div class="replyInfo'+value.replyNo+'">'+'작성자: '+value.userName; 
                a += '<a onclick="replyDelete('+value.replyNo+');" style="color:blue; float:right;">&nbsp;&nbsp;삭제 </a>';
                a += '<a onclick="replyUpdate('+value.replyNo+',\''+value.replyContent+'\');" style="color:blue; float:right;">수정 </a></div>'; 
                a += '<div class="replyContent'+value.replyNo+'"> <p> '+value.replyContent +'</p>'+''+value.replyDate;
                a += '</div></div>';
            });
         
            $(".replyList").html(a);
        }
    });
}

//댓글 등록 
function replyInsert(insertData) {
	$.ajax({
		url : '${cPath}/board/insert',
		type : 'post',
		data : insertData,
		success : function(data) {
			if(data == 1){
				replyList(); // 댓글 작성 후 댓글 목록 reload
				$('[name=replyContent]').val('');
			}
		}
	});
}
	
//댓글 삭제 
function replyDelete(replyNo) {
	var token = $("meta[name='_csrf']").attr("content");
    var header = $("meta[name='_csrf_header']").attr("content");
	$.ajax({
		url : '${cPath}/board/delete/'+replyNo,
		type : 'post',
		beforeSend : function(xhr){
			if(token && header) {
	            xhr.setRequestHeader(header, token);
	        }
		},
		success : function(data) {
			if(data == 1) replyList(boardNo); //댓글 삭제후 목록 출력 
		}
	});
}

//댓글 수정 - 댓글 내용 출력을 input으로 변경
function replyUpdate(replyNo, replyContent) {
	var a = '';
	
    a += '<div class="input-group">';
    a += '<input type="text" class="form-control" name="replyContent_'+replyNo+'" value="'+replyContent+'"/>';
    a += '<span class="input-group-btn"><button class="btn btn-default" type="button" onclick="replyUpdateProc('+replyNo+');">수정</button> </span>';
    a += '</div>';
  
    $('.replyContent'+replyNo).html(a);

}

//댓글 수정 
function replyUpdateProc(replyNo) {
	var replyContent =  $('[name=replyContent_'+replyNo+']').val();
	  $.ajax({
	        url : '${cPath}/board/update',
	        type : 'get',
	        data : {'replyContent' : replyContent, 'replyNo' : replyNo},
	        success : function(data){
	            if(data == 1) replyList(replyNo); //댓글 수정후 목록 출력 
	        }
	    });
}

//댓글 화면에 바로 출력 
$(document).ready(function() {
	replyList(); //페이지 로딩시 댓글 목록 출력 
});

			
</script>

