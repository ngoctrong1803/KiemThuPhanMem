<%@page import="dao.CountDownTHPTDAO"%>
<%@page import="model.CountDownTHPT"%>
<%@page import="model.Quiz"%>
<%@page import="model.Subject"%>
<%@page import="controller.SessionCounter"%>
<%@page import="dao.UserDAO"%>
<%@page import="dao.ViewDAO"%>
<%@page import="dao.QuizDAO"%>
<%@page import="dao.SubjectDAO"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"
            rel="stylesheet"
            />
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@400;500;600;700&display=swap" rel="stylesheet">
        <style>
            .container .countdown {
                position: relative;
                color: #333;
                margin: 0 auto;
                text-align: center;
            }
            .countdown_item {
                display: inline-block;
                font-size: 1.5em;
                list-style-type: none;
                line-height: normal;
                padding: 1em;
                text-transform: uppercase;
                border-radius: 5px;
                width: 140px;
                height: 130px;
                margin: 0px 2px;
                background: rgb(227,227,228);
            }
            .countdown_item span {
                display: block;
                font-size: 4.5rem;
                font-weight: 900;
            }
            .countdown_item #days,
            .countdown_item #hours,
            .countdown_item #minutes,
            .countdown_item #seconds{
                color: black;
            }
            .countdown_music{
                margin-top: 40px;
            }
            .tryhard{
                border: 2px solid #fff;
                padding: 5px 25px;
                color: #fff;
                font-size: 18px;
                font-weight: 600;
                margin-top: 30px;
                display: inline-block;
                cursor: pointer;
            }
            .tryhard:hover{
                background: #fff;
                color: #333;
            }
            .tryhard img{
                width: 20px;
            }
            .emoji {
                display: none;
                padding: 1rem;
            }

            .emoji span {
                font-size: 4rem;
                padding: 0 .5rem;
            }
            @media all and (max-width: 768px) {
                .countdown_item {
                    font-size: 1.125rem;
                    padding: .75rem;
                }
                .countdown_item span {
                    font-size: 3.375rem;
                }
            }
        </style>
    </head>
    <body>
        <%
            SubjectDAO subjectDAO = new SubjectDAO();
            QuizDAO quizDAO = new QuizDAO();
            ViewDAO viewDAO = new ViewDAO();
            UserDAO userDAO = new UserDAO();
            // T???ng l?????t truy c???p  
            int view = viewDAO.getViews();
            application.setAttribute("view", view);
            if (view != 0) {
                if (session.isNew()) {
                    viewDAO.updateView();
                }
            }

            // T???ng h???c vi??n
            int users = userDAO.getCount();
            request.setAttribute("users", users);

            // ??ang truy c???p
            SessionCounter counter = (SessionCounter) session.getAttribute(SessionCounter.COUNTER);

            // T???ng ????? thi
            int countQ = quizDAO.getCountQuiz();
            request.setAttribute("countQ", countQ);

        %>

        <div id="fh5co-course-categories">
            <div class="container">
                <div class="row animate-box">
                    <div class="col-md-6 col-md-offset-3 text-center fh5co-heading">
                        <h2>C??c m??n thi</h2>
                        <p>C?? l??m th?? m???i c?? ??n, kh??ng l??m m?? ????i ??n th?? ch??? c?? ??n ... ??n :poop:</p>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-4 col-sm-6 text-center animate-box">
                        <div class="services">
                            <a class="icon" href="quiz.jsp?pages=1">
                                <i class="fa fa-graduation-cap"></i>
                            </a>
                            <div class="desc">
                                <h3><a href="quiz.jsp?pages=1">T???t c???</a></h3>
                                <p>Bi???t th?? n??i l?? bi???t. Kh??ng bi???t th?? n??i l?? kh??ng bi???t. Th??? m???i g???i l?? bi???t.<br> <b><i>"Kh???ng T???"</i></b></p>
                            </div>
                        </div>
                    </div>
                    <%                            for (Subject s : subjectDAO.getListSubject()) {
                    %>
                    <div class="col-md-4 col-sm-6 text-center animate-box">
                        <div class="services">
                            <a class="icon" href="quiz.jsp?subject_id=<%=s.getSubjectID()%>&pages=1">
                                <i class="<%=s.getSubjectIcon()%>"></i>
                            </a>
                            <div class="desc">
                                <h3><a href="quiz.jsp?subject_id=<%=s.getSubjectID()%>&pages=1"><%=s.getSubjectName()%></a></h3>
                                <p id="test"><%=s.getDescription()%></p>
                            </div>
                        </div>
                    </div>
                    <%
                        }
                    %>          
                </div>
            </div>
        </div>

        <div id="fh5co-counter" class="fh5co-counters" data-stellar-background-ratio="0.5">
            <div class="overlay" style="background: #25314f;"></div>
            <div class="container">
                <div class="row">
                    <div class="col-md-10 col-md-offset-1">
                        <div class="row">
                            <div class="col-md-3 col-sm-6 text-center animate-box">
                                <span class="icon"><i class="icon-world"></i></span>
                                <span class="fh5co-counter js-counter" data-from="0" data-to="<%=view%>" data-speed="5000" data-refresh-interval="50"></span>
                                <span class="fh5co-counter-label">T???ng l?????t truy c???p</span>
                            </div>
                            <div class="col-md-3 col-sm-6 text-center animate-box">
                                <span class="icon"><i class="icon-study"></i></span>
                                <span class="fh5co-counter js-counter" data-from="0" data-to="<%=users%>" data-speed="5000" data-refresh-interval="50"></span>
                                <span class="fh5co-counter-label">S??? l?????ng h???c vi??n</span>
                            </div>
                            <div class="col-md-3 col-sm-6 text-center animate-box">
                                <span class="icon"><i class="fas fa-bolt"></i></span>
                                <span class="fh5co-counter js-counter" data-from="0" data-to="<%=counter.getActiveSessionNumber()%>" data-speed="5000" data-refresh-interval="50"></span>
                                <span class="fh5co-counter-label">??ang truy c???p</span>
                            </div>
                            <div class="col-md-3 col-sm-6 text-center animate-box">
                                <span class="icon"><i class="icon-book2"></i></span>
                                <span class="fh5co-counter js-counter" data-from="0" data-to="<%=countQ%>" data-speed="5000" data-refresh-interval="50"></span>
                                <span class="fh5co-counter-label">S??? l?????ng ????? thi</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div id="fh5co-course">
            <div class="container">
                <div class="row animate-box">
                    <div class="col-md-6 col-md-offset-3 text-center fh5co-heading">
                        <h2>????? thi m???i nh???t</h2>
                        <p class="m-0">"Nh???ng g?? ch??ng ta bi???t ng??y h??m nay s??? l???i th???i v??o ng??y h??m sau.</p>
                        <p>N???u ch??ng ta ng???ng h???c th?? ch??ng ta s??? ng???ng ph??t tri???n."</p>
                    </div>
                </div>
                <div class="row">
                    <%
                        for (Quiz q : quizDAO.getListQuizLatest()) {
                            int countQExams = quizDAO.getCountQuizExams(q.getQuizID());
                            request.setAttribute("countQExams", countQExams);
                    %>    
                    <div class="col-md-6 animate-box">
                        <div class="course">
                            <a href="detail.jsp?quiz_id=<%=q.getQuizID()%>&subject_id=<%=q.getSubjectID()%>" class="course-img" style="background-image: url(<%=q.getImage()%>);">
                            </a>
                            <div class="desc">
                                <h3><a href="detail.jsp?quiz_id=<%=q.getQuizID()%>&subject_id=<%=q.getSubjectID()%>"><%=q.getQuizName()%></a></h3>
                                <p style="font-size: 15px; display: grid" class="ltin">
                                    <span><i class="fa fa-bars" aria-hidden="true"></i> <a href="quiz.jsp?subject_id=<%=q.getSubjectID()%>&pages=1"><%=q.getSubjectName()%></a></span>                                             
                                    <span><i class="fa fa-question-circle" aria-hidden="true"></i> S??? c??u h???i: <%=q.getTotalQuestion()%> c??u </span>
                                    <span><i class="fa fa-clock" aria-hidden="true"></i>  Th???i gian: <%=q.getTime()%> ph??t</span> 
                                    <span><i class="fa fa-signal" aria-hidden="true"></i>  L?????t thi: <%=countQExams%></span>
                                    <span><i class="fas fa-edit" aria-hidden="true"></i> ????ng t???i: <fmt:formatDate pattern="dd-MM-yyyy" value="<%=q.getCreatedate()%>" /></span>
                                </p>
                                <span><a href="detail.jsp?quiz_id=<%=q.getQuizID()%>&subject_id=<%=q.getSubjectID()%>" class="btn btn-primary btn-sm btn-course">Xem chi ti???t</a></span>
                            </div>
                        </div>
                    </div>
                    <%}%>
                </div>
            </div>
        </div>

        <div id="fh5co-testimonial" style="background-image: url('images/school.jpg')">
            <div class="container">
                <div class="row animate-box">
                    <div class="col-md-6 col-md-offset-3 text-center fh5co-heading">
                        <h2><span>C???m nh???n ng?????i h???c</span></h2>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-10 col-md-offset-1">
                        <div class="row animate-box">
                            <div class="owl-carousel owl-carousel-fullwidth">
                                <div class="item">
                                    <div class="testimony-slide active text-center">
                                        <div class="user" style="background-image: url('images/anh-anime-1.jpg');"></div>
                                        <span>Tr???n Quang Huy<br><small>H???c sinh</small></span>
                                        <blockquote>
                                            <p>&ldquo;Nh??? c??c kh??a h???c em ???? c?? ???????c ?????nh h?????ng cho b???n th??n m??nh, t??? tin h??n v?? kh??ng c???m th???y hoang mang v??? c??c k?? n??ng h???c n???a!&rdquo;</p>
                                        </blockquote>
                                    </div>
                                </div>
                                <div class="item">
                                    <div class="testimony-slide active text-center">
                                        <div class="user" style="background-image: url('images/anh-anime-2.jpg');"></div>
                                        <span>Nguy???n Ho??ng Anh<br><small>H???c sinh</small></span>
                                        <blockquote>
                                            <p>&ldquo;Em ???? h???c ??? website n??y t??? l??u r???i, th???y r???t t???t, nh???ng b??i thi ???????c l??m r???t c??ng phu, h??nh ???nh ?????p v?? n??t!&rdquo;</p>
                                        </blockquote>
                                    </div>
                                </div>
                                <div class="item">
                                    <div class="testimony-slide active text-center">
                                        <div class="user" style="background-image: url('images/anh-anime-3.jpg');"></div>
                                        <span>Tr????ng Quang Minh<br><small>H???c sinh</small></span>
                                        <blockquote>
                                            <p>&ldquo;C??c kh??a h???c tr??n website r???t b??? ??ch gi??p em c?? th??m nhi???u k??? n??ng s???ng, l??m vi???c. Em c???m th???y r???t t??? tin v??o b???n th??n!&rdquo;</p>
                                        </blockquote>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div id="fh5co-testimonial" style="background-image: url(images/countdown.jpg); background-size: cover;">
            <div class="overlay" style="background: rgba(31, 95, 139, 0.4);"></div>
            <div class="container">
                <div class="row animate-box">
                    <%
                        for (CountDownTHPT cd : new CountDownTHPTDAO().getListCountDownTHPT()) {
                    %>
                    <div class="col-md-6 col-md-offset-3 text-center fh5co-heading">
                        <h2>K??? THI THPT QU???C GIA <%=cd.getYear()%></h2>
                        <h2 style="font-family: 'Dancing Script', cursive; font-size: 60px;">C??ng ?????m Ng?????c N??o!</h2>
                        <h4 style="color: #fff; margin: 0"><%=cd.getNote()%></h4>
                        <span hidden id="startday-thptqg"><%=cd.getStartDay()%></span>
                    </div>
                    <%}%>
                </div>
                <div class="row animate-box">
                    <div class="countdown">
                        <div id="countdown">
                            <ul style="padding: 0">
                                <li class="countdown_item"><span id="days"></span>ng??y</li>
                                <li class="countdown_item"><span id="hours"></span>gi???</li>
                                <li class="countdown_item"><span id="minutes"></span>ph??t</li>
                                <li class="countdown_item"><span id="seconds"></span>gi??y</li>
                            </ul>
                        </div>
                        <div id="content" class="emoji">
                            <span>????</span>
                            <span>????</span>
                            <span>????</span>
                        </div>
                        <div class="countdown_music">
                            <audio controls>
                                <source src="music/Demons-Boyce-Avenue-Jennel-Garcia.mp3" type="audio/mpeg">
                            </audio> 
                        </div>
                        <span class="tryhard">
                            <img src="images/rocket.png" />
                            H??Y C??? G???NG CHO K??? THI S???P T???I!!!
                        </span>
                    </div>
                </div>
            </div>
        </div>
    </body>
    <script>
        (function () {
            const second = 1000,
                    minute = second * 60,
                    hour = minute * 60,
                    day = hour * 24;
            let exam_thpt = document.getElementById("startday-thptqg").innerHTML;
            countDown = new Date(exam_thpt).getTime(),
                    x = setInterval(function () {

                        let now = new Date().getTime(),
                                distance = countDown - now;

                        document.getElementById("days").innerText = Math.floor(distance / (day)),
                                document.getElementById("hours").innerText = Math.floor((distance % (day)) / (hour)),
                                document.getElementById("minutes").innerText = Math.floor((distance % (hour)) / (minute)),
                                document.getElementById("seconds").innerText = Math.floor((distance % (minute)) / second);

                        //do something later when date is reached
                        if (distance < 0) {
                            let headline = document.getElementById("headline"),
                                    countdown = document.getElementById("countdown"),
                                    content = document.getElementById("content");

                            headline.innerText = "Ch??c c??c b???n thi t???t!!!";
                            countdown.style.display = "none";
                            content.style.display = "block";

                            clearInterval(x);
                        }
                        //seconds
                    }, 0)
        }());
    </script>
</html>
