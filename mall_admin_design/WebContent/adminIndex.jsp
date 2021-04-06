<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="gdu.mall.vo.*" %>
<%@ page import ="gdu.mall.dao.*" %>
<%@ page import ="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<title>adminIndex</title>
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
	<!-- 로그인이 안되어 있다면 로그인 창으로 보내기 (adminLogin.jsp) -->
	<%
		// session이 null이라는 것은 한번도 로그인을 한 적이 없다는 의미 --> 로그인 창으로 보냄
		if(session.getAttribute("sessionManager") == null) {
			response.sendRedirect(request.getContextPath()+"/adminLogin.jsp");
			return;
		}
	%>

<!-- 로그인 후의 화면 구현 -->
<div id="app">
	<!-- 관리자화면 메뉴(네비게이션) include -->
	<div>
		<jsp:include page="/adminMenu.jsp">
			<jsp:param name="current" value="adminIndex"/>
		</jsp:include> <!-- include 사용 시에 프로젝트명 필요없음 -->
	</div>
			
		<!-- 
			- 2가지 화면을 분기
			
			- 로그인 정보는 Manager자료형 세션변수(sessionManager)를 이용
			1) 관리자 로그인 폼
			2) 관리자 인증 화면 & 몰 메인페이지
		-->
	<%
		// 세션이 null이 아닌 경우, 로그인을 함 --> ~님 반갑습니다 멘트, 레벨 정보 + 관리자화면 메뉴 + 로그아웃 링크
	
		Manager manager = (Manager)(session.getAttribute("sessionManager")); // Manager 클래스 타입의 manager라는 변수에 session 결과를 담음?
	
		// Dao 호출
		ArrayList<Notice> noticeList = NoticeDao.selectNoticeListByPage(5, 0);
		ArrayList<Manager> managerList = ManagerDao.selectManagerListByPage(5, 0);
		ArrayList<Client> clientList = ClientDao.selectClientListByPage(5, 0, "");
		ArrayList<Ebook> ebookList = EbookDao.selectEbookListByPage(5, 0, null);
		ArrayList<OrdersAndEbookAndClient> oecList = OrdersDao.selectOrdersListByPage(5, 0);
	%>
	    <!-- 페이지 작게 했을 때 뜨는 사이드바 열고 닫는 버튼 -->
	        <div id="main">
	            <header class="mb-3">
	                <a href="#" class="burger-btn d-block d-xl-none">
	                    <i class="bi bi-justify fs-3"></i>
	                </a>
	            </header>
				<!-- 로그인 한 관리자 정보 표시 -->
	            <div class="page-heading col-12 col-lg-3">
					<div class="card">
					    <div class="card-body py-4 px-5">
					        <div class="d-flex align-items-center">
					            <div class="avatar avatar-xl">
					                <img src="assets/images/faces/1.jpg" alt="Face 1">
					            </div>
					            <div class="ms-3 name">
					                <h5 class="font-bold"><%=manager.getManagerName()%></h5>
					                <h6 class="text-muted mb-0">Level : <%=manager.getManagerLevel()%></h6>
					            </div>
					        </div>
					    </div>
					</div>
				</div>
				
				<!-- 최근 자료 대시보드 -->
				<h3>Dashboard</h3>
	            <div class="page-content">
	                <section class="row">
	                        <div class="row">
	                            <!-- noticeList 테이블 -->
	                            <div class="col-12 col-md-6">
	                                <div class="card">
		                                <div class="card-header">
		                                    <h4 class="card-title">NoticeList&nbsp;<a href="<%=request.getContextPath()%>/notice/noticeList.jsp" class="btn btn-sm btn-outline-primary">more</a></h4>
		                                </div>
	                                    <div class="card-body">
	                                        <div class="table-responsive">
	                                        <table class="table table-lg">
														<tr>
															<th>NoticeNo</th>
															<th>NoticeTitle</th>
															<th>ManagerID</th>
														</tr>
												<%
													for(Notice n : noticeList) {
												%>
														<tr>
															<td><%=n.getNoticeNo()%></td>
															<td><%=n.getNoticeTitle()%></td>
															<td><%=n.getManagerId()%></td>
														</tr>
												<%
													}
												%>
											</table>
	                                        </div>
	                                    </div>
	                                </div>
	                            </div>
	                            <!-- managerList 테이블 -->
	                            <div class="col-12 col-md-6">
	                                <div class="card">
		                                <div class="card-header">
		                                    <h4 class="card-title">ManagerList&nbsp;<a href="<%=request.getContextPath()%>/manager/managerList.jsp" class="btn btn-sm btn-outline-primary">more</a></h4>
		                                </div>
	                                    <div class="card-body">
	                                        <div class="table-responsive">
	                                        <table class="table table-lg">
														<tr>
															<th>ManagerNo</th>
															<th>ManagerID</th>
															<th>ManagerName</th>
														</tr>
												<%
													for(Manager m : managerList) {
												%>
														<tr>
															<td><%=m.getManagerNo()%></td>
															<td><%=m.getManagerId()%></td>
															<td><%=m.getManagerName()%></td>
														</tr>
												<%
													}
												%>
											</table>
	                                        </div>
	                                    </div>
	                                </div>
	                            </div>
	                        </div>
						</section>
						<section class="row">
							<div class="row">
	                            <!-- clientList 테이블 -->
	                            <div class="col-12 col-md-6">
	                                <div class="card">
		                                <div class="card-header">
		                                    <h4 class="card-title">ClientList&nbsp;<a href="<%=request.getContextPath()%>/client/clientList.jsp" class="btn btn-sm btn-outline-primary">more</a></h4>
		                                </div>
	                                    <div class="card-body">
	                                        <div class="table-responsive">
	                                        <table class="table table-lg">
														<tr>
															<th>ClientMail</th>
															<th>ClientDate</th>
														</tr>
												<%
													for(Client c : clientList) {
												%>
														<tr>
															<td><%=c.getClientMail()%></td>
															<td><%=c.getClientDate().substring(0,11)%></td>
														</tr>
												<%
													}
												%>
											</table>
	                                        </div>
	                                    </div>
	                                </div>
	                            </div>
	                            <!-- ebookList 테이블 -->
	                            <div class="col-12 col-md-6">
	                                <div class="card">
		                                <div class="card-header">
		                                    <h4 class="card-title">EbookList&nbsp;<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp" class="btn btn-sm btn-outline-primary">more</a></h4>
		                                </div>
	                                    <div class="card-body">
	                                        <div class="table-responsive">
	                                        <table class="table table-lg">
														<tr>
															<th>CategoryName</th>
															<th>EbookTitle</th>
															<th>EbookAuthor</th>
															<th>EbookPrice</th>
														</tr>
												<%
													for(Ebook e : ebookList) {
												%>
														<tr>
															<td><%=e.getCategoryName()%></td>
															<td><%=e.getEbookTitle()%></td>
															<td><%=e.getEbookAuthor()%></td>
															<td><%=e.getEbookPrice()%>원</td>
														</tr>
												<%
													}
												%>
											</table>
	                                        </div>
	                                    </div>
	                                </div>
	                            </div>
	                        </div>
						</section>
						<section class="row">
							<div class="row">
	                            <!-- orderList 테이블 -->
	                            <div class="col-12 col-md-6">
	                                <div class="card">
		                                <div class="card-header">
		                                    <h4 class="card-title">OrderList&nbsp;<a href="<%=request.getContextPath()%>/orders/ordersList.jsp" class="btn btn-sm btn-outline-primary">more</a></h4>
		                                </div>
	                                    <div class="card-body">
	                                        <div class="table-responsive">
	                                        <table class="table table-lg">
														<tr>
															<th>OrdersNo</th>
															<th>EbookTitle</th>
															<th>ClientMail</th>
														</tr>
												<%
													for(OrdersAndEbookAndClient oec : oecList) {
												%>
														<tr>
															<td><%=oec.getOrders().getOrdersNo()%></td>
															<td><%=oec.getEbook().getEbookTitle()%></td>
															<td><%=oec.getClient().getClientMail()%></td>
														</tr>
												<%
													}
												%>
											</table>
	                                        </div>
	                                    </div>
	                                </div>
	                            </div>
							</div>
						</section>
	            </div> <!-- page-content 끝 -->
	
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