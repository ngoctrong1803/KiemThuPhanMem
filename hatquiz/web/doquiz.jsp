<%@page import="model.User"%>
<%@page import="model.Question"%>
<%@page import="dao.QuestionDAO"%>
<%@page import="model.Quiz"%>
<%@page import="dao.QuizDAO"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/css/bootstrap-grid.min.css" integrity="sha512-cKoGpmS4czjv58PNt1YTHxg0wUDlctZyp9KUxQpdbAft+XqnyKvDvcGX0QYCgCohQenOuyGSl8l1f7/+axAqyg==" crossorigin="anonymous" />
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
        <meta property="og:description" content="" />
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
        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js" type="text/javascript"></script>
        <script type="text/javascript" src="js/countdownTQ.js"></script>
        <script type="text/javascript" src="js/testdetail.js"></script>
        <!-- Modernizr JS -->
        <script src="js/modernizr-2.6.2.min.js"></script>
        <style type='text/css'>
            p{
                margin: 0;
            }
            body {
                -webkit-touch-callout: none;
                -webkit-user-select: none;
                -moz-user-select: none;
                -ms-user-select: none;
                -o-user-select: none;
                user-select: none;
            }
            .formatquestion input{
                transform: translateY(2px);
            }
            #result{
                flex: 0 0 23%;
                height: min-content;
            }
        </style>
    </head>
    <body onkeydown="return false">
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
            } else {
                response.sendRedirect("login.jsp");
            }
        %>
        <div id="page">
            <jsp:include page="header.jsp"></jsp:include>    
                <div class="breadcrumb-wrap">
                    <div class="container-fluid p-0">
                        <ul class="breadcrumb">
                            <li class="breadcrumb-item"><a href="index.jsp">Trang chủ</a></li>
                            <li class="breadcrumb-item"><a href="quiz.jsp?pages=1">Thi THPT QG</a></li>
                            <li class="breadcrumb-item"><a href="quiz.jsp?subject_id=<%=quiz.getSubjectID()%>&pages=1"><%=quiz.getSubjectName()%></a></li>
                        <li class="breadcrumb-item"><%=quiz.getQuizName()%></li>
                    </ul>
                </div>
            </div>
            <div class="container">
                <div class="row">
                    <div class="animate-box detail col-md-9">
                        <h3 class="m-0"><%=quiz.getQuizName()%></h3>
                        <p class="mb-4">
                            <span>
                                <i class="fa fa-clock"> </i>
                                Cập nhật: <fmt:formatDate type = "both" dateStyle = "short" timeStyle = "short" value="<%=quiz.getCreatedate()%>" />
                            </span>  
                        </p>
                        <div class="detail-question">
                            <span class="mr-2"> 
                                <i class="fa fa-check-square"> </i>
                                Môn:&nbsp;<a href=""><%=quiz.getSubjectName()%></a>
                            </span>                            
                            <span class="mr-2">
                                <i class="fa fa-list-alt"> </i>
                                Số câu hỏi: <%=quiz.getTotalQuestion()%> câu
                            </span>  
                            <span class="mr-2 d-flex align-items-center" id="clock">
                                <img width="69" src="images/clock.png" />
                                <span class="ml-2" id="countdown" style="color: red; font-size: 30px;"></span>
                                <span hidden id="timeofquiz"><%=quiz.getTime()%></span>
                            </span>
                        </div>
                        <div class="contentoftest">
                            <span id="idofquiz" style="display: none"><%=quiz.getQuizID()%></span>
                            <span id="idofuser" style="display: none"><%=u.getUserID()%></span>
                            <span id="idofsubject" style="display: none"><%=quiz.getSubjectID()%></span>
                            <div id ="myForm"> 
                                <!--content-->
                                <% QuestionDAO quesDao = new QuestionDAO();%>
                                <div>
                                    <%
                                        int i = 1;
                                        for (Question ques : quesDao.getListQuestionByQuiz(quiz.getQuizID())) {
                                    %>
                                    <div class="formatquestion">
                                        <b>
                                            <span class="mr-1">Câu <%=i%>:</span> 
                                            <%=ques.getContent()%>
                                        </b>
                                        <div class="row">
                                            <% if (ques.getqA() != "") {%>
                                            <div class="col-md-6 d-flex align-items-baseline mt-2 mb-2">
                                                <input class="radiobutton" id="qa <%=i%>" type="radio" name="<%=ques.getQuestionID()%>" value='<%=ques.getqA().replaceAll("[\n\r]$", "").replaceAll("[\\s\r]$", "").replaceAll("[&nbsp;\r]$", "")%>' /> 
                                                <label class="d-flex" for="qa <%=i%>"><span class="mr-1">A.</span><%=ques.getqA()%></label>
                                                <span id="answer_result_<%=ques.getQuestionID()%>1"></span>
                                            </div>
                                            <%}%>
                                            <% if (ques.getqB() != "") {%>
                                            <div class="col-md-6 d-flex align-items-baseline mt-2 mb-2">
                                                <input class="radiobutton" id="qb <%=i%>" type="radio" name="<%=ques.getQuestionID()%>" value='<%=ques.getqB().replaceAll("[\n\r]$", "").replaceAll("[\\s\r]$", "").replaceAll("[&nbsp;\r]$", "")%>' /> 
                                                <label class="d-flex" for="qb <%=i%>"><span class="mr-1">B.</span><%=ques.getqB()%></label>
                                                <span id="answer_result_<%=ques.getQuestionID()%>2"></span>
                                            </div>
                                            <%}%>
                                        </div>
                                        <div class="row">
                                            <% if (ques.getqC() != "") {%>
                                            <div class="col-md-6 d-flex align-items-baseline mt-2 mb-2">
                                                <input class="radiobutton" id="qc <%=i%>" type="radio" name="<%=ques.getQuestionID()%>" value='<%=ques.getqC().replaceAll("[\n\r]$", "").replaceAll("[\\s\r]$", "").replaceAll("[&nbsp;\r]$", "")%>' /> 
                                                <label class="d-flex" for="qc <%=i%>"><span class="mr-1">C.</span><%=ques.getqC()%></label>
                                                <span id="answer_result_<%=ques.getQuestionID()%>3"></span>
                                            </div>
                                            <%}%>
                                            <% if (ques.getqD() != "") {%>
                                            <div class="col-md-6 d-flex align-items-baseline mt-2 mb-2">
                                                <input class="radiobutton" id="qd <%=i%>" type="radio" name="<%=ques.getQuestionID()%>" value='<%=ques.getqD().replaceAll("[\n\r]$", "").replaceAll("[\\s\r]$", "").replaceAll("[&nbsp;\r]$", "")%>' /> 
                                                <label class="d-flex" for="qd <%=i%>"><span class="mr-1">D.</span><%=ques.getqD()%></label>
                                                <span id="answer_result_<%=ques.getQuestionID()%>4"></span>
                                            </div>
                                            <%}%>
                                        </div>
                                        <% if (request.getAttribute("imgincorrectanswer") != "" && request.getAttribute("imgcorrectanswer") != "") {%>
                                        <div class="notdoquiz d-none">
                                            <span id="user_answer_<%=ques.getQuestionID()%>1"></span>
                                            <span id="user_answer_<%=ques.getQuestionID()%>2"></span> 
                                            <span id="user_answer_<%=ques.getQuestionID()%>3"></span>
                                            <span id="user_answer_<%=ques.getQuestionID()%>4"></span>
                                            <% if (request.getAttribute("imgunchecked") != "") {%>
                                            <span id="uncheck_<%=ques.getQuestionID()%>"></span>
                                            <%}%>
                                        </div>
                                        <%}%>
                                    </div>
                                    <%
                                            i = i + 1;
                                        }
                                    %>  
                                </div>
                            </div>
                            <div class="d-flex">
                                <div class="btn-group-do-exam mr-4">        
                                    <button class="btn-do-exam" id="savetest" value="savetest" style="background: #2d6cdf">Lưu bài</button>
                                    <span id="savetest"></span>
                                </div>
                                <div class="btn-group-do-exam">
                                    <button class="btn-do-exam" id="submit" value="submit" onclick="return confirm('Bạn chắc chắn muốn nộp bài? \nHãy kiểm tra thật kĩ trước khi bạn muốn nộp bài!!!')">Nộp bài</button>
                                </div>
                                <div class="btn-group-do-exam">        
                                    <button class="btn-do-exam" id="loadanswer" value="loadanswer">Xem đáp án</button>
                                </div>
                            </div>
                        </div> 
                    </div>
                    <div class="animate-box charts col-md-3 p-0" id="result">
                        <div class="box-charts">
                            <header class="card-header">
                                <h2 class="m-0">Kết quả thi</h2>
                                <span id='result'></span>
                            </header>
                            <div class="exam-top-list">
                                <div class="top-header">
                                    <div class="col name">Số câu đúng</div>
                                    <div class="col">Điểm</div>
                                    <div class="col">Thời gian</div>
                                </div>
                                <div class="exam-item">
                                    <div class="row-content">
                                        <div class="col name">                                       
                                            <span id="sumcorrectanswer"></span>/<span id="sumquestions"></span>  
                                        </div>
                                        <div class="col score"> 
                                            <span id="score"></span>
                                        </div>
                                        <div class="col time">
                                            <span id="minutes"></span>:<span id="seconds"></span>
                                        </div>
                                    </div>
                                </div>
                                <hr/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <jsp:include page="footer.jsp"></jsp:include>
        </div>
        <div class="gototop js-top">
            <a href="#" class="js-gotop"><i class="icon-arrow-up"></i></a>
        </div>

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
        <script>
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

                                        //scroll time
                                        window.onscroll = function () {
                                            scrollFunction()
                                        };

                                        function scrollFunction() {
                                            var countdown = document.getElementById("clock");
                                            if (document.body.scrollTop > 300 || document.documentElement.scrollTop > 300) {
                                                Object.assign(countdown.style, {position: "fixed", top: "0", right: "18%", background: "#fafafa",
                                                    padding: "30px 18px", borderRadius: "5px", boxShadow: "rgb(136,136,136) 0px 2px 15px -5px"});
                                            } else {
                                                Object.assign(countdown.style, {position: "unset", background: "unset",
                                                    padding: "unset", borderRadius: "unset", boxShadow: "unset"});
                                            }
                                        }

        </script>
        <!--Code chống chuột Phải-->
        <script type='text/javascript'>
            //<![CDATA[
            // JavaScript Document
            var message = "NoRightClicking";
            function defeatIE() {
                if (document.all) {
                    (message);
                    return false;
                }
            }
            function defeatNS(e) {
                if (document.layers || (document.getElementById && !document.all)) {
                    if (e.which === 2 || e.which === 3) {
                        (message);
                        return false;
                    }
                }
            }
            if (document.layers) {
                document.captureEvents(Event.MOUSEDOWN);
                document.onmousedown = defeatNS;
            } else {
                document.onmouseup = defeatNS;
                document.oncontextmenu = defeatIE;
            }
            document.oncontextmenu = new Function("return false")
            //]]>
        </script>
        <!--Code chống F12, Ctrl+U để xem mã nguồn (viewsourse)-->
        <script type='text/javascript'>
            checkCtrl = false $('*').keydown(function (e) {
                if (e.keyCode === '17') {
                    checkCtrl = false;
                }
            }).keyup(function (ev) {
                if (ev.keyCode === '17') {
                    checkCtrl = false;
                }
            }).keydown(function (event) {
                if (checkCtrl) {
                    if (event.keyCode === '85') {
                        return false;
                    }
                }
            })
        </script>
    </body>
</html>
