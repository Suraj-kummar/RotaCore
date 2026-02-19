<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <title>Login - RotaCore</title>
        <style>
            body {
                font-family: 'FK Grotesk Neue', Arial, sans-serif;
                background: #ffffff;
                margin: 0;
                padding: 0;
            }

            .login-container {
                max-width: 400px;
                margin: 50px auto;
                padding: 20px;
                border: 1px solid #ccc;
                background: white;
            }

            h2 {
                font-size: 20px;
                margin-bottom: 20px;
                border-bottom: 1px solid #ccc;
                padding-bottom: 5px;
            }

            label {
                display: block;
                margin-top: 10px;
                font-weight: bold;
            }

            input[type="email"],
            input[type="password"] {
                width: 100%;
                padding: 8px;
                margin-top: 5px;
                border: 1px solid #ccc;
            }

            input[type="submit"] {
                margin-top: 15px;
                padding: 10px;
                border: 1px solid #ccc;
                background: #f8f9fa;
                cursor: pointer;
                font-weight: bold;
            }

            input[type="submit"]:hover {
                background: #e2e2e2;
            }

            a {
                display: block;
                margin-top: 15px;
                color: #0645ad;
                text-decoration: none;
            }

            a:hover {
                text-decoration: underline;
            }

            .error {
                color: red;
                font-size: 14px;
            }
        </style>
    </head>

    <body>
        <div class="login-container">
            <h2>Login</h2>
            <% if (request.getAttribute("error") !=null) { %>
                <p class="error">
                    <%= request.getAttribute("error") %>
                </p>
                <% } %>
                    <form action="login" method="post">
                        <label>Email:</label>
                        <input type="email" name="email" required>
                        <label>Password:</label>
                        <input type="password" name="password" required>
                        <input type="submit" value="Login">
                    </form>
                    <a href="register.jsp">Sign up</a>
        </div>
    </body>

    </html>