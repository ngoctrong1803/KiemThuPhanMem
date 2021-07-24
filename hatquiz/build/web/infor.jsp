<%@page import="dao.UserDAO"%>
<%@page import="model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <title>Thông tin tài khoản</title>
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
        <link rel="stylesheet" href="css/infor.css" />
        <link rel="stylesheet" href="css/responsive.css" />

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css"/>     

        <!-- Modernizr JS -->
        <script src="js/modernizr-2.6.2.min.js"></script>        
    </head>
    <body>
        <%
            User users = (User) session.getAttribute("user");
            if (users == null) {
                response.sendRedirect("login.jsp");
            }
        %>
        <div id="page">
            <jsp:include page="header.jsp"></jsp:include>    
                <div class="breadcrumb-wrap">
                    <div class="container-fluid">
                        <ul class="breadcrumb">
                            <li class="breadcrumb-item"><a href="index.jsp">Trang chủ</a></li>
                            <li class="breadcrumb-item">Thông tin tài khoản</li>
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
                    <%
                        String id = request.getParameter("user_id");
                        User u = new UserDAO().getUserByID(Integer.parseInt(id));
                    %>
                    <h1>Thông tin chung</h1>                
                    <%
                        if (session.getAttribute("update_success") != null) {
                    %>
                    <div>
                        <p style="color:red"><%=session.getAttribute("update_success")%></p>
                    </div>
                    <%
                            session.removeAttribute("update_success");
                        }
                    %>
                    <form class="form" action="UserServlet" method="post">
                        <table style="text-align: left; line-height: 22px;">
                            <tbody><tr>
                                    <td>Tài khoản đăng nhập:&nbsp;&nbsp;&nbsp;</td><td><b><%=u.getEmail()%></b></td>
                                </tr>                                                                 
                            </tbody>
                        </table>
                        <input type="text" name="name" value="<%=u.getFullName()%>" required="yes" maxlength="30" placeholder="Họ và tên">                                           
                        <input type="text" name="phone" value="<%=u.getPhone()%>" required="yes" maxlength="10" placeholder="Số điện thoại">
                        <input type="text" name="address" value="<%=u.getAddress()%>" required="yes" maxlength="250" placeholder="Địa chỉ">   
                        <input type="hidden" name="command" value="update"> 
                        <input type="hidden" name="user_id" value="<%=request.getParameter("user_id")%>"> 
                        <input type="submit" value="Cập nhật" name="capnhat">
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
    </body>
</html>
