package dao;

import connect.DBConnect;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Administrator;

public class AdminDAO {

    public boolean checkEmail(String email) {
        Connection con = DBConnect.getConnecttion();
        String query = "SELECT * FROM administrator WHERE Email = '" + email + "'";
        PreparedStatement ps;
        try {
            ps = con.prepareCall(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                con.close();
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(AdminDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    // phương thức thêm tài khoản
    public boolean registerAdmin(Administrator ad) {
        Connection con = DBConnect.getConnecttion();
        try {
            String sql = "INSERT INTO administrator(FullName, Email, Password, Status) VALUES(?,?,?,?)";
            PreparedStatement ps = con.prepareCall(sql);
            ps.setString(1, ad.getFullName());
            ps.setString(2, ad.getEmail());
            ps.setString(3, ad.getPassword());
            ps.setBoolean(4, ad.getStatus());
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(AdminDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

//    Check Login method
    public Administrator checkLogin(String email, String password) {
        Connection con = DBConnect.getConnecttion();
        String sql = "select * from administrator where Email ='" + email + "' and Password ='" + password + "' and Status = true ";
        PreparedStatement ps;
        try {
            ps = (PreparedStatement) con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Administrator ad = new Administrator();
                ad.setFullName(rs.getString("FullName"));
                ad.setEmail(rs.getString("Email"));
                con.close();
                return ad;
            }
        } catch (SQLException ex) {
            Logger.getLogger(AdminDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    // get danh sách admin
    public ArrayList<Administrator> getListAdmin() throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT * FROM administrator order by AdminID asc";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ArrayList<Administrator> list = new ArrayList<>();
        while (rs.next()) {
            Administrator ad = new Administrator();
            ad.setId(rs.getInt("AdminID"));
            ad.setFullName(rs.getString("FullName"));
            ad.setEmail(rs.getString("Email"));
            ad.setPassword(rs.getString("Password"));
            ad.setStatus(rs.getBoolean("Status"));
            list.add(ad);
        }
        return list;
    }

    public Administrator getAdminByID(int id) throws Exception {
        Administrator ad = null;
        Connection connection = DBConnect.getConnecttion();
        String sql = "select * from administrator where AdminID=?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            int aid = rs.getInt("AdminID");
            String name = rs.getString("FullName");
            String email = rs.getString("Email");
            String password = rs.getString("Password");
            Boolean status = rs.getBoolean("Status");
            ad = new Administrator(aid, name, email, password, status);
        }
        return ad;
    }

    //Them moi
    public boolean insert(Administrator ad) throws SQLException {
        try {
            Connection connection = DBConnect.getConnecttion();
            String sql = "INSERT INTO administrator VALUE(?,?,?,?,?)";
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setInt(1, ad.getId());
            ps.setString(2, ad.getFullName());
            ps.setString(3, ad.getEmail());
            ps.setString(4, ad.getPassword());
            ps.setBoolean(5, ad.getStatus());
            int temp = ps.executeUpdate();
            return temp == 1;
        } catch (SQLException ex) {
            Logger.getLogger(AdminDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    //cap nhat
    public boolean update(Administrator ad) throws SQLException {
        try {
            Connection connection = DBConnect.getConnecttion();
            String sql = "update administrator set FullName = ?, Email = ?, Password = ?, Status = ? WHERE AdminID = ?";
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, ad.getFullName());
            ps.setString(2, ad.getEmail());
            ps.setString(3, ad.getPassword());
            ps.setBoolean(4, ad.getStatus());
            ps.setInt(5, ad.getId());
            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            Logger.getLogger(AdminDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    //xoa
    public boolean delete(int admin_id) throws SQLException {
        Connection con = DBConnect.getConnecttion();
        String sql = "DELETE FROM administrator WHERE AdminID = ?";
        try {
            PreparedStatement ps = con.prepareCall(sql);
            ps.setInt(1, admin_id);
            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            Logger.getLogger(AdminDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    public int getCountAdminF() {
        Connection conn = DBConnect.getConnecttion();
        ArrayList<Administrator> list = new ArrayList();
        String sql = "SELECT COUNT(AdminID) FROM administrator WHERE STATUS = false";
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
