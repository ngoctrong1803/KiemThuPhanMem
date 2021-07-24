package controller;

import dao.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.User;
import tools.MD5;

public class ManagerUserServlet extends HttpServlet {

    UserDAO userDAO = new UserDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ManagerUserServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManagerUserServlet at " + request.getContextPath() + "</h1>");
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
                    userDAO.delete(Integer.parseInt(request.getParameter("user_id")));
                    url = "/admin/manager_user.jsp";
                    session.setAttribute("remove_success", "Xóa thành công!");
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
        String user_id = request.getParameter("user_id");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String url = "";
        HttpSession session = request.getSession();
        try {
            switch (command) {
                case "insert":
                    userDAO.insert(new User(name, email, MD5.encryption(password), phone, address));
                    session.setAttribute("insert_success", "Thêm mới thành công!");
                    url = "/admin/manager_user.jsp";
                    break;
                case "update":
                    userDAO.update(new User(Integer.parseInt(user_id), name, email, MD5.encryption(password), phone, address));
                    session.setAttribute("update_success", "Cập nhật thành công!");
                    url = "/admin/manager_user.jsp";
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
