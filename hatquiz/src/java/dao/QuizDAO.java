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
import model.Quiz;

public class QuizDAO {

    // get danh sách đề thi có  phân trang
    public ArrayList<Quiz> getListQuiz(int firstResult, int maxResult) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "Select a.QuizID, a.SubjectID, b.SubjectName, a.QuizName, a.Time, a.TotalQuestion, a.Image, a.CreateDate "
                + "from quiz a, subject b where a.SubjectID = b.SubjectID order by a.QuizID desc limit ?,?";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setInt(1, firstResult);
        ps.setInt(2, maxResult);
        ResultSet rs = ps.executeQuery();
        ArrayList<Quiz> list = new ArrayList<>();
        while (rs.next()) {
            Quiz quiz = new Quiz();
            quiz.setQuizID(rs.getInt("QuizID"));
            quiz.setSubjectID(rs.getInt("SubjectID"));
            quiz.setSubjectName(rs.getString("SubjectName"));
            quiz.setQuizName(rs.getString("QuizName"));
            quiz.setTime(rs.getInt("Time"));
            quiz.setTotalQuestion(rs.getInt("TotalQuestion"));
            quiz.setImage(rs.getString("Image"));
            quiz.setCreatedate(rs.getTimestamp("CreateDate"));
            list.add(quiz);
        }
        return list;
    }

    // get 4 đề thi liên quan nhưng mới nhất
    public ArrayList<Quiz> getListQuizRelate(int subjectID) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "Select a.QuizID, a.SubjectID, b.SubjectName, a.QuizName, a.Time, a.TotalQuestion, a.Image, a.CreateDate "
                + "from quiz a, subject b where a.SubjectID = b.SubjectID and a.SubjectID ='" + subjectID + "' order by a.CreateDate desc";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ArrayList<Quiz> list = new ArrayList<>();
        while (rs.next()) {
            Quiz quiz = new Quiz();
            quiz.setQuizID(rs.getInt("QuizID"));
            quiz.setSubjectID(rs.getInt("SubjectID"));
            quiz.setSubjectName(rs.getString("SubjectName"));
            quiz.setQuizName(rs.getString("QuizName"));
            quiz.setTime(rs.getInt("Time"));
            quiz.setTotalQuestion(rs.getInt("TotalQuestion"));
            quiz.setImage(rs.getString("Image"));
            quiz.setCreatedate(rs.getTimestamp("CreateDate"));
            list.add(quiz);
        }
        return list;
    }

    // get 4 đề thi mới nhất
    public ArrayList<Quiz> getListQuizLatest() throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "Select a.QuizID, a.SubjectID, b.SubjectName, a.QuizName, a.Time, a.TotalQuestion, a.Image, a.CreateDate "
                + "from quiz a, subject b where a.SubjectID = b.SubjectID order by a.CreateDate desc limit 4";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ArrayList<Quiz> list = new ArrayList<>();
        while (rs.next()) {
            Quiz quiz = new Quiz();
            quiz.setQuizID(rs.getInt("QuizID"));
            quiz.setSubjectID(rs.getInt("SubjectID"));
            quiz.setSubjectName(rs.getString("SubjectName"));
            quiz.setQuizName(rs.getString("QuizName"));
            quiz.setTime(rs.getInt("Time"));
            quiz.setTotalQuestion(rs.getInt("TotalQuestion"));
            quiz.setImage(rs.getString("Image"));
            quiz.setCreatedate(rs.getTimestamp("CreateDate"));
            list.add(quiz);
        }
        return list;
    }

    // get danh sách đề thi 
    public ArrayList<Quiz> getListQuiz() throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT * FROM quiz order by QuizID asc";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ArrayList<Quiz> list = new ArrayList<>();
        while (rs.next()) {
            Quiz q = new Quiz();
            q.setQuizID(rs.getInt("QuizID"));
            q.setSubjectID(rs.getInt("SubjectID"));
            q.setQuizName(rs.getString("QuizName"));
            q.setTime(rs.getInt("Time"));
            q.setTotalQuestion(rs.getInt("TotalQuestion"));
            q.setImage(rs.getString("Image"));
            q.setCreatedate(rs.getTimestamp("CreateDate"));
            list.add(q);
        }
        return list;
    }

    public Quiz getQuizByQuizID(int quizID) throws Exception {
        Quiz qz = null;
        Connection connection = DBConnect.getConnecttion();
        String sql = "Select a.QuizID, a.SubjectID, b.SubjectName, a.QuizName, a.Time, a.TotalQuestion, a.Image, a.CreateDate "
                + "from quiz a, subject b where a.SubjectID = b.SubjectID and a.QuizID=?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, quizID);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            int qid = rs.getInt("QuizID");
            int sid = rs.getInt("SubjectID");
            String subjectName = rs.getString("SubjectName");
            String name = rs.getString("QuizName");
            int time = rs.getInt("Time");
            int totalq = rs.getInt("TotalQuestion");
            String image = rs.getString("Image");
            Timestamp createdate = rs.getTimestamp("CreateDate");
            qz = new Quiz(qid, sid, subjectName, name, time, totalq, image, createdate);
        }
        return qz;
    }

    public Quiz getQuizBySubjectID(int subjectID) throws Exception {
        Quiz qz = null;
        Connection connection = DBConnect.getConnecttion();
        String sql = "select QuizID, a.SubjectID, SubjectName, QuizName, Time, TotalQuestion, Image, a.CreateDate from quiz a, subject b "
                + "where a.SubjectID = b.SubjectID and a.SubjectID=?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, subjectID);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            int qid = rs.getInt("QuizID");
            int sid = rs.getInt("SubjectID");
            String sname = rs.getString("SubjectName");
            String qname = rs.getString("QuizName");
            int time = rs.getInt("Time");
            int totalq = rs.getInt("TotalQuestion");
            String image = rs.getString("Image");
            Timestamp createdate = rs.getTimestamp("CreateDate");
            qz = new Quiz(qid, sid, sname, qname, time, totalq, image, createdate);
        }
        return qz;
    }

    //Them moi
    public boolean insert(Quiz qz) throws SQLException {
        try {
            Connection connection = DBConnect.getConnecttion();
            String sql = "INSERT INTO quiz VALUE(?,?,?,?,?,?,?)";
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setInt(1, qz.getQuizID());
            ps.setInt(2, qz.getSubjectID());
            ps.setString(3, qz.getQuizName());
            ps.setInt(4, qz.getTime());
            ps.setInt(5, qz.getTotalQuestion());
            ps.setString(6, qz.getImage());
            ps.setTimestamp(7, new Timestamp(System.currentTimeMillis()));
            int temp = ps.executeUpdate();
            return temp == 1;
        } catch (SQLException ex) {
            Logger.getLogger(QuizDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    //cap nhat
    public boolean update(Quiz qz) throws SQLException {
        try {
            Connection connection = DBConnect.getConnecttion();
            String sql = "update quiz set QuizName = ?, SubjectID = ?, Time = ?, TotalQuestion = ?, Image = ?, CreateDate = ? WHERE QuizID = ?";
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, qz.getQuizName());
            ps.setInt(2, qz.getSubjectID());
            ps.setInt(3, qz.getTime());
            ps.setInt(4, qz.getTotalQuestion());
            ps.setString(5, qz.getImage());
            ps.setTimestamp(6, qz.getCreatedate());
            ps.setInt(7, qz.getQuizID());
            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            Logger.getLogger(QuizDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    //xoa
    public boolean delete(int quiz_id) throws SQLException {
        Connection con = DBConnect.getConnecttion();
        String sql = "DELETE FROM quiz WHERE QuizID = ?";
        try {
            PreparedStatement ps = con.prepareCall(sql);
            ps.setInt(1, quiz_id);
            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            Logger.getLogger(QuizDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    //get list quiz by subject
    public ArrayList<Quiz> getListQuizBySubject(int subjectID, int a, int b) {
        Connection conn = DBConnect.getConnecttion();
        ArrayList<Quiz> list = new ArrayList();
        String sql = "Select a.QuizID, a.SubjectID, b.SubjectName, a.QuizName, a.Time, a.TotalQuestion, a.Image, a.CreateDate "
                + "from quiz a, subject b "
                + "where a.SubjectID = b.SubjectID and a.SubjectID ='" + subjectID + "' order by a.QuizID desc limit ?,?";
        try {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, a);
            stmt.setInt(2, b);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Quiz q = new Quiz();
                q.setQuizID(rs.getInt("QuizID"));
                q.setSubjectID(rs.getInt("SubjectID"));
                q.setSubjectName(rs.getString("SubjectName"));
                q.setQuizName(rs.getString("QuizName"));
                q.setTime(rs.getInt("Time"));
                q.setTotalQuestion(rs.getInt("TotalQuestion"));
                q.setImage(rs.getString("Image"));
                q.setCreatedate(rs.getTimestamp("CreateDate"));
                list.add(q);
            }
            return list;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    //search
    public ArrayList<Quiz> search(String search) {
        Connection conn = DBConnect.getConnecttion();
        ArrayList<Quiz> list = new ArrayList();
        String sql = "SELECT * FROM quiz WHERE QuizName like ?";
        try {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, "%" + search + "%");
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Quiz q = new Quiz();
                q.setQuizID(rs.getInt("QuizID"));
                q.setSubjectID(rs.getInt("SubjectID"));
                q.setQuizName(rs.getString("QuizName"));
                q.setTime(rs.getInt("Time"));
                q.setTotalQuestion(rs.getInt("TotalQuestion"));
                q.setImage(rs.getString("Image"));
                q.setCreatedate(rs.getTimestamp("CreateDate"));
                list.add(q);
            }
            return list;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    //Total quiz number by subject
    public int getCountQuizBySubject(int subjectID) {
        Connection conn = DBConnect.getConnecttion();
        ArrayList<Quiz> list = new ArrayList();
        String sql = "SELECT count(QuizID) FROM quiz "
                + "WHERE SubjectID = '" + subjectID + "'";
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

    //Total quiz number
    public int getCountQuiz() {
        Connection conn = DBConnect.getConnecttion();
        ArrayList<Quiz> list = new ArrayList();
        String sql = "SELECT count(QuizID) FROM quiz";
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
    
    //Total quiz number
    public int getCountQuizExams(int quizID) {
        Connection conn = DBConnect.getConnecttion();
        ArrayList<Quiz> list = new ArrayList();
        String sql = "SELECT count(b.QuizID) FROM quiz a, userquiz b WHERE a.QuizID = b.QuizID and b.QuizID = '" + quizID + "'";
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

    public static void main(String[] args) throws SQLException, Exception {
        QuizDAO s = new QuizDAO();
        System.out.println(s.getCountQuizExams(40));
    }
}
