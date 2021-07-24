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

public class LoadCorrectAnswerServlet extends HttpServlet {

    class loadanswer {

        public loadanswer() {
        }

        public loadanswer(String id, String result) {
            this.id = id;
            this.result = result;
        }

        public String getId() {
            return id;
        }

        public void setId(String id) {
            this.id = id;
        }

        public String getResult() {
            return result;
        }

        public void setResult(String result) {
            this.result = result;
        }

        @Override
        public String toString() {
            return "loadanswer{" + "id=" + id + ", result=" + result + '}';
        }
        private String id;
        private String result;

    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet LoadCorrectAnswerController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoadCorrectAnswerController at " + request.getContextPath() + "</h1>");
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
        // cái này để xử lý kiểm tra đáp án người dùng làm đúng hay sai từ rồi tính
        CheckQuestionServlet.answer[] answer = gson.fromJson(myJsonData, CheckQuestionServlet.answer[].class);
        /*------------------------------------------------------------*/
        try {
            String imgcorrectanswer = "<img src=\"images/available.png\" style=\"width: 20px; transform: translateY(-1px); margin-left: 4px;\" />";
            QuestionDAO qdao = new QuestionDAO();
            int temp = 0;
            int sumQuestions = qdao.getListQuestionByQuiz(quizID).size();
            loadanswer[] loadanswer = new loadanswer[sumQuestions];
            for (Question ques : qdao.getListQuestionByQuiz(quizID)) {
                loadanswer[temp] = new loadanswer();
                loadanswer[temp].setResult(imgcorrectanswer);// đưa cái ảnh tick vào
                if (ques.getqA().equals(ques.getqTrue())) {
                    loadanswer[temp].setId("answer_result_" + ques.getQuestionID() + "1");
                } else if (ques.getqB().equals(ques.getqTrue())) {
                    loadanswer[temp].setId("answer_result_" + ques.getQuestionID() + "2");
                } else if (ques.getqC().equals(ques.getqTrue())) {
                    loadanswer[temp].setId("answer_result_" + ques.getQuestionID() + "3");
                } else if (ques.getqD().equals(ques.getqTrue())) {
                    loadanswer[temp].setId("answer_result_" + ques.getQuestionID() + "4");
                }
                temp++;
            }

            String json = gson.toJson(loadanswer);
            String result = json;
            out.println(result);
        } catch (Exception e) {
        }
        /*--------------------------------------------------------------*/

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
