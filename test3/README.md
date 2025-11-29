# Video Learning App (Flutter)

A Flutter mobile application for the Video Learning system with authentication, video browsing, and YouTube player integration.

## Features

- **Login Screen**: JWT authentication using API
- **Home Screen**: List videos with thumbnails, titles, and categories
- **Video Details Screen**: Play YouTube videos using YouTube Player plugin
- **Profile Screen**: Update user information
- **Secure Storage**: JWT token stored securely
- **State Management**: Riverpod for state management
- **Offline Handling**: Retry mechanism for network failures

## Prerequisites

- Flutter SDK (3.35.0 or higher)
- Dart SDK (3.9.0 or higher)
- Android Studio / Xcode (for mobile builds)
- API running at `http://localhost:3000` (or update API URL in code)

## Setup

1. Install dependencies:
   ```bash
   flutter pub get
   ```

2. Update API URL in `lib/presentation/providers/auth_provider.dart`:
   ```dart
   // For Android Emulator
   static const String baseUrl = 'http://10.0.2.2:3000';
   
   // For iOS Simulator
   static const String baseUrl = 'http://localhost:3000';
   
   // For Physical Device
   static const String baseUrl = 'http://YOUR_IP:3000';
   ```

3. Run the app:
   ```bash
   flutter run
   ```

## Build

### Android APK
```bash
# Build release APK (smaller size)
flutter build apk --release --split-per-abi

# Build single APK
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

## Project Structure

```
lib/
├── core/           # Core utilities (network, storage, utils)
├── data/           # Data models and repositories
├── presentation/   # UI screens and providers
└── main.dart       # Application entry point
```

## Docker

The app can be built as a web app using Docker:
```bash
docker build -t flutter-web ./test3
docker run -p 3002:80 flutter-web
```

## Features Implemented

- ✅ Login screen with JWT authentication
- ✅ Home screen with video list (thumbnails, categories)
- ✅ Video details screen with YouTube player
- ✅ Profile screen for user updates
- ✅ Secure storage for JWT tokens
- ✅ REST API integration
- ✅ Offline handling with retry
- ✅ State management with Riverpod

## Testing

```bash
flutter test
```
