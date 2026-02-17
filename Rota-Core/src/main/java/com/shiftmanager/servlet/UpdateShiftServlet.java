package com.shiftmanager.servlet;

import com.shiftmanager.dao.NotificationDAO;
import com.shiftmanager.dao.ShiftDAO;
import com.shiftmanager.model.Notification;
import com.shiftmanager.model.Shift;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@WebServlet("/updateShift")
public class UpdateShiftServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int shiftId = Integer.parseInt(request.getParameter("shiftId"));
            int employeeId = Integer.parseInt(request.getParameter("employeeId"));
            String startTimeStr = request.getParameter("startTime");
            String endTimeStr = request.getParameter("endTime");

            // Validate inputs
            if (startTimeStr == null || endTimeStr == null || startTimeStr.isEmpty() || endTimeStr.isEmpty()) {
                throw new IllegalArgumentException("Start time or end time is missing");
            }

            // Convert datetime-local format to Timestamp-compatible format
            DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
            DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

            // Parse and reformat startTime
            LocalDateTime startLocalDateTime = LocalDateTime.parse(startTimeStr, inputFormatter);
            String formattedStartTime = startLocalDateTime.format(outputFormatter);
            Timestamp startTime = Timestamp.valueOf(formattedStartTime);

            // Parse and reformat endTime
            LocalDateTime endLocalDateTime = LocalDateTime.parse(endTimeStr, inputFormatter);
            String formattedEndTime = endLocalDateTime.format(outputFormatter);
            Timestamp endTime = Timestamp.valueOf(formattedEndTime);

            Shift shift = new Shift();
            shift.setId(shiftId);
            shift.setStartTime(startTime);
            shift.setEndTime(endTime);

            ShiftDAO shiftDAO = new ShiftDAO();
            shiftDAO.updateShift(shift);

            // Add notification
            NotificationDAO notifDAO = new NotificationDAO();
            Notification notif = new Notification(employeeId, "Your shift (ID: " + shiftId + ") has been updated to " + startTime + " - " + endTime);
            notifDAO.addNotification(notif);
            response.sendRedirect("admin.jsp");
        } catch (SQLException e) {
            request.setAttribute("error", "Shift update failed: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Invalid date format or data: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}