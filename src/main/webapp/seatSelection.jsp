<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, com.example.model.Bus, com.example.model.Seat" %>
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
    <title>Select Seats - Bus Booking</title>
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
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 20px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .container {
            max-width: 900px;
            margin: 30px auto;
            padding: 0 20px;
        }
        .bus-info {
            background: white;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 30px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        .bus-info h2 {
            color: #333;
            margin-bottom: 15px;
        }
        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
        }
        .info-item {
            padding: 10px;
            background: #f9f9f9;
            border-radius: 5px;
        }
        .seat-section {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        .seat-section h3 {
            margin-bottom: 20px;
            color: #333;
        }
        .seats-grid {
            display: grid;
            grid-template-columns: repeat(6, 1fr);
            gap: 15px;
            margin-bottom: 30px;
        }
        .seat {
            width: 100%;
            aspect-ratio: 1;
            border: 2px solid #ddd;
            border-radius: 8px;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            transition: all 0.3s;
            background: white;
        }
        .seat.available:hover {
            border-color: #667eea;
            background: #f0f5ff;
        }
        .seat.booked {
            background: #ddd;
            cursor: not-allowed;
            color: #999;
        }
        .seat.selected {
            background: #667eea;
            color: white;
            border-color: #667eea;
        }
        .seat-legend {
            display: flex;
            gap: 30px;
            margin-bottom: 20px;
            justify-content: center;
        }
        .legend-item {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .legend-box {
            width: 30px;
            height: 30px;
            border-radius: 5px;
            border: 2px solid #ddd;
        }
        .legend-box.available {
            background: white;
        }
        .legend-box.booked {
            background: #ddd;
        }
        .legend-box.selected {
            background: #87CEEB;
            border-color: #0066FF;
        }
        .selected-seats {
            background: #f0f5ff;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            min-height: 40px;
        }
        .book-btn {
            width: 100%;
            padding: 12px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            font-size: 1.1em;
        }
        .book-btn:hover {
            opacity: 0.9;
        }
        .book-btn:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }
        .total-fare {
            margin-top: 20px;
            padding: 15px;
            background: #f0f0f0;
            border-radius: 5px;
            font-size: 1.1em;
            color: #333;
        }
        .back-btn {
            display: inline-block;
            margin-bottom: 20px;
            padding: 10px 20px;
            background: #667eea;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <div class="navbar">
        <h2>🚌 Bus Ticket Booking</h2>
        <div>
            <a href="<%= request.getContextPath() %>/dashboard" style="color: white; text-decoration: none;">Back to Dashboard</a>
        </div>
    </div>

    <div class="container">
        <a href="<%= request.getContextPath() %>/dashboard" class="back-btn">← Back to Buses</a>

        <%
            Bus bus = (Bus) request.getAttribute("bus");
            List<Seat> seats = (List<Seat>) request.getAttribute("seats");
            if (bus != null) {
        %>
        <div class="bus-info">
            <h2><%= bus.getBusName() %></h2>
            <div class="info-grid">
                <div class="info-item">
                    <strong>Route:</strong> <%= bus.getDepartureLocation() %> → <%= bus.getArrivalLocation() %>
                </div>
                <div class="info-item">
                    <strong>Date:</strong> <%= bus.getDepartureDate() %>
                </div>
                <div class="info-item">
                    <strong>Time:</strong> <%= bus.getDepartureTime() %>
                </div>
                <div class="info-item">
                    <strong>Fare per Seat:</strong> ₹<%= bus.getFare() %>
                </div>
            </div>
        </div>

        <div class="seat-section">
            <h3>Select Your Seats</h3>

            <div class="seat-legend">
                <div class="legend-item">
                    <div class="legend-box available"></div>
                    <span>Available</span>
                </div>
                <div class="legend-item">
                    <div class="legend-box booked"></div>
                    <span>Booked</span>
                </div>
                <div class="legend-item">
                    <div class="legend-box selected"></div>
                    <span>Selected</span>
                </div>
            </div>

            <form method="post" action="<%= request.getContextPath() %>/confirmBooking" id="bookingForm">
                <input type="hidden" name="busId" value="<%= bus.getBusId() %>">
                <input type="hidden" name="seatNumber" id="seatNumber" value="">

                <div class="seats-grid" id="seatsGrid">
                    <%
                        if (seats != null) {
                            for (Seat seat : seats) {
                                String seatClass = "seat " + (seat.isAvailable() ? "available" : "booked");
                    %>
                    <div class="<%= seatClass %>" onclick="toggleSeat(this, '<%= seat.getSeatNumber() %>')" data-seat="<%= seat.getSeatNumber() %>" <%= seat.isAvailable() ? "" : "disabled" %>>
                        <%= seat.getSeatNumber() %>
                    </div>
                    <%
                            }
                        }
                    %>
                </div>

                <div class="selected-seats">
                    <strong>Selected Seats:</strong> <span id="selectedList">None</span>
                </div>

                <div class="total-fare">
                    <strong>Total Fare:</strong> ₹<span id="totalFare">0</span>
                </div>

                <button type="submit" class="book-btn" id="bookBtn" disabled>Confirm Booking</button>
            </form>
        </div>
        <% } %>
    </div>

    <script>
        let selectedSeats = [];
        const fare = <%= bus != null ? bus.getFare() : 0 %>;

        function toggleSeat(element, seatNumber) {
            if (element.classList.contains('booked')) return;

            element.classList.toggle('selected');

            if (element.classList.contains('selected')) {
                selectedSeats.push(seatNumber);
            } else {
                selectedSeats = selectedSeats.filter(s => s !== seatNumber);
            }

            updateSeatInfo();
        }

        function updateSeatInfo() {
            document.getElementById('selectedList').textContent = selectedSeats.length > 0 ? selectedSeats.join(', ') : 'None';
            document.getElementById('totalFare').textContent = (selectedSeats.length * fare).toFixed(2);
            document.getElementById('bookBtn').disabled = selectedSeats.length === 0;

            // For now, we book one seat at a time
            if (selectedSeats.length > 0) {
                document.getElementById('seatNumber').value = selectedSeats[0];
            }
        }
    </script>
</body>
</html>
