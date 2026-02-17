package com.shiftmanager.servlet;

import com.shiftmanager.dao.ShiftDAO;
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

@WebServlet("/createShift")
public class CreateShiftServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int employeeId = Integer.parseInt(request.getParameter("employeeId"));
            String startTimeStr = request.getParameter("startTime"); // e.g., "2025-10-01T14:30"
            String endTimeStr = request.getParameter("endTime");

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

            Shift shift = new Shift(employeeId, startTime, endTime, "active");
            ShiftDAO shiftDAO = new ShiftDAO();
            shiftDAO.createShift(shift);
            response.sendRedirect("admin.jsp");
        } catch (SQLException e) {
            request.setAttribute("error", "Shift creation failed: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Invalid date format: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}