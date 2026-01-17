package com.example.dao;

import com.example.model.Bus;
import com.example.util.DatabaseConnection;
import java.sql.*;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

public class BusDAO {
    /**
     * Get all buses
     */
    public List<Bus> getAllBuses() {
        List<Bus> buses = new ArrayList<>();
        String query = "SELECT * FROM buses ORDER BY departure_date, departure_time";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Bus bus = new Bus();
                bus.setBusId(rs.getInt("bus_id"));
                bus.setBusName(rs.getString("bus_name"));
                bus.setBusNumber(rs.getString("bus_number"));
                bus.setDepartureLocation(rs.getString("departure_location"));
                bus.setArrivalLocation(rs.getString("arrival_location"));
                bus.setDepartureDate(rs.getDate("departure_date").toLocalDate());
                bus.setDepartureTime(rs.getTime("departure_time").toLocalTime());
                bus.setFare(rs.getDouble("fare"));
                bus.setTotalSeats(rs.getInt("total_seats"));
                bus.setAvailableSeats(rs.getInt("available_seats"));
                bus.setBusType(rs.getString("bus_type"));
                buses.add(bus);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return buses;
    }

    /**
     * Search buses by departure and arrival locations and date
     */
    public List<Bus> searchBuses(String departure, String arrival, String date) {
        List<Bus> buses = new ArrayList<>();
        StringBuilder query = new StringBuilder("SELECT * FROM buses WHERE 1=1");

        if (departure != null && !departure.isEmpty()) {
            query.append(" AND departure_location LIKE ?");
        }
        if (arrival != null && !arrival.isEmpty()) {
            query.append(" AND arrival_location LIKE ?");
        }
        if (date != null && !date.isEmpty()) {
            query.append(" AND DATE(departure_date) = ?");
        }
        query.append(" ORDER BY departure_time");

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query.toString())) {

            int paramIndex = 1;
            if (departure != null && !departure.isEmpty()) {
                stmt.setString(paramIndex++, "%" + departure + "%");
            }
            if (arrival != null && !arrival.isEmpty()) {
                stmt.setString(paramIndex++, "%" + arrival + "%");
            }
            if (date != null && !date.isEmpty()) {
                stmt.setString(paramIndex++, date);
            }

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Bus bus = new Bus();
                bus.setBusId(rs.getInt("bus_id"));
                bus.setBusName(rs.getString("bus_name"));
                bus.setBusNumber(rs.getString("bus_number"));
                bus.setDepartureLocation(rs.getString("departure_location"));
                bus.setArrivalLocation(rs.getString("arrival_location"));
                bus.setDepartureDate(rs.getDate("departure_date").toLocalDate());
                bus.setDepartureTime(rs.getTime("departure_time").toLocalTime());
                bus.setFare(rs.getDouble("fare"));
                bus.setTotalSeats(rs.getInt("total_seats"));
                bus.setAvailableSeats(rs.getInt("available_seats"));
                bus.setBusType(rs.getString("bus_type"));
                buses.add(bus);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return buses;
    }

    /**
     * Get bus by ID
     */
    public Bus getBusById(int busId) {
        String query = "SELECT * FROM buses WHERE bus_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, busId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Bus bus = new Bus();
                bus.setBusId(rs.getInt("bus_id"));
                bus.setBusName(rs.getString("bus_name"));
                bus.setBusNumber(rs.getString("bus_number"));
                bus.setDepartureLocation(rs.getString("departure_location"));
                bus.setArrivalLocation(rs.getString("arrival_location"));
                bus.setDepartureDate(rs.getDate("departure_date").toLocalDate());
                bus.setDepartureTime(rs.getTime("departure_time").toLocalTime());
                bus.setFare(rs.getDouble("fare"));
                bus.setTotalSeats(rs.getInt("total_seats"));
                bus.setAvailableSeats(rs.getInt("available_seats"));
                bus.setBusType(rs.getString("bus_type"));
                return bus;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
