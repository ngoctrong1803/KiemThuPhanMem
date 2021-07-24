package controller;

import dao.AdminDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Administrator;
import tools.MD5;

public class AdminServlet extends HttpServlet {

    AdminDAO adminDAO = new AdminDAO();

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
                    adminDAO.delete(Integer.parseInt(request.getParameter("admin_id")));
                    session.setAttribute("remove_success", "Xóa thành công!");
                    url = "/admin/manager_admin.jsp";
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
        String admin_id = request.getParameter("admin_id");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String command = request.getParameter("command");
        String status = request.getParameter("status");
        String url = "";
        Administrator admin = new Administrator();
        HttpSession session = request.getSession();
        switch (command) {
            case "register":
                if (!adminDAO.checkEmail(email)) {
                    admin.setFullName(name);
                    admin.setEmail(email);
                    admin.setPassword(MD5.encryption(password));
                    //mặc định trạng thái là false, admin tối cao sẽ cấp cho bạn thành true để được quyền quản trị
                    admin.setStatus(Boolean.FALSE);
                    adminDAO.registerAdmin(admin);
                    session.setAttribute("admin", admin);
                    session.setAttribute("success", "Đăng ký thành công. Vui lòng đợi admin xét duyệt quyền!");
                    url = "/admin/register.jsp";
                } else {
                    session.setAttribute("errorEmail", "Email này đã tồn tại!");
                    url = "/admin/register.jsp";
                }
                break;
            case "login":
                Administrator ad = adminDAO.checkLogin(email, MD5.encryption(password));
                if (ad != null) {
                    session.setAttribute("admin", ad);
                    url = "/admin/index.jsp";
                } else {
                    session.setAttribute("error", "Email hoặc mật khẩu không đúng!");
                    url = "/admin/login.jsp";
                }
                break;
            case "insert": {
                try {
                    adminDAO.insert(new Administrator(name, email, MD5.encryption(password), Boolean.parseBoolean(status)));
                    session.setAttribute("insert_success", "Thêm mới thành công!");
                } catch (SQLException ex) {
                    Logger.getLogger(AdminServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            url = "/admin/manager_admin.jsp";
            break;
            case "update": {
                try {
                    adminDAO.update(new Administrator(Integer.parseInt(admin_id), name, email, MD5.encryption(password), Boolean.parseBoolean(status)));
                    session.setAttribute("update_success", "Cập nhật thành công!");
                } catch (SQLException ex) {
                    Logger.getLogger(AdminServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            url = "/admin/manager_admin.jsp";
            break;
        }
        RequestDispatcher rd = getServletContext().getRequestDispatcher(url);
        rd.forward(request, response);
    }
}
