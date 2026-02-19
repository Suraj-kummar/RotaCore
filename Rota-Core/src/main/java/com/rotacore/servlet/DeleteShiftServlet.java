package com.rotacore.servlet;

import com.rotacore.dao.NotificationDAO;
import com.rotacore.dao.ShiftDAO;
import com.rotacore.model.Notification;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/deleteShift")
public class DeleteShiftServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int shiftId = Integer.parseInt(request.getParameter("shiftId"));
        int employeeId = Integer.parseInt(request.getParameter("employeeId")); // Pass from form

        ShiftDAO shiftDAO = new ShiftDAO();
        try {
            shiftDAO.deleteShift(shiftId);
            // Add notification
            NotificationDAO notifDAO = new NotificationDAO();
            Notification notif = new Notification(employeeId, "Your shift (ID: " + shiftId + ") has been deleted.");
            notifDAO.addNotification(notif);
            response.sendRedirect("admin.jsp");
        } catch (SQLException e) {
            request.setAttribute("error", "Shift deletion failed: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}