<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.6.0.min.js"></script>
<!--     stomp 통신 -->
    <script	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.0/sockjs.min.js"></script>
	<script	src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<!--     stomp 통신 -->
<style type="text/css">
	.text-nowrap{
		margin-left: 30px;
	}
	
/* 	ㅡㅡ메시지 숫자 cssㅡㅡ */
/* 	.note-num { */
/*     position: absolute; */
/*     left : 180px; */
/*     z-index: 3; */
/*     height: 15px; */
/*     width: 24px; */
/*     line-height: 14px; */
/*     text-align: center; */
/*     background-color: red; */
/*     border-radius: 10px; */
/*     display: inline-block; */
/*     color : white; */
/* 	ㅡㅡ메시지 숫자 cssㅡㅡ */
/* } */
</style>
<security:authentication property="principal.realUser" 
	var="authMember"/>

	<nav class="navbar navbar-expand bg-light navbar-light" id="hermes_top_bar" style="height: 70px; ">

		<div id="hermes-top-menu" class="navbar-nav align-items-center">
			<ul id="subTopMenu" class="navbar-nav px-3 py-3">
				<c:forEach items="${topMenuList}" var="topMenu">
					<security:authorize access="hasRole('ROLE_MANAGER')">
					<c:if test="${topMenu.topmenuType eq '학사관리자' }">
					<li class="nav-item text-nowrap nav-topMenuText">
						<a id="${topMenu.topmenuId}" class="nav-link dropdown-item" href="javascript:void(0);" data-menu-no="${topMenu.topmenuId}">
							${topMenu.topmenuText}</a>
					</li>
					</c:if>
					</security:authorize>
					
					<security:authorize access="hasRole('ROLE_STUDENT')">
					<c:if test="${topMenu.topmenuType eq '학생' }">
					<li class="nav-item text-nowrap nav-topMenuText">
						<a id="${topMenu.topmenuId}" class="nav-link dropdown-item" href="javascript:void(0);" data-menu-no="${topMenu.topmenuId}">
							${topMenu.topmenuText}</a>
					</li>
					</c:if>
					</security:authorize>
					
					<security:authorize access="hasRole('ROLE_PROFESSOR')">
					<c:if test="${topMenu.topmenuType eq '교수' }">
					<li class="nav-item text-nowrap nav-topMenuText">
						<a id="${topMenu.topmenuId}" class="nav-link dropdown-item" href="javascript:void(0);" data-menu-no="${topMenu.topmenuId}">
							${topMenu.topmenuText}</a>
					</li>
					</c:if>
					</security:authorize>
				</c:forEach>
			</ul>

	
	
		<div id="heremes-top-submenu" class="navbar-nav navbar-light bg-light position-absolute top-0 end-0" style="margin-top:0.5rem;">
			<div class="nav-item dropdown">
				<a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">
					<img class="rounded-circle me-lg-2" src="${cPath }/resources/img/profile/${authMember.userSavename}" alt="" style="width: 40px; height: 40px;">
					<span class="d-none d-lg-inline-flex">${authMember.userName } (${authMember.userType })</span>
				</a>
				<div class="dropdown-menu dropdown-menu-end bg-light border-0 rounded-0 rounded-bottom m-0">
                   <a href="${cPath }/myPage" class="dropdown-item">마이페이지</a>
                   <a onclick="logoutFunc(event)" href="${cPath }/login/logout.do" class="dropdown-item">로그아웃</a>
				<form id="logoutFrm" action="${cPath }/login/logout.do" method="post" hidden="hidden">
				<security:csrfInput />
				</form>
                </div>
			</div>
			
			<div class="nav-item">
				<a href="javascript:messageHamPop('${cPath }/stompDM', 'popup');" class="nav-link" id="messageHam">
					<i class="fa fa-envelope me-lg-2 position-relative" style="margin-top : -0.1rem;">
					<span class="position-absolute top-5 start-100 translate-middle badge rounded-pill bg-danger note-num"></span>
  </i>
					<span class="d-none d-lg-inline-flex" style="margin-top : -2.5rem;">메시지함</span>
				
				</a>
			</div>
<!-- 			<div class="nav-item dropdown"> -->
<!-- 				<a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"> -->
<!-- 				<i class="fa fa-bell me-lg-2"></i> -->
<!-- 				<span class="d-none d-lg-inline-flex">새로운 알림</span> -->
<!-- 				</a> -->
<!-- 			</div> -->
		</div>
		</div>
		<br>
	</nav>
	
	


<security:authentication property="principal" var="user"/>
<script type="text/javascript">
$(".nav-topMenuText a").removeClass("nowTopMenu");

$(function(){
// 	let sideMenuArea = $("#sideMenuArea");
	let userType = "${user.realUser.userType}";
// 	let sideMenuURL = "sideMenu.do";


	let menuTop = "${menuTop}";
	if(menuTop !=null && menuTop != ""){
		let sideMenuArea = $("#sideMenuArea");
		let sideMenuURL = "sideMenu.do";
		let code = "";
		$.ajax({
			url : "${pageContext.request.contextPath}/"+sideMenuURL,
			method : "get",
			data : {menuTop : menuTop},
			dataType : "json",
			success : function(resp) {
				
				sideMenuArea.empty();
				let sideMenuList = resp.sideMenuList;
				
				$.each(sideMenuList, function(idx, sideMenu){
					code += "<div class='nav-item dropdown'>";
					if(sideMenu.childList != null){
						let childList = sideMenu.childList;
						code += "<a href='#' class='nav-link dropdown-toggle' data-bs-toggle='dropdown'>";
						code += "<i class='"+sideMenu.menuClasses+"' style='color:#0099FF'></i>";
						code += sideMenu.menuText;
						code += "</a>";
						code += "<div class='dropdown-menu bg-transparent border-0 navmem' id='navmem'>";
						for(var i = 0; i < childList.length; i++){
							let childMenu = childList[i];
							code += "<a href='";
							code += "${pageContext.request.contextPath}/";
		                     code += childMenu.menuUrl+"?name="+childMenu.menuId;
							code += "' class='dropdown-item' id='"+childMenu.menuId+"'>";
							code += childMenu.menuText;
							code += "</a>";
						}
						code += "</div>";
					}else{
						code += "<a href='";
						code += "${pageContext.request.contextPath}/"
						code += sideMenu.menuUrl+"?name="+sideMenu.menuId;
						code += "' class='nav-link dropdown-toggle' id='"+sideMenu.menuId+"' >";
						code += "<i class='"+sideMenu.menuClasses+"' style='color:#0099FF'></i>";
						code += sideMenu.menuText;
						code += "</a>";
					}
					code += "</div>";
				});
				sideMenuArea.html(code);
				let childMenuId = "${param.name}";

				if(childMenuId !=null && childMenuId != ""){
					
				$('#'+childMenuId).parent().addClass('show');
				$('#'+childMenuId).parent().prev().addClass('show');
				$('#'+childMenuId).css('background-color','#cde4da');
				
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				console.log(jqXHR);
				console.log(textStatus);
				console.log(errorThrown);
			}
		});
	}
	
	$("#subTopMenu").on("click", ".nav-link", function(){
		$(".nav-topMenuText a").removeClass("nowTopMenu");
		$(this).addClass("nowTopMenu");
		let menuTop = $(this).data("menuNo");
		sessionStorage.setItem("nowTopMenu", menuTop );
		menuTop += " ";
		let sideMenuArea = $("#sideMenuArea");
		let sideMenuURL = "sideMenu.do";
		let code = "";
		$.ajax({
			url : "${pageContext.request.contextPath}/"+sideMenuURL,
			method : "get",
			data : {menuTop : menuTop},
			dataType : "json",
			success : function(resp) {
				menuTop = "";
				sideMenuArea.empty();
				let sideMenuList = resp.sideMenuList;
				
				$.each(sideMenuList, function(idx, sideMenu){
					code += "<div class='nav-item dropdown'>";
					if(sideMenu.childList != null){
						let childList = sideMenu.childList;
						code += "<a href='#' class='nav-link dropdown-toggle' data-bs-toggle='dropdown'>";
						code += "<i class='"+sideMenu.menuClasses+"' style='color:#0099FF'></i>";
						code += sideMenu.menuText;
						code += "</a>";
						code += "<div class='dropdown-menu bg-transparent border-0 navmem' id='navmem'>";
						for(var i = 0; i < childList.length; i++){
							let childMenu = childList[i];
							code += "<a href='";
							code += "${pageContext.request.contextPath}/";
		                     code += childMenu.menuUrl+"?name="+childMenu.menuId;
							code += "' class='dropdown-item' id='"+childMenu.menuId+"'>";
							code += childMenu.menuText;
							code += "</a>";
						}
						code += "</div>";
					}else{
						code += "<a href='";
						code += "${pageContext.request.contextPath}/"
						code += sideMenu.menuUrl+"?name="+sideMenu.menuId;
						code += "' class='nav-link dropdown-toggle' id='"+sideMenu.menuId+"'>";
						code += "<i class='"+sideMenu.menuClasses+"' style='color:#0099FF'></i>";
						code += sideMenu.menuText;
						code += "</a>";
					}
					code += "</div>";
				});
				sideMenuArea.html(code);
			},
			error : function(jqXHR, textStatus, errorThrown) {
				console.log(jqXHR);
				console.log(textStatus);
				console.log(errorThrown);
			}
		});
	});
});






//로그아웃 폼 전송
function logoutFunc(event){
	sessionStorage.removeItem("nowTopMenu");
	event.returnValue=false;
	var frm = document.getElementById("logoutFrm");
	frm.submit();
}

//subscribe 상수ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
const serviceinfo = {
	"check" : {dest:"/DM/check",id:"check",callback: function(messageFrame){
															console.log(messageFrame);
															let messageBody = JSON.parse(messageFrame.body);
															getNewMessage();
															}
			}
	, "login" : {dest:"/DM/login",id:"login"}
	, "DM" : {dest:"/DM", id:"dm",callback: function(messageFrame){
												console.log(messageFrame);
												let messageBody = JSON.parse(messageFrame.body);
												getNewMessage();
												}
	}
	
}
var defaultcallback = function(messageFrame){
						console.log(messageFrame);
						let messageBody = JSON.parse(messageFrame.body);
						};
//subscribe 상수ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ

// ㅡㅡㅡㅡㅡㅡㅡㅡstomp 통신시작ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	let headers = {};
function init(event) {
	var sockJS = new SockJS("${cPath}/stomp/echo");
	client = Stomp.over(sockJS);
	client.connect(headers, function(connectFrame) {
		
		
		// $.each() 메서드의 첫번째 매겨변수로 위에서 선언한 객체를 전달
		$.each(serviceinfo, function (index, item) {
		    // 객체를 전달받으면 index는 객체의 key(property)를 가리키고
		    // item은 키의 값을 가져옵니다.

		client.subscribe("/user/queue"+item.dest,
				item.callback ?? defaultcallback,
				{id:item.id});
		});
		
		
	}, function(error) {
		console.log(error);
	});
}

function disconnect(event) {
	if (!client || !client.connected)
		throw "stomp 연결 수립 전";
	client.disconnect();
}
$(document).ready(init);

$(window).on("unload", disconnect);
//ㅡㅡㅡㅡㅡㅡㅡㅡstomp 통신끝ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ

// ㅡㅡㅡㅡㅡㅡㅡㅡ메세지 갯수 가져와서 뿌리기ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
function getNewMessage(){
	$.ajax({
		url : "${pageContext.request.contextPath}/messageCount",
		dataType : "text",
		success : function(messageCount) 
		{
			$('#messageHam .note-num').text(messageCount);
// 			<span class="note-num">3</span>
// 			alert(messageCount);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR);
			console.log(textStatus);
			console.log(errorThrown);
		},
	});
// ㅡㅡㅡㅡㅡㅡㅡㅡ메세지 갯수 가져와서 뿌리기ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
    	
		
}
function messageHamPop(url, name){
    var options = 'top=100, left=650, width=800, height=750, status=no, menubar=no, toolbar=no, resizable=no';
    window.open(url, name, options);
}
$(document).ready(getNewMessage);

</script> 
