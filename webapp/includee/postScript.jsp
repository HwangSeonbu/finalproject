<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


        <!-- Back to Top 맨위로가는버튼인데 필요없을듯? 챗봇버튼으로 만들어도될듯-->
<!--         <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a> -->
   
    <!-- JavaScript Libraries -->
    <script src="${pageContext.request.contextPath }/resources/js/jquery-3.6.0.min.js"></script>
    <script src="${pageContext.request.contextPath }/resources/js/bootstrap-5.1.3-dist/js/bootstrap.bundle.min.js"></script>

    <!-- Template Javascript -->
    <script src="${pageContext.request.contextPath }/resources/js/main.js"></script>
    
<!--     alert (MJH) -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
    
    
    <!-- HERMES ONLY -->
    <script src="${pageContext.request.contextPath }/resources/js/hermes.js"></script>
    
    
    
    
<script>
    let sessionTopMenu = sessionStorage.getItem("nowTopMenu");
	if(sessionTopMenu != null){
		$("#"+sessionTopMenu).addClass("nowTopMenu");
	}
</script>