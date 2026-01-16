package com.example.servlet;

import com.example.dao.BusDAO;
import com.example.model.Bus;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
    private BusDAO busDAO = new BusDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        List<Bus> buses = busDAO.getAllBuses();
        request.setAttribute("buses", buses);
        request.getRequestDispatcher("/dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String departure = request.getParameter("departure");
        String arrival = request.getParameter("arrival");
        String date = request.getParameter("date");

        List<Bus> buses = busDAO.searchBuses(departure, arrival, date);

        request.setAttribute("buses", buses);
        request.setAttribute("departure", departure);
        request.setAttribute("arrival", arrival);
        request.setAttribute("date", date);
        request.getRequestDispatcher("/dashboard.jsp").forward(request, response);
    }
}
