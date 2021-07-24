package controller;

import java.io.IOException;
import java.sql.Date;
import java.sql.Time;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.UserQuiz;

public class CheckQServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        String url = "";
        int userID = Integer.parseInt(request.getParameter("idofuser"));
        int subjectID = Integer.parseInt(request.getParameter("idofsubject"));
        int quizID = Integer.parseInt(request.getParameter("idofquiz"));
        int checkStart = Integer.parseInt(request.getParameter("start"));
        try {
            /*------------------------------------------------------------------*/
            switch (checkStart) {
                case 1:
                    if (userID == 0) {
                        url = "/login.jsp";
                    } else {
                        /*lưu các dữ liệu ban đầy như người làm đề nào thời gian bắt đầu vào session*/
                        UserQuiz userquiz = new UserQuiz();
                        userquiz.setUserID(userID);
                        userquiz.setQuizID(quizID);
                        Date date = new Date(System.currentTimeMillis());
                        Time time = new Time(System.currentTimeMillis());
                        userquiz.setStarttime(time);
                        userquiz.setStartday(date);
                        session.setAttribute("userquiz", userquiz);
                        url = "/doquiz.jsp?quiz_id=" + quizID + "&subject_id=" + subjectID + "&start=1";
                    }
                    break;
            }
            /*------------------------------------------------------------------*/
        } catch (Exception ex) {
        }

        RequestDispatcher rd = getServletContext().getRequestDispatcher(url);
        rd.forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
