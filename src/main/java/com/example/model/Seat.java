package com.example.model;

public class Seat {
    private int seatId;
    private int busId;
    private String seatNumber;
    private String status; // "available" or "booked"

    public Seat() {}

    public Seat(int busId, String seatNumber, String status) {
        this.busId = busId;
        this.seatNumber = seatNumber;
        this.status = status;
    }

    // Getters and Setters
    public int getSeatId() { return seatId; }
    public void setSeatId(int seatId) { this.seatId = seatId; }

    public int getBusId() { return busId; }
    public void setBusId(int busId) { this.busId = busId; }

    public String getSeatNumber() { return seatNumber; }
    public void setSeatNumber(String seatNumber) { this.seatNumber = seatNumber; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public boolean isAvailable() {
        return "available".equalsIgnoreCase(status);
    }

    @Override
    public String toString() {
        return "Seat{" +
                "seatId=" + seatId +
                ", busId=" + busId +
                ", seatNumber='" + seatNumber + '\'' +
                ", status='" + status + '\'' +
                '}';
    }
}
