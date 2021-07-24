package controller;

import dao.SubjectDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Subject;

public class ManagerSubjectServlet extends HttpServlet {

    SubjectDAO subjectDAO = new SubjectDAO();
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ManagerSubjectServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManagerSubjectServlet at " + request.getContextPath() + "</h1>");
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
                    subjectDAO.delete(Integer.parseInt(request.getParameter("subject_id")));
                    session.setAttribute("remove_success", "Xóa thành công!");
                    url = "/admin/manager_subject.jsp";
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
        String sub_id = request.getParameter("subject_id");
        String sub_name = request.getParameter("name");
        String sub_icon = request.getParameter("icon");
        String sub_description = request.getParameter("description");
        String url = "";
        HttpSession session = request.getSession();
        try {
            switch (command) {
                case "insert":
                    subjectDAO.insert(new Subject(sub_name, sub_icon, sub_description, new Timestamp(System.currentTimeMillis())));
                    session.setAttribute("insert_success", "Thêm mới thành công!");
                    url = "/admin/manager_subject.jsp";
                    break;
                case "update":
                    subjectDAO.update(new Subject(Integer.parseInt(sub_id), sub_name, sub_icon, sub_description, new Timestamp(System.currentTimeMillis())));
                    session.setAttribute("update_success", "Cập nhật thành công!");
                    url = "/admin/manager_subject.jsp";
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();;
        }
        RequestDispatcher rd = getServletContext().getRequestDispatcher(url);
        rd.forward(request, response);
    }

}
