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

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/bootstrap.css">

    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/vendors/iconly/bold.css">

    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/vendors/perfect-scrollbar/perfect-scrollbar.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/vendors/bootstrap-icons/bootstrap-icons.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/app.css">
    <link rel="shortcut icon" href="<%=request.getContextPath()%>/assets/images/favicon.svg" type="image/x-icon">
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
<div id="app">
	<div id="main">
	<header class="mb-3">
    <a href="#" class="burger-btn d-block d-xl-none">
        <i class="bi bi-justify fs-3"></i>
    </a>
	</header>
	<h1><a href="<%=request.getContextPath()%>/client/clientList.jsp">ClientList</a></h1>
	
	<!-- 한 페이지당 몇 개씩 볼건지 선택가능 -->
	<form action="<%=request.getContextPath()%>/client/clientList.jsp" method="post">
		<!-- hidden 값으로 searchWord를 넘김 -->
		<input type="hidden" name="searchWord" value=<%=searchWord%>>
		<select name="rowPerPage">
			<%
				for(int i=10; i<31; i+=5) {
					if(rowPerPage == i) {
			%>
					<option value=<%=i%> selected="selected"><%=i%></option> 
			<%
					} else {
			%>
					<option value=<%=i%>><%=i%></option>
			<%	
					}
				}
			%>
		</select>
		<button type="submit" class="btn btn-sm btn btn-primary">entries per page</button>
	</form>
	
	<br>
	
	<!-- 고객 목록 테이블 -->
	<div class="page-content">
		<section class="row">
			<div class="row">
			    <div class="col-12">
				   	<div class="card">
						<div class="table-responsive">
							<table class="table table-lg">
								<thead>
									<tr>
										<th>ClientMail</th>
										<th>ClientDate</th>
										<th>Edit</th>
										<th>Delete</th>
									</tr>
								</thead>
								<tbody>
									<%
										for(Client c : list) {
									%>
											<tr>
												<td><%=c.getClientMail()%></td>
												<td><%=c.getClientDate().substring(0,11)%></td>
												<!-- 수정이나 삭제버튼에서 primary key 혹은 unique key인 정보가 해당 폼이나 액션으로 넘어가게 해줘야 함 -->
												<td><a href="<%=request.getContextPath()%>/client/updateClientForm.jsp?clientMail=<%=c.getClientMail()%>"><button type=button class="btn btn-sm btn btn-primary">Edit</button></a></td>
												<td><a href="<%=request.getContextPath()%>/client/deleteClientAction.jsp?clientMail=<%=c.getClientMail()%>"><button type=button class="btn btn-sm btn btn-primary">Delete</button></a></td>
											</tr>
									<%
										}
									%>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</section>
	</div>
	
	<!-- 페이징 (이전, 다음) 버튼 만들기 -->
	<nav aria-label="Page navigation example">
		<ul class="pagination pagination-primary justify-content-center">
		<% 
			// 이전 버튼
			// 맨 첫 페이지에서 이전 버튼이 나오지 않게 함
			if(currentPage > 1) {
		%>
				<li class="page-item">
					<a class="page-link" href="<%=request.getContextPath()%>/client/clientList.jsp?currentPage=<%=currentPage-1%>&rowPerPage=<%=rowPerPage%>&searchWord=<%=searchWord%>">
						<span aria-hidden="true"><i class="bi bi-chevron-left"></i></span>
					</a>
				</li>
		<%
			}
		%>
		
		<%
			// 페이징 번호 나오게 하기 위한 메소드 (1, 2, 3, ...)
			int lastPage = totalRow / rowPerPage;
			
		 	int pageRange = (currentPage - 1)/10;
			for (int i = 1; i <= 10; i++) {
				if((pageRange * 10) + i == (lastPage + 1)) {
					break;
				}
		%>
				<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/client/clientList.jsp?currentPage=<%=(pageRange*10)+i%>&rowPerPage=<%=rowPerPage%>"><%=(pageRange*10)+i%></a></li>
		<%
			} 
		%>
		
		<%
			// 다음 버튼
			// 맨 마지막 페이지에서 다음 버튼이 보이지 않도록 함
			if(totalRow % rowPerPage != 0) {
				lastPage += 1; // lastPage = lastPage+1; lastPage++;
			}
			
			if(currentPage < lastPage) {
		%>
				<li class="page-item">
					<a class="page-link" href="<%=request.getContextPath()%>/client/clientList.jsp?currentPage=<%=currentPage+1%>&rowPerPage=<%=rowPerPage%>&searchWord=<%=searchWord%>">
						<span aria-hidden="true"><i class="bi bi-chevron-right"></i></span>
					</a>
				</li>
		<%
			}
		%>
		</ul>
	</nav>
	<!-- 페이징 끝 -->
	
		<!-- 고객 메일 검색 기능 -->
		<form action="<%=request.getContextPath()%>/client/clientList.jsp" method="post">
			<!-- 검색할 때 몇개 볼건지 선택한 기능이 그대로 유지되게 함 -->
			<input type="hidden" name="rowPerPage" value="<%=rowPerPage%>">
			<div class="col-md-6">
				<input type="text" name="searchWord" placeholder="Search...">
				<button type="submit" class="btn btn-sm btn btn-primary">Search</button>
			</div>
		</form>
	
		<!-- 저작권 표시 -->
		<footer>
		       <div class="footer clearfix mb-0 text-muted">
		           <div class="float-start">
		               <p>2021 &copy; RiDi</p>
		           </div>
		           <div class="float-end">
		               <p>Made with <span class="text-danger"><i class="bi bi-heart"></i></span> by <a
		                       href="https://github.com/Jung-Ah-C">Jungah Choi</a></p>
		           </div>
		       </div>
		</footer>
	</div>
</div>
	
<script src="<%=request.getContextPath()%>/assets/vendors/perfect-scrollbar/perfect-scrollbar.min.js"></script>
<script src="<%=request.getContextPath()%>/assets/js/bootstrap.bundle.min.js"></script>

<script src="<%=request.getContextPath()%>/assets/vendors/apexcharts/apexcharts.js"></script>
<script src="<%=request.getContextPath()%>/assets/js/pages/dashboard.js"></script>

<script src="<%=request.getContextPath()%>/assets/js/main.js"></script>
</body>
</html>