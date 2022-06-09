<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
     <source src="${pageContext.request.contextPath}/resources/video/mainBackground.mp4" type="video/mp4">
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
					<input type="radio" id="student" name="whoru" value="student" checkd/>
					<label for="student">학생</label>
					<input type="radio" id="professor" name="whoru" value="professor" checkd/>
					<label for="professor">교수</label>
					<input type="radio" id="admin" name="whoru" value="admin" checkd/>
					<label for="admin">학사관리자</label>
					<form action="${pageContext.request.contextPath }/login/loginProcess.do" method="post">
						<div class="form-group">
							<div class="input-group">
								<div class="input-group-prepend">
									<span class="input-group-text"><i class="fa fa-user"></i></span>
								</div>
								<input name="" class="form-control" placeholder="학번/사번 입력하세요" >
							</div> <!-- input-group.// -->
						</div> <!-- form-group// -->
						<div class="form-group">
							<div class="input-group">
								<div class="input-group-prepend">
									<span class="input-group-text"><i class="fa fa-lock"></i></span>
								</div>
								<input class="form-control" placeholder="******" type="password">
							</div> <!-- input-group.// -->
						</div> <!-- form-group// -->
						<div class="form-group">
							<button type="submit" class="btn btn-primary btn-block">Login</button>
							<br>
								<p class="text-center">
									<a href="#" class="btn">학번(교번)찾기</a>
									<a href="#" class="btn">비밀번호 찾기</a>
								</p>
						</div> <!-- form-group// -->
					</form>
					<a href="${pageContext.request.contextPath }/studentMain.do">학생으로 로그인</a> <br>
					<a href="${pageContext.request.contextPath }/professorMain.do">교수로 로그인</a> <br>
					<a href="${pageContext.request.contextPath }/adminMain.do">학사관리자로 로그인</a> <br>
				</article>
			</div> <!-- card.// -->
		</aside> <!-- col.// -->
	</div> <!-- row.// -->
</div> 
<!--container end.//-->
</body>
</html>