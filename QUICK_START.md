# 🚗 Used Cars Marketplace - Quick Start (5 Minutes)

## ⚡ Fast Setup

### Step 1: Update Database (2 minutes)
```powershell
cd d:\java-back-end
mysql -u root -p < database-schema.sql
```
When prompted, enter your MySQL root password.

✅ This creates the `cars` table and loads 8 sample cars

### Step 2: Rebuild Project (1 minute)
```powershell
mvn clean install
```

### Step 3: Start Tomcat (1 minute)
```powershell
cd C:\apache-tomcat-11.0.15\bin
.\startup.bat
```

Wait for: "Server startup in XXX ms"

### Step 4: Test (1 minute)
1. Open browser: `http://localhost:8080/java-back-end`
2. Click **Register**
3. Fill form with any details
4. Click Register

### ✅ BOOM! You're in the Used Cars Marketplace! 🎉

---

## 🎯 What Changed

**BEFORE:** Register/Login → Bus Booking Dashboard
**AFTER:** Register/Login → **Used Cars Marketplace Dashboard** ✨

---

## 📝 Files Modified

| File | Change |
|------|--------|
| `database-schema.sql` | Added cars table + 8 sample cars |
| `RegisterServlet.java` | Auto-login → Redirect to carMarketplace |
| `LoginServlet.java` | Redirect to carMarketplace instead of dashboard |
| `CarDAO.java` | Added filterByEngineType() method |

## 📄 Files Created

| File | Purpose |
|------|---------|
| `CarMarketplaceServlet.java` | Handles car marketplace requests |
| `carMarketplace.jsp` | Beautiful car dashboard UI |

---

## 🧪 Features to Test

1. **Register & Login**
   - Register a new user
   - Should auto-login and show car marketplace

2. **Search**
   - Type `Honda` and search
   - Should show only Honda Civic

3. **Filter**
   - Select `Diesel` 
   - Should show only Ford Focus

4. **Clear**
   - Click "Clear Filters"
   - Should show all 8 cars

5. **Logout**
   - Click Logout
   - Should redirect to login

---

## 🚗 Sample Cars in Database

```
1. Toyota Camry - 2020 - $22,000 - Petrol
2. Honda Civic - 2019 - $18,500 - Petrol
3. Hyundai Elantra - 2021 - $19,500 - Petrol
4. Mazda Mazda3 - 2020 - $21,000 - Petrol
5. Nissan Altima - 2018 - $17,000 - Petrol
6. Ford Focus - 2019 - $16,500 - DIESEL ⭐
7. Volkswagen Golf - 2021 - $23,000 - Petrol
8. Kia Cerato - 2020 - $19,000 - Petrol
```

---

## ✅ Testing Checklist

- [ ] Database updated
- [ ] Project compiled
- [ ] Tomcat started
- [ ] Can register user
- [ ] Redirects to car marketplace
- [ ] See 8 cars on dashboard
- [ ] Search works
- [ ] Filter works
- [ ] Logout works

---

## 💡 Pro Tips

**If cars don't show:**
```powershell
mysql -u root -p bus_ticket_booking -e "SELECT COUNT(*) FROM cars;"
# Should show: 8
```

**If still redirecting to bus dashboard:**
1. Clear browser cache (Ctrl+Shift+Delete)
2. Hard refresh (Ctrl+F5)
3. Rebuild: `mvn clean install`

**To see database cars:**
```powershell
mysql -u root -p bus_ticket_booking -e "SELECT brand, model, price, engine_type FROM cars;"
```

---

## 🎉 That's It!

Your java-back-end project is now a **Used Cars Marketplace** application!

**Register → Auto-Login → See Car Dashboard ✅**

Enjoy! 🚗💨

