# Quick Start Guide

## Prerequisites
- Node.js (v14 or higher)
- MySQL (v5.7 or higher)
- npm or yarn

## Setup Steps

1. **Install Dependencies**
   ```bash
   npm install
   ```

2. **Configure Environment**
   - Create a `.env` file (see `ENV_SETUP.md` for details)
   - Update database credentials in `.env`

3. **Create MySQL Database**
   ```sql
   CREATE DATABASE user_video_db;
   ```

4. **Run Setup Script** (creates upload directories)
   ```bash
   npm run setup
   ```

5. **Run Migrations**
   ```bash
   npm run migrate
   ```

6. **Seed Database (Optional)**
   ```bash
   npm run seed
   ```

7. **Start Server**
   ```bash
   npm run dev
   ```

The API will be available at `http://localhost:3000`

## Testing the API

### 1. Register a User
```bash
POST http://localhost:3000/auth/register
Content-Type: application/json

{
  "name": "John Doe",
  "email": "john@example.com",
  "password": "password123"
}
```

### 2. Login
```bash
POST http://localhost:3000/auth/login
Content-Type: application/json

{
  "email": "john@example.com",
  "password": "password123"
}
```

### 3. Get All Videos (with filters)
```bash
GET http://localhost:3000/videos?search=node&category=Education
```

### 4. Create a Video (requires authentication)
```bash
POST http://localhost:3000/videos
Authorization: Bearer <your-jwt-token>
Content-Type: application/json

{
  "title": "My Video",
  "description": "Video description",
  "youtubeVideoId": "dQw4w9WgXcQ",
  "category": "Entertainment",
  "duration": 240
}
```

### 5. Get All Users (requires authentication)
```bash
GET http://localhost:3000/users
Authorization: Bearer <your-jwt-token>
```

### 6. Upload Avatar (requires authentication)
```bash
POST http://localhost:3000/users/:id/avatar
Authorization: Bearer <your-jwt-token>
Content-Type: multipart/form-data

avatar: <image-file>
```

## Default Seed Data

If you ran the seed command, you can login with:
- Email: `john@example.com`
- Password: `password123`

Or:
- Email: `jane@example.com`
- Password: `password123`
