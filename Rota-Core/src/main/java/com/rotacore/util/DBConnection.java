package com.rotacore.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    // defaults for local development
    private static final String DEFAULT_URL = "jdbc:mysql://localhost:3306/rotacore";
    private static final String DEFAULT_USER = "root";
    private static final String DEFAULT_PASS = "0000";

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        String url = System.getenv("DB_URL");
        if (url == null)
            url = DEFAULT_URL;

        String user = System.getenv("DB_USER");
        if (user == null)
            user = DEFAULT_USER;

        String pass = System.getenv("DB_PASSWORD");
        if (pass == null)
            pass = DEFAULT_PASS;

        return DriverManager.getConnection(url, user, pass);
    }
}