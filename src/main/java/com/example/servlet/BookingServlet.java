package com.example.servlet;

import com.example.dao.BookingDAO;
import com.example.dao.BusDAO;
import com.example.dao.SeatDAO;
import com.example.model.Booking;
import com.example.model.Bus;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/confirmBooking")
public class BookingServlet extends HttpServlet {
    private BusDAO busDAO = new BusDAO();
    private SeatDAO seatDAO = new SeatDAO();
    private BookingDAO bookingDAO = new BookingDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        int busId = Integer.parseInt(request.getParameter("busId"));
        String seatNumber = request.getParameter("seatNumber");

        // Check if seat is available
        if (!seatDAO.isSeatAvailable(busId, seatNumber)) {
            request.setAttribute("error", "Seat is no longer available");
            response.sendRedirect(request.getContextPath() + "/seatSelection?busId=" + busId);
            return;
        }

        // Book the seat
        if (seatDAO.bookSeat(busId, seatNumber)) {
            Bus bus = busDAO.getBusById(busId);
            Booking booking = new Booking(userId, busId, seatNumber, bus.getFare());
            int bookingId = bookingDAO.createBooking(booking);

            request.setAttribute("bookingId", bookingId);
            request.setAttribute("bus", bus);
            request.setAttribute("seatNumber", seatNumber);
            request.setAttribute("fare", bus.getFare());
            request.getRequestDispatcher("/bookingConfirmation.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Booking failed. Please try again.");
            response.sendRedirect(request.getContextPath() + "/seatSelection?busId=" + busId);
        }
    }
}
