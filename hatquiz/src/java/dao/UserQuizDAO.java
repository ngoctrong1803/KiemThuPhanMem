package dao;

import connect.DBConnect;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.UserQuiz;
import java.util.ArrayList;

public class UserQuizDAO {

    // get danh sách userquiz
    public ArrayList<UserQuiz> getListUserQuiz(int a, int b) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT a.UserQuizID, b.FullName, c.QuizName, a.Score, a.AnwserTrue, c.TotalQuestion, a.StartTime, "
                + "a.EndTime, a.StartDay, a.EndDay FROM userquiz a, user b, quiz c "
                + "where a.UserID = b.UserID and a.QuizID = c.QuizID order by a.UserQuizID asc limit ?,?";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setInt(1, a);
        ps.setInt(2, b);
        ResultSet rs = ps.executeQuery();
        ArrayList<UserQuiz> list = new ArrayList<>();
        while (rs.next()) {
            UserQuiz uq = new UserQuiz();
            uq.setUserquizID(rs.getInt("UserQuizID"));
            uq.setUsername(rs.getString("FullName"));
            uq.setQuizname(rs.getString("QuizName"));
            uq.setScore(rs.getFloat("Score"));
            uq.setTotalanswertrue(rs.getInt("AnwserTrue"));
            uq.setTotalquestion(rs.getInt("TotalQuestion"));
            uq.setStarttime(rs.getTime("StartTime"));
            uq.setEndtime(rs.getTime("EndTime"));
            uq.setStartday(rs.getDate("StartDay"));
            uq.setEndday(rs.getDate("EndDay"));
            list.add(uq);
        }
        return list;
    }

    // lịch sử thi của user
    public ArrayList<UserQuiz> getListUserQuizHistory(int userID) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT * FROM userquiz a, user b, quiz c, subject d "
                + "where a.UserID = b.UserID and a.QuizID = c.QuizID "
                + "and c.SubjectID = d.SubjectID and a.UserID = ? order by a.UserQuizID asc";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setInt(1, userID);
        ResultSet rs = ps.executeQuery();
        ArrayList<UserQuiz> list = new ArrayList<>();
        while (rs.next()) {
            UserQuiz uq = new UserQuiz();
            uq.setUserquizID(rs.getInt("UserQuizID"));
            uq.setUsername(rs.getString("FullName"));
            uq.setQuizID(rs.getInt("QuizID"));
            uq.setQuizname(rs.getString("QuizName"));
            uq.setScore(rs.getFloat("Score"));
            uq.setTotalanswertrue(rs.getInt("AnwserTrue"));
            uq.setTotalquestion(rs.getInt("TotalQuestion"));
            uq.setStarttime(rs.getTime("StartTime"));
            uq.setEndtime(rs.getTime("EndTime"));
            uq.setStartday(rs.getDate("StartDay"));
            uq.setEndday(rs.getDate("EndDay"));
            uq.setSubjectID(rs.getInt("SubjectID"));
            uq.setSubjectName(rs.getString("SubjectName"));
            uq.setTime(rs.getInt("Time"));
            list.add(uq);
        }
        return list;
    }

    public ArrayList<UserQuiz> getListUserQuiz() throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT a.UserQuizID, b.FullName, c.QuizName, a.Score, a.AnwserTrue, c.TotalQuestion, a.StartTime, "
                + "a.EndTime, a.StartDay, a.EndDay FROM userquiz a, user b, quiz c "
                + "where a.UserID = b.UserID and a.QuizID = c.QuizID";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ArrayList<UserQuiz> list = new ArrayList<>();
        while (rs.next()) {
            UserQuiz uq = new UserQuiz();
            uq.setUserquizID(rs.getInt("UserQuizID"));
            uq.setUsername(rs.getString("FullName"));
            uq.setQuizname(rs.getString("QuizName"));
            uq.setScore(rs.getFloat("Score"));
            uq.setTotalanswertrue(rs.getInt("AnwserTrue"));
            uq.setTotalquestion(rs.getInt("TotalQuestion"));
            uq.setStarttime(rs.getTime("StartTime"));
            uq.setEndtime(rs.getTime("EndTime"));
            uq.setStartday(rs.getDate("StartDay"));
            uq.setEndday(rs.getDate("EndDay"));
            list.add(uq);
        }
        return list;
    }

    public boolean insertUserQuiz(UserQuiz uq) {
        Connection connection = DBConnect.getConnecttion();
        String sql = "INSERT INTO userquiz VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?);";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setInt(1, uq.getUserquizID());
            ps.setInt(2, uq.getUserID());
            ps.setInt(3, uq.getQuizID());
            ps.setFloat(4, uq.getScore());
            ps.setFloat(5, uq.getTotalanswertrue());
            ps.setTime(6, uq.getStarttime());
            ps.setTime(7, uq.getEndtime());
            ps.setDate(8, uq.getStartday());
            ps.setDate(9, uq.getEndday());
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(UserQuizDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    //xoa
    public boolean delete(int userquiz_id) throws SQLException {
        Connection con = DBConnect.getConnecttion();
        String sql = "DELETE FROM userquiz WHERE UserQuizID = ?";
        try {
            PreparedStatement ps = con.prepareCall(sql);
            ps.setInt(1, userquiz_id);
            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            Logger.getLogger(UserQuizDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public int getCount() {
        Connection conn = DBConnect.getConnecttion();
        ArrayList<UserQuiz> list = new ArrayList();
        String sql = "SELECT count(UserQuizID) FROM userquiz";
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

    // search
    public ArrayList<UserQuiz> search(String search) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT a.UserQuizID, b.FullName, c.QuizName, a.Score, a.AnwserTrue, c.TotalQuestion, a.StartTime, "
                + "a.EndTime, a.StartDay, a.EndDay FROM userquiz a, user b, quiz c "
                + "where a.UserID = b.UserID and a.QuizID = c.QuizID and (b.FullName like ? or c.QuizName like ?)";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setString(1, "%" + search + "%");
        ps.setString(2, "%" + search + "%");
        ResultSet rs = ps.executeQuery();
        ArrayList<UserQuiz> list = new ArrayList<>();
        while (rs.next()) {
            UserQuiz uq = new UserQuiz();
            uq.setUserquizID(rs.getInt("UserQuizID"));
            uq.setUsername(rs.getString("FullName"));
            uq.setQuizname(rs.getString("QuizName"));
            uq.setScore(rs.getFloat("Score"));
            uq.setTotalanswertrue(rs.getInt("AnwserTrue"));
            uq.setTotalquestion(rs.getInt("TotalQuestion"));
            uq.setStarttime(rs.getTime("StartTime"));
            uq.setEndtime(rs.getTime("EndTime"));
            uq.setStartday(rs.getDate("StartDay"));
            uq.setEndday(rs.getDate("EndDay"));
            list.add(uq);
        }
        return list;
    }

    //bang xep hang top 10
    public ArrayList<UserQuiz> getListUserQuizCharts(int quizID) {
        Connection conn = DBConnect.getConnecttion();
        ArrayList<UserQuiz> list = new ArrayList();
        String sql = "select * from userquiz x, "
                + "(SELECT c.UserID, c.FullName, max(b.Score) as maxScore FROM userquiz b, user c "
                + "WHERE b.UserID = c.UserID and b.QuizID = ? GROUP BY c.FullName) as y "
                + "where x.UserID = y.UserID and x.Score = y.maxScore "
                + "group by FullName "
                + "order by x.Score desc limit 10";
        try {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, quizID);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                UserQuiz uq = new UserQuiz();
                uq.setUserquizID(rs.getInt("UserQuizID"));
                uq.setUsername(rs.getString("FullName"));
                uq.setScore(rs.getFloat("Score"));
                uq.setTotalanswertrue(rs.getInt("AnwserTrue"));
                uq.setStarttime(rs.getTime("StartTime"));
                uq.setEndtime(rs.getTime("EndTime"));
                uq.setStartday(rs.getDate("StartDay"));
                uq.setEndday(rs.getDate("EndDay"));
                list.add(uq);
            }
            return list;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static void main(String[] args) throws SQLException, Exception {
        UserQuizDAO s = new UserQuizDAO();
        System.out.println(s.getListUserQuizCharts(15));
    }
}
