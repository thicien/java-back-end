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

            // Create Cars Table for Used Cars Marketplace
            stmt.execute("CREATE TABLE IF NOT EXISTS cars (" +
                    "car_id INT PRIMARY KEY AUTO_INCREMENT," +
                    "brand VARCHAR(100) NOT NULL," +
                    "model VARCHAR(100) NOT NULL," +
                    "launch_year INT NOT NULL," +
                    "price DECIMAL(10, 2) NOT NULL," +
                    "mileage INT NOT NULL," +
                    "engine_type VARCHAR(50) NOT NULL," +
                    "condition VARCHAR(50) NOT NULL," +
                    "description TEXT," +
                    "created_at DATETIME DEFAULT CURRENT_TIMESTAMP" +
                    ")");

            // Insert sample car data
            stmt.execute("INSERT INTO cars (brand, model, launch_year, price, mileage, engine_type, condition, description) " +
                    "SELECT 'Toyota', 'Camry', 2020, 22000.00, 45000, 'Petrol', 'Excellent', 'Well-maintained Toyota Camry with full service history. Excellent condition.' " +
                    "WHERE NOT EXISTS (SELECT 1 FROM cars WHERE brand = 'Toyota' AND model = 'Camry')");
            
            stmt.execute("INSERT INTO cars (brand, model, launch_year, price, mileage, engine_type, condition, description) " +
                    "SELECT 'Honda', 'Civic', 2019, 18500.00, 52000, 'Petrol', 'Good', 'Reliable Honda Civic with great fuel efficiency. Recently serviced.' " +
                    "WHERE NOT EXISTS (SELECT 1 FROM cars WHERE brand = 'Honda' AND model = 'Civic')");
            
            stmt.execute("INSERT INTO cars (brand, model, launch_year, price, mileage, engine_type, condition, description) " +
                    "SELECT 'Hyundai', 'Elantra', 2021, 19500.00, 35000, 'Petrol', 'Excellent', 'Latest model Hyundai Elantra with modern features and excellent condition.' " +
                    "WHERE NOT EXISTS (SELECT 1 FROM cars WHERE brand = 'Hyundai' AND model = 'Elantra')");
            
            stmt.execute("INSERT INTO cars (brand, model, launch_year, price, mileage, engine_type, condition, description) " +
                    "SELECT 'Mazda', 'Mazda3', 2020, 21000.00, 40000, 'Petrol', 'Good', 'Sporty Mazda3 with great handling and performance. Well maintained.' " +
                    "WHERE NOT EXISTS (SELECT 1 FROM cars WHERE brand = 'Mazda' AND model = 'Mazda3')");
            
            stmt.execute("INSERT INTO cars (brand, model, launch_year, price, mileage, engine_type, condition, description) " +
                    "SELECT 'Nissan', 'Altima', 2018, 17000.00, 65000, 'Petrol', 'Fair', 'Budget-friendly Nissan Altima. Mechanically sound with minor cosmetic issues.' " +
                    "WHERE NOT EXISTS (SELECT 1 FROM cars WHERE brand = 'Nissan' AND model = 'Altima')");
            
            stmt.execute("INSERT INTO cars (brand, model, launch_year, price, mileage, engine_type, condition, description) " +
                    "SELECT 'Ford', 'Focus', 2019, 16500.00, 55000, 'Diesel', 'Good', 'Efficient Ford Focus with low fuel consumption. Great for long drives.' " +
                    "WHERE NOT EXISTS (SELECT 1 FROM cars WHERE brand = 'Ford' AND model = 'Focus')");
            
            stmt.execute("INSERT INTO cars (brand, model, launch_year, price, mileage, engine_type, condition, description) " +
                    "SELECT 'Volkswagen', 'Golf', 2021, 23000.00, 28000, 'Petrol', 'Excellent', 'Premium VW Golf with all modern amenities and excellent condition.' " +
                    "WHERE NOT EXISTS (SELECT 1 FROM cars WHERE brand = 'Volkswagen' AND model = 'Golf')");
            
            stmt.execute("INSERT INTO cars (brand, model, launch_year, price, mileage, engine_type, condition, description) " +
                    "SELECT 'Kia', 'Cerato', 2020, 19000.00, 42000, 'Petrol', 'Good', 'Reliable Kia Cerato with great warranty and fuel efficiency.' " +
                    "WHERE NOT EXISTS (SELECT 1 FROM cars WHERE brand = 'Kia' AND model = 'Cerato')");


            // Insert sample bus data
            stmt.execute("INSERT INTO buses (bus_name, bus_number, departure_location, arrival_location, departure_date, departure_time, fare, total_seats, available_seats, bus_type) " +
                    "SELECT 'Royal Galactic Sleeper', 'BUS001', 'New York', 'Boston', '2026-01-17', '20:00:00', 65.00, 42, 38, 'AC Sleeper (2+1)' " +
                    "WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number = 'BUS001')");
            
            stmt.execute("INSERT INTO buses (bus_name, bus_number, departure_location, arrival_location, departure_date, departure_time, fare, total_seats, available_seats, bus_type) " +
                    "SELECT 'Intercity Express', 'BUS002', 'New York', 'Philadelphia', '2026-01-17', '08:30:00', 40.00, 50, 45, 'Semi-Sleeper Luxury' " +
                    "WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number = 'BUS002')");
            
            stmt.execute("INSERT INTO buses (bus_name, bus_number, departure_location, arrival_location, departure_date, departure_time, fare, total_seats, available_seats, bus_type) " +
                    "SELECT 'Mountain Voyager', 'BUS003', 'Boston', 'New York', '2026-01-18', '06:15:00', 25.00, 45, 40, 'Non-AC High Deck' " +
                    "WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number = 'BUS003')");
            
            stmt.execute("INSERT INTO buses (bus_name, bus_number, departure_location, arrival_location, departure_date, departure_time, fare, total_seats, available_seats, bus_type) " +
                    "SELECT 'Coastline Premium', 'BUS004', 'Philadelphia', 'Washington DC', '2026-01-18', '22:00:00', 55.00, 50, 42, 'Multi-Axle Scania AC' " +
                    "WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number = 'BUS004')");
            
            stmt.execute("INSERT INTO buses (bus_name, bus_number, departure_location, arrival_location, departure_date, departure_time, fare, total_seats, available_seats, bus_type) " +
                    "SELECT 'City Shuttle Pro', 'BUS005', 'New York', 'Washington DC', '2026-01-19', '09:00:00', 18.00, 50, 48, 'Electric Eco-Bus' " +
                    "WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number = 'BUS005')");
            
            stmt.execute("INSERT INTO buses (bus_name, bus_number, departure_location, arrival_location, departure_date, departure_time, fare, total_seats, available_seats, bus_type) " +
                    "SELECT 'Sunset Wanderer', 'BUS006', 'Boston', 'Philadelphia', '2026-01-20', '17:45:00', 48.00, 50, 46, 'Executive Class AC' " +
                    "WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number = 'BUS006')");

            initialized = true;
            System.out.println("Database initialized successfully with H2");
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }
}
