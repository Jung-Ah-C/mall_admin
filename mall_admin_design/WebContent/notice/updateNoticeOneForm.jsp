<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="java.util.*" %>
<%
	// 관리자만 접근할 수 있게 하는 메소드 (level 2 이상만 공지 수정 가능)
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 2) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return; // 코드 실행 멈춤
	}
%>
<%
	// 수집 (noticeOne에서 수정 버튼에서 noticeNo)
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	System.out.println(noticeNo+"<-- updateNoticeOneForm의 noticeNo"); // 디버깅
	
	// dao 연결
	Notice notice = NoticeDao.selectNoticeOne(noticeNo);
	System.out.println(notice); // 디버깅
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
<title>updateNoticeOneForm</title>
</head>
<body>

	<!-- 관리자화면 메뉴(네비게이션) include -->
	<div>
		<!-- include 사용 시에 프로젝트명 필요없음 -->
		<jsp:include page="/adminMenu.jsp">
			<jsp:param name="current" value="notice"/>
		</jsp:include>
	</div>

<div id="app">
	<div id="main">
	
	<header class="mb-3">
	    <a href="#" class="burger-btn d-block d-xl-none">
	        <i class="bi bi-justify fs-3"></i>
	    </a>
    </header>
	
	<!-- 클릭하면 NoticeList로 넘어감 -->
	<h1><a href="<%=request.getContextPath()%>/notice/noticeList.jsp">NoticeList</a></h1>
	
	<!-- updateNoticeOneForm 테이블 작성 -->
	<div class="row match-height">
	<div class="col-md-6 col-12">
		<div class="card">
			<div class="card-header">
	            <h4 class="card-title">Edit E-book Form</h4>
	            <p class="card-text">you can edit e-book information except for image.</p>
            </div>
			<div class="card-content">
				<div class="card-body">
					<form action="<%=request.getContextPath()%>/ebook/updateEbookAction.jsp" method="post" class="form form-vertical">
						<div class="form-body">
							<div class="row">
								<div class="col-md-4">
									<label for="noticeNo">NoticeNo</label>
								</div>
								<div class="col-md-8 form-group">
									<input type="text" name="noticeNo" value=<%=notice.getNoticeNo()%> class="form-control" readonly="readonly">
								</div>
								
								<div class="col-md-4">
									<label for="noticeTitle">NoticeTitle</label>
								</div>
								<div class="col-md-8 form-group">
									<input type="text" name="noticeTitle" value="<%=notice.getNoticeTitle()%>" class="form-control" placeholder="<%=notice.getNoticeTitle()%>" required="required">
								</div>
								
								<div class="col-md-4">
									<label for="noticeContent">NoticeContent</label>
								</div>
								<div class="col-md-8 form-group">
									<textarea rows="5" name="noticeContent" class="col-md-8 form-control" required="required"><%=notice.getNoticeContent()%></textarea>
								</div>
								
								<div class="col-md-4">
									<label for="managerId">ManagerID</label>
								</div>
								<div class="col-md-8 form-group">
									<input type="text" name="managerId" value=<%=notice.getManagerId()%> class="form-control" readonly="readonly">
								</div>
								
								<div class="col-md-4">
									<label for="noticeDate">NoticeDate</label>
								</div>
								<div class="col-md-8 form-group">
									<input type="text" name="noticeDate" value="<%=notice.getNoticeDate().substring(0,11)%>" class="form-control" readonly="readonly">
								</div>
								
								<div class="col-sm-12 d-flex justify-content-end">
									<button type="submit" class="btn btn-primary me-1 mb-1">Edit</button>
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