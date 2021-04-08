<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<!-- 이미지를 같은 폴더에 저장할 때, 이미지 이름이 겹쳐서 덮어쓰기가 되지 않도록 하는 클래스 (이미지를 등록할 때의 시간을 통해서 구분함) -->
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.vo.*" %>
<%
	// 매니저가 아니라면 다시 adminIndex로 보내버림
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return; // 코드 실행 멈춤
	}
%>
<%
	/*
	실행하면 null 값으로 나옴
	enctype="multipart/form-data" 으로 넘기면 request.getParameter로 넘겨 받을 수 없음
	
	String ebookISBN = request.getParameter("ebookISBN");
	String ebookImg = request.getParameter("ebookImg");
	System.out.println(ebookISBN+"<-- updateEbookImgAction의 ebookISBN");
	System.out.println(ebookImg+"<-- updateEbookImgAction의 ebookImg");
	*/
	
	// 파일을 다운로드 받을 위치
	// String path = application.getRealPath("img"); // 이 프로그램이 실행될 때 img 폴더가 OS상에서 실제로 어디에 위치해 있는지 찾아달라는 메소드
	String path = "D:/goodee/eclipse/web/mall_admin/WebContent/img"; // 직접 경로 입력함
	System.out.println(path); // 디버깅
	int size = 1024 * 1024 * 1024; // 1GB
	
	// 매개변수 순서 : request를 위임함, file이 저장되어 있는 위치, 파일크기를 얼마까지 허용할건지, 인코딩, 중복된 이름이 있으면 어떻게 처리할건지
	MultipartRequest multi = new MultipartRequest(request, path, size, "UTF-8", new DefaultFileRenamePolicy());
	String ebookISBN = multi.getParameter("ebookISBN");
	String ebookImg = multi.getFilesystemName("ebookImg"); // DefaultFileRenamePolicy에 의해서 중복된 이름이 걸러진 파일명을 받기 때문에 getFilesystemName으로 함
	System.out.println(ebookISBN);
	System.out.println(ebookImg);
	
	Ebook ebook = new Ebook();
	ebook.setEbookISBN(ebookISBN);
	ebook.setEbookImg(ebookImg);
	EbookDao.updateEbookImg(ebook);
	
	response.sendRedirect(request.getContextPath()+"/ebook/ebookOne.jsp?ebookISBN="+ebookISBN);
%>