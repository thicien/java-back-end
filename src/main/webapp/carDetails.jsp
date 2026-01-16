<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.example.model.Car, com.example.model.User" %>
<%
    // Check if user is logged in
    if (session.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    User loggedUser = (User) session.getAttribute("user");
    Car car = (Car) request.getAttribute("car");
    String[] carImages = {
        "https://images.unsplash.com/photo-1618843479313-40f8afb4b4d8?auto=format&fit=crop&q=80&w=1024",
        "https://images.unsplash.com/photo-1503376780353-7e6692767b70?auto=format&fit=crop&q=80&w=1024",
        "https://images.unsplash.com/photo-1555215695-3004980ad54e?auto=format&fit=crop&q=80&w=1024",
        "https://images.unsplash.com/photo-1614200187524-dc4b892acf16?auto=format&fit=crop&q=80&w=1024",
        "https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?auto=format&fit=crop&q=80&w=1024",
        "https://images.unsplash.com/photo-1533473359331-0135ef1b58bf?auto=format&fit=crop&q=80&w=1024",
        "https://images.unsplash.com/photo-1568605114967-8130f3a36994?auto=format&fit=crop&q=80&w=1024",
        "https://images.unsplash.com/photo-1552820728-8ac41f1ce891?auto=format&fit=crop&q=80&w=1024",
        "https://images.unsplash.com/photo-1606611013016-969c19d14311?auto=format&fit=crop&q=80&w=1024",
        "https://images.unsplash.com/photo-1550355291-bbee04a92027?auto=format&fit=crop&q=80&w=1024"
    };
    String carImage = carImages[(car.getCarId() - 1) % carImages.length];
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= car.getBrand() %> <%= car.getModel() %> - Used Car Marketplace</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f7fa;
        }
        .navbar {
            background: linear-gradient(135deg, #0066FF 0%, #0047B2 100%);
            color: white;
            padding: 15px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        .navbar-brand {
            font-size: 1.5em;
            font-weight: bold;
        }
        .navbar a {
            color: white;
            text-decoration: none;
            margin-left: 20px;
            padding: 8px 15px;
            border-radius: 5px;
            transition: background 0.3s;
        }
        .navbar a:hover {
            background: rgba(255, 255, 255, 0.2);
        }
        .container {
            max-width: 1000px;
            margin: 40px auto;
            padding: 0 20px;
        }
        .back-link {
            display: inline-block;
            margin-bottom: 30px;
            color: #0066FF;
            text-decoration: none;
            font-weight: 600;
        }
        .back-link:hover {
            text-decoration: underline;
        }
        .car-detail-container {
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        }
        .car-image-section {
            width: 100%;
            height: 350px;
            background: linear-gradient(135deg, #e0e0e0 0%, #f5f5f5 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2em;
            color: #999;
            overflow: hidden;
        }
        .car-image-section img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .car-info-section {
            padding: 40px;
        }
        .car-header {
            border-bottom: 2px solid #f0f0f0;
            padding-bottom: 20px;
            margin-bottom: 30px;
        }
        .car-title {
            font-size: 2.5em;
            color: #333;
            margin-bottom: 10px;
            font-weight: bold;
        }
        .car-status {
            display: inline-block;
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 0.9em;
            font-weight: 600;
        }
        .status-excellent {
            background: #d4edda;
            color: #155724;
        }
        .status-good {
            background: #d1ecf1;
            color: #0c5460;
        }
        .status-fair {
            background: #fff3cd;
            color: #856404;
        }
        .price-section {
            background: linear-gradient(135deg, #0066FF 0%, #0047B2 100%);
            color: white;
            padding: 30px;
            border-radius: 10px;
            margin: 30px 0;
            text-align: center;
        }
        .price-label {
            font-size: 0.9em;
            opacity: 0.9;
            margin-bottom: 10px;
        }
        .price-value {
            font-size: 3em;
            font-weight: bold;
        }
        .details-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 30px;
            margin: 30px 0;
        }
        .detail-item {
            border-left: 4px solid #0066FF;
            padding-left: 20px;
        }
        .detail-label {
            font-size: 0.85em;
            color: #999;
            text-transform: uppercase;
            margin-bottom: 8px;
            letter-spacing: 1px;
        }
        .detail-value {
            font-size: 1.3em;
            color: #333;
            font-weight: 600;
        }
        .description-section {
            background: #f9f9f9;
            padding: 30px;
            border-radius: 10px;
            margin: 30px 0;
        }
        .description-title {
            font-size: 1.3em;
            color: #333;
            margin-bottom: 15px;
            font-weight: bold;
        }
        .description-text {
            color: #666;
            line-height: 1.8;
            font-size: 1.05em;
        }
        .action-buttons {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-top: 30px;
        }
        .btn {
            padding: 15px 30px;
            border: none;
            border-radius: 5px;
            font-size: 1.05em;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s;
        }
        .btn-primary {
            background: linear-gradient(135deg, #0066FF 0%, #0047B2 100%);
            color: white;
        }
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 102, 255, 0.3);
        }
        .btn-secondary {
            background: white;
            color: #0066FF;
            border: 2px solid #0066FF;
        }
        .btn-secondary:hover {
            background: #f5f9ff;
        }
        .specs-table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }
        .specs-table tr {
            border-bottom: 1px solid #f0f0f0;
        }
        .specs-table td {
            padding: 12px 0;
            color: #333;
        }
        .specs-table td:first-child {
            color: #999;
            font-weight: 600;
            width: 40%;
        }
        .specs-table td:last-child {
            font-weight: 600;
            color: #0066FF;
        }
        @media (max-width: 768px) {
            .car-title {
                font-size: 1.8em;
            }
            .price-value {
                font-size: 2em;
            }
            .action-buttons {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="navbar">
        <div class="navbar-brand">🚗 Used Car Marketplace</div>
        <div>
            <a href="<%= request.getContextPath() %>/dashboard">Back to Cars</a>
            <a href="<%= request.getContextPath() %>/logout">Logout</a>
        </div>
    </div>

    <div class="container">
        <a href="<%= request.getContextPath() %>/dashboard" class="back-link">← Back to All Cars</a>

        <div class="car-detail-container">
            <div class="car-image-section">
                <img src="<%= carImage %>" 
                     alt="<%= car.getBrand() %> <%= car.getModel() %>">
            </div>

            <div class="car-info-section">
                <div class="car-header">
                    <div class="car-title"><%= car.getBrand() %> <%= car.getModel() %></div>
                    <span class="car-status status-<%= car.getCondition().toLowerCase() %>">
                        <%= car.getCondition() %>
                    </span>
                </div>

                <div class="price-section">
                    <div class="price-label">Asking Price</div>
                    <div class="price-value">$<%= String.format("%,.2f", car.getPrice()) %></div>
                </div>

                <div class="details-grid">
                    <div class="detail-item">
                        <div class="detail-label">Year of Manufacture</div>
                        <div class="detail-value"><%= car.getLaunchYear() %></div>
                    </div>
                    <div class="detail-item">
                        <div class="detail-label">Total Mileage</div>
                        <div class="detail-value"><%= String.format("%,d", car.getMileage()) %> km</div>
                    </div>
                    <div class="detail-item">
                        <div class="detail-label">Engine Type</div>
                        <div class="detail-value"><%= car.getEngineType() %></div>
                    </div>
                    <div class="detail-item">
                        <div class="detail-label">Condition</div>
                        <div class="detail-value"><%= car.getCondition() %></div>
                    </div>
                </div>

                <div class="description-section">
                    <div class="description-title">About This Vehicle</div>
                    <div class="description-text">
                        <%= car.getDescription() %>
                    </div>
                </div>

                <table class="specs-table">
                    <tr>
                        <td>Car ID</td>
                        <td>#<%= String.format("%05d", car.getCarId()) %></td>
                    </tr>
                    <tr>
                        <td>Brand</td>
                        <td><%= car.getBrand() %></td>
                    </tr>
                    <tr>
                        <td>Model</td>
                        <td><%= car.getModel() %></td>
                    </tr>
                    <tr>
                        <td>Engine Type</td>
                        <td><%= car.getEngineType() %></td>
                    </tr>
                    <tr>
                        <td>Mileage</td>
                        <td><%= String.format("%,d", car.getMileage()) %> km</td>
                    </tr>
                    <tr>
                        <td>Price</td>
                        <td>$<%= String.format("%,.2f", car.getPrice()) %></td>
                    </tr>
                </table>

                <div class="action-buttons">
                    <button class="btn btn-primary" onclick="alert('Thank you for your interest! Contact us at info@carmarketplace.com')">
                        📞 Contact Seller
                    </button>
                    <button class="btn btn-secondary" onclick="window.location.href='<%= request.getContextPath() %>/dashboard'">
                        ← Back to Cars
                    </button>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
