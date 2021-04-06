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
<%
	// 입력했을 때 한글 깨짐 방지
	request.setCharacterEncoding("UTF-8");
	
	// noticeOne에서 입력한 값 받아오기
	// noticeNo는 comment 전체 데이터에서 해당하는 공지의 댓글들을 불러오기 위해서 사용함
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	String managerId = request.getParameter("managerId");
	String commentContent = request.getParameter("commentContent");
	
	// 디버깅
	System.out.println(noticeNo+"<-- insertCommentAction의 noticeNo");
	System.out.println(managerId+"<-- insertCommentAction의 managerId");
	System.out.println(commentContent+"<-- insertCommentAction의 commentContent");
	
	// 전처리
	Comment comment = new Comment();
	comment.setNoticeNo(noticeNo);
	comment.setManagerId(managerId);
	comment.setCommentContent(commentContent);
	
	// Dao 호출
	CommentDao.insertComment(comment);
	
	// 댓글 추가 후 해당 noticeOne으로 재요청
	response.sendRedirect(request.getContextPath()+"/notice/noticeOne.jsp?noticeNo="+noticeNo);
%>