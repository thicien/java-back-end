package com.example.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class DatabaseConnection {
    // H2 Embedded Database
    private static final String DB_URL = "jdbc:h2:mem:bus_ticket_booking;MODE=MySQL;DB_CLOSE_DELAY=-1;DB_CLOSE_ON_EXIT=FALSE";
    private static final String DB_USER = "sa";
    private static final String DB_PASSWORD = "";
    private static boolean initialized = false;

    static {
        try {
            Class.forName("org.h2.Driver");
            initializeDatabase();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    private static synchronized void initializeDatabase() throws SQLException {
        if (initialized) return;
        
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             Statement stmt = conn.createStatement()) {
            
            // Create Users Table
            stmt.execute("CREATE TABLE IF NOT EXISTS users (" +
                    "user_id INT PRIMARY KEY AUTO_INCREMENT," +
                    "full_name VARCHAR(100) NOT NULL," +
                    "email VARCHAR(100) UNIQUE NOT NULL," +
                    "password VARCHAR(255) NOT NULL," +
                    "phone VARCHAR(15)," +
                    "created_at DATETIME DEFAULT CURRENT_TIMESTAMP" +
                    ")");

            // Create Buses Table
            stmt.execute("CREATE TABLE IF NOT EXISTS buses (" +
                    "bus_id INT PRIMARY KEY AUTO_INCREMENT," +
                    "bus_name VARCHAR(100) NOT NULL," +
                    "bus_number VARCHAR(20) UNIQUE NOT NULL," +
                    "departure_location VARCHAR(100) NOT NULL," +
                    "arrival_location VARCHAR(100) NOT NULL," +
                    "departure_date DATE NOT NULL," +
                    "departure_time TIME NOT NULL," +
                    "fare DECIMAL(10, 2) NOT NULL," +
                    "total_seats INT NOT NULL," +
                    "available_seats INT NOT NULL," +
                    "bus_type VARCHAR(50)," +
                    "created_at DATETIME DEFAULT CURRENT_TIMESTAMP" +
                    ")");

            // Create Seats Table
            stmt.execute("CREATE TABLE IF NOT EXISTS seats (" +
                    "seat_id INT PRIMARY KEY AUTO_INCREMENT," +
                    "bus_id INT NOT NULL," +
                    "seat_number VARCHAR(10) NOT NULL," +
                    "status VARCHAR(20) NOT NULL DEFAULT 'available'," +
                    "FOREIGN KEY (bus_id) REFERENCES buses(bus_id) ON DELETE CASCADE," +
                    "UNIQUE(bus_id, seat_number)" +
                    ")");

            // Create Bookings Table
            stmt.execute("CREATE TABLE IF NOT EXISTS bookings (" +
                    "booking_id INT PRIMARY KEY AUTO_INCREMENT," +
                    "user_id INT NOT NULL," +
                    "bus_id INT NOT NULL," +
                    "seat_number VARCHAR(10) NOT NULL," +
                    "booking_date DATETIME DEFAULT CURRENT_TIMESTAMP," +
                    "total_fare DECIMAL(10, 2) NOT NULL," +
                    "status VARCHAR(20) NOT NULL DEFAULT 'confirmed'," +
                    "payment_status VARCHAR(20) NOT NULL DEFAULT 'pending'," +
                    "ticket_number VARCHAR(20) UNIQUE," +
                    "FOREIGN KEY (user_id) REFERENCES users(user_id)," +
                    "FOREIGN KEY (bus_id) REFERENCES buses(bus_id)" +
                    ")");

            // Insert sample bus data
            stmt.execute("INSERT INTO buses (bus_name, bus_number, departure_location, arrival_location, departure_date, departure_time, fare, total_seats, available_seats, bus_type) " +
                    "SELECT 'Express Travel', 'BUS001', 'New York', 'Boston', '2026-01-15', '08:00:00', 45.00, 42, 42, 'AC Sleeper' " +
                    "WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number = 'BUS001')");
            
            stmt.execute("INSERT INTO buses (bus_name, bus_number, departure_location, arrival_location, departure_date, departure_time, fare, total_seats, available_seats, bus_type) " +
                    "SELECT 'Quick Ride', 'BUS002', 'New York', 'Philadelphia', '2026-01-15', '10:30:00', 35.00, 50, 50, 'AC Seater' " +
                    "WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number = 'BUS002')");
            
            stmt.execute("INSERT INTO buses (bus_name, bus_number, departure_location, arrival_location, departure_date, departure_time, fare, total_seats, available_seats, bus_type) " +
                    "SELECT 'Comfort Journey', 'BUS003', 'Boston', 'New York', '2026-01-15', '14:00:00', 45.00, 42, 42, 'AC Sleeper' " +
                    "WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number = 'BUS003')");
            
            stmt.execute("INSERT INTO buses (bus_name, bus_number, departure_location, arrival_location, departure_date, departure_time, fare, total_seats, available_seats, bus_type) " +
                    "SELECT 'Speed Bus', 'BUS004', 'Philadelphia', 'Washington DC', '2026-01-15', '06:00:00', 40.00, 50, 50, 'AC Seater' " +
                    "WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number = 'BUS004')");
            
            stmt.execute("INSERT INTO buses (bus_name, bus_number, departure_location, arrival_location, departure_date, departure_time, fare, total_seats, available_seats, bus_type) " +
                    "SELECT 'Royal Tours', 'BUS005', 'New York', 'Washington DC', '2026-01-16', '09:00:00', 55.00, 42, 42, 'AC Sleeper' " +
                    "WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number = 'BUS005')");
            
            stmt.execute("INSERT INTO buses (bus_name, bus_number, departure_location, arrival_location, departure_date, departure_time, fare, total_seats, available_seats, bus_type) " +
                    "SELECT 'City Express', 'BUS006', 'Boston', 'Philadelphia', '2026-01-16', '11:00:00', 38.00, 50, 50, 'AC Seater' " +
                    "WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number = 'BUS006')");

            initialized = true;
            System.out.println("Database initialized successfully with H2");
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }
}
