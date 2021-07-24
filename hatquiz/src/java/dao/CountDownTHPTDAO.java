package dao;

import connect.DBConnect;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.CountDownTHPT;

public class CountDownTHPTDAO {

    // get danh sách
    public ArrayList<CountDownTHPT> getListCountDownTHPT() throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT * FROM countdown";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ArrayList<CountDownTHPT> list = new ArrayList<>();
        while (rs.next()) {
            CountDownTHPT cd = new CountDownTHPT();
            cd.setCountDownID(rs.getInt("CountDownID"));
            cd.setYear(rs.getInt("Year"));
            cd.setStartDay(rs.getString("StartDay"));
            cd.setNote(rs.getString("Note"));
            list.add(cd);
        }
        return list;
    }

    public CountDownTHPT getCountDownByID(int id) throws Exception {
        CountDownTHPT cd = null;
        Connection connection = DBConnect.getConnecttion();
        String sql = "select * from countdown where CountDownID=?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            int cid = rs.getInt("CountDownID");
            int cyear = rs.getInt("Year");
            String startday = rs.getString("StartDay");
            String note = rs.getString("Note");
            cd = new CountDownTHPT(cid, cyear, startday, note);
        }
        return cd;
    }

    //Them moi
    public boolean insert(CountDownTHPT cd) throws SQLException {
        try {
            Connection connection = DBConnect.getConnecttion();
            String sql = "INSERT INTO countdown VALUE(?,?,?,?)";
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setInt(1, cd.getYear());
            ps.setString(2, cd.getStartDay());
            ps.setString(3, cd.getNote());
            ps.setInt(4, cd.getCountDownID());
            int temp = ps.executeUpdate();
            return temp == 1;
        } catch (SQLException ex) {
            Logger.getLogger(CountDownTHPTDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    //cap nhat
    public boolean update(CountDownTHPT cd) throws SQLException {
        try {
            Connection connection = DBConnect.getConnecttion();
            String sql = "update countdown set Year = ?, StartDay = ?, Note = ? WHERE CountDownID = ?";
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setInt(1, cd.getYear());
            ps.setString(2, cd.getStartDay());
            ps.setString(3, cd.getNote());
            ps.setInt(4, cd.getCountDownID());
            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            Logger.getLogger(CountDownTHPTDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    //xoa
    public boolean delete(int cd_id) throws SQLException {
        Connection con = DBConnect.getConnecttion();
        String sql = "DELETE FROM countdown WHERE CountDownID = ?";
        try {
            PreparedStatement ps = con.prepareCall(sql);
            ps.setInt(1, cd_id);
            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            Logger.getLogger(CountDownTHPTDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public static void main(String[] args) throws SQLException, Exception {
        CountDownTHPTDAO s = new CountDownTHPTDAO();
        System.out.println(s.insert(new CountDownTHPT(2021, "123", "123")));
    }
}
