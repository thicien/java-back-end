package com.example.servlet;

import com.example.dao.BookingDAO;
import com.example.dao.BusDAO;
import com.example.dao.SeatDAO;
import com.example.model.Booking;
import com.example.model.Bus;
import com.example.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.UUID;

@WebServlet("/confirmBooking")
public class BookingServlet extends HttpServlet {
    private BusDAO busDAO = new BusDAO();
    private SeatDAO seatDAO = new SeatDAO();
    private BookingDAO bookingDAO = new BookingDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            int userId = user.getUserId();
            int busId = Integer.parseInt(request.getParameter("busId"));
            String seatNumber = request.getParameter("seatNumber");

            // Validate seat number
            if (seatNumber == null || seatNumber.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/seatSelection?busId=" + busId + "&error=Please select a seat");
                return;
            }

            // Check if seat is available
            if (!seatDAO.isSeatAvailable(busId, seatNumber)) {
                response.sendRedirect(request.getContextPath() + "/seatSelection?busId=" + busId + "&error=Seat is no longer available");
                return;
            }

            // Book the seat
            if (!seatDAO.bookSeat(busId, seatNumber)) {
                response.sendRedirect(request.getContextPath() + "/seatSelection?busId=" + busId + "&error=Failed to book seat");
                return;
            }

            // Get bus details
            Bus bus = busDAO.getBusById(busId);
            if (bus == null) {
                response.sendRedirect(request.getContextPath() + "/dashboard?error=Bus not found");
                return;
            }

            // Create booking with ticket number
            String ticketNumber = "TICKET-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
            Booking booking = new Booking(userId, busId, seatNumber, bus.getFare());
            booking.setTicketNumber(ticketNumber);
            booking.setPaymentStatus("completed");
            booking.setStatus("confirmed");

            // Save booking
            int bookingId = bookingDAO.createBooking(booking);

            if (bookingId > 0) {
                // Redirect to booking confirmation
                request.setAttribute("bookingId", bookingId);
                request.setAttribute("bus", bus);
                request.setAttribute("seatNumber", seatNumber);
                request.setAttribute("fare", bus.getFare());
                request.setAttribute("ticketNumber", ticketNumber);
                request.getRequestDispatcher("/bookingConfirmation.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/seatSelection?busId=" + busId + "&error=Booking failed");
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/dashboard?error=Invalid request");
        }
    }
}
