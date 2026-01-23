package com.example.servlet;

import com.example.dao.SeatDAO;
import com.example.dao.BusDAO;
import com.example.model.Seat;
import com.example.model.Bus;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/debugSeats")
public class DebugSeatsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        out.println("<html><head><title>Debug Seats</title>");
        out.println("<style>");
        out.println("body { font-family: Arial; padding: 20px; background: #f0f0f0; }");
        out.println(".bus { background: white; padding: 15px; margin: 10px 0; border-radius: 8px; border-left: 5px solid #0052CC; }");
        out.println(".seats { display: grid; grid-template-columns: repeat(6, 1fr); gap: 5px; margin-top: 10px; }");
        out.println(".seat { padding: 10px; text-align: center; background: #e8e8e8; border-radius: 4px; }");
        out.println(".seat.available { background: #d4edda; color: green; font-weight: bold; }");
        out.println(".seat.booked { background: #f8d7da; color: red; }");
        out.println("h1 { color: #0052CC; }");
        out.println("</style></head><body>");
        
        out.println("<h1>🔍 Seat Database Debug</h1>");
        
        try {
            BusDAO busDAO = new BusDAO();
            SeatDAO seatDAO = new SeatDAO();
            
            List<Bus> buses = busDAO.getAllBuses();
            out.println("<p><strong>Total Buses:</strong> " + (buses != null ? buses.size() : 0) + "</p>");
            
            if (buses != null && !buses.isEmpty()) {
                for (Bus bus : buses) {
                    List<Seat> seats = seatDAO.getSeatsByBusId(bus.getBusId());
                    out.println("<div class='bus'>");
                    out.println("<h3>" + bus.getBusName() + " (Bus ID: " + bus.getBusId() + ")</h3>");
                    out.println("<p><strong>Total Seats:</strong> " + (seats != null ? seats.size() : 0) + "</p>");
                    
                    if (seats != null && !seats.isEmpty()) {
                        out.println("<div class='seats'>");
                        for (Seat seat : seats) {
                            String seatClass = seat.isAvailable() ? "available" : "booked";
                            out.println("<div class='seat " + seatClass + "'>" + seat.getSeatNumber() + "</div>");
                        }
                        out.println("</div>");
                    } else {
                        out.println("<p style='color: red;'><strong>❌ NO SEATS FOUND for this bus!</strong></p>");
                    }
                    out.println("</div>");
                }
            } else {
                out.println("<p style='color: red;'><strong>❌ NO BUSES FOUND!</strong></p>");
            }
            
            out.println("<hr>");
            out.println("<h2>Quick Fix Instructions:</h2>");
            out.println("<ol>");
            out.println("<li><a href='" + request.getContextPath() + "/initializeSeats'>Click here to Initialize Seats</a></li>");
            out.println("<li>Wait for success message</li>");
            out.println("<li>Then go to <a href='" + request.getContextPath() + "/dashboard'>Dashboard</a> and try booking</li>");
            out.println("</ol>");
            
        } catch (Exception e) {
            out.println("<p style='color: red;'><strong>Error:</strong> " + e.getMessage() + "</p>");
            e.printStackTrace(out);
        }
        
        out.println("</body></html>");
    }
}
