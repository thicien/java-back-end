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
            background: #0052CC;
            color: white;
            padding: 20px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.15);
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
            font-size: 0.9em;
        }
        .seat.available {
            background: white;
            border-color: #0052CC;
            color: #333;
            cursor: pointer;
        }
        .seat.available:hover {
            border-color: #0052CC;
            background: #f0f5ff;
            transform: scale(1.05);
            box-shadow: 0 2px 8px rgba(0, 82, 204, 0.3);
        }
        .seat.booked {
            background: #ddd;
            border-color: #999;
            cursor: not-allowed;
            color: #999;
            opacity: 0.6;
        }
        .seat.selected {
            background: #0052CC;
            color: white;
            border-color: #0052CC;
            font-weight: bold;
            box-shadow: 0 0 10px rgba(0, 82, 204, 0.5);
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
            background: #0052CC;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            font-size: 1.1em;
            transition: all 0.3s;
        }
        .book-btn:hover {
            background: #003d99;
            transform: translateY(-2px);
        }
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
            background: #0052CC;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            transition: all 0.3s;
        }

        .back-btn:hover {
            background: #003d99;
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
                        if (seats != null && !seats.isEmpty()) {
                            for (Seat seat : seats) {
                                boolean isAvailable = seat.isAvailable();
                                String seatClass = "seat " + (isAvailable ? "available" : "booked");
                    %>
                    <div class="<%= seatClass %>" 
                         <% if (isAvailable) { %>
                         onclick="toggleSeat(this, '<%= seat.getSeatNumber() %>')" 
                         <% } %>
                         data-seat="<%= seat.getSeatNumber() %>">
                        <%= seat.getSeatNumber() %>
                    </div>
                    <%
                            }
                        } else {
                    %>
                    <div style="grid-column: 1 / -1; text-align: center; padding: 20px; color: #666;">
                        No seats available for this bus
                    </div>
                    <%
                        }
                    %>
                </div>

                <div class="selected-seats">
                    <strong>Selected Seats:</strong> <span id="selectedList">None</span>
                </div>

                <div class="total-fare">
                    <strong>Total Fare:</strong> $<span id="totalFare">0.00</span>
                </div>

                <button type="submit" class="book-btn" id="bookBtn" disabled>Confirm Booking</button>
            </form>
        </div>
        <% } %>
    </div>

    <script>
        let selectedSeats = [];
        const fare = <%= bus != null ? bus.getFare() : 0 %>;

        console.log('Seat Selection Page Loaded');
        console.log('Bus Fare:', fare);
        console.log('Total Seats Rendered:', document.querySelectorAll('.seat').length);

        // Attach click handlers to all available seats
        document.addEventListener('DOMContentLoaded', function() {
            console.log('DOM Content Loaded');
            const availableSeats = document.querySelectorAll('.seat.available');
            console.log('Available seats found:', availableSeats.length);
            
            availableSeats.forEach(function(seatElement) {
                seatElement.addEventListener('click', function(e) {
                    console.log('Seat clicked:', this.getAttribute('data-seat'));
                    toggleSeat(this, this.getAttribute('data-seat'));
                });
            });
        });

        function toggleSeat(element, seatNumber) {
            console.log('toggleSeat called with:', seatNumber);
            
            if (element.classList.contains('booked')) {
                console.log('Seat is booked, ignoring click');
                alert('This seat is already booked');
                return;
            }

            const isSelected = element.classList.contains('selected');
            console.log('Is currently selected:', isSelected);
            
            if (isSelected) {
                element.classList.remove('selected');
                selectedSeats = selectedSeats.filter(s => s !== seatNumber);
                console.log('Removed seat:', seatNumber);
            } else {
                element.classList.add('selected');
                selectedSeats.push(seatNumber);
                console.log('Added seat:', seatNumber);
            }

            console.log('Selected seats now:', selectedSeats);
            updateSeatInfo();
        }

        function updateSeatInfo() {
            const selectedDisplay = selectedSeats.length > 0 ? selectedSeats.join(', ') : 'None';
            document.getElementById('selectedList').textContent = selectedDisplay;
            
            const total = (selectedSeats.length * fare).toFixed(2);
            document.getElementById('totalFare').textContent = total;
            
            const bookBtn = document.getElementById('bookBtn');
            bookBtn.disabled = selectedSeats.length === 0;
            console.log('Button enabled:', !bookBtn.disabled);
            
            if (selectedSeats.length > 0) {
                document.getElementById('seatNumber').value = selectedSeats[0];
            } else {
                document.getElementById('seatNumber').value = '';
            }
        }

        // Initialize on page load
        window.addEventListener('load', function() {
            console.log('Window loaded');
            updateSeatInfo();
        });
    </script>
</body>
</html>
