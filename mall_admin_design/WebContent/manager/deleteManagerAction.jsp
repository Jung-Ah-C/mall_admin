<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*"%>
<%@ page import="gdu.mall.dao.*"%>
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

	// 수집 코드 구현 (managerNo)
	int managerNo = Integer.parseInt(request.getParameter("managerNo")); // 값을 받아올 때 String으로 받기 때문에 int로 변환해줘야 함
	
	// 디버깅 코드
	System.out.println("managerNo : "+managerNo);
	
	// dao 삭제 메소드 호출 코드 구현
	ManagerDao.deleteManager(managerNo);
	
	response.sendRedirect(request.getContextPath()+"/manager/managerList.jsp");
%>