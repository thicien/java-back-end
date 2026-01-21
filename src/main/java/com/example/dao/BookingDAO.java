package com.example.dao;

import com.example.model.Booking;
import com.example.util.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {
    public int createBooking(Booking booking) {
        String query = "INSERT INTO bookings (user_id, bus_id, seat_number, total_fare, status, payment_status, ticket_number) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setInt(1, booking.getUserId());
            stmt.setInt(2, booking.getBusId());
            stmt.setString(3, booking.getSeatNumber());
            stmt.setDouble(4, booking.getTotalFare());
            stmt.setString(5, booking.getStatus());
            stmt.setString(6, booking.getPaymentStatus());
            stmt.setString(7, booking.getTicketNumber());

            if (stmt.executeUpdate() > 0) {
                ResultSet rs = stmt.getGeneratedKeys();
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }


    public List<Booking> getBookingsByUserId(int userId) {
        List<Booking> bookings = new ArrayList<>();
        String query = "SELECT * FROM bookings WHERE user_id = ? ORDER BY booking_date DESC";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Booking booking = new Booking();
                booking.setBookingId(rs.getInt("booking_id"));
                booking.setUserId(rs.getInt("user_id"));
                booking.setBusId(rs.getInt("bus_id"));
                booking.setSeatNumber(rs.getString("seat_number"));
                booking.setBookingDate(rs.getTimestamp("booking_date").toLocalDateTime());
                booking.setTotalFare(rs.getDouble("total_fare"));
                booking.setStatus(rs.getString("status"));
                booking.setPaymentStatus(rs.getString("payment_status"));
                booking.setTicketNumber(rs.getString("ticket_number"));
                bookings.add(booking);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookings;
    }

    public Booking getBookingById(int bookingId) {
        String query = "SELECT * FROM bookings WHERE booking_id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, bookingId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Booking booking = new Booking();
                booking.setBookingId(rs.getInt("booking_id"));
                booking.setUserId(rs.getInt("user_id"));
                booking.setBusId(rs.getInt("bus_id"));
                booking.setSeatNumber(rs.getString("seat_number"));
                booking.setBookingDate(rs.getTimestamp("booking_date").toLocalDateTime());
                booking.setTotalFare(rs.getDouble("total_fare"));
                booking.setStatus(rs.getString("status"));
                booking.setPaymentStatus(rs.getString("payment_status"));
                booking.setTicketNumber(rs.getString("ticket_number"));
                return booking;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updatePaymentStatus(int bookingId, String paymentStatus) {
        String query = "UPDATE bookings SET payment_status = ? WHERE booking_id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, paymentStatus);
            stmt.setInt(2, bookingId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean cancelBooking(int bookingId) {
        String query = "UPDATE bookings SET status = 'cancelled' WHERE booking_id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, bookingId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
