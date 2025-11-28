# Deployment Configuration

This directory contains deployment configurations for the Video Learning system.

## Docker Compose Setup

### Prerequisites
- Docker and Docker Compose installed
- SSL certificates for HTTPS (or use self-signed for development)

### Quick Start

1. Copy environment file:
```bash
cp .env.example .env
```

2. Update `.env` with your production values

3. Generate SSL certificates (for development):
```bash
mkdir -p nginx/ssl
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout nginx/ssl/key.pem \
  -out nginx/ssl/cert.pem
```

4. Start all services:
```bash
docker-compose up -d
```

5. Run migrations:
```bash
docker-compose exec node_api npm run migrate
docker-compose exec node_api npm run seed
```

## Services

- **MySQL**: Database on port 3306
- **Node.js API**: Backend API on port 3000
- **Django API**: Reporting service on port 8000
- **Nginx**: Reverse proxy on ports 80/443

## Production Deployment

### Using PM2 (Alternative to Docker)

1. Install PM2:
```bash
npm install -g pm2
```

2. Start Node.js API:
```bash
cd test1
pm2 start server.js --name video-api
pm2 save
pm2 startup
```

3. Start Django with Gunicorn:
```bash
cd test4
gunicorn --bind 0.0.0.0:8000 reporting_service.wsgi:application
```

### Nginx Configuration

1. Copy nginx config:
```bash
sudo cp nginx/conf.d/default.conf /etc/nginx/sites-available/video-learning
sudo ln -s /etc/nginx/sites-available/video-learning /etc/nginx/sites-enabled/
```

2. Test and reload:
```bash
sudo nginx -t
sudo systemctl reload nginx
```

### MySQL Backup

Create backup script:
```bash
#!/bin/bash
mysqldump -u root -p video_learning > backup_$(date +%Y%m%d_%H%M%S).sql
```

### Environment Variables

Set in production:
- Strong JWT_SECRET
- Strong DJANGO_SECRET_KEY
- Secure database passwords
- SSL certificates from Let's Encrypt

## Monitoring

- Check logs: `docker-compose logs -f [service_name]`
- Check status: `docker-compose ps`
- Restart service: `docker-compose restart [service_name]`

