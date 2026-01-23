package com.example.servlet;

import com.example.util.DatabaseConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Statement;

@WebServlet("/initializeSeats")
public class InitializeSeatsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            Connection conn = DatabaseConnection.getConnection();
            if (conn != null) {
                Statement stmt = conn.createStatement();
                
                // Clear existing seats for all buses
                stmt.execute("DELETE FROM seats;");
                
                // Initialize seats for all 10 buses
                initializeBusSeats(stmt, 1, 42, 6); // 6 columns x 7 rows
                initializeBusSeats(stmt, 2, 50, 5); // 5 columns x 10 rows
                initializeBusSeats(stmt, 3, 42, 6);
                initializeBusSeats(stmt, 4, 50, 5);
                initializeBusSeats(stmt, 5, 42, 6);
                initializeBusSeats(stmt, 6, 50, 5);
                initializeBusSeats(stmt, 7, 42, 6);
                initializeBusSeats(stmt, 8, 50, 5);
                initializeBusSeats(stmt, 9, 42, 6);
                initializeBusSeats(stmt, 10, 50, 5);
                
                stmt.close();
                conn.close();
                
                out.println("<html><body style='font-family: Arial; padding: 20px; background: #0052CC; color: white;'>");
                out.println("<h1>✅ Database Initialized Successfully!</h1>");
                out.println("<p>All bus seats have been generated and are ready for booking.</p>");
                out.println("<a href='" + request.getContextPath() + "/dashboard' style='color: white; text-decoration: underline;'>Go to Dashboard</a>");
                out.println("</body></html>");
            }
        } catch (Exception e) {
            out.println("<html><body style='color: red;'>");
            out.println("<h1>Error initializing seats</h1>");
            out.println("<pre>" + e.getMessage() + "</pre>");
            e.printStackTrace(out);
            out.println("</body></html>");
        }
    }

    private void initializeBusSeats(Statement stmt, int busId, int totalSeats, int columns) {
        try {
            int rows = totalSeats / columns;
            char[] rowLetters = {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J'};
            
            for (int r = 0; r < rows; r++) {
                for (int c = 1; c <= columns; c++) {
                    String seatNumber = "" + rowLetters[r] + c;
                    String sql = "INSERT INTO seats (bus_id, seat_number, status) VALUES (" 
                        + busId + ", '" + seatNumber + "', 'available');";
                    stmt.execute(sql);
                }
            }
            System.out.println("Initialized " + totalSeats + " seats for Bus " + busId);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
