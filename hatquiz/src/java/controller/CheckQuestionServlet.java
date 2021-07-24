package controller;

import com.google.gson.Gson;
import dao.QuestionDAO;
import dao.UserQuizDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.Time;
import java.text.DecimalFormat;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Question;
import model.UserQuiz;

public class CheckQuestionServlet extends HttpServlet {

    class answer {

        public String name;
        public String value;

        void setData(String name, String value) {
            this.name = name;
            this.value = value;
        }

        public answer(String name, String value) {
            this.name = name;
            this.value = value;
        }

        public answer() {
        }

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        public String getValue() {
            return value;
        }

        public void setValue(String value) {
            this.value = value;
        }

        @Override
        public String toString() {
            return "answer{" + "name=" + name + ", value=" + value + '}';
        }

    }

    public class Language {

        public Language(String name, String description) {
            this.name = name;
            this.description = description;
        }

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        public String getDescription() {
            return description;
        }

        public void setDescription(String description) {
            this.description = description;
        }

        public Language() {
        }

        @Override
        public String toString() {
            return "Language{" + "name=" + name + ", description=" + description + '}';
        }

        public String name;
        public String description;

    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CheckQuestionController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CheckQuestionController at " + request.getContextPath() + "</h1>");
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
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        int userID = Integer.parseInt(request.getParameter("idofuser"));
        int subjectID = Integer.parseInt(request.getParameter("idofsubject"));
        int quizID = Integer.parseInt(request.getParameter("idofquiz"));
        String myJsonData = request.getParameter("json");
        Gson gson = new Gson();
        answer[] answer = gson.fromJson(myJsonData, answer[].class);
        /*------------------------------------------------------------*/
        try {
            UserQuiz userquiz = (UserQuiz) session.getAttribute("userquiz");
            QuestionDAO qdao = new QuestionDAO();
            int sumCorrectAnswer = 0;
            int sumUnselectedQuestion = 0;
            float score = 0;
            int sumQuestions = qdao.getListQuestionByQuiz(quizID).size();
            for (int i = 0; i < answer.length; i++) {
                Question ques = qdao.getQuestionByID(Integer.parseInt(answer[i].name));
                if (answer[i].value.equals(ques.getqTrue().replaceAll("[\n\r]$", "").replaceAll("[\\s\r]$", ""))) {
                    sumCorrectAnswer++;
                }
            }
            double temp = ((double) sumCorrectAnswer / sumQuestions) * 10;
            DecimalFormat df = new DecimalFormat("#.00");
            score = Float.parseFloat(df.format(temp));
            /*lưu các dữ liệu như điểm thời gian kết thúc số câu đúng vào session*/
            userquiz.setScore(score);
            userquiz.setTotalanswertrue(sumCorrectAnswer);
            Date date = new Date(System.currentTimeMillis());
            Time time = new Time(System.currentTimeMillis());
            userquiz.setEndtime(time);
            userquiz.setEndday(date);
            /*kết thúc lưu trữ vào session*/
            /*hiển thị thời gian làm bài*/
            int startTime = 0;
            int endTime = 0;
            int totalTime = 0;
            startTime = userquiz.getStarttime().getHours() * 3600 + userquiz.getStarttime().getMinutes() * 60 + userquiz.getStarttime().getSeconds();
            endTime = userquiz.getEndtime().getHours() * 3600 + userquiz.getEndtime().getMinutes() * 60 + userquiz.getEndtime().getSeconds();
            totalTime = endTime - startTime;
            int hours = totalTime / (60 * 60);
            int minutes = (totalTime - hours * 60 * 60) / 60;
            int seconds = (totalTime - hours * 60 * 60 - minutes * 60);
            minutes = hours * 60 + minutes;
            /*lấy dự liệu từ session bắt đầu lưu dữ liệu xuống database*/
            UserQuizDAO uqDao = new UserQuizDAO();
            uqDao.insertUserQuiz(userquiz);

            /*kết thúc lưu dữ liệu*/
            String result = "{\"score\":\"" + score + "\",\"sumcorrectanswer\":\"" + sumCorrectAnswer + "\",\"sumquestions\":\"" + sumQuestions + "\",\"minutes\":\"" + minutes + "\",\"seconds\":\"" + seconds + "\"}";
            out.println(result);
        } catch (Exception e) {
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
