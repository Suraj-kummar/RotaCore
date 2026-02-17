<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.shiftmanager.dao.ShiftDAO, com.shiftmanager.dao.NotificationDAO, com.shiftmanager.model.Shift, com.shiftmanager.model.Notification, com.shiftmanager.model.User, java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Employee Dashboard - Shift Manager</title>
    <link rel="stylesheet" href="css/style.css">
    <script src="js/script.js"></script>
</head>
<body>
    <%
        HttpSession sess = request.getSession(false); 
        User user = (User) (sess != null ? sess.getAttribute("user") : null);
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        int employeeId = user.getId();
    %>

    <!-- Left Sidebar (Profile) -->
    <div class="sidebar-left" id="sidebarLeft">
        <h2>Profile</h2>
        <div class="profile-card">
            <p><strong>Name:</strong> <%= user.getName() %></p>
            <p><strong>Email:</strong> <%= user.getEmail() %></p>
            <p><strong>Role:</strong> <%= user.getRole() %></p>
        </div>
        <nav class="side-nav">
		    <a href="logout" class="diamond-red-button">Sign Out</a>
		</nav>
		
		<style>
			

		</style>

    </div>

    <!-- Main Content -->
    <div class="container">
        <header>
            <h1>Shift Manager</h1>
            <div class="header-actions">
                <button id="menuToggle">☰</button>
                <button id="themeToggle">Dark Mode</button>
            </div>
        </header>

        <h2>Employee Dashboard</h2>

        <h3>Upcoming Shifts</h3>
        <div class="table-responsive">
            <table>
                <tr><th>ID</th><th>Start</th><th>End</th><th>Status</th></tr>
                <%
                    ShiftDAO shiftDAO = new ShiftDAO();
                    List<Shift> shifts = shiftDAO.getShiftsByEmployee(employeeId);
                    for (Shift shift : shifts) {
                %>
                    <tr>
                        <td><%= shift.getId() %></td>
                        <td><%= shift.getStartTime() %></td>
                        <td><%= shift.getEndTime() %></td>
                        <td><%= shift.getStatus() %></td>
                    </tr>
                <% } %>
            </table>
        </div>
    </div>

    <!-- Right Sidebar (Notifications) -->
    <div class="sidebar-right">
        <h2>Notifications</h2>
        <ul class="notifications">
            <%
                NotificationDAO notifDAO = new NotificationDAO();
                List<Notification> notifications = notifDAO.getNotificationsByEmployee(employeeId);
                for (Notification notif : notifications) {
            %>
                <li><%= notif.getMessage() %> (at <%= notif.getTimestamp() %>)</li>
            <% } %>
            <% if (notifications.isEmpty()) { %>
                <li>No new notifications.</li>
            <% } %>
        </ul>
    </div>

    <footer>
        <p>&copy; 2025 Shift Manager. All rights reserved.</p>
    </footer>

<style>
/* Layout */
body {
    display: flex;
    margin: 0;
    transition: background 0.3s, color 0.3s;
}

/* Left Sidebar (Profile) */
.sidebar-left {
    width: 220px;
    background: #f8f9fa;
    border-right: 1px solid #a2a9b1;
    padding: 20px;
    position: fixed;
    top: 0;
    bottom: 0;
    overflow-y: auto;
    transition: transform 0.3s ease-in-out;
}
.sidebar-left.hidden {
    transform: translateX(-100%);
}

/* Header Actions */
.header-actions {
    float: right;
}
.header-actions button {
    margin-left: 10px;
    padding: 6px 12px;
    cursor: pointer;
}

/* Main Content */
.container {
    flex: 1;
    margin: 0 260px 0 240px;
    padding: 20px;
    background: #ffffff;
    min-height: 100vh;
}

/* Right Sidebar (Notifications) */
.sidebar-right {
    width: 260px;
    background: #f8f9fa;
    border-left: 1px solid #a2a9b1;
    padding: 20px;
    position: fixed;
    right: 0;
    top: 0;
    bottom: 0;
    overflow-y: auto;
}

/* Footer */
footer {
    position: fixed;
    bottom: 0;
    left: 240px;
    right: 260px;
    background: #f8f9fa;
    border-top: 1px solid #a2a9b1;
    text-align: center;
    padding: 10px;
    font-size: 12px;
    color: #54595d;
}

/* Table Styling */
table {
    width: 100%;
    border-collapse: collapse;
}
th, td {
    padding: 10px;
    border: 1px solid #a2a9b1;
    text-align: left;
}

/* button style (logout) */
.diamond-red-button {
    display: inline-block;
    padding: 5px 10px;
    background: linear-gradient(145deg, #ffffff, #e6e6e6);
    color: #333333;
    font-weight: bold;
    text-decoration: none;
    border: 2px solid white;
    border-radius: 2px;
    text-align: center;
    position: relative;
    overflow: hidden;
}

.diamond-red-button::before {
    content: "";
    position: absolute;
    top: 0;
    left: -75%;
    width: 50%;
    height: 100%;
    background: linear-gradient(
        to right,
        rgba(255, 255, 255, 0.2),
        rgba(255, 255, 255, 0.6),
        rgba(255, 255, 255, 0.2)
    );
    transform: skewX(-20deg);
    transition: all 0.7s ease;
}

.diamond-red-button:hover::before {
    left: 125%;
}

/* Dark Mode */
body.dark-mode {
    background-color: #1c1c1e;
    color: #f5f5f7;
}
body.dark-mode .container,
body.dark-mode .sidebar-left,
body.dark-mode .sidebar-right,
body.dark-mode .notifications,
body.dark-mode footer {
    background: #2c2c2e;
    border-color: #3a3a3c;
    color: #f5f5f7;
}
body.dark-mode table {
    background: #2c2c2e;
    color: #f5f5f7;
    border: 1px solid #3a3a3c;
}
body.dark-mode th,
body.dark-mode td {
    border: 1px solid #3a3a3c;
    padding: 10px;
}
body.dark-mode th {
    background: #3a3a3c;
    color: #ffffff;
}
body.dark-mode tr:nth-child(even) {
    background: #252526;
}
body.dark-mode tr:hover {
    background: #38383a;
}

/* Responsive Table */
.table-responsive {
    overflow-x: auto;
}
@media (max-width: 768px) {
    table {
        display: block;
        overflow-x: auto;
        white-space: nowrap;
    }
    th, td {
        padding: 8px;
        font-size: 14px;
    }
    .container {
        margin: 0 0 0 0;
    }
    footer {
        left: 0;
        right: 0;
    }
}
</style>

<script>
// 🌙 Dark Mode Toggle
document.addEventListener("DOMContentLoaded", () => {
    const toggleBtn = document.getElementById("themeToggle");
    if (localStorage.getItem("theme") === "dark") {
        document.body.classList.add("dark-mode");
        toggleBtn.textContent = "Light Mode";
    }
    toggleBtn.addEventListener("click", () => {
        document.body.classList.toggle("dark-mode");
        if (document.body.classList.contains("dark-mode")) {
            localStorage.setItem("theme", "dark");
            toggleBtn.textContent = "Light Mode";
        } else {
            localStorage.setItem("theme", "light");
            toggleBtn.textContent = "Dark Mode";
        }
    });
});

// 📱 Mobile Sidebar Toggle
document.getElementById("menuToggle").addEventListener("click", () => {
    document.getElementById("sidebarLeft").classList.toggle("hidden");
});
</script>
</body>
</html>
