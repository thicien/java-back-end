package com.example.util;

import java.sql.*;

public class DatabaseInitializer {
    
    public static void main(String[] args) {
        initializeCars();
        initializeSeats();
        System.out.println("\n✅ Database initialization completed!");
    }

    public static void initializeCars() {
        System.out.println("🚗 Initializing database with sample cars...");
        try (Connection conn = DatabaseConnection.getConnection()) {
            if (conn != null) {
                // Clear existing cars
                String deleteQuery = "DELETE FROM cars";
                try (Statement stmt = conn.createStatement()) {
                    stmt.executeUpdate(deleteQuery);
                    System.out.println("✓ Cleared existing cars");
                }

                // Insert sample cars
                String insertQuery = "INSERT INTO cars (brand, model, launch_year, price, mileage, engine_type, condition, description) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
                
                try (PreparedStatement pstmt = conn.prepareStatement(insertQuery)) {
                    int[][] carData = {
                        {2020, 22000, 45000}, // Toyota Camry
                        {2019, 18500, 52000}, // Honda Civic
                        {2021, 19500, 35000}, // Hyundai Elantra
                        {2020, 21000, 40000}, // Mazda Mazda3
                        {2018, 17000, 65000}, // Nissan Altima
                        {2019, 16500, 55000}, // Ford Focus
                        {2021, 23000, 28000}, // Volkswagen Golf
                        {2020, 19000, 42000}  // Kia Cerato
                    };
                    
                    String[][] carInfo = {
                        {"Toyota", "Camry", "Petrol", "Excellent", "Well-maintained Toyota Camry with full service history. Excellent condition."},
                        {"Honda", "Civic", "Petrol", "Good", "Reliable Honda Civic with great fuel efficiency. Recently serviced."},
                        {"Hyundai", "Elantra", "Petrol", "Excellent", "Latest model Hyundai Elantra with modern features and excellent condition."},
                        {"Mazda", "Mazda3", "Petrol", "Good", "Sporty Mazda3 with great handling and performance. Well maintained."},
                        {"Nissan", "Altima", "Petrol", "Fair", "Budget-friendly Nissan Altima. Mechanically sound with minor cosmetic issues."},
                        {"Ford", "Focus", "Diesel", "Good", "Efficient Ford Focus with low fuel consumption. Great for long drives."},
                        {"Volkswagen", "Golf", "Petrol", "Excellent", "Premium VW Golf with all modern amenities and excellent condition."},
                        {"Kia", "Cerato", "Petrol", "Good", "Reliable Kia Cerato with great warranty and fuel efficiency."}
                    };
                    
                    for (int i = 0; i < carInfo.length; i++) {
                        pstmt.setString(1, carInfo[i][0]);
                        pstmt.setString(2, carInfo[i][1]);
                        pstmt.setInt(3, carData[i][0]);
                        pstmt.setDouble(4, carData[i][1]);
                        pstmt.setInt(5, carData[i][2]);
                        pstmt.setString(6, carInfo[i][2]);
                        pstmt.setString(7, carInfo[i][3]);
                        pstmt.setString(8, carInfo[i][4]);
                        pstmt.executeUpdate();
                    }
                    System.out.println("✓ Successfully inserted 8 sample cars");
                }
            }
        } catch (SQLException e) {
            System.err.println("❌ Error initializing cars:");
            e.printStackTrace();
        }
    }

    public static void initializeSeats() {
        String[] busSeats = {
            // Bus 1 - 42 seats (6 columns x 7 rows)
            "INSERT INTO seats (bus_id, seat_number, status) SELECT 1, 'A1', 'available' WHERE NOT EXISTS (SELECT 1 FROM seats WHERE bus_id = 1 AND seat_number = 'A1');",
            "INSERT INTO seats (bus_id, seat_number, status) SELECT 1, 'A2', 'available' WHERE NOT EXISTS (SELECT 1 FROM seats WHERE bus_id = 1 AND seat_number = 'A2');",
            "INSERT INTO seats (bus_id, seat_number, status) SELECT 1, 'A3', 'available' WHERE NOT EXISTS (SELECT 1 FROM seats WHERE bus_id = 1 AND seat_number = 'A3');",
            "INSERT INTO seats (bus_id, seat_number, status) SELECT 1, 'A4', 'available' WHERE NOT EXISTS (SELECT 1 FROM seats WHERE bus_id = 1 AND seat_number = 'A4');",
            "INSERT INTO seats (bus_id, seat_number, status) SELECT 1, 'A5', 'available' WHERE NOT EXISTS (SELECT 1 FROM seats WHERE bus_id = 1 AND seat_number = 'A5');",
            "INSERT INTO seats (bus_id, seat_number, status) SELECT 1, 'A6', 'available' WHERE NOT EXISTS (SELECT 1 FROM seats WHERE bus_id = 1 AND seat_number = 'A6');",
            "INSERT INTO seats (bus_id, seat_number, status) SELECT 1, 'B1', 'available' WHERE NOT EXISTS (SELECT 1 FROM seats WHERE bus_id = 1 AND seat_number = 'B1');",
            "INSERT INTO seats (bus_id, seat_number, status) SELECT 1, 'B2', 'available' WHERE NOT EXISTS (SELECT 1 FROM seats WHERE bus_id = 1 AND seat_number = 'B2');",
            "INSERT INTO seats (bus_id, seat_number, status) SELECT 1, 'B3', 'available' WHERE NOT EXISTS (SELECT 1 FROM seats WHERE bus_id = 1 AND seat_number = 'B3');",
            "INSERT INTO seats (bus_id, seat_number, status) SELECT 1, 'B4', 'available' WHERE NOT EXISTS (SELECT 1 FROM seats WHERE bus_id = 1 AND seat_number = 'B4');",
            "INSERT INTO seats (bus_id, seat_number, status) SELECT 1, 'B5', 'available' WHERE NOT EXISTS (SELECT 1 FROM seats WHERE bus_id = 1 AND seat_number = 'B5');",
            "INSERT INTO seats (bus_id, seat_number, status) SELECT 1, 'B6', 'available' WHERE NOT EXISTS (SELECT 1 FROM seats WHERE bus_id = 1 AND seat_number = 'B6');",
            "INSERT INTO seats (bus_id, seat_number, status) SELECT 1, 'C1', 'available' WHERE NOT EXISTS (SELECT 1 FROM seats WHERE bus_id = 1 AND seat_number = 'C1');",
            "INSERT INTO seats (bus_id, seat_number, status) SELECT 1, 'C2', 'available' WHERE NOT EXISTS (SELECT 1 FROM seats WHERE bus_id = 1 AND seat_number = 'C2');",
            "INSERT INTO seats (bus_id, seat_number, status) SELECT 1, 'C3', 'available' WHERE NOT EXISTS (SELECT 1 FROM seats WHERE bus_id = 1 AND seat_number = 'C3');",
            "INSERT INTO seats (bus_id, seat_number, status) SELECT 1, 'C4', 'available' WHERE NOT EXISTS (SELECT 1 FROM seats WHERE bus_id = 1 AND seat_number = 'C4');",
            "INSERT INTO seats (bus_id, seat_number, status) SELECT 1, 'C5', 'available' WHERE NOT EXISTS (SELECT 1 FROM seats WHERE bus_id = 1 AND seat_number = 'C5');",
            "INSERT INTO seats (bus_id, seat_number, status) SELECT 1, 'C6', 'available' WHERE NOT EXISTS (SELECT 1 FROM seats WHERE bus_id = 1 AND seat_number = 'C6');",
            "INSERT INTO seats (bus_id, seat_number, status) SELECT 1, 'D1', 'available' WHERE NOT EXISTS (SELECT 1 FROM seats WHERE bus_id = 1 AND seat_number = 'D1');",
            "INSERT INTO seats (bus_id, seat_number, status) SELECT 1, 'D2', 'available' WHERE NOT EXISTS (SELECT 1 FROM seats WHERE bus_id = 1 AND seat_number = 'D2');",
            "INSERT INTO seats (bus_id, seat_number, status) SELECT 1, 'D3', 'available' WHERE NOT EXISTS (SELECT 1 FROM seats WHERE bus_id = 1 AND seat_number = 'D3');",
            "INSERT INTO seats (bus_id, seat_number, status) SELECT 1, 'D4', 'available' WHERE NOT EXISTS (SELECT 1 FROM seats WHERE bus_id = 1 AND seat_number = 'D4');",
            "INSERT INTO seats (bus_id, seat_number, status) SELECT 1, 'D5', 'available' WHERE NOT EXISTS (SELECT 1 FROM seats WHERE bus_id = 1 AND seat_number = 'D5');",
            "INSERT INTO seats (bus_id, seat_number, status) SELECT 1, 'D6', 'available' WHERE NOT EXISTS (SELECT 1 FROM seats WHERE bus_id = 1 AND seat_number = 'D6');",
            "INSERT INTO seats (bus_id, seat_number, status) SELECT 1, 'E1', 'available' WHERE NOT EXISTS (SELECT 1 FROM seats WHERE bus_id = 1 AND seat_number = 'E1');",
            "INSERT INTO seats (bus_id, seat_number, status) SELECT 1, 'E2', 'available' WHERE NOT EXISTS (SELECT 1 FROM seats WHERE bus_id = 1 AND seat_number = 'E2');",
            "INSERT INTO seats (bus_id, seat_number, status) SELECT 1, 'E3', 'available' WHERE NOT EXISTS (SELECT 1 FROM seats WHERE bus_id = 1 AND seat_number = 'E3');",
            "INSERT INTO seats (bus_id, seat_number, status) SELECT 1, 'E4', 'available' WHERE NOT EXISTS (SELECT 1 FROM seats WHERE bus_id = 1 AND seat_number = 'E4');",
            "INSERT INTO seats (bus_id, seat_number, status) SELECT 1, 'E5', 'available' WHERE NOT EXISTS (SELECT 1 FROM seats WHERE bus_id = 1 AND seat_number = 'E5');",
            "INSERT INTO seats (bus_id, seat_number, status) SELECT 1, 'E6', 'available' WHERE NOT EXISTS (SELECT 1 FROM seats WHERE bus_id = 1 AND seat_number = 'E6');",
            "INSERT INTO seats (bus_id, seat_number, status) SELECT 1, 'F1', 'available' WHERE NOT EXISTS (SELECT 1 FROM seats WHERE bus_id = 1 AND seat_number = 'F1');",
            "INSERT INTO seats (bus_id, seat_number, status) SELECT 1, 'F2', 'available' WHERE NOT EXISTS (SELECT 1 FROM seats WHERE bus_id = 1 AND seat_number = 'F2');",
            "INSERT INTO seats (bus_id, seat_number, status) SELECT 1, 'F3', 'available' WHERE NOT EXISTS (SELECT 1 FROM seats WHERE bus_id = 1 AND seat_number = 'F3');",
            "INSERT INTO seats (bus_id, seat_number, status) SELECT 1, 'F4', 'available' WHERE NOT EXISTS (SELECT 1 FROM seats WHERE bus_id = 1 AND seat_number = 'F4');",
            "INSERT INTO seats (bus_id, seat_number, status) SELECT 1, 'F5', 'available' WHERE NOT EXISTS (SELECT 1 FROM seats WHERE bus_id = 1 AND seat_number = 'F5');",
            "INSERT INTO seats (bus_id, seat_number, status) SELECT 1, 'F6', 'available' WHERE NOT EXISTS (SELECT 1 FROM seats WHERE bus_id = 1 AND seat_number = 'F6');",
            "INSERT INTO seats (bus_id, seat_number, status) SELECT 1, 'G1', 'available' WHERE NOT EXISTS (SELECT 1 FROM seats WHERE bus_id = 1 AND seat_number = 'G1');",
            "INSERT INTO seats (bus_id, seat_number, status) SELECT 1, 'G2', 'available' WHERE NOT EXISTS (SELECT 1 FROM seats WHERE bus_id = 1 AND seat_number = 'G2');",
            "INSERT INTO seats (bus_id, seat_number, status) SELECT 1, 'G3', 'available' WHERE NOT EXISTS (SELECT 1 FROM seats WHERE bus_id = 1 AND seat_number = 'G3');",
            "INSERT INTO seats (bus_id, seat_number, status) SELECT 1, 'G4', 'available' WHERE NOT EXISTS (SELECT 1 FROM seats WHERE bus_id = 1 AND seat_number = 'G4');",
            "INSERT INTO seats (bus_id, seat_number, status) SELECT 1, 'G5', 'available' WHERE NOT EXISTS (SELECT 1 FROM seats WHERE bus_id = 1 AND seat_number = 'G5');",
            "INSERT INTO seats (bus_id, seat_number, status) SELECT 1, 'G6', 'available' WHERE NOT EXISTS (SELECT 1 FROM seats WHERE bus_id = 1 AND seat_number = 'G6');"
        };

        try (Connection conn = DatabaseConnection.getConnection()) {
            // First, clear existing seats for bus 1 to avoid duplicates
            try (Statement stmt = conn.createStatement()) {
                stmt.execute("DELETE FROM seats WHERE bus_id = 1;");
                System.out.println("Cleared existing seats");
            }

            // Insert new seats
            for (String sql : busSeats) {
                try (Statement stmt = conn.createStatement()) {
                    stmt.execute(sql);
                }
            }
            System.out.println("Successfully initialized " + busSeats.length + " seats for Bus 1");
        } catch (SQLException e) {
            System.err.println("Error initializing seats: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
