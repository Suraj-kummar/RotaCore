package com.rotacore.dao;

import com.rotacore.model.Notification;
import com.rotacore.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class NotificationDAO {
    public void addNotification(Notification notification) throws SQLException {
        String sql = "INSERT INTO notifications (employee_id, message) VALUES (?, ?)";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, notification.getEmployeeId());
            ps.setString(2, notification.getMessage());
            ps.executeUpdate();
        }
    }

    public List<Notification> getNotificationsByEmployee(int employeeId) throws SQLException {
        List<Notification> notifications = new ArrayList<>();
        String sql = "SELECT * FROM notifications WHERE employee_id = ? ORDER BY timestamp DESC";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, employeeId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Notification notif = new Notification();
                notif.setId(rs.getInt("id"));
                notif.setEmployeeId(rs.getInt("employee_id"));
                notif.setMessage(rs.getString("message"));
                notif.setTimestamp(rs.getTimestamp("timestamp"));
                notifications.add(notif);
            }
        }
        return notifications;
    }
}