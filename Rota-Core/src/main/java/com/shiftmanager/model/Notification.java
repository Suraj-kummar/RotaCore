package com.shiftmanager.model;

import java.sql.Timestamp;

public class Notification {
    private int id;
    private int employeeId;
    private String message;
    private Timestamp timestamp;

    // Constructors, getters, setters
    public Notification() {}
    public Notification(int employeeId, String message) {
        this.employeeId = employeeId;
        this.message = message;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getEmployeeId() { return employeeId; }
    public void setEmployeeId(int employeeId) { this.employeeId = employeeId; }
    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }
    public Timestamp getTimestamp() { return timestamp; }
    public void setTimestamp(Timestamp timestamp) { this.timestamp = timestamp; }
}