<%@page import="dao.SubjectDAO"%>
<%@page import="model.Administrator"%>
<%@page import="model.Quiz"%>
<%@page import="model.Subject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.QuizDAO"%>
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
    </head>
    <body id="page-top">
        <%
            QuizDAO quizDAO = new QuizDAO();
            ArrayList<Quiz> listQuiz;

            SubjectDAO subjectDAO = new SubjectDAO();
            ArrayList<Subject> listSubject = subjectDAO.getListSubject();

            Administrator ad = (Administrator) session.getAttribute("admin");
            if (ad == null) {
                response.sendRedirect("login.jsp");
            }
            //Phân trang               
            int subjectID = 0;
            String txtSearch = "";
            if (request.getParameter("subject_id") != null) {
                subjectID = (int) Integer.parseInt(request.getParameter("subject_id"));
            }
            if (request.getParameter("search") != null) {
                txtSearch = request.getParameter("search");
            }
            int pages = 0, firstResult = 0, maxResult = 0, total = 0, pagesize = 10;
            if (request.getParameter("pages") != null) {
                pages = (int) Integer.parseInt(request.getParameter("pages"));
            }
            //get total phan trang
            if (request.getParameter("subject_id") != null) {
                total = quizDAO.getCountQuizBySubject(subjectID);
            } else {
                total = quizDAO.getCountQuiz();
            }
            if (total <= pagesize) {
                firstResult = 0;
                maxResult = total;
            } else {
                firstResult = (pages - 1) * pagesize;
                maxResult = pagesize;
            }

            //get list question phan trang
            if (request.getParameter("subject_id") != null) {
                listQuiz = quizDAO.getListQuizBySubject(subjectID, firstResult, maxResult);
            } else if (request.getParameter("search") != null) { //search
                listQuiz = quizDAO.search(txtSearch);
            } else {
                listQuiz = quizDAO.getListQuiz(firstResult, maxResult);
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
                            <h3>QUẢN LÝ ĐỀ THI</h3>

                            <div class="d-flex mb-4">
                                <a href="${root}/admin/insert_quiz.jsp" class="btn btn-primary">
                                <i class="fas fa-plus"></i>
                                Thêm mới đề thi
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
                                <h6 class="m-0 font-weight-bold text-primary">DANH SÁCH ĐỀ THI</h6>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="form-group col-md-5">
                                        <form action="" method="get" class="form-inline">
                                            <div class="input-group">
                                                <div class="input-group-prepend">
                                                    <span class="input-group-text" id="basic-addon1">
                                                        <i class="fas fa-search"></i>
                                                    </span>
                                                </div>
                                                <input type="text" class="form-control" name="search" size="50" placeholder="Nhập câu hỏi cần tìm kiếm..." >
                                            </div>
                                        </form>
                                    </div>
                                    <div class="form-group col-md-3">
                                        <select id="subject_id" name="subject_id" class="form-control" onchange="location = this.value;">  
                                            <option value="none">--Chọn môn học--</option>  
                                            <%
                                                for (Subject s : listSubject) {
                                            %>
                                            <option value="${root}/admin/manager_quiz.jsp?subject_id=<%=s.getSubjectID()%>&pages=1">
                                                <%=s.getSubjectName()%>
                                            </option>  
                                            <%

                                                }

                                            %>
                                        </select> 
                                    </div>
                                </div>
                                <div class="table-responsive">
                                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                        <thead>
                                            <tr>
                                                <th>STT</th>
                                                <th>Mã đề</th>                                                
                                                <th>Mã môn</th>
                                                <th style="width: 380px">Tên đề</th>
                                                <th>Thời gian</th>
                                                <th>Tổng số câu</th>                                    
                                                <th>Ảnh</th>
                                                <th>Ngày tạo</th>
                                                <th></th>
                                            </tr>
                                        </thead>
                                        <%                                            
                                            int count = 0;
                                            for (Quiz quiz : listQuiz) {
                                                count++;
                                        %>
                                        <tbody>
                                            <tr>
                                                <th scope="row"><%=count%></th>
                                                <td><%=quiz.getQuizID()%></td>
                                                <td><%=quiz.getSubjectID()%></td>
                                                <td><%=quiz.getQuizName()%></td>
                                                <td><%=quiz.getTime()%> phút</td>
                                                <td><%=quiz.getTotalQuestion()%> câu</td>                                    
                                                <td><image src="<%=quiz.getImage()%>" alt="<%=quiz.getQuizName()%>" style="width: 60px" /></td>
                                                <td><fmt:formatDate type = "both" dateStyle = "short" timeStyle = "short" value="<%=quiz.getCreatedate()%>" /></td>
                                                <td>
                                                    <a href="${root}/admin/update_quiz.jsp?command=update&quiz_id=<%=quiz.getQuizID()%>" class="btn btn-primary">
                                                        <i class="far fa-edit"></i>
                                                    </a>
                                                    <a href="${root}/ManagerQuizServlet?command=delete&quiz_id=<%=quiz.getQuizID()%>" 
                                                       class="btn btn-danger"
                                                       onclick="return confirm('Bạn có chắc chắn muốn xóa đề <%=quiz.getQuizName()%>?')">
                                                        <i class="far fa-trash-alt"></i>
                                                    </a>
                                                </td>
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

                                            if (request.getParameter("subject_id") != null) {
                                        %>

                                        <li class="page-item">
                                            <a class="page-link" href="${root}/admin/manager_quiz.jsp?subject_id=<%=subjectID%>&pages=<%=back%>" aria-label="Previous">
                                                <span aria-hidden="true">&laquo;</span>
                                                <span class="sr-only">Previous</span>
                                            </a>
                                        </li>
                                        <%} else {%>
                                        <li class="page-item">
                                            <a class="page-link" href="${root}/admin/manager_quiz.jsp?pages=<%=back%>" aria-label="Previous">
                                                <span aria-hidden="true">&laquo;</span>
                                                <span class="sr-only">Previous</span>
                                            </a>
                                        </li>
                                        <%}%>

                                        <%for (int i = 1; i <= (total / pagesize) + 1; i++) {
                                                if (request.getParameter("subject_id") != null) {
                                        %>

                                        <li class="page-item">
                                            <a class="page-link" href="${root}/admin/manager_quiz.jsp?subject_id=<%=subjectID%>&pages=<%=i%>">
                                                <%=i%>
                                            </a>
                                        </li>
                                        <%} else {%>
                                        <li class="page-item">
                                            <a class="page-link" href="${root}/admin/manager_quiz.jsp?pages=<%=i%>">
                                                <%=i%>
                                            </a>
                                        </li>
                                        <%}
                                            }
                                        %>

                                        <%
                                            //Button Next
                                            int next = 0;
                                            //Nếu total lẻ
                                            if (total % 2 != 0) {
                                                if (pages == (total / pagesize) + 1) {
                                                    next = pages;//Khong next
                                                } else {
                                                    next = pages + 1;//Co next
                                                }
                                            } else {
                                                //Nếu total chẵn nhỏ hơn fullpage
                                                //Và không fullPage thì thêm 1
                                                if (total < (pagesize * pagesize) + pagesize && total != pagesize * pagesize) {
                                                    if (pages == (total / pagesize) + 1) {
                                                        next = pages;//Khong next
                                                    } else {
                                                        next = pages + 1;//Co next
                                                    }
                                                } else {
                                                    //Nếu fullPage đến trang cuối dừng
                                                    //Chưa tới trang cuối thì được next
                                                    if (pages == (total / pagesize)) {
                                                        next = pages;//Khong next
                                                    } else {
                                                        next = pages + 1;//Co next
                                                    }
                                                }
                                            }
                                            if (request.getParameter("subject_id") != null) {
                                        %>
                                        <li class="page-item">
                                            <a class="page-link" href="${root}/admin/manager_quiz.jsp?subject_id=<%=subjectID%>&pages=<%=next%>" aria-label="Next">
                                                <span aria-hidden="true">&raquo;</span>
                                                <span class="sr-only">Next</span>
                                            </a>
                                        </li>
                                        <%} else {%>
                                        <li class="page-item">
                                            <a class="page-link" href="${root}/admin/manager_quiz.jsp?pages=<%=next%>" aria-label="Next">
                                                <span aria-hidden="true">&raquo;</span>
                                                <span class="sr-only">Next</span>
                                            </a>
                                        </li>
                                        <%}%>
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
        <script src="${root}/vendor/chart.js/Chart.min.js"></script>

        <!-- Page level custom scripts -->
        <script src="${root}/js/demo/chart-area-demo.js"></script>
        <script src="${root}/js/demo/chart-pie-demo.js"></script>
    </body>
</html>
