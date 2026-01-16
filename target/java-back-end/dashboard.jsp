<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="com.example.model.Bus" %>
<%@ page import="com.example.model.User" %>
<%
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
        :root {
            --primary: #1a237e;
            --secondary: #fbc02d;
            --accent: #d32f2f;
            --bg: #f0f2f5;
            --white: #ffffff;
        }

        body {
            font-family: 'Segoe UI', Roboto, sans-serif;
            margin: 0;
            background-color: var(--bg);
            color: #333;
        }

        header {
            background-color: var(--primary);
            color: white;
            padding: 1.5rem 5%;
            box-shadow: 0 2px 10px rgba(0,0,0,0.2);
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .header-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
            max-width: 1100px;
            margin: auto;
            flex-wrap: wrap;
            gap: 15px;
        }

        .header-content h2 {
            margin: 0;
            font-size: 1.8rem;
        }

        .header-right {
            display: flex;
            align-items: center;
            gap: 15px;
            font-size: 0.95rem;
        }

        .logout-btn {
            background: var(--accent);
            color: white;
            padding: 8px 16px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            font-weight: bold;
            transition: 0.3s;
        }

        .logout-btn:hover {
            background: #b71c1c;
        }

        .container {
            width: 90%;
            max-width: 1100px;
            margin: 20px auto;
        }

        .search-container {
            background: var(--white);
            padding: 25px;
            border-radius: 12px;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            margin-bottom: 30px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
        }

        .search-group input {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 6px;
            box-sizing: border-box;
            font-size: 0.95rem;
        }

        .btn-search {
            background: var(--secondary);
            color: #000;
            border: none;
            padding: 12px;
            border-radius: 6px;
            font-weight: bold;
            cursor: pointer;
            transition: 0.3s;
        }

        .btn-search:hover {
            background: #f9a825;
        }

        .bus-card {
            background: var(--white);
            border-radius: 12px;
            display: flex;
            flex-wrap: wrap;
            margin-bottom: 25px;
            overflow: hidden;
            transition: transform 0.2s;
            box-shadow: 0 4px 6px rgba(0,0,0,0.05);
        }

        .bus-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 12px rgba(0,0,0,0.1);
        }

        .bus-image {
            width: 300px;
            min-height: 200px;
            object-fit: cover;
        }

        .bus-details {
            flex: 1;
            padding: 20px;
            min-width: 300px;
        }

        .bus-details h3 {
            margin: 0 0 5px 0;
            color: var(--primary);
        }

        .bus-type {
            color: var(--primary);
            font-weight: 600;
        }

        .bus-booking {
            padding: 20px;
            width: 200px;
            border-left: 1px dashed #ccc;
            text-align: center;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .amenities {
            font-size: 0.85rem;
            color: #666;
            margin: 10px 0;
        }

        .price {
            font-size: 1.8rem;
            font-weight: bold;
            color: var(--primary);
            margin-bottom: 10px;
        }

        .schedule-info {
            margin: 10px 0;
            font-weight: 500;
        }

        .seats-available {
            font-size: 0.9rem;
            color: #666;
            margin: 10px 0;
        }

        .no-buses {
            text-align: center;
            padding: 40px;
            background: var(--white);
            border-radius: 12px;
            color: #666;
        }

        .no-buses h2 {
            color: var(--primary);
        }

        .book-link {
            text-decoration: none;
        }

        .book-btn-disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }

        @media (max-width: 768px) {
            .bus-image {
                width: 100%;
            }
            .bus-booking {
                width: 100%;
                border-left: none;
                border-top: 1px dashed #ccc;
            }
            .search-container {
                grid-template-columns: 1fr;
            }
            .header-content {
                flex-direction: column;
                align-items: flex-start;
            }
        }
    </style>
</head>
<body>

<header>
    <div class="header-content">
        <h2>🚍 QuickBus</h2>
        <div class="header-right">
            <span>Welcome, <%= loggedUser.getFullName() %></span>
            <a href="<%= request.getContextPath() %>/bookingHistory" class="logout-btn">My Bookings</a>
            <a href="<%= request.getContextPath() %>/logout" class="logout-btn">Logout</a>
        </div>
    </div>
</header>

<div class="container">
    <div class="search-container">
        <form method="POST" style="display: contents;">
            <div class="search-group">
                <input type="text" name="departure" placeholder="From City" value="<%= request.getParameter("departure") != null ? request.getParameter("departure") : "" %>">
            </div>
            <div class="search-group">
                <input type="text" name="arrival" placeholder="To City" value="<%= request.getParameter("arrival") != null ? request.getParameter("arrival") : "" %>">
            </div>
            <div class="search-group">
                <input type="date" name="date" value="<%= request.getParameter("date") != null ? request.getParameter("date") : "" %>">
            </div>
            <button type="submit" class="btn-search">Find Buses</button>
        </form>
    </div>

    <div id="bus-list">
        <% if (buses.isEmpty()) { %>
            <div class="no-buses">
                <h2>No buses available</h2>
                <p>Try adjusting your search criteria or check back later for more options.</p>
            </div>
        <% } else { %>
            <%
                String[] busImages = {
                    "https://images.unsplash.com/photo-1544620347-c4fd4a3d5957?q=80&w=600",
                    "https://images.unsplash.com/photo-1570125909232-eb263c188f7e?q=80&w=600",
                    "https://images.unsplash.com/photo-1512413316925-fd4b93f31521?q=80&w=600",
                    "https://images.unsplash.com/photo-1562620644-656450258040?q=80&w=600",
                    "https://images.unsplash.com/photo-1632276513361-ec853114382e?q=80&w=600",
                    "https://images.unsplash.com/photo-1590674899484-13da0d1b58f5?q=80&w=600"
                };

                int imageIndex = 0;
                for (Bus bus : buses) {
            %>
            <div class="bus-card">
                <img src="<%= busImages[imageIndex % busImages.length] %>" class="bus-image" alt="<%= bus.getBusName() %>">
                <div class="bus-details">
                    <h3><%= bus.getBusName() %></h3>
                    <span class="bus-type"><%= bus.getBusType() %></span>
                    <p class="schedule-info"><strong>🕐 Schedule:</strong> <%= bus.getDepartureTime() %> onwards</p>
                    <p><strong>📍 Route:</strong> <%= bus.getDepartureLocation() %> → <%= bus.getArrivalLocation() %></p>
                    <p class="seats-available"><strong>💺 Available Seats:</strong> <%= bus.getAvailableSeats() %> / <%= bus.getTotalSeats() %></p>
                    <div class="amenities">
                        <% if (bus.getBusType().contains("Sleeper")) { %>
                            🛌 Sleeper Beds | 📶 Free Wi-Fi | ⚡ Charging Points
                        <% } else if (bus.getBusType().contains("Electric")) { %>
                            🌱 Zero Emission | ♿ Accessible | 📶 Fast Wi-Fi
                        <% } else { %>
                            ❄️ Central AC | 💺 Pushback Seats | 🧳 Large Boot Space
                        <% } %>
                    </div>
                </div>
                <div class="bus-booking">
                    <div class="price">$<%= String.format("%.0f", bus.getFare()) %></div>
                    <% if (bus.getAvailableSeats() > 0) { %>
                        <a href="<%= request.getContextPath() %>/seatSelection?busId=<%= bus.getBusId() %>" class="book-link">
                            <button class="btn-search" style="width: 100%; cursor: pointer;">Book Ticket</button>
                        </a>
                    <% } else { %>
                        <button class="btn-search book-btn-disabled" disabled>Sold Out</button>
                    <% } %>
                </div>
            </div>
            <%
                    imageIndex++;
                }
            %>
        <% } %>
    </div>
</div>

</body>
</html>
