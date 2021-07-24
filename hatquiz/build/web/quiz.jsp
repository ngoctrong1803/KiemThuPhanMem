<%@page import="dao.ViewDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="model.Subject"%>
<%@page import="dao.SubjectDAO"%>
<%@page import="model.Quiz"%>
<%@page import="dao.QuizDAO"%>   
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <title>Luyện thi THPT QG</title>
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <meta
            name="description"
            content="Free HTML5 Website Template by freehtml5.co"
            />
        <meta
            name="keywords"
            content="free website templates, free html5, free template, free bootstrap, free website template, html5, css3, mobile first, responsive"
            />
        <meta name="author" content="freehtml5.co" />

        <!-- Facebook and Twitter integration -->
        <meta property="og:title" content="" />
        <meta property="og:image" content="" />
        <meta property="og:url" content="" />
        <meta property="og:site_name" content="" />
        <meta property="og:descript;ion" content="" />
        <meta name="twitter:title" content="" />
        <meta name="twitter:image" content="" />
        <meta name="twitter:url" content="" />
        <meta name="twitter:card" content="" />
        <link
            href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700"
            rel="stylesheet"
            />
        <link
            href="https://fonts.googleapis.com/css?family=Roboto+Slab:300,400"
            rel="stylesheet"
            />

        <!-- Animate.css -->
        <link rel="stylesheet" href="css/animate.css" />
        <!-- Icomoon Icon Fonts-->
        <link rel="stylesheet" href="css/icomoon.css" />
        <!-- Bootstrap  -->
        <link rel="stylesheet" href="css/bootstrap.css" />

        <!-- Magnific Popup -->
        <link rel="stylesheet" href="css/magnific-popup.css" />

        <!-- Owl Carousel  -->
        <link rel="stylesheet" href="css/owl.carousel.min.css" />
        <link rel="stylesheet" href="css/owl.theme.default.min.css" />

        <!-- Flexslider  -->
        <link rel="stylesheet" href="css/flexslider.css" />

        <!-- Pricing -->
        <link rel="stylesheet" href="css/pricing.css" />

        <!-- Theme style  -->
        <link rel="stylesheet" href="css/style.css" />        
        <link rel="stylesheet" href="css/luyenthi.css" />
        <link rel="stylesheet" href="css/responsive.css" />

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css"/>     

        <!-- Modernizr JS -->
        <script src="js/modernizr-2.6.2.min.js"></script>     
    </head>
    <body>
        <div id="page">
            <%
                SubjectDAO subjectDAO = new SubjectDAO();
                QuizDAO quizDAO = new QuizDAO();
                List<Quiz> list;

                //Phân trang               
                int subjectID = 0;
                //Theo mã môn học
                if (request.getParameter("subject_id") != null) {
                    subjectID = (int) Integer.parseInt(request.getParameter("subject_id"));
                }
                int pages = 0, firstResult = 0, maxResult = 0, total = 0, pagesize = 6;
                if (request.getParameter("pages") != null) {
                    pages = (int) Integer.parseInt(request.getParameter("pages"));
                }
                if (request.getParameter("subject_id") != null) {
                    total = quizDAO.getCountQuizBySubject(subjectID); //Tổng đề thi theo môn
                } else {
                    total = quizDAO.getCountQuiz(); //Tổng tất cả đề thi
                }
                if (total <= pagesize) {
                    firstResult = 0;
                    maxResult = total;
                } else {
                    firstResult = (pages - 1) * pagesize;
                    maxResult = pagesize;
                }
                if (request.getParameter("subject_id") != null) {
                    list = quizDAO.getListQuizBySubject(subjectID, firstResult, maxResult);//Phân trang theo môn
                } else {
                    list = quizDAO.getListQuiz(firstResult, maxResult);//Phân trang tất cả
                }
                // Tổng lượt truy cập   
                ViewDAO viewDAO = new ViewDAO();
                if (session.isNew()) {
                    viewDAO.updateView();
                }

                // Tổng đề thi
                int countQ = quizDAO.getCountQuiz();
                request.setAttribute("countQ", countQ);
            %>  
            <jsp:include page="header.jsp"></jsp:include>    
                <div class="breadcrumb-wrap">
                    <div class="container-fluid">
                        <ul class="breadcrumb">
                        <%
                            if (request.getParameter("subject_id") != null) {
                                subjectID = (int) Integer.parseInt(request.getParameter("subject_id"));
                                Quiz qz = new QuizDAO().getQuizBySubjectID(subjectID);
                        %>
                        <li class="breadcrumb-item"><a href="index.jsp">Trang chủ</a></li>
                        <li class="breadcrumb-item"><a href="quiz.jsp?pages=1">Thi THPT QG</a></li>
                        <li class="breadcrumb-item"><%=qz.getSubjectName()%></li>
                            <%} else {%>
                        <li class="breadcrumb-item"><a href="index.jsp">Trang chủ</a></li>
                        <li class="breadcrumb-item">Thi THPT QG</li>
                            <%}%>
                    </ul>
                </div>
            </div>

            <div id="fh5co-course">
                <div class="container">
                    <div class="animate-box mb-5">
                        <div class="heading_luyenthi text-center">
                            <h2>Luyện thi trắc nghiệm online miễn phí</h2>
                        </div>
                        <ul class="menu_monthi" id="menu_monthi" style="list-style: none">
                            <li class="monthi_item">
                                <a class="btn link_monthi" href="quiz.jsp?pages=1" id="all">
                                    <i class="fa fa-graduation-cap"></i>
                                    Tất cả
                                    <span>(<%=countQ%>)</span>
                                </a>
                            </li>
                            <%
                                for (Subject s : subjectDAO.getListSubject()) {
                                    int countQBySubject = quizDAO.getCountQuizBySubject(s.getSubjectID());
                                    request.setAttribute("countQBySubject", countQBySubject);
                            %>
                            <li class="monthi_item">
                                <a class="btn link_monthi" href="quiz.jsp?subject_id=<%=s.getSubjectID()%>&pages=1" id="<%=s.getSubjectID()%>">
                                    <i class="<%=s.getSubjectIcon()%>"></i>
                                    <%=s.getSubjectName()%>
                                    <span>(<%=countQBySubject%>)</span>
                                </a> 
                            </li>
                            <%
                                }
                            %> 
                        </ul>
                    </div>
                    <div class="row">
                        <%
                            for (Quiz q : list) {
                                int countQExams = quizDAO.getCountQuizExams(q.getQuizID());
                                request.setAttribute("countQExams", countQExams);
                        %>    
                        <div class="col-md-6 animate-box">
                            <div class="course">
                                <a href="detail.jsp?quiz_id=<%=q.getQuizID()%>&subject_id=<%=q.getSubjectID()%>" class="course-img" style="background-image: url(<%=q.getImage()%>)"></a>
                                <div class="desc">
                                    <h3>
                                        <a href="detail.jsp?quiz_id=<%=q.getQuizID()%>&subject_id=<%=q.getSubjectID()%>"><%=q.getQuizName()%></a>                                        
                                    </h3>
                                    <p>
                                        <span>
                                            <i class="fa fa-bars"> </i>
                                            <a href="quiz.jsp?subject_id=<%=q.getSubjectID()%>&pages=1">Môn <%=q.getSubjectName()%></a>
                                        </span>
                                        <span>
                                            <i class="fa fa-question-circle"> </i>
                                            Số câu hỏi: <%=q.getTotalQuestion()%> câu
                                        </span>
                                        <span>
                                            <i class="fa fa-clock"> </i>
                                            Thời gian: <%=q.getTime()%> phút
                                        </span>
                                        <span>
                                            <i class="fa fa-signal"></i>
                                            Lượt thi: <%=countQExams%>
                                        </span>
                                        <span>
                                            <i class="far fa-edit"></i>
                                            Đăng tải: <fmt:formatDate pattern="dd-MM-yyyy" value="<%=q.getCreatedate()%>" />
                                        </span>
                                    </p>
                                    <span>
                                        <a href="detail.jsp?quiz_id=<%=q.getQuizID()%>&subject_id=<%=q.getSubjectID()%>" 
                                           class="btn btn-primary btn-sm btn-course"> xem chi tiết</a>                                                                                  
                                    </span>
                                </div>
                            </div>
                        </div>
                        <%
                            }
                        %>
                    </div>
                </div>

                <ul class="pagination">
                    <%                //Button Previous
                        int back = 0;
                        if (pages == 1) {
                            back = 1;//Luon la page 1
                        } else {
                            back = pages - 1;//Neu pages tu 2 tro len thi back tru 1
                        }
                        if (request.getParameter("subjectID") != null) {
                    %>
                    <li class="page-item">
                        <a class="page-link" href="quiz.jsp?subject_id=<%=subjectID%>&pages=<%=back%>" aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                            <span class="sr-only">Previous</span>
                        </a>
                    </li>
                    <%} else {%>
                    <li class="page-item">
                        <a class="page-link" href="quiz.jsp?pages=<%=back%>" aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                            <span class="sr-only">Previous</span>
                        </a>
                    </li>
                    <%}%>
                    <%
                        for (int i = 1; i <= (total / pagesize) + 1; i++) {
                            if (request.getParameter("subject_id") != null) {
                    %>
                    <li class="page-item">
                        <a class="page-link" href="quiz.jsp?subject_id=<%=subjectID%>&pages=<%=i%>"><%=i%></a>
                    </li>    
                    <%} else {%>
                    <li class="page-item">
                        <a class="page-link" href="quiz.jsp?pages=<%=i%>"><%=i%></a>
                    </li>    
                    <%}
                        }%>
                    <%
                        //Button Next
                        int next = 0;
                        //Nếu total lẻ
                        if (total % 2 != 0) {
                            if (pages == (total / 6) + 1) {
                                next = pages;//Khong next
                            } else {
                                next = pages + 1;//Co next
                            }
                        } else {
                            //Nếu total chẵn nhỏ hơn fullpage
                            //Và không fullPage thì thêm 1
                            if (total < (pagesize * 6) + 6 && total != pagesize * 6) {
                                if (pages == (total / 6) + 1) {
                                    next = pages;//Khong next
                                } else {
                                    next = pages + 1;//Co next
                                }
                            } else {
                                //Nếu fullPage đến trang cuối dừng
                                //Chưa tới trang cuối thì được next
                                if (pages == (total / 6)) {
                                    next = pages;//Khong next
                                } else {
                                    next = pages + 1;//Co next
                                }
                            }
                        }
                        if (request.getParameter("subject_id") != null) {
                    %>
                    <li class="page-item">
                        <a class="page-link" href="quiz.jsp?subject_id=<%=subjectID%>&pages=<%=next%>" aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                            <span class="sr-only">Next</span>
                        </a>
                    </li>
                    <%} else {%>
                    <li class="page-item">
                        <a class="page-link" href="quiz.jsp?pages=<%=next%>" aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                            <span class="sr-only">Next</span>
                        </a>
                    </li>
                    <%}%>
                </ul>
            </div>
            <jsp:include page="footer.jsp"></jsp:include>
        </div>
        <div class="gototop js-top">
            <a href="#" class="js-gotop"><i class="icon-arrow-up"></i></a>
        </div>


        <!-- script for breadcrumb -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" ></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.6.0/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.min.js"></script>

        <!-- jQuery -->
        <script src="js/jquery.min.js"></script>
        <!-- jQuery Easing -->
        <script src="js/jquery.easing.1.3.js"></script>
        <!-- Bootstrap -->
        <script src="js/bootstrap.min.js"></script>
        <!-- Waypoints -->
        <script src="js/jquery.waypoints.min.js"></script>
        <!-- Stellar Parallax -->
        <script src="js/jquery.stellar.min.js"></script>
        <!-- Carousel -->
        <script src="js/owl.carousel.min.js"></script>
        <!-- Flexslider -->
        <script src="js/jquery.flexslider-min.js"></script>
        <!-- countTo -->
        <script src="js/jquery.countTo.js"></script>
        <!-- Magnific Popup -->
        <script src="js/jquery.magnific-popup.min.js"></script>
        <script src="js/magnific-popup-options.js"></script>
        <!-- Count Down -->
        <script src="js/simplyCountdown.js"></script>
        <!-- Main -->
        <script src="js/main.js"></script>
        <script type="text/javascript">
            //active link 
            const urlParams = new URLSearchParams(window.location.search);
            const myParam = urlParams.get('subject_id');
            if (myParam === null) {
                document.getElementById("all").classList.add('active');
            } else {
                document.getElementById(myParam).classList.add('active');
            }
            //
            var d = new Date(new Date().getTime() + 1000 * 120 * 120 * 2000);
            // default example
            simplyCountdown(".simply-countdown-one", {
                year: d.getFullYear(),
                month: d.getMonth() + 1,
                day: d.getDate(),
            });
            //jQuery example
            $("#simply-countdown-losange").simplyCountdown({
                year: d.getFullYear(),
                month: d.getMonth() + 1,
                day: d.getDate(),
                enableUtc: false,
            });
        </script>
    </body>
</html>
