<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="java.util.*" %>
<%
	// 관리자만 접근할 수 있게 하는 메소드 
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
    
<title>ordersList</title>
</head>
<body>
	<!-- 관리자화면 메뉴(네비게이션) include -->
	<div>
		<!-- include 사용 시에 프로젝트명 필요없음 -->
		<jsp:include page="/adminMenu.jsp">
			<jsp:param name="current" value="orders"/>
		</jsp:include>
	</div>
	
	<h1>ordersList</h1>
	<!-- rowPerPage별 페이징을 위한 변수 초기화 -->
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
			
		// 시작 행
		int beginRow = (currentPage - 1) * rowPerPage;
		
		// 전체 행의 개수
		int totalRow = OrdersDao.totalCount();
		System.out.println(totalRow+"<-- OrdersList의 totalRow"); // 디버깅
		
		// dao 실행해서 list 생성
		ArrayList<OrdersAndEbookAndClient> list = OrdersDao.selectOrdersListByPage(rowPerPage, beginRow);
	%>
	
	<!-- 한 페이지당 몇 개씩 볼건지 선택가능 -->
	<form action="<%=request.getContextPath()%>/ebook/ebookList.jsp" method="post">
		<select name="rowPerPage">
			<%
				for(int i=10; i<31; i+=5) {
					if(rowPerPage == i) {
			%>
					<!-- 옵션에서 선택한 개수만큼의 행이 보이게 함 -->
					<option value=<%=i%> selected="selected"><%=i%>개씩</option> 
			<%
					} else {
			%>
					<!-- 옵션 선택이 되어 있지 않으면 rowPerPage 설정 값으로 보이게 함 -->
					<option value=<%=i%>><%=i%>개씩</option>
			<%	
					}
				}
			%>
		</select>
		<button type="submit">보기</button>
	</form>
	
	<!-- 주문 목록 테이블 -->
	<table border="1">
		<thead>
			<tr>
				<th>ordersDate</th>
				<th>ordersNo</th>
				<th>clientNo</th>
				<th>clientMail</th>
				<th>ebookNo</th>
				<th>ebookTitle</th>
				<th>ordersState</th>
			</tr>
		</thead>
		<tbody>
			<%
				for (OrdersAndEbookAndClient oec : list) { // for each문
			%>
					<tr>
						<td><%=oec.getOrders().getOrdersDate()%></td>
						<td><%=oec.getOrders().getOrdersNo()%></td>
						<td><%=oec.getClient().getClientNo()%></td>
						<td><%=oec.getClient().getClientMail()%></td>
						<td><%=oec.getEbook().getEbookNo()%></td>
						<td><%=oec.getEbook().getEbookTitle()%></td>
						<td>
							<form action="<%=request.getContextPath()%>/orders/updateOrdersStateAction.jsp" method="post">
							<input type="hidden" value="<%=oec.getOrders().getOrdersNo()%>" name="ordersNo">
							<input type="hidden" value="<%=currentPage%>" name="currentPage">
							<input type="hidden" value="<%=rowPerPage%>" name="rowPerPage">
								<select name="ordersState">
								<% 
								String[] state = {"주문완료", "주문취소"};
									for(String s : state) {
										if(s.equals(oec.getOrders().getOrdersState())) {
								%>
											<option value="<%=s%>" selected="selected"><%=s%></option>
								<%
										} else {
								%>
											<option value="<%=s%>"><%=s%></option>
								<%
										}
									}
								%>
								</select>
								<button type="submit">주문수정</button>
							</form>
						</td>
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
			<a href="<%=request.getContextPath()%>/orders/ordersList.jsp?currentPage=<%=currentPage-1%>&rowPerPage=<%=rowPerPage%>">이전</a>
	<%
		}
	
		// 맨 마지막 페이지에서 다음 버튼이 보이지 않도록 함
		int lastPage = totalRow / rowPerPage;
		if(totalRow % rowPerPage != 0) {
			lastPage += 1; // lastPage = lastPage+1; lastPage++;
		}
		
		if(currentPage < lastPage) {
	%>
			<a href="<%=request.getContextPath()%>/orders/ordersList.jsp?currentPage=<%=currentPage+1%>&rowPerPage=<%=rowPerPage%>">다음</a>
	<%
		}
	%>
</body>
</html>