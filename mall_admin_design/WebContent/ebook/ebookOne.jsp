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
<title>ebookOne</title>
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
			for(String s : categoryNameList){
		%>
				<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp?categoryName=<%=s%>">[<%=s%>]</a>
		<%
			}
		%>
		<%
		
			//수집
			String ebookISBN = request.getParameter("ebookISBN");
			System.out.printf("ebookISBN: %s<ebookOne.jsp>\n",ebookISBN);
			
			//dao연결
			Ebook ebook = EbookDao.selectEbookOne(ebookISBN);
			System.out.println(ebook);
			
			// ebookStateList 배열 가져오기
			String[] ebookStateList = EbookDao.ebookStateList();
		%>
	</div>

	<h1>ebookOne</h1>
	<table border="1">
		<tr>
			<th>ebookNO</th>
			<td><%=ebook.getEbookNo()%></td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<th>categoryName</th>
			<td><%=ebook.getCategoryName()%></td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<th>ebookTitle</th>
			<td><%=ebook.getEbookTitle()%></td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<th>ebookState</th>
			<td><%=ebook.getEbookState()%></td>
			<td>
				<form action="<%=request.getContextPath()%>/ebook/updateEbookStateAction.jsp" method="post">
					<!-- 
						값을 넘기기 위해서는 name을 꼭 지정해줘야 함!
						Form에서 사용한 name을 가지고 Action에서 받아야 함
					 -->
					<input type="hidden" value="<%=ebookISBN%>" name="ebookISBN">
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
					<button type="submit">책상태 수정</button>
				</form>
			</td>
		</tr>
		<tr>
			<th>ebookAuthor</th>
			<td><%=ebook.getEbookAuthor()%></td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<th>ebookImg</th>
			<td><img src="<%=request.getContextPath()%>/img/<%=ebook.getEbookImg()%>"></td>
			<td>
				<a href="<%=request.getContextPath()%>/ebook/updateEbookImgForm.jsp?ebookISBN=<%=ebookISBN%>">
					<button type="button">이미지 수정</button>
				</a>
			</td>
		</tr>
		<tr>
			<th>ebookISBN</th>
			<td><%=ebook.getEbookISBN()%></td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<th>ebookCompany</th>
			<td><%=ebook.getEbookCompany()%></td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<th>ebookDate</th>
			<td><%=ebook.getEbookDate().substring(0,11)%></td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<th>ebookSummary</th>
			<td><%=ebook.getEbookSummary()%></td>
			<td>
				<a href="<%=request.getContextPath()%>/ebook/updateEbookSummaryForm.jsp?ebookISBN=<%=ebookISBN%>">
					<button type="button">책요약 수정</button>
				</a>
			</td>
		</tr>
		<tr>
			<th>ebookPrice</th>
			<td><%=ebook.getEbookPrice()%></td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<th>ebookPageCount</th>
			<td><%=ebook.getEbookPageCount()%></td>
			<td>&nbsp;</td>
		</tr>
	</table>
	
	<a href="<%=request.getContextPath()%>/ebook/updateEbookForm.jsp?ebookISBN=<%=ebookISBN%>">
		<button type="button">전체 수정(이미지 제외)</button>
	</a>
		
	<a href="<%=request.getContextPath()%>/ebook/deleteEbookAction.jsp?ebookISBN=<%=ebookISBN%>">
		<button type="button">삭제</button>
	</a>
</body>
</html>