# Video Learning Dashboard (React)

A React dashboard for managing users and videos in the Video Learning system.

## Features

- **Login Page**: JWT-based authentication with secure token storage
- **User List Page**: View all users with search and pagination
- **Video Upload Page**: Upload video metadata with YouTube API integration

## Setup

1. Install dependencies:
```bash
npm install
```

2. Create a `.env` file:
```bash
cp .env.example .env
```

3. Update `.env` with your API URL and YouTube API key:
```
VITE_API_URL=http://localhost:3000
VITE_YOUTUBE_API_KEY=your_youtube_api_key_here
```

4. Start the development server:
```bash
npm run dev
```

The app will be available at `http://localhost:3001`

## Features Implemented

- ✅ Login page with JWT authentication
- ✅ Secure token storage (localStorage - use httpOnly cookies in production)
- ✅ User list page with search and pagination
- ✅ Video upload page with YouTube API integration
- ✅ Auto-fetch thumbnail and metadata from YouTube
- ✅ Material UI components
- ✅ Responsive design
- ✅ Protected routes

## Production Deployment

For production, deploy to Vercel or configure Nginx:

```bash
npm run build
```

The build output will be in the `dist` folder.

