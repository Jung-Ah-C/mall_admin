<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.vo.*" %>
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
	// 입력했을 때 한글 깨짐 방지
	request.setCharacterEncoding("UTF-8");
	
	// EbookDao에서 insertEbook 입력 메소드 가져옴
	String categoryName = request.getParameter("categoryName");
	String ebookISBN = request.getParameter("ebookISBN");
	String ebookTitle = request.getParameter("ebookTitle");
	String ebookAuthor = request.getParameter("ebookAuthor");
	String ebookCompany = request.getParameter("ebookCompany");
	int ebookPageCount = Integer.parseInt(request.getParameter("ebookPageCount"));
	int ebookPrice = Integer.parseInt(request.getParameter("ebookPrice"));
	String ebookSummary = request.getParameter("ebookSummary");
	
	// 디버깅 확인
	System.out.println(categoryName+"<-- insertEbookAction.categoryName");
	System.out.println(ebookISBN+"<-- insertEbookAction.ebookISBN");
	System.out.println(ebookTitle+"<-- insertEbookAction.ebookTitle");
	System.out.println(ebookAuthor+"<-- insertEbookAction.ebookAuthor");
	System.out.println(ebookCompany+"<-- insertEbookAction.ebookCompany");
	System.out.println(ebookPageCount+"<-- insertEbookAction.ebookPageCount");
	System.out.println(ebookPrice+"<-- insertEbookAction.ebookPrice");
	System.out.println(ebookSummary+"<-- insertEbookAction.ebookSummary");
	
	// ISBN 중복 확인
	if(EbookDao.doubleCheckISBN(ebookISBN) != null) { // null이 아니라면 중복된 ISBN 존재함
		response.sendRedirect(request.getContextPath()+"/ebook/ebookList.jsp");
		System.out.println("중복된 ebookISBN 입니다");
		return;
	}
	
	// 중복된 ISBN이 없다면 입력 진행
	// 전처리 (8개의 데이터를 하나로 묶는 작업)
	Ebook ebook = new Ebook();
	ebook.setCategoryName(categoryName);
	ebook.setEbookISBN(ebookISBN);
	ebook.setEbookTitle(ebookTitle);
	ebook.setEbookAuthor(ebookAuthor);
	ebook.setEbookCompany(ebookCompany);
	ebook.setEbookPageCount(ebookPageCount);
	ebook.setEbookPrice(ebookPrice);
	ebook.setEbookSummary(ebookSummary);
	
	int rowCnt = EbookDao.insertEbook(ebook);
	response.sendRedirect(request.getContextPath()+"/ebook/ebookList.jsp");
%>