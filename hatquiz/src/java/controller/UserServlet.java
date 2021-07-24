package controller;

import dao.UserDAO;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.User;
import tools.MD5;

public class UserServlet extends HttpServlet {

    UserDAO usersDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        String userID = request.getParameter("user_id");
        String userName = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String command = request.getParameter("command");
        String url = "";
        User users = new User();
        HttpSession session = request.getSession();
        try {
            switch (command) {
                case "insert":
                    if (!usersDAO.checkEmail(email)) {
                        users.setFullName(userName);
                        users.setEmail(email);
                        users.setPassword(MD5.encryption(password));
                        users.setPhone(phone);
                        users.setAddress(address);
                        usersDAO.insert(users);
                        session.setAttribute("user", users);
                        url = "/login.jsp";
                    } else {
                        session.setAttribute("errorEmail", "Email này đã tồn tại!");
                        url = "/register.jsp";
                    }
                    break;
                case "login":
                    users = usersDAO.login(email, MD5.encryption(password));
                    if (users != null) {
                        session.setAttribute("user", users);
                        url = "/index.jsp";
                    } else {
                        session.setAttribute("error", "Email hoặc mật khẩu không đúng!");
                        url = "/login.jsp";
                    }
                    break;
                case "update":
                    usersDAO.updateUser(new User(Integer.parseInt(userID), userName, phone, address));
                    session.setAttribute("update_success", "Cập nhật thông tin thành công!");
                    url = "/infor.jsp";
                    break;
                case "reset":
                    String oldpass = request.getParameter("oldpass");
                    String newpass = request.getParameter("newpass");
                    if (usersDAO.checkPass(MD5.encryption(oldpass))) {
                        usersDAO.changePass(new User(Integer.parseInt(userID), MD5.encryption(newpass)));
                        session.setAttribute("message", "Cập nhật mật khẩu mới thành công!");
                        url = "/changepass.jsp";
                    } else {
                        session.setAttribute("message", "Mật khẩu cũ không đúng!");
                        url = "/changepass.jsp";
                    }
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();;
        }

        RequestDispatcher rd = getServletContext().getRequestDispatcher(url);
        rd.forward(request, response);
    }
}
