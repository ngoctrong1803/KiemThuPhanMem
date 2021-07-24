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
import model.Banner;

public class BannerDAO {
    // get danh sách banner
    public ArrayList<Banner> getListBanner() throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT * FROM banner";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ArrayList<Banner> list = new ArrayList<>();
        while (rs.next()) {
            Banner bn = new Banner();
            bn.setBannerID(rs.getInt("BannerID"));
            bn.setContent(rs.getString("Content"));
            bn.setImage(rs.getString("Image"));
            bn.setCreatedate(rs.getTimestamp("CreateDate"));
            list.add(bn);
        }
        return list;
    }

    public Banner getBannerByID(int id) throws Exception {
        Banner bn = null;
        Connection connection = DBConnect.getConnecttion();
        String sql = "select * from banner where BannerID=?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            int bid = rs.getInt("BannerID");
            String content = rs.getString("Content");
            String image = rs.getString("Image");
            Timestamp createdate = rs.getTimestamp("CreateDate");
            bn = new Banner(bid, content, image, createdate);
        }
        return bn;
    }

    //Them moi
    public boolean insert(Banner bn) throws SQLException {
        try {
            Connection connection = DBConnect.getConnecttion();
            String sql = "INSERT INTO banner VALUE(?,?,?,?)";
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setInt(1, bn.getBannerID());
            ps.setString(2, bn.getContent());
            ps.setString(3, bn.getImage());
            ps.setTimestamp(4, new Timestamp(System.currentTimeMillis()));
            int temp = ps.executeUpdate();
            return temp == 1;
        } catch (SQLException ex) {
            Logger.getLogger(BannerDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    //cap nhat
    public boolean update(Banner bn) throws SQLException {
        try {
            Connection connection = DBConnect.getConnecttion();
            String sql = "update banner set Content = ?, Image = ?, CreateDate = ? WHERE BannerID = ?";
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, bn.getContent());
            ps.setString(2, bn.getImage());
            ps.setTimestamp(3, new Timestamp(System.currentTimeMillis()));
            ps.setInt(4, bn.getBannerID());
            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            Logger.getLogger(BannerDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    //xoa
    public boolean delete(int bn_id) throws SQLException {
        Connection con = DBConnect.getConnecttion();
        String sql = "DELETE FROM banner WHERE BannerID = ?";
        try {
            PreparedStatement ps = con.prepareCall(sql);
            ps.setInt(1, bn_id);
            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            Logger.getLogger(BannerDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
}
