<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.rotacore.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RotaCore</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: Arial, 'Helvetica Neue', sans-serif;
            background-color: #f8f8f8;
            color: #202122;
            line-height: 1.6;
            font-size: 16px;
        }
        .container {
            max-width: 960px;
            margin: 0 auto;
            padding: 20px;
        }
        header {
            background: #f8f8f8;
            border-bottom: 1px solid #c8ccd1;
            padding: 10px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;

            position: sticky; /* sticky header */
            top: 0;
            z-index: 1000;
        }
        header h1 {
            font-size: 24px;
            font-weight: normal;
        }
        nav a {
            color: #0645ad;
            text-decoration: none;
            margin-left: 15px;
            font-size: 14px;
        }
        nav a:hover {
            text-decoration: underline;
        }
        .hero {
            text-align: center;
            padding: 40px 20px;
            background: #fff;
            border: 1px solid #c8ccd1;
            border-radius: 4px;
            margin-bottom: 20px;
        }
        .hero h2 {
            font-size: 28px;
            font-weight: normal;
            margin-bottom: 10px;
        }
        .hero p {
            font-size: 16px;
            color: #54595d;
            max-width: 800px;
            margin: 0 auto 20px;
        }
        .hero-buttons a {
            display: inline-block;
            padding: 8px 16px;
            margin: 0 10px;
            background: #f8f8f8;
            border: 1px solid #a2a9af;
            border-radius: 3px;
            color: #0645ad;
            text-decoration: none;
            font-size: 14px;
        }
        .hero-buttons a:hover {
            background: #e6e6e6;
            color: #003087;
        }
        .hero-buttons .primary-btn {
            background: #0645ad;
            color: #fff;
            border: none;
        }
        .hero-buttons .primary-btn:hover {
            background: #003087;
        }
        article {
            background: #fff;
            padding: 20px;
            border: 1px solid #c8ccd1;
            border-radius: 4px;
            margin-bottom: 20px;
        }
        article h3 {
            font-size: 20px;
            margin-top: 20px;
            margin-bottom: 10px;
            border-bottom: 1px solid #ccc;
            padding-bottom: 5px;
        }
        article p {
            margin-bottom: 15px;
            text-align: justify;
        }
        footer {
            text-align: center;
            padding: 20px;
            font-size: 12px;
            color: #54595d;
            border-top: 1px solid #c8ccd1;
            background: #f8f8f8;
        }
    </style>
</head>
<body>
<%
    HttpSession sess = request.getSession(false);
    User user = (User) (sess != null ? sess.getAttribute("user") : null);
    if (user != null) {
        if ("admin".equals(user.getRole())) {
            response.sendRedirect("admin.jsp");
        } else {
            response.sendRedirect("employee.jsp");
        }
        return;
    }
%>
<header>
    <div class="container" style="display: flex; justify-content: space-between; align-items: center;">
        <h1>RotaCore</h1>
        <nav style="display: flex; align-items: center;">
            <a href="login.jsp">Login</a>
            <a href="register.jsp">Sign Up</a>
        </nav>
    </div>
</header>

<div class="container">
    <section class="hero">
        <h2>Welcome to RotaCore</h2>
        <p>RotaCore is a modern platform designed to streamline workforce scheduling, track shifts, and improve team productivity.</p>
        <div class="hero-buttons">
            <a href="login.jsp" class="primary-btn">Sign In</a>
            <a href="register.jsp">Sign Up</a>
        </div>
    </section>

    <article>
        <h3>About RotaCore</h3>
        <p>RotaCore helps organizations schedule and manage employee shifts efficiently, improving operational productivity and communication.</p>

        <h3>Features</h3>
        <p>- Easy shift creation and management.</p>
        <p>- Real-time notifications for employees.</p>
        <p>- Role-based access for admins and employees.</p>
        <p>- Clean and responsive design.</p>

        <h3>Benefits</h3>
        <p>By using RotaCore, organizations can reduce administrative work, minimize scheduling errors, and ensure employee satisfaction.</p>
    </article>
</div>

<footer>
    <p>&copy; 2025 RotaCore. All rights reserved.</p>
</footer>
</body>
</html>
