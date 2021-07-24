<%@page import="dao.QuestionDAO"%>
<%@page import="dao.QuizDAO"%>
<%@page import="java.util.Map"%>
<%@page import="dao.UserDAO"%>
<%@page import="java.sql.Time"%>
<%@page import="dao.UserQuizDAO"%>
<%@page import="model.UserQuiz"%>
<%@page import="model.User"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <title>Lịch sử thi</title>
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
        <link rel="stylesheet" href="css/infor.css" />  
        <link rel="stylesheet" href="css/luyenthi.css" />
        <link rel="stylesheet" href="css/responsive.css" />

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css"/>     

        <!-- Modernizr JS -->
        <script src="js/modernizr-2.6.2.min.js"></script>      
    </head>
    <body>
        <%
            User u = new User();
            if (session.getAttribute("user") != null) {
                u = (User) session.getAttribute("user");
            }
            String id = request.getParameter("user_id");
        %>
        <div id="page">
            <jsp:include page="header.jsp"></jsp:include>    
                <div class="breadcrumb-wrap">
                    <div class="container-fluid">
                        <ul class="breadcrumb">
                            <li class="breadcrumb-item"><a href="index.jsp">Trang chủ</a></li>
                            <li class="breadcrumb-item">Thi trắc nghiệm</li>
                        </ul>
                    </div>
                </div>
                <div class="container pb-4">
                    <div style="width: 94%" class="infor_nav">
                        <p class="p_doc align_center tit_mem">
                            <a class="infor_menu" href="infor.jsp?user_id=<%=u.getUserID()%>"><i class="fa fa-info-circle" aria-hidden="true"></i> Thông tin chung</a> 
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                                                       
                        <a class="" href="history.jsp?user_id=<%=u.getUserID()%>"><i class="fa fa-clock" aria-hidden="true"></i> Thi trắc nghiệm</a>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  
                        <a class="" href="changepass.jsp?user_id=<%=u.getUserID()%>"><i class="fa fa-key" aria-hidden="true"></i> Đổi mật khẩu</a>
                    </p>
                </div>
                <div style="width: 100%" class="infor_nav">
                    <h1>Kết quả thi</h1>
                    <p style="line-height: 20px;">Hàng ngàn bài thi trắc nghiệm miễn phí còn đang chờ bạn thử sức</p>
                    <div class="danhsach">
                        <table cellspacing="0" cellpadding="0">
                            <tbody>
                                <tr style="line-height: 30px;">
                                    <th>STT</th>
                                    <th>Đề thi</th>
                                    <th>Kết quả</th>
                                    <th>Đã thi lúc</th>
                                </tr>  
                                <%
                                    int count = 0;
                                    for (UserQuiz uq : new UserQuizDAO().getListUserQuizHistory(Integer.parseInt(id))) {
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
                                        count++;

                                        int countQExams = new QuizDAO().getCountQuizExams(uq.getQuizID());
                                        request.setAttribute("countQExams", countQExams);
                                %>                                
                                <tr>
                                    <td><%=count%></td>
                                    <td style="text-align: left; line-height: 20px;">
                                        <a href="detail.jsp?quiz_id=<%=uq.getQuizID()%>&subject_id=<%=uq.getSubjectID()%>"><%=uq.getQuizname()%></a>
                                        <p style="font-size: 12px; font-style: italic;" class="ltin">
                                            <span><i class="fa fa-bars" aria-hidden="true"></i><a href="quiz.jsp?subject_id=<%=uq.getSubjectID()%>&pages=1">Môn <%=uq.getSubjectName()%>;</a></span> 
                                            <span><i class="fa fa-question-circle" aria-hidden="true"></i> Số câu hỏi: <b><%=uq.getTotalquestion()%> câu;</b>
                                                <i class="fa fa-clock" aria-hidden="true"></i>  Thời gian: <b><%=uq.getTime()%> phút;</b>
                                                <i class="fa fa-signal" aria-hidden="true"></i>  Lượt thi: <%=countQExams%>
                                            </span>
                                        </p>
                                    </td>
                                    <td>
                                        <p>Điểm: <b style="color: red;"><fmt:formatNumber value="<%=uq.getScore()%>" minFractionDigits="0" maxFractionDigits="2"/><sup>đ</sup></b></p>
                                        <p>Thời gian làm: <%=minutes%> phút <%=seconds%> giây</p>
                                        <p>Số câu đúng: <%=uq.getTotalanswertrue()%>/<%=uq.getTotalquestion()%></p>
                                    </td>
                                    <td>
                                        <fmt:formatDate value="<%=uq.getStarttime()%>" pattern="HH:mm" /> 
                                        Ngày <fmt:formatDate pattern="dd-MM-yyyy" value="<%=uq.getStartday()%>" />
                                        <p><a class="nutnho" href="javascript: void(0)">Xem kết quả chi tiết</a></p>
                                    </td>
                                </tr>   
                                <%}%>
                            </tbody>
                        </table>
                        <table id="tabletr" cellspacing="2" cellpadding="0" border="0">
                            <tbody>
                                <tr>

                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <p class="align_center"><i class="fa fa-star" aria-hidden="true"></i><i class="fa fa-star" aria-hidden="true"></i><i class="fa fa-star" aria-hidden="true"></i></p>
                    <p>
                        <a href="javascript:void(0)">Tuyệt đối không cho người khác sử dụng tài khoản<br> nếu không bạn có thể bị xóa tài khoản bất kể lúc nào.</a>
                    </p>
                    <p>Thông tin cá nhân của bạn được bảo mật và chỉ sử dụng trong các tư vấn liên quan đến dịch vụ của HatQuiz.</p>
                </div>
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
    </body>
</html>
