<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.vo.*" %>
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
<!DOCTYPE html>
<html>
<head>
<title>insertManagerForm</title>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/bootstrap.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/vendors/bootstrap-icons/bootstrap-icons.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/app.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/pages/auth.css">
</head>
<body>
	<div class="text-center">
		<img src="<%=request.getContextPath()%>/img/firecracker.png">
		<div>
			<h1>Welcome!</h1>
			<p>매니저 등록 성공! 승인 후 사용 가능합니다.</p>
				
				<table class="table" style="width: 600px; margin-left:auto; margin-right:auto;">
					<tr>
						<th>Manager ID</th>
						<td><%=managerId%></td>
					</tr>
					<tr>
						<th>Manager Name</th>
						<td><%=managerName%></td>
					</tr>
				</table>
		</div>
		<a href="<%=request.getContextPath()%>/adminIndex.jsp"><button class="btn btn-primary">Home</button></a>	
	</div>
		
</body>
</html>