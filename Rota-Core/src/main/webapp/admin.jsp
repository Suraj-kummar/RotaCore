<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page
        import="com.rotacore.dao.UserDAO, com.rotacore.dao.ShiftDAO, com.rotacore.model.User, com.rotacore.model.Shift, java.util.List"
        %>
        <!DOCTYPE html>
        <html>

        <head>
            <title>Admin Panel - RotaCore</title>
            <link rel="stylesheet" href="css/style.css">
            <script src="js/script.js"></script>
        </head>

        <body>
            <header>
                <div class="container">
                    <h1>RotaCore</h1>
                    <nav>
                        <a href="logout">Sign Out</a>
                    </nav>
                </div>
            </header>
            <div class="container">
                <% HttpSession sess=request.getSession(false); User user=(User) (sess !=null ? sess.getAttribute("user")
                    : null); if (user==null || !"admin".equals(user.getRole())) { response.sendRedirect("login.jsp");
                    return; } %>
                    <h2>Admin Panel</h2>

                    <h3>Employees</h3>
                    <table>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Email</th>
                        </tr>
                        <% UserDAO userDAO=new UserDAO(); List<User> employees = userDAO.getAllEmployees();
                            for (User emp : employees) {
                            %>
                            <tr>
                                <td>
                                    <%= emp.getId() %>
                                </td>
                                <td>
                                    <%= emp.getName() %>
                                </td>
                                <td>
                                    <%= emp.getEmail() %>
                                </td>
                            </tr>
                            <% } %>
                    </table>

                    <h3>Create Shift</h3>
                    <form action="createShift" method="post">
                        <label for="employeeId">Employee ID</label>
                        <input type="number" id="employeeId" name="employeeId" required>

                        <label for="startTime">Start Time</label>
                        <input type="datetime-local" id="startTime" name="startTime" required>

                        <label for="endTime">End Time</label>
                        <input type="datetime-local" id="endTime" name="endTime" required>

                        <input type="submit" value="Create Shift">
                    </form>

                    <h3>All Shifts</h3>
                    <table>
                        <tr>
                            <th>ID</th>
                            <th>Employee ID</th>
                            <th>Start</th>
                            <th>End</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                        <% ShiftDAO shiftDAO=new ShiftDAO(); List<Shift> shifts = shiftDAO.getAllShifts();
                            for (Shift shift : shifts) {
                            %>
                            <tr>
                                <td>
                                    <%= shift.getId() %>
                                </td>
                                <td>
                                    <%= shift.getEmployeeId() %>
                                </td>
                                <td>
                                    <%= shift.getStartTime() %>
                                </td>
                                <td>
                                    <%= shift.getEndTime() %>
                                </td>
                                <td>
                                    <%= shift.getStatus() %>
                                </td>
                                <td>
                                    <form action="updateShift" method="post" style="display:inline;">
                                        <input type="hidden" name="shiftId" value="<%= shift.getId() %>">
                                        <input type="hidden" name="employeeId" value="<%= shift.getEmployeeId() %>">
                                        <input type="datetime-local" name="startTime"
                                            value="<%= shift.getStartTime().toLocalDateTime().format(java.time.format.DateTimeFormatter.ofPattern("
                                            yyyy-MM-dd'T'HH:mm")) %>" required>
                                        <input type="datetime-local" name="endTime"
                                            value="<%= shift.getEndTime().toLocalDateTime().format(java.time.format.DateTimeFormatter.ofPattern("
                                            yyyy-MM-dd'T'HH:mm")) %>" required>
                                        <input type="submit" value="Update" class="action-btn">
                                    </form>
                                    <form action="deleteShift" method="post" style="display:inline;">
                                        <input type="hidden" name="shiftId" value="<%= shift.getId() %>">
                                        <input type="hidden" name="employeeId" value="<%= shift.getEmployeeId() %>">
                                        <input type="submit" value="Delete" class="action-btn delete-btn">
                                    </form>
                                </td>
                            </tr>
                            <% } %>
                    </table>
            </div>
            <footer>
                <p>&copy; 2025 RotaCore. All rights reserved.</p>
            </footer>
        </body>

        </html>