package com.example.servlet;

import com.example.dao.BookingDAO;
import com.example.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/deleteBooking")
public class DeleteBookingServlet extends HttpServlet {
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
            
            BookingDAO bookingDAO = new BookingDAO();
            
            // Delete the booking
            boolean success = bookingDAO.deleteBooking(bookingId);
            
            if (success) {
                // Redirect back to booking history with success message
                response.sendRedirect(request.getContextPath() + "/bookingHistory?message=Ticket deleted successfully");
            } else {
                // Redirect with error message
                response.sendRedirect(request.getContextPath() + "/bookingHistory?error=Failed to delete ticket");
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/bookingHistory?error=Invalid booking ID");
        }
    }
}
