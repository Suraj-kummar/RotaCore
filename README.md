# RotaCore - Enterprise Shift Management System

[![Java](https://img.shields.io/badge/Java-ED8B00?style=for-the-badge&logo=openjdk&logoColor=white)](https://www.java.com/)
[![MySQL](https://img.shields.io/badge/MySQL-00000F?style=for-the-badge&logo=mysql&logoColor=white)](https://www.mysql.com/)
[![Apache Tomcat](https://img.shields.io/badge/Apache%20Tomcat-F8DC75?style=for-the-badge&logo=apache-tomcat&logoColor=black)](https://tomcat.apache.org/)

A robust, enterprise-grade shift management application built with Java EE technologies, designed to streamline employee scheduling, shift tracking, and workforce management operations. This system provides role-based access control, real-time notifications, and comprehensive shift management capabilities for organizations of all sizes.

---

## 📑 Table of Contents

- [Features](#-features)
- [System Architecture](#-system-architecture)
- [Technology Stack](#-technology-stack)
- [Prerequisites](#-prerequisites)
- [Installation & Setup](#-installation--setup)
- [Database Configuration](#-database-configuration)
- [Deployment](#-deployment)
- [Usage Guide](#-usage-guide)
- [API Documentation](#-api-documentation)
- [Project Structure](#-project-structure)
- [Security Considerations](#-security-considerations)
- [Contributing](#-contributing)
- [Troubleshooting](#-troubleshooting)
- [License](#-license)

---

## ✨ Features

### Core Functionality
- **Role-Based Access Control (RBAC)**
  - Admin and Employee role separation
  - Secure authentication and authorization
  - Session management with filters

- **Comprehensive Shift Management**
  - Create, read, update, and delete (CRUD) operations for shifts
  - Real-time shift status tracking (active, updated, deleted)
  - Shift conflict detection and validation
  - DateTime-based shift scheduling

- **User Management**
  - User registration and authentication
  - Secure password hashing (SHA-256)
  - User profile management
  - Employee directory

- **Notification System**
  - Real-time notifications for shift changes
  - Employee-specific notification feed
  - Timestamp tracking for all notifications

### Admin Capabilities
- Complete shift oversight across all employees
- Employee management and administration
- Shift assignment and reassignment
- System-wide reporting and analytics
- User role management

### Employee Capabilities
- View personal shift schedule
- Receive notifications for shift updates
- Track shift history
- Profile management

---

## 🏗️ System Architecture

RotaCore follows the **Model-View-Controller (MVC)** architectural pattern with a clear separation of concerns:

```
┌─────────────┐
│   Client    │ (Browser - JSP Views)
└──────┬──────┘
       │
       ▼
┌─────────────┐
│  Servlets   │ (Controllers - Business Logic)
└──────┬──────┘
       │
       ▼
┌─────────────┐
│     DAO     │ (Data Access Layer)
└──────┬──────┘
       │
       ▼
┌─────────────┐
│   Models    │ (Entity Classes)
└──────┬──────┘
       │
       ▼
┌─────────────┐
│   MySQL DB  │ (Persistent Storage)
└─────────────┘
```

### Architecture Components

1. **Presentation Layer** - JSP pages with CSS/JavaScript
2. **Controller Layer** - Servlets handling HTTP requests
3. **Service Layer** - Business logic and validation
4. **Data Access Layer (DAO)** - Database operations
5. **Model Layer** - POJOs representing domain entities
6. **Utility Layer** - Database connections and helpers

---

## 🛠️ Technology Stack

### Backend
- **Java EE 8+** - Core application framework
- **Servlets 4.0** - Request handling and routing
- **JSP 2.3** - Server-side rendering
- **JDBC** - Database connectivity

### Frontend
- **HTML5** - Semantic markup
- **CSS3** - Responsive styling
- **JavaScript (ES6+)** - Client-side interactivity

### Database
- **MySQL 8.0+** - Relational database management

### Server
- **Apache Tomcat 9.0+** - Servlet container

### Build Tools
- **Eclipse/IntelliJ IDEA** - Development environment
- **Maven/Gradle** (optional) - Dependency management

---

## 📋 Prerequisites

Before setting up RotaCore, ensure you have the following installed:

- **Java Development Kit (JDK) 8 or higher**
  ```bash
  java -version
  # Should output: java version "1.8.0" or higher
  ```

- **Apache Tomcat 9.0+**
  - Download from: https://tomcat.apache.org/download-90.cgi

- **MySQL Server 8.0+**
  ```bash
  mysql --version
  # Should output: mysql Ver 8.0.x
  ```

- **MySQL Workbench** (Optional but recommended)
  - For database visualization and management

- **Eclipse IDE for Enterprise Java Developers** or **IntelliJ IDEA Ultimate**
  - With Java EE/Jakarta EE support

---

## 🚀 Installation & Setup

### Step 1: Clone the Repository

```bash
git clone https://github.com/yourusername/RotaCore.git
cd RotaCore/Rota-Core
```

### Step 2: Database Configuration

1. **Start MySQL Server**
   ```bash
   # Windows
   net start MySQL80
   
   # Linux/Mac
   sudo systemctl start mysql
   ```

2. **Create Database and Tables**
   ```bash
   mysql -u root -p < db.sql
   ```

   Or manually execute the SQL script:
   ```sql
   mysql -u root -p
   ```
   ```sql
   source /path/to/RotaCore/Rota-Core/db.sql;
   ```

3. **Verify Database Setup**
   ```sql
   USE shift_manager;
   SHOW TABLES;
   -- Should display: users, shifts, notifications
   ```

### Step 3: Configure Database Connection

Update the database credentials in `src/main/java/com/shiftmanager/util/DBConnection.java`:

```java
private static final String URL = "jdbc:mysql://localhost:3306/shift_manager";
private static final String USERNAME = "root";  // Your MySQL username
private static final String PASSWORD = "yourpassword";  // Your MySQL password
```

### Step 4: Import Project into IDE

#### For Eclipse:
1. Open Eclipse IDE
2. **File → Import → Existing Projects into Workspace**
3. Select the `Rota-Core` directory
4. Click **Finish**

#### For IntelliJ IDEA:
1. Open IntelliJ IDEA
2. **File → Open**
3. Select the `Rota-Core` directory
4. Configure Tomcat server in **Run → Edit Configurations**

### Step 5: Configure Apache Tomcat

1. **In Eclipse:**
   - **Window → Preferences → Server → Runtime Environments**
   - Click **Add** → Select **Apache Tomcat v9.0**
   - Browse to your Tomcat installation directory
   - Click **Finish**

2. **Add Server to Project:**
   - Right-click on project → **Run As → Run on Server**
   - Select configured Tomcat server
   - Click **Finish**

---

## 🗄️ Database Configuration

### Database Schema

#### Users Table
```sql
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(64) NOT NULL,  -- SHA-256 hash
    role ENUM('employee', 'admin') NOT NULL
);
```

#### Shifts Table
```sql
CREATE TABLE shifts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT NOT NULL,
    start_time DATETIME NOT NULL,
    end_time DATETIME NOT NULL,
    status ENUM('active', 'updated', 'deleted') DEFAULT 'active',
    FOREIGN KEY (employee_id) REFERENCES users(id)
);
```

#### Notifications Table
```sql
CREATE TABLE notifications (
    id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT NOT NULL,
    message TEXT NOT NULL,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (employee_id) REFERENCES users(id)
);
```

### Default Admin Account

After running `db.sql`, manually insert the admin account:

```sql
INSERT INTO users (name, email, password, role) 
VALUES ('Admin', 'admin@abhishek.com', 
        SHA2('admin', 256), 'admin');
```

**Default Credentials:**
- **Email:** admin@abhishek.com
- **Password:** admin
- **Role:** Admin

> ⚠️ **Security Warning:** Change the default admin password immediately after first login in a production environment.

---

## 📦 Deployment

### Local Deployment (Development)

1. **Build the Project**
   - In Eclipse: **Project → Clean → Build Project**
   - Ensure no compilation errors

2. **Deploy to Tomcat**
   - Right-click project → **Run As → Run on Server**
   - Select Tomcat server
   - Application will be deployed automatically

3. **Access the Application**
   ```
   http://localhost:8080/Rota-Core/
   ```

### Production Deployment

1. **Build WAR File**
   - Right-click project → **Export → WAR file**
   - Save as `shift-manager.war`

2. **Deploy to Tomcat**
   ```bash
   # Copy WAR to Tomcat webapps directory
   cp shift-manager.war /path/to/tomcat/webapps/
   
   # Restart Tomcat
   ./bin/shutdown.sh
   ./bin/startup.sh
   ```

3. **Update Database Connection**
   - Use production database credentials
   - Enable SSL/TLS for database connections
   - Configure connection pooling (recommended)

4. **Access Production Application**
   ```
   http://your-domain.com:8080/shift-manager/
   ```

---

## 📖 Usage Guide

### For Administrators

1. **Login**
   - Navigate to application URL
   - Use admin credentials

2. **Dashboard Overview**
   - View all employees and their shifts
   - Monitor shift statistics
   - Access administrative functions

3. **Create Shifts**
   - Click **"Create Shift"**
   - Select employee
   - Set start and end times
   - Submit to create

4. **Manage Shifts**
   - **Update:** Modify existing shift details
   - **Delete:** Remove shifts (soft delete with status change)
   - **View History:** Track shift modifications

5. **Employee Management**
   - View employee directory
   - Manage user roles
   - Monitor employee schedules

### For Employees

1. **Login**
   - Navigate to application URL
   - Use employee credentials

2. **View Shifts**
   - See assigned shifts
   - Check upcoming schedule
   - Review shift history

3. **Notifications**
   - Receive alerts for shift changes
   - View notification feed
   - Track important updates

---

## 🔌 API Documentation

### Servlet Endpoints

#### Authentication
- **POST** `/login` - User authentication
  - Parameters: `email`, `password`
  - Returns: Session with user object

- **GET** `/logout` - User logout
  - Clears session
  - Redirects to login page

- **POST** `/register` - New user registration
  - Parameters: `name`, `email`, `password`, `role`

#### Shift Management
- **POST** `/createShift` - Create new shift
  - Parameters: `employeeId`, `startTime`, `endTime`
  - Access: Admin only

- **POST** `/updateShift` - Update existing shift
  - Parameters: `shiftId`, `startTime`, `endTime`
  - Access: Admin only

- **POST** `/deleteShift` - Delete shift (soft delete)
  - Parameters: `shiftId`
  - Access: Admin only

---

## 📂 Project Structure

```
Rota-Core/
│
├── src/
│   └── main/
│       ├── java/
│       │   └── com/
│       │       └── shiftmanager/
│       │           ├── dao/                    # Data Access Objects
│       │           │   ├── NotificationDAO.java
│       │           │   ├── ShiftDAO.java
│       │           │   └── UserDAO.java
│       │           │
│       │           ├── model/                  # Entity Models
│       │           │   ├── Notification.java
│       │           │   ├── Shift.java
│       │           │   └── User.java
│       │           │
│       │           ├── servlet/                # Controllers
│       │           │   ├── AuthFilter.java
│       │           │   ├── CreateShiftServlet.java
│       │           │   ├── DeleteShiftServlet.java
│       │           │   ├── LoginServlet.java
│       │           │   ├── LogoutServlet.java
│       │           │   ├── RegisterServlet.java
│       │           │   └── UpdateShiftServlet.java
│       │           │
│       │           └── util/                   # Utilities
│       │               └── DBConnection.java
│       │
│       └── webapp/                             # Web Resources
│           ├── WEB-INF/
│           │   └── web.xml                     # Deployment Descriptor
│           │
│           ├── css/                            # Stylesheets
│           ├── js/                             # JavaScript
│           │
│           ├── admin.jsp                       # Admin Dashboard
│           ├── employee.jsp                    # Employee Dashboard
│           ├── index.jsp                       # Landing Page
│           ├── login.jsp                       # Login Page
│           ├── register.jsp                    # Registration Page
│           └── error.jsp                       # Error Page
│
├── build/                                      # Compiled Classes
├── db.sql                                      # Database Schema
├── .classpath                                  # Eclipse Classpath
├── .project                                    # Eclipse Project File
└── README.md                                   # This File
```

---

## 🔒 Security Considerations

### Implemented Security Measures

1. **Password Security**
   - SHA-256 hashing for password storage
   - No plain-text passwords in database

2. **Authentication Filter**
   - `AuthFilter.java` protects restricted pages
   - Session validation on every request
   - Automatic redirect to login for unauthorized access

3. **SQL Injection Prevention**
   - PreparedStatements for all database queries
   - Input validation and sanitization

4. **Role-Based Access Control**
   - Separate admin and employee roles
   - Permission checks before sensitive operations

### Security Best Practices (Recommended)

1. **Upgrade Password Hashing**
   ```java
   // Consider using BCrypt or Argon2 instead of SHA-256
   // SHA-256 is cryptographic but not designed for passwords
   ```

2. **Implement HTTPS**
   - Configure SSL/TLS certificates
   - Force HTTPS for all connections

3. **Session Security**
   - Configure session timeout
   - Implement CSRF tokens
   - Use secure and httpOnly cookies

4. **Input Validation**
   - Validate all user inputs on server-side
   - Implement CAPTCHA for registration/login
   - Rate limiting for API endpoints

5. **Database Security**
   - Use least-privilege database accounts
   - Enable MySQL SSL connections
   - Regular database backups

6. **Logging & Monitoring**
   - Implement comprehensive logging
   - Monitor for suspicious activities
   - Set up alerts for security events

---

## 🤝 Contributing

We welcome contributions to RotaCore! Follow these steps to contribute:

### Development Workflow

1. **Fork the Repository**
   ```bash
   git clone https://github.com/yourusername/RotaCore.git
   ```

2. **Create a Feature Branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

3. **Make Your Changes**
   - Follow Java coding conventions
   - Write meaningful commit messages
   - Add comments for complex logic

4. **Test Your Changes**
   - Ensure no existing functionality breaks
   - Test with different user roles
   - Verify database operations

5. **Commit and Push**
   ```bash
   git add .
   git commit -m "feat: add your feature description"
   git push origin feature/your-feature-name
   ```

6. **Submit Pull Request**
   - Provide detailed PR description
   - Reference related issues
   - Wait for code review

### Code Style Guidelines

- **Java Naming Conventions**
  - Classes: PascalCase (`UserDAO`)
  - Methods: camelCase (`getUserById()`)
  - Constants: UPPER_SNAKE_CASE (`MAX_LOGIN_ATTEMPTS`)

- **Code Documentation**
  - JavaDoc comments for all public methods
  - Inline comments for complex logic

- **Database**
  - Use snake_case for table and column names
  - Always define foreign key constraints

---

## 🐛 Troubleshooting

### Common Issues and Solutions

#### Issue 1: Database Connection Failed
```
Error: java.sql.SQLException: Access denied for user
```

**Solution:**
- Verify MySQL is running: `net start MySQL80`
- Check credentials in `DBConnection.java`
- Ensure database `shift_manager` exists
- Grant privileges: `GRANT ALL ON shift_manager.* TO 'user'@'localhost';`

---

#### Issue 2: Tomcat Deployment Error
```
Error: Failed to deploy application
```

**Solution:**
- Clean Tomcat work directory: `tomcat/work/Catalina/localhost/`
- Rebuild project: **Project → Clean**
- Check `web.xml` for syntax errors
- Verify servlet mappings

---

#### Issue 3: 404 Error on JSP Pages
```
HTTP Status 404 - Not Found
```

**Solution:**
- Check file paths in servlet redirects
- Verify JSP files are in `webapp/` directory
- Ensure context path is correct
- Review `web.xml` servlet mappings

---

#### Issue 4: Session Not Persisting
```
User logged out unexpectedly
```

**Solution:**
- Check `AuthFilter` configuration
- Verify session timeout settings in `web.xml`
- Ensure cookies are enabled in browser
- Review session handling in servlets

---

#### Issue 5: Password Hash Mismatch
```
Login failed with correct credentials
```

**Solution:**
- Verify password hashing algorithm matches (SHA-256)
- Check database password column length (64 chars for SHA-256)
- Re-insert admin user with correct hash:
  ```sql
  INSERT INTO users VALUES (NULL, 'Admin', 'admin@abhishek.com', SHA2('admin', 256), 'admin');
  ```

---

## 📊 Future Enhancements

### Planned Features
- [ ] RESTful API for mobile integration
- [ ] Email notifications for shift changes
- [ ] Calendar view for shift visualization
- [ ] Export shifts to PDF/Excel
- [ ] Shift swap requests between employees
- [ ] Multi-location support
- [ ] Advanced reporting and analytics
- [ ] Two-factor authentication (2FA)
- [ ] Dark mode UI theme
- [ ] Internationalization (i18n) support

---

## 📝 Changelog

### Version 1.0.0 (Current)
- Initial release
- Core shift management functionality
- Role-based access control
- Basic notification system
- Admin and employee dashboards

---

## 👥 Authors & Maintainers

- **Project Lead:** Suraj Kumar
- **Email:** [Your Email]
- **GitHub:** [@Suraj-kummar](https://github.com/Suraj-kummar)

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

```
MIT License

Copyright (c) 2026 Suraj Kumar

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
```

---

## 🙏 Acknowledgments

- Apache Software Foundation for Tomcat
- Oracle for MySQL
- Eclipse Foundation for IDE
- All contributors and testers

---

## 📞 Support

For support, please:
- Open an issue on GitHub: [Issues](https://github.com/Suraj-kummar/RotaCore/issues)
- Email: surajsinha1115@gmail.com
- Documentation: [Wiki](https://github.com/Suraj-kummar/RotaCore/wiki)

---

## 🌟 Show Your Support

If you find this project useful, please consider:
- ⭐ Starring the repository
- 🐛 Reporting bugs
- 💡 Suggesting new features
- 🤝 Contributing code

---

<div align="center">

**Made with ❤️ by Suraj Kumar**

[Website](https://yourwebsite.com) • [GitHub](https://github.com/Suraj-kummar) • [LinkedIn](www.linkedin.com/in/suraj-b85050222)

</div>

