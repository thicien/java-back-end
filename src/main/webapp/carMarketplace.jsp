<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, com.example.model.Car, com.example.model.User" %>
<%
    // Check if user is logged in
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Used Cars Marketplace</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px 0;
        }
        
        .navbar {
            background: linear-gradient(to right, #667eea, #764ba2);
            padding: 20px 40px;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            margin-bottom: 40px;
        }
        
        .navbar h1 {
            font-size: 2em;
            font-weight: bold;
        }
        
        .navbar-right {
            display: flex;
            gap: 20px;
            align-items: center;
        }
        
        .welcome-text {
            font-size: 0.95em;
        }
        
        .logout-btn {
            background: rgba(255, 255, 255, 0.2);
            color: white;
            border: 1px solid white;
            padding: 8px 16px;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            font-weight: bold;
            transition: all 0.3s;
        }
        
        .logout-btn:hover {
            background: white;
            color: #667eea;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }
        
        .page-title {
            text-align: center;
            color: white;
            margin-bottom: 40px;
            font-size: 2.5em;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
        }
        
        .search-filter-section {
            background: white;
            padding: 30px;
            border-radius: 10px;
            margin-bottom: 40px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.15);
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
        }
        
        .search-filter-section form {
            display: flex;
            gap: 10px;
        }
        
        .search-filter-section input,
        .search-filter-section select {
            flex: 1;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 0.95em;
        }
        
        .search-filter-section input:focus,
        .search-filter-section select:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 5px rgba(102, 126, 234, 0.3);
        }
        
        .search-filter-section button,
        .clear-btn {
            background: linear-gradient(to right, #667eea, #764ba2);
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            transition: all 0.3s;
        }
        
        .search-filter-section button:hover,
        .clear-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
        }
        
        .clear-btn {
            grid-column: 1 / -1;
            text-align: center;
        }
        
        .cars-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 30px;
            margin-bottom: 40px;
        }
        
        .car-card {
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.15);
            transition: all 0.3s;
            cursor: pointer;
        }
        
        .car-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.25);
        }
        
        .car-header {
            background: linear-gradient(to right, #667eea, #764ba2);
            color: white;
            padding: 20px;
        }
        
        .car-header h3 {
            font-size: 1.5em;
            margin-bottom: 5px;
        }
        
        .car-year {
            font-size: 0.9em;
            opacity: 0.9;
        }
        
        .car-body {
            padding: 20px;
        }
        
        .car-price {
            font-size: 1.8em;
            color: #764ba2;
            font-weight: bold;
            margin-bottom: 15px;
        }
        
        .car-specs {
            display: flex;
            flex-direction: column;
            gap: 8px;
            margin-bottom: 15px;
            font-size: 0.95em;
            color: #555;
        }
        
        .car-spec-item {
            display: flex;
            justify-content: space-between;
            padding: 8px 0;
            border-bottom: 1px solid #f0f0f0;
        }
        
        .car-spec-item strong {
            color: #333;
        }
        
        .condition-badge {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 0.85em;
            font-weight: bold;
            margin-bottom: 10px;
        }
        
        .condition-excellent {
            background: #d4edda;
            color: #155724;
        }
        
        .condition-good {
            background: #cfe2ff;
            color: #084298;
        }
        
        .condition-fair {
            background: #fff3cd;
            color: #664d03;
        }
        
        .car-description {
            color: #666;
            font-size: 0.9em;
            margin-bottom: 15px;
            line-height: 1.5;
            min-height: 50px;
        }
        
        .view-details-btn {
            width: 100%;
            background: linear-gradient(to right, #667eea, #764ba2);
            color: white;
            border: none;
            padding: 12px;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            font-size: 1em;
            transition: all 0.3s;
        }
        
        .view-details-btn:hover {
            transform: scale(1.02);
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
        }
        
        .no-cars {
            grid-column: 1 / -1;
            text-align: center;
            padding: 40px;
            background: white;
            border-radius: 10px;
            color: #666;
            font-size: 1.1em;
        }
        
        .filter-info {
            background: white;
            padding: 15px 20px;
            border-radius: 10px;
            margin-bottom: 20px;
            color: #666;
        }
        
        .filter-info strong {
            color: #667eea;
        }
    </style>
</head>
<body>
    <div class="navbar">
        <h1>🚗 Used Cars Marketplace</h1>
        <div class="navbar-right">
            <span class="welcome-text">Welcome, <strong><%= user.getFullName() %></strong>!</span>
            <a href="<%= request.getContextPath() %>/logout" class="logout-btn">Logout</a>
        </div>
    </div>
    
    <div class="container">
        <h2 class="page-title">Find Your Perfect Car</h2>
        
        <!-- Search and Filter Section -->
        <div class="search-filter-section">
            <form method="POST" action="<%= request.getContextPath() %>/carMarketplace">
                <input type="hidden" name="action" value="search">
                <input type="text" name="brand" placeholder="Search by brand (e.g., Toyota, Honda)" required>
                <button type="submit">Search</button>
            </form>
            
            <form method="POST" action="<%= request.getContextPath() %>/carMarketplace">
                <input type="hidden" name="action" value="filter">
                <select name="engineType" required onchange="this.form.submit()">
                    <option value="">Filter by Engine Type</option>
                    <option value="Petrol">Petrol</option>
                    <option value="Diesel">Diesel</option>
                </select>
            </form>
            
            <a href="<%= request.getContextPath() %>/carMarketplace" class="clear-btn">Clear Filters</a>
        </div>
        
        <%
            String searchBrand = (String) request.getAttribute("searchBrand");
            String filterEngine = (String) request.getAttribute("filterEngine");
            if (searchBrand != null) {
        %>
            <div class="filter-info">
                Showing results for: <strong><%= searchBrand %></strong> <a href="<%= request.getContextPath() %>/carMarketplace">Clear</a>
            </div>
        <%
            }
            if (filterEngine != null) {
        %>
            <div class="filter-info">
                Filtering by: <strong><%= filterEngine %></strong> <a href="<%= request.getContextPath() %>/carMarketplace">Clear</a>
            </div>
        <%
            }
        %>
        
        <!-- Cars Grid -->
        <div class="cars-grid">
            <%
                List<Car> cars = (List<Car>) request.getAttribute("cars");
                if (cars != null && !cars.isEmpty()) {
                    for (Car car : cars) {
            %>
                <div class="car-card">
                    <div class="car-header">
                        <h3><%= car.getBrand() %> <%= car.getModel() %></h3>
                        <p class="car-year">Year: <%= car.getLaunchYear() %></p>
                    </div>
                    <div class="car-body">
                        <div class="car-price">$<%= String.format("%.2f", car.getPrice()) %></div>
                        
                        <span class="condition-badge condition-<%= car.getCondition().toLowerCase() %>">
                            <%= car.getCondition() %>
                        </span>
                        
                        <div class="car-specs">
                            <div class="car-spec-item">
                                <strong>Mileage:</strong>
                                <span><%= car.getMileage() %> km</span>
                            </div>
                            <div class="car-spec-item">
                                <strong>Engine:</strong>
                                <span><%= car.getEngineType() %></span>
                            </div>
                        </div>
                        
                        <p class="car-description"><%= car.getDescription() %></p>
                        
                        <button class="view-details-btn">View Details</button>
                    </div>
                </div>
            <%
                    }
                } else {
            %>
                <div class="no-cars">
                    <p>No cars found. Try adjusting your search or filters.</p>
                </div>
            <%
                }
            %>
        </div>
    </div>
</body>
</html>
