package com.example.servlet;

import com.example.dao.BookingDAO;
import com.example.model.Booking;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.UUID;

@WebServlet("/processPayment")
public class PaymentServlet extends HttpServlet {
    private BookingDAO bookingDAO = new BookingDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
        String paymentMethod = request.getParameter("paymentMethod");
        String cardNumber = request.getParameter("cardNumber");

        // Validate payment details (basic validation)
        if (cardNumber == null || cardNumber.length() < 13) {
            request.setAttribute("error", "Invalid card number");
            request.getRequestDispatcher("/payment.jsp?bookingId=" + bookingId).forward(request, response);
            return;
        }

        // Get the booking
        Booking booking = bookingDAO.getBookingById(bookingId);
        if (booking == null) {
            request.setAttribute("error", "Booking not found");
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }

        // Process payment (simulated)
        // In a real application, integrate with payment gateway (Stripe, PayPal, etc.)
        String ticketNumber = "TICKET-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();

        // Update payment status and ticket number
        booking.setPaymentStatus("completed");
        booking.setTicketNumber(ticketNumber);
        bookingDAO.updatePaymentStatus(bookingId, "completed");

        request.setAttribute("booking", booking);
        request.setAttribute("ticketNumber", ticketNumber);
        request.getRequestDispatcher("/ticketDownload.jsp?bookingId=" + bookingId).forward(request, response);
    }
}
