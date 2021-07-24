package controller;

import com.google.gson.Gson;
import dao.QuestionDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Question;

public class CheckUserAnswerServlet extends HttpServlet {

    class CheckUserAnswer {

        private String name;
        private String value;

        @Override
        public String toString() {
            return "CheckUserAnswer{" + "name=" + name + ", value=" + value + '}';
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

        public CheckUserAnswer(String name, String value) {
            this.name = name;
            this.value = value;
        }

        public CheckUserAnswer() {
        }

    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CheckUserAnswerController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CheckUserAnswerController at " + request.getContextPath() + "</h1>");
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
        /*------------------------------------------------------------*/
        CheckUserAnswer[] answer = gson.fromJson(myJsonData, CheckUserAnswer[].class);
        /*------------------------------------------------------------*/
        try {
            String imgcorrectanswer = "<img src=\"images/available.png\" /> <span class='text-success'>Chính xác</span>";
            String imgincorrectanswer = "<img src=\"images/not-available.png\" /> <span>Không chính xác</span>";
            String imgunchecked = "<img src=\"images/chamthan.png\" /> <span>Chưa làm</span>";
            QuestionDAO qdao = new QuestionDAO();
            int temp = 0;
            int sumQuestions = qdao.getListQuestionByQuiz(quizID).size();
            CheckUserAnswer cua[] = new CheckUserAnswer[sumQuestions];
            for (int i = 0; i < answer.length; i++)// check những câu hỏi đã chọn
            {
                Question ques = qdao.getQuestionByID(Integer.parseInt(answer[i].name));
                if (answer[i].value.equals(ques.getqTrue().replaceAll("[\n\r]$", "").replaceAll("[\\s\r]$", ""))) {
                    cua[i] = new CheckUserAnswer();
                    cua[i].setValue(imgcorrectanswer);
                    if (answer[i].value.equals(ques.getqA().replaceAll("[\n\r]$", "").replaceAll("[\\s\r]$", ""))) {
                        cua[i].setName("user_answer_" + ques.getQuestionID() + "1");
                    } else if (answer[i].value.equals(ques.getqB().replaceAll("[\n\r]$", "").replaceAll("[\\s\r]$", ""))) {
                        cua[i].setName("user_answer_" + ques.getQuestionID() + "2");
                    } else if (answer[i].value.equals(ques.getqC().replaceAll("[\n\r]$", "").replaceAll("[\\s\r]$", ""))) {
                        cua[i].setName("user_answer_" + ques.getQuestionID() + "3");
                    } else if (answer[i].value.equals(ques.getqD().replaceAll("[\n\r]$", "").replaceAll("[\\s\r]$", ""))) {
                        cua[i].setName("user_answer_" + ques.getQuestionID() + "4");
                    }

                } else {
                    cua[i] = new CheckUserAnswer();
                    cua[i].setValue(imgincorrectanswer);
                    if (answer[i].value.equals(ques.getqA().replaceAll("[\n\r]$", "").replaceAll("[\\s\r]$", ""))) {
                        cua[i].setName("user_answer_" + ques.getQuestionID() + "1");
                    } else if (answer[i].value.equals(ques.getqB().replaceAll("[\n\r]$", "").replaceAll("[\\s\r]$", ""))) {
                        cua[i].setName("user_answer_" + ques.getQuestionID() + "2");
                    } else if (answer[i].value.equals(ques.getqC().replaceAll("[\n\r]$", "").replaceAll("[\\s\r]$", ""))) {
                        cua[i].setName("user_answer_" + ques.getQuestionID() + "3");
                    } else if (answer[i].value.equals(ques.getqD().replaceAll("[\n\r]$", "").replaceAll("[\\s\r]$", ""))) {
                        cua[i].setName("user_answer_" + ques.getQuestionID() + "4");
                    }

                }
            }

            int sumUnchecked = 0;
            int check = 0;
            int checkArray[] = new int[sumQuestions];
            for (Question uq : qdao.getListQuestionByQuiz(quizID))// đưa ra các câu hỏi chưa chọn
            {
                for (int i = 0; i < answer.length; i++) {
                    if (Integer.parseInt(answer[i].name) == uq.getQuestionID())// tồn tại mã câu hỏi trong đáp án người dùng
                    {
                        check = 1;
                    }
                }
                if (check == 0) {
                    checkArray[sumUnchecked] = uq.getQuestionID();
                    sumUnchecked++;
                }
                check = 0;
            }
            for (int i = 0; i < sumUnchecked; i++) {
                int index = cua.length - sumUnchecked + i;
                cua[index] = new CheckUserAnswer();
                cua[index].setName("uncheck_" + (String.valueOf(checkArray[i])));
                cua[index].setValue(imgunchecked);

            }
            request.setAttribute("imgcorrectanswer", imgcorrectanswer);
            request.setAttribute("imgincorrectanswer", imgincorrectanswer);
            request.setAttribute("imgunchecked", imgunchecked);
            String json = gson.toJson(cua);
            out.println(json);

        } catch (Exception e) {
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
