<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	session.invalidate(); // 기존의 세션을 초기화(로그인 정보도 사라지게된다 -> 로그아웃)
	response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
%>