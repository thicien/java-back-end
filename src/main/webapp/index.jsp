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
            background: #0052CC;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        .navbar {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            background: rgba(0, 51, 153, 0.95);
            backdrop-filter: blur(10px);
            padding: 15px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
        }
        .navbar-logo {
            font-size: 1.8em;
            color: white;
            font-weight: bold;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .navbar-links {
            display: flex;
            gap: 20px;
        }
        .navbar-links a {
            color: white;
            text-decoration: none;
            padding: 8px 16px;
            border-radius: 6px;
            transition: all 0.3s ease;
            font-weight: 500;
        }
        .navbar-links a:hover {
            background: rgba(0, 82, 204, 0.5);
        }
        .container {
            background: white;
            padding: 60px 50px;
            border-radius: 20px;
            box-shadow: 0 30px 80px rgba(0, 0, 0, 0.25);
            text-align: center;
            max-width: 700px;
            width: 100%;
            animation: slideUp 0.6s ease-out;
        }
        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        .logo {
            font-size: 4em;
            margin-bottom: 20px;
            animation: bounce 2s infinite;
        }
        @keyframes bounce {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
        }
        h1 {
            color: #0052CC;
            margin-bottom: 10px;
            font-size: 3em;
            background: linear-gradient(135deg, #0052CC, #003d99);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        .tagline {
            color: #0052CC;
            font-size: 1.3em;
            margin-bottom: 15px;
            font-weight: 600;
            letter-spacing: 0.5px;
        }
        p {
            color: #3403f4;
            margin-bottom: 40px;
            font-size: 1.1em;
            line-height: 1.8;
        }
        .buttons {
            display: flex;
            gap: 20px;
            justify-content: center;
            flex-wrap: wrap;
            margin-bottom: 50px;
        }
        a {
            padding: 16px 40px;
            border-radius: 10px;
            text-decoration: none;
            font-size: 1.1em;
            font-weight: 600;
            transition: all 0.3s ease;
            display: inline-block;
            border: none;
            cursor: pointer;
        }
        .btn-login {
            background: linear-gradient(135deg, #0052CC, #003d99);
            color: white;
            box-shadow: 0 5px 15px rgba(37, 29, 250, 0.3);
        }
        .btn-login:hover {
            background: linear-gradient(135deg, #003d99, #002666);
            transform: translateY(-3px);
            box-shadow: 0 15px 35px rgba(0, 82, 204, 0.4);
        }
        .btn-register {
            background: white;
            color: #0052CC;
            border: 2.5px solid #0052CC;
            box-shadow: 0 5px 15px rgba(7, 102, 245, 0.2);
        }
        .btn-register:hover {
            background: #0052CC;
            color: white;
            transform: translateY(-3px);
            box-shadow: 0 15px 35px rgba(0, 82, 204, 0.4);
        }
        .features {
            margin-top: 50px;
            padding-top: 50px;
            border-top: 2px solid #e0e7ff;
            text-align: left;
        }
        .features h3 {
            color: #0052CC;
            margin-bottom: 30px;
            font-size: 1.5em;
            text-align: center;
        }
        .features-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }
        .features ul {
            list-style: none;
        }
        .features li {
            color: #3410ff;
            margin-bottom: 15px;
            padding-left: 35px;
            position: relative;
            font-size: 1.05em;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        .features li:hover {
            padding-left: 45px;
            color: #0052CC;
        }
        .features li:before {
            content: "✓";
            position: absolute;
            left: 0;
            color: #0052CC;
            font-weight: bold;
            font-size: 1.3em;
        }
        @media (max-width: 600px) {
            .features-grid {
                grid-template-columns: 1fr;
            }
            h1 {
                font-size: 2.2em;
            }
            .navbar {
                flex-direction: column;
                gap: 15px;
            }
            .container {
                padding: 40px 25px;
            }
        }
    </style>
</head>
<body>
    <div class="navbar">
        <div class="navbar-logo">
             BusTicket Pro
        </div>
        <div class="navbar-links">
            <a href="#home">Home</a>
            <a href="#about">About</a>
            <a href="#contact">Contact</a>
        </div>
    </div>

    <div class="container">
        <div class="logo"></div>
        <h1>Bus Ticket Booking</h1>
        <div class="tagline">Book Your Journey Today</div>
        <p>Explore our extensive network of buses connecting major cities. Select your route, choose your seat, and get your ticket in minutes. Easy, secure, and affordable travel solutions.</p>
        <div class="buttons">
            <a href="<%= request.getContextPath() %>/login" class="btn-login">Login</a>
            <a href="<%= request.getContextPath() %>/register" class="btn-register">Register</a>
        </div>

        <div class="features">
            <h3>Why Book With Us?</h3>
            <div class="features-grid">
                <ul>
                    <li>Wide Network of Destinations</li>
                    <li>Real-Time Seat Availability</li>
                    <li>Digital Tickets & Confirmation</li>
                </ul>
                <ul>
                    <li>Transparent Pricing</li>
                    <li>Easy Seat Selection</li>
                    <li>24/7 Customer Support</li>
                </ul>
            </div>
        </div>
    </div>
</body>
</html>
