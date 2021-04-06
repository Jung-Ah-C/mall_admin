<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
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

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="assets/css/bootstrap.css">

    <link rel="stylesheet" href="assets/vendors/iconly/bold.css">

    <link rel="stylesheet" href="assets/vendors/perfect-scrollbar/perfect-scrollbar.css">
    <link rel="stylesheet" href="assets/vendors/bootstrap-icons/bootstrap-icons.css">
    <link rel="stylesheet" href="assets/css/app.css">
    <link rel="shortcut icon" href="assets/images/favicon.svg" type="image/x-icon">
<title>clientList</title>
</head>
<body>
	<!-- 관리자화면 메뉴(네비게이션) include -->
	<div>
		<!-- include 사용 시에 프로젝트명 필요없음 -->
		<jsp:include page="/adminMenu.jsp">
			<jsp:param name="current" value="client"/>
		</jsp:include>
	</div>
	
	<!-- 페이징을 위한 변수 초기화 -->
	<%
		// 현재 페이지
		int currentPage = 1;
		if(request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage")); // 받아온 값 정수로 변환
		}
		
		// 페이지 당 행의 수
		int rowPerPage = 10;
		if(request.getParameter("rowPerPage") != null) {
			rowPerPage = Integer.parseInt(request.getParameter("rowPerPage")); // 받아온 값 정수로 변환
		}
		
		// 고객 메일 검색
		String searchWord = ""; // 공백이면 검색어가 없는 것, 있으면 검색어가 있는 것!
		if(request.getParameter("searchWord") != null) { // 넘어온 값이 있으면
			searchWord = request.getParameter("searchWord");
		}
		
		// 시작 행
		int beginRow = (currentPage - 1) * rowPerPage;
		
		// 전체 행의 개수
		int totalRow = ClientDao.totalCount(searchWord);
		System.out.println(totalRow+"<-- totalRow"); // 디버깅
		
		// list 생성	
		ArrayList<Client> list = ClientDao.selectClientListByPage(rowPerPage, beginRow, searchWord);
	%>
	<h1>clientList</h1>
	
	<!-- 한 페이지당 몇개씩 볼건지 선택가능 -->
	<form action="<%=request.getContextPath()%>/client/clientList.jsp" method="post">
		<!-- hidden 값으로 searchWord를 넘김 -->
		<input type="hidden" name="searchWord" value=<%=searchWord%>>
		<select name="rowPerPage">
			<%
				for(int i=10; i<31; i+=5) {
					if(rowPerPage == i) {
			%>
					<option value=<%=i%> selected="selected"><%=i%>개씩</option> 
			<%
					} else {
			%>
					<option value=<%=i%>><%=i%>개씩</option>
			<%	
					}
				}
			%>
		</select>
		<button type="submit">보기</button>
	</form>
	
	<!-- 고객 목록 테이블 -->
	<table border="1">
		<thead>
			<tr>
				<th>clientNo</th>
				<th>clientMail</th>
				<th>clientDate</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
		</thead>
		<tbody>
			<%
				for(Client c : list) {
			%>
					<tr>
						<td><%=c.getClientNo()%></td>
						<td><%=c.getClientMail()%></td>
						<td><%=c.getClientDate().substring(0,11)%></td>
						<!-- 수정이나 삭제버튼에서 primary key 혹은 unique key인 정보가 해당 폼이나 액션으로 넘어가게 해줘야 함 -->
						<td><a href="<%=request.getContextPath()%>/client/updateClientForm.jsp?clientMail=<%=c.getClientMail()%>"><button type=button>수정</button></a></td>
						<td><a href="<%=request.getContextPath()%>/client/deleteClientAction.jsp?clientMail=<%=c.getClientMail()%>"><button type=button>삭제</button></a></td>
					</tr>
			<%
				}
			%>
		</tbody>
	</table>
	
	<!-- 페이징 (이전, 다음) 버튼 만들기 -->
	<% 
		// 맨 첫 페이지에서 이전 버튼이 나오지 않게 함
		if(currentPage > 1) {
	%>
				<a href="<%=request.getContextPath()%>/client/clientList.jsp?currentPage=<%=currentPage-1%>&rowPerPage=<%=rowPerPage%>&searchWord=<%=searchWord%>">이전</a>
	<%
		}
	
		// 맨 마지막 페이지에서 다음 버튼이 보이지 않도록 함
		int lastPage = totalRow / rowPerPage;
		if(totalRow % rowPerPage != 0) {
			lastPage += 1; // lastPage = lastPage+1; lastPage++;
		}
		
		if(currentPage < lastPage) {
	%>
			<a href="<%=request.getContextPath()%>/client/clientList.jsp?currentPage=<%=currentPage+1%>&rowPerPage=<%=rowPerPage%>&searchWord=<%=searchWord%>">다음</a>
	<%
		}
	%>
	
	<!-- 고객 메일 검색 기능 -->
	<form action="<%=request.getContextPath()%>/client/clientList.jsp" method="post">
		<!-- 검색할 때 몇개 볼건지 선택한 기능이 그대로 유지되게 함 -->
		<input type="hidden" name="rowPerPage" value="<%=rowPerPage%>">
		<div>
			clientMail :
			<input type="text" name="searchWord">
			<button type="submit">검색</button>
		</div>
	</form>
</body>
</html>