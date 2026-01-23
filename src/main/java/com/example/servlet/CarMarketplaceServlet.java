package com.example.servlet;

import com.example.dao.CarDAO;
import com.example.model.Car;
import com.example.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/carMarketplace")
public class CarMarketplaceServlet extends HttpServlet {
    private CarDAO carDAO = new CarDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Get all cars
        List<Car> cars = carDAO.getAllCars();
        request.setAttribute("cars", cars);

        // Forward to car marketplace JSP
        request.getRequestDispatcher("/carMarketplace.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");

        if ("search".equals(action)) {
            String brand = request.getParameter("brand");
            List<Car> cars = carDAO.searchByBrand(brand);
            request.setAttribute("cars", cars);
            request.setAttribute("searchBrand", brand);
        } else if ("filter".equals(action)) {
            String engineType = request.getParameter("engineType");
            List<Car> cars = carDAO.filterByEngineType(engineType);
            request.setAttribute("cars", cars);
            request.setAttribute("filterEngine", engineType);
        } else {
            List<Car> cars = carDAO.getAllCars();
            request.setAttribute("cars", cars);
        }

        request.getRequestDispatcher("/carMarketplace.jsp").forward(request, response);
    }
}
