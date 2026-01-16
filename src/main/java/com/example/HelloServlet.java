package com.example;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Sample servlet for Tomcat 10 with Java 17
 */
@WebServlet("/hello")
public class HelloServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");
        response.getWriter().println("""
                <!DOCTYPE html>
                <html>
                <head>
                    <title>Hello Servlet</title>
                </head>
                <body>
                    <h1>Welcome to Your Java Web App!</h1>
                    <p>This servlet is running on Tomcat 10 with Java 17</p>
                    <p>Current Time: """ + java.time.LocalDateTime.now() + """
                    </p>
                </body>
                </html>
                """);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
