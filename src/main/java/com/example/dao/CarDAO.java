package com.example.dao;

import com.example.model.Car;
import com.example.util.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CarDAO {
    /**
     * Get all cars
     */
    public List<Car> getAllCars() {
        List<Car> cars = new ArrayList<>();
        String query = "SELECT * FROM cars ORDER BY brand ASC";
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                Car car = mapResultSetToCar(rs);
                cars.add(car);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cars;
    }

    /**
     * Get car by ID
     */
    public Car getCarById(int carId) {
        String query = "SELECT * FROM cars WHERE car_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, carId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return mapResultSetToCar(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Search cars by brand
     */
    public List<Car> searchByBrand(String brand) {
        List<Car> cars = new ArrayList<>();
        String query = "SELECT * FROM cars WHERE brand LIKE ? ORDER BY brand ASC";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, "%" + brand + "%");
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Car car = mapResultSetToCar(rs);
                cars.add(car);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cars;
    }

    /**
     * Filter cars by launch year range
     */
    public List<Car> filterByYearRange(int minYear, int maxYear) {
        List<Car> cars = new ArrayList<>();
        String query = "SELECT * FROM cars WHERE launch_year BETWEEN ? AND ? ORDER BY launch_year DESC";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, minYear);
            stmt.setInt(2, maxYear);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Car car = mapResultSetToCar(rs);
                cars.add(car);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cars;
    }

    /**
     * Filter cars by engine type
     */
    public List<Car> filterByEngineType(String engineType) {
        List<Car> cars = new ArrayList<>();
        String query = "SELECT * FROM cars WHERE engine_type = ? ORDER BY brand ASC";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, engineType);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Car car = mapResultSetToCar(rs);
                cars.add(car);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cars;
    }

    /**
     * Filter cars by price range
     */
    public List<Car> filterByPriceRange(double minPrice, double maxPrice) {
        List<Car> cars = new ArrayList<>();
        String query = "SELECT * FROM cars WHERE price BETWEEN ? AND ? ORDER BY price ASC";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setDouble(1, minPrice);
            stmt.setDouble(2, maxPrice);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Car car = mapResultSetToCar(rs);
                cars.add(car);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cars;
    }

    /**
     * Filter cars by condition
     */
    public List<Car> filterByCondition(String condition) {
        List<Car> cars = new ArrayList<>();
        String query = "SELECT * FROM cars WHERE car_condition = ? ORDER BY brand ASC";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, condition);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Car car = mapResultSetToCar(rs);
                cars.add(car);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cars;
    }

    /**
     * Map ResultSet to Car object
     */
    private Car mapResultSetToCar(ResultSet rs) throws SQLException {
        Car car = new Car();
        car.setCarId(rs.getInt("car_id"));
        car.setBrand(rs.getString("brand"));
        car.setModel(rs.getString("model"));
        car.setLaunchYear(rs.getInt("launch_year"));
        car.setPrice(rs.getDouble("price"));
        car.setMileage(rs.getInt("mileage"));
        car.setEngineType(rs.getString("engine_type"));
        car.setCondition(rs.getString("condition"));
        car.setDescription(rs.getString("description"));
        car.setImageUrl(rs.getString("image_url"));
        return car;
    }
}
