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

<div id="app">
	<div id="main">
		
		<header class="mb-3">
	        <a href="#" class="burger-btn d-block d-xl-none">
	            <i class="bi bi-justify fs-3"></i>
	        </a>
	    </header>
	
	<h1><a href="<%=request.getContextPath()%>/notice/noticeList.jsp">NoticeList</a></h1>
	
	<!-- 공지 추가 버튼 -->
	<a href="<%=request.getContextPath()%>/notice/insertNoticeForm.jsp"><button type="button" class="btn btn-outline-primary">Add New Notice</button></a>
			
	<!-- 한 페이지당 몇 개씩 볼건지 선택하는 기능 -->
	<form action="<%=request.getContextPath()%>/notice/noticeList.jsp" method="post">
		<br>
		<select name="rowPerPage">
			<%
				for(int i=10; i<31; i+=5) {
					if(rowPerPage == i) {
			%>
					<!-- 옵션에서 선택한 개수만큼의 행이 보이게 함 -->
					<option value=<%=i%> selected="selected"><%=i%></option> 
			<%
					} else {
			%>
					<!-- 옵션 선택이 되어 있지 않으면 rowPerPage 설정 값으로 보이게 함 -->
					<option value=<%=i%>><%=i%></option>
			<%	
					}
				}
			%>
		</select>
		<button type="submit" class="btn btn-sm btn btn-primary">entries per page</button>
	</form>
	
	<br>
	
	<!-- 공지 목록 테이블 -->
	<div class="page-content">
		<section class="row">
			<div class="row">
			    <div class="col-12">
				   	<div class="card">
						<div class="table-responsive">
							<table class="table table-lg">
								<thead>
									<tr>
										<th>NoticeNo</th>
										<th>NoticeTitle</th>
										<th>ManagerID</th>
										<th>NoticeDate</th>
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
			if(currentPage > 1) {
		%>
				<li class="page-item">
					<a class="page-link" href="<%=request.getContextPath()%>/notice/noticeList.jsp?currentPage=<%=currentPage-1%>&rowPerPage=<%=rowPerPage%>">
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
					<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/notice/noticeList.jsp?currentPage=<%=(pageRange*10)+i%>&rowPerPage=<%=rowPerPage%>"><%=(pageRange*10)+i%></a></li>
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
					<a class="page-link" href="<%=request.getContextPath()%>/notice/noticeList.jsp?currentPage=<%=currentPage+1%>&rowPerPage=<%=rowPerPage%>">
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