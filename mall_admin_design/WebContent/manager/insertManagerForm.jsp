<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<!DOCTYPE html>
<html>
<head>
<title>insertManagerForm</title>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/bootstrap.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/vendors/bootstrap-icons/bootstrap-icons.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/app.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/pages/auth.css">
</head>
<body>
	<!-- auth-register form -->
	<div id="auth">
		<div class="row h-100">
		    <div class="col-lg-5 col-12">
		        <div id="auth-left">
		            <h1 class="auth-title">Create Account</h1>
		            <p class="auth-subtitle mb-5">Input your data to add a new manager.</p>
		
		            <form action="<%=request.getContextPath()%>/manager/insertManagerAction.jsp" method="post">
		                <div class="form-group position-relative has-icon-left mb-4">
		                    <input type="text" class="form-control form-control-xl" required="required" name="managerId" placeholder="Manager ID">
		                    <div class="form-control-icon">
		                        <i class="bi bi-person"></i>
		                    </div>
		                </div>
		                <div class="form-group position-relative has-icon-left mb-4">
		                    <input type="text" class="form-control form-control-xl" required="required" name="managerName" placeholder="Manager Name">
		                    <div class="form-control-icon">
		                        <i class="bi bi-person-lines-fill"></i>
		                    </div>
		                </div>
		                <div class="form-group position-relative has-icon-left mb-4">
		                    <input type="password" class="form-control form-control-xl" required="required" name="managerPw" placeholder="Password">
		                    <div class="form-control-icon">
		                        <i class="bi bi-shield-lock"></i>
		                    </div>
		                </div>
						<button type="reset" class="btn btn-light-secondary btn-block btn-lg shadow-lg mt-5">Reset</button>
						<button type="submit" class="btn btn-primary btn-block btn-lg shadow-lg mt-5">Sign Up</button>
		            </form>
		            <div class="text-center mt-5 text-lg fs-4">
		                <p class='text-gray-600'>Already have an account? <a href="<%=request.getContextPath()%>/adminLogin.jsp" class="font-bold">Sign in</a>.</p>
		            </div>
		        </div>
		    </div>
		    <div class="col-lg-7 d-none d-lg-block">
		        <div id="auth-right"></div>
	    </div>
	</div>
</div>
</body>
</html>