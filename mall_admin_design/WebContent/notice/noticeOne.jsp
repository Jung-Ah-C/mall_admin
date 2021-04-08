<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="java.util.*" %>
<%
	// 관리자만 접근할 수 있게 하는 메소드
	// 관리자 레벨 1 이상은 열람 가능
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return; // 코드 실행 멈춤
	}
%>
<%
	// 수집 (noticeList에서 클릭한 공지 noticeNo)
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	System.out.println(noticeNo+"<-- noticeOne의 noticeNo"); // 디버깅
	
	// dao연결
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
<title>noticeOne</title>
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
		
	<h1><a href="<%=request.getContextPath()%>/notice/noticeList.jsp">NoticeList</a></h1>
	
	<!-- NoticeOne 테이블 -->
		<div class="row match-height">
			<div class="col-md-6 col-12">
				<div class="card">
					<div class="card-header">
				        <h4 class="card-title">NoticeOne</h4>
				        <p class="card-text">Notice Information</p>
				    </div>
					<div class="card-content">
					<div class="table-responsive">
						<table class="table table-lg">
							<tr>
								<th>NoticeNo</th>
								<td><%=notice.getNoticeNo()%></td>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<th>NoticeTitle</th>
								<td><%=notice.getNoticeTitle()%></td>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<th>NoticeContent</th>
								<td><%=notice.getNoticeContent()%></td>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<th>ManagerID</th>
								<td><%=notice.getManagerId()%></td>
							</tr>
							<tr>
								<th>NoticeDate</th>
								<td><%=notice.getNoticeDate().substring(0,11)%></td>
								<td>&nbsp;</td>
							</tr>
						</table>
					</div>
					</div>
				</div>
			</div>
		</div>
	
	<a href="<%=request.getContextPath()%>/notice/updateNoticeOneForm.jsp?noticeNo=<%=notice.getNoticeNo()%>">
		<button type="button" class="btn btn-primary">Edit</button>
	</a>
		
	<a href="<%=request.getContextPath()%>/notice/deleteNoticeOneAction.jsp?noticeNo=<%=notice.getNoticeNo()%>">
		<button type="button" class="btn btn-primary">Delete</button>
	</a>
	
	<hr>
	
	<!-- 댓글 목록 -->
	<%
		ArrayList<Comment> commentList = CommentDao.selectCommentListByNoticeNo(noticeNo);
	%>
	
	<!-- 전체 댓글 개수 나오게 함 -->
	<div class="col-12 col-md-6">
	    <div class="card">
			<div class="card-header">
			<h4>Comments <%=commentList.size()%></h4>
			<div class="card-content">
				<div class="card-body">
				<table class="table table-lg">
				<%
					for(Comment c : commentList) {
				%>
							<tr>
								<td><%=c.getCommentContent()%></td>
								<td><%=c.getManagerId()%></td>
								<td><%=c.getCommentDate().substring(0,11)%></td>
								<td><a href="<%=request.getContextPath()%>/notice/deleteCommentAction.jsp?commentNo=<%=c.getCommentNo()%>&noticeNo=<%=notice.getNoticeNo()%>"><button type="button" class="btn btn-primary">Delete</button></a></td>
							</tr>
			
				<%
					}
				%>
				</table>
				<br>
				
				<!-- 댓글 입력 -->
				<form action="<%=request.getContextPath()%>/notice/insertCommentAction.jsp" method="post">
					<!-- 현재 공지글 넘버 사용 -->
					<input type="hidden" name="noticeNo" value="<%=notice.getNoticeNo()%>">
					<div>
						<!-- 세션값 사용 -->
						ManagerID :
						<input type="text" name="managerId" value="<%=manager.getManagerId()%>" readonly="readonly">
					</div>
					<div>
						<textarea rows="3" name="commentContent" class="col-md-8 form-control" required="required"></textarea>
					</div>
					<button type="submit" class="btn btn-primary">Submit</button>
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