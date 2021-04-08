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
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/bootstrap.css">

    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/vendors/iconly/bold.css">

    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/vendors/perfect-scrollbar/perfect-scrollbar.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/vendors/bootstrap-icons/bootstrap-icons.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/app.css">
    <link rel="shortcut icon" href="<%=request.getContextPath()%>/assets/images/favicon.svg" type="image/x-icon">
<title>updateClientForm</title>
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
	
	<!-- 제목 클릭 시 clientList로 돌아감 -->
	<h1><a href="<%=request.getContextPath()%>/client/clientList.jsp">ClientList</a></h1>
	
	<!-- clientMail 변수 가져오기 -->
	<%
	String clientMail= request.getParameter("clientMail");
	%>
	
	<div class="row match-height">
		<div class="col-md-6 col-12">
			<div class="card">
				<div class="card-header">
                    <h4 class="card-title">UpdateClientForm</h4>
                </div>
				<div class="card-content">
					<div class="card-body">
						<form action="<%=request.getContextPath()%>/client/updateClientAction.jsp" method="post" class="form form-vertical">
							<div class="form-body">
								<div class="row">
									<div class="col-md-4">
										<label for="clientMail">Client e-mail</label>
									</div>
									<div class="col-md-8 form-group">
										<input type="text" id="clientMail" class="form-control" readonly="readonly" placeholder="<%=clientMail%>">
									</div>
									<div class="col-md-4">
										<label for="clientPw">Client Password</label>
									</div>
									<div class="col-md-8 form-group">
										<!-- clientMail 값을 clientAction으로 넘기되, 보이지 않게 처리함 -->
										<input type="hidden" name="clientMail" value="<%=clientMail%>">
										<input type="password" class="form-control" required="required" id="clientPw">
									</div>
									<div class="col-sm-12 d-flex justify-content-end">
										<button type="submit" class="btn btn-primary me-1 mb-1">Submit</button>
										<button type="reset" class="btn btn-light-secondary me-1 mb-1">Reset</button>
									</div>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
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