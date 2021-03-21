<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!--     <meta http-equiv="X-UA-Compatible" content="IE=edge"> -->
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>LogOut</title>

    <!-- Custom fonts for this template-->
    <link href="/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="/resources/css/sb-admin-2.min.css" rel="stylesheet">

</head>

<body class="bg-gradient-primary">

    <div class="container">

        <!-- Outer Row -->
        <div class="row justify-content-center" >

            <div class="col-xl-5 col-lg-6 col-md-7">

                <div class="card o-hidden border-0 shadow-lg my-5">
                    <div class="card-body p-0">
                        <!-- Nested Row within Card Body -->
                        <div class="row">
                            <div class="col-lg-6 d-none bg-login-image"></div>
                            <div class="col-lg-12">
                                <div class="p-5">
                                    <div class="text-center">
                                       <!--  <h1 class="h4 text-gray-900 mb-4">Welcome Back!</h1> -->
                                    </div>
                                    <form class="user" method='post' action="/customLogout">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                     
            
                                        <button id="btn" class="btn btn-primary btn-user btn-block">로그아웃</button>
                                        <hr>
                                        
                                        
                                    </form>
          
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

        </div>

    </div>

    <!-- Bootstrap core JavaScript-->
    <script src="/resources/vendor/jquery/jquery.min.js"></script>
    <script src="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="/resources/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="/resources/js/sb-admin-2.min.js"></script>
	
	<script>
		$("#btn").on("click", function(e){
			e.preventDefault();
			$("form").submit();
		});
	</script>
	
	<c:if test="${param.logout !=null }">
		<script>
		$(document).ready(function(){
			alert("로그아웃하였습니다").
		});
		</script>
	</c:if>
</body>

</html>