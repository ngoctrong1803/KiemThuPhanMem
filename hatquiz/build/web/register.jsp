<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <c:set var="root" value="${pageContext.request.contextPath}"/>
        <title>Đăng ký tài khoản</title>
        <!-- Font Icon -->
        <link rel="stylesheet" href="${root}/fonts/material-icon/css/material-design-iconic-font.min.css">
        <!-- Main css -->
        <link rel="stylesheet" href="${root}/css/regform.css">
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap" rel="stylesheet">
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link href="https://fonts.googleapis.com/css2?family=Lobster&display=swap" rel="stylesheet">
        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js" type="text/javascript"></script>
        <script type="text/javascript">
            $(document).ready(function () {
                var x_timer;
                $("#email").keyup(function (e) {
                    clearTimeout(x_timer);
                    var user_email = $(this).val();
                    x_timer = setTimeout(function () {
                        check_email_ajax(user_email);
                    }, 1000);
                });
                function check_email_ajax(email) {
                    $("#user-result").html('<img src="${root}/images/loader.gif"/>');
                    $.post('${root}/CheckEmailUserServlet', {'email': email}, function (data) {
                        $("#user-result").html(data);
                    });
                }
            });

            function validate()
            {
                var fullname_valid = /^[a-zA-ZÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶẸẺẼỀỀỂẾưăạảấầẩẫậắằẳẵặẹẻẽềềểếỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợụủứừỬỮỰỲỴÝỶỸửữựỳỵỷỹ\s\W|_]+$/;
                var fullname = document.getElementById("name").value;
                var password = document.getElementById("password").value;
                var spassword = document.getElementById("re_pass").value;
                if (!fullname_valid.test(fullname))
                {
                    alert("Vui lòng nhập họ tên hợp lệ!");
                    return false;
                }
                if (password.length < 6) {
                    alert("Mật khẩu ít nhất 6 ký tự");
                    return false;
                }
                if (password === spassword) {
                    return true;
                } else {
                    alert("Mật khẩu nhập lại không trùng khớp!");
                    return false;
                }
            }
        </script>
        <style>
            #user-result{
                position: absolute;
                top: 4px;
                right: 4px;
                width: 20px;                
                height: 20px;
            }
        </style>

    </head>
    <body>
        <div class="main">
            <section class="signup">
                <div class="container">
                    <div class="signup-content">
                        <div class="signup-form">
                            <h2 class="form-title">Đăng ký</h2>
                            <form action="${root}/UserServlet" method="POST" name="myForm" onsubmit="return validate()" class="register-form" id="register-form">
                                <div class="form-group">
                                    <label for="name"><i class="zmdi zmdi-account material-icons-name"></i></label>
                                    <input type="text" name="name" required="yes" id="name" placeholder="Họ tên" required="yes"/>
                                </div>
                                <div class="form-group">
                                    <label for="email"><i class="zmdi zmdi-email"></i></label>
                                    <input type="email" name="email" maxlength="50" required="yes" id="email" placeholder="Email"/>
                                    <span id="user-result"></span>
                                </div>
                                <div class="form-group">
                                    <label for="pass"><i class="zmdi zmdi-lock"></i></label>
                                    <input type="password" name="password" required="yes" id="password" placeholder="Mật khẩu"/>
                                </div>
                                <div class="form-group">
                                    <label for="re-pass"><i class="zmdi zmdi-lock-outline"></i></label>
                                    <input type="password" name="re_pass" required="yes" id="re_pass" placeholder="Nhập lại mật khẩu"/>
                                </div>
                                <div class="form-group">
                                    <label for="phone"><i class="zmdi zmdi-phone"></i></label>
                                    <input type="text" name="phone" placeholder="Điện thoại"/>
                                </div>
                                <div class="form-group">
                                    <label for="address"><i class="zmdi zmdi-city"></i></label>
                                    <input type="text" name="address" placeholder="Địa chỉ"/>
                                </div>
                                <%
                                    if (session.getAttribute("errorEmail") != null) {

                                %>
                                <div>
                                    <p style="color:red"><%=session.getAttribute("errorEmail")%></p>
                                </div>
                                <%
                                        session.removeAttribute("errorEmail");
                                    }
                                %>
                                <div class="form-group form-button">
                                    <input type="hidden" name="command" value="insert"/>
                                    <input type="submit" name="signup" id="signup" class="form-submit" value="Đăng ký"/>                                    
                                </div>
                            </form>
                        </div>
                        <div class="signup-image">
                            <figure><img src="${root}/images/signup-image.jpg" alt="sing up image"></figure>
                            <a href="login.jsp" class="signup-image-link">Bạn đã có tài khoản? Đăng nhập</a>
                        </div>
                    </div>
                </div>
            </section>
        </div>
        <script src="${root}/vendor/jquery/jquery.min.js"></script>
        <script src="${root}/js/regform.js"></script>
    </body>
</html>
