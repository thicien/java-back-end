<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bus Ticket Booking - Book Your Journey Today</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .container {
            background: white;
            padding: 50px;
            border-radius: 15px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            text-align: center;
            max-width: 600px;
            width: 100%;
        }
        .logo {
            font-size: 3em;
            margin-bottom: 20px;
        }
        h1 {
            color: #333;
            margin-bottom: 15px;
            font-size: 2.5em;
        }
        .tagline {
            color: #667eea;
            font-size: 1.2em;
            margin-bottom: 10px;
            font-weight: 600;
        }
        p {
            color: #666;
            margin-bottom: 35px;
            font-size: 1.05em;
            line-height: 1.6;
        }
        .buttons {
            display: flex;
            gap: 15px;
            justify-content: center;
            flex-wrap: wrap;
            margin-bottom: 40px;
        }
        a {
            padding: 14px 35px;
            border-radius: 8px;
            text-decoration: none;
            font-size: 1.05em;
            font-weight: bold;
            transition: all 0.3s ease;
            display: inline-block;
        }
        .btn-login {
            background: #667eea;
            color: white;
        }
        .btn-login:hover {
            background: #5568d3;
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.3);
        }
        .btn-register {
            background: #764ba2;
            color: white;
        }
        .btn-register:hover {
            background: #683a89;
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(118, 75, 162, 0.3);
        }
        .features {
            margin-top: 40px;
            padding-top: 40px;
            border-top: 2px solid #eee;
            text-align: left;
        }
        .features h3 {
            color: #333;
            margin-bottom: 20px;
            font-size: 1.3em;
        }
        .features ul {
            list-style: none;
        }
        .features li {
            color: #666;
            margin-bottom: 12px;
            padding-left: 30px;
            position: relative;
            font-size: 1.05em;
        }
        .features li:before {
            content: "✓";
            position: absolute;
            left: 0;
            color: #667eea;
            font-weight: bold;
            font-size: 1.2em;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="logo">🚌</div>
        <h1>Bus Ticket Booking</h1>
        <div class="tagline">Book Your Journey Today</div>
        <p>Explore our extensive network of buses connecting major cities. Select your route, choose your seat, and get your ticket in minutes. Easy, secure, and affordable travel solutions.</p>
        <div class="buttons">
            <a href="<%= request.getContextPath() %>/login" class="btn-login">Login</a>
            <a href="<%= request.getContextPath() %>/register" class="btn-register">Register</a>
        </div>

        <div class="features">
            <h3>Why Book With Us?</h3>
            <ul>
                <li>Wide Network of Destinations</li>
                <li>Transparent Pricing & Instant Booking</li>
                <li>Real-Time Seat Availability</li>
                <li>Easy Seat Selection & Payment</li>
                <li>Digital Tickets & Booking Confirmation</li>
                <li>24/7 Customer Support</li>
            </ul>
        </div>
    </div>
</body>
</html>
