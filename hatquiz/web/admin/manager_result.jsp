<%@page import="dao.UserQuizDAO"%>
<%@page import="model.UserQuiz"%>
<%@page import="model.Administrator"%>
<%@page import="model.User"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.UserDAO"%>
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
            UserQuizDAO userquizDAO = new UserQuizDAO();

            Administrator ad = (Administrator) session.getAttribute("admin");
            if (ad == null) {
                response.sendRedirect("login.jsp");
            }
            //phân trang
            int first = 0, last = 0, pages = 1;
            if (request.getParameter("pages") != null) {
                pages = (int) Integer.parseInt(request.getParameter("pages"));
            }
            int total = userquizDAO.getCount();
            if (total <= 4) {
                first = 0;
                last = total;
            } else {
                first = (pages - 1) * 4;
                last = 4;
            }
            //Lấy ra danh sách userquiz
            ArrayList<UserQuiz> listUserQuiz;
            String txtSearch = "";
            if (request.getParameter("search") != null) {
                txtSearch = request.getParameter("search");
            }
            if (request.getParameter("search") != null) { //search
                listUserQuiz = userquizDAO.search(txtSearch);
            } else {
                listUserQuiz = userquizDAO.getListUserQuiz(first, last);
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
                            <h3>QUẢN LÝ KẾT QUẢ THI</h3>
                        <%if (session.getAttribute("insert_success") != null || session.getAttribute("update_success") != null || session.getAttribute("remove_success") != null) {%>
                        <div>
                            <% if (session.getAttribute("remove_success") != null) {%>
                            <p style = "color: green; font-weight: 600;"> 
                                <%=session.getAttribute("remove_success")%>
                            </p>
                            <%}%>
                        </div>                                    
                        <%
                                session.removeAttribute("remove_success");
                            }%>
                        <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-primary">KẾT QUẢ THI</h6>
                            </div>
                            <div class="card-body">
                                <div class="form-group">
                                    <form action="" method="get" class="form-inline">
                                        <div class="input-group">
                                            <div class="input-group-prepend">
                                                <span class="input-group-text" id="basic-addon1">
                                                    <i class="fas fa-search"></i>
                                                </span>
                                            </div>
                                            <input type="text" class="form-control" name="search" size="35" placeholder="Tìm kiếm..." >
                                        </div>
                                    </form>
                                </div>
                                <div class="table-responsive">
                                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                        <thead>
                                            <tr>
                                                <th>STT</th>
                                                <th>Mã</th>
                                                <th>Học viên</th>
                                                <th>Đề</th>
                                                <th>Điểm</th>
                                                <th>Số câu đúng</th>
                                                <th>StartTime</th>
                                                <th>EndTime</th>
                                                <th>StartDay</th>
                                                <th>EndDay</th>
                                                <th>Thời gian làm</th>
                                                <th></th>
                                            </tr>
                                        </thead>
                                        <%
                                            int count = 0;
                                            for (UserQuiz uq : listUserQuiz) {
                                                count++;
                                                int startTime = 0;
                                                int endTime = 0;
                                                int totalTime = 0;
                                                startTime = uq.getStarttime().getHours() * 3600 + uq.getStarttime().getMinutes() * 60 + uq.getStarttime().getSeconds();
                                                endTime = uq.getEndtime().getHours() * 3600 + uq.getEndtime().getMinutes() * 60 + uq.getEndtime().getSeconds();
                                                totalTime = endTime - startTime;
                                                int hours = totalTime / (60 * 60);
                                                int minutes = (totalTime - hours * 60 * 60) / 60;
                                                int seconds = (totalTime - hours * 60 * 60 - minutes * 60);
                                                minutes = hours * 60 + minutes;
                                        %>
                                        <tbody>
                                            <tr>
                                                <th scope="row"><%=count%></th>
                                                <td><%=uq.getUserquizID()%></td>
                                                <td><%=uq.getUsername()%></td>
                                                <td><%=uq.getQuizname()%></td>
                                                <td><%=uq.getScore()%></td>
                                                <td><%=uq.getTotalanswertrue()%> / <%=uq.getTotalquestion()%></td>
                                                <td><%=uq.getStarttime()%></td>
                                                <td><%=uq.getEndtime()%></td>
                                                <td><fmt:formatDate pattern="dd-MM-yyyy" value="<%=uq.getStartday()%>" /></td>
                                                <td><fmt:formatDate pattern="dd-MM-yyyy" value="<%=uq.getEndday()%>" /></td>
                                                <td><%=minutes%>:<%=seconds%></td>
                                                <td>
                                                    <a href="${root}/ManagerReslutServlet?command=delete&userquiz_id=<%=uq.getUserquizID()%>" 
                                                       class="btn btn-danger"
                                                       onclick="return confirm('Bạn có chắc chắn muốn xóa kết quả thi này của <%=uq.getUsername()%>?')">
                                                        <i class="far fa-trash-alt"></i>
                                                    </a>
                                                </td>
                                            </tr>
                                        </tbody>
                                        <%}%>
                                    </table>
                                    <% if (request.getParameter("search") == null) {%>
                                    <ul class="pagination justify-content-center">
                                        <%
                                            int back = 0;
                                            if (pages == 0 || pages == 1) {
                                                back = 1;//Luon la page 1
                                            } else {
                                                back = pages - 1;//Neu pages tu 2 tro len thi back tru 1
                                            }
                                        %>
                                        <li class="page-item">
                                            <a class="page-link" href="${root}/admin/manager_result.jsp?pages=<%=back%>" aria-label="Previous">
                                                <span aria-hidden="true">&laquo;</span>
                                                <span class="sr-only">Previous</span>
                                            </a>
                                        </li>
                                        <%
                                            //Button Number pages
                                            int loop = 0, num = 0;
                                            if ((total / 4) % 2 == 0) {
                                                num = total / 4;
                                            } else {
                                                num = (total + 1) / 4;
                                            }
                                            //Nếu total lẻ thêm 1
                                            if (total % 2 != 0) {
                                                loop = (total / 4) + 1;

                                            } else {
                                                //Nếu total chẵn nhỏ hơn fullpage và # fullPage thì thêm 1
                                                if (total < (num * 4) + 4 && total != num * 4) {
                                                    loop = (total / 4) + 1;
                                                } else {
                                                    //Nếu bằng fullPage thì không thêm
                                                    loop = (total / 4);
                                                }
                                            }
                                            //Lap so pages
                                            for (int i = 1; i <= loop; i++) {%>
                                        <% if (pages == i) {%> 
                                        <li class="page-item"><a class="page-link" href="${root}/admin/manager_result.jsp?pages=<%=i%>"><%=i%></a></li>
                                            <%} else {%>
                                        <li class="page-item"><a class="page-link" href="${root}/admin/manager_result.jsp?pages=<%=i%>"><%=i%></a></li>
                                            <%}
                                                }%>
                                            <%
                                                //Button Next
                                                int next = 0;
                                                //Nếu total lẻ
                                                if (total % 2 != 0) {
                                                    if (pages == (total / 4) + 1) {
                                                        next = pages;//Khong next
                                                    } else {
                                                        next = pages + 1;//Co next
                                                    }
                                                } else {
                                                    //Nếu total chẵn nhỏ hơn fullpage
                                                    //Và không fullPage thì thêm 1
                                                    if (total < (num * 4) + 4 && total != num * 4) {
                                                        if (pages == (total / 4) + 1) {
                                                            next = pages;//Khong next
                                                        } else {
                                                            next = pages + 1;//Co next
                                                        }
                                                    } else {
                                                        //Nếu fullPage đến trang cuối dừng
                                                        //Chưa tới trang cuối thì được next
                                                        if (pages == (total / 4)) {
                                                            next = pages;//Khong next
                                                        } else {
                                                            next = pages + 1;//Co next
                                                        }
                                                    }
                                                }
                                            %>
                                        <li class="page-item">
                                            <a class="page-link" href="${root}/admin/manager_result.jsp?pages=<%=next%>" aria-label="Next">
                                                <span aria-hidden="true">&raquo;</span>
                                                <span class="sr-only">Next</span>
                                            </a>
                                        </li>
                                    </ul>
                                    <%}%>
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

    </body>
</html>
