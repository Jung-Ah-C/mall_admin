<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 메뉴의 active를 주기 위해서 각 메뉴의 value 값을 받아옴
	String current = request.getParameter("current");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>adminMenu(사이드바)</title>

    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="assets/css/bootstrap.css">

    <link rel="stylesheet" href="assets/vendors/iconly/bold.css">

    <link rel="stylesheet" href="assets/vendors/perfect-scrollbar/perfect-scrollbar.css">
    <link rel="stylesheet" href="assets/vendors/bootstrap-icons/bootstrap-icons.css">
    <link rel="stylesheet" href="assets/css/app.css">
    <link rel="shortcut icon" href="assets/images/favicon.svg" type="image/x-icon">
</head>
<body>

<!-- sidebar menu (네비게이션 메뉴) -->
<div id="sidebar" class="active">
            <div class="sidebar-wrapper active">
                <div class="sidebar-header">
                    <div class="d-flex justify-content-between">
                        <div class="logo">
                            <a href="<%=request.getContextPath()%>/adminIndex.jsp"><img src="<%=request.getContextPath()%>/img/logo1.jpg" alt="Logo" srcset=""></a>
                        </div>
                        <div class="toggler">
                            <a href="#" class="sidebar-hide d-xl-none d-block"><i class="bi bi-x bi-middle"></i></a>
                        </div>
                    </div>
                </div>
                <div class="sidebar-menu">
                    <ul class="menu">
                        <li class="sidebar-title">Menu</li>
                        
						<!-- adminIndex.jsp 메뉴버튼 (운영자 홈) -->
						<!-- 메뉴 이름 앞에 있는 아이콘은 i class를 변경하면 됨 -->
                        <%
                        	if(current.equals("adminIndex")) {
                        %>
                        		<li class="sidebar-item active">
                        <% } else { %>
                        		<li class="sidebar-item">
                        <% } %>
                            <a href="<%=request.getContextPath()%>/adminIndex.jsp" class='sidebar-link'>
                                <i class="bi bi-grid-fill"></i>
                                <span>Dashboard</span>
                            </a>
                        </li>
						
						<!-- Manager (관리자 메뉴) -->
                        <%
                        	if(current.equals("manager")) {
                        %>
                        		<li class="sidebar-item active">
                        <% } else { %>
                        		<li class="sidebar-item">                   
                        <% } %>
                            <a href="<%=request.getContextPath()%>/manager/managerList.jsp" class='sidebar-link'>
                                <i class="bi bi-person-badge-fill"></i>
                                <span>Manager</span>
                            </a>
                        </li>
						
						<!-- Client (고객 메뉴) -->
                        <%
                        	if(current.equals("client")) {
                        %>
                        		<li class="sidebar-item active">
                        <% } else { %>
                        		<li class="sidebar-item">
                        <% } %>
                            <a href="<%=request.getContextPath()%>/client/clientList.jsp" class='sidebar-link'>
                                <i class="bi bi-file-earmark-medical-fill"></i>
                                <span>Client</span>
                            </a>
                        </li>
						
						<!-- Category (상품 카테고리) -->
                        <%
                        	if(current.equals("category")) {
                        %>
                        		<li class="sidebar-item active">
                        <% } else { %>
                        		<li class="sidebar-item">
                        <% } %>
                            <a href="<%=request.getContextPath()%>/category/categoryList.jsp" class='sidebar-link'>
                                <i class="bi bi-grid-1x2-fill"></i>
                                <span>Category</span>
                            </a>
                        </li>
						
						<!-- E-book -->
						<%
                        	if(current.equals("ebook")) {
                        %>
                        		<li class="sidebar-item active">
                        <% } else { %>
                        		<li class="sidebar-item">
                        <% } %>
                            <a href="<%=request.getContextPath()%>/ebook/ebookList.jsp" class='sidebar-link'>
                                <i class="bi bi-map-fill"></i>
                                <span>E-book</span>
                            </a>
                        </li>
                        
                        <!-- Orders (주문) -->
						<%
                        	if(current.equals("orders")) {
                        %>
                        		<li class="sidebar-item active">
                        <% } else { %>
                        		<li class="sidebar-item">
                        <% } %>
                            <a href="<%=request.getContextPath()%>/orders/ordersList.jsp" class='sidebar-link'>
                                <i class="bi bi-basket-fill"></i>
                                <span>Orders</span>
                            </a>
                        </li>
                        
                        <!-- Notice (공지) -->
						<%
                        	if(current.equals("notice")) {
                        %>
                        		<li class="sidebar-item active">
                        <% } else { %>
                        		<li class="sidebar-item">
                        <% } %>
                            <a href="<%=request.getContextPath()%>/notice/noticeList.jsp" class='sidebar-link'>
                                <i class="bi bi-chat-dots-fill"></i>
                                <span>Notice</span>
                            </a>
                        </li>
                        
                        <!-- Logout (로그아웃) -->
						<li class="sidebar-item">
                            <a href="<%=request.getContextPath()%>/manager/logoutManagerAction.jsp" class='sidebar-link'>
                                <i class="bi bi-x-octagon-fill"></i>
                                <span>Logout</span>
                            </a>
                        </li>
                        </ul>
                </div>
                <button class="sidebar-toggler btn x"><i data-feather="x"></i></button>
			</div>
</div>
</body>
</html>
                         
                        <!-- <li class="sidebar-title">Pages</li>

                        <li class="sidebar-item  ">
                            <a href="application-email.html" class='sidebar-link'>
                                <i class="bi bi-envelope-fill"></i>
                                <span>Email Application</span>
                            </a>
                        </li>

                        <li class="sidebar-item  ">
                            <a href="application-chat.html" class='sidebar-link'>
                                <i class="bi bi-chat-dots-fill"></i>
                                <span>Chat Application</span>
                            </a>
                        </li>

                        <li class="sidebar-item  ">
                            <a href="application-gallery.html" class='sidebar-link'>
                                <i class="bi bi-image-fill"></i>
                                <span>Photo Gallery</span>
                            </a>
                        </li>

                        <li class="sidebar-item  ">
                            <a href="application-checkout.html" class='sidebar-link'>
                                <i class="bi bi-basket-fill"></i>
                                <span>Checkout Page</span>
                            </a>
                        </li>

                        <li class="sidebar-item  has-sub">
                            <a href="#" class='sidebar-link'>
                                <i class="bi bi-person-badge-fill"></i>
                                <span>Authentication</span>
                            </a>
                            <ul class="submenu ">
                                <li class="submenu-item ">
                                    <a href="auth-login.html">Login</a>
                                </li>
                                <li class="submenu-item ">
                                    <a href="auth-register.html">Register</a>
                                </li>
                                <li class="submenu-item ">
                                    <a href="auth-forgot-password.html">Forgot Password</a>
                                </li>
                            </ul>
                        </li>

                        <li class="sidebar-item  has-sub">
                            <a href="#" class='sidebar-link'>
                                <i class="bi bi-x-octagon-fill"></i>
                                <span>Errors</span>
                            </a>
                            <ul class="submenu ">
                                <li class="submenu-item ">
                                    <a href="error-403.html">403</a>
                                </li>
                                <li class="submenu-item ">
                                    <a href="error-404.html">404</a>
                                </li>
                                <li class="submenu-item ">
                                    <a href="error-500.html">500</a>
                                </li>
                            </ul>
                        </li>

                        <li class="sidebar-title">Raise Support</li>

                        <li class="sidebar-item  ">
                            <a href="https://zuramai.github.io/mazer/docs" class='sidebar-link'>
                                <i class="bi bi-life-preserver"></i>
                                <span>Documentation</span>
                            </a>
                        </li>

                        <li class="sidebar-item  ">
                            <a href="https://github.com/zuramai/mazer/blob/main/CONTRIBUTING.md" class='sidebar-link'>
                                <i class="bi bi-puzzle"></i>
                                <span>Contribute</span>
                            </a>
                        </li>

                        <li class="sidebar-item  ">
                            <a href="https://github.com/zuramai/mazer#donate" class='sidebar-link'>
                                <i class="bi bi-cash"></i>
                                <span>Donate</span>
                            </a>
                        </li> -->
