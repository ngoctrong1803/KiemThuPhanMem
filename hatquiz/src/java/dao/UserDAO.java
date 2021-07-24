package dao;

import connect.DBConnect;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.User;

public class UserDAO {

    // get danh sách user
    public ArrayList<User> getListUser() throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT * FROM user order by UserID asc";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ArrayList<User> list = new ArrayList<>();
        while (rs.next()) {
            User user = new User();
            user.setUserID(rs.getInt("UserID"));
            user.setFullName(rs.getString("FullName"));
            user.setEmail(rs.getString("Email"));
            user.setPassword(rs.getString("Password"));
            user.setPhone(rs.getString("Phone"));
            user.setAddress(rs.getString("Address"));
            list.add(user);
        }
        return list;
    }

    public User getUserByID(int id) throws Exception {
        User u = null;
        Connection connection = DBConnect.getConnecttion();
        String sql = "select * from user where UserID=?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            int uid = rs.getInt("UserID");
            String name = rs.getString("FullName");
            String email = rs.getString("Email");
            String password = rs.getString("Password");
            String phone = rs.getString("Phone");
            String address = rs.getString("Address");
            u = new User(uid, name, email, password, phone, address);
        }
        return u;
    }

    //Them moi
    public boolean insert(User u) throws SQLException {
        try {
            Connection connection = DBConnect.getConnecttion();
            String sql = "INSERT INTO user VALUE(?,?,?,?,?,?)";
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setInt(1, u.getUserID());
            ps.setString(2, u.getFullName());
            ps.setString(3, u.getEmail());
            ps.setString(4, u.getPassword());
            ps.setString(5, u.getPhone());
            ps.setString(6, u.getAddress());
            int temp = ps.executeUpdate();
            return temp == 1;
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    //cap nhat của admin
    public boolean update(User u) throws SQLException {
        try {
            Connection connection = DBConnect.getConnecttion();
            String sql = "update user set FullName = ?, Email = ?, Password = ?, Phone = ?, Address = ? WHERE UserID = ?";
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, u.getFullName());
            ps.setString(2, u.getEmail());
            ps.setString(3, u.getPassword());
            ps.setString(4, u.getPhone());
            ps.setString(5, u.getAddress());
            ps.setInt(6, u.getUserID());
            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    //cap nhat của hoc vien
    public boolean updateUser(User u) throws SQLException {
        try {
            Connection connection = DBConnect.getConnecttion();
            String sql = "update user set FullName = ?, Phone = ?, Address = ? WHERE UserID = ?";
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, u.getFullName());
            ps.setString(2, u.getPhone());
            ps.setString(3, u.getAddress());
            ps.setInt(4, u.getUserID());
            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    //thay doi pass của hoc vien
    public boolean changePass(User u) throws SQLException {
        try {
            Connection connection = DBConnect.getConnecttion();
            String sql = "update user set Password = ? WHERE UserID = ?";
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, u.getPassword());
            ps.setInt(2, u.getUserID());
            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    //xoa
    public boolean delete(int user_id) throws SQLException {
        Connection con = DBConnect.getConnecttion();
        String sql = "DELETE FROM user WHERE UserID = ?";
        try {
            PreparedStatement ps = con.prepareCall(sql);
            ps.setInt(1, user_id);
            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    //phân trang
    public ArrayList<User> getUser(int a, int b) {
        Connection conn = DBConnect.getConnecttion();
        ArrayList<User> list = new ArrayList();
        String sql = "SELECT * FROM user order by UserID asc Limit ?,?";
        try {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, a);
            stmt.setInt(2, b);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setUserID(rs.getInt("UserID"));
                user.setFullName(rs.getString("FullName"));
                user.setEmail(rs.getString("Email"));
                user.setPassword(rs.getString("Password"));
                user.setPhone(rs.getString("Phone"));
                user.setAddress(rs.getString("Address"));
                list.add(user);
            }
            return list;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    //Total user number
    public int getCount() {
        Connection conn = DBConnect.getConnecttion();
        ArrayList<User> list = new ArrayList();
        String sql = "SELECT count(UserID) FROM user";
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
    public ArrayList<User> search(String search) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT * FROM user WHERE FullName like ? or Email like ? or Phone like ? or Address like ?";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setString(1, "%" + search + "%");
        ps.setString(2, "%" + search + "%");
        ps.setString(3, "%" + search + "%");
        ps.setString(4, "%" + search + "%");
        ResultSet rs = ps.executeQuery();
        ArrayList<User> list = new ArrayList<>();
        while (rs.next()) {
            User user = new User();
            user.setUserID(rs.getInt("UserID"));
            user.setFullName(rs.getString("FullName"));
            user.setEmail(rs.getString("Email"));
            user.setPassword(rs.getString("Password"));
            user.setPhone(rs.getString("Phone"));
            user.setAddress(rs.getString("Address"));
            list.add(user);
        }
        return list;
    }

    //users
    //ktra email
    public boolean checkEmail(String email) {
        Connection connection = DBConnect.getConnecttion();
        String sql = "select * from user where Email = '" + email + "'";
        PreparedStatement ps;
        try {
            ps = connection.prepareCall(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                connection.close();
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    //ktra email
    public boolean checkPass(String pass) {
        Connection connection = DBConnect.getConnecttion();
        String sql = "select * from user where Password = '" + pass + "'";
        PreparedStatement ps;
        try {
            ps = connection.prepareCall(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                connection.close();
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    //ktra login
    public User login(String email, String pass) {
        Connection con = DBConnect.getConnecttion();
        String sql = "select * from user where Email = '" + email + "' and Password = '" + pass + "'";
        PreparedStatement ps;
        try {
            ps = (PreparedStatement) con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                User u = new User();
                u.setUserID(rs.getInt("UserID"));
                u.setEmail(rs.getString("Email"));
                u.setFullName(rs.getString("FullName"));
                con.close();
                return u;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }
}
