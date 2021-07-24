<%@page import="model.Administrator"%>
<%@page import="model.CountDownTHPT"%>
<%@page import="connect.DBConnect"%>
<%@page import="dao.CountDownTHPTDAO"%>
<%@page import="java.util.ArrayList"%>
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
            Administrator ad = (Administrator) session.getAttribute("admin");
            if (ad == null) {
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

                            <h3>QUẢN LÝ COUNTDOWN THPTQG</h3>
                            <div>
                                <i class="fas fa-undo-alt"></i>
                                <a href="manager_cd.jsp">Quay về danh sách countdown</a>
                            </div>
                            <br/>
                            <div class="card shadow mb-4">
                            <%
                                String id = request.getParameter("cd_id");
                                CountDownTHPT cd = new CountDownTHPTDAO().getCountDownByID(Integer.parseInt(id));
                            %>
                            <div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-primary">CẬP NHẬT COUNTDOWN #<%=id%></h6>
                            </div>
                            <div class="card-body">

                                <form action="${root}/ManagerCountDownServlet" method="post">
                                    <div class="row">
                                        <div class="form-group col-md-3">
                                            <label for="year">Năm thi THPTQG</label>
                                            <input type="text" class="form-control" name="year" id="year" placeholder="Nhập năm thi..." 
                                                   required="yes" value="<%=cd.getYear()%>">
                                        </div>
                                        <div class="form-group col-md-4">
                                            <label for="startday">Ngày bắt đầu</label>
                                            <input type="text" class="form-control" name="startday" id="startday" placeholder="Nhập ngày bắt đầu..." 
                                                   required="yes" value="<%=cd.getStartDay()%>">
                                        </div>
                                        <div class="form-group col-md-5">
                                            <label for="note">Ghi chú</label>
                                            <textarea type="text" class="form-control" name="note" id="note" placeholder="Ghi chú..." required="yes" 
                                                      rows="5"><%=cd.getNote()%></textarea>
                                        </div>
                                    </div>
                                    <input type="hidden" name="command" value="update"> 
                                    <input type="hidden" name="cd_id" value="<%=request.getParameter("cd_id")%>"> 
                                    <input type="submit" class="btn btn-primary" value="Lưu lại">
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
