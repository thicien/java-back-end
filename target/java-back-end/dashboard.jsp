<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="com.example.model.Bus" %>
<%@ page import="com.example.model.User" %>
<%
    // Check if user is logged in
    if (session.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    User loggedUser = (User) session.getAttribute("user");
    List<Bus> buses = (List<Bus>) request.getAttribute("buses");
    if (buses == null) {
        buses = new ArrayList<>();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>QuickBus | Premium Ticket Booking</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Roboto, Arial, sans-serif;
            background-color: #f4f6f8;
            padding: 20px;
        }

        header {
            background: linear-gradient(135deg, #1a237e 0%, #283593 100%);
            color: white;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 20px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }

        .header-left {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .header-left h1 {
            font-size: 2em;
            margin: 0;
        }

        .header-right {
            display: flex;
            align-items: center;
            gap: 15px;
            flex-wrap: wrap;
        }

        .header-right span {
            font-size: 1.1em;
        }

        .logout-btn, .bookings-btn {
            background-color: #d32f2f;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            text-decoration: none;
            transition: 0.3s;
            display: inline-block;
        }

        .logout-btn:hover, .bookings-btn:hover {
            background-color: #b71c1c;
            transform: translateY(-2px);
        }

        .welcome {
            font-size: 18px;
            margin-bottom: 20px;
            color: #333;
            text-align: center;
        }

        h2 {
            text-align: center;
            margin-bottom: 30px;
            color: #1a237e;
            font-size: 1.8em;
        }

        .search-container {
            background: white;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 30px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        .search-form {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
        }

        .search-form input, .search-form button {
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 1em;
        }

        .search-form input {
            border: 1px solid #ddd;
        }

        .search-form button {
            background: #fbc02d;
            color: #000;
            border: none;
            font-weight: bold;
            cursor: pointer;
            transition: 0.3s;
        }

        .search-form button:hover {
            background: #f9a825;
        }

        .bus-container {
            display: flex;
            justify-content: center;
            gap: 30px;
            flex-wrap: wrap;
            margin: 0 auto;
            max-width: 1400px;
        }

        .bus-card {
            background: #ffffff;
            width: 320px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            overflow: hidden;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            display: flex;
            flex-direction: column;
        }

        .bus-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }

        .bus-image-wrapper {
            width: 100%;
            height: 200px;
            overflow: hidden;
            background: linear-gradient(135deg, #1a237e 0%, #283593 100%);
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .bus-card img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .bus-info {
            padding: 20px;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
        }

        .bus-card h3 {
            margin: 0 0 10px 0;
            color: #1a237e;
            font-size: 1.3em;
        }

        .bus-card p {
            margin: 8px 0;
            color: #555;
            font-size: 0.95em;
        }

        .route {
            color: #666;
            margin-bottom: 10px;
        }

        .route strong {
            color: #1a237e;
        }

        .status {
            display: inline-block;
            margin: 10px 0;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.85em;
            font-weight: bold;
            width: fit-content;
        }

        .available {
            background-color: #d4edda;
            color: #155724;
        }

        .busy {
            background-color: #f8d7da;
            color: #721c24;
        }

        .price-section {
            border-top: 1px solid #eee;
            padding-top: 15px;
            margin-top: auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .price {
            font-size: 1.5em;
            font-weight: bold;
            color: #1a237e;
        }

        .book-btn {
            background: #1a237e;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 6px;
            cursor: pointer;
            font-weight: bold;
            transition: 0.3s;
            text-decoration: none;
            display: inline-block;
        }

        .book-btn:hover {
            background: #0d1557;
        }

        .book-btn-disabled {
            background: #ccc;
            cursor: not-allowed;
            opacity: 0.6;
        }

        .no-buses {
            text-align: center;
            padding: 60px 20px;
            background: white;
            border-radius: 12px;
            color: #666;
        }

        .no-buses h2 {
            color: #1a237e;
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
        }

        @media (max-width: 768px) {
            header {
                flex-direction: column;
                align-items: flex-start;
            }

            .header-right {
                width: 100%;
            }

            .bus-card {
                width: 100%;
                max-width: 500px;
            }

            .search-form {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>

<header>
    <div class="header-left">
        <h1>🚍 QuickBus</h1>
    </div>
    <div class="header-right">
        <span>Welcome, <strong><%= loggedUser.getFullName() %></strong></span>
        <a href="<%= request.getContextPath() %>/bookingHistory" class="bookings-btn">My Bookings</a>
        <a href="<%= request.getContextPath() %>/logout" class="logout-btn">Logout</a>
    </div>
</header>

<div class="container">
    <h2>🚌 Available Buses</h2>

    <div class="search-container">
        <form method="POST" class="search-form">
            <input type="text" name="departure" placeholder="From City" value="<%= request.getParameter("departure") != null ? request.getParameter("departure") : "" %>">
            <input type="text" name="arrival" placeholder="To City" value="<%= request.getParameter("arrival") != null ? request.getParameter("arrival") : "" %>">
            <input type="date" name="date" value="<%= request.getParameter("date") != null ? request.getParameter("date") : "" %>">
            <button type="submit">Find Buses</button>
        </form>
    </div>

    <% if (buses.isEmpty()) { %>
        <div class="no-buses">
            <h2>No buses available</h2>
            <p>Try adjusting your search criteria or check back later for more options.</p>
        </div>
    <% } else { %>
        <div class="bus-container">
            <%
                String[] busImages = {
                    "https://images.unsplash.com/photo-1544620347-c4fd4a3d5957?auto=format&fit=crop&w=800&q=80",
                    "https://images.unsplash.com/photo-1570125909232-eb263c188f7e?auto=format&fit=crop&w=800&q=80",
                    "https://images.unsplash.com/photo-1529070538774-1843cb3265df?auto=format&fit=crop&w=800&q=80",
                    "https://images.unsplash.com/photo-1461896836934-ffe607ba8211?auto=format&fit=crop&w=800&q=80",
                    "https://images.unsplash.com/photo-1449824913935-59a10b8d2000?auto=format&fit=crop&w=800&q=80",
                    "https://images.unsplash.com/photo-1464219414839-083f6b4c3efc?auto=format&fit=crop&w=800&q=80"
                };

                int imageIndex = 0;
                for (Bus bus : buses) {
                    String statusText = bus.getAvailableSeats() > 0 ? "Available" : "Fully Booked";
                    String statusClass = bus.getAvailableSeats() > 0 ? "available" : "busy";
            %>
                <div class="bus-card">
                    <div class="bus-image-wrapper">
                        <img src="<%= busImages[imageIndex % busImages.length] %>" 
                             alt="<%= bus.getBusName() %>"
                             onerror="this.src='data:image/svg+xml,<svg xmlns=%22http://www.w3.org/2000/svg%22 width=%22320%22 height=%22200%22><rect fill=%22%231a237e%22 width=%22320%22 height=%22200%22/><text x=%2250%25%22 y=%2250%25%22 font-size=%2248%22 fill=%22white%22 text-anchor=%22middle%22 dominant-baseline=%22middle%22>🚍</text></svg>';">
                    </div>
                    <div class="bus-info">
                        <h3><%= bus.getBusName() %></h3>
                        <p class="route"><strong>Route:</strong> <%= bus.getDepartureLocation() %> → <%= bus.getArrivalLocation() %></p>
                        <p><strong>🕐 Departure:</strong> <%= bus.getDepartureTime() %></p>
                        <p><strong>📅 Date:</strong> <%= bus.getDepartureDate() %></p>
                        <p><strong>🧑:</strong> <%= bus.getBusType() %></p>
                        <p><strong>💺 Seats:</strong> <%= bus.getAvailableSeats() %> / <%= bus.getTotalSeats() %> available</p>
                        
                        <span class="status <%= statusClass %>"><%= statusText %></span>

                        <div class="price-section">
                            <div class="price">$<%= String.format("%.0f", bus.getFare()) %></div>
                            <% if (bus.getAvailableSeats() > 0) { %>
                                <a href="<%= request.getContextPath() %>/seatSelection?busId=<%= bus.getBusId() %>" class="book-btn">Book Now</a>
                            <% } else { %>
                                <button class="book-btn book-btn-disabled" disabled>Sold Out</button>
                            <% } %>
                        </div>
                    </div>
                </div>
            <%
                    imageIndex++;
                }
            %>
        </div>
    <% } %>
</div>

</body>
</html>
