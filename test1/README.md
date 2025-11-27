# User-Video Management API

A RESTful API built with Node.js, Express, MySQL, and Sequelize for managing users and videos.

## Features

- **Authentication**: JWT-based authentication with register and login endpoints
- **User Management**: Full CRUD operations for users with avatar upload support
- **Video Management**: Create and retrieve video metadata with search and category filtering
- **Database**: MySQL with Sequelize ORM
- **Validation**: Request validation using Joi
- **File Upload**: Avatar image upload using Multer

## Prerequisites

- Node.js (v14 or higher)
- MySQL (v5.7 or higher)
- npm or yarn

## Installation

1. Clone the repository
2. Install dependencies:
   ```bash
   npm install
   ```

3. Create a `.env` file based on `.env.example` and configure your database and JWT secret:
   ```bash
   cp .env.example .env
   ```

4. Update the `.env` file with your MySQL credentials and JWT secret.

5. Run migrations:
   ```bash
   npm run migrate
   ```

6. (Optional) Run seeds:
   ```bash
   npm run seed
   ```

7. Start the server:
   ```bash
   npm run dev
   ```

The API will be available at `http://localhost:3000`

## API Endpoints

### Authentication

- `POST /auth/register` - Register a new user
- `POST /auth/login` - Login and get JWT token

### Users

- `GET /users` - Get all users (protected)
- `GET /users/:id` - Get user by ID (protected)
- `PUT /users/:id` - Update user (protected)
- `DELETE /users/:id` - Delete user (protected)
- `POST /users/:id/avatar` - Upload user avatar (protected)

### Videos

- `POST /videos` - Create a new video (protected)
- `GET /videos` - Get all videos with optional search and category filter
- `GET /videos/:id` - Get video by ID

## Request/Response Examples

### Register
```json
POST /auth/register
{
  "name": "John Doe",
  "email": "john@example.com",
  "password": "password123"
}
```

### Login
```json
POST /auth/login
{
  "email": "john@example.com",
  "password": "password123"
}
```

### Create Video
```json
POST /videos
Authorization: Bearer <token>
{
  "title": "My Video",
  "description": "Video description",
  "youtubeVideoId": "dQw4w9WgXcQ",
  "category": "Entertainment",
  "duration": 240
}
```

### Get Videos with Filters
```
GET /videos?search=javascript&category=Education
```

## Project Structure

```
.
├── config/
│   └── database.js
├── controllers/
│   ├── authController.js
│   ├── userController.js
│   └── videoController.js
├── middleware/
│   ├── auth.js
│   ├── upload.js
│   └── validation.js
├── migrations/
├── models/
│   ├── index.js
│   ├── user.js
│   └── video.js
├── routes/
│   ├── authRoutes.js
│   ├── userRoutes.js
│   └── videoRoutes.js
├── services/
│   ├── authService.js
│   ├── userService.js
│   └── videoService.js
├── seeders/
├── uploads/
│   └── avatars/
├── server.js
└── package.json
```
