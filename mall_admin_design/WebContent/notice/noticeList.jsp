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
<title>noticeList</title>
</head>
<body>
	<!-- 관리자화면 메뉴(네비게이션) include -->
	<div>
		<!-- include 사용 시에 프로젝트명 필요없음 -->
		<jsp:include page="/adminMenu.jsp">
			<jsp:param name="current" value="notice"/>
		</jsp:include>
	</div>
	
	<h1>noticeList</h1>
	<!-- 공지 추가 버튼 -->
	<a href="<%=request.getContextPath()%>/notice/insertNoticeForm.jsp"><button type="button">공지 추가</button></a>
	
	<!-- rowPerPage별 페이징 -->
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
		int totalRow = NoticeDao.totalCount();
		System.out.println(totalRow+"<-- NoticeDao의 totalRow"); // 디버깅
		
		// list 생성	
		ArrayList<Notice> list = NoticeDao.selectNoticeListByPage(rowPerPage, beginRow);
	%>
			
	<!-- 한 페이지당 몇 개씩 볼건지 선택하는 기능 -->
	<form action="<%=request.getContextPath()%>/notice/noticeList.jsp" method="post">
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
	
	<!-- 공지 목록 테이블 -->
	<table border="1">
		<thead>
			<tr>
				<th>noticeNo</th>
				<th>noticeTitle</th>
				<th>managerId</th>
				<th>noticeDate</th>
			</tr>
		</thead>
		<tbody>
			<%
				for(Notice n : list) { // for each문
			%>
					<tr>
						<td><%=n.getNoticeNo()%></td>
						<!-- noticeTitle을 클릭하면 상세보기(noticeOne)으로 넘어감 -->
						<td><a href="<%=request.getContextPath()%>/notice/noticeOne.jsp?noticeNo=<%=n.getNoticeNo()%>"><%=n.getNoticeTitle()%></a></td>
						<td><%=n.getManagerId()%></td>
						<td><%=n.getNoticeDate().substring(0,11)%></td>
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
				<a href="<%=request.getContextPath()%>/notice/noticeList.jsp?currentPage=<%=currentPage-1%>&rowPerPage=<%=rowPerPage%>">이전</a>
	<%
		}
	
		// 맨 마지막 페이지에서 다음 버튼이 보이지 않도록 함
		int lastPage = totalRow / rowPerPage;
		if(totalRow % rowPerPage != 0) {
			lastPage += 1; // lastPage = lastPage+1; lastPage++;
		}
		
		if(currentPage < lastPage) {
	%>
			<a href="<%=request.getContextPath()%>/notice/noticeList.jsp?currentPage=<%=currentPage+1%>&rowPerPage=<%=rowPerPage%>">다음</a>
	<%
		}
	%>
</body>
</html>