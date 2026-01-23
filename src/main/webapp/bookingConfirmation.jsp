<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, com.example.model.Bus" %>
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
    <title>Booking Confirmation</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #0052CC 0%, #003d99 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        .container {
            background: white;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            max-width: 600px;
            width: 100%;
        }
        .success-header {
            text-align: center;
            margin-bottom: 30px;
        }
        .success-icon {
            font-size: 4em;
            margin-bottom: 10px;
        }
        h1 {
            color: #27ae60;
            margin-bottom: 10px;
        }
        .subtitle {
            color: #666;
            font-size: 1.1em;
        }
        .ticket-details {
            background: #f9f9f9;
            padding: 20px;
            border-radius: 10px;
            margin: 30px 0;
            border-left: 5px solid #0052CC;
        }
        .detail-row {
            display: flex;
            justify-content: space-between;
            padding: 12px 0;
            border-bottom: 1px solid #eee;
        }
        .detail-row:last-child {
            border-bottom: none;
        }
        .detail-label {
            color: #666;
            font-weight: 500;
        }
        .detail-value {
            color: #333;
            font-weight: bold;
        }
        .total-section {
            background: linear-gradient(135deg, #0052CC 0%, #003d99 100%);
            color: white;
            padding: 20px;
            border-radius: 10px;
            margin: 20px 0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .total-label {
            font-size: 1.2em;
        }
        .total-amount {
            font-size: 1.8em;
            font-weight: bold;
        }
        .booking-id {
            background: #e8f4f8;
            padding: 15px;
            border-radius: 8px;
            text-align: center;
            margin-bottom: 20px;
            border: 2px solid #0066FF;
        }
        .booking-id-label {
            color: #666;
            font-size: 0.9em;
        }
        .booking-id-value {
            color: #0052CC;
            font-size: 1.3em;
            font-weight: bold;
        }
        .button-group {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }
        .btn {
            flex: 1;
            padding: 12px;
            border: none;
            border-radius: 8px;
            font-size: 1em;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .btn-primary {
            background: #0052CC;
            color: white;
        }
        .btn-primary:hover {
            background: #003d99;
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(0, 82, 204, 0.3);
        }
        .btn-secondary {
            background: #f0f0f0;
            color: #333;
        }
        .btn-secondary:hover {
            background: #e0e0e0;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="success-header">
            <div class="success-icon">✅</div>
            <h1>Booking Confirmed!</h1>
            <p class="subtitle">Your ticket has been successfully booked</p>
        </div>

        <%
            Integer bookingId = (Integer) request.getAttribute("bookingId");
            Bus bus = (Bus) request.getAttribute("bus");
            String seatNumber = (String) request.getAttribute("seatNumber");
            Double fare = (Double) request.getAttribute("fare");

            if (bookingId != null && bus != null) {
        %>

        <div class="booking-id">
            <div class="booking-id-label">Booking Reference</div>
            <div class="booking-id-value">#BK<%= bookingId %></div>
        </div>

        <div class="ticket-details">
            <div class="detail-row">
                <span class="detail-label">Bus Name</span>
                <span class="detail-value"><%= bus.getBusName() %></span>
            </div>
            <div class="detail-row">
                <span class="detail-label">Route</span>
                <span class="detail-value"><%= bus.getDepartureLocation() %> → <%= bus.getArrivalLocation() %></span>
            </div>
            <div class="detail-row">
                <span class="detail-label">Date</span>
                <span class="detail-value"><%= bus.getDepartureDate() %></span>
            </div>
            <div class="detail-row">
                <span class="detail-label">Time</span>
                <span class="detail-value"><%= bus.getDepartureTime() %></span>
            </div>
            <div class="detail-row">
                <span class="detail-label">Seat Number</span>
                <span class="detail-value"><%= seatNumber %></span>
            </div>
            <%
                String ticketNumber = (String) request.getAttribute("ticketNumber");
                if (ticketNumber != null) {
            %>
            <div class="detail-row">
                <span class="detail-label">Ticket Number</span>
                <span class="detail-value"><%= ticketNumber %></span>
            </div>
            <% } %>
        </div>

        <div class="total-section">
            <span class="total-label">Total Amount</span>
            <span class="total-amount">$<%= String.format("%.2f", fare) %></span>
        </div>

        <p style="color: #666; text-align: center; margin-bottom: 20px;">
            ✅ Your ticket has been successfully booked! A confirmation email has been sent to your registered email address.
        </p>

        <div class="button-group">
            <a href="<%= request.getContextPath() %>/bookingHistory" class="btn btn-primary">📋 View My Tickets</a>
            <a href="<%= request.getContextPath() %>/dashboard" class="btn btn-secondary">🚌 Book Another Ticket</a>
        </div>

        <% } %>
    </div>
</body>
</html>
