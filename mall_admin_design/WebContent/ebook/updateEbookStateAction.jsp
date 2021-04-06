<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="java.util.*" %>
<%
	// 매니저인 사람들만 고객리스트에 접근할 수 있게 함
	// 매니저가 아니라면 다시 adminIndex로 보내버림
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return; // 코드 실행 멈춤
	}
%>
<%
	request.setCharacterEncoding("UTF-8"); // 한글 깨짐 방지
	
	String ebookState = request.getParameter("ebookState");
	String ebookISBN = request.getParameter("ebookISBN");
	
	// 디버깅
	System.out.println(ebookState+"<-- updateEbookStateAction의 ebookState");
	System.out.println(ebookISBN+"<-- updateEbookStateAction의 ebookISBN");
	
	// 객체생성
	Ebook ebook = new Ebook();
	// 목록 메소드에 있던 ISBN, State 값을 다시 업데이트 
	ebook.setEbookISBN(ebookISBN);
	ebook.setEbookState(ebookState);
	
	// dao 호출 후 업데이트 실행
	EbookDao.updateEbookState(ebook);
	
	//책상태 업데이트 후 ebookOne으로 재요청
	response.sendRedirect(request.getContextPath()+"/ebook/ebookOne.jsp?ebookISBN="+ebookISBN);
%>