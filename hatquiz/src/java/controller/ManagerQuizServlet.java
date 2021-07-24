package controller;

import dao.QuizDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Quiz;

public class ManagerQuizServlet extends HttpServlet {

    QuizDAO quizDAO = new QuizDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ManagerQuizServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManagerQuizServlet at " + request.getContextPath() + "</h1>");
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
                    quizDAO.delete(Integer.parseInt(request.getParameter("quiz_id")));
                    session.setAttribute("remove_success", "Xóa thành công!");
                    url = "/admin/manager_quiz.jsp?pages=1";
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
        String qz_id = request.getParameter("quiz_id");
        String s_id = request.getParameter("subject");
        String qz_name = request.getParameter("name");
        String qz_time = request.getParameter("time");
        String qz_totalquestion = request.getParameter("totalquestion");
        String qz_image = request.getParameter("image");
        String url = "";
        HttpSession session = request.getSession();
        try {
            switch (command) {
                case "insert":
                    quizDAO.insert(new Quiz(Integer.parseInt(s_id), qz_name, Integer.parseInt(qz_time), Integer.parseInt(qz_totalquestion), qz_image, new Timestamp(System.currentTimeMillis())));
                    session.setAttribute("insert_success", "Thêm mới thành công!");
                    url = "/admin/manager_quiz.jsp?pages=1";
                    break;
                case "update":
                    quizDAO.update(new Quiz(Integer.parseInt(qz_id), Integer.parseInt(s_id), qz_name, Integer.parseInt(qz_time), Integer.parseInt(qz_totalquestion), qz_image, new Timestamp(System.currentTimeMillis())));
                    session.setAttribute("update_success", "Cập nhật thành công!");
                    url = "/admin/manager_quiz.jsp?pages=1";
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
