package com.example.servlet;

import com.example.dao.BusDAO;
import com.example.dao.SeatDAO;
import com.example.model.Bus;
import com.example.model.Seat;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/seatSelection")
public class SeatSelectionServlet extends HttpServlet {
    private BusDAO busDAO = new BusDAO();
    private SeatDAO seatDAO = new SeatDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String busIdParam = request.getParameter("busId");
        if (busIdParam == null || busIdParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }

        int busId = Integer.parseInt(busIdParam);
        Bus bus = busDAO.getBusById(busId);
        List<Seat> seats = seatDAO.getSeatsByBusId(busId);

        request.setAttribute("bus", bus);
        request.setAttribute("seats", seats);
        request.getRequestDispatcher("/seatSelection.jsp").forward(request, response);
    }
}
