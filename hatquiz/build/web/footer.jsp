<%@page import="dao.SubjectDAO"%>
<%@page import="model.Subject"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <footer id="fh5co-footer" role="contentinfo" style="background-image: url(images/img_bg_4.jpg);">
            <div class="overlay"></div>           
            <div class="container">
                <div class="row row-pb-md">
                    <div class="col-md-3 fh5co-widget">
                        <h3>HatQuiz</h3>
                        <p>Tổng hợp đề thi trắc nghiệm online THPT QG của các môn Toán, Tiếng Anh, Vật lý, Hóa học, Sinh học kèm đáp án và lời giải chi tiết.</p>
                    </div>
                    <div class="col-md-2 col-sm-4 col-xs-6 col-md-push-1 fh5co-widget">
                        <h3>THI THPT QG</h3>
                        <ul class="fh5co-footer-links">
                            <%
                                for (Subject s : new SubjectDAO().getListSubject()) {

                            %>
                            <li><a href="quiz.jsp?subject_id=<%=s.getSubjectID()%>&pages=1"><%=s.getSubjectName()%></a></li>
                                <%}%>
                        </ul>
                    </div>

                    <div class="col-md-2 col-sm-4 col-xs-6 col-md-push-1 fh5co-widget">
                        <h3>ĐỀ KIỂM TRA</h3>
                        <ul class="fh5co-footer-links">
                            <li><a href="javascript:void(0)">Đề thi HK1,HK2</a></li>
                            <li><a href="javascript:void(0)">Kiểm tra 1 tiết</a></li>
                            <li><a href="javascript:void(0)">Kiểm tra 15 phút</a></li>                            
                        </ul>
                    </div>

                    <div class="col-md-4 col-sm-4 col-xs-6 col-md-push-1 fh5co-widget">
                        <h3>THÔNG TIN LIÊN HỆ</h3>
                        <ul class="fh5co-footer-links">
                            <li><a href="javascript:void(0)">Địa chỉ: Số 113, đường Nguyễn Tất Thành, Q4, TP HCM</a></li>
                            <li><a href="javascript:void(0)">Điện thoại: 0123456789</a></li>
                            <li><a href="javascript:void(0)">Email: hatquiz@edu.com.vn</a></li>                            
                        </ul>
                    </div>
                </div>

                <div class="row copyright">
                    <div class="col-md-12 text-center">
                        <p>                            
                            <small class="block">
                                Copyright © 2021 by hatquiz.net
                            </small>
                        </p>
                    </div>
                </div>
            </div>
        </footer>
        <script>
            !function (s, u, b, i, z) {
                var o, t, r, y;
                s[i] || (s._sbzaccid = z, s[i] = function () {
                    s[i].q.push(arguments)
                },
                        s[i].q = [], s[i]("setAccount", z), r = ["widget.subiz.net", "storage.googleapis" + (t = ".com"),
                    "app.sbz.workers.dev", i + "a" + (o = function (k, t) {
                        var n = t <= 6 ? 5 : o(k, t - 1) + o(k, t - 3);
                        return k !== t ? n : n.toString(32)
                    })(20, 20) + t, i + "b" + o(30, 30) + t, i + "c" + o(40, 40) + t],
                        (y = function (k) {
                            var t, n;
                            s._subiz_init_2094850928430 || r[k] &&
                                    (t = u.createElement(b), n = u.getElementsByTagName(b)[0],
                                            t.async = 1, t.src = "https://" + r[k] + "/sbz/app.js?accid=" + z, n.parentNode.insertBefore(t, n),
                                            setTimeout(y, 2e3, k + 1))
                        })(0))
            }(window, document, "script", "subiz", "acqztbeoejhihvyjxamm")
        </script>
    </body>
</html>




