# Troubleshooting Login/Registration Issues

## Common Issues and Solutions

### 1. "Cannot connect to server" Error

**Problem**: The app cannot reach the backend API.

**Solutions**:

#### For Android Emulator:
- The API URL should be: `http://10.0.2.2:3000`
- Make sure the server is running: `cd test1 && npm start`
- Check if server is listening: `netstat -ano | findstr :3000`

#### For iOS Simulator:
- The API URL should be: `http://localhost:3000`
- Make sure the server is running

#### For Physical Device:
- You need to use your computer's IP address
- Find your IP: 
  - Windows: `ipconfig` (look for IPv4 Address)
  - Mac/Linux: `ifconfig` or `ip addr`
- Update `lib/presentation/providers/auth_provider.dart`:
  ```dart
  return ApiService(baseUrl: 'http://YOUR_IP_ADDRESS:3000');
  ```
- Make sure your phone and computer are on the same WiFi network
- Check Windows Firewall allows port 3000

### 2. "Login failed" or "Registration failed"

**Check**:
1. Server is running and accessible
2. Database is connected (check server logs)
3. Email format is correct
4. Password meets requirements (min 6 characters)
5. For registration: Name is provided

**Test the API directly**:
```bash
# Test registration
curl -X POST http://localhost:3000/auth/register \
  -H "Content-Type: application/json" \
  -d "{\"name\":\"Test User\",\"email\":\"test@test.com\",\"password\":\"password123\"}"

# Test login
curl -X POST http://localhost:3000/auth/login \
  -H "Content-Type: application/json" \
  -d "{\"email\":\"test@test.com\",\"password\":\"password123\"}"
```

### 3. CORS Errors

If you see CORS errors, check `test1/server.js` has:
```javascript
app.use(cors());
```

### 4. Database Connection Issues

Make sure:
- MySQL is running
- Database credentials in `test1/.env` are correct
- Database exists: `CREATE DATABASE video_learning;`
- Migrations are run: `cd test1 && npm run migrate`

### 5. Check Server Logs

Look at the server console for error messages when you try to login/register.

### Quick Test Steps

1. **Verify server is running**:
   ```bash
   cd test1
   npm start
   # Should see: "Server is running on port 3000"
   ```

2. **Test API endpoint**:
   ```bash
   curl http://localhost:3000/health
   # Should return: {"success":true,"message":"Server is running"}
   ```

3. **Check Flutter app API URL**:
   - Open `lib/presentation/providers/auth_provider.dart`
   - Verify the baseUrl matches your setup:
     - Android Emulator: `http://10.0.2.2:3000`
     - iOS Simulator: `http://localhost:3000`
     - Physical Device: `http://YOUR_IP:3000`

4. **Check error messages**:
   - The app now shows detailed error messages
   - Look for connection errors, validation errors, or server errors

### Still Not Working?

1. Check Flutter logs: `flutter run -v`
2. Check server logs in the terminal where `npm start` is running
3. Try testing the API with Postman or curl first
4. Verify database has the users table: `SHOW TABLES;` in MySQL

