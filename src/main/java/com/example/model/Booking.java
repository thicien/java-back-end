package com.example.model;

import java.time.LocalDateTime;

public class Booking {
    private int bookingId;
    private int userId;
    private int busId;
    private String seatNumber;
    private LocalDateTime bookingDate;
    private double totalFare;
    private String status; // "confirmed", "cancelled"
    private String paymentStatus; // "pending", "completed"
    private String ticketNumber; // Unique ticket identifier

    public Booking() {}

    public Booking(int userId, int busId, String seatNumber, double totalFare) {
        this.userId = userId;
        this.busId = busId;
        this.seatNumber = seatNumber;
        this.totalFare = totalFare;
        this.status = "confirmed";
        this.paymentStatus = "pending";
    }

    // Getters and Setters
    public int getBookingId() { return bookingId; }
    public void setBookingId(int bookingId) { this.bookingId = bookingId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public int getBusId() { return busId; }
    public void setBusId(int busId) { this.busId = busId; }

    public String getSeatNumber() { return seatNumber; }
    public void setSeatNumber(String seatNumber) { this.seatNumber = seatNumber; }

    public LocalDateTime getBookingDate() { return bookingDate; }
    public void setBookingDate(LocalDateTime bookingDate) { this.bookingDate = bookingDate; }

    public double getTotalFare() { return totalFare; }
    public void setTotalFare(double totalFare) { this.totalFare = totalFare; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getPaymentStatus() { return paymentStatus; }
    public void setPaymentStatus(String paymentStatus) { this.paymentStatus = paymentStatus; }

    public String getTicketNumber() { return ticketNumber; }
    public void setTicketNumber(String ticketNumber) { this.ticketNumber = ticketNumber; }

    @Override
    public String toString() {
        return "Ticket{" +
                "bookingId=" + bookingId +
                ", userId=" + userId +
                ", busId=" + busId +
                ", seatNumber='" + seatNumber + '\'' +
                ", bookingDate=" + bookingDate +
                ", totalFare=" + totalFare +
                ", status='" + status + '\'' +
                ", paymentStatus='" + paymentStatus + '\'' +
                ", ticketNumber='" + ticketNumber + '\'' +
                '}';
    }
}
