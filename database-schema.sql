-- Bus Ticket Booking System & Used Cars Marketplace Database Schema
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

-- Cars Table for Used Cars Marketplace
CREATE TABLE IF NOT EXISTS cars (
    car_id INT PRIMARY KEY AUTO_INCREMENT,
    brand VARCHAR(100) NOT NULL,
    model VARCHAR(100) NOT NULL,
    launch_year INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    mileage INT NOT NULL,
    engine_type VARCHAR(50) NOT NULL,
    condition VARCHAR(50) NOT NULL,
    description TEXT,
    image_url VARCHAR(500),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Sample Car Data for Used Cars Marketplace
INSERT INTO cars (brand, model, launch_year, price, mileage, engine_type, condition, description, image_url) VALUES
('Toyota', 'Camry', 2020, 22000.00, 45000, 'Petrol', 'Excellent', 'Well-maintained Toyota Camry with full service history. Excellent condition.', 'https://images.unsplash.com/photo-1552820728-8ac41f1ce891?auto=format&fit=crop&q=80&w=600'),
('Honda', 'Civic', 2019, 18500.00, 52000, 'Petrol', 'Good', 'Reliable Honda Civic with great fuel efficiency. Recently serviced.', 'https://images.unsplash.com/photo-1609708536965-bc6e90a279ba?auto=format&fit=crop&q=80&w=600'),
('Hyundai', 'Elantra', 2021, 19500.00, 35000, 'Petrol', 'Excellent', 'Latest model Hyundai Elantra with modern features and excellent condition.', 'https://images.unsplash.com/photo-1554744512-d2c5c7da7dc8?auto=format&fit=crop&q=80&w=600'),
('Mazda', 'Mazda3', 2020, 21000.00, 40000, 'Petrol', 'Good', 'Sporty Mazda3 with great handling and performance. Well maintained.', 'https://images.unsplash.com/photo-1559056169-641ef7e3b404?auto=format&fit=crop&q=80&w=600'),
('Nissan', 'Altima', 2018, 17000.00, 65000, 'Petrol', 'Fair', 'Budget-friendly Nissan Altima. Mechanically sound with minor cosmetic issues.', 'https://images.unsplash.com/photo-1517524008697-20bcc1f72e16?auto=format&fit=crop&q=80&w=600'),
('Ford', 'Focus', 2019, 16500.00, 55000, 'Diesel', 'Good', 'Efficient Ford Focus with low fuel consumption. Great for long drives.', 'https://images.unsplash.com/photo-1533473359331-0135ef1b58bf?auto=format&fit=crop&q=80&w=600'),
('Volkswagen', 'Golf', 2021, 23000.00, 28000, 'Petrol', 'Excellent', 'Premium VW Golf with all modern amenities and excellent condition.', 'https://images.unsplash.com/photo-1552272412-c1ca2c9c2934?auto=format&fit=crop&q=80&w=600'),
('Kia', 'Cerato', 2020, 19000.00, 42000, 'Petrol', 'Good', 'Reliable Kia Cerato with great warranty and fuel efficiency.', 'https://images.unsplash.com/photo-1571868552521-9b24ce49f1d1?auto=format&fit=crop&q=80&w=600');

-- Sample Bus Data
INSERT INTO buses (bus_name, bus_number, departure_location, arrival_location, departure_date, departure_time, fare, total_seats, available_seats, bus_type) VALUES
('Express Travel', 'BUS001', 'New York', 'Boston', '2026-01-15', '08:00:00', 45.00, 42, 42, 'AC Sleeper'),
('Quick Ride', 'BUS002', 'New York', 'Philadelphia', '2026-01-15', '10:30:00', 35.00, 50, 50, 'AC Seater'),
('Comfort Journey', 'BUS003', 'Boston', 'New York', '2026-01-15', '14:00:00', 45.00, 42, 42, 'AC Sleeper'),
('Speed Bus', 'BUS004', 'Philadelphia', 'Washington DC', '2026-01-15', '06:00:00', 40.00, 50, 50, 'AC Seater'),
('Royal Tours', 'BUS005', 'New York', 'Washington DC', '2026-01-16', '09:00:00', 55.00, 42, 42, 'AC Sleeper'),
('City Express', 'BUS006', 'Boston', 'Philadelphia', '2026-01-16', '11:00:00', 38.00, 50, 50, 'AC Seater'),
('Royal Galactic Sleeper', 'BUS007', 'New York', 'Boston', '2026-01-17', '20:00:00', 65.00, 42, 42, 'AC Sleeper'),
('Galaxy Traveler', 'BUS008', 'Boston', 'Washington DC', '2026-01-17', '15:00:00', 50.00, 50, 50, 'AC Seater'),
('Cosmic Express', 'BUS009', 'New York', 'Philadelphia', '2026-01-18', '09:30:00', 40.00, 42, 42, 'AC Sleeper'),
('Star Route', 'BUS010', 'Washington DC', 'New York', '2026-01-18', '11:00:00', 60.00, 50, 50, 'AC Seater');

-- Generate Seats for Bus 1 (BUS001) - 42 seats
INSERT INTO seats (bus_id, seat_number, status) VALUES
(1, 'A1', 'available'), (1, 'A2', 'available'), (1, 'A3', 'available'), (1, 'A4', 'available'), (1, 'A5', 'available'), (1, 'A6', 'available'),
(1, 'B1', 'available'), (1, 'B2', 'available'), (1, 'B3', 'available'), (1, 'B4', 'available'), (1, 'B5', 'available'), (1, 'B6', 'available'),
(1, 'C1', 'available'), (1, 'C2', 'available'), (1, 'C3', 'available'), (1, 'C4', 'available'), (1, 'C5', 'available'), (1, 'C6', 'available'),
(1, 'D1', 'available'), (1, 'D2', 'available'), (1, 'D3', 'available'), (1, 'D4', 'available'), (1, 'D5', 'available'), (1, 'D6', 'available'),
(1, 'E1', 'available'), (1, 'E2', 'available'), (1, 'E3', 'available'), (1, 'E4', 'available'), (1, 'E5', 'available'), (1, 'E6', 'available'),
(1, 'F1', 'available'), (1, 'F2', 'available'), (1, 'F3', 'available'), (1, 'F4', 'available'), (1, 'F5', 'available'), (1, 'F6', 'available'),
(1, 'G1', 'available'), (1, 'G2', 'available'), (1, 'G3', 'available'), (1, 'G4', 'available'), (1, 'G5', 'available'), (1, 'G6', 'available');

-- Generate Seats for Bus 2 (BUS002) - 50 seats
INSERT INTO seats (bus_id, seat_number, status) VALUES
(2, 'A1', 'available'), (2, 'A2', 'available'), (2, 'A3', 'available'), (2, 'A4', 'available'), (2, 'A5', 'available'),
(2, 'B1', 'available'), (2, 'B2', 'available'), (2, 'B3', 'available'), (2, 'B4', 'available'), (2, 'B5', 'available'),
(2, 'C1', 'available'), (2, 'C2', 'available'), (2, 'C3', 'available'), (2, 'C4', 'available'), (2, 'C5', 'available'),
(2, 'D1', 'available'), (2, 'D2', 'available'), (2, 'D3', 'available'), (2, 'D4', 'available'), (2, 'D5', 'available'),
(2, 'E1', 'available'), (2, 'E2', 'available'), (2, 'E3', 'available'), (2, 'E4', 'available'), (2, 'E5', 'available'),
(2, 'F1', 'available'), (2, 'F2', 'available'), (2, 'F3', 'available'), (2, 'F4', 'available'), (2, 'F5', 'available'),
(2, 'G1', 'available'), (2, 'G2', 'available'), (2, 'G3', 'available'), (2, 'G4', 'available'), (2, 'G5', 'available'),
(2, 'H1', 'available'), (2, 'H2', 'available'), (2, 'H3', 'available'), (2, 'H4', 'available'), (2, 'H5', 'available'),
(2, 'I1', 'available'), (2, 'I2', 'available'), (2, 'I3', 'available'), (2, 'I4', 'available'), (2, 'I5', 'available'),
(2, 'J1', 'available'), (2, 'J2', 'available'), (2, 'J3', 'available'), (2, 'J4', 'available'), (2, 'J5', 'available');

-- Generate Seats for Bus 3 (BUS003) - 42 seats
INSERT INTO seats (bus_id, seat_number, status) VALUES
(3, 'A1', 'available'), (3, 'A2', 'available'), (3, 'A3', 'available'), (3, 'A4', 'available'), (3, 'A5', 'available'), (3, 'A6', 'available'),
(3, 'B1', 'available'), (3, 'B2', 'available'), (3, 'B3', 'available'), (3, 'B4', 'available'), (3, 'B5', 'available'), (3, 'B6', 'available'),
(3, 'C1', 'available'), (3, 'C2', 'available'), (3, 'C3', 'available'), (3, 'C4', 'available'), (3, 'C5', 'available'), (3, 'C6', 'available'),
(3, 'D1', 'available'), (3, 'D2', 'available'), (3, 'D3', 'available'), (3, 'D4', 'available'), (3, 'D5', 'available'), (3, 'D6', 'available'),
(3, 'E1', 'available'), (3, 'E2', 'available'), (3, 'E3', 'available'), (3, 'E4', 'available'), (3, 'E5', 'available'), (3, 'E6', 'available'),
(3, 'F1', 'available'), (3, 'F2', 'available'), (3, 'F3', 'available'), (3, 'F4', 'available'), (3, 'F5', 'available'), (3, 'F6', 'available'),
(3, 'G1', 'available'), (3, 'G2', 'available'), (3, 'G3', 'available'), (3, 'G4', 'available'), (3, 'G5', 'available'), (3, 'G6', 'available');

-- Generate Seats for Bus 4 (BUS004) - 50 seats
INSERT INTO seats (bus_id, seat_number, status) VALUES
(4, 'A1', 'available'), (4, 'A2', 'available'), (4, 'A3', 'available'), (4, 'A4', 'available'), (4, 'A5', 'available'),
(4, 'B1', 'available'), (4, 'B2', 'available'), (4, 'B3', 'available'), (4, 'B4', 'available'), (4, 'B5', 'available'),
(4, 'C1', 'available'), (4, 'C2', 'available'), (4, 'C3', 'available'), (4, 'C4', 'available'), (4, 'C5', 'available'),
(4, 'D1', 'available'), (4, 'D2', 'available'), (4, 'D3', 'available'), (4, 'D4', 'available'), (4, 'D5', 'available'),
(4, 'E1', 'available'), (4, 'E2', 'available'), (4, 'E3', 'available'), (4, 'E4', 'available'), (4, 'E5', 'available'),
(4, 'F1', 'available'), (4, 'F2', 'available'), (4, 'F3', 'available'), (4, 'F4', 'available'), (4, 'F5', 'available'),
(4, 'G1', 'available'), (4, 'G2', 'available'), (4, 'G3', 'available'), (4, 'G4', 'available'), (4, 'G5', 'available'),
(4, 'H1', 'available'), (4, 'H2', 'available'), (4, 'H3', 'available'), (4, 'H4', 'available'), (4, 'H5', 'available'),
(4, 'I1', 'available'), (4, 'I2', 'available'), (4, 'I3', 'available'), (4, 'I4', 'available'), (4, 'I5', 'available'),
(4, 'J1', 'available'), (4, 'J2', 'available'), (4, 'J3', 'available'), (4, 'J4', 'available'), (4, 'J5', 'available');

-- Generate Seats for Bus 5 (BUS005) - 42 seats
INSERT INTO seats (bus_id, seat_number, status) VALUES
(5, 'A1', 'available'), (5, 'A2', 'available'), (5, 'A3', 'available'), (5, 'A4', 'available'), (5, 'A5', 'available'), (5, 'A6', 'available'),
(5, 'B1', 'available'), (5, 'B2', 'available'), (5, 'B3', 'available'), (5, 'B4', 'available'), (5, 'B5', 'available'), (5, 'B6', 'available'),
(5, 'C1', 'available'), (5, 'C2', 'available'), (5, 'C3', 'available'), (5, 'C4', 'available'), (5, 'C5', 'available'), (5, 'C6', 'available'),
(5, 'D1', 'available'), (5, 'D2', 'available'), (5, 'D3', 'available'), (5, 'D4', 'available'), (5, 'D5', 'available'), (5, 'D6', 'available'),
(5, 'E1', 'available'), (5, 'E2', 'available'), (5, 'E3', 'available'), (5, 'E4', 'available'), (5, 'E5', 'available'), (5, 'E6', 'available'),
(5, 'F1', 'available'), (5, 'F2', 'available'), (5, 'F3', 'available'), (5, 'F4', 'available'), (5, 'F5', 'available'), (5, 'F6', 'available'),
(5, 'G1', 'available'), (5, 'G2', 'available'), (5, 'G3', 'available'), (5, 'G4', 'available'), (5, 'G5', 'available'), (5, 'G6', 'available');

-- Generate Seats for Bus 6 (BUS006) - 50 seats
INSERT INTO seats (bus_id, seat_number, status) VALUES
(6, 'A1', 'available'), (6, 'A2', 'available'), (6, 'A3', 'available'), (6, 'A4', 'available'), (6, 'A5', 'available'),
(6, 'B1', 'available'), (6, 'B2', 'available'), (6, 'B3', 'available'), (6, 'B4', 'available'), (6, 'B5', 'available'),
(6, 'C1', 'available'), (6, 'C2', 'available'), (6, 'C3', 'available'), (6, 'C4', 'available'), (6, 'C5', 'available'),
(6, 'D1', 'available'), (6, 'D2', 'available'), (6, 'D3', 'available'), (6, 'D4', 'available'), (6, 'D5', 'available'),
(6, 'E1', 'available'), (6, 'E2', 'available'), (6, 'E3', 'available'), (6, 'E4', 'available'), (6, 'E5', 'available'),
(6, 'F1', 'available'), (6, 'F2', 'available'), (6, 'F3', 'available'), (6, 'F4', 'available'), (6, 'F5', 'available'),
(6, 'G1', 'available'), (6, 'G2', 'available'), (6, 'G3', 'available'), (6, 'G4', 'available'), (6, 'G5', 'available'),
(6, 'H1', 'available'), (6, 'H2', 'available'), (6, 'H3', 'available'), (6, 'H4', 'available'), (6, 'H5', 'available'),
(6, 'I1', 'available'), (6, 'I2', 'available'), (6, 'I3', 'available'), (6, 'I4', 'available'), (6, 'I5', 'available'),
(6, 'J1', 'available'), (6, 'J2', 'available'), (6, 'J3', 'available'), (6, 'J4', 'available'), (6, 'J5', 'available');

-- Generate Seats for Bus 7 (BUS007 - Royal Galactic Sleeper) - 42 seats
INSERT INTO seats (bus_id, seat_number, status) VALUES
(7, 'A1', 'available'), (7, 'A2', 'available'), (7, 'A3', 'available'), (7, 'A4', 'available'), (7, 'A5', 'available'), (7, 'A6', 'available'),
(7, 'B1', 'available'), (7, 'B2', 'available'), (7, 'B3', 'available'), (7, 'B4', 'available'), (7, 'B5', 'available'), (7, 'B6', 'available'),
(7, 'C1', 'available'), (7, 'C2', 'available'), (7, 'C3', 'available'), (7, 'C4', 'available'), (7, 'C5', 'available'), (7, 'C6', 'available'),
(7, 'D1', 'available'), (7, 'D2', 'available'), (7, 'D3', 'available'), (7, 'D4', 'available'), (7, 'D5', 'available'), (7, 'D6', 'available'),
(7, 'E1', 'available'), (7, 'E2', 'available'), (7, 'E3', 'available'), (7, 'E4', 'available'), (7, 'E5', 'available'), (7, 'E6', 'available'),
(7, 'F1', 'available'), (7, 'F2', 'available'), (7, 'F3', 'available'), (7, 'F4', 'available'), (7, 'F5', 'available'), (7, 'F6', 'available'),
(7, 'G1', 'available'), (7, 'G2', 'available'), (7, 'G3', 'available'), (7, 'G4', 'available'), (7, 'G5', 'available'), (7, 'G6', 'available');

-- Generate Seats for Bus 8 (BUS008) - 50 seats
INSERT INTO seats (bus_id, seat_number, status) VALUES
(8, 'A1', 'available'), (8, 'A2', 'available'), (8, 'A3', 'available'), (8, 'A4', 'available'), (8, 'A5', 'available'),
(8, 'B1', 'available'), (8, 'B2', 'available'), (8, 'B3', 'available'), (8, 'B4', 'available'), (8, 'B5', 'available'),
(8, 'C1', 'available'), (8, 'C2', 'available'), (8, 'C3', 'available'), (8, 'C4', 'available'), (8, 'C5', 'available'),
(8, 'D1', 'available'), (8, 'D2', 'available'), (8, 'D3', 'available'), (8, 'D4', 'available'), (8, 'D5', 'available'),
(8, 'E1', 'available'), (8, 'E2', 'available'), (8, 'E3', 'available'), (8, 'E4', 'available'), (8, 'E5', 'available'),
(8, 'F1', 'available'), (8, 'F2', 'available'), (8, 'F3', 'available'), (8, 'F4', 'available'), (8, 'F5', 'available'),
(8, 'G1', 'available'), (8, 'G2', 'available'), (8, 'G3', 'available'), (8, 'G4', 'available'), (8, 'G5', 'available'),
(8, 'H1', 'available'), (8, 'H2', 'available'), (8, 'H3', 'available'), (8, 'H4', 'available'), (8, 'H5', 'available'),
(8, 'I1', 'available'), (8, 'I2', 'available'), (8, 'I3', 'available'), (8, 'I4', 'available'), (8, 'I5', 'available'),
(8, 'J1', 'available'), (8, 'J2', 'available'), (8, 'J3', 'available'), (8, 'J4', 'available'), (8, 'J5', 'available');

-- Generate Seats for Bus 9 (BUS009) - 42 seats
INSERT INTO seats (bus_id, seat_number, status) VALUES
(9, 'A1', 'available'), (9, 'A2', 'available'), (9, 'A3', 'available'), (9, 'A4', 'available'), (9, 'A5', 'available'), (9, 'A6', 'available'),
(9, 'B1', 'available'), (9, 'B2', 'available'), (9, 'B3', 'available'), (9, 'B4', 'available'), (9, 'B5', 'available'), (9, 'B6', 'available'),
(9, 'C1', 'available'), (9, 'C2', 'available'), (9, 'C3', 'available'), (9, 'C4', 'available'), (9, 'C5', 'available'), (9, 'C6', 'available'),
(9, 'D1', 'available'), (9, 'D2', 'available'), (9, 'D3', 'available'), (9, 'D4', 'available'), (9, 'D5', 'available'), (9, 'D6', 'available'),
(9, 'E1', 'available'), (9, 'E2', 'available'), (9, 'E3', 'available'), (9, 'E4', 'available'), (9, 'E5', 'available'), (9, 'E6', 'available'),
(9, 'F1', 'available'), (9, 'F2', 'available'), (9, 'F3', 'available'), (9, 'F4', 'available'), (9, 'F5', 'available'), (9, 'F6', 'available'),
(9, 'G1', 'available'), (9, 'G2', 'available'), (9, 'G3', 'available'), (9, 'G4', 'available'), (9, 'G5', 'available'), (9, 'G6', 'available');

-- Generate Seats for Bus 10 (BUS010) - 50 seats
INSERT INTO seats (bus_id, seat_number, status) VALUES
(10, 'A1', 'available'), (10, 'A2', 'available'), (10, 'A3', 'available'), (10, 'A4', 'available'), (10, 'A5', 'available'),
(10, 'B1', 'available'), (10, 'B2', 'available'), (10, 'B3', 'available'), (10, 'B4', 'available'), (10, 'B5', 'available'),
(10, 'C1', 'available'), (10, 'C2', 'available'), (10, 'C3', 'available'), (10, 'C4', 'available'), (10, 'C5', 'available'),
(10, 'D1', 'available'), (10, 'D2', 'available'), (10, 'D3', 'available'), (10, 'D4', 'available'), (10, 'D5', 'available'),
(10, 'E1', 'available'), (10, 'E2', 'available'), (10, 'E3', 'available'), (10, 'E4', 'available'), (10, 'E5', 'available'),
(10, 'F1', 'available'), (10, 'F2', 'available'), (10, 'F3', 'available'), (10, 'F4', 'available'), (10, 'F5', 'available'),
(10, 'G1', 'available'), (10, 'G2', 'available'), (10, 'G3', 'available'), (10, 'G4', 'available'), (10, 'G5', 'available'),
(10, 'H1', 'available'), (10, 'H2', 'available'), (10, 'H3', 'available'), (10, 'H4', 'available'), (10, 'H5', 'available'),
(10, 'I1', 'available'), (10, 'I2', 'available'), (10, 'I3', 'available'), (10, 'I4', 'available'), (10, 'I5', 'available'),
(10, 'J1', 'available'), (10, 'J2', 'available'), (10, 'J3', 'available'), (10, 'J4', 'available'), (10, 'J5', 'available');
