<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, com.example.model.Booking, com.example.dao.BusDAO" %>
<%
    // Check if user is logged in
    if (session.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking History - Bus Booking</title>
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
            padding: 20px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .navbar a {
            color: white;
            text-decoration: none;
            padding: 8px 15px;
            border-radius: 5px;
            transition: background 0.3s;
        }
        .navbar a:hover {
            background: rgba(255, 255, 255, 0.2);
        }
        .container {
            max-width: 1000px;
            margin: 30px auto;
            padding: 0 20px;
        }
        .back-btn {
            display: inline-block;
            margin-bottom: 20px;
            padding: 10px 20px;
            background: #0066FF;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
        h2 {
            color: #333;
            margin-bottom: 20px;
        }
        .bookings-list {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 20px;
        }
        .booking-card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }
        .booking-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
            padding-bottom: 15px;
            border-bottom: 2px solid #f0f0f0;
        }
        .booking-id {
            font-weight: bold;
            color: #0066FF;
            font-size: 1.1em;
        }
        .status {
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 0.9em;
            font-weight: bold;
        }
        .status.confirmed {
            background: #d4edda;
            color: #155724;
        }
        .status.cancelled {
            background: #f8d7da;
            color: #721c24;
        }
        .booking-details {
            color: #666;
            margin-bottom: 15px;
        }
        .detail {
            margin-bottom: 10px;
            display: flex;
            justify-content: space-between;
        }
        .detail-label {
            font-weight: 500;
            color: #333;
        }
        .detail-value {
            color: #666;
        }
        .fare-section {
            background: #f9f9f9;
            padding: 12px;
            border-radius: 5px;
            text-align: center;
            margin-bottom: 15px;
        }
        .fare-amount {
            font-size: 1.3em;
            font-weight: bold;
            color: #27ae60;
        }
        .button-group {
            display: flex;
            gap: 10px;
        }
        .btn {
            flex: 1;
            padding: 8px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            text-decoration: none;
            text-align: center;
            transition: all 0.3s;
        }
        .btn-cancel {
            background: #e74c3c;
            color: white;
        }
        .btn-cancel:hover {
            background: #c0392b;
        }
        .btn-cancel:disabled {
            background: #bdc3c7;
            cursor: not-allowed;
        }
        .btn-print {
            background: #3498db;
            color: white;
        }
        .btn-print:hover {
            background: #2980b9;
        }
        .no-bookings {
            text-align: center;
            padding: 40px;
            color: #666;
            background: white;
            border-radius: 10px;
        }
    </style>
</head>
<body>
    <div class="navbar">
        <h2>🚌 Bus Ticket Booking</h2>
        <div>
            <a href="<%= request.getContextPath() %>/dashboard">Book Tickets</a>
            <a href="<%= request.getContextPath() %>/logout">Logout</a>
        </div>
    </div>

    <div class="container">
        <a href="<%= request.getContextPath() %>/dashboard" class="back-btn">← Back to Dashboard</a>
        <h2>Your Booking History</h2>

        <%
            List<Booking> bookings = (List<Booking>) request.getAttribute("bookings");
            if (bookings != null && !bookings.isEmpty()) {
                BusDAO busDAO = new BusDAO();
        %>
        <div class="bookings-list">
            <% for (Booking booking : bookings) {
                    String statusClass = "confirmed".equals(booking.getStatus()) ? "confirmed" : "cancelled";
            %>
            <div class="booking-card">
                <div class="booking-header">
                    <div class="booking-id">Booking #<%= booking.getBookingId() %></div>
                    <span class="status <%= statusClass %>"><%= booking.getStatus().toUpperCase() %></span>
                </div>

                <div class="booking-details">
                    <div class="detail">
                        <span class="detail-label">Booking Date:</span>
                        <span class="detail-value"><%= booking.getBookingDate() %></span>
                    </div>
                    <div class="detail">
                        <span class="detail-label">Seat Number:</span>
                        <span class="detail-value"><%= booking.getSeatNumber() %></span>
                    </div>
                    <div class="detail">
                        <span class="detail-label">Bus ID:</span>
                        <span class="detail-value">Bus #<%= booking.getBusId() %></span>
                    </div>
                </div>

                <div class="fare-section">
                    <div style="color: #666; font-size: 0.9em;">Total Fare</div>
                    <div class="fare-amount">₹<%= booking.getTotalFare() %></div>
                </div>

                <div class="button-group">
                    <% if ("confirmed".equals(booking.getStatus())) { %>
                    <form method="post" action="<%= request.getContextPath() %>/cancelBooking" style="flex: 1;">
                        <input type="hidden" name="bookingId" value="<%= booking.getBookingId() %>">
                        <button type="submit" class="btn btn-cancel">Cancel Booking</button>
                    </form>
                    <% } %>
                    <button class="btn btn-print" onclick="alert('Print feature coming soon!')">Print Ticket</button>
                </div>
            </div>
            <% } %>
        </div>
        <% } else { %>
        <div class="no-bookings">
            <p>No bookings found. <a href="<%= request.getContextPath() %>/dashboard">Book a ticket now!</a></p>
        </div>
        <% } %>
    </div>
</body>
</html>
