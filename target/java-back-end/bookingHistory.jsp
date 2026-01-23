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
    <title>My Tickets - Bus Booking</title>
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
            box-shadow: 0 2px 10px rgba(0, 82, 204, 0.2);
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
            max-width: 1200px;
            margin: 30px auto;
            padding: 0 20px;
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
        h2 {
            color: #0052CC;
            margin-bottom: 30px;
            font-size: 2em;
        }
        .bookings-list {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(380px, 1fr));
            gap: 25px;
        }
        .booking-card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 82, 204, 0.1);
            padding: 25px;
            border-top: 5px solid #0052CC;
            transition: all 0.3s ease;
        }
        .booking-card:hover {
            box-shadow: 0 8px 25px rgba(0, 82, 204, 0.2);
            transform: translateY(-5px);
        }
        .booking-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 2px solid #f0f0f0;
        }
        .booking-id {
            font-weight: bold;
            color: #0052CC;
            font-size: 1.2em;
        }
        .status {
            padding: 6px 15px;
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
            margin-bottom: 20px;
        }
        .detail {
            margin-bottom: 12px;
            display: flex;
            justify-content: space-between;
            padding: 8px 0;
        }
        .detail-label {
            font-weight: 600;
            color: #333;
        }
        .detail-value {
            color: #0052CC;
            font-weight: 500;
        }
        .fare-section {
            background: linear-gradient(135deg, #0052CC 0%, #003d99 100%);
            padding: 15px;
            border-radius: 8px;
            text-align: center;
            margin-bottom: 20px;
            color: white;
        }
        .fare-label {
            font-size: 0.9em;
            opacity: 0.9;
        }
        .fare-amount {
            font-size: 1.8em;
            font-weight: bold;
        }
        .button-group {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }
        .btn {
            flex: 1;
            min-width: 100px;
            padding: 10px 15px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 600;
            text-decoration: none;
            text-align: center;
            transition: all 0.3s;
            font-size: 0.95em;
        }
        .btn-delete {
            background: #e74c3c;
            color: white;
        }
        .btn-delete:hover {
            background: #c0392b;
            transform: translateY(-2px);
        }
        .btn-delete:disabled {
            background: #bdc3c7;
            cursor: not-allowed;
        }
        .btn-edit {
            background: #3498db;
            color: white;
        }
        .btn-edit:hover {
            background: #2980b9;
            transform: translateY(-2px);
        }
        .btn-download {
            background: #27ae60;
            color: white;
        }
        .btn-download:hover {
            background: #229954;
            transform: translateY(-2px);
        }
        .no-bookings {
            text-align: center;
            padding: 60px 20px;
            color: #666;
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        .no-bookings h3 {
            color: #0052CC;
            margin-bottom: 15px;
        }
        .no-bookings a {
            display: inline-block;
            margin-top: 15px;
            padding: 12px 30px;
            background: #0052CC;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            font-weight: 600;
            transition: all 0.3s;
        }
        .no-bookings a:hover {
            background: #003d99;
        }
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
        }
        .modal-content {
            background-color: white;
            margin: 5% auto;
            padding: 30px;
            border-radius: 12px;
            width: 80%;
            max-width: 500px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
        }
        .modal-header {
            color: #0052CC;
            font-size: 1.5em;
            margin-bottom: 20px;
            font-weight: bold;
        }
        .modal-body {
            margin-bottom: 20px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #333;
            font-weight: 600;
        }
        .form-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 1em;
        }
        .form-group input:focus {
            outline: none;
            border-color: #0052CC;
            box-shadow: 0 0 5px rgba(0, 82, 204, 0.3);
        }
        .modal-buttons {
            display: flex;
            gap: 10px;
        }
        .modal-buttons button {
            flex: 1;
            padding: 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
        }
        .modal-buttons .btn-save {
            background: #0052CC;
            color: white;
        }
        .modal-buttons .btn-save:hover {
            background: #003d99;
        }
        .modal-buttons .btn-cancel-modal {
            background: #bdc3c7;
            color: #333;
        }
        .modal-buttons .btn-cancel-modal:hover {
            background: #95a5a6;
        }
        @media (max-width: 768px) {
            .navbar {
                flex-direction: column;
                gap: 15px;
            }
            .bookings-list {
                grid-template-columns: 1fr;
            }
            .button-group {
                flex-direction: column;
            }
            .btn {
                min-width: unset;
            }
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
        <h2>📋 Your Tickets</h2>

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
                    <div class="booking-id">Ticket #<%= booking.getBookingId() %></div>
                    <span class="status <%= statusClass %>"><%= booking.getStatus().toUpperCase() %></span>
                </div>

                <div class="booking-details">
                    <div class="detail">
                        <span class="detail-label">🚍 Bus ID:</span>
                        <span class="detail-value">Bus #<%= booking.getBusId() %></span>
                    </div>
                    <div class="detail">
                        <span class="detail-label">🪑 Seat:</span>
                        <span class="detail-value"><%= booking.getSeatNumber() %></span>
                    </div>
                    <div class="detail">
                        <span class="detail-label">📅 Booking Date:</span>
                        <span class="detail-value"><%= booking.getBookingDate() %></span>
                    </div>
                    <div class="detail">
                        <span class="detail-label">🎫 Ticket No:</span>
                        <span class="detail-value"><%= booking.getTicketNumber() != null ? booking.getTicketNumber() : "N/A" %></span>
                    </div>
                </div>

                <div class="fare-section">
                    <div class="fare-label">Total Fare</div>
                    <div class="fare-amount">$<%= String.format("%.2f", booking.getTotalFare()) %></div>
                </div>

                <div class="button-group">
                    <% if ("confirmed".equals(booking.getStatus())) { %>
                        <button class="btn btn-edit" onclick="openEditModal(<%= booking.getBookingId() %>, '<%= booking.getSeatNumber() %>', <%= booking.getTotalFare() %>)">✏️ Edit</button>
                    <% } %>
                    <button class="btn btn-download" onclick="alert('Download feature coming soon!')">⬇️ Download</button>
                    <% if ("confirmed".equals(booking.getStatus())) { %>
                        <form method="post" action="<%= request.getContextPath() %>/deleteBooking" style="flex: 1;">
                            <input type="hidden" name="bookingId" value="<%= booking.getBookingId() %>">
                            <button type="submit" class="btn btn-delete" onclick="return confirm('Are you sure you want to delete this ticket?')">🗑️ Delete</button>
                        </form>
                    <% } %>
                </div>
            </div>
            <% } %>
        </div>
        <% } else { %>
        <div class="no-bookings">
            <h3>No Tickets Found</h3>
            <p>You haven't booked any tickets yet. Start by selecting a bus from our dashboard!</p>
            <a href="<%= request.getContextPath() %>/dashboard">Book Your First Ticket</a>
        </div>
        <% } %>
    </div>

    <!-- Edit Booking Modal -->
    <div id="editModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">Edit Your Ticket</div>
            <form method="post" action="<%= request.getContextPath() %>/updateBooking">
                <div class="modal-body">
                    <input type="hidden" name="bookingId" id="bookingId">
                    
                    <div class="form-group">
                        <label for="seatNumber">Seat Number</label>
                        <input type="text" id="seatNumber" name="seatNumber" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="totalFare">Total Fare ($)</label>
                        <input type="number" id="totalFare" name="totalFare" step="0.01" required>
                    </div>
                </div>
                
                <div class="modal-buttons">
                    <button type="submit" class="btn-save">Save Changes</button>
                    <button type="button" class="btn-cancel-modal" onclick="closeEditModal()">Cancel</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        function openEditModal(bookingId, seatNumber, totalFare) {
            document.getElementById('bookingId').value = bookingId;
            document.getElementById('seatNumber').value = seatNumber;
            document.getElementById('totalFare').value = totalFare;
            document.getElementById('editModal').style.display = 'block';
        }

        function closeEditModal() {
            document.getElementById('editModal').style.display = 'none';
        }

        // Close modal when clicking outside of it
        window.onclick = function(event) {
            var modal = document.getElementById('editModal');
            if (event.target == modal) {
                modal.style.display = 'none';
            }
        }
    </script>
</body>
</html>
