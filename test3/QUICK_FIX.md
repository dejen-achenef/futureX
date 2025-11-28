# Quick Fix for Login/Registration Issues

## The Problem
The Flutter app can't connect to the backend server.

## Step-by-Step Fix

### 1. Make Sure Backend Server is Running

```powershell
# Navigate to test1 folder
cd ..\test1

# Check if .env file exists
# If not, create it with these values:
# DB_HOST=localhost
# DB_PORT=3306
# DB_NAME=video_learning
# DB_USER=root
# DB_PASSWORD=your_mysql_password
# JWT_SECRET=your-secret-key
# PORT=3000

# Start the server
npm start
```

You should see: `✓ Server is running on port 3000`

### 2. Test the Server

Open a new terminal and test:
```powershell
# Test if server is running
curl http://localhost:3000/health
```

Should return: `{"success":true,"message":"Server is running"}`

### 3. Check Your Device Type

**If using Android Emulator:**
- API URL should be: `http://10.0.2.2:3000` ✅ (already set)

**If using iOS Simulator:**
- API URL should be: `http://localhost:3000`
- Update `lib/presentation/providers/auth_provider.dart` line 8

**If using Physical Device:**
- Find your computer's IP: `ipconfig` (look for IPv4)
- Update API URL to: `http://YOUR_IP:3000`
- Make sure phone and computer are on same WiFi

### 4. Common Issues

**Issue: "Cannot connect to server"**
- Server not running → Start it with `npm start` in test1 folder
- Wrong API URL → Check device type above
- Firewall blocking → Allow port 3000 in Windows Firewall

**Issue: "Email already exists" (Registration)**
- Try a different email address
- Or login with existing account

**Issue: "Invalid credentials" (Login)**
- Check email and password are correct
- Try registering a new account first

### 5. Test Registration

Try registering with:
- Name: Test User
- Email: test@example.com
- Password: password123

### 6. Still Not Working?

1. Check server console for error messages
2. Check Flutter console for error messages
3. Verify database is running and connected
4. Try restarting both server and Flutter app

