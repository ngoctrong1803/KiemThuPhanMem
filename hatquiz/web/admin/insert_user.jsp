<%-- 
    Document   : insert_subject
    Created on : Mar 27, 2021, 9:27:39 PM
    Author     : Admin
--%>
<%@page import="model.Administrator"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>HAT Admin - Dashboard</title>
        <!-- Custom fonts for this template-->
        <c:set var="root" value="${pageContext.request.contextPath}"/>
        <link href="${root}/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
        <link
            href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
            rel="stylesheet">

        <!-- Custom styles for this template-->
        <link href="${root}/css/sb-admin-2.min.css" rel="stylesheet">
    </head>
    <body id="page-top">

        <%
            String error = "";
            if (request.getParameter("error") != null) {
                error = (String) request.getParameter("error");
            }
            Administrator ad = (Administrator) session.getAttribute("admin");
            if(ad == null){
                response.sendRedirect("login.jsp");
            }
        %>

        <div id="wrapper">
            <jsp:include page="sidebar.jsp"></jsp:include>
                <div id="content-wrapper" class="d-flex flex-column">

                    <!-- Main Content -->
                    <div id="content">
                        <!--Header-->
                    <jsp:include page="header.jsp"></jsp:include>
                        <!-- Begin Page Content -->
                        <div class="container-fluid">
                            <h3>QUẢN LÝ HỌC VIÊN</h3>
                            <div>
                                <i class="fas fa-undo-alt"></i>
                                <a href="${root}/admin/manager_user.jsp">Quay về danh sách học viên</a>
                        </div>
                        <br/>
                        <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-primary">THÊM MỚI HỌC VIÊN</h6>
                            </div>
                            <div class="card-body">
                                <form action="${root}/ManagerUserServlet" method="post">
                                    <div class="row">
                                        <div class="form-group col-md-6">
                                            <label for="name">Tên học viên</label>
                                            <input type="text" class="form-control" name="name" id="name" placeholder="Nhập tên học viên..." required="yes" >
                                            <%=error%>
                                        </div>
                                        <div class="form-group col-md-6">
                                            <label for="email">Email</label>
                                            <input type="email" class="form-control" name="email" id="email" placeholder="Nhập email..." required="yes">
                                            <%=error%>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="form-group col-md-6">
                                            <label for="password">Mật khẩu</label>
                                            <input type="password" class="form-control" name="password" id="password" placeholder="Nhập mật khẩu..." required="yes" >
                                            <%=error%>
                                        </div>
                                        <div class="form-group col-md-6">
                                            <label for="phone">Số điện thoại</label>
                                            <input type="text" class="form-control" name="phone" id="phone" placeholder="Nhập số điện thoại..." required="yes">
                                            <%=error%>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="form-group col-md-12">
                                            <label for="address">Địa chỉ</label>
                                            <input type="text" class="form-control" name="address" id="address" placeholder="Nhập địa chỉ..." required="yes">
                                            <%=error%>
                                        </div>
                                    </div>
                                    <input type="hidden" name="command" class="btn btn-primary" value="insert" />
                                    <input type="submit" class="btn btn-primary" value="Thêm mới" />
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- End of Main Content -->

                <jsp:include page="footer.jsp"></jsp:include>

                </div>
            </div>

            <!-- Scroll to Top Button-->
            <a class="scroll-to-top rounded" href="#page-top">
                <i class="fas fa-angle-up"></i>
            </a>

            <!-- Logout Modal-->
        <jsp:include page="logout_modal.jsp"></jsp:include>
            <!-- Bootstrap core JavaScript-->
            <script src="${root}/vendor/jquery/jquery.min.js"></script>
        <script src="${root}/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

        <!-- Core plugin JavaScript-->
        <script src="${root}/vendor/jquery-easing/jquery.easing.min.js"></script>

        <!-- Custom scripts for all pages-->
        <script src="${root}/js/sb-admin-2.min.js"></script>

        <!-- Page level plugins -->
        <script src="${root}/vendor/chart.js/Chart.min.js"></script>

        <!-- Page level custom scripts -->
        <script src="${root}/js/demo/chart-area-demo.js"></script>
        <script src="${root}/js/demo/chart-pie-demo.js"></script>
    </body>
</html>
