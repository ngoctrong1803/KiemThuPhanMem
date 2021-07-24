package controller;

import dao.BannerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Banner;

public class ManagerBannerServlet extends HttpServlet {

    BannerDAO bannerDAO = new BannerDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ManagerBannerServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManagerBannerServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        String command = request.getParameter("command");
        String url = "";
        HttpSession session = request.getSession();
        try {
            switch (command) {
                case "delete":
                    bannerDAO.delete(Integer.parseInt(request.getParameter("banner_id")));
                    session.setAttribute("remove_success", "Xóa thành công!");
                    url = "/admin/manager_banner.jsp";
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();;
        }
        RequestDispatcher rd = getServletContext().getRequestDispatcher(url);
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        String command = request.getParameter("command");
        String b_id = request.getParameter("banner_id");
        String bcontent = request.getParameter("content");
        String bimage = request.getParameter("image");
        String url = "";
        HttpSession session = request.getSession();
        try {
            switch (command) {
                case "insert":
                    bannerDAO.insert(new Banner(bcontent, bimage, new Timestamp(System.currentTimeMillis())));
                    session.setAttribute("insert_success", "Thêm mới thành công!");
                    url = "/admin/manager_banner.jsp";
                    break;
                case "update":
                    bannerDAO.update(new Banner(Integer.parseInt(b_id), bcontent, bimage, new Timestamp(System.currentTimeMillis())));
                    session.setAttribute("update_success", "Cập nhật thành công!");
                    url = "/admin/manager_banner.jsp";
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();;
        }
        RequestDispatcher rd = getServletContext().getRequestDispatcher(url);
        rd.forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
