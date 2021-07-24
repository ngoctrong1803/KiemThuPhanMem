package dao;

import connect.DBConnect;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ViewDAO {

    public int getViews() throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "Select * from view";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        int count = 0;
        while (rs.next()) {
            count = rs.getInt("ViewCount");
        }
        return count;
    }

    public void updateView() throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "UPDATE view set ViewCount = ViewCount+1";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.executeUpdate();
    }
}
