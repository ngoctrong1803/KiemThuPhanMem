<%@page import="dao.UserQuizDAO"%>
<%@page import="model.UserQuiz"%>
<%@page import="model.User"%>
<%@page import="model.Quiz"%>
<%@page import="dao.QuizDAO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix ="fmt" uri ="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <title>Luyện thi THPT QG</title>
        <c:set var="root" value="${pageContext.request.contextPath}"/>
        <meta name="viewport" content="width=device-width, initial-scale=1" />

        <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700" rel="stylesheet" />
        <link href="https://fonts.googleapis.com/css?family=Roboto+Slab:300,400" rel="stylesheet" />

        <!-- Animate.css -->
        <link rel="stylesheet" href="${root}/css/animate.css" />
        <!-- Icomoon Icon Fonts-->
        <link rel="stylesheet" href="${root}/css/icomoon.css" />
        <!-- Bootstrap  -->
        <link rel="stylesheet" href="${root}/css/bootstrap.css" />

        <!-- Magnific Popup -->
        <link rel="stylesheet" href="${root}/css/magnific-popup.css" />

        <!-- Owl Carousel  -->
        <link rel="stylesheet" href="${root}/css/owl.carousel.min.css" />
        <link rel="stylesheet" href="${root}/css/owl.theme.default.min.css" />

        <!-- Flexslider  -->
        <link rel="stylesheet" href="${root}/css/flexslider.css" />

        <!-- Pricing -->
        <link rel="stylesheet" href="${root}/css/pricing.css" />

        <!-- Theme style  -->
        <link rel="stylesheet" href="${root}/css/style.css" />        
        <link rel="stylesheet" href="${root}/css/luyenthi.css" />
        <link rel="stylesheet" href="${root}/css/responsive.css" />

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css"/>
        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js" type="text/javascript"></script> 
    </head>
    <body>
        <div id="fb-root"></div>
        <script async defer crossorigin="anonymous" src="https://connect.facebook.net/vi_VN/sdk.js#xfbml=1&version=v10.0&appId=3495163843919139&autoLogAppEvents=1" nonce="fpT2NZnO"></script>
        <div id="page">
            <%
                QuizDAO quizDAO = new QuizDAO();
                Quiz quiz = new Quiz();
                String quizID = "", subjectID = "";
                int userID = 0;
                if (request.getParameter("quiz_id") != null) {
                    quizID = request.getParameter("quiz_id");
                    quiz = quizDAO.getQuizByQuizID(Integer.parseInt(quizID));
                }
                if (request.getParameter("subject_id") != null) {
                    subjectID = request.getParameter("subject_id");
                }
                User u = (User) session.getAttribute("user");
                if (u != null) {
                    userID = u.getUserID();
                }
            %>
            <jsp:include page="header.jsp"></jsp:include>    
                <div class="breadcrumb-wrap">
                    <div class="container-fluid">
                        <ul class="breadcrumb">
                            <li class="breadcrumb-item"><a href="index.jsp">Trang chủ</a></li>
                            <li class="breadcrumb-item"><a href="quiz.jsp?pages=1">Thi THPT QG</a></li>
                            <li class="breadcrumb-item"><a href="quiz.jsp?subject_id=<%=quiz.getSubjectID()%>&pages=1"><%=quiz.getSubjectName()%></a></li>
                        <li class="breadcrumb-item"><%=quiz.getQuizName()%></li>
                    </ul>
                </div>
            </div>
            <div id="fh5co-course" style="padding: 2em 0 2em 0;">
                <div class="container">
                    <div class="row">
                        <div class="animate-box detail col-md-9">
                            <h3 class="m-0"><%=quiz.getQuizName()%></h3>
                            <p>
                                <span>
                                    <i class="fa fa-clock"> </i>
                                    Cập nhật: <fmt:formatDate type = "both" dateStyle = "short" timeStyle = "short" value="<%=quiz.getCreatedate()%>" />
                                </span>  
                            </p>
                            <div class="detail-question">
                                <span class="mr-2"> 
                                    <i class="fa fa-check-square"> </i>
                                    Môn: <%=quiz.getSubjectName()%>
                                </span>                            
                                <span class="mr-2">
                                    <i class="fa fa-list-alt"> </i>
                                    Số câu hỏi: <%=quiz.getTotalQuestion()%> câu
                                </span>  
                                <span class="mr-2">
                                    <i class="fa fa-clock"> </i>
                                    Thời gian: <%=quiz.getTime()%> phút
                                </span>
                            </div>
                            <div class="regulation">
                                <h3>Hướng dẫn làm bài trắc nghiệm</h3>
                                <div class="instruction-box">
                                    1. Đợi đến khi đến thời gian làm bài
                                    <hr/>
                                    2. Click vào nút <b>Bắt đầu làm bài</b> để tiến hành làm bài thi
                                    <hr/>
                                    3. Ở mỗi câu hỏi, chọn đáp án đúng
                                    <hr/>
                                    4. Hết thời gian làm bài, hệ thống sẽ tự thu bài. Bạn có thể nộp bài trước khi thời gian kết thúc bằng cách nhấn nút <b>Nộp bài</b>
                                </div>
                                <p class="note m-0">
                                    Lưu ý:
                                </p>
                                <div class="note-content">
                                    <p>Trong quá trình làm bài phải thường xuyên nhấn nút <b>lưu bài</b> để lưu lại đáp án.</p>
                                    <p>Những câu <b>chưa chọn đáp án</b> sẽ được tính là <b>câu trả lời sai.</b></p>
                                    <p>Nếu bạn <b>thoát ra</b> trong lúc chưa hết thời gian làm bài thi thì kết quả <b>sẽ không được tính.</b></p>
                                    <p>Sau khi nhấn <b>"Nộp bài"</b>, bài thi sẽ kết thúc và bạn sẽ <b>không thể sửa được bài thi</b> nữa.</p>
                                    <p>Thời gian làm bài thi có hạn, chú ý chia thời gian hợp lý cho mỗi câu để đạt kết quả tốt nhất.</p>
                                </div>
                            </div>
                            <div class="btn-group-do-exam">
                                <form action="${root}/CheckQServlet?idofquiz=<%=quiz.getQuizID()%>&idofsubject=<%=subjectID%>&idofuser=<%=userID%>&start=1" method="post">
                                    <a>
                                        <button class="btn-do-exam" type="submit" id="startquiz" onclick="return confirm('Bạn đã sẵn sàng chinh phục đề thi này?')">Bắt đầu làm bài</button>
                                    </a> 
                                </form>
                            </div>
                        </div>     
                        <div class="animate-box charts col-md-3 p-0">
                            <header class="card-header">
                                <h2 class="m-0">Bảng xếp hạng</h2>
                            </header>
                            <div class="exam-top-list">
                                <div class="top-header">
                                    <div class="col name">Tên</div>
                                    <div class="col">Điểm</div>
                                    <div class="col">Thời gian</div>
                                </div>
                                <%
                                    for (UserQuiz uq : new UserQuizDAO().getListUserQuizCharts(Integer.parseInt(quizID))) {
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
                                <div class="exam-item">
                                    <div class="row-content">
                                        <div class="col name">
                                            <span><%=uq.getUsername()%></span>
                                        </div>
                                        <div class="col score"><fmt:formatNumber value="<%=uq.getScore()%>" minFractionDigits="0" maxFractionDigits="2"/>đ</div>
                                        <div class="col time"><%=minutes%>:<%=seconds%></div>
                                    </div>
                                </div>
                                <hr/>                                
                                <%}%>
                            </div>
                        </div>
                        <div class="animate-box">
                            <h5 class="mb-2 text-center" style="color: red">Bạn có muốn chinh phục đề thi này</h5>
                            <div class="btn-group-do-exam">
                                <form action="${root}/CheckQServlet?idofquiz=<%=quiz.getQuizID()%>&idofsubject=<%=subjectID%>&idofuser=<%=userID%>&start=1" method="post">
                                    <a>
                                        <input class="btn-do-exam" style="width: 290px;" type="submit" value="Có, tôi muốn!" onclick="return confirm('Bạn đã sẵn sàng chinh phục đề thi này?')"/>
                                    </a> 
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="container animate-box"> 
                <h4><i class="fas fa-comments"></i> Ý kiến của bạn</h4>
                <div class="fb-comments" data-href="detail.jsp?quiz_id=<%=quiz.getQuizID()%>&subject_id=<%=quiz.getSubjectID()%>" data-width="820" data-numposts="5">
                </div>
            </div>
            <div id="fh5co-course">
                <div class="container">
                    <div class="animate-box mb-5">
                        <div class="heading_luyenthi text-center">
                            <h2>Đề thi liên quan</h2>
                        </div>
                    </div>
                    <div class="row">
                        <%
                            for (Quiz q : quizDAO.getListQuizRelate(Integer.parseInt(subjectID))) {
                                int countQExams = quizDAO.getCountQuizExams(q.getQuizID());
                                request.setAttribute("countQExams", countQExams);
                        %>
                        <div class="col-md-6 animate-box">
                            <div class="course">
                                <a
                                    href="detail.jsp?quiz_id=<%=q.getQuizID()%>&subject_id=<%=q.getSubjectID()%>"
                                    class="course-img"
                                    style="background-image: url('<%=q.getImage()%>')"
                                    >
                                </a>
                                <div class="desc">
                                    <h3>
                                        <a href="detail.jsp?quiz_id=<%=q.getQuizID()%>&subject_id=<%=q.getSubjectID()%>"
                                           ><%=q.getQuizName()%>
                                        </a
                                        >
                                    </h3>
                                    <p>
                                        <span>
                                            <i class="fa fa-bars"> </i>
                                            <a href="quiz.jsp?subject_id=<%=q.getSubjectID()%>&pages=1"><%=q.getSubjectName()%></a>
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
                                        <a href="detail.jsp?quiz_id=<%=q.getQuizID()%>&subject_id=<%=q.getSubjectID()%>" class="btn btn-primary btn-sm btn-course">xem chi tiết</a>
                                    </span>
                                </div>
                            </div>
                        </div>
                        <%}%>
                    </div>
                </div>
            </div>

            <jsp:include page="footer.jsp"></jsp:include>
            </div>
            <div class="gototop js-top">
                <a href="#" class="js-gotop"><i class="icon-arrow-up"></i></a>
            </div>

            <!-- jQuery -->
            <script src="${root}/js/jquery.min.js"></script>
        <!-- jQuery Easing -->
        <script src="${root}/js/jquery.easing.1.3.js"></script>
        <!-- Bootstrap -->
        <script src="${root}/js/bootstrap.min.js"></script>
        <!-- Waypoints -->
        <script src="${root}/js/jquery.waypoints.min.js"></script>
        <!-- Stellar Parallax -->
        <script src="${root}/js/jquery.stellar.min.js"></script>
        <!-- Carousel -->
        <script src="${root}/js/owl.carousel.min.js"></script>
        <!-- Flexslider -->
        <script src="${root}/js/jquery.flexslider-min.js"></script>
        <!-- countTo -->
        <script src="${root}/js/jquery.countTo.js"></script>
        <!-- Magnific Popup -->
        <script src="${root}/js/jquery.magnific-popup.min.js"></script>
        <script src="${root}/js/magnific-popup-options.js"></script>
        <!-- Count Down -->
        <script src="${root}/js/simplyCountdown.js"></script>
        <!-- Main -->
        <script src="${root}/js/main.js"></script>
        <script src="${root}/js/testdetail.js" type="text/javascript"></script>
        <!-- Modernizr JS -->
        <script src="${root}/js/modernizr-2.6.2.min.js"></script>
        <script type="text/javascript">
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

                                            //bảng xếp hạng
                                            $(function () {
                                                $('.col.name')[1].classList.add('top1');
                                                $('.col.name')[2].classList.add('top2');
                                                $('.col.name')[3].classList.add('top3');
                                            });
        </script>
    </body>
</html>
