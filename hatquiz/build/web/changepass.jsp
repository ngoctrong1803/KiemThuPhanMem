<%@page import="dao.UserDAO"%>
<%@page import="model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>

        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <title>Đổi mật khẩu</title>
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
    <body onload="onload()">
        <%
            User users = new User();
            if (session.getAttribute("user") != null) {
                users = (User) session.getAttribute("user");
                if (users == null) {
                    response.sendRedirect("login.jsp");
                }
            }
        %>        
        <div id="page">
            <jsp:include page="header.jsp"></jsp:include>    
                <div class="breadcrumb-wrap">
                    <div class="container-fluid">
                        <ul class="breadcrumb">
                            <li class="breadcrumb-item"><a href="index.jsp">Trang chủ</a></li>
                            <li class="breadcrumb-item">Đổi mật khẩu</li>
                        </ul>
                    </div>
                </div>
                <div class="main container">
                    <div style="width: 94%" class="infor_nav">
                        <p class="p_doc align_center tit_mem">
                            <a class="infor_menu" href="infor.jsp?user_id=<%=users.getUserID()%>"><i class="fa fa-info-circle" aria-hidden="true"></i> Thông tin chung</a> 
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                                                       
                        <a class="" href="history.jsp?user_id=<%=users.getUserID()%>"><i class="fa fa-clock" aria-hidden="true"></i> Thi trắc nghiệm</a>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  
                        <a class="" href="changepass.jsp?user_id=<%=users.getUserID()%>"><i class="fa fa-key" aria-hidden="true"></i> Đổi mật khẩu</a>
                    </p>
                </div>
                <div class="infor_nav">                   
                    <h1>Đổi mật khẩu tài khoản</h1>
                    <%
                        if (session.getAttribute("message") != null) {
                    %>
                    <input id="message" value="<%=session.getAttribute("message")%>" class="hidden">                        
                    </input>
                    <%
                            session.removeAttribute("message");
                        }
                    %>

                    <form class="form" action="UserServlet" method="post" onsubmit="return validate()">                          
                        <input type="password" name="oldpass" required="yes" placeholder="Nhập mật khẩu cũ">                                           
                        <input type="password" name="newpass" required="yes" id="newpass" placeholder="Nhập mật khẩu mới">
                        <input type="password" name="conpass" required="yes" id="conpass" placeholder="Nhập lại mật khẩu mới"> 
                        <input type="hidden" name="command" value="reset"> 
                        <input type="hidden" name="user_id" value="<%=request.getParameter("user_id")%>"> 
                        <input type="submit" value="đổi mật khẩu" name="reset">
                    </form>
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
        <script>
                        function onload() {
                            var message = document.getElementById("message").value;
                            if (message) {
                                alert(message);
                                return false;
                            }
                        }
                        function validate()
                        {
                            var newpass = document.getElementById("newpass").value;
                            var conpass = document.getElementById("conpass").value;

                            if (newpass.length < 6) {
                                alert("Mật khẩu ít nhất 6 ký tự");
                                return false;
                            }
                            if (newpass === conpass) {
                                return true;
                            } else {
                                alert("Mật khẩu nhập lại không trùng khớp");
                                return false;
                            }
                        }
        </script>  
    </body>
</html>
