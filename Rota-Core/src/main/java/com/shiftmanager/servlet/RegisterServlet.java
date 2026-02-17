package com.shiftmanager.servlet;

import com.shiftmanager.dao.UserDAO;
import com.shiftmanager.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        User user = new User(name, email, password, "employee");
        UserDAO userDAO = new UserDAO();
        try {
            userDAO.registerUser(user);
            response.sendRedirect("login.jsp");
        } catch (SQLException e) {
            request.setAttribute("error", "Registration failed: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}