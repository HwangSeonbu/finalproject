<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2022. 5. 3.      이유정      최초작성
* Copyright (c) 2022 by DDIT All right reserved
 --%>
<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ page import="java.util.List" %>
<%@ page import="kr.or.ddit.vo.CalendarVO" %>
<security:csrfMetaTags/>
<head>
   <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
</head>
<meta charset='utf-8' />
<link href='${pageContext.request.contextPath }/resources/css/fullcalendar/main.css' rel='stylesheet' />
<script src='${pageContext.request.contextPath }/resources/js/fullcalendar/main.js'></script>


<script>



//들어가자마자 리스트  고~ 
calendarList();

//일정추가! 
$(function(){
    $("#addCalendar").on("click",function(){  // modal의 추가 버튼 클릭 시
        let acadscCont = $("#acadscCont").val();
        let acadscStart = $("#acadscStart").val();
        let acadscEnd = $("#acadscEnd").val();
        let acadscUserno = $("#acadscUserno").val();       
        
        //내용 입력 여부 확인
        if(acadscCont == null || acadscCont == ""){
//         	Swal.fire({
//         		  title: 'Error!',
//         		  text: '내용을 입력하세요',
//         		  icon: 'error',
//         		  confirmButtonText: '돌아가기'
//         		})
             alert("내용을 입력하세요."); 
        }else if(acadscStart == "" || acadscStart ==""){
        	/* Swal.fire({
      		  title: 'Error!',
      		  text: '날짜를 입력하세요',
      		  icon: 'error',
      		  confirmButtonText: '돌아가기'
      		}) */
             alert("날짜를 입력하세요.");
        }else if(new Date(acadscEnd)- new Date(acadscStart) < 0){ // date 타입으로 변경 후 확인
//         	Swal.fire({
//       		  title: 'Error!',
//       		  text: '종료일이 시작일보다 먼저입니다',
//       		  icon: 'error',
//       		  confirmButtonText: '돌아가기'
//       		})
             alert("종료일이 시작일보다 먼저입니다."); 
        }else{ // 정상적인 입력 시
            var obj = {
                "acadscCont" : acadscCont,
                "acadscStart" : acadscStart,
                "acadscEnd" : acadscEnd,
                "acadscUserno" :acadscUserno               
            }//전송할 객체 생성
            insertCalendar(obj);
        }
   });
});



function calendarList() {
     //일정목록 출력 ====================================================================================
      $.ajax({
           url: '${pageContext.request.contextPath }/calendar/calendarForm.do',
           type: 'GET',
           dataType:'json',
           success: function(resp){
              var dataList = resp.dataList;
              console.log(dataList);
              
               var calendarEl = document.getElementById('calendar');
               let draggableEl = document.getElementById('mydraggable');
                var Draggable = FullCalendar.Draggable;
                 var containerEl = document.getElementById('external-events');
              var checkbox = document.getElementById('drop-remove');
              var acadscDiv = dataList.acadscDiv;
              
              //var acadscColor = dataList.acadscColor;
              
              var events = dataList.map(function(item) {
                 var editableChk = item.acadscDiv == 'B1'?false:true;
                 var clickChk = item.acadscDiv == 'B1'?false:true;
                 var acadscColor = item.acadscDiv == 'B1'?'#CD5C5C':'#4682B4';
                 return {
                       id : item.acadscNo,
                     title : item.acadscCont,
                     start : item.acadscStart,
                     end : item.acadscEnd,
                     editable : editableChk,
                     clickChk : clickChk,
                     backgroundColor : acadscColor
                  }
              });
        //}
                 
             
              
               //드래그 기능 ======================================================================================
               new Draggable(containerEl, {
                   itemSelector: '.fc-event',
                   eventData: function(eventEl) {
                     return {
                       title: eventEl.innerText,                                       
                       backgroundColor : eventEl.backgroundColor
                     };
                	  console.log("info===========================================>" , info);
                      updateFunc(info);
                   }
                 });
               
               
         

               
               
                 //시간과 헤더===================================================================================
               var calendar = new FullCalendar.Calendar(calendarEl, {
                  height: 385,
                  events : events,                  
                  headerToolbar: {
                         left: 'addEventButton prev,next today',
                         center: 'title',
                         right: 'dayGridMonth,timeGridWeek,timeGridDay'
                  },
                       
                    //일정추가 ==============================================================================
                  customButtons: {
                       addEventButton: { // 추가한 버튼 설정
                           text : "일정 추가",  // 버튼 내용
                            click : function(){ // 버튼 클릭 시 이벤트 추가
                               $("#calendarModal").modal("show"); // modal 나타내기
                          }
                    }
                 },
                        
   /*             
                    //날짜선택해서 일정추가 (근데 날짜 끌어와서 넣기)
                  dateClick : function(){ // 버튼 클릭 시 이벤트 추가
                            $("#calendarModal").modal("show"); // modal 나타내기
                       },
          */
          

                        eventDrop : function(info) { // 이벤트를 드래그를 해 손을 놓았을 했을 때
               //         alert(start);
               //          alert(
               //          info.event.title + " was moved " +
               //          info.event.start + " start and " +
               //          info.event.end + " end." +
               //          info.event.extendedProps.seq + " seq" +
               //          info.event.extendedProps.proSeq + " proSeq"
               //          );
                        if (confirm("수정하시겠습니까?")) {
                        
                        	    //사용 예시 **************************                     	
                           var msg = updateFunc(info);
                        } else {
                           info.revert(); // 취소 시키기(없을 경우 무조건 이동이 이뤄진다.)
                        }
                     },
                     eventResize : function(info) { // 이벤트 일정을 드래그 해 변경했을 때(종료 일자)
                        if (confirm("수정하시겠습니까?")) {
                           var msg = updateFunc(info);                           
                        } else {
                           info.revert(); // 취소 시키기(없을 경우 무조건 이동이 이뤄진다.)
                        }
                     },   
                                              
                       
                           //이벤트 선택해서 삭제
                           eventClick: function (info){
                              //console.log("item", info.event.extendedProps.clickChk);
                              if(info.event.extendedProps.clickChk){
                                if(confirm("'"+ info.event.title +"' 일정을 삭제하시겠습니까 ?")){
                                    // 확인 클릭 시
                                    info.event.remove();
                                    var acadscNo = info.event.id;
                                    console.log(acadscNo);
                                    deleteData(acadscNo);
         
                                }
                              }else{
                            	  alert("학사일정은 수정/삭제가 불가능합니다.");
//                             	  Swal.fire({
//                             		  title: 'Error!',
//                             		  text: '학사일정은 수정/삭제가 불가능합니다.',
//                             		  icon: 'error',
//                             		  confirmButtonText: '돌아가기'
//                             		})
                              }
                   
                           }, 
                           
                         /*  //이벤트 클릭하여 수정 
                          eventClick: function (info){
                           if(info.event.extendedProps.clickChk){
                              if(confirm){
                               $("#calendarView").modal("show");
                              }
                            }else{
                                alert("학사일정은 수정/삭제가 불가능합니다");
                             }      
                        }, */
                        

                        
   //*******************************달력의 잡다한 기smd ***************************************************************
            selectable : true, // 달력 일자 드래그 설정가능
            locale: 'ko', //한국어 
            //editable: true,
            droppable: true, // this allows things to be dropped onto the calendar
            drop: function(info) {
                      // is the "remove after drop" checkbox checked?
                if (checkbox.checked) {
                        // if so, remove the element from the "Draggable Events" list
                   info.draggedEl.parentNode.removeChild(info.draggedEl);
                }
            }
      });
      calendar.render();
    },
   });
 };
        



// 글 저장 ===========================================================================================
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");

   function insertCalendar(obj) {   
      $.ajax({
         url : '${cPath}/calendar/calendarInsert',
         type : 'post',
         data : obj,
         beforeSend : function(xhr){
            if(token && header) {
                  xhr.setRequestHeader(header, token);
              }
         },
         success : function(data) {
            if (data == 1) {
            /* 	Swal.fire({
            		  icon: 'success',
            		  title: '일정이 추가되었습니다.',
            		  showConfirmButton: false,
            		  timer: 1500
            		}) */
            		alert("일정이 추가되었습니다.");
               calendarList();             
            }
            
         }
      });
   };
   
   function dateFormat(date){
      var yyyy = date.getFullYear();
      var MM = date.getMonth()+1; // 0월 부터 시작해 +1을 시켜줌
      var dd = date.getDate();
      var rtnDate = yyyy + '-' + MM + '-' + dd;
      return rtnDate;
   }
   
//수정 ===========================================================================================
   function updateFunc(info) {
   var proSeq = info.event.extendedProps.proSeq;
   var seq = info.event.extendedProps.seq;
   var start = info.event.start;
   var id = info.event.id;
   start = dateFormat(start);
   var end = info.event.end;
   end = dateFormat(end);
   var title = info.event.title;
   var contents = info.event.extendedProps.contents;
   var msg;
   var token = $("meta[name='_csrf']").attr("content");
   var header = $("meta[name='_csrf_header']").attr("content");

   $.ajax({
      type : 'POST',
      data : {
         "proSeq" : proSeq,
         "seq" : seq,
         "acadscNo" : id,
         "acadscStart" : start,
         "acadscEnd" : end,
         "acadscCont" : title
      },
      datatype : 'json',
      async : false,
      url : '${cPath}/calendar/update',
      beforeSend : function(xhr){
         if(token && header) {
               xhr.setRequestHeader(header, token);
           }
      },
      success : function(result) {
         if(result == 'y'){
            msg = '수정되었습니다.';
         } 
      },
      
   });
   return msg;
}


//삭제============================================================================================
         var token = $("meta[name='_csrf']").attr("content");
          var header = $("meta[name='_csrf_header']").attr("content");
          
    function deleteData(acadscNo){
       
       console.log(acadscNo);
            $.ajax({
                url: "${cPath}/calendar/delete",
                method: "post",
                data : {acadscNo:acadscNo},
               beforeSend : function(xhr){
               if(token && header) {
                     xhr.setRequestHeader(header, token);
                 }
            },
            success : function(data) {
            if(data == 1){
               calendarList();   
            }; 
            }
        });
    };
    
   
 
</script>
<style>
#dragObj{
    height: 30px;
    text-align: center;
    padding: 5%;   
}
.fc-event-main:hover {
   color:    red;
   cursor: pointer;
}
</style>
<body>
<div id="wrap">
<!--  드래그 이벤트  =======================================================================================-->
 <div id='external-events'>
 <p></p>
   <p style="text-align: center; font-size: large; font-weight: bolder; ">일정추가</p>
      <div id= "dragObj" class='fc-event fc-h-event fc-daygrid-event fc-daygrid-block-event' style="background-color: #F08080;">
        <div class='fc-event-main'>미팅</div>
      </div>
      <div id= "dragObj" class='fc-event fc-h-event fc-daygrid-event fc-daygrid-block-event'style="background-color: #FF7F50;">
        <div class='fc-event-main'>시험</div>
      </div>
      <div id= "dragObj" class='fc-event fc-h-event fc-daygrid-event fc-daygrid-block-event' style="background-color: #FFD700;">
        <div class='fc-event-main'>휴식</div>
      </div>
      <div id= "dragObj" class='fc-event fc-h-event fc-daygrid-event fc-daygrid-block-event' style="background-color: #87CEFA;">
        <div class='fc-event-main'>개강</div>
      </div> 
      <div id= "dragObj" class='fc-event fc-h-event fc-daygrid-event fc-daygrid-block-event' style="background-color: #DDA0DD;">
        <div class='fc-event-main' >종강</div>
      </div>
      <p>
        <input type='checkbox' id='drop-remove' />
        <label for='drop-remove'>추가 후 삭제</label>
      </p>     
</div>

<div id='calendar-wrap'>
    <div id='calendar' ></div>
    <!-- modal 추가 -->
    </div>
</div>

<!-- 일정추가 모달  ===========================================================================================-->
<div class="modal fade" id="calendarModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">일정을 입력하세요.</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                    <security:authentication property="principal.realUser" var="authMember"/>
                        <input type="hidden" class="form-control" id="acadscUserno" name="acadscUserno" value="${authMember.userNo }" readonly="readonly">
                        <label for="taskId" class="col-form-label">일정 내용</label>
                        <input type="text" class="form-control" id="acadscCont" name="acadscCont">
                        <label for="taskId" class="col-form-label">시작 날짜</label>
                        <input type="date" class="form-control" id="acadscStart" name="acadscStart">
                        <label for="taskId" class="col-form-label">종료 날짜</label>
                        <input type="date" class="form-control" id="acadscEnd" name="acadscEnd">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning"   id="addCalendar"  >추가</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" id="sprintSettingModalClose" >닫기</button>
                </div>
    
            </div>
        </div>
    </div>
    

<!-- 일정수정 모달  ===========================================================================================-->
<form name ="calendarForm" role="form" method="post">
<div class="modal fade" id="calendarView" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">일정을 입력하세요.</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                    <security:authentication property="principal.realUser" var="authMember"/>
                        <input type="hidden" class="form-control" id="acadscUserno" name="acadscUserno" readonly="readonly">
                        <label for="taskId" class="col-form-label">일정 내용</label>
                        <input type="text" class="form-control" id="acadscCont" name="acadscCont">
                        <label for="taskId" class="col-form-label">시작 날짜</label>
                        <input type="date" class="form-control" id="acadscStart" name="acadscStart">
                        <label for="taskId" class="col-form-label">종료 날짜</label>
                        <input type="date" class="form-control" id="acadscEnd" name="acadscEnd">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning"   id="updateCalendar"  data-bs-dismiss="modal" >수정</button>
                    <button type="button" class="btn btn-danger"   id="deleteCalendar"  data-bs-dismiss="modal" >삭제</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal"
                        id="sprintSettingModalClose" >닫기</button>
                </div>
    
            </div>
        </div>
    </div>
</form>

   
</body>