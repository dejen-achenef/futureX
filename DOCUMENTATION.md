# Video Learning System - Complete Documentation

## Table of Contents

1. [Project Overview](#project-overview)
2. [Architecture](#architecture)
3. [Part 1: Backend API](#part-1-backend-api)
4. [Part 2: React Dashboard](#part-2-react-dashboard)
5. [Part 3: Flutter Mobile App](#part-3-flutter-mobile-app)
6. [Part 4: Django Reporting Service](#part-4-django-reporting-service)
7. [Part 5: Deployment](#part-5-deployment)
8. [Part 6: Bonus Features](#part-6-bonus-features)
9. [API Reference](#api-reference)
10. [Database Schema](#database-schema)
11. [Security](#security)
12. [Troubleshooting](#troubleshooting)

---

## Project Overview

The Video Learning System is a full-stack application designed for managing users and educational videos. It consists of:

- **Backend API**: Node.js/Express REST API with MySQL database
- **Web Dashboard**: React-based admin dashboard
- **Mobile App**: Flutter application for end users
- **Reporting Service**: Django microservice for analytics
- **Deployment**: Docker-based production setup
- **Bonus Features**: Push notifications, YouTube API integration

### Technology Stack

| Component | Technology |
|-----------|-----------|
| Backend API | Node.js, Express, MySQL, Sequelize |
| Frontend | React, TypeScript, Material UI |
| Mobile | Flutter, Riverpod, Dio |
| Reporting | Django, Django REST Framework |
| Deployment | Docker, Docker Compose, Nginx |
| Authentication | JWT (JSON Web Tokens) |
| Database | MySQL 8.0 |

---

## Architecture

### System Architecture Diagram

```
┌─────────────────┐
│  React Dashboard│ (Port 3001)
│   (test2)       │
└────────┬────────┘
         │
         │ HTTP/REST
         │
┌────────▼─────────────────────────────┐
│      Nginx Reverse Proxy             │ (Port 80/443)
│      (test5)                         │
└────────┬─────────────────────────────┘
         │
    ┌────┴────┬──────────────────┐
    │         │                  │
┌───▼───┐ ┌──▼────┐      ┌──────▼──────┐
│ Node  │ │Django │      │   MySQL     │
│  API  │ │Report │      │  Database   │
│(test1)│ │(test4)│      │             │
└───┬───┘ └───────┘      └─────────────┘
    │
    │ REST API
    │
┌───▼──────────────┐
│  Flutter Mobile   │
│     (test3)       │
└───────────────────┘
```

### Data Flow

1. **User Registration/Login**: React Dashboard or Flutter App → Node.js API → MySQL
2. **Video Management**: React Dashboard → Node.js API → MySQL
3. **Video Viewing**: Flutter App → Node.js API → MySQL
4. **Reporting**: Django Service → Node.js API → Process & Return Reports

---

## Part 1: Backend API

### Overview

The Node.js/Express backend provides RESTful API endpoints for authentication, user management, and video management.

### Project Structure

```
test1/
├── config/
│   └── database.cjs          # Database configuration
├── controllers/
│   ├── authController.js     # Authentication logic
│   ├── userController.js     # User CRUD operations
│   └── videoController.js    # Video CRUD operations
├── middleware/
│   ├── auth.js               # JWT authentication middleware
│   ├── upload.js             # File upload middleware (Multer)
│   └── validation.js        # Request validation (Joi)
├── migrations/
│   ├── 20240101000001-create-users.cjs
│   └── 20240101000002-create-videos.cjs
├── models/
│   ├── index.js              # Sequelize models initialization
│   ├── user.js               # User model
│   └── video.js              # Video model
├── routes/
│   ├── authRoutes.js         # Authentication routes
│   ├── userRoutes.js         # User routes
│   └── videoRoutes.js        # Video routes
├── seeders/
│   ├── 20240101000001-demo-users.cjs
│   └── 20240101000002-demo-videos.cjs
├── services/
│   ├── authService.js        # Authentication business logic
│   ├── userService.js        # User business logic
│   └── videoService.js       # Video business logic
├── uploads/
│   └── avatars/              # User avatar storage
├── server.js                 # Application entry point
└── package.json
```

### Installation & Setup

1. **Install Dependencies**
```bash
cd test1
npm install
```

2. **Configure Environment Variables**

Create a `.env` file:
```env
# Database Configuration
DB_HOST=localhost
DB_PORT=3306
DB_NAME=video_learning
DB_USER=root
DB_PASSWORD=your_password

# JWT Configuration
JWT_SECRET=your-super-secret-jwt-key-change-in-production
JWT_EXPIRES_IN=7d

# Server Configuration
PORT=3000
NODE_ENV=development

# File Upload
MAX_FILE_SIZE=5242880  # 5MB in bytes
```

3. **Create Database**
```sql
CREATE DATABASE video_learning CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

4. **Run Migrations**
```bash
npm run migrate
```

5. **Seed Database (Optional)**
```bash
npm run seed
```

6. **Start Server**
```bash
# Development
npm run dev

# Production
npm start
```

### API Endpoints

See [API Reference](#api-reference) section for detailed endpoint documentation.

### Key Features

- ✅ JWT-based authentication
- ✅ Password hashing with bcrypt
- ✅ File upload for user avatars
- ✅ Input validation with Joi
- ✅ Sequelize ORM for database operations
- ✅ Error handling middleware
- ✅ CORS enabled

---

## Part 2: React Dashboard

### Overview

A modern React dashboard built with TypeScript, Material UI, and Vite for managing users and videos.

### Project Structure

```
test2/
├── src/
│   ├── components/
│   │   └── ProtectedRoute.tsx    # Route protection component
│   ├── context/
│   │   └── AuthContext.tsx       # Authentication context
│   ├── pages/
│   │   ├── LoginPage.tsx         # Login page
│   │   ├── UserListPage.tsx      # User management page
│   │   └── VideoUploadPage.tsx   # Video upload page
│   ├── services/
│   │   ├── authService.ts        # Authentication API calls
│   │   ├── userService.ts        # User API calls
│   │   ├── videoService.ts       # Video API calls
│   │   └── youtubeService.ts     # YouTube API integration
│   ├── App.tsx                   # Main app component
│   ├── main.tsx                  # Entry point
│   └── index.css                 # Global styles
├── index.html
├── package.json
├── vite.config.ts
└── tsconfig.json
```

### Installation & Setup

1. **Install Dependencies**
```bash
cd test2
npm install
```

2. **Configure Environment Variables**

Create a `.env` file:
```env
VITE_API_URL=http://localhost:3000
VITE_YOUTUBE_API_KEY=your_youtube_api_key_here
```

**Getting YouTube API Key:**
1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select existing
3. Enable YouTube Data API v3
4. Create credentials (API Key)
5. Copy the API key to `.env`

3. **Start Development Server**
```bash
npm run dev
```

The dashboard will be available at `http://localhost:3001`

4. **Build for Production**
```bash
npm run build
```

The production build will be in the `dist` folder.

### Features

- **Login Page**
  - Email/password authentication
  - JWT token storage in localStorage
  - Error handling and validation
  - Redirect to dashboard on success

- **User List Page**
  - Display all users in a table
  - Search functionality
  - Pagination
  - User avatar display
  - Navigation to video upload

- **Video Upload Page**
  - Form for video metadata
  - YouTube video ID input
  - Auto-fetch thumbnail and metadata from YouTube
  - Category selection
  - Duration input
  - Form validation

### Usage

1. **Login**
   - Navigate to `/login`
   - Enter credentials (use seeded demo users or register via API)
   - On success, redirected to user list

2. **View Users**
   - Users are displayed automatically
   - Use search bar to filter users
   - Click pagination to navigate pages

3. **Upload Video**
   - Click "Upload Video" button
   - Enter YouTube video ID
   - Click "Fetch Metadata" to auto-fill title, description, duration
   - Select category
   - Submit form

---

## Part 3: Flutter Mobile App

### Overview

A Flutter mobile application for viewing videos with authentication, video playback, and user profile management.

### Project Structure

```
test3/
├── lib/
│   ├── core/
│   │   ├── network/
│   │   │   └── api_service.dart      # HTTP client with retry logic
│   │   └── storage/
│   │       └── secure_storage_service.dart  # Encrypted storage
│   ├── data/
│   │   ├── models/
│   │   │   ├── user_model.dart      # User data model
│   │   │   └── video_model.dart      # Video data model
│   │   └── repositories/
│   │       ├── auth_repository.dart  # Authentication repository
│   │       └── video_repository.dart # Video repository
│   ├── presentation/
│   │   ├── providers/
│   │   │   ├── auth_provider.dart    # Auth state management
│   │   │   └── video_provider.dart   # Video state management
│   │   └── screens/
│   │       ├── login_screen.dart     # Login UI
│   │       ├── home_screen.dart       # Video list UI
│   │       ├── video_details_screen.dart  # Video player UI
│   │       └── profile_screen.dart    # User profile UI
│   └── main.dart                     # App entry point
├── android/
├── ios/
├── pubspec.yaml
└── README.md
```

### Installation & Setup

1. **Install Flutter Dependencies**
```bash
cd test3
flutter pub get
```

2. **Configure API URL**

Edit `lib/presentation/providers/auth_provider.dart`:
```dart
final apiServiceProvider = Provider<ApiService>((ref) {
  // For Android Emulator:
  return ApiService(baseUrl: 'http://10.0.2.2:3000');
  
  // For iOS Simulator:
  // return ApiService(baseUrl: 'http://localhost:3000');
  
  // For Physical Device:
  // return ApiService(baseUrl: 'http://YOUR_COMPUTER_IP:3000');
});
```

3. **Run the App**
```bash
# List available devices
flutter devices

# Run on specific device
flutter run -d <device_id>

# Or run on default device
flutter run
```

### Features

- **Login Screen**
  - Email and password input
  - Form validation
  - JWT token storage in secure storage
  - Error handling
  - Loading states

- **Home Screen**
  - Video grid with thumbnails
  - Search functionality
  - Category filters
  - Pull-to-refresh
  - Offline error handling with retry
  - Video duration display

- **Video Details Screen**
  - YouTube video player
  - Video metadata display
  - Description
  - Category badge
  - Duration information

- **Profile Screen**
  - User information display
  - Avatar display
  - Logout functionality
  - Member since date

### State Management

The app uses **Riverpod** for state management:
- `authProvider`: Manages authentication state
- `videoListProvider`: Manages video list state with search/filter

### Secure Storage

JWT tokens are stored using `flutter_secure_storage`:
- Encrypted on Android (EncryptedSharedPreferences)
- Keychain on iOS
- Automatically attached to API requests

### Offline Handling

The app includes:
- Network connectivity checking
- Automatic retry on network errors
- User-friendly error messages
- Retry button on failures

---

## Part 4: Django Reporting Service

### Overview

A Django REST Framework microservice that fetches data from the Node.js API and generates reports.

### Project Structure

```
test4/
├── reporting_service/
│   ├── settings.py          # Django settings
│   ├── urls.py             # Main URL configuration
│   ├── wsgi.py             # WSGI configuration
│   └── asgi.py             # ASGI configuration
├── reports/
│   ├── services/
│   │   ├── node_api_client.py    # Node.js API client
│   │   └── report_service.py     # Report generation logic
│   ├── serializers.py      # DRF serializers
│   ├── views.py            # API views
│   ├── urls.py             # Report URLs
│   └── tests.py            # Unit tests
├── manage.py
├── requirements.txt
└── README.md
```

### Installation & Setup

1. **Create Virtual Environment**
```bash
cd test4
python -m venv venv

# Windows
venv\Scripts\activate

# Linux/Mac
source venv/bin/activate
```

2. **Install Dependencies**
```bash
pip install -r requirements.txt
```

3. **Configure Environment Variables**
```bash
# Windows
set NODE_API_URL=http://localhost:3000
set SECRET_KEY=your-django-secret-key
set DEBUG=True

# Linux/Mac
export NODE_API_URL=http://localhost:3000
export SECRET_KEY=your-django-secret-key
export DEBUG=True
```

4. **Run Migrations**
```bash
python manage.py migrate
```

5. **Start Development Server**
```bash
python manage.py runserver
```

The service will be available at `http://localhost:8000`

### API Endpoints

#### GET /report/summary

Returns summary statistics about users and videos.

**Response:**
```json
{
  "total_users": 10,
  "total_videos": 25,
  "top_categories": [
    {"category": "Programming", "count": 8},
    {"category": "Design", "count": 5},
    {"category": "Business", "count": 4}
  ]
}
```

#### GET /report/user/<user_id>

Returns activity report for a specific user.

**Response:**
```json
{
  "user": {
    "id": 1,
    "name": "John Doe",
    "email": "john@example.com"
  },
  "total_videos": 5,
  "total_duration_seconds": 1500,
  "videos_by_category": {
    "Programming": 3,
    "Design": 2
  },
  "videos": [
    {
      "id": 1,
      "title": "Introduction to React",
      "category": "Programming",
      "duration": 300
    }
  ]
}
```

### Running Tests

```bash
python manage.py test
```

The test suite includes:
- ReportService unit tests
- NodeAPIClient unit tests
- Error handling tests

---

## Part 5: Deployment

### Overview

Docker-based deployment configuration with Nginx reverse proxy, MySQL database, and all services.

### Project Structure

```
test5/
├── docker-compose.yml      # Docker Compose configuration
├── nginx/
│   └── conf.d/
│       └── default.conf     # Nginx configuration
├── test1/
│   └── Dockerfile          # Node.js API Dockerfile
├── test4/
│   └── Dockerfile          # Django API Dockerfile
└── .env.example            # Environment variables template
```

### Prerequisites

- Docker and Docker Compose installed
- SSL certificates (or self-signed for development)

### Setup

1. **Configure Environment Variables**
```bash
cd test5
cp .env.example .env
# Edit .env with your production values
```

2. **Generate SSL Certificates (Development)**
```bash
mkdir -p nginx/ssl
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout nginx/ssl/key.pem \
  -out nginx/ssl/cert.pem
```

3. **Build and Start Services**
```bash
docker-compose up -d --build
```

4. **Run Migrations**
```bash
docker-compose exec node_api npm run migrate
docker-compose exec node_api npm run seed
```

5. **Check Service Status**
```bash
docker-compose ps
```

6. **View Logs**
```bash
# All services
docker-compose logs -f

# Specific service
docker-compose logs -f node_api
```

### Services

| Service | Port | Description |
|---------|------|-------------|
| MySQL | 3306 | Database |
| Node.js API | 3000 | Backend API |
| Django API | 8000 | Reporting service |
| Nginx | 80/443 | Reverse proxy |

### Production Considerations

1. **Environment Variables**
   - Use strong secrets for JWT_SECRET and DJANGO_SECRET_KEY
   - Use secure database passwords
   - Set NODE_ENV=production

2. **SSL Certificates**
   - Use Let's Encrypt for production
   - Update certificate paths in nginx config

3. **Database Backups**
   - Set up automated MySQL backups
   - Store backups securely

4. **Monitoring**
   - Set up log aggregation
   - Monitor service health
   - Set up alerts

### Alternative: PM2 Deployment

For non-Docker deployment:

1. **Install PM2**
```bash
npm install -g pm2
```

2. **Start Node.js API**
```bash
cd test1
pm2 start server.js --name video-api
pm2 save
pm2 startup
```

3. **Start Django with Gunicorn**
```bash
cd test4
gunicorn --bind 0.0.0.0:8000 --workers 4 reporting_service.wsgi:application
```

---

## Part 6: Bonus Features

### Push Notifications

**Location**: `test6/flutter-push/`

Firebase Cloud Messaging integration for push notifications.

**Setup:**
1. Create Firebase project
2. Add `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
3. Initialize in Flutter app:
```dart
await PushNotificationService().initialize();
```

**Usage:**
```dart
final pushService = PushNotificationService();
pushService.onMessageReceived = (data) {
  // Handle notification
};
```

### YouTube API Integration

**Location**: `test6/youtube-api/`

Service for validating and fetching YouTube video metadata.

**Usage:**
```dart
final youtubeService = YouTubeAPIService(apiKey: 'YOUR_KEY');

// Validate video ID
final isValid = await youtubeService.validateVideoId('dQw4w9WgXcQ');

// Get metadata
final metadata = await youtubeService.getVideoMetadata('dQw4w9WgXcQ');
```

### Backend Push Notifications

**Location**: `test6/backend-service/`

Node.js service for sending push notifications from backend.

**Setup:**
1. Install Firebase Admin SDK
2. Add service account JSON
3. Use in video creation:
```javascript
import { notifyNewVideo } from './push_notification_controller.js';
await notifyNewVideo(user.fcmToken, video);
```

---

## API Reference

### Authentication Endpoints

#### POST /auth/register

Register a new user.

**Request Body:**
```json
{
  "name": "John Doe",
  "email": "john@example.com",
  "password": "password123"
}
```

**Response:**
```json
{
  "success": true,
  "message": "User registered successfully",
  "data": {
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "user": {
      "id": 1,
      "name": "John Doe",
      "email": "john@example.com",
      "createdAt": "2024-01-01T00:00:00.000Z"
    }
  }
}
```

#### POST /auth/login

Login user and get JWT token.

**Request Body:**
```json
{
  "email": "john@example.com",
  "password": "password123"
}
```

**Response:**
```json
{
  "success": true,
  "message": "Login successful",
  "data": {
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "user": {
      "id": 1,
      "name": "John Doe",
      "email": "john@example.com"
    }
  }
}
```

### User Endpoints

#### GET /users

Get all users (Protected).

**Headers:**
```
Authorization: Bearer <token>
```

**Query Parameters:**
- `search` (optional): Search by name or email
- `page` (optional): Page number
- `limit` (optional): Items per page

**Response:**
```json
{
  "success": true,
  "data": [
    {
      "id": 1,
      "name": "John Doe",
      "email": "john@example.com",
      "avatar": "/uploads/avatars/avatar.jpg",
      "createdAt": "2024-01-01T00:00:00.000Z"
    }
  ],
  "total": 10,
  "page": 1,
  "limit": 10
}
```

#### POST /users/:id/avatar

Upload user avatar (Protected).

**Headers:**
```
Authorization: Bearer <token>
Content-Type: multipart/form-data
```

**Request Body:**
- `avatar`: Image file (max 5MB)

**Response:**
```json
{
  "success": true,
  "message": "Avatar uploaded successfully",
  "data": {
    "avatar": "/uploads/avatars/avatar.jpg"
  }
}
```

### Video Endpoints

#### POST /videos

Create a new video (Protected).

**Headers:**
```
Authorization: Bearer <token>
```

**Request Body:**
```json
{
  "title": "Introduction to React",
  "description": "Learn the basics of React",
  "youtubeVideoId": "dQw4w9WgXcQ",
  "category": "Programming",
  "duration": 300
}
```

**Response:**
```json
{
  "success": true,
  "message": "Video created successfully",
  "data": {
    "id": 1,
    "title": "Introduction to React",
    "description": "Learn the basics of React",
    "youtubeVideoId": "dQw4w9WgXcQ",
    "category": "Programming",
    "duration": 300,
    "userId": 1,
    "createdAt": "2024-01-01T00:00:00.000Z"
  }
}
```

#### GET /videos

Get all videos (Public).

**Query Parameters:**
- `search` (optional): Search in title/description
- `category` (optional): Filter by category

**Response:**
```json
{
  "success": true,
  "data": [
    {
      "id": 1,
      "title": "Introduction to React",
      "description": "Learn the basics of React",
      "youtubeVideoId": "dQw4w9WgXcQ",
      "category": "Programming",
      "duration": 300,
      "userId": 1,
      "createdAt": "2024-01-01T00:00:00.000Z"
    }
  ]
}
```

#### GET /videos/:id

Get video by ID (Public).

**Response:**
```json
{
  "success": true,
  "data": {
    "id": 1,
    "title": "Introduction to React",
    "description": "Learn the basics of React",
    "youtubeVideoId": "dQw4w9WgXcQ",
    "category": "Programming",
    "duration": 300,
    "userId": 1,
    "user": {
      "id": 1,
      "name": "John Doe"
    },
    "createdAt": "2024-01-01T00:00:00.000Z"
  }
}
```

---

## Database Schema

### Users Table

```sql
CREATE TABLE users (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  password VARCHAR(255) NOT NULL,
  avatar VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
```

### Videos Table

```sql
CREATE TABLE videos (
  id INT PRIMARY KEY AUTO_INCREMENT,
  title VARCHAR(255) NOT NULL,
  description TEXT,
  youtube_video_id VARCHAR(255) NOT NULL,
  category VARCHAR(255) NOT NULL,
  duration INT NOT NULL,
  user_id INT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  INDEX idx_category (category),
  INDEX idx_youtube_video_id (youtube_video_id),
  INDEX idx_user_id (user_id)
);
```

---

## Security

### Authentication

- JWT tokens with expiration (7 days default)
- Password hashing with bcrypt (10 rounds)
- Protected routes require valid JWT token

### Data Protection

- Input validation with Joi
- SQL injection prevention (Sequelize ORM)
- File upload size limits (5MB)
- CORS configuration

### Best Practices

1. **Environment Variables**: Never commit `.env` files
2. **Secrets**: Use strong, random secrets in production
3. **HTTPS**: Always use HTTPS in production
4. **Token Storage**: Use secure storage (httpOnly cookies or secure storage)
5. **Password Policy**: Enforce strong passwords

---

## Troubleshooting

### Backend API Issues

**Problem**: Database connection error
- **Solution**: Check database credentials in `.env`
- **Solution**: Ensure MySQL is running
- **Solution**: Verify database exists

**Problem**: JWT token invalid
- **Solution**: Check JWT_SECRET matches
- **Solution**: Verify token hasn't expired
- **Solution**: Ensure token is sent in Authorization header

### React Dashboard Issues

**Problem**: API calls failing
- **Solution**: Check VITE_API_URL in `.env`
- **Solution**: Verify backend API is running
- **Solution**: Check browser console for CORS errors

**Problem**: YouTube API not working
- **Solution**: Verify YouTube API key is valid
- **Solution**: Check API quota limits
- **Solution**: Ensure YouTube Data API v3 is enabled

### Flutter App Issues

**Problem**: Cannot connect to API
- **Solution**: For Android emulator, use `10.0.2.2:3000`
- **Solution**: For iOS simulator, use `localhost:3000`
- **Solution**: For physical device, use computer's IP address
- **Solution**: Check firewall settings

**Problem**: YouTube player not loading
- **Solution**: Check internet connection
- **Solution**: Verify YouTube video ID is valid
- **Solution**: Check YouTube player plugin permissions

### Django Service Issues

**Problem**: Cannot fetch from Node.js API
- **Solution**: Check NODE_API_URL environment variable
- **Solution**: Verify Node.js API is running
- **Solution**: Check network connectivity

### Deployment Issues

**Problem**: Docker containers not starting
- **Solution**: Check Docker logs: `docker-compose logs`
- **Solution**: Verify environment variables in `.env`
- **Solution**: Check port conflicts

**Problem**: Nginx SSL errors
- **Solution**: Verify SSL certificate paths
- **Solution**: Check certificate permissions
- **Solution**: Ensure certificates are valid

---

## Additional Resources

### Documentation Links

- [Node.js Documentation](https://nodejs.org/docs/)
- [Express.js Guide](https://expressjs.com/en/guide/routing.html)
- [Sequelize Documentation](https://sequelize.org/docs/v6/)
- [React Documentation](https://react.dev/)
- [Flutter Documentation](https://docs.flutter.dev/)
- [Django REST Framework](https://www.django-rest-framework.org/)

### API Testing

Use tools like:
- Postman
- Insomnia
- curl
- Thunder Client (VS Code extension)

### Example curl Commands

```bash
# Register user
curl -X POST http://localhost:3000/auth/register \
  -H "Content-Type: application/json" \
  -d '{"name":"John Doe","email":"john@example.com","password":"password123"}'

# Login
curl -X POST http://localhost:3000/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"john@example.com","password":"password123"}'

# Get videos
curl http://localhost:3000/videos

# Create video (with token)
curl -X POST http://localhost:3000/videos \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"title":"Test Video","youtubeVideoId":"dQw4w9WgXcQ","category":"Programming","duration":300}'
```

---

## Support

For issues or questions:
1. Check the troubleshooting section
2. Review error logs
3. Verify environment configuration
4. Check API documentation

---

**Last Updated**: 2024
**Version**: 1.0.0

