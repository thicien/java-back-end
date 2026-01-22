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
            background: #0052CC;
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
            color: #0052CC;
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
            background: #0052CC;
            color: white;
            border: none;
            font-weight: bold;
            cursor: pointer;
            transition: 0.3s;
        }

        .search-form button:hover {
            background: #003d99;
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
            box-shadow: 0 4px 15px rgba(0, 82, 204, 0.1);
            overflow: hidden;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            display: flex;
            flex-direction: column;
            border-top: 4px solid #0052CC;
        }

        .bus-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 8px 25px rgba(0, 82, 204, 0.25);
        }

        .bus-image-wrapper {
            width: 100%;
            height: 200px;
            overflow: hidden;
            background: #0052CC;
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
            color: #0052CC;
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
            color: #0052CC;
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
            color: #0052CC;
        }

        .book-btn {
            background: #0052CC;
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
            background: #003d99;
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
            color: #0052CC;
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

        .featured-section {
            margin-top: 50px;
            padding: 40px 20px;
            background: #f0f4f8;
            border-radius: 15px;
        }

        .featured-title {
            text-align: center;
            color: #0052CC;
            font-size: 2em;
            margin-bottom: 10px;
            font-weight: bold;
        }

        .featured-subtitle {
            text-align: center;
            color: #666;
            margin-bottom: 40px;
            font-size: 1.1em;
        }

        .featured-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
            gap: 25px;
            max-width: 1400px;
            margin: 0 auto;
        }

        .featured-card {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0, 82, 204, 0.15);
            transition: all 0.3s ease;
            border-top: 4px solid #0052CC;
            display: flex;
            flex-direction: column;
        }

        .featured-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 8px 25px rgba(0, 82, 204, 0.3);
        }

        .featured-card img {
            width: 100%;
            height: 180px;
            object-fit: cover;
            background: #0052CC;
        }

        .featured-card-content {
            padding: 20px;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
        }

        .featured-card h4 {
            color: #0052CC;
            margin: 0 0 10px 0;
            font-size: 1.2em;
            font-weight: bold;
        }

        .featured-card p {
            color: #666;
            margin: 8px 0;
            font-size: 0.95em;
        }

        .featured-route {
            color: #333;
            font-weight: 600;
            margin-bottom: 10px;
        }

        .featured-price {
            color: #0052CC;
            font-size: 1.4em;
            font-weight: bold;
            margin-top: auto;
            margin-bottom: 10px;
        }

        .featured-btn {
            background: #0052CC;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 6px;
            cursor: pointer;
            font-weight: bold;
            text-decoration: none;
            display: block;
            text-align: center;
            transition: all 0.3s ease;
        }

        .featured-btn:hover {
            background: #003d99;
            transform: translateY(-2px);
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
                    "https://images.unsplash.com/photo-1590611357128-7a28610f940a?auto=format&fit=crop&w=800&q=80",
                    "https://images.unsplash.com/photo-1620055375841-7607a0a03075?auto=format&fit=crop&w=800&q=80",
                    "https://images.unsplash.com/photo-1562620644-85bc21387f6e?auto=format&fit=crop&w=800&q=80",
                    "https://images.unsplash.com/photo-1557223562-6c77ef16210f?auto=format&fit=crop&w=800&q=80",
                    "https://images.unsplash.com/photo-1512411604240-5290f9712e09?auto=format&fit=crop&w=800&q=80",
                    "https://images.unsplash.com/photo-1622329388062-8e7526738596?auto=format&fit=crop&w=800&q=80",
                    "https://images.unsplash.com/photo-1568228128648-97f48037146d?auto=format&fit=crop&w=800&q=80",
                    "https://images.unsplash.com/photo-1520105072000-f44fc083e50b?auto=format&fit=crop&w=800&q=80"
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

<!-- Featured Buses Section -->
<div class="featured-section">
    <h2 class="featured-title">🚌 Premium Bus Services</h2>
    <p class="featured-subtitle">Check out our 10 premium bus routes with the best prices</p>
    
    <div class="featured-grid">
        <%
            // Premium bus data from the BusProjectGenerator
            String[][] premiumBuses = {
                {"City Express", "New York - DC", "$30", "https://images.unsplash.com/photo-1544620347-c4fd4a3d5957?auto=format&fit=crop&w=500&q=80"},
                {"Mountain Traveler", "Denver - Aspen", "$55", "https://images.unsplash.com/photo-1570125909232-eb263c188f7e?auto=format&fit=crop&w=500&q=80"},
                {"Coastal Liner", "LA - San Diego", "$25", "https://images.unsplash.com/photo-1590611357128-7a28610f940a?auto=format&fit=crop&w=500&q=80"},
                {"Night Owl Sleeper", "Chicago - Nashville", "$75", "https://images.unsplash.com/photo-1620055375841-7607a0a03075?auto=format&fit=crop&w=500&q=80"},
                {"Executive Shuttle", "Airport Transfer", "$15", "https://images.unsplash.com/photo-1562620644-85bc21387f6e?auto=format&fit=crop&w=500&q=80"},
                {"Euro Tourer", "London - Paris", "$85", "https://images.unsplash.com/photo-1557223562-6c77ef16210f?auto=format&fit=crop&w=500&q=80"},
                {"Interstate Jet", "Dallas - Houston", "$40", "https://images.unsplash.com/photo-1512411604240-5290f9712e09?auto=format&fit=crop&w=500&q=80"},
                {"Nature Explorer", "Seattle - Portland", "$35", "https://images.unsplash.com/photo-1622329388062-8e7526738596?auto=format&fit=crop&w=500&q=80"},
                {"Golden Sun", "Miami - Orlando", "$20", "https://images.unsplash.com/photo-1568228128648-97f48037146d?auto=format&fit=crop&w=500&q=80"},
                {"Skyline Transit", "Toronto - Ottawa", "$50", "https://images.unsplash.com/photo-1520105072000-f44fc083e50b?auto=format&fit=crop&w=500&q=80"}
            };
            
            for (String[] bus : premiumBuses) {
        %>
            <div class="featured-card">
                <img src="<%= bus[3] %>" alt="<%= bus[0] %>" onerror="this.src='data:image/svg+xml,<svg xmlns=%22http://www.w3.org/2000/svg%22 width=%22260%22 height=%22180%22><rect fill=%22%230052CC%22 width=%22260%22 height=%22180%22/><text x=%2250%25%22 y=%2250%25%22 font-size=%2248%22 fill=%22white%22 text-anchor=%22middle%22 dominant-baseline=%22middle%22>🚌</text></svg>';">
                <div class="featured-card-content">
                    <h4><%= bus[0] %></h4>
                    <p class="featured-route">📍 <%= bus[1] %></p>
                    <p class="featured-price"><%= bus[2] %></p>
                    <a href="<%= request.getContextPath() %>/dashboard" class="featured-btn">Book Now</a>
                </div>
            </div>
        <% } %>
    </div>
</div>

</body>
</html>
