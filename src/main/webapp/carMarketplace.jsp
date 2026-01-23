<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, com.example.model.Car, com.example.model.User" %>
<%
    // Check if user is logged in
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
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

        * { 
            box-sizing: border-box; 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
            margin: 0; 
            padding: 0; 
        }

        body { 
            background-color: #f1f5f9; 
            color: var(--dark); 
            line-height: 1.6; 
        }

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
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        
        header h1 {
            font-size: 1.8rem;
            font-weight: bold;
        }
        
        .navbar-right {
            display: flex;
            gap: 20px;
            align-items: center;
        }
        
        .welcome-text {
            font-size: 0.95em;
        }
        
        .logout-btn {
            background: rgba(255, 255, 255, 0.2);
            color: white;
            border: 1px solid white;
            padding: 8px 16px;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            font-weight: bold;
            transition: all 0.3s;
        }
        
        .logout-btn:hover {
            background: white;
            color: var(--dark);
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
            padding: 20px;
        }
        
        .hero h2 {
            font-size: 2.5rem;
            margin-bottom: 10px;
        }
        
        .hero p {
            font-size: 1.2rem;
            opacity: 0.9;
        }

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
            position: relative;
            z-index: 10;
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
            box-shadow: 0 0 5px rgba(37, 99, 235, 0.3);
        }
        
        .search-container button {
            background: var(--primary);
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            transition: all 0.3s;
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
        
        .page-title {
            text-align: center;
            color: var(--dark);
            margin-bottom: 40px;
            font-size: 2.5em;
        }
        
        /* Car Grid */
        .cars-grid { 
            display: grid; 
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); 
            gap: 25px;
        }

        /* Car Card */
        .car-card { 
            background: white; 
            border-radius: 12px; 
            overflow: hidden; 
            transition: all 0.3s ease; 
            box-shadow: 0 2px 10px rgba(0,0,0,0.05); 
            cursor: pointer;
        }
        
        .car-card:hover { 
            transform: translateY(-8px); 
            box-shadow: 0 12px 24px rgba(0,0,0,0.15);
        }
        
        .car-img { 
            width: 100%; 
            height: 220px; 
            object-fit: cover; 
        }
        
        .car-info { 
            padding: 20px; 
        }
        
        .car-price { 
            font-size: 1.6rem; 
            font-weight: bold; 
            color: var(--primary);
            margin-bottom: 10px;
        }
        
        .car-title { 
            font-size: 1.2rem; 
            margin: 8px 0; 
            font-weight: 600;
            color: var(--dark);
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
        
        .car-specs {
            display: flex;
            flex-direction: column;
            gap: 8px;
            margin-top: 12px;
            font-size: 0.9rem;
            color: var(--gray);
        }
        
        .car-spec-item {
            display: flex;
            justify-content: space-between;
        }
        
        .view-details-btn {
            width: 100%;
            background: var(--primary);
            color: white;
            border: none;
            padding: 12px;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            margin-top: 15px;
            transition: all 0.3s;
        }
        
        .view-details-btn:hover {
            background: #1d4ed8;
            transform: scale(1.02);
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
            max-height: 90vh;
            overflow-y: auto;
        }
        
        .close-btn { 
            position: absolute; 
            top: 15px; 
            right: 20px; 
            font-size: 2rem; 
            cursor: pointer;
            background: rgba(255,255,255,0.9);
            border: none;
            border-radius: 50%;
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 10;
        }
        
        .close-btn:hover {
            background: white;
        }
        
        .modal-body { 
            padding: 30px;
        }
        
        .modal-body h2 {
            color: var(--dark);
            margin-bottom: 10px;
        }
        
        .modal-body p {
            margin: 8px 0;
            color: var(--gray);
        }
        
        .modal-body strong {
            color: var(--dark);
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
            transition: all 0.3s;
        }
        
        .contact-btn:hover {
            background: #1d4ed8;
        }
        
        .no-cars {
            grid-column: 1 / -1;
            text-align: center;
            padding: 60px 40px;
            background: white;
            border-radius: 10px;
            color: var(--gray);
            font-size: 1.1em;
        }
        
        /* Filter Section */
        .filter-section {
            background: white;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 30px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
            align-items: center;
        }
        
        .filter-section form {
            display: flex;
            gap: 10px;
            align-items: center;
        }
        
        .filter-section select {
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 0.95rem;
        }
        
        .filter-section button {
            background: var(--primary);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            transition: all 0.3s;
        }
        
        .filter-section button:hover {
            background: #1d4ed8;
        }
        
        .filter-info {
            background: #eff6ff;
            border-left: 4px solid var(--primary);
            padding: 12px 15px;
            border-radius: 5px;
            color: var(--dark);
            margin-bottom: 20px;
        }
        
        .filter-info a {
            color: var(--primary);
            text-decoration: none;
            font-weight: bold;
            margin-left: 10px;
        }
        
        .filter-info a:hover {
            text-decoration: underline;
        }
        
        @media (max-width: 600px) { 
            .search-container { 
                flex-direction: column; 
            }
            
            .cars-grid {
                grid-template-columns: 1fr;
            }
            
            header {
                flex-direction: column;
                gap: 15px;
            }
            
            .navbar-right {
                width: 100%;
                justify-content: space-between;
            }
        }
    </style>
</head>
<body>
    <!-- Header Navigation -->
    <header>
        <h1>🚗 DriveSelect</h1>
        <div class="navbar-right">
            <span class="welcome-text">Welcome, <strong><%= user.getFullName() %></strong>!</span>
            <a href="<%= request.getContextPath() %>/logout" class="logout-btn">Logout</a>
        </div>
    </header>

    <!-- Hero Section -->
    <section class="hero">
        <h2>Find Your Next Adventure</h2>
        <p>Browse our collection of premium used cars</p>
    </section>

    <!-- Search Bar -->
    <div class="search-container">
        <input type="text" id="searchInput" placeholder="Search by brand or model..." onkeyup="filterCars()">
        <button onclick="searchCars()">Search</button>
    </div>

    <!-- Main Container -->
    <div class="container">
        <!-- Filter Section -->
        <div class="filter-section">
            <form method="POST" action="<%= request.getContextPath() %>/carMarketplace" style="flex: 1; display: flex; gap: 10px;">
                <input type="hidden" name="action" value="filter">
                <select name="engineType" onchange="this.form.submit()">
                    <option value="">Filter by Engine Type</option>
                    <option value="Petrol">Petrol</option>
                    <option value="Diesel">Diesel</option>
                </select>
            </form>
            <a href="<%= request.getContextPath() %>/carMarketplace" style="background: var(--primary); color: white; padding: 10px 20px; border-radius: 5px; text-decoration: none; font-weight: bold; cursor: pointer;">Clear Filters</a>
        </div>
        
        <%
            String searchBrand = (String) request.getAttribute("searchBrand");
            String filterEngine = (String) request.getAttribute("filterEngine");
            if (searchBrand != null || filterEngine != null) {
        %>
            <div class="filter-info">
                <%
                    if (searchBrand != null) {
                        out.print("🔍 Search: <strong>" + searchBrand + "</strong>");
                    }
                    if (filterEngine != null) {
                        if (searchBrand != null) out.print(" | ");
                        out.print("⛽ Engine: <strong>" + filterEngine + "</strong>");
                    }
                %>
                <a href="<%= request.getContextPath() %>/carMarketplace">✕ Clear</a>
            </div>
        <%
            }
        %>
        
        <!-- Cars Grid -->
        <div class="cars-grid" id="carGrid">
            <%
                List<Car> cars = (List<Car>) request.getAttribute("cars");
                java.util.Map<String, String> carImages = new java.util.HashMap<>();
                carImages.put("Tesla", "https://images.unsplash.com/photo-1560958089-b8a1929cea89?auto=format&fit=crop&q=80&w=600");
                carImages.put("BMW", "https://images.unsplash.com/photo-1555215695-3004980ad54e?auto=format&fit=crop&q=80&w=600");
                carImages.put("Ford", "https://images.unsplash.com/photo-1533473359331-0135ef1b58bf?auto=format&fit=crop&q=80&w=600");
                carImages.put("Audi", "https://images.unsplash.com/photo-1606152421802-db97b9c7a11b?auto=format&fit=crop&q=80&w=600");
                carImages.put("Porsche", "https://images.unsplash.com/photo-1503376780353-7e6692767b70?auto=format&fit=crop&q=80&w=600");
                carImages.put("Toyota", "https://images.unsplash.com/photo-1552820728-8ac41f1ce891?auto=format&fit=crop&q=80&w=600");
                carImages.put("Honda", "https://images.unsplash.com/photo-1549399542-7e3f8b83ad38?auto=format&fit=crop&q=80&w=600");
                carImages.put("Hyundai", "https://images.unsplash.com/photo-1558618666-fcd25c85cd64?auto=format&fit=crop&q=80&w=600");
                carImages.put("Mazda", "https://images.unsplash.com/photo-1552821284-e673c89de5c9?auto=format&fit=crop&q=80&w=600");
                carImages.put("Nissan", "https://images.unsplash.com/photo-1566023967268-7cb58b0e3d39?auto=format&fit=crop&q=80&w=600");
                carImages.put("Volkswagen", "https://images.unsplash.com/photo-1550355291-bbee04a92027?auto=format&fit=crop&q=80&w=600");
                carImages.put("Kia", "https://images.unsplash.com/photo-1627454818175-da953e82b32d?auto=format&fit=crop&q=80&w=600");
                
                if (cars != null && !cars.isEmpty()) {
                    for (Car car : cars) {
                        String imageUrl = car.getImageUrl() != null ? car.getImageUrl() : carImages.getOrDefault(car.getBrand(), "https://images.unsplash.com/photo-1485968579580-b6d095aa1f30?auto=format&fit=crop&q=80&w=600");
            %>
                <div class="car-card" onclick="openModal(this)">
                    <img src="<%= imageUrl %>" alt="<%= car.getBrand() %>" class="car-img" loading="lazy">
                    <div class="car-info">
                        <p class="car-price">$<%= String.format("%.0f", car.getPrice()) %></p>
                        <h3 class="car-title"><%= car.getYear() %> <%= car.getBrand() %> <%= car.getModel() %></h3>
                        <div class="car-details">
                            <span>📍 <%= String.format("%,d", car.getMileage()) %> mi</span>
                            <span>⛽ <%= car.getEngineType() %></span>
                        </div>
                        <div class="car-specs">
                            <div class="car-spec-item">
                                <strong>Condition:</strong>
                                <span><%= car.getCondition() %></span>
                            </div>
                            <div class="car-spec-item">
                                <strong>Year:</strong>
                                <span><%= car.getLaunchYear() %></span>
                            </div>
                        </div>
                        <button class="view-details-btn" onclick="event.stopPropagation(); openModal(this.closest('.car-card'));">View Details</button>
                    </div>
                </div>
            <%
                    }
                } else {
            %>
                <div class="no-cars">
                    <p>🚫 No cars found. Try adjusting your search or filters.</p>
                </div>
            <%
                }
            %>
        </div>
    </div>

    <!-- Modal -->
    <div id="carModal" class="modal" onclick="if(event.target === this) closeModal()">
        <div class="modal-content">
            <button class="close-btn" onclick="closeModal()">✕</button>
            <div id="modalData"></div>
        </div>
    </div>

    <script>
        // Image URL mapping
        const carImageMap = {
            'Tesla': 'https://images.unsplash.com/photo-1560958089-b8a1929cea89?auto=format&fit=crop&q=80&w=600',
            'BMW': 'https://images.unsplash.com/photo-1555215695-3004980ad54e?auto=format&fit=crop&q=80&w=600',
            'Ford': 'https://images.unsplash.com/photo-1533473359331-0135ef1b58bf?auto=format&fit=crop&q=80&w=600',
            'Audi': 'https://images.unsplash.com/photo-1606152421802-db97b9c7a11b?auto=format&fit=crop&q=80&w=600',
            'Porsche': 'https://images.unsplash.com/photo-1503376780353-7e6692767b70?auto=format&fit=crop&q=80&w=600',
            'Toyota': 'https://images.unsplash.com/photo-1552820728-8ac41f1ce891?auto=format&fit=crop&q=80&w=600',
            'Honda': 'https://images.unsplash.com/photo-1549399542-7e3f8b83ad38?auto=format&fit=crop&q=80&w=600',
            'Hyundai': 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?auto=format&fit=crop&q=80&w=600',
            'Mazda': 'https://images.unsplash.com/photo-1552821284-e673c89de5c9?auto=format&fit=crop&q=80&w=600',
            'Nissan': 'https://images.unsplash.com/photo-1566023967268-7cb58b0e3d39?auto=format&fit=crop&q=80&w=600',
            'Volkswagen': 'https://images.unsplash.com/photo-1550355291-bbee04a92027?auto=format&fit=crop&q=80&w=600',
            'Kia': 'https://images.unsplash.com/photo-1627454818175-da953e82b32d?auto=format&fit=crop&q=80&w=600'
        };
        
        // Car data from JSP - will be populated dynamically
        const cars = [
            <%
                List<Car> carList = (List<Car>) request.getAttribute("cars");
                if (carList != null && !carList.isEmpty()) {
                    for (int i = 0; i < carList.size(); i++) {
                        Car car = carList.get(i);
                        String imageUrl = car.getImageUrl() != null ? car.getImageUrl() : (carImages.containsKey(car.getBrand()) ? carImages.get(car.getBrand()) : "https://images.unsplash.com/photo-1485968579580-b6d095aa1f30?auto=format&fit=crop&q=80&w=600");
            %>
            {
                id: <%= car.getCarId() %>,
                brand: "<%= car.getBrand() %>",
                model: "<%= car.getModel() %>",
                year: <%= car.getLaunchYear() %>,
                price: <%= car.getPrice() %>,
                mileage: "<%= String.format("%,d", car.getMileage()) %>",
                fuel: "<%= car.getEngineType() %>",
                condition: "<%= car.getCondition() %>",
                description: "<%= car.getDescription() != null ? car.getDescription().replace("\"", "\\\"") : "" %>",
                image: "<%= imageUrl %>"
            }<%= i < carList.size() - 1 ? "," : "" %>
            <%
                    }
                }
            %>
        ];

        function getCarImageUrl(brand) {
            return carImageMap[brand] || 'https://images.unsplash.com/photo-1485968579580-b6d095aa1f30?auto=format&fit=crop&q=80&w=600';
        }

        function filterCars() {
            const searchTerm = document.getElementById('searchInput').value.toLowerCase();
            const filtered = cars.filter(car => 
                car.brand.toLowerCase().includes(searchTerm) || 
                car.model.toLowerCase().includes(searchTerm)
            );
            displayCars(filtered);
        }

        function displayCars(carsArray) {
            const grid = document.getElementById('carGrid');
            if (carsArray.length === 0) {
                grid.innerHTML = '<div class="no-cars"><p>🚫 No cars found matching your search.</p></div>';
                return;
            }
            grid.innerHTML = carsArray.map(car => `
                <div class="car-card" onclick="openModalData(${car.id})">
                    <img src="${car.image}" alt="${car.brand}" class="car-img">
                    <div class="car-info">
                        <p class="car-price">$${car.price.toLocaleString()}</p>
                        <h3 class="car-title">${car.year} ${car.brand} ${car.model}</h3>
                        <div class="car-details">
                            <span>📍 ${car.mileage} mi</span>
                            <span>⛽ ${car.fuel}</span>
                        </div>
                        <div class="car-specs">
                            <div class="car-spec-item">
                                <strong>Condition:</strong>
                                <span>${car.condition}</span>
                            </div>
                        </div>
                        <button class="view-details-btn" onclick="event.stopPropagation(); openModalData(${car.id});">View Details</button>
                    </div>
                </div>
            `).join('');
        }

        function openModal(element) {
            const card = element.closest('.car-card');
            const title = card.querySelector('.car-title').textContent;
            const price = card.querySelector('.car-price').textContent;
            const mileage = card.querySelector('.car-details').children[0].textContent;
            const fuel = card.querySelector('.car-details').children[1].textContent;
            const image = card.querySelector('.car-img').src;
            
            const [year, brand, model] = title.split(' ');
            const car = cars.find(c => c.year == year && c.brand === brand && c.model === model);
            openModalData(car ? car.id : null);
        }

        function openModalData(id) {
            const car = cars.find(c => c.id === id);
            if (!car) return;
            
            const modalData = document.getElementById('modalData');
            modalData.innerHTML = `
                <img src="${car.image}" style="width:100%; height:300px; object-fit:cover; display: block;">
                <div class="modal-body">
                    <h2>${car.year} ${car.brand} ${car.model}</h2>
                    <p style="color:var(--primary); font-size:1.5rem; font-weight:bold; margin: 15px 0;">$${car.price.toLocaleString()}</p>
                    <p><strong>📍 Mileage:</strong> ${car.mileage} miles</p>
                    <p><strong>⛽ Fuel Type:</strong> ${car.fuel}</p>
                    <p><strong>✓ Condition:</strong> ${car.condition}</p>
                    <p style="margin-top:15px; color: #555; line-height: 1.6;">${car.description || 'Premium quality vehicle in excellent condition.'}</p>
                    <button class="contact-btn">Contact Seller</button>
                </div>
            `;
            document.getElementById('carModal').style.display = "flex";
        }

        function closeModal() {
            document.getElementById('carModal').style.display = "none";
        }

        window.onclick = function(event) {
            const modal = document.getElementById('carModal');
            if (event.target === modal) {
                closeModal();
            }
        }

        function searchCars() {
            filterCars();
        }
    </script>
</body>
</html>