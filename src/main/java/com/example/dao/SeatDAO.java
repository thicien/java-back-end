package com.example.dao;

import com.example.model.Seat;
import com.example.util.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SeatDAO {
    /**
     * Get all seats for a bus
     */
    public List<Seat> getSeatsByBusId(int busId) {
        List<Seat> seats = new ArrayList<>();
        String query = "SELECT * FROM seats WHERE bus_id = ? ORDER BY seat_number";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, busId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Seat seat = new Seat();
                seat.setSeatId(rs.getInt("seat_id"));
                seat.setBusId(rs.getInt("bus_id"));
                seat.setSeatNumber(rs.getString("seat_number"));
                seat.setStatus(rs.getString("status"));
                seats.add(seat);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return seats;
    }

    /**
     * Check if seat is available
     */
    public boolean isSeatAvailable(int busId, String seatNumber) {
        String query = "SELECT status FROM seats WHERE bus_id = ? AND seat_number = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, busId);
            stmt.setString(2, seatNumber);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return "available".equalsIgnoreCase(rs.getString("status"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Book a seat
     */
    public boolean bookSeat(int busId, String seatNumber) {
        String query = "UPDATE seats SET status = 'booked' WHERE bus_id = ? AND seat_number = ? AND status = 'available'";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, busId);
            stmt.setString(2, seatNumber);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Cancel a seat booking
     */
    public boolean cancelSeat(int busId, String seatNumber) {
        String query = "UPDATE seats SET status = 'available' WHERE bus_id = ? AND seat_number = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, busId);
            stmt.setString(2, seatNumber);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
