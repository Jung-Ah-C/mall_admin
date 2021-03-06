<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="java.util.*" %>
<%
	// 주소창에 직접 치고 들어왔을 때, 못 들어오게 하는 기능 (로그인 기록이 없는 경우)
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if (manager == null) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	
	// managerLevel 이 낮은 경우, 못 보게 하는 기능	
	} else if(manager.getManagerLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
%>
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
	
	System.out.println(rowPerPage+"<-- managerList의 rowPerPage"); // 디버깅
	
	// 시작 행
	int beginRow = (currentPage - 1) * rowPerPage;
	
	// 전체 행의 개수
	int totalRow = ManagerDao.totalCount();
	System.out.println(totalRow+"<-- managerList의 totalRow"); // 디버깅
	
	// dao 실행해서 list 생성
	ArrayList<Manager> list = ManagerDao.selectManagerListByPage(rowPerPage, beginRow);
%>
<!DOCTYPE html>
<html>
<head>
<title>managerList</title>
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
</head>
<body>
	<!-- 관리자화면 메뉴(네비게이션) include -->
	<div>
		<!-- include 사용 시에 프로젝트명 필요없음 -->
		<jsp:include page="/adminMenu.jsp">
			<jsp:param name="current" value="manager"/>
		</jsp:include>
	</div>
<div id="app">
	<div id="main">
		<header class="mb-3">
	        <a href="#" class="burger-btn d-block d-xl-none">
	            <i class="bi bi-justify fs-3"></i>
	        </a>
	    </header>
	
	<h1><a href="<%=request.getContextPath()%>/manager/managerList.jsp">ManagerList</a></h1>
	<!-- manager 추가 버튼 -->
	<a href="<%=request.getContextPath()%>/manager/insertManagerForm.jsp"><button type="button" class="btn btn-outline-primary">Add a New Manager</button></a>
	
	<!-- 한 페이지당 몇 개씩 볼건지 선택 가능 (~개씩 보기) -->
	<form action="<%=request.getContextPath()%>/manager/managerList.jsp" method="post">
		<br>
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
	
	<!-- managerList 테이블 작성 -->
	<div class="page-content">
		<section class="row">
			<div class="row">
			    <div class="col-12">
			    	<div class="card">
						<div class="table-responsive">
							<table class="table table-lg">
								<thead>
									<tr>
										<th>ManagerNo</th>
										<th>ManagerID</th>
										<th>ManagerName</th>
										<th>ManagerDate</th>
										<th>ManagerLevel</th>
										<th>Delete</th>
									</tr>
								</thead>
								<tbody>
									<%
										for(Manager m : list) {
									%>
											<tr>
												<td><%=m.getManagerNo()%></td>
												<td><%=m.getManagerId()%></td>
												<td><%=m.getManagerName()%></td>
												<td><%=m.getManagerDate()%></td>
												<!-- managerLevel 수정을 같은 페이지에서 할 수 있게 함 -->
												<td>
													<form action="<%=request.getContextPath()%>/manager/updateManagerLevelAction.jsp" method="post">
														<input type="hidden" name="managerNo" value=<%=m.getManagerNo()%>>
														<input type="hidden" name="currentPage" value=<%=currentPage%>>
														<input type="hidden" name="rowPerPage" value=<%=rowPerPage%>>
														<select name="managerLevel">
															<%
																for(int i=0; i<3; i++) {
																	if(m.getManagerLevel() == i) {
															%>
																		<option value="<%=i%>" selected="selected"><%=i%></option>
															<%			
																	} else {
															%>
																		<option value="<%=i%>"><%=i%></option>
															<%			
																	}		
																}
															%>
														</select>
														<button type="submit" class="btn btn-sm btn btn-primary">Edit</button>
													</form>
												</td>
												<td><a href="<%=request.getContextPath()%>/manager/deleteManagerAction.jsp?managerNo=<%=m.getManagerNo()%>"><button type="button" class="btn btn-sm btn btn-primary">Delete</button></a></td>
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
	
	
	<!-- 페이징 (이전, 다음) 버튼 만들기 + 페이징 숫자 나오게 하기 -->
	<nav aria-label="Page navigation example">
		<ul class="pagination pagination-primary justify-content-center">
		<% 
			// 이전 버튼
			// 맨 첫 페이지에서 이전 버튼이 나오지 않게 함
			if(currentPage > 1) { // 첫 페이지가 아니라면
		%>
				<li class="page-item">
					<a class="page-link" href="<%=request.getContextPath()%>/manager/managerList.jsp?currentPage=<%=currentPage-1%>&rowPerPage=<%=rowPerPage%>">
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
				<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/manager/managerList.jsp?currentPage=<%=(pageRange*10)+i%>&rowPerPage=<%=rowPerPage%>"><%=(pageRange*10)+i%></a></li>
		<%
			} 
		%>
		
		<%
			// 다음 버튼
			// 맨 마지막 페이지에서 다음 버튼이 보이지 않도록 함
			if(totalRow % rowPerPage != 0) {
				lastPage += 1;
			}
			
			if(currentPage < lastPage) {
		%>
				<li class="page-item">
					<a class="page-link" href="<%=request.getContextPath()%>/manager/managerList.jsp?currentPage=<%=currentPage+1%>&rowPerPage=<%=rowPerPage%>">
						<span aria-hidden="true"><i class="bi bi-chevron-right"></i></span>
					</a>
				</li>
		<%
			}
		%>
		</ul>
	</nav>
	<!-- 페이징 끝 -->	
		
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