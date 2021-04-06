<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*"%>
<%@ page import="gdu.mall.dao.*" %>
<%	
	// 관리자만 접근 가능 (level 1)
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if (manager == null) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;	
	} else if(manager.getManagerLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}

	// 인코딩
	request.setCharacterEncoding("UTF-8");
	
	// 수집 코드 구현
	String ordersState = request.getParameter("ordersState"); 
	int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));
	int currentPage = Integer.parseInt(request.getParameter("currentPage"));
	int rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
	
	// 디버깅 코드
	System.out.println(ordersNo+"<-- updateOrdersStateAction의 ordersNo");
	System.out.println(ordersState+"<-- updateOrdersStateAction의 ordersState");
	
	// 전처리
	OrdersAndEbookAndClient oec = new OrdersAndEbookAndClient();
	oec.setOrders(new Orders());
	
	oec.getOrders().setOrdersNo(ordersNo);
	oec.getOrders().setOrdersState(ordersState);
	
	// dao 수정 메소드 호출 코드 구현
	OrdersDao.updateOrdersState(oec);
	
	// 페이지 재요청
	response.sendRedirect(request.getContextPath()+"/orders/ordersList.jsp?rowPerPage="+rowPerPage+"&currentPage="+currentPage);
%>