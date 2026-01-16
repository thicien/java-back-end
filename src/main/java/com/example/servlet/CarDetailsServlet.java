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

@WebServlet("/carDetails")
public class CarDetailsServlet extends HttpServlet {
    private CarDAO carDAO = new CarDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String carIdStr = request.getParameter("id");
        if (carIdStr == null || carIdStr.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }

        try {
            int carId = Integer.parseInt(carIdStr);
            Car car = carDAO.getCarById(carId);
            if (car != null) {
                request.setAttribute("car", car);
                request.getRequestDispatcher("/carDetails.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/dashboard");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/dashboard");
        }
    }
}
