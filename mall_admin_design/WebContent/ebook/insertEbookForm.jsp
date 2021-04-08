<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="java.util.*" %>
<%
	// 매니저 레벨 1 이상
	// 매니저가 아니라면 다시 adminIndex로 보내버림
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return; // 코드 실행 멈춤
	}
%>
<%
	// 배열 불러오기
	ArrayList<String> categoryNameList = CategoryDao.categoryNameList();
	System.out.println(categoryNameList.size()+" <-- insertEbookForm의 categoryNameList.size"); // 디버깅
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
<title>insertEbookForm</title>
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
	
	<!-- E-bookForm -->
	<div class="row match-height">
	<div class="col-md-6 col-12">
		<div class="card">
			<div class="card-header">
	            <h4 class="card-title">E-bookForm</h4>
	            <p class="card-text">Add a New E-book</p>
            </div>
			<div class="card-content">
				<div class="card-body">
					<form action="<%=request.getContextPath()%>/ebook/insertEbookAction.jsp" method="post" class="form form-vertical">
						<div class="form-body">
							<div class="row">
								<div class="col-md-4">
									<label for="categoryName">Category Name</label>
								</div>
								<div class="col-md-8 form-group">
									<select name="categoryName">
										<option value="">--Category--</option>
										<%
											for(String cn : categoryNameList) {
										%>
												<option value="<%=cn%>"><%=cn%></option>
										<%
											}
										%>
									</select>
								</div>
								
								<div class="col-md-4">
									<label for="ebookISBN">ebookISBN</label>
								</div>
								<div class="col-md-8 form-group">
									<input type="text" name="ebookISBN" class="form-control" required="required">
								</div>
								
								<div class="col-md-4">
									<label for="ebookTitle">ebookTitle</label>
								</div>
								<div class="col-md-8 form-group">
									<input type="text" name="ebookTitle" class="form-control" required="required">
								</div>
								
								<div class="col-md-4">
									<label for="ebookAuthor">ebookAuthor</label>
								</div>
								<div class="col-md-8 form-group">
									<input type="text" name="ebookAuthor" class="form-control" required="required">
								</div>
								
								<div class="col-md-4">
									<label for="ebookCompany">ebookCompany</label>
								</div>
								<div class="col-md-8 form-group">
									<input type="text" name="ebookCompany" class="form-control" required="required">
								</div>
								
								<div class="col-md-4">
									<label for="ebookPageCount">ebookPageCount</label>
								</div>
								<div class="col-md-8 form-group">
									<input type="text" name="ebookPageCount" class="form-control" required="required">
								</div>
								
								<div class="col-md-4">
									<label for="ebookPrice">ebookPrice</label>
								</div>
								<div class="col-md-8 form-group">
									<input type="text" name="ebookPrice" class="form-control" required="required">
								</div>
								
								<div class="col-md-4">
									<label for="ebookSummary">ebookSummary</label>
								</div>
								<div class="col-md-8 form-group">
									<textarea rows="5" name="ebookSummary" class="col-md-8 form-control" required="required"></textarea>
								</div>
								
								<div class="col-sm-12 d-flex justify-content-end">
									<button type="submit" class="btn btn-primary me-1 mb-1">Submit</button>
									<button type="reset" class="btn btn-light-secondary me-1 mb-1">Reset</button>
								</div>
							</div>
						</div>
					</form>
				</div>
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