# How to Start the Server

## Quick Start

1. **Open a terminal/PowerShell in the test1 folder**

2. **Start the server**:
   ```powershell
   npm start
   ```
   
   OR double-click `START_SERVER.bat`

3. **You should see**:
   ```
   ✓ Database connection established successfully.
   ✓ Server is running on port 5000
   ✓ API available at http://localhost:5000
   ```

4. **Keep this terminal open** - the server needs to keep running

## Verify Server is Running

Open a NEW terminal and test:
```powershell
curl http://localhost:5000/health
```

Should return: `{"success":true,"message":"Server is running"}`

## Important Notes

- **Port**: Server runs on port **5000** (not 3000)
- **Database**: Make sure MySQL is running
- **Keep server running**: Don't close the terminal where server is running
- **Flutter app**: Already configured to use port 5000

## Troubleshooting

**Server won't start?**
- Check MySQL is running
- Check database credentials in `.env`
- Check if port 5000 is already in use

**Can't connect from Flutter?**
- Android Emulator: Uses `http://10.0.2.2:5000` ✅
- iOS Simulator: Uses `http://localhost:5000` ✅
- Physical Device: Use your computer's IP address

