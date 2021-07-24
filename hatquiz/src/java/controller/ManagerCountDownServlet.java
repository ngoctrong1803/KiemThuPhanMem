package controller;

import dao.CountDownTHPTDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.CountDownTHPT;

public class ManagerCountDownServlet extends HttpServlet {

    CountDownTHPTDAO cdDAO = new CountDownTHPTDAO();

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
                    cdDAO.delete(Integer.parseInt(request.getParameter("cd_id")));
                    session.setAttribute("remove_success", "Xóa thành công!");
                    url = "/admin/manager_cd.jsp";
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
        String cd_id = request.getParameter("cd_id");
        String year = request.getParameter("year");
        String startday = request.getParameter("startday");
        String note = request.getParameter("note");
        String url = "";
        HttpSession session = request.getSession();
        try {
            switch (command) {
                case "insert":
                    cdDAO.insert(new CountDownTHPT(Integer.parseInt(year), startday, note));
                    session.setAttribute("insert_success", "Thêm mới thành công!");
                    url = "/admin/manager_cd.jsp";
                    break;
                case "update":
                    cdDAO.update(new CountDownTHPT(Integer.parseInt(cd_id), Integer.parseInt(year), startday, note));
                    session.setAttribute("update_success", "Cập nhật thành công!");
                    url = "/admin/manager_cd.jsp";
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
