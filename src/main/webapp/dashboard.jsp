<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, com.example.model.Car, com.example.model.User" %>
<%
    // Check if user is logged in
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    
    // Get cars from request
    List<Car> cars = (List<Car>) request.getAttribute("cars");
    if (cars == null) {
        cars = new ArrayList<>();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DriveSelect | Used Car Marketplace</title>
    <style>
        :root {
            --primary: #2563eb;
            --dark: #1e293b;
            --light: #f8fafc;
            --gray: #64748b;
        }

        * { box-sizing: border-box; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; margin: 0; padding: 0; }

        body { background-color: #f1f5f9; color: var(--dark); line-height: 1.6; }

        /* Header & Navigation */
        header { 
            background: var(--dark); 
            color: white; 
            padding: 1rem 5%; 
            display: flex; 
            justify-content: space-between; 
            align-items: center; 
            position: sticky; 
            top: 0; 
            z-index: 100; 
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        header h1 { font-size: 1.8rem; }
        
        .header-nav {
            display: flex;
            gap: 30px;
            align-items: center;
        }
        
        .header-nav a, .header-nav span {
            color: white;
            text-decoration: none;
            cursor: pointer;
            transition: color 0.3s;
        }
        
        .header-nav a:hover {
            color: var(--primary);
        }
        
        .user-section {
            display: flex;
            gap: 15px;
            align-items: center;
        }
        
        .logout-btn {
            background: var(--primary);
            padding: 8px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            color: white;
            font-weight: bold;
            transition: background 0.3s;
        }
        
        .logout-btn:hover {
            background: #1d4ed8;
        }
        
        /* Hero Section */
        .hero { 
            background: linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.6)), url('https://images.unsplash.com/photo-1492144534655-ae79c964c9d7?auto=format&fit=crop&q=80&w=1920'); 
            background-size: cover; 
            background-position: center; 
            height: 300px; 
            display: flex; 
            flex-direction: column; 
            justify-content: center; 
            align-items: center; 
            color: white; 
            text-align: center; 
        }
        
        .hero h2 { font-size: 2.5rem; margin-bottom: 10px; }
        .hero p { font-size: 1.2rem; opacity: 0.9; }

        /* Search Bar */
        .search-container { 
            background: white; 
            padding: 20px; 
            border-radius: 8px; 
            box-shadow: 0 4px 6px -1px rgb(0 0 0 / 0.1); 
            margin-top: -40px; 
            width: 90%; 
            max-width: 800px; 
            margin-left: auto; 
            margin-right: auto; 
            display: flex; 
            gap: 10px;
        }
        
        .search-container input { 
            flex: 1; 
            padding: 12px; 
            border: 1px solid #ddd; 
            border-radius: 5px; 
            font-size: 1rem; 
        }
        
        .search-container input:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 5px rgba(37, 99, 235, 0.2);
        }
        
        .search-container button {
            background: var(--primary);
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            transition: background 0.3s;
        }
        
        .search-container button:hover {
            background: #1d4ed8;
        }

        /* Container */
        .container { 
            max-width: 1200px; 
            margin: 50px auto; 
            padding: 0 20px; 
        }
        
        .filter-section {
            margin-bottom: 30px;
            text-align: center;
        }
        
        .filter-section h3 {
            margin-bottom: 15px;
            color: var(--dark);
        }
        
        .filter-buttons {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
            justify-content: center;
        }
        
        .filter-btn {
            padding: 8px 15px;
            border: 2px solid var(--primary);
            background: white;
            color: var(--primary);
            border-radius: 20px;
            cursor: pointer;
            font-weight: bold;
            transition: all 0.3s;
        }
        
        .filter-btn:hover, .filter-btn.active {
            background: var(--primary);
            color: white;
        }

        /* Car Grid */
        .car-grid { 
            display: grid; 
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); 
            gap: 25px;
        }

        .car-card { 
            background: white; 
            border-radius: 12px; 
            overflow: hidden; 
            transition: transform 0.3s ease; 
            box-shadow: 0 2px 10px rgba(0,0,0,0.05); 
            cursor: pointer; 
        }
        
        .car-card:hover { 
            transform: translateY(-5px); 
            box-shadow: 0 10px 20px rgba(0,0,0,0.1); 
        }
        
        .car-img { 
            width: 100%; 
            height: 200px; 
            object-fit: cover; 
            background: #e0e0e0;
        }
        
        .car-info { 
            padding: 20px; 
        }
        
        .car-price { 
            font-size: 1.5rem; 
            font-weight: bold; 
            color: var(--primary); 
        }
        
        .car-title { 
            font-size: 1.2rem; 
            margin: 5px 0; 
            font-weight: 600; 
        }
        
        .car-details { 
            display: flex; 
            justify-content: space-between; 
            color: var(--gray); 
            font-size: 0.9rem; 
            margin-top: 10px; 
            border-top: 1px solid #eee; 
            padding-top: 10px; 
        }

        /* Modal */
        .modal { 
            display: none; 
            position: fixed; 
            top: 0; 
            left: 0; 
            width: 100%; 
            height: 100%; 
            background: rgba(0,0,0,0.8); 
            z-index: 1000; 
            justify-content: center; 
            align-items: center; 
        }
        
        .modal-content { 
            background: white; 
            width: 90%; 
            max-width: 600px; 
            border-radius: 15px; 
            overflow: hidden; 
            position: relative; 
        }
        
        .close-btn { 
            position: absolute; 
            top: 15px; 
            right: 20px; 
            font-size: 2rem; 
            cursor: pointer;
            color: #666;
            background: white;
            border: none;
            z-index: 1001;
        }
        
        .close-btn:hover {
            color: var(--primary);
        }
        
        .modal-body { 
            padding: 30px; 
        }
        
        .modal-body h2 {
            margin-bottom: 10px;
            color: var(--dark);
        }
        
        .modal-body p {
            margin: 10px 0;
            color: #555;
        }
        
        .contact-btn {
            margin-top: 20px;
            width: 100%;
            padding: 15px;
            background: var(--primary);
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            font-size: 1rem;
            transition: background 0.3s;
        }
        
        .contact-btn:hover {
            background: #1d4ed8;
        }
        
        .no-cars {
            grid-column: 1 / -1;
            text-align: center;
            padding: 40px;
            background: white;
            border-radius: 12px;
            color: var(--gray);
        }

        @media (max-width: 600px) { 
            .search-container { 
                flex-direction: column; 
            }
            
            header {
                flex-direction: column;
                gap: 15px;
                padding: 1rem 2%;
            }
            
            .header-nav {
                width: 100%;
                justify-content: space-between;
            }
            
            .hero h2 {
                font-size: 1.8rem;
            }
        }
    </style>
</head>
<body>

    <!-- Header -->
    <header>
        <h1>🚗 DriveSelect</h1>
        <div class="header-nav">
            <span>Marketplace</span>
            <span>Sell Car</span>
            <div class="user-section">
                <span>Welcome, <strong><%= user.getFullName() %></strong></span>
                <a href="<%= request.getContextPath() %>/logout" class="logout-btn">Logout</a>
            </div>
        </div>
    </header>

    <!-- Hero Section -->
    <section class="hero">
        <h2>Find Your Next Adventure</h2>
        <p>Browse our premium collection of certified used cars</p>
    </section>

    <!-- Search Bar -->
    <div class="search-container">
        <input type="text" id="searchInput" placeholder="Search by brand or model (e.g., BMW, Tesla)..." onkeyup="filterCars()">
        <button onclick="filterCars()">Search</button>
    </div>

    <!-- Main Container -->
    <div class="container">
        <!-- Filter Buttons -->
        <div class="filter-section">
            <h3>Filter by Condition</h3>
            <div class="filter-buttons">
                <button class="filter-btn active" onclick="filterByCondition('All')">All Cars</button>
                <button class="filter-btn" onclick="filterByCondition('Excellent')">Excellent</button>
                <button class="filter-btn" onclick="filterByCondition('Good')">Good</button>
                <button class="filter-btn" onclick="filterByCondition('Fair')">Fair</button>
            </div>
        </div>

        <!-- Car Grid -->
        <div class="car-grid" id="carGrid">
            <%
                if (cars != null && !cars.isEmpty()) {
                    for (Car car : cars) {
            %>
                <div class="car-card" onclick="openModal('<%= car.getBrand() %>', '<%= car.getModel() %>', '<%= car.getLaunchYear() %>', '<%= car.getPrice() %>', '<%= car.getMileage() %>', '<%= car.getEngineType() %>', '<%= car.getCondition() %>', '<%= car.getDescription() %>')">
                    <div class="car-img" style="background: url('https://via.placeholder.com/300x200?text=<%= car.getBrand() %>+<%= car.getModel() %>'); background-size: cover; background-position: center;"></div>
                    <div class="car-info">
                        <p class="car-price">$<%= String.format("%.0f", car.getPrice()) %></p>
                        <h3 class="car-title"><%= car.getLaunchYear() %> <%= car.getBrand() %> <%= car.getModel() %></h3>
                        <div class="car-details">
                            <span>📍 <%= car.getMileage() %> km</span>
                            <span>⛽ <%= car.getEngineType() %></span>
                        </div>
                    </div>
                </div>
            <%
                    }
                } else {
            %>
                <div class="no-cars">
                    <h3>No cars found</h3>
                    <p>Try adjusting your search criteria</p>
                </div>
            <%
                }
            %>
        </div>
    </div>

    <!-- Modal -->
    <div id="carModal" class="modal" onclick="closeModal(event)">
        <div class="modal-content" onclick="event.stopPropagation()">
            <button class="close-btn" onclick="closeModal()">&times;</button>
            <div id="modalData"></div>
        </div>
    </div>

    <script>
        // Sample cars with beautiful Unsplash images
        const carsData = [
            {
                id: 1,
                brand: "Tesla",
                model: "Model 3 Long Range",
                year: 2022,
                price: 38500,
                mileage: "12,400",
                fuel: "Electric",
                condition: "Excellent",
                description: "Pristine condition, full self-driving capability included. One owner, non-smoker.",
                image: "https://images.unsplash.com/photo-1560958089-b8a1929cea89?auto=format&fit=crop&q=80&w=600"
            },
            {
                id: 2,
                brand: "BMW",
                model: "M4 Competition",
                year: 2021,
                price: 62000,
                mileage: "8,200",
                fuel: "Gasoline",
                condition: "Excellent",
                description: "Ultimate driving machine with carbon fiber interior package and sport exhaust.",
                image: "https://images.unsplash.com/photo-1555215695-3004980ad54e?auto=format&fit=crop&q=80&w=600"
            },
            {
                id: 3,
                brand: "Ford",
                model: "F-150 Raptor",
                year: 2020,
                price: 55900,
                mileage: "35,000",
                fuel: "Gasoline",
                condition: "Good",
                description: "Off-road ready with upgraded Fox shocks and 35-inch all-terrain tires.",
                image: "https://images.unsplash.com/photo-1533473359331-0135ef1b58bf?auto=format&fit=crop&q=80&w=600"
            },
            {
                id: 4,
                brand: "Audi",
                model: "A5 Sportback",
                year: 2019,
                price: 29500,
                mileage: "42,000",
                fuel: "Gasoline",
                condition: "Good",
                description: "Elegant styling with Quattro all-wheel drive and premium Bang & Olufsen sound.",
                image: "https://images.unsplash.com/photo-1606152421802-db97b9c7a11b?auto=format&fit=crop&q=80&w=600"
            },
            {
                id: 5,
                brand: "Porsche",
                model: "911 Carrera",
                year: 2023,
                price: 115000,
                mileage: "1,500",
                fuel: "Gasoline",
                condition: "Excellent",
                description: "Like new condition. Special Guard's Red paint and sport chrono package.",
                image: "https://images.unsplash.com/photo-1503376780353-7e6692767b70?auto=format&fit=crop&q=80&w=600"
            },
            {
                id: 6,
                brand: "Toyota",
                model: "Camry",
                year: 2020,
                price: 25000,
                mileage: "52,000",
                fuel: "Petrol",
                condition: "Excellent",
                description: "Reliable and fuel-efficient sedan with excellent maintenance history.",
                image: "https://images.unsplash.com/photo-1552820728-8ac41f1ce891?auto=format&fit=crop&q=80&w=600"
            },
            {
                id: 7,
                brand: "Honda",
                model: "Civic",
                year: 2019,
                price: 22000,
                mileage: "48,000",
                fuel: "Diesel",
                condition: "Good",
                description: "Compact and nimble with excellent handling and reliability.",
                image: "https://images.unsplash.com/photo-1609708536965-bc6e90a279ba?auto=format&fit=crop&q=80&w=600"
            },
            {
                id: 8,
                brand: "Mercedes-Benz",
                model: "C-Class",
                year: 2021,
                price: 45000,
                mileage: "28,000",
                fuel: "Gasoline",
                condition: "Excellent",
                description: "Luxury sedan with premium interior and advanced safety features.",
                image: "https://images.unsplash.com/photo-1541899481282-d53bffe3c35d?auto=format&fit=crop&q=80&w=600"
            }
        ];

        let filteredCars = [...carsData];
        let currentConditionFilter = 'All';

        // Display cars
        function displayCars(carsArray) {
            const grid = document.getElementById('carGrid');
            
            if (carsArray.length === 0) {
                grid.innerHTML = '<div class="no-cars" style="grid-column: 1/-1;"><h3>No cars found</h3><p>Try adjusting your search criteria</p></div>';
                return;
            }

            grid.innerHTML = carsArray.map(car => `
                <div class="car-card" onclick="openModal('${car.brand}', '${car.model}', ${car.year}, ${car.price}, '${car.mileage}', '${car.fuel}', '${car.condition}', '${car.description}')">
                    <div class="car-img" style="background: url('${car.image}'); background-size: cover; background-position: center;"></div>
                    <div class="car-info">
                        <p class="car-price">$${car.price.toLocaleString()}</p>
                        <h3 class="car-title">${car.year} ${car.brand} ${car.model}</h3>
                        <div class="car-details">
                            <span>📍 ${car.mileage} km</span>
                            <span>⛽ ${car.fuel}</span>
                        </div>
                    </div>
                </div>
            `).join('');
        }

        // Search filter
        function filterCars() {
            const searchTerm = document.getElementById('searchInput').value.toLowerCase();
            
            filteredCars = carsData.filter(car => {
                const matchesSearch = car.brand.toLowerCase().includes(searchTerm) || 
                                     car.model.toLowerCase().includes(searchTerm);
                const matchesCondition = currentConditionFilter === 'All' || car.condition === currentConditionFilter;
                return matchesSearch && matchesCondition;
            });
            
            displayCars(filteredCars);
        }

        // Filter by condition
        function filterByCondition(condition) {
            currentConditionFilter = condition;
            
            // Update button styles
            document.querySelectorAll('.filter-btn').forEach(btn => {
                btn.classList.remove('active');
            });
            event.target.classList.add('active');
            
            filterCars();
        }

        // Modal functions
        function openModal(brand, model, year, price, mileage, fuel, condition, description) {
            const modalData = document.getElementById('modalData');
            const modal = document.getElementById('carModal');

            modalData.innerHTML = `
                <div class="car-img" style="background: url('https://via.placeholder.com/600x300?text=${brand}+${model}'); background-size: cover; background-position: center; height: 300px;"></div>
                <div class="modal-body">
                    <h2>${year} ${brand} ${model}</h2>
                    <p style="color:var(--primary); font-size:1.5rem; font-weight:bold; margin: 10px 0;">$${price.toLocaleString()}</p>
                    <p><strong>Condition:</strong> <span style="color: #4CAF50; font-weight: bold;">${condition}</span></p>
                    <p><strong>Mileage:</strong> ${mileage} km</p>
                    <p><strong>Fuel Type:</strong> ${fuel}</p>
                    <p style="margin-top:15px; color: #555; line-height: 1.6;">${description}</p>
                    <button class="contact-btn">Contact Seller</button>
                </div>
            `;
            modal.style.display = "flex";
        }

        function closeModal(event) {
            if (event) event.stopPropagation();
            document.getElementById('carModal').style.display = "none";
        }

        // Close on escape
        document.addEventListener('keydown', function(event) {
            if (event.key === 'Escape') {
                closeModal();
            }
        });

        // Initial load
        displayCars(carsData);
    </script>
</body>
</html>
