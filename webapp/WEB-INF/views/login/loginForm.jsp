<%--
* [[개정이력(Modification Information)]]
* 수정일                 수정자      수정내용
* ----------  ---------  -----------------
* 2022. 5. 24.      민진홍      로그인페이지,아이디찾기추가
* Copyright (c) 2022 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<security:authorize access="isAuthenticated()">
<script>

location.href="${pageContext.request.contextPath}/main.do";
 </script>
</security:authorize>
<security:authorize access="isAnonymous()">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<!------ Include the above in your HEAD tag ---------->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.8/css/all.css">
<title>Insert title here</title>
</head>
<style>
	.card{
		opacity:0.9;
	}

	.container {
		top: 500%;
	}
	.col-sm-4{
		 left: 33%;	
	}
	#videobcg {
		position: absolute;
		top: 0px;
		left: 0px;
		min-width: 100%;
		min-height: 100%;
		width: auto;
		height: auto;
		z-index: -1000;
		overflow: hidden;
	}
</style>
<body>


<video id="videobcg" preload="auto" autoplay="true" loop="loop" muted="muted" volume="0">
     <source src="${pageContext.request.contextPath}/resources/video/login.mp4" type="video/mp4">
</video>

<div class="container">
	<br>
	<p class="text-center"><a href="http://bootstrap-ecommerce.com/"></a></p>
	<hr>
	
	<div class="row">
		<aside class="col-sm-4">
			<div class="card">
				<article class="card-body">
					<h4 class="card-title text-center mb-4 mt-1">HERMES</h4>
					<hr>
					<p class="text-success text-center">대덕인재대학교 종합포털</p>
					
					<form action="${pageContext.request.contextPath }/login/loginProcess.do" method="post" id="loginfrm">
					  <security:csrfInput/>
						<div class="form-group">
							<div class="input-group">
								<div class="input-group-prepend">
									<span class="input-group-text"><i class="fa fa-user"></i></span>
								</div>
								  <input type="text" id="memId" name="memId" value="${cookie.idCookie.value }" 
  									class="form-control" placeholder="Account" required autofocus>
							</div> <!-- input-group.// -->
						</div> <!-- form-group// -->
						<div class="form-group">
							<div class="input-group">
								<div class="input-group-prepend">
									<span class="input-group-text"><i class="fa fa-lock"></i></span>
								</div>

								<input type="password" id="memPass" name="memPass" class="form-control" placeholder="Password" required>
							</div> <!-- input-group.// -->
							<div class="float-right">
								<span class="text-danger" style="font-size: 5px;">*최초암호는 생년월일(YYMMDD)입니다.</span>
							</div>
						</div> <!-- form-group// -->
						<div class="form-group">
							<button type="submit" class="btn btn-primary btn-block">Login</button>
								<p class="text-center" style="margin-top: 10px;">
									<a href="javascript:openWindowPop('${cPath }/login/findMyId', 'popup');" class="btn">학번(교번)찾기</a>
								</p>
						</div> <!-- form-group// -->
					</form>
					 <a class="samplelogin" id="student" href="${pageContext.request.contextPath }/login/loginProcess.do" class="dropdown-item">학생으로 로그인</a>
					 <br>
					 <a class="samplelogin" id="professor" href="${pageContext.request.contextPath }/login/loginProcess.do" class="dropdown-item">교수로 로그인</a>
					 <br>
					 <a class="samplelogin" id="manager" href="${pageContext.request.contextPath }/login/loginProcess.do" class="dropdown-item">학사관리자로 로그인</a>

				</article>
			</div> <!-- card.// -->
		</aside> <!-- col.// -->
	</div> <!-- row.// -->
</div> 
<script type="text/javascript">

$(document).on("click", ".samplelogin", function(){
	event.returnValue=false;
	var frm = document.getElementById("loginfrm");
	let usertype = $(this).attr('id');
	if(usertype == 'student'){
	$('#memId').val('541');
	$('#memPass').val('java');
	}else if(usertype == 'professor'){
		$('#memId').val('18031001');
		$('#memPass').val('java');
	}else{
		$('#memId').val('19060001');
		$('#memPass').val('java');
	}
	
	
	frm.submit();
});



function openWindowPop(url, name){
     var options = 'top=100, left=650, width=500, height=600, status=no, menubar=no, toolbar=no, resizable=no';
     window.open(url, name, options);
 }

</script>

<!--container end.//-->
</body>
</html>
</security:authorize>