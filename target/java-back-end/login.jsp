<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Used Car Marketplace</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #0066FF 0%, #0047B2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .container {
            background: white;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            width: 100%;
            max-width: 400px;
        }
        h1 {
            color: #333;
            margin-bottom: 10px;
            text-align: center;
            font-size: 1.8em;
        }
        .subtitle {
            text-align: center;
            color: #999;
            margin-bottom: 30px;
            font-size: 0.95em;
        }
        .form-group {
            margin-bottom: 20px;
        }
        label {
            display: block;
            color: #333;
            margin-bottom: 8px;
            font-weight: 500;
        }
        input {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 1em;
            transition: border-color 0.3s;
        }
        input:focus {
            outline: none;
            border-color: #0066FF;
            box-shadow: 0 0 5px rgba(102, 126, 234, 0.3);
        }
        .error {
            color: #e74c3c;
            background: #fadbd8;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
            display: none;
        }
        .error.show {
            display: block;
        }
        .success {
            color: #27ae60;
            background: #d5f4e6;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
            display: none;
        }
        .success.show {
            display: block;
        }
        button {
            width: 100%;
            padding: 12px;
            background: linear-gradient(135deg, #0066FF 0%, #0047B2 100%);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 1.1em;
            font-weight: bold;
            cursor: pointer;
            transition: transform 0.3s;
        }
        button:hover {
            transform: translateY(-2px);
        }
        .register-link {
            text-align: center;
            margin-top: 20px;
            color: #666;
        }
        .register-link a {
            color: #0066FF;
            text-decoration: none;
            font-weight: bold;
        }
        .register-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🚗 Welcome Back</h1>
        <div class="subtitle">Login to Used Car Marketplace</div>
        
        <% 
            String error = (String) request.getAttribute("error");
            String message = (String) request.getAttribute("message");
            if (message == null) {
                message = (String) session.getAttribute("message");
                if (message != null) {
                    session.removeAttribute("message");
                }
            }
            if (error != null) {
        %>
        <div class="error show"><%= error %></div>
        <% } %>
        <% if (message != null) { %>
        <div class="success show"><%= message %></div>
        <% } %>

        <form method="post" action="<%= request.getContextPath() %>/login">
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" required>
            </div>

            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required>
            </div>

            <button type="submit">Login</button>
        </form>

        <div class="register-link">
            Don't have an account? <a href="<%= request.getContextPath() %>/register">Register here</a>
        </div>
    </div>
</body>
</html>
