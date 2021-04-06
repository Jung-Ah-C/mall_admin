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
	// updateEbookSummaryForm에서 입력한 값 받아오기
	String ebookISBN = request.getParameter("ebookISBN");
	String ebookSummary = request.getParameter("ebookSummary");
	
	// 디버깅
	System.out.println(ebookISBN+"<-- updateEbookSummaryAction의 ebookISBN");
	System.out.println(ebookISBN+"<-- updateEbookSummaryAction의 ebookSummary");
	
	// 객체 생성과 전처리
	Ebook ebook = new Ebook();
	ebook.setEbookISBN(ebookISBN);
	ebook.setEbookSummary(ebookSummary);
	
	// 업데이트 실행
	EbookDao.updateEbookSummary(ebook);
	
	// 업데이트 후, ebookOne으로 재요청
	response.sendRedirect(request.getContextPath()+"/ebook/ebookOne.jsp?ebookISBN="+ebookISBN);
%>