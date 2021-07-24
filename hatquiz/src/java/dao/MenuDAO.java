package dao;

import connect.DBConnect;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Menu;

public class MenuDAO {

    // get danh sách menu nav
    public ArrayList<Menu> getListMenu() throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT * FROM menu order by Location asc";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ArrayList<Menu> list = new ArrayList<>();
        while (rs.next()) {
            Menu m = new Menu();
            m.setMenuID(rs.getInt("MenuID"));
            m.setName(rs.getString("Name"));
            m.setUrl(rs.getString("Url"));
            m.setLocation(rs.getInt("Location"));
            list.add(m);
        }
        return list;
    }

    public Menu getMenuByID(int id) throws Exception {
        Menu m = null;
        Connection connection = DBConnect.getConnecttion();
        String sql = "select * from menu where MenuID=?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            int mid = rs.getInt("MenuID");
            String name = rs.getString("Name");
            String url = rs.getString("Url");
            int location = rs.getInt("Location");
            m = new Menu(mid, name, url, location);
        }
        return m;
    }

    //Them moi
    public boolean insert(Menu m) throws SQLException {
        try {
            Connection connection = DBConnect.getConnecttion();
            String sql = "INSERT INTO menu VALUE(?,?,?,?)";
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setInt(1, m.getMenuID());
            ps.setString(2, m.getName());
            ps.setString(3, m.getUrl());
            ps.setInt(4, m.getLocation());
            int temp = ps.executeUpdate();
            return temp == 1;
        } catch (SQLException ex) {
            Logger.getLogger(MenuDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    //cap nhat
    public boolean update(Menu m) throws SQLException {
        try {
            Connection connection = DBConnect.getConnecttion();
            String sql = "update menu set Name = ?, Url = ?, Location = ? WHERE MenuID = ?";
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, m.getName());
            ps.setString(2, m.getUrl());
            ps.setInt(3, m.getLocation());
            ps.setInt(4, m.getMenuID());
            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            Logger.getLogger(MenuDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    //xoa
    public boolean delete(int m_id) throws SQLException {
        Connection con = DBConnect.getConnecttion();
        String sql = "DELETE FROM menu WHERE MenuID = ?";
        try {
            PreparedStatement ps = con.prepareCall(sql);
            ps.setInt(1, m_id);
            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            Logger.getLogger(MenuDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
}
