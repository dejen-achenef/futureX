# Quick Start Guide

Get the Video Learning System up and running in minutes!

## Prerequisites

- Node.js 18+ and npm
- MySQL 8.0+
- Python 3.11+ (for Django service)
- Flutter SDK (for mobile app)
- Docker and Docker Compose (optional, for deployment)

## 5-Minute Setup

### Step 1: Backend API (test1)

```bash
cd test1
npm install

# Create .env file
cat > .env << EOF
DB_HOST=localhost
DB_PORT=3306
DB_NAME=video_learning
DB_USER=root
DB_PASSWORD=your_password
JWT_SECRET=your-secret-key
PORT=3000
EOF

# Create database
mysql -u root -p -e "CREATE DATABASE video_learning;"

# Run migrations
npm run migrate

# Seed database
npm run seed

# Start server
npm start
```

✅ Backend running on `http://localhost:3000`

### Step 2: React Dashboard (test2)

```bash
cd test2
npm install

# Create .env file
cat > .env << EOF
VITE_API_URL=http://localhost:3000
VITE_YOUTUBE_API_KEY=your_youtube_api_key
EOF

# Start dev server
npm run dev
```

✅ Dashboard running on `http://localhost:3001`

### Step 3: Flutter App (test3)

```bash
cd test3
flutter pub get

# Update API URL in lib/presentation/providers/auth_provider.dart
# For Android Emulator: http://10.0.2.2:3000
# For iOS Simulator: http://localhost:3000

flutter run
```

✅ Flutter app running on your device/emulator

### Step 4: Django Reporting (test4) - Optional

```bash
cd test4
python -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate
pip install -r requirements.txt

export NODE_API_URL=http://localhost:3000
python manage.py migrate
python manage.py runserver
```

✅ Reporting service on `http://localhost:8000`

## Test the System

### 1. Register a User (via API)

```bash
curl -X POST http://localhost:3000/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Test User",
    "email": "test@example.com",
    "password": "password123"
  }'
```

### 2. Login via Dashboard

1. Open `http://localhost:3001`
2. Use the credentials from step 1
3. You'll see the user list

### 3. Upload a Video

1. Click "Upload Video" in dashboard
2. Enter YouTube video ID (e.g., `dQw4w9WgXcQ`)
3. Click "Fetch Metadata"
4. Fill in category and submit

### 4. View Videos in Flutter App

1. Login in Flutter app
2. Browse videos on home screen
3. Tap a video to play

## Default Test Credentials

After running seeders, you can use:

- **Email**: `demo@example.com`
- **Password**: `password123`

## Common Issues

### Backend won't start
- Check MySQL is running
- Verify database credentials
- Ensure port 3000 is available

### React dashboard shows errors
- Verify backend is running
- Check `VITE_API_URL` in `.env`
- Clear browser cache

### Flutter can't connect
- Android Emulator: Use `10.0.2.2:3000`
- iOS Simulator: Use `localhost:3000`
- Physical device: Use your computer's IP

## Next Steps

- Read [DOCUMENTATION.md](./DOCUMENTATION.md) for detailed information
- Check [README.md](./README.md) for project overview
- Explore the code in each test folder

## Need Help?

1. Check the troubleshooting section in DOCUMENTATION.md
2. Review error logs in console
3. Verify all environment variables are set

Happy coding! 🚀

