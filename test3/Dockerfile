# Flutter web build - Multi-stage
FROM ghcr.io/cirruslabs/flutter:stable AS builder

WORKDIR /app

# Build argument for API URL
ARG API_URL=http://localhost:3000
ENV API_URL=$API_URL

# Copy pubspec files
COPY pubspec.yaml pubspec.lock ./

# Get dependencies
RUN flutter pub get

# Copy application files
COPY . .

# Build Flutter web
RUN flutter build web --release --dart-define=API_URL=$API_URL

# Production stage - serve with nginx
FROM nginx:alpine

# Copy built files from builder
COPY --from=builder /app/build/web /usr/share/nginx/html

# Copy nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port
EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget --quiet --tries=1 --spider http://localhost/ || exit 1

# Start nginx
CMD ["nginx", "-g", "daemon off;"]

