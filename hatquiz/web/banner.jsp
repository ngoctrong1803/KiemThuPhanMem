<%@page import="model.Banner"%>
<%@page import="dao.BannerDAO"%>  
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            BannerDAO bannerDAO = new BannerDAO();
        %>
        <aside id="fh5co-hero">
            <div class="flexslider">
                <ul class="slides">
                    <%
                        for (Banner b : bannerDAO.getListBanner()) {
                    %>
                    <li style="background-image: url('<%=b.getImage()%>');">
                        <div class="overlay-gradient"></div>
                        <div class="container">
                            <div class="row">
                                <div class="col-md-8 col-md-offset-2 text-center slider-text">
                                    <div class="slider-text-inner">
                                        <h1><%=b.getContent()%></h1>                                         
                                        <p><a class="btn btn-primary btn-lg" href="quiz.jsp?pages=1">Luyện thi ngay!</a></p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </li> 
                    <%}%>                    
                </ul>
            </div>
        </aside>
      
    </body>
</html>