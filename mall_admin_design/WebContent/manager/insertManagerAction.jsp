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
	// 1. 수집 (managerInsertForm에서 입력한 정보를 가져옴)
	request.setCharacterEncoding("UTF-8");
	String managerId = request.getParameter("managerId");
	String managerPw = request.getParameter("managerPw");
	String managerName = request.getParameter("managerName");
	
	// 디버깅 코드
	System.out.println("managerId : "+managerId);
	System.out.println("managerPw : "+managerPw);
	System.out.println("managerName : "+managerName);
	
	// 2-1. 중복된 아이디가 있으면 다시 입력 폼 (managerInsertForm) 으로 가면서 끝냄
	// managerId가 null이면 사용가능하고, else면 사용불가하므로 입력폼으로 돌아가게 함
	String returnManagerId = ManagerDao.selectManagerId(managerId);
	if(returnManagerId != null) { // 중복된 아이디가 있음
		System.out.println("사용 중인 아이디입니다.");
		response.sendRedirect(request.getContextPath()+"manager/managerInsertForm.jsp");
		return; // if 문에 걸려서 위의 코드가 실행된다면 아래 부분에 있는 불필요한 코드를 실행하지 않도록 return문을 통해서 코드진행을 멈춤
		// else 문을 생략하기 위해서 return을 통해서 코드를 멈춤
	}
	
	// 2-2. 중복된 아이디가 없으면 입력함
	ManagerDao.insertManager(managerId, managerPw, managerName);
	// 3. 등록에 성공한다면 간단한 메세지를 출력
%>
	<div>
		매니저 등록 성공! 승인 후 사용 가능합니다.
		<a href="<%=request.getContextPath()%>/adminIndex.jsp">관리자 홈</a>
	</div>
</body>
</html>