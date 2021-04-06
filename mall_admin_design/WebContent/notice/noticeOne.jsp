<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="java.util.*" %>
<%
	// 관리자만 접근할 수 있게 하는 메소드 
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return; // 코드 실행 멈춤
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="assets/css/bootstrap.css">

    <link rel="stylesheet" href="assets/vendors/iconly/bold.css">

    <link rel="stylesheet" href="assets/vendors/perfect-scrollbar/perfect-scrollbar.css">
    <link rel="stylesheet" href="assets/vendors/bootstrap-icons/bootstrap-icons.css">
    <link rel="stylesheet" href="assets/css/app.css">
    <link rel="shortcut icon" href="assets/images/favicon.svg" type="image/x-icon">
<title>noticeOne</title>
</head>
<body>
<%
	// 수집 (noticeList에서 클릭한 공지 noticeNo)
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	System.out.println(noticeNo+"<-- noticeOne의 noticeNo"); // 디버깅
	
	// dao연결
	Notice notice = NoticeDao.selectNoticeOne(noticeNo);
	System.out.println(notice); // 디버깅
%>
	<!-- 관리자화면 메뉴(네비게이션) include -->
	<div>
		<!-- include 사용 시에 프로젝트명 필요없음 -->
		<jsp:include page="/adminMenu.jsp">
			<jsp:param name="current" value="notice"/>
		</jsp:include>
	</div>
		
	<h1>noticeOne</h1>
	<!-- noticeOne 테이블 생성 -->
	<table border="1">
		<tr>
			<th>noticeNo</th>
			<td><%=notice.getNoticeNo()%></td>
		</tr>
		<tr>
			<th>noticeTitle</th>
			<td><%=notice.getNoticeTitle()%></td>
		</tr>
		<tr>
			<th>noticeContent</th>
			<td><%=notice.getNoticeContent()%></td>
		</tr>
		<tr>
			<th>managerId</th>
			<td><%=notice.getManagerId()%></td>
		</tr>
		<tr>
			<th>noticeDate</th>
			<td><%=notice.getNoticeDate().substring(0,11)%></td>
		</tr>
	</table>
	<a href="<%=request.getContextPath()%>/notice/updateNoticeOneForm.jsp?noticeNo=<%=notice.getNoticeNo()%>"><button type="button">수정</button></a>
	<a href="<%=request.getContextPath()%>/notice/deleteNoticeOneAction.jsp?noticeNo=<%=notice.getNoticeNo()%>"><button type="button">삭제</button></a>
	
	<hr>
	
	<!-- 댓글 목록 -->
	<%
		ArrayList<Comment> commentList = CommentDao.selectCommentListByNoticeNo(noticeNo);
	%>
	
	<!-- 전체 댓글 개수 나오게 함 -->
	<div>
		<h4>Comments <%=commentList.size()%></h4>
	</div>
	<table border="1">
	<%
		for(Comment c : commentList) {
	%>
				<tr>
					<td><%=c.getCommentContent()%></td>
					<td><%=c.getManagerId()%></td>
					<td><%=c.getCommentDate().substring(0,11)%></td>
					<td><a href="<%=request.getContextPath()%>/notice/deleteCommentAction.jsp?commentNo=<%=c.getCommentNo()%>&noticeNo=<%=notice.getNoticeNo()%>"><button type="button">삭제</button></a></td>
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
			managerId :
			<input type="text" name="managerId" value="<%=manager.getManagerId()%>" readonly="readonly">
		</div>
		<div>
			<textarea name="commentContent" rows="2" cols="80"></textarea>
		</div>
		<button type="submit">댓글 입력</button>
	</form>
</body>
</html>