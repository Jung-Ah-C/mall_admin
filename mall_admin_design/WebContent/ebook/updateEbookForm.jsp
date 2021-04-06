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
<title>updateEbookForm</title>
</head>
<body>
	<!-- 관리자화면 메뉴(네비게이션) include -->
	<div>
		<!-- include 사용 시에 프로젝트명 필요없음 -->
		<jsp:include page="/adminMenu.jsp">
			<jsp:param name="current" value="ebook"/>
		</jsp:include>
	</div>
		
		<!-- 카테고리 눌렀을 때, 카테고리별로 리스트를 나오게 함 (네비게이션) -->
		<div>
			<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp">[전체]</a>
			<%
				ArrayList<String> categoryNameList = CategoryDao.categoryNameList();
				for(String s : categoryNameList) {
			%>
					<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp?categoryName=<%=s%>">[<%=s%>]</a>
			<%
				}
			%>
		</div>
		
		
		<!-- Dao에서 데이터 가져오기 -->
		<%
			// 수집
			String ebookISBN = request.getParameter("ebookISBN");
			
			// 디버깅
			System.out.println(ebookISBN+"<-- updateEbookForm의 ebookISBN");
			
			// dao연결
			Ebook ebook = EbookDao.selectEbookOne(ebookISBN);
			System.out.println(ebook);
			
			// ebookStateList 배열 가져오기
			String[] ebookStateList = EbookDao.ebookStateList();
		%>
	
	<h1>updateEbookForm</h1>
	<form action="<%=request.getContextPath()%>/ebook/updateEbookAction.jsp" method="post">
		<table border="1">
			<tr>
				<td>ebookNo</td>
				<td><%=ebook.getEbookNo()%></td>
			</tr>
			<tr>
				<td>
					CategoryName
				</td>
				<td>
					<select name="categoryName">
						<%
							for(String cn : categoryNameList) {
						%>
								<option value="<%=cn%>"><%=cn%></option>
						<%
							}
						%>
					</select>
				</td>
			</tr>
			<tr>
				<td>
					ebookTitle
				</td>
				<td>
					<input type="text" name="ebookTitle" value="<%=ebook.getEbookTitle()%>">
				</td>
			</tr>
			<tr>
				<td>
					ebookState
				</td>
				<td>
					<input type="hidden" value="<%=ebook.getEbookISBN()%>" name="ebookISBN">
						<select name="ebookState">
						<%
							for(int i = 0; i < ebookStateList.length; i++) {
								if(ebookStateList[i].equals(ebook.getEbookState())) {
						%>
									<option value="<%=ebookStateList[i]%>" selected = "selected"><%=ebookStateList[i]%></option>
						<%			
								} else {
						%>
									<option value="<%=ebookStateList[i]%>"><%=ebookStateList[i]%></option>
						<%
								}
						
							}
						%>
						</select>
				</td>
			</tr>
			<tr>
				<td>
					ebookAuthor
				</td>
				<td>
					<input type="text" name="ebookAuthor" value=<%=ebook.getEbookAuthor()%>>
				</td>
			</tr>
			<tr>
				<td>
					ebookISBN
				</td>
				<td><%=ebook.getEbookISBN()%></td>
			</tr>
			<tr>
				<td>
					ebookCompany
				</td>
				<td>
					<input type="text" name="ebookCompany" value=<%=ebook.getEbookCompany()%>>
				</td>
			</tr>
			<tr>
				<td>
					ebookDate
				</td>
				<td><%=ebook.getEbookDate().substring(0,11)%></td>
			</tr>
			<tr>
				<td>
					ebookSummary
				</td>
				<td>
					<textarea rows="5" cols="80" name="ebookSummary"><%=ebook.getEbookSummary()%></textarea>
				</td>
			</tr>
			<tr>
				<td>
					ebookPrice
				</td>
				<td>
					<input type="text" name="ebookPrice" value="<%=ebook.getEbookPrice()%>">
				</td>
			</tr>
			<tr>
				<td>
					ebookPageCount
				</td>
				<td>
					<input type="text" name="ebookPageCount" value="<%=ebook.getEbookPageCount()%>">
				</td>
			</tr>
		</table>
		<button type="submit">ebook 수정</button>
	</form>
</body>
</html>