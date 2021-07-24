package dao;

import connect.DBConnect;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.TakeAnswer;

public class TakeAnswerDAO {

    public boolean CheckExistTakeAnswer(TakeAnswer ta) {
        Connection connection = DBConnect.getConnecttion();
        String sql = "select * from takeanswer where UserID = " + ta.getUserID() + " and QuizID =" + ta.getQuizID() + " "
                + "and startday = '" + ta.getStartday() + "' and starttime='" + ta.getStarttime() + "' "
                + "and QuestionID=" + ta.getQuestionID() + "";
        PreparedStatement ps;
        try {
            ps = connection.prepareCall(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                connection.close();
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(TakeAnswerDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public boolean insertTakeAnswer(TakeAnswer ta) {
        Connection connection = DBConnect.getConnecttion();
        String sql = "INSERT INTO takeanswer VALUES (?, ?, ?, ?, ?, ?, ?, ?);";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setInt(1, ta.getUserID());
            ps.setInt(2, ta.getQuizID());
            ps.setDate(3, ta.getStartday());
            ps.setTime(4, ta.getStarttime());
            ps.setDate(5, ta.getEndday());
            ps.setTime(6, ta.getEndtime());
            ps.setInt(7, ta.getQuestionID());
            ps.setString(8, ta.getAnswer());
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(TakeAnswerDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public boolean updateTakeAnswer(TakeAnswer ta) throws SQLException {
        try {
            Connection connection = DBConnect.getConnecttion();
            String sql = "update takeanswer set EndDay=?, EndTime=?, Answer=? WHERE UserID=? and QuizID=? and StartDay=? "
                    + "and StartTime=? and QuestionID=?";
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setDate(1, ta.getEndday());
            ps.setTime(2, ta.getEndtime());
            ps.setString(3, ta.getAnswer());
            ps.setInt(4, ta.getUserID());
            ps.setInt(5, ta.getQuizID());
            ps.setDate(6, ta.getStartday());
            ps.setTime(7, ta.getStarttime());
            ps.setInt(8, ta.getQuestionID());
            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            Logger.getLogger(TakeAnswerDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public ArrayList<TakeAnswer> getListTakeAnswer(int userID, int quizID, Date startDay, Time startTime) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "select * from takeanswer where UserID = " + userID + " and QuizID =" + quizID + " "
                + "and startday = '" + startDay + "' and starttime='" + startTime + "'";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ArrayList<TakeAnswer> list = new ArrayList<>();
        while (rs.next()) {
            TakeAnswer ta = new TakeAnswer();
            ta.setQuizID(rs.getInt("QuizID"));
            ta.setAnswer(rs.getString("Answer"));
            ta.setQuestionID(rs.getInt("QuestionID"));
            list.add(ta);
        }
        return list;
    }

    public static void main(String[] args) throws SQLException, Exception {
        TakeAnswerDAO s = new TakeAnswerDAO();
    }
}
