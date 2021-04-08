<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*"%>
<%@ page import="gdu.mall.dao.*" %>
<%
	// 매니저가 아니라면 다시 adminIndex로 보내버림
	// 레벨 2 이상만 레벨 수정 가능
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 2) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return; // 코드 실행 멈춤
	}
%>
<%

	// 수집 코드 구현 (managerNo, managerLevel)
	// 값을 받아올 때 String으로 받기 때문에 int로 변환해줘야 함
	int managerNo = Integer.parseInt(request.getParameter("managerNo")); 
	int managerLevel = Integer.parseInt(request.getParameter("managerLevel"));
	int rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
	int currentPage = Integer.parseInt(request.getParameter("currentPage"));
	
	// 디버깅 코드
	System.out.println(managerNo+"<-- updateManagerLevelAction의 managerNo");
	System.out.println(managerLevel+"<-- updateManagerLevelAction의 managerLevel");
	System.out.println(rowPerPage+"<-- updateManagerLevelAction의 rowPerPage");
	System.out.println(currentPage+"<-- updateManagerLevelAction의 currentPage");
	
	// dao 수정 메소드 호출 코드 구현
	ManagerDao.updateManagerLevel(managerNo, managerLevel);
	
	response.sendRedirect(request.getContextPath()+"/manager/managerList.jsp?rowPerPage="+rowPerPage+"&currentPage="+currentPage);
%>