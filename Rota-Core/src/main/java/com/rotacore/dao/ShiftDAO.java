package com.rotacore.dao;

import com.rotacore.model.Shift;
import com.rotacore.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ShiftDAO {
    public void createShift(Shift shift) throws SQLException {
        String sql = "INSERT INTO shifts (employee_id, start_time, end_time, status) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, shift.getEmployeeId());
            ps.setTimestamp(2, shift.getStartTime());
            ps.setTimestamp(3, shift.getEndTime());
            ps.setString(4, shift.getStatus());
            ps.executeUpdate();
        }
    }

    public void updateShift(Shift shift) throws SQLException {
        String sql = "UPDATE shifts SET start_time = ?, end_time = ?, status = 'updated' WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setTimestamp(1, shift.getStartTime());
            ps.setTimestamp(2, shift.getEndTime());
            ps.setInt(3, shift.getId());
            ps.executeUpdate();
        }
    }

    public void deleteShift(int shiftId) throws SQLException {
        String sql = "UPDATE shifts SET status = 'deleted' WHERE id = ?"; // Soft delete
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, shiftId);
            ps.executeUpdate();
        }
    }

    public List<Shift> getShiftsByEmployee(int employeeId) throws SQLException {
        List<Shift> shifts = new ArrayList<>();
        String sql = "SELECT * FROM shifts WHERE employee_id = ? AND status != 'deleted' ORDER BY start_time ASC";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, employeeId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Shift shift = new Shift();
                shift.setId(rs.getInt("id"));
                shift.setEmployeeId(rs.getInt("employee_id"));
                shift.setStartTime(rs.getTimestamp("start_time"));
                shift.setEndTime(rs.getTimestamp("end_time"));
                shift.setStatus(rs.getString("status"));
                shifts.add(shift);
            }
        }
        return shifts;
    }

    public List<Shift> getAllShifts() throws SQLException {
        List<Shift> shifts = new ArrayList<>();
        String sql = "SELECT * FROM shifts WHERE status != 'deleted' ORDER BY start_time ASC";
        try (Connection conn = DBConnection.getConnection();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Shift shift = new Shift();
                shift.setId(rs.getInt("id"));
                shift.setEmployeeId(rs.getInt("employee_id"));
                shift.setStartTime(rs.getTimestamp("start_time"));
                shift.setEndTime(rs.getTimestamp("end_time"));
                shift.setStatus(rs.getString("status"));
                shifts.add(shift);
            }
        }
        return shifts;
    }
}