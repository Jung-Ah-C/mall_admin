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
<title>updateEbookSummaryForm</title>
</head>
<body>
	<!-- 관리자화면 메뉴(네비게이션) include -->
	<div>
		<!-- include 사용 시에 프로젝트명 필요없음 -->
		<jsp:include page="/adminMenu.jsp">
			<jsp:param name="current" value="ebook"/>
		</jsp:include>
	</div>

	<!-- 카테고리별 목록을 볼 수 있는 메뉴(네비게이션) -->
	<div>
		<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp">[전체]</a>
		<%
			ArrayList<String> categoryNameList = CategoryDao.categoryNameList();
			System.out.println(categoryNameList.size()+" <-- insertEbookForm의 categoryNameList.size");
			for(String s : categoryNameList){
		%>
				<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp?categoryName=<%=s%>">[<%=s%>]</a>
		<%
			}
		%>
	</div>
	
	<%
		// 수집
		String ebookISBN = request.getParameter("ebookISBN");
		System.out.printf(ebookISBN+"<-- updateEbookSummaryForm의 ebookISBN");
		
		// dao연결
		Ebook ebook = EbookDao.selectEbookOne(ebookISBN);
	%>
	<h1>updateEbookSummaryForm</h1>
	<form action="<%=request.getContextPath()%>/ebook/updateEbookSummaryAction.jsp">
		<input type="hidden" name="ebookISBN" value="<%=ebookISBN%>">
		<table border="1">
			<tr>
				<td>ebookSummary</td>
				<td>
					<textarea rows="5" cols="80" name="ebookSummary"><%=ebook.getEbookSummary()%></textarea>
				</td>
			</tr>
		</table>
		<button type="submit">수정</button>
	</form>
</body>
</html>