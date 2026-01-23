package com.example.servlet;

import com.example.dao.BookingDAO;
import com.example.model.Booking;
import com.example.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/updateBooking")
public class UpdateBookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if user is logged in
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));
            String seatNumber = request.getParameter("seatNumber");
            double totalFare = Double.parseDouble(request.getParameter("totalFare"));
            
            // Validate inputs
            if (seatNumber == null || seatNumber.trim().isEmpty() || totalFare <= 0) {
                response.sendRedirect(request.getContextPath() + "/bookingHistory?error=Invalid seat number or fare");
                return;
            }
            
            BookingDAO bookingDAO = new BookingDAO();
            Booking booking = bookingDAO.getBookingById(bookingId);
            
            if (booking == null || booking.getUserId() != user.getUserId()) {
                response.sendRedirect(request.getContextPath() + "/bookingHistory?error=Invalid booking");
                return;
            }
            
            // Update the booking
            booking.setSeatNumber(seatNumber.toUpperCase());
            booking.setTotalFare(totalFare);
            
            boolean success = bookingDAO.updateBooking(booking);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/bookingHistory?message=Ticket updated successfully");
            } else {
                response.sendRedirect(request.getContextPath() + "/bookingHistory?error=Failed to update ticket");
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/bookingHistory?error=Invalid input");
        }
    }
}
