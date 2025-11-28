/**
 * Push Notification Controller for Node.js API
 * Sends push notifications to Flutter app via FCM
 */

import admin from 'firebase-admin';
import serviceAccount from './firebase-service-account.json' assert { type: 'json' };

// Initialize Firebase Admin SDK
if (!admin.apps.length) {
  admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
  });
}

/**
 * Send push notification to a specific device
 * @param {string} fcmToken - FCM token of the device
 * @param {Object} notification - Notification payload
 * @param {Object} data - Additional data payload
 */
export const sendPushNotification = async (fcmToken, notification, data = {}) => {
  try {
    const message = {
      notification: {
        title: notification.title,
        body: notification.body,
      },
      data: {
        ...data,
        click_action: 'FLUTTER_NOTIFICATION_CLICK',
      },
      token: fcmToken,
    };

    const response = await admin.messaging().send(message);
    console.log('Successfully sent message:', response);
    return { success: true, messageId: response };
  } catch (error) {
    console.error('Error sending message:', error);
    return { success: false, error: error.message };
  }
};

/**
 * Send push notification to multiple devices
 * @param {string[]} fcmTokens - Array of FCM tokens
 * @param {Object} notification - Notification payload
 * @param {Object} data - Additional data payload
 */
export const sendMulticastNotification = async (fcmTokens, notification, data = {}) => {
  try {
    const message = {
      notification: {
        title: notification.title,
        body: notification.body,
      },
      data: {
        ...data,
        click_action: 'FLUTTER_NOTIFICATION_CLICK',
      },
      tokens: fcmTokens,
    };

    const response = await admin.messaging().sendEachForMulticast(message);
    console.log(`Successfully sent ${response.successCount} messages`);
    return {
      success: true,
      successCount: response.successCount,
      failureCount: response.failureCount,
    };
  } catch (error) {
    console.error('Error sending multicast message:', error);
    return { success: false, error: error.message };
  }
};

/**
 * Send push notification to a topic
 * @param {string} topic - Topic name
 * @param {Object} notification - Notification payload
 * @param {Object} data - Additional data payload
 */
export const sendTopicNotification = async (topic, notification, data = {}) => {
  try {
    const message = {
      notification: {
        title: notification.title,
        body: notification.body,
      },
      data: {
        ...data,
        click_action: 'FLUTTER_NOTIFICATION_CLICK',
      },
      topic: topic,
    };

    const response = await admin.messaging().send(message);
    console.log('Successfully sent topic message:', response);
    return { success: true, messageId: response };
  } catch (error) {
    console.error('Error sending topic message:', error);
    return { success: false, error: error.message };
  }
};

/**
 * Example: Send notification when a new video is uploaded
 */
export const notifyNewVideo = async (fcmToken, video) => {
  return sendPushNotification(
    fcmToken,
    {
      title: 'New Video Available',
      body: `Check out: ${video.title}`,
    },
    {
      type: 'new_video',
      videoId: video.id.toString(),
      category: video.category,
    }
  );
};

