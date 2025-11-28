# Video Learning System - Full-Stack Technical Challenge

A comprehensive full-stack application demonstrating backend API development, frontend dashboards, mobile app development, microservices, and deployment.

## 📚 Documentation

- **[Quick Start Guide](./QUICK_START.md)** - Get up and running in 5 minutes
- **[Complete Documentation](./DOCUMENTATION.md)** - Comprehensive guide with API reference, architecture, and troubleshooting

## Project Structure

```
test_Project/
├── test1/          # Part 1: Node.js/Express Backend API
├── test2/          # Part 2: React Frontend Dashboard
├── test3/          # Part 3: Flutter Mobile App
├── test4/          # Part 4: Django Reporting Service
├── test5/          # Part 5: Deployment Configurations
└── test6/          # Part 6: Bonus Features
```

## Part 1: Backend API (test1)

**Technology**: Node.js, Express, MySQL, Sequelize, JWT

**Features**:
- ✅ User authentication (register/login with JWT)
- ✅ User CRUD operations
- ✅ Avatar upload
- ✅ Video metadata management
- ✅ Sequelize migrations & seeders
- ✅ Joi validation
- ✅ Protected routes middleware

**Endpoints**:
- `POST /auth/register` - Register new user
- `POST /auth/login` - Login user
- `GET /users` - Get all users (protected)
- `POST /videos` - Create video (protected)
- `GET /videos?search=&category=` - Get videos with filters

**Setup**:
```bash
cd test1
npm install
cp .env.example .env  # Configure database
npm run migrate
npm run seed
npm start
```

## Part 2: React Dashboard (test2)

**Technology**: React, TypeScript, Material UI, Vite

**Features**:
- ✅ Login page with JWT storage
- ✅ User list with search and pagination
- ✅ Video upload with YouTube API integration
- ✅ Auto-fetch thumbnail and metadata
- ✅ Responsive design

**Setup**:
```bash
cd test2
npm install
cp .env.example .env  # Set API URL and YouTube API key
npm run dev
```

## Part 3: Flutter Mobile App (test3)

**Technology**: Flutter, Riverpod, Dio, Secure Storage

**Features**:
- ✅ Login screen with JWT authentication
- ✅ Home screen with video list (thumbnails, categories)
- ✅ Video details screen with YouTube player
- ✅ Profile screen
- ✅ Secure storage for JWT
- ✅ Offline handling with retry
- ✅ State management with Riverpod

**Setup**:
```bash
cd test3
flutter pub get
flutter run
```

**Note**: Update API URL in `lib/presentation/providers/auth_provider.dart`:
- Android Emulator: `http://10.0.2.2:3000`
- iOS Simulator: `http://localhost:3000`
- Physical Device: `http://YOUR_IP:3000`

## Part 4: Django Reporting Service (test4)

**Technology**: Django, Django REST Framework, Python requests

**Features**:
- ✅ Fetches data from Node.js API
- ✅ Summary report endpoint
- ✅ User activity report endpoint
- ✅ DRF serializers and viewsets
- ✅ Unit tests (3+ tests)

**Endpoints**:
- `GET /report/summary` - Total users, videos, top categories
- `GET /report/user/<id>` - User activity report

**Setup**:
```bash
cd test4
python -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate
pip install -r requirements.txt
export NODE_API_URL=http://localhost:3000
python manage.py migrate
python manage.py runserver
```

## Part 5: Deployment (test5)

**Technology**: Docker, Docker Compose, Nginx, PM2

**Features**:
- ✅ Docker Compose configuration
- ✅ Nginx reverse proxy with SSL
- ✅ MySQL database setup
- ✅ Environment variable management
- ✅ Production-ready configurations

**Services**:
- MySQL (port 3306)
- Node.js API (port 3000)
- Django API (port 8000)
- Nginx (ports 80/443)

**Setup**:
```bash
cd test5
cp .env.example .env  # Configure environment
docker-compose up -d
```

## Part 6: Bonus Features (test6)

**Features**:
- ✅ Firebase Push Notifications (Flutter)
- ✅ YouTube API Integration
- ✅ Secure Storage examples
- ✅ Backend push notification service

**Components**:
- `flutter-push/` - Push notification service
- `youtube-api/` - YouTube API integration
- `backend-service/` - Backend push notification controller

## Quick Start

> **New to the project?** Check out the [Quick Start Guide](./QUICK_START.md) for a step-by-step setup.

### 1. Start Backend API
```bash
cd test1
npm install
# Configure .env with database credentials
npm run migrate
npm run seed
npm start
```

### 2. Start React Dashboard
```bash
cd test2
npm install
# Configure .env with API URL
npm run dev
```

### 3. Run Flutter App
```bash
cd test3
flutter pub get
# Update API URL in auth_provider.dart
flutter run
```

### 4. Start Django Reporting Service
```bash
cd test4
pip install -r requirements.txt
export NODE_API_URL=http://localhost:3000
python manage.py runserver
```

### 5. Deploy with Docker
```bash
cd test5
docker-compose up -d
```

## Environment Variables

### test1 (Node.js API)
```
DB_HOST=localhost
DB_PORT=3306
DB_NAME=video_learning
DB_USER=root
DB_PASSWORD=password
JWT_SECRET=your-secret-key
PORT=3000
```

### test2 (React)
```
VITE_API_URL=http://localhost:3000
VITE_YOUTUBE_API_KEY=your-youtube-api-key
```

### test4 (Django)
```
NODE_API_URL=http://localhost:3000
SECRET_KEY=your-django-secret-key
DEBUG=True
```

## Testing

### Backend API Tests
```bash
cd test1
npm test  # If tests are configured
```

### Django Tests
```bash
cd test4
python manage.py test
```

## Production Deployment

1. **Set strong secrets** in environment variables
2. **Configure SSL certificates** for Nginx
3. **Set up database backups** for MySQL
4. **Use PM2** for Node.js process management
5. **Configure firewall** rules
6. **Set up monitoring** and logging

## API Documentation

### Authentication
- Register: `POST /auth/register` - { name, email, password }
- Login: `POST /auth/login` - { email, password } → Returns JWT token

### Videos
- List: `GET /videos?search=query&category=Programming`
- Create: `POST /videos` (requires auth) - { title, description, youtubeVideoId, category, duration }
- Get: `GET /videos/:id`

### Reports
- Summary: `GET /report/summary`
- User Activity: `GET /report/user/:id`

## Technologies Used

- **Backend**: Node.js, Express, MySQL, Sequelize
- **Frontend**: React, TypeScript, Material UI
- **Mobile**: Flutter, Riverpod, Dio
- **Microservice**: Django, DRF
- **Deployment**: Docker, Nginx, PM2
- **Bonus**: Firebase, YouTube API

## License

This is a technical challenge project for assessment purposes.

