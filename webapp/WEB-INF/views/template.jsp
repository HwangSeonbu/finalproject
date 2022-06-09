<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!doctype html>
<html lang="kr">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.88.1">
    <title>대덕인재대학교</title>

	<tiles:insertAttribute name="preScript" />

<meta name="theme-color" content="#563d7c">
</head>
<style>
#contentBody{
	padding-left : 3.5rem !important;
	padding-top: 2rem !important;
}

</style>
<body>

<!-- <div class="container-xxl position-relative bg-white d-flex p-0"> -->


    <tiles:insertAttribute name="leftMenu" />


    <div class="content">
    
	<tiles:insertAttribute name="topMenu" />
	
    <div class="container-fluid pt-5 px-4" id="contentBody">
   
      <tiles:insertAttribute name="content"/>

  	</div>
  	</div>
    

<!--   	</div> -->
<!--     <div class="content" id="mainDetailbody"> -->
<!--     </div> -->
<!-- </div> -->

<tiles:insertAttribute name="postScript" />
</body>
</html>
    
    
    
    
  