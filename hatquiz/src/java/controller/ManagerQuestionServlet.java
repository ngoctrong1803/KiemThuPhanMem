package controller;

import dao.QuestionDAO;
import java.io.IOException;
import java.sql.Timestamp;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Question;

public class ManagerQuestionServlet extends HttpServlet {
    
    QuestionDAO questionDAO = new QuestionDAO();
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
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
                    questionDAO.delete(Integer.parseInt(request.getParameter("question_id")));
                    session.setAttribute("remove_success", "Xóa thành công!");
                    url = "/admin/manager_question.jsp?pages=1";
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
        response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        String command = request.getParameter("command");
        String q_id = request.getParameter("question_id");
        String s_id = request.getParameter("subject");
        String qz_id = request.getParameter("quiz");
        String qcontent = request.getParameter("content");
        String q_a = request.getParameter("qa");
        String q_b = request.getParameter("qb");
        String q_c = request.getParameter("qc");
        String q_d = request.getParameter("qd");
        String q_true = request.getParameter("qtrue");
        String url = "";
        HttpSession session = request.getSession();
        try {
            switch (command) {
                case "insert":
                    questionDAO.insert(new Question(Integer.parseInt(s_id), Integer.parseInt(qz_id), qcontent, q_a, q_b, q_c, q_d, q_true, new Timestamp(System.currentTimeMillis())));
                    session.setAttribute("insert_success", "Thêm mới thành công!");
                    url = "/admin/manager_question.jsp?pages=1";
                    break;
                case "update":
                    questionDAO.update(new Question(Integer.parseInt(q_id), Integer.parseInt(s_id), Integer.parseInt(qz_id), qcontent, q_a, q_b, q_c, q_d, q_true, new Timestamp(System.currentTimeMillis())));
                    session.setAttribute("update_success", "Cập nhật thành công!");
                    url = "/admin/manager_question.jsp?pages=1";
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
