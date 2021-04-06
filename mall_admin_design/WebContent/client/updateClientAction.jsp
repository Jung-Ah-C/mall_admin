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
	
		// 수집 코드 구현 (clientMail, clientPw)
		String clientMail = request.getParameter("clientMail");
		String clientPw = request.getParameter("clientPw");
		
		// 디버깅 코드 (값을 폼에서 잘 받아왔는지 확인)
		System.out.println("clientMail : "+clientMail);
		System.out.println("clientPw : "+clientPw);
		
		// dao 수정 메소드 호출 코드 구현
		ClientDao.updateClient(clientMail, clientPw);
		
		// 수정이 완료되면 clientList 페이지로 재요청
		response.sendRedirect(request.getContextPath()+"/client/clientList.jsp");
%>