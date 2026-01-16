-- Bus Ticket Booking System Database Schema
-- Create database
CREATE DATABASE IF NOT EXISTS bus_ticket_booking;
USE bus_ticket_booking;

-- Users Table
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(15),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Buses Table
CREATE TABLE buses (
    bus_id INT PRIMARY KEY AUTO_INCREMENT,
    bus_name VARCHAR(100) NOT NULL,
    bus_number VARCHAR(20) UNIQUE NOT NULL,
    departure_location VARCHAR(100) NOT NULL,
    arrival_location VARCHAR(100) NOT NULL,
    departure_date DATE NOT NULL,
    departure_time TIME NOT NULL,
    fare DECIMAL(10, 2) NOT NULL,
    total_seats INT NOT NULL,
    available_seats INT NOT NULL,
    bus_type VARCHAR(50),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Seats Table
CREATE TABLE seats (
    seat_id INT PRIMARY KEY AUTO_INCREMENT,
    bus_id INT NOT NULL,
    seat_number VARCHAR(10) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'available',
    FOREIGN KEY (bus_id) REFERENCES buses(bus_id) ON DELETE CASCADE,
    UNIQUE KEY unique_seat (bus_id, seat_number)
);

-- Bookings (Tickets) Table
CREATE TABLE bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    bus_id INT NOT NULL,
    seat_number VARCHAR(10) NOT NULL,
    booking_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    total_fare DECIMAL(10, 2) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'confirmed',
    payment_status VARCHAR(20) NOT NULL DEFAULT 'pending',
    ticket_number VARCHAR(20) UNIQUE,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (bus_id) REFERENCES buses(bus_id)
);

-- Sample Bus Data
INSERT INTO buses (bus_name, bus_number, departure_location, arrival_location, departure_date, departure_time, fare, total_seats, available_seats, bus_type) VALUES
('Express Travel', 'BUS001', 'New York', 'Boston', '2026-01-15', '08:00:00', 45.00, 42, 42, 'AC Sleeper'),
('Quick Ride', 'BUS002', 'New York', 'Philadelphia', '2026-01-15', '10:30:00', 35.00, 50, 50, 'AC Seater'),
('Comfort Journey', 'BUS003', 'Boston', 'New York', '2026-01-15', '14:00:00', 45.00, 42, 42, 'AC Sleeper'),
('Speed Bus', 'BUS004', 'Philadelphia', 'Washington DC', '2026-01-15', '06:00:00', 40.00, 50, 50, 'AC Seater'),
('Royal Tours', 'BUS005', 'New York', 'Washington DC', '2026-01-16', '09:00:00', 55.00, 42, 42, 'AC Sleeper'),
('City Express', 'BUS006', 'Boston', 'Philadelphia', '2026-01-16', '11:00:00', 38.00, 50, 50, 'AC Seater');
