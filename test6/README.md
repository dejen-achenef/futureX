# Bonus Features (Part 6)

This directory contains bonus features for the Video Learning system.

## Features

### 1. Push Notifications (Flutter + Firebase)

**Location**: `flutter-push/`

Flutter service for handling push notifications using Firebase Cloud Messaging (FCM).

**Features**:
- FCM token management
- Foreground and background message handling
- Local notifications
- Topic subscriptions

**Setup**:
1. Add Firebase to your Flutter project
2. Add `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
3. Initialize in your app:
```dart
await PushNotificationService().initialize();
```

**Usage**:
```dart
final pushService = PushNotificationService();
pushService.onMessageReceived = (data) {
  // Handle notification data
};
```

### 2. YouTube API Integration

**Location**: `youtube-api/`

Service for validating and fetching YouTube video metadata.

**Features**:
- Video ID validation
- Metadata fetching (title, description, thumbnail, duration)
- URL parsing and video ID extraction
- Thumbnail URL generation

**Usage**:
```dart
final youtubeService = YouTubeAPIService(apiKey: 'YOUR_API_KEY');

// Validate video ID
final isValid = await youtubeService.validateVideoId('dQw4w9WgXcQ');

// Get metadata
final metadata = await youtubeService.getVideoMetadata('dQw4w9WgXcQ');

// Get thumbnail
final thumbnail = YouTubeAPIService.getThumbnailUrl('dQw4w9WgXcQ');
```

### 3. Secure Storage

**Location**: Already implemented in `test3/lib/core/storage/secure_storage_service.dart`

Features:
- Encrypted storage for Android and iOS
- JWT token storage
- User data storage

### 4. Backend Push Notification Service

**Location**: `backend-service/`

Node.js service for sending push notifications from the backend.

**Setup**:
1. Install Firebase Admin SDK:
```bash
npm install firebase-admin
```

2. Download Firebase service account JSON file
3. Place it as `firebase-service-account.json`

**Usage**:
```javascript
import { sendPushNotification, notifyNewVideo } from './push_notification_controller.js';

// Send to single device
await sendPushNotification(
  fcmToken,
  { title: 'Hello', body: 'World' },
  { type: 'custom' }
);

// Notify about new video
await notifyNewVideo(fcmToken, video);
```

## Integration

### Flutter App Integration

Add to `test3/pubspec.yaml`:
```yaml
dependencies:
  firebase_core: ^2.24.2
  firebase_messaging: ^14.7.9
  flutter_local_notifications: ^16.3.0
```

### Backend Integration

Add push notification endpoint to `test1/routes/videoRoutes.js`:
```javascript
import { notifyNewVideo } from '../../test6/backend-service/push_notification_controller.js';

router.post('/', authenticate, async (req, res) => {
  // ... create video logic
  // Send notification
  if (user.fcmToken) {
    await notifyNewVideo(user.fcmToken, video);
  }
});
```

## Testing

### Test Push Notifications
1. Get FCM token from Flutter app
2. Use Firebase Console or backend API to send test notification

### Test YouTube API
```dart
final service = YouTubeAPIService(apiKey: 'test');
final isValid = await service.validateVideoId('dQw4w9WgXcQ');
print('Valid: $isValid');
```

