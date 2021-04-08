<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="java.util.*" %>
<%
	// 레벨 1 이상만 ebook 리스트 열람 가능
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
	
	// 시작 행
	int beginRow = (currentPage - 1) * rowPerPage;
	
	// 전체 행의 개수
	int totalRow = EbookDao.totalCount();
	System.out.println(totalRow+"<-- EbookDao의 totalRow"); // 디버깅
	
	// 카테고리 변수 초기화
	String categoryName = null;
	
	// 카테고리별 목록 (카테고리 누른 값을 DAO로 넘겨줌)
      	if(request.getParameter("categoryName") != null){
         categoryName = request.getParameter("categoryName");
         }
	System.out.println(categoryName+"<-- ebookList의 categoryName"); // 디버깅
	
	// list 생성 (categoryName에 누른 값이 들어감)
	ArrayList<Ebook> ebookList = EbookDao.selectEbookListByPage(rowPerPage, beginRow, categoryName);
	ArrayList<String> CategoryList = CategoryDao.categoryNameList();
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
<title>ebookList</title>
</head>
<body>
	<!-- 관리자화면 메뉴(네비게이션) include -->
	<div>
		<!-- include 사용 시에 프로젝트명 필요없음 -->
		<jsp:include page="/adminMenu.jsp">
			<jsp:param name="current" value="ebook"/>
		</jsp:include>
	</div>
<div id="app">
	<div id="main">
		
		<header class="mb-3">
	        <a href="#" class="burger-btn d-block d-xl-none">
	            <i class="bi bi-justify fs-3"></i>
	        </a>
	    </header>
	
	<h1><a href="<%=request.getContextPath()%>/ebook/ebookList.jsp">E-bookList</a></h1>
	
	<!-- 카테고리 눌렀을 때, 카테고리별로 E-book 목록 나오게 함-->
	<div>
		<nav aria-label="breadcrumb">
			<ol class="breadcrumb">
				<li class="breadcrumb-item">
					<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp">All</a>
				</li>
				<%
            		for(String e : CategoryList) {
				%>
						<li class="breadcrumb-item">
							<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp?categoryName=<%=e%>"><%=e%></a>
						</li>
            	<%
            		}
				%>
			</ol>
		</nav>
	</div>
	
	<!-- e-book 추가 버튼 -->
	<a href="<%=request.getContextPath()%>/ebook/insertEbookForm.jsp"><button type="button" class="btn btn-outline-primary">Add a New E-book</button></a>
			
	<!-- 한 페이지당 몇 개씩 볼건지 선택가능 / 카테고리 선택 반영 안됨 -->
	<form action="<%=request.getContextPath()%>/ebook/ebookList.jsp" method="post">
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
	
	<!-- e-book 목록 테이블 작성 -->
	<div class="page-content">
		<section class="row">
			<div class="row">
			    <div class="col-12">
				   	<div class="card">
						<div class="table-responsive">
							<table class="table table-lg">
								<thead>
									<tr>
										<th>CategoryName</th>
										<th>E-bookISBN</th>
										<th>E-bookTitle</th>
										<th>E-bookAuthor</th>
										<th>E-bookDate</th>
										<th>E-bookPrice</th>
									</tr>
								</thead>
								<tbody>
									<%
										for(Ebook e : ebookList) {
									%>
											<tr>
												<td><%=e.getCategoryName()%></td>
												<td><%=e.getEbookISBN()%></td>
												<!-- ebookTitle을 누르면 상세정보로 넘어가게 링크 걸음 -->
												<!-- primary key를 안받아와서, 대신 ISBN으로 대체함 -->
												<td><a href="<%=request.getContextPath()%>/ebook/ebookOne.jsp?ebookISBN=<%=e.getEbookISBN()%>"><%=e.getEbookTitle()%></a></td>
												<td><%=e.getEbookAuthor()%></td>
												<td><%=e.getEbookDate().substring(0,11)%></td>
												<td><%=e.getEbookPrice()%>원</td>
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
	
	<!-- 페이징 (이전, 다음) 버튼 만들기 + 페이징 숫자 나오게 하기 + 카테고리별로 눌렀을 때 조건문으로 구분 -->
	<nav aria-label="Page navigation example">
		<ul class="pagination pagination-primary justify-content-center">
		<% 
			// 이전 버튼
			// 맨 첫 페이지에서 이전 버튼이 나오지 않게 함
			if(currentPage > 1) {
		%>
				<li class="page-item">
		<%			
				if(categoryName == null) {
		%>
					<a class="page-link" href="<%=request.getContextPath()%>/ebook/ebookList.jsp?currentPage=<%=currentPage-1%>&rowPerPage=<%=rowPerPage%>">
						<span aria-hidden="true"><i class="bi bi-chevron-left"></i></span>
					</a>
		<%
				} else {
		%>			
					<a class="page-link" href="<%=request.getContextPath()%>/ebook/ebookList.jsp?currentPage=<%=currentPage-1%>&rowPerPage=<%=rowPerPage%>&categoryName=<%=categoryName%>">
						<span aria-hidden="true"><i class="bi bi-chevron-left"></i></span>
					</a>
		<%
				}
		%>
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
				if(categoryName == null) {
		%>
					<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/ebook/ebookList.jsp?currentPage=<%=(pageRange*10)+i%>&rowPerPage=<%=rowPerPage%>"><%=(pageRange*10)+i%></a></li>
		<%
				} else {
		%>
					<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/ebook/ebookList.jsp?currentPage=<%=(pageRange*10)+i%>&rowPerPage=<%=rowPerPage%>&categoryName=<%=categoryName%>"><%=(pageRange*10)+i%></a></li>
		<%	
				}
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
		<%
				if(categoryName == null) {
		%>
					<a class="page-link" href="<%=request.getContextPath()%>/ebook/ebookList.jsp?currentPage=<%=currentPage+1%>&rowPerPage=<%=rowPerPage%>">
						<span aria-hidden="true"><i class="bi bi-chevron-right"></i></span>
					</a>
		<%
				} else {
		%>
					<a class="page-link" href="<%=request.getContextPath()%>/ebook/ebookList.jsp?currentPage=<%=currentPage+1%>&rowPerPage=<%=rowPerPage%>&categoryName=<%=categoryName%>">
						<span aria-hidden="true"><i class="bi bi-chevron-right"></i></span>
					</a>
		<%
				}
		%>
				</li>
		<%
			}
		%>
		</ul>
	</nav>
	<!-- 페이징 끝! -->
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