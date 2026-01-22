<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.example.dao.BookingDAO, com.example.model.Booking, com.example.model.User" %>
<%
    // Check if user is logged in
    if (session.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    
    int bookingId = Integer.parseInt(request.getParameter("bookingId"));
    BookingDAO bookingDAO = new BookingDAO();
    Booking booking = bookingDAO.getBookingById(bookingId);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment - Bus Ticket Booking</title>
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
        .payment-container {
            background: white;
            border-radius: 10px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
            max-width: 500px;
            width: 100%;
            padding: 40px;
        }
        h1 {
            color: #333;
            margin-bottom: 30px;
            text-align: center;
        }
        .booking-summary {
            background: #f9f9f9;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 30px;
        }
        .summary-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            color: #666;
        }
        .summary-item strong {
            color: #333;
        }
        .summary-total {
            display: flex;
            justify-content: space-between;
            padding-top: 10px;
            border-top: 1px solid #ddd;
            font-size: 1.2em;
            font-weight: bold;
            color: #0052CC;
        }
        .form-group {
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: bold;
        }
        input, select {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 1em;
        }
        input:focus, select:focus {
            outline: none;
            border-color: #0052CC;
            box-shadow: 0 0 5px rgba(0, 82, 204, 0.3);
        }
        .card-grid {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 10px;
        }
        .pay-btn {
            width: 100%;
            padding: 12px;
            background: linear-gradient(135deg, #0052CC 0%, #003d99 100%);
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            font-size: 1.1em;
            margin-top: 20px;
            transition: opacity 0.3s;
        }
        .pay-btn:hover {
            opacity: 0.9;
        }
        .error-msg {
            color: #d32f2f;
            background: #ffebee;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="payment-container">
        <h1>Payment Gateway</h1>
        
        <% if (booking != null) { %>
            <div class="booking-summary">
                <div class="summary-item">
                    <span>Booking ID:</span>
                    <strong><%= booking.getBookingId() %></strong>
                </div>
                <div class="summary-item">
                    <span>Seat:</span>
                    <strong><%= booking.getSeatNumber() %></strong>
                </div>
                <div class="summary-item">
                    <span>Booking Date:</span>
                    <strong><%= booking.getBookingDate() %></strong>
                </div>
                <div class="summary-total">
                    <span>Total Amount:</span>
                    <span>₹<%= booking.getTotalFare() %></span>
                </div>
            </div>

            <% if (request.getParameter("error") != null) { %>
                <div class="error-msg"><%= request.getParameter("error") %></div>
            <% } %>

            <form method="POST" action="<%= request.getContextPath() %>/processPayment">
                <input type="hidden" name="bookingId" value="<%= booking.getBookingId() %>">

                <div class="form-group">
                    <label>Payment Method</label>
                    <select name="paymentMethod" required>
                        <option value="">Select Payment Method</option>
                        <option value="credit_card">Credit Card</option>
                        <option value="debit_card">Debit Card</option>
                        <option value="upi">UPI</option>
                        <option value="net_banking">Net Banking</option>
                    </select>
                </div>

                <div class="form-group">
                    <label>Card Number</label>
                    <input type="text" name="cardNumber" placeholder="1234 5678 9012 3456" maxlength="16" required>
                </div>

                <div class="card-grid">
                    <div class="form-group">
                        <label>Expiry Date</label>
                        <input type="text" name="expiryDate" placeholder="MM/YY" maxlength="5" required>
                    </div>
                    <div class="form-group">
                        <label>CVV</label>
                        <input type="text" name="cvv" placeholder="123" maxlength="3" required>
                    </div>
                </div>

                <div class="form-group">
                    <label>Card Holder Name</label>
                    <input type="text" name="cardHolderName" placeholder="John Doe" required>
                </div>

                <button type="submit" class="pay-btn">Pay ₹<%= booking.getTotalFare() %></button>
            </form>
        <% } else { %>
            <p style="color: red;">Booking not found. <a href="<%= request.getContextPath() %>/dashboard">Go back to dashboard</a></p>
        <% } %>
    </div>
</body>
</html>
