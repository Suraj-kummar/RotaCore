package com.rotacore.model;

import java.sql.Timestamp;

public class Shift {
    private int id;
    private int employeeId;
    private Timestamp startTime;
    private Timestamp endTime;
    private String status;

    // Constructors, getters, setters
    public Shift() {
    }

    public Shift(int employeeId, Timestamp startTime, Timestamp endTime, String status) {
        this.employeeId = employeeId;
        this.startTime = startTime;
        this.endTime = endTime;
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getEmployeeId() {
        return employeeId;
    }

    public void setEmployeeId(int employeeId) {
        this.employeeId = employeeId;
    }

    public Timestamp getStartTime() {
        return startTime;
    }

    public void setStartTime(Timestamp startTime) {
        this.startTime = startTime;
    }

    public Timestamp getEndTime() {
        return endTime;
    }

    public void setEndTime(Timestamp endTime) {
        this.endTime = endTime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}