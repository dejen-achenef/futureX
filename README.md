# Video Learning System - Full-Stack Technical Challenge

A comprehensive full-stack application demonstrating backend API development, frontend dashboards, mobile app development, microservices, and deployment.

## Project Structure

```
futureX/
├── test1/          # Node.js/Express Backend API
├── test2/          # React Frontend Dashboard
├── test3/          # Flutter Mobile App
├── test4/          # Django Reporting Service
├── docker-compose.yml  # Docker orchestration for all services
└── README.md       # This file
```

## Quick Start

### Option 1: Docker (All Services)

```bash
# 1. Create environment file
cp .env.example .env

# 2. Start all services
docker-compose up -d --build

# 3. Run migrations
docker-compose exec node_api npm run migrate

# 4. Access services
# React: http://localhost:3001
# Flutter: http://localhost:3002
# Node.js API: http://localhost:3000
# Django API: http://localhost:8000
```

### Option 2: Individual Setup

See individual README files in each test folder:

- [test1/README.md](./test1/README.md) - Backend API
- [test2/README.md](./test2/README.md) - React Frontend
- [test3/README.md](./test3/README.md) - Flutter App
- [test4/README.md](./test4/README.md) - Django Service

## Components

### Part 1: Backend API (test1)

- Node.js, Express, MySQL, Sequelize
- JWT authentication
- User & Video CRUD
- Swagger documentation

### Part 2: React Frontend (test2)

- React + TypeScript + Vite
- Material UI
- YouTube API integration
- Protected routes

### Part 3: Flutter App (test3)

- Flutter with Riverpod
- Secure storage
- YouTube player
- Offline handling

### Part 4: Django Service (test4)

- Django REST Framework
- Reporting endpoints
- Swagger documentation
- Unit tests

## API Documentation

- **Swagger (Node.js):** Visit `http://localhost:3000/api-docs` when server is running
- **Swagger (Django):** Visit `http://localhost:8000/api/docs/` when server is running

## Deployment

See deployment guides in each test folder:

- **test1:** Railway, Render, Docker
- **test2:** Vercel
- **test3:** Build APK or Web
- **test4:** Render, Docker

## Requirements

- Node.js 18+
- Python 3.11+
- MySQL 8.0+
- Docker & Docker Compose (for Docker setup)
- Flutter SDK (for test3)

## License

ISC
