<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.example.dao.BookingDAO, com.example.dao.BusDAO, com.example.model.Booking, com.example.model.Bus, com.example.model.User" %>
<%
    // Check if user is logged in
    if (session.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    
    int bookingId = Integer.parseInt(request.getParameter("bookingId"));
    BookingDAO bookingDAO = new BookingDAO();
    BusDAO busDAO = new BusDAO();
    Booking booking = bookingDAO.getBookingById(bookingId);
    Bus bus = busDAO.getBusById(booking.getBusId());
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Ticket - Bus Booking</title>
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
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        .ticket-container {
            background: white;
            border-radius: 10px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
            max-width: 600px;
            width: 100%;
            overflow: hidden;
        }
        .ticket-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 30px;
            text-align: center;
        }
        .ticket-header h1 {
            font-size: 2em;
            margin-bottom: 10px;
        }
        .ticket-header p {
            opacity: 0.9;
        }
        .ticket-number {
            background: rgba(255,255,255,0.2);
            padding: 15px;
            border-radius: 5px;
            margin-top: 15px;
            font-weight: bold;
            font-size: 1.1em;
        }
        .ticket-body {
            padding: 40px 30px;
        }
        .ticket-section {
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 1px solid #eee;
        }
        .ticket-section:last-child {
            border-bottom: none;
        }
        .section-title {
            color: #667eea;
            font-weight: bold;
            margin-bottom: 15px;
            font-size: 0.9em;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        .ticket-info {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-bottom: 20px;
        }
        .info-block {
            background: #f9f9f9;
            padding: 15px;
            border-radius: 5px;
        }
        .info-label {
            color: #999;
            font-size: 0.85em;
            margin-bottom: 5px;
        }
        .info-value {
            color: #333;
            font-weight: bold;
            font-size: 1.1em;
        }
        .route-section {
            display: grid;
            grid-template-columns: 1fr auto 1fr;
            gap: 20px;
            align-items: center;
            margin-bottom: 20px;
        }
        .station {
            background: #f9f9f9;
            padding: 15px;
            border-radius: 5px;
            text-align: center;
        }
        .station-name {
            font-weight: bold;
            color: #333;
            font-size: 1.1em;
        }
        .station-time {
            color: #667eea;
            font-weight: bold;
            margin-top: 5px;
        }
        .arrow {
            color: #667eea;
            font-size: 1.5em;
        }
        .ticket-footer {
            background: #f9f9f9;
            padding: 20px 30px;
            display: flex;
            gap: 10px;
            justify-content: center;
        }
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            text-decoration: none;
            transition: all 0.3s;
        }
        .btn-download {
            background: #667eea;
            color: white;
        }
        .btn-download:hover {
            background: #5568d3;
        }
        .btn-home {
            background: #f0f0f0;
            color: #333;
        }
        .btn-home:hover {
            background: #e0e0e0;
        }
        .success-msg {
            background: #e8f5e9;
            color: #2e7d32;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            text-align: center;
        }
        @media print {
            body {
                background: white;
            }
            .ticket-footer {
                display: none;
            }
        }
    </style>
</head>
<body>
    <div class="ticket-container">
        <div class="ticket-header">
            <h1>✓ Booking Confirmed</h1>
            <p>Your ticket has been successfully booked</p>
            <div class="ticket-number">
                Ticket #: <%= booking.getTicketNumber() %>
            </div>
        </div>

        <div class="ticket-body">
            <div class="success-msg">
                Payment completed successfully! Your ticket is ready to download.
            </div>

            <div class="ticket-section">
                <div class="section-title">Bus Details</div>
                <div class="ticket-info">
                    <div class="info-block">
                        <div class="info-label">Bus Name</div>
                        <div class="info-value"><%= bus.getBusName() %></div>
                    </div>
                    <div class="info-block">
                        <div class="info-label">Bus Number</div>
                        <div class="info-value"><%= bus.getBusNumber() %></div>
                    </div>
                </div>
            </div>

            <div class="ticket-section">
                <div class="section-title">Journey Details</div>
                <div class="route-section">
                    <div class="station">
                        <div class="station-name"><%= bus.getDepartureLocation() %></div>
                        <div class="station-time"><%= bus.getDepartureTime() %></div>
                    </div>
                    <div class="arrow">→</div>
                    <div class="station">
                        <div class="station-name"><%= bus.getArrivalLocation() %></div>
                        <div class="station-time">Est. Arrival</div>
                    </div>
                </div>
                <div class="ticket-info">
                    <div class="info-block">
                        <div class="info-label">Date of Journey</div>
                        <div class="info-value"><%= bus.getDepartureDate() %></div>
                    </div>
                    <div class="info-block">
                        <div class="info-label">Bus Type</div>
                        <div class="info-value"><%= bus.getBusType() != null ? bus.getBusType() : "AC Seater" %></div>
                    </div>
                </div>
            </div>

            <div class="ticket-section">
                <div class="section-title">Passenger & Seat Details</div>
                <div class="ticket-info">
                    <div class="info-block">
                        <div class="info-label">Seat Number</div>
                        <div class="info-value"><%= booking.getSeatNumber() %></div>
                    </div>
                    <div class="info-block">
                        <div class="info-label">Fare</div>
                        <div class="info-value">₹<%= booking.getTotalFare() %></div>
                    </div>
                </div>
            </div>

            <div class="ticket-section" style="border-bottom: none;">
                <div class="section-title">Booking Information</div>
                <div class="ticket-info">
                    <div class="info-block">
                        <div class="info-label">Booking ID</div>
                        <div class="info-value"><%= booking.getBookingId() %></div>
                    </div>
                    <div class="info-block">
                        <div class="info-label">Booking Date</div>
                        <div class="info-value"><%= booking.getBookingDate() %></div>
                    </div>
                </div>
            </div>
        </div>

        <div class="ticket-footer">
            <button class="btn btn-download" onclick="window.print()">Print Ticket</button>
            <a href="<%= request.getContextPath() %>/dashboard" class="btn btn-home">Back to Dashboard</a>
        </div>
    </div>
</body>
</html>
