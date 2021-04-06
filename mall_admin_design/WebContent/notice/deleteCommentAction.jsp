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
	
	//인코딩
	request.setCharacterEncoding("UTF-8");
	
	// noticeOne에서 managerId 값 받아오기
	String managerId = manager.getManagerId();
	int commentNo = Integer.parseInt(request.getParameter("commentNo"));
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	
	// 디버깅
	System.out.println(managerId+"<-- deleteCommentAction의 managerId");
	System.out.println(commentNo+"<-- deleteCommentAction의 commentNo");
	System.out.println(noticeNo+"<-- deleteCommentAction의 noticeNo");
	
	// dao 실행
	if(manager.getManagerLevel() > 1) {
		CommentDao.deleteComment(commentNo);
	} else if (manager.getManagerLevel() > 0) {
		CommentDao.deleteComment(commentNo, managerId);
	}
	
	// 삭제 후 해당 noticeOne으로 재요청
	response.sendRedirect(request.getContextPath()+"/notice/noticeOne.jsp?noticeNo="+noticeNo);
%>