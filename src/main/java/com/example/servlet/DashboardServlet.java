package com.example.servlet;

import com.example.dao.CarDAO;
import com.example.model.Car;
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
    private CarDAO carDAO = new CarDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        List<Car> cars = carDAO.getAllCars();
        request.setAttribute("cars", cars);
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

        String searchBrand = request.getParameter("search");
        String conditionFilter = request.getParameter("condition");

        List<Car> cars;
        
        if (searchBrand != null && !searchBrand.isEmpty()) {
            cars = carDAO.searchByBrand(searchBrand);
        } else if (conditionFilter != null && !conditionFilter.isEmpty() && !conditionFilter.equals("All")) {
            cars = carDAO.filterByCondition(conditionFilter);
        } else {
            cars = carDAO.getAllCars();
        }

        request.setAttribute("cars", cars);
        request.getRequestDispatcher("/dashboard.jsp").forward(request, response);
    }
}
