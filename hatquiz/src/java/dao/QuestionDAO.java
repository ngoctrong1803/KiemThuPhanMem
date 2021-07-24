package dao;

import connect.DBConnect;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Question;

public class QuestionDAO {

    // get danh sách câu hỏi có phân trang
    public ArrayList<Question> getListQuestion(int firstResult, int maxResult) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT * FROM question order by QuestionID asc limit ?,?";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setInt(1, firstResult);
        ps.setInt(2, maxResult);
        ResultSet rs = ps.executeQuery();
        ArrayList<Question> list = new ArrayList<>();
        while (rs.next()) {
            Question q = new Question();
            q.setQuestionID(rs.getInt("QuestionID"));
            q.setSubjectID(rs.getInt("SubjectID"));
            q.setQuizID(rs.getInt("QuizID"));
            q.setContent(rs.getString("Content"));
            q.setqA(rs.getString("Q_A"));
            q.setqB(rs.getString("Q_B"));
            q.setqC(rs.getString("Q_C"));
            q.setqD(rs.getString("Q_D"));
            q.setqTrue(rs.getString("Q_True"));
            q.setCreatedate(rs.getTimestamp("CreateDate"));
            list.add(q);
        }
        return list;
    }

    // get danh sách câu hỏi theo môn học
    public ArrayList<Question> getListQuestionBySubject(int subjectID, int firstResult, int maxResult) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT * FROM question WHERE SubjectID = '" + subjectID + "' limit ?,?";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setInt(1, firstResult);
        ps.setInt(2, maxResult);
        ResultSet rs = ps.executeQuery();
        ArrayList<Question> list = new ArrayList<>();
        while (rs.next()) {
            Question q = new Question();
            q.setQuestionID(rs.getInt("QuestionID"));
            q.setSubjectID(rs.getInt("SubjectID"));
            q.setQuizID(rs.getInt("QuizID"));
            q.setContent(rs.getString("Content"));
            q.setqA(rs.getString("Q_A"));
            q.setqB(rs.getString("Q_B"));
            q.setqC(rs.getString("Q_C"));
            q.setqD(rs.getString("Q_D"));
            q.setqTrue(rs.getString("Q_True"));
            q.setCreatedate(rs.getTimestamp("CreateDate"));
            list.add(q);
        }
        return list;
    }

    // get danh sách câu hỏi theo đề thi
    public ArrayList<Question> getListQuestionByQuiz(int quiz_id, int firstResult, int maxResult) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT * FROM question WHERE QuizID ='" + quiz_id + "' limit ?,?";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setInt(1, firstResult);
        ps.setInt(2, maxResult);
        ResultSet rs = ps.executeQuery();
        ArrayList<Question> list = new ArrayList<>();
        while (rs.next()) {
            Question q = new Question();
            q.setQuestionID(rs.getInt("QuestionID"));
            q.setSubjectID(rs.getInt("SubjectID"));
            q.setQuizID(rs.getInt("QuizID"));
            q.setContent(rs.getString("Content"));
            q.setqA(rs.getString("Q_A"));
            q.setqB(rs.getString("Q_B"));
            q.setqC(rs.getString("Q_C"));
            q.setqD(rs.getString("Q_D"));
            q.setqTrue(rs.getString("Q_True"));
            q.setCreatedate(rs.getTimestamp("CreateDate"));
            list.add(q);
        }
        return list;
    }

    public ArrayList<Question> getListQuestionByQuiz(int quiz_id) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT * FROM question WHERE QuizID ='" + quiz_id + "' ORDER BY RAND()";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ArrayList<Question> list = new ArrayList<>();
        while (rs.next()) {
            Question q = new Question();
            q.setQuestionID(rs.getInt("QuestionID"));
            q.setSubjectID(rs.getInt("SubjectID"));
            q.setQuizID(rs.getInt("QuizID"));
            q.setContent(rs.getString("Content"));
            q.setqA(rs.getString("Q_A"));
            q.setqB(rs.getString("Q_B"));
            q.setqC(rs.getString("Q_C"));
            q.setqD(rs.getString("Q_D"));
            q.setqTrue(rs.getString("Q_True"));
            q.setCreatedate(rs.getTimestamp("CreateDate"));
            list.add(q);
        }
        return list;
    }

    // search
    public ArrayList<Question> search(String search) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT * FROM question WHERE Content like ?";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setString(1, "%" + search + "%");
        ResultSet rs = ps.executeQuery();
        ArrayList<Question> list = new ArrayList<>();
        while (rs.next()) {
            Question q = new Question();
            q.setQuestionID(rs.getInt("QuestionID"));
            q.setSubjectID(rs.getInt("SubjectID"));
            q.setQuizID(rs.getInt("QuizID"));
            q.setContent(rs.getString("Content"));
            q.setqA(rs.getString("Q_A"));
            q.setqB(rs.getString("Q_B"));
            q.setqC(rs.getString("Q_C"));
            q.setqD(rs.getString("Q_D"));
            q.setqTrue(rs.getString("Q_True"));
            q.setCreatedate(rs.getTimestamp("CreateDate"));
            list.add(q);
        }
        return list;
    }

    public Question getQuestionByID(int id) throws Exception {
        Question q = null;
        Connection connection = DBConnect.getConnecttion();
        String sql = "select * from question where QuestionID=?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            int qid = rs.getInt("QuestionID");
            int sid = rs.getInt("SubjectID");
            int qzid = rs.getInt("QuizID");
            String content = rs.getString("Content");
            String qa = rs.getString("Q_A");
            String qb = rs.getString("Q_B");
            String qc = rs.getString("Q_C");
            String qd = rs.getString("Q_D");
            String qtrue = rs.getString("Q_True");
            Timestamp createdate = rs.getTimestamp("CreateDate");
            q = new Question(qid, sid, qzid, content, qa, qb, qc, qd, qtrue, createdate);
        }
        return q;
    }

    //Them moi
    public boolean insert(Question q) throws SQLException {
        try {
            Connection connection = DBConnect.getConnecttion();
            String sql = "INSERT INTO question VALUE(?,?,?,?,?,?,?,?,?,?)";
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setInt(1, q.getQuestionID());
            ps.setInt(2, q.getSubjectID());
            ps.setInt(3, q.getQuizID());
            ps.setString(4, q.getContent());
            ps.setString(5, q.getqA());
            ps.setString(6, q.getqB());
            ps.setString(7, q.getqC());
            ps.setString(8, q.getqD());
            ps.setString(9, q.getqTrue());
            ps.setTimestamp(10, new Timestamp(System.currentTimeMillis()));
            int temp = ps.executeUpdate();
            return temp == 1;
        } catch (SQLException ex) {
            Logger.getLogger(QuestionDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    //cap nhat
    public boolean update(Question q) throws SQLException {
        try {
            Connection connection = DBConnect.getConnecttion();
            String sql = "update question set SubjectID=?,QuizID=?,Content=?,Q_A=?,Q_B=?,Q_C=?,Q_D=?,Q_True=?,CreateDate=? WHERE QuestionID = ?";
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setInt(1, q.getSubjectID());
            ps.setInt(2, q.getQuizID());
            ps.setString(3, q.getContent());
            ps.setString(4, q.getqA());
            ps.setString(5, q.getqB());
            ps.setString(6, q.getqC());
            ps.setString(7, q.getqD());
            ps.setString(8, q.getqTrue());
            ps.setTimestamp(9, new Timestamp(System.currentTimeMillis()));
            ps.setInt(10, q.getQuestionID());
            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            Logger.getLogger(QuestionDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    //xoa
    public boolean delete(int question_id) throws SQLException {
        Connection con = DBConnect.getConnecttion();
        String sql = "DELETE FROM question WHERE QuestionID = ?";
        try {
            PreparedStatement ps = con.prepareCall(sql);
            ps.setInt(1, question_id);
            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            Logger.getLogger(QuestionDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    //Total question number
    public int getCountQuestion() {
        Connection conn = DBConnect.getConnecttion();
        ArrayList<Question> list = new ArrayList();
        String sql = "SELECT count(QuestionID) FROM question";
        int count = 0;
        try {
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    //Total question number by subject
    public int getCountQuestionBySubject(int subjectID) {
        Connection conn = DBConnect.getConnecttion();
        ArrayList<Question> list = new ArrayList();
        String sql = "SELECT count(QuestionID) FROM question WHERE SubjectID = '" + subjectID + "'";
        int count = 0;
        try {
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    //Total question number by quiz
    public int getCountQuestionByQuiz(int quizID) {
        Connection conn = DBConnect.getConnecttion();
        ArrayList<Question> list = new ArrayList();
        String sql = "SELECT count(QuestionID) FROM question WHERE QuizID = '" + quizID + "'";
        int count = 0;
        try {
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

}
