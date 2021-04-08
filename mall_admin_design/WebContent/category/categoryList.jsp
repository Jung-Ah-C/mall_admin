<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="java.util.*" %>
<%
	// 매니저 레벨 1 이상만 카테고리 목록에 접근할 수 있게 함
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
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/bootstrap.css">

    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/vendors/iconly/bold.css">

    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/vendors/perfect-scrollbar/perfect-scrollbar.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/vendors/bootstrap-icons/bootstrap-icons.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/app.css">
    <link rel="shortcut icon" href="<%=request.getContextPath()%>/assets/images/favicon.svg" type="image/x-icon">
<title>categoryList</title>
</head>
<body>
	<!-- 관리자화면 메뉴(네비게이션) include -->
	<div>
		<!-- include 사용 시에 프로젝트명 필요없음 -->
		<jsp:include page="/adminMenu.jsp">
			<jsp:param name="current" value="category"/>
		</jsp:include>
	</div>
	
	<% // CategoryDao에 있는 ArrayList을 사용하기 위해서 불러옴
		ArrayList<Category> list = CategoryDao.selectCategoryList();
	%>
	
	<!-- 페이징 X, 검색어 X -->
	<!-- 카테고리 목록 테이블 -->
<div id="app">
	<div id="main">
		
		<header class="mb-3">
	        <a href="#" class="burger-btn d-block d-xl-none">
	            <i class="bi bi-justify fs-3"></i>
	        </a>
	    </header>
	
	<h1><a href="<%=request.getContextPath()%>/category/categoryList.jsp">CategoryList</a></h1>
	<!-- category 추가 버튼 -->
	<a href="<%=request.getContextPath()%>/category/insertCategoryForm.jsp"><button type="button" class="btn btn-outline-primary">Add New Category</button></a>
	
	<!-- Category 테이블 -->
	<div class="page-content">
		<br>
		<section class="row">
			<div class="row">
				<div class="col-12">
					<div class="card">
						<div class="table-responsive">
							<table class="table table-lg">
								<thead>
									<tr>
										<th>CategoryName</th>
										<th>CategoryWeight</th> <!-- managerlevel 수정한 것처럼 weight도 수정할 수 있게 함 -->
										<th>Delete</th>
									</tr>
								</thead>
								<tbody>
									<%
										for(Category c : list) {
									%>
											<tr>
												<td><%=c.getCategoryName()%></td>
												<td>
													<form action="<%=request.getContextPath()%>/category/updateCategoryWeightAction.jsp" method="post">
														<!-- categoryWeight를 수정할 때, 어떤 행을 수정할지 구분짓기 위해서 categoryNo도 같이 Action으로 넘김 (안보이게 하기 위해서 hidden 기능 사용!) -->
														<input type="hidden" name="categoryNo" value=<%=c.getCategoryNo()%>>
														<select name="categoryWeight">
															<%
																for(int i=0; i<11; i++) {
																	if(c.getCategoryWeight() == i) {
															%>
																		<!-- 가중치 변경시에 선택된 가중치 값으로 나오게 함 -->
																		<option value="<%=i%>" selected="selected"><%=i%></option>
															<%			
																	} else {
															%>
																		<!-- 기본 가중치는 0으로 함 -->
																		<option value="<%=i%>"><%=i%></option>
															<%			
																	}		
																}
															%>
														</select>
														<button type="submit" class="btn btn-sm btn btn-primary">Edit</button>
													</form>
												</td>
												<!-- 삭제할 때 기준이 되는 키는 categoryName 으로 함, categoryNo는 계속 변하니까 -->
												<td><a href="<%=request.getContextPath()%>/category/deleteCategoryAction.jsp?categoryName=<%=c.getCategoryName()%>"><button type=button class="btn btn-sm btn btn-primary">Delete</button></a></td>
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