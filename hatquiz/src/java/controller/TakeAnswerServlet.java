package controller;

import com.google.gson.Gson;
import dao.QuestionDAO;
import dao.TakeAnswerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.Time;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Question;
import model.UserQuiz;
import model.TakeAnswer;

public class TakeAnswerServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet TakeAnswerController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet TakeAnswerController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/plain");
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        int userID = Integer.parseInt(request.getParameter("idofuser"));
        int subjectID = Integer.parseInt(request.getParameter("idofsubject"));
        int quizID = Integer.parseInt(request.getParameter("idofquiz"));
        String myJsonData = request.getParameter("json");
        Gson gson = new Gson();
        CheckQuestionServlet.answer[] answer = gson.fromJson(myJsonData, CheckQuestionServlet.answer[].class);
        /*------------------------------------------------------------*/
        try {
            UserQuiz userquiz = (UserQuiz) session.getAttribute("userquiz");
            TakeAnswer ta = new TakeAnswer();
            ta.setUserID(userID);
            ta.setQuizID(quizID);
            ta.setStartday(userquiz.getStartday());
            ta.setStarttime(userquiz.getStarttime());
            QuestionDAO qdao = new QuestionDAO();
            TakeAnswerDAO tdao = new TakeAnswerDAO();
            Date date = new Date(System.currentTimeMillis());
            Time time = new Time(System.currentTimeMillis());
            for (int i = 0; i < answer.length; i++) {
                Question ques = new Question();
                ques = qdao.getQuestionByID(Integer.parseInt(answer[i].name));
                ta.setQuestionID(ques.getQuestionID());
                ta.setAnswer(answer[i].value);
                ta.setEndtime(time);
                ta.setEndday(date);
                if (tdao.CheckExistTakeAnswer(ta)) {
                    tdao.updateTakeAnswer(ta);
                } else if (tdao.CheckExistTakeAnswer(ta) == false) {
                    tdao.insertTakeAnswer(ta);
                }
            }
            String result = "{\"savetest\":\"Lưu bài(" + time + ")\"}";
            out.println(result);
        } catch (Exception e) {
        }

    }
    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
