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
<div id="app">
	<div id="main">
	
	<header class="mb-3">
	    <a href="#" class="burger-btn d-block d-xl-none">
	        <i class="bi bi-justify fs-3"></i>
	    </a>
    </header>
	
	<h1><a href="<%=request.getContextPath()%>/ebook/ebookList.jsp">E-bookList</a></h1>
	
		<!-- ebookOne 테이블 -->
		<div class="row match-height">
			<div class="col-md-6 col-12">
				<div class="card">
					<div class="card-header">
				        <h4 class="card-title">E-bookOne</h4>
				        <p class="card-text">E-book Information</p>
				    </div>
					<div class="card-content">
					<div class="table-responsive">
						<table class="table table-lg">
							<tr>
								<th>ebookNo</th>
								<td><%=ebook.getEbookNo()%></td>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<th>CategoryName</th>
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
										<button type="submit" class="btn btn-sm btn btn-primary">Edit</button>
									</form>
								</td>
							</tr>
							<tr>
								<th>ebookAuthor</th>
								<td><%=ebook.getEbookAuthor()%></td>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<th>ebookImage</th>
								<td><img src="<%=request.getContextPath()%>/img/<%=ebook.getEbookImg()%>"></td>
								<td>
									<a href="<%=request.getContextPath()%>/ebook/updateEbookImgForm.jsp?ebookISBN=<%=ebookISBN%>">
										<button type="button" class="btn btn-sm btn btn-primary">Edit</button>
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
										<button type="button" class="btn btn-sm btn btn-primary">Edit</button>
									</a>
								</td>
							</tr>
							<tr>
								<th>ebookPrice</th>
								<td><%=ebook.getEbookPrice()%>원</td>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<th>ebookPageCount</th>
								<td><%=ebook.getEbookPageCount()%></td>
								<td>&nbsp;</td>
							</tr>
						</table>
					</div>
					</div>
				</div>
			</div>
		</div>
	
	<a href="<%=request.getContextPath()%>/ebook/updateEbookForm.jsp?ebookISBN=<%=ebookISBN%>">
		<button type="button" class="btn btn-primary">All Edit (Except For Image)</button>
	</a>
		
	<a href="<%=request.getContextPath()%>/ebook/deleteEbookAction.jsp?ebookISBN=<%=ebookISBN%>">
		<button type="button" class="btn btn-primary">Delete</button>
	</a>
	
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