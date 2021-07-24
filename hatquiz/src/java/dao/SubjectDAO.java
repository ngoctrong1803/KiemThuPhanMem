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
import model.Subject;

/**
 *
 * @author Admin
 */
public class SubjectDAO {

    // get danh sách môn học
    public ArrayList<Subject> getListSubject() throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT * FROM subject order by SubjectID asc";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ArrayList<Subject> list = new ArrayList<>();
        while (rs.next()) {
            Subject subject = new Subject();
            subject.setSubjectID(rs.getInt("SubjectID"));
            subject.setSubjectName(rs.getString("SubjectName"));
            subject.setSubjectIcon(rs.getString("Icon"));
            subject.setDescription(rs.getString("Description"));
            subject.setCreatedate(rs.getTimestamp("CreateDate"));
            list.add(subject);
        }
        return list;
    }

    public Subject getSubjectByID(int id) throws Exception {
        Subject su = null;
        Connection connection = DBConnect.getConnecttion();
        String sql = "select * from subject where SubjectID=?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            int sid = rs.getInt("SubjectID");
            String name = rs.getString("SubjectName");
            String icon = rs.getString("Icon");
            String des = rs.getString("Description");
            Timestamp createdate = rs.getTimestamp("CreateDate");
            su = new Subject(sid, name, icon, des, createdate);
        }
        return su;
    }

    //Them moi
    public boolean insert(Subject s) throws SQLException {
        try {
            Connection connection = DBConnect.getConnecttion();
            String sql = "INSERT INTO subject VALUE(?,?,?,?,?)";
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setInt(1, s.getSubjectID());
            ps.setString(2, s.getSubjectName());
            ps.setString(3, s.getSubjectIcon());
            ps.setString(4, s.getDescription());
            ps.setTimestamp(5, new Timestamp(System.currentTimeMillis()));
            int temp = ps.executeUpdate();
            return temp == 1;
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    //cap nhat
    public boolean update(Subject s) throws SQLException {
        try {
            Connection connection = DBConnect.getConnecttion();
            String sql = "update subject set SubjectName = ?, Icon = ?, Description = ?, CreateDate = ? WHERE SubjectID = ?";
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, s.getSubjectName());
            ps.setString(2, s.getSubjectIcon());
            ps.setString(3, s.getDescription());
            ps.setTimestamp(4, s.getCreatedate());
            ps.setInt(5, s.getSubjectID());
            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    //xoa
    public boolean delete(int sub_id) throws SQLException {
        Connection con = DBConnect.getConnecttion();
        String sql = "DELETE FROM subject WHERE SubjectID = ?";
        try {
            PreparedStatement ps = con.prepareCall(sql);
            ps.setInt(1, sub_id);
            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    //Total Subject number
    public int getCount() {
        Connection conn = DBConnect.getConnecttion();
        ArrayList<Subject> list = new ArrayList();
        String sql = "SELECT count(SubjectID) FROM subject";
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
