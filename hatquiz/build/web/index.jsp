<%@page import="model.Quiz"%>
<%@page import="controller.SessionCounter"%>
<%@page import="dao.UserDAO"%>
<%@page import="dao.QuizDAO"%>
<%@page import="model.Subject"%>
<%@page import="dao.SubjectDAO"%>
<%@page import="dao.ViewDAO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <title>HatQuiz</title>
        <c:set var="root" value="${pageContext.request.contextPath}"/>
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
        <link rel="stylesheet" href="${root}/css/responsive.css" />

        <!-- Modernizr JS -->
        <script src="${root}/js/modernizr-2.6.2.min.js"></script>

    </head>
    <body>
        <div id="page">
            <jsp:include page="header.jsp"></jsp:include>
            <jsp:include page="banner.jsp"></jsp:include>
            <jsp:include page="content.jsp"></jsp:include>
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
        </script>
    </body>
</html>