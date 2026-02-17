CREATE DATABASE shift_manager;
USE shift_manager;

-- Users table
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(64) NOT NULL,  -- SHA-256 hash (64 chars)
    role ENUM('employee', 'admin') NOT NULL
);

-- Shifts table
CREATE TABLE shifts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT NOT NULL,
    start_time DATETIME NOT NULL,
    end_time DATETIME NOT NULL,
    status ENUM('active', 'updated', 'deleted') DEFAULT 'active',
    FOREIGN KEY (employee_id) REFERENCES users(id)
);

-- Notifications table (for basic alerts)
CREATE TABLE notifications (
    id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT NOT NULL,
    message TEXT NOT NULL,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (employee_id) REFERENCES users(id)
);


-- admin details = >
-- name = Admin
-- password = admin
-- email = admin@abhishek.com

SELECT * FROM users;



