<%@page import="model.Administrator"%>
<%@page import="model.Banner"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.BannerDAO"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
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
        <link href="${root}/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">

    </head>
    <body id="page-top">
        <%
            BannerDAO bannerDAO = new BannerDAO();
            ArrayList<Banner> listBanner = bannerDAO.getListBanner();

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
                            <h3>QUẢN LÝ BANNER</h3>

                            <div class="d-flex mb-4">
                                <a href="${root}/admin/insert_banner.jsp" class="btn btn-primary mr-2">
                                <i class="fas fa-plus"></i>
                                Thêm mới banner
                            </a>
                        </div>
                        <%if (session.getAttribute("insert_success") != null || session.getAttribute("update_success") != null || session.getAttribute("remove_success") != null) {%>
                        <div>
                            <% if (session.getAttribute("insert_success") != null) {%>
                            <p style = "color: green; font-weight: 600;"> 
                                <%=session.getAttribute("insert_success")%>
                            </p>
                            <%}%>
                            <% if (session.getAttribute("update_success") != null) {%>
                            <p style = "color: green; font-weight: 600;"> 
                                <%=session.getAttribute("update_success")%>
                            </p>
                            <%}%>
                            <% if (session.getAttribute("remove_success") != null) {%>
                            <p style = "color: green; font-weight: 600;"> 
                                <%=session.getAttribute("remove_success")%>
                            </p>
                            <%}%>
                        </div>                                    
                        <%
                                session.removeAttribute("insert_success");
                                session.removeAttribute("update_success");
                                session.removeAttribute("remove_success");
                            }%>

                        <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-primary">DANH SÁCH BANNER</h6>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                        <thead>
                                            <tr>
                                                <th>STT</th>
                                                <th>Mã</th>
                                                <th>Nội dung</th>
                                                <th>Ảnh</th>
                                                <th>Ngày tạo</th>
                                                <th></th>
                                            </tr>
                                        </thead>
                                        <%
                                            int count = 0;
                                            for (Banner bn : listBanner) {
                                                count++;
                                        %>
                                        <tbody>
                                            <tr>
                                                <th scope="row"><%=count%></th>
                                                <td><%=bn.getBannerID()%></td>
                                                <td style="width: 500px;"><%=bn.getContent()%></td>
                                                <td><image src="<%=bn.getImage()%>" style="width: 200px; height: 100px" /></td>
                                                <td><fmt:formatDate type = "both" dateStyle = "short" timeStyle = "short" value="<%=bn.getCreatedate()%>" /></td>
                                                <td>
                                                    <a href="${root}/admin/update_banner.jsp?command=update&banner_id=<%=bn.getBannerID()%>" class="btn btn-primary">
                                                        <i class="far fa-edit"></i>
                                                    </a>
                                                    <a href="${root}/ManagerBannerServlet?command=delete&banner_id=<%=bn.getBannerID()%>" class="btn btn-danger"
                                                       onclick="return confirm('Bạn có chắc chắn muốn xóa banner #<%=bn.getBannerID()%>?')">
                                                        <i class="far fa-trash-alt"></i>
                                                    </a>
                                                </td>
                                            </tr>
                                        </tbody>
                                        <%}%>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- /.container-fluid -->
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
        <script src="${root}/vendor/datatables/jquery.dataTables.min.js"></script>
        <script src="${root}/vendor/datatables/dataTables.bootstrap4.min.js"></script>

        <!--         Page level custom scripts 
                <script src="${root}/js/demo/datatables-demo.js"></script>-->
    </body>
</html>
