package com.example.model;

import java.time.LocalDate;
import java.time.LocalTime;

public class Bus {
    private int busId;
    private String busName;
    private String busNumber;
    private String departureLocation;
    private String arrivalLocation;
    private LocalDate departureDate;
    private LocalTime departureTime;
    private double fare;
    private int totalSeats;
    private int availableSeats;
    private String busType;

    public Bus() {}

    public Bus(String busName, String busNumber, String departureLocation, String arrivalLocation,
               LocalDate departureDate, LocalTime departureTime, double fare,
               int totalSeats, int availableSeats, String busType) {
        this.busName = busName;
        this.busNumber = busNumber;
        this.departureLocation = departureLocation;
        this.arrivalLocation = arrivalLocation;
        this.departureDate = departureDate;
        this.departureTime = departureTime;
        this.fare = fare;
        this.totalSeats = totalSeats;
        this.availableSeats = availableSeats;
        this.busType = busType;
    }

    // Getters and Setters
    public int getBusId() { return busId; }
    public void setBusId(int busId) { this.busId = busId; }

    public String getBusName() { return busName; }
    public void setBusName(String busName) { this.busName = busName; }

    public String getBusNumber() { return busNumber; }
    public void setBusNumber(String busNumber) { this.busNumber = busNumber; }

    public String getDepartureLocation() { return departureLocation; }
    public void setDepartureLocation(String departureLocation) { this.departureLocation = departureLocation; }

    public String getArrivalLocation() { return arrivalLocation; }
    public void setArrivalLocation(String arrivalLocation) { this.arrivalLocation = arrivalLocation; }

    public LocalDate getDepartureDate() { return departureDate; }
    public void setDepartureDate(LocalDate departureDate) { this.departureDate = departureDate; }

    public LocalTime getDepartureTime() { return departureTime; }
    public void setDepartureTime(LocalTime departureTime) { this.departureTime = departureTime; }

    public double getFare() { return fare; }
    public void setFare(double fare) { this.fare = fare; }

    public int getTotalSeats() { return totalSeats; }
    public void setTotalSeats(int totalSeats) { this.totalSeats = totalSeats; }

    public int getAvailableSeats() { return availableSeats; }
    public void setAvailableSeats(int availableSeats) { this.availableSeats = availableSeats; }

    public String getBusType() { return busType; }
    public void setBusType(String busType) { this.busType = busType; }

    @Override
    public String toString() {
        return "Bus{" +
                "busId=" + busId +
                ", busName='" + busName + '\'' +
                ", departureLocation='" + departureLocation + '\'' +
                ", arrivalLocation='" + arrivalLocation + '\'' +
                ", departureDate=" + departureDate +
                ", departureTime=" + departureTime +
                ", fare=" + fare +
                ", availableSeats=" + availableSeats + '/' + totalSeats +
                '}';
    }
}
