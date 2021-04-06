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
	// updateEbookForm에서 입력한 값을 받아옴
	request.setCharacterEncoding("UTF-8"); // 인코딩
	String ebookISBN = request.getParameter("ebookISBN");
	String categoryName = request.getParameter("categoryName");
	String ebookTitle = request.getParameter("ebookTitle");
	String ebookState = request.getParameter("ebookState");
	String ebookAuthor = request.getParameter("ebookAuthor");
	String ebookCompany = request.getParameter("ebookCompany");
	String ebookSummary = request.getParameter("ebookSummary");
	int ebookPrice = Integer.parseInt(request.getParameter("ebookPrice"));
	int ebookPageCount = Integer.parseInt(request.getParameter("ebookPageCount"));
	
	// 디버깅
	System.out.println(ebookISBN+"<-- updateEbookAction의 ebookISBN");
	System.out.println(categoryName+"<-- updateEbookAction의 CategoryName");
	System.out.println(ebookTitle+"<-- updateEbookAction의 ebookTitle");
	System.out.println(ebookState+"<-- updateEbookAction의 ebookState");
	System.out.println(ebookAuthor+"<-- updateEbookAction의 ebookAuthor");
	System.out.println(ebookCompany+"<-- updateEbookAction의 ebookCompany");
	System.out.println(ebookSummary+"<-- updateEbookAction의 ebookSummary");
	System.out.println(ebookPrice+"<-- updateEbookAction의 ebookPrice");
	System.out.println(ebookPageCount+"<-- updateEbookAction의 ebookPageCount");
	
	// 객체 생성 및 전처리
	Ebook ebook = new Ebook();
	ebook.setEbookISBN(ebookISBN);
	ebook.setCategoryName(categoryName);
	ebook.setEbookTitle(ebookTitle);
	ebook.setEbookState(ebookState);
	ebook.setEbookAuthor(ebookAuthor);
	ebook.setEbookCompany(ebookCompany);
	ebook.setEbookSummary(ebookSummary);
	ebook.setEbookPrice(ebookPrice);
	ebook.setEbookPageCount(ebookPageCount);
	
	// 업데이트 실행
	EbookDao.updateEbook(ebook);
	
	// 실행 후 ebookOne 으로 재요청
	response.sendRedirect(request.getContextPath()+"/ebook/ebookOne.jsp?ebookISBN="+ebookISBN);
%>