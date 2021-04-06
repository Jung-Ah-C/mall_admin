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
	// 수집 (insertCategoryForm에서 입력한 정보를 가져옴)
	request.setCharacterEncoding("UTF-8"); // 한글 입력 가능하게 함
	String categoryName = request.getParameter("categoryName");
	
	// 디버깅 코드
	System.out.println("categoryName : "+categoryName);
	
	// 중복된 카테고리가 있으면 다시 입력 폼 (insertCategoryForm) 으로 가면서 끝냄
	// categoryName이 null이면 사용가능하고, else면 사용불가하므로 입력폼으로 돌아가게 함
	String returnCategoryName = CategoryDao.selectCategoryName(categoryName);
	if(returnCategoryName != null) { // 중복된 카테고리가 있음
		System.out.println("사용 중인 카테고리입니다.");
		response.sendRedirect(request.getContextPath()+"category/insertCategoryForm.jsp");
		return; // if 문에 걸려서 위의 코드가 실행된다면 아래 부분에 있는 불필요한 코드를 실행하지 않도록 return문을 통해서 코드진행을 멈춤
		// else 문을 생략하기 위해서 return을 통해서 코드를 멈춤
	}
	
	// 중복된 카테고리가 없으면 입력함
	CategoryDao.insertCategory(categoryName);
	
	// 등록이 완료되면 다시 categoryList로 돌아가게 함
	response.sendRedirect(request.getContextPath()+"/category/categoryList.jsp");
%>
</body>
</html>