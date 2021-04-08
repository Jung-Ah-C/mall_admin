<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="java.util.*" %>
<%
	//매니저 레벨 1 이상만
	// 매니저가 아니라면 다시 adminIndex로 보내버림
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return; // 코드 실행 멈춤
	}
%>
<%
	String ebookISBN = request.getParameter("ebookISBN"); // ebookOne에서 ebookISBN값을 넘겨 받음
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/bootstrap.css">

    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/vendors/iconly/bold.css">

    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/vendors/perfect-scrollbar/perfect-scrollbar.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/vendors/bootstrap-icons/bootstrap-icons.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/app.css">
    <link rel="shortcut icon" href="<%=request.getContextPath()%>/assets/images/favicon.svg" type="image/x-icon">
<title>updateEbookImgForm</title>
</head>
<body>
	<!-- 관리자화면 메뉴(네비게이션) include -->
	<div>
		<!-- include 사용 시에 프로젝트명 필요없음 -->
		<jsp:include page="/adminMenu.jsp">
			<jsp:param name="current" value="ebook"/>
		</jsp:include>
	</div>

<div id="app">
	<div id="main">
	
	<header class="mb-3">
	    <a href="#" class="burger-btn d-block d-xl-none">
	        <i class="bi bi-justify fs-3"></i>
	    </a>
    </header>
    
	<!-- 클릭하면 E-bookList로 넘어감 -->
	<h1><a href="<%=request.getContextPath()%>/ebook/ebookList.jsp">E-bookList</a></h1>
	
	<div class="col-12 col-md-6">
	    <div class="card">
		    <div class="card-header">
		        <h4 class="card-title">Edit E-book Image</h4>
		    </div>
		    <div class="card-content">
			    <div class="card-body">
					<!-- 이미지를 넘길 때는 무조건 post 방식으로 넘기기 -->
					<form action="<%=request.getContextPath()%>/ebook/updateEbookImgAction.jsp" method="post" enctype="multipart/form-data">
						<input type="hidden" name="ebookISBN" value="<%=ebookISBN%>">
						<input type="file" class="image-preview-filepond" name="ebookImg"> <!-- request.getParameter는 문자만 넘겨받기 때문에, 파일은 넘겨받지 못함 -->
						<button type="submit" class="btn btn-primary">Edit</button>
					</form>
				</div>
			</div>
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

<script src="<%=request.getContextPath()%>/assets/vendors/perfect-scrollbar/perfect-scrollbar.min.js"></script>
<script src="<%=request.getContextPath()%>/assets/js/bootstrap.bundle.min.js"></script>

<script src="<%=request.getContextPath()%>/assets/vendors/apexcharts/apexcharts.js"></script>
<script src="<%=request.getContextPath()%>/assets/js/pages/dashboard.js"></script>

<script src="<%=request.getContextPath()%>/assets/js/main.js"></script>
</body>
</html>