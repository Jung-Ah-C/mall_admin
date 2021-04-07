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
	            <div class="auth-logo">
	                <a href="<%=request.getContextPath()%>/adminIndex.jsp"><img src="<%=request.getContextPath()%>/img/logo1.jpg" alt="logo" width="200" height="100"></a>
	            </div>
	            <h1 class="auth-title">Create Account</h1>
	            <p class="auth-subtitle mb-5">Input your data to add a new manager.</p>
	
	            <form action="<%=request.getContextPath()%>/manager/insertManagerAction.jsp" method="post">
	                <div class="form-group position-relative has-icon-left mb-4">
	                    <input type="text" class="form-control form-control-xl" name="managerId" placeholder="Manager ID">
	                    <div class="form-control-icon">
	                        <i class="bi bi-person"></i>
	                    </div>
	                </div>
	                <div class="form-group position-relative has-icon-left mb-4">
	                    <input type="text" class="form-control form-control-xl" name="managerName" placeholder="Manager Name">
	                    <div class="form-control-icon">
	                        <i class="bi bi-person-lines-fill"></i>
	                    </div>
	                </div>
	                <div class="form-group position-relative has-icon-left mb-4">
	                    <input type="password" class="form-control form-control-xl" name="managerPw" placeholder="Password">
	                    <div class="form-control-icon">
	                        <i class="bi bi-shield-lock"></i>
	                    </div>
	                </div>
	                <button type="submit" class="btn btn-primary btn-block btn-lg shadow-lg mt-5">SIGN UP</button>
	                <!-- reset 버튼 크기 수정하기 -->
	                <button type="reset" class="btn btn-light-secondary me-1 mb-1">Reset</button>
	            </form>
	            <div class="text-center mt-5 text-lg fs-4">
	                <p class='text-gray-600'>Already have an account? <a href="<%=request.getContextPath()%>/adminLogin.jsp" class="font-bold">Sign in</a>.</p>
	            </div>
	        </div>
	    </div>
	    <div class="col-lg-7 d-none d-lg-block">
	        <div id="auth-right">
	
	        </div>
	    </div>
	    
		<!-- 저작권 표시 -->
		<footer>
		       <div class="footer clearfix mb-0 text-muted">
		           <div class="float-start">
		               <p>2021 &copy; RiDi</p>
		           </div>
		           <div class="float-end">
		               <p>Made with <span class="text-danger"><i class="bi bi-heart"></i></span> by <a
		                       href="https://github.com/Jung-Ah-C">Jungah Choi</a></p>
		           </div>
		       </div>
		</footer>
	</div>
</div>
</body>
</html>