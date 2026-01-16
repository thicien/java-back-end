package com.example.model;

public class Car {
    private int carId;
    private String brand;
    private String model;
    private int launchYear;
    private double price;
    private int mileage;
    private String engineType;
    private String condition;
    private String description;

    // Constructors
    public Car() {}

    public Car(String brand, String model, int launchYear, double price, int mileage, 
               String engineType, String condition, String description) {
        this.brand = brand;
        this.model = model;
        this.launchYear = launchYear;
        this.price = price;
        this.mileage = mileage;
        this.engineType = engineType;
        this.condition = condition;
        this.description = description;
    }

    // Getters and Setters
    public int getCarId() {
        return carId;
    }

    public void setCarId(int carId) {
        this.carId = carId;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public int getLaunchYear() {
        return launchYear;
    }

    public void setLaunchYear(int launchYear) {
        this.launchYear = launchYear;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getMileage() {
        return mileage;
    }

    public void setMileage(int mileage) {
        this.mileage = mileage;
    }

    public String getEngineType() {
        return engineType;
    }

    public void setEngineType(String engineType) {
        this.engineType = engineType;
    }

    public String getCondition() {
        return condition;
    }

    public void setCondition(String condition) {
        this.condition = condition;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
