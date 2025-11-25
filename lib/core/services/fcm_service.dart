import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:safi/core/di/service_locator.dart';
import 'package:safi/core/logging/app_logger.dart';
import 'package:safi/core/services/firebase_auth_service.dart';
import 'package:safi/core/services/firebase_firestore_service.dart';
import 'package:safi/features/notifications/presentations/view/notifications_view.dart';
import 'package:safi/safi_app.dart';

import 'local_notiffication_service.dart';

class FcmService {
  FcmService._();

  static final FcmService instance = FcmService._();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future<void> init() async {
    await _requestPermissions();

    // Foreground
    FirebaseMessaging.onMessage.listen(_handleMessage);

    // Background
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // TERMINATED
    await _handleInitialMessage();

    // Token
    String? token = await _messaging.getToken();
    AppLogger.info("FCM Token: $token");
  }

  Future<void> _requestPermissions() async {
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    AppLogger.info('Permission: ${settings.authorizationStatus}');
  }

  // -------------------------
  // MAIN HANDLER (Foreground + Terminated)
  // -------------------------
  void _handleMessage(RemoteMessage message) async {
    _saveNotification(message);

    // 2) Show local notification
    if (message.notification != null) {
      LocalNotificationService.instance.showNotification(
        id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        title: message.notification!.title ?? '',
        body: message.notification!.body ?? '',
      );
    }

    navigatorKey.currentState?.pushNamed(NotificationsView.routeName);
  }

  // -------------------------
  // For TERMINATED APPS
  // -------------------------
  Future<void> _handleInitialMessage() async {
    final message = await FirebaseMessaging.instance.getInitialMessage();

    if (message != null) {
      _handleMessage(message);
    }
  }

  // -------------------------
  // Save in Firestore
  // -------------------------
  void _saveNotification(RemoteMessage message) {
    injector<FirebaseStoreService>().sendNotification(
      userId: injector<FirebaseAuthService>().currentUser()!.uid,
      title: message.notification?.title ?? '',
      body: message.notification?.body ?? '',
    );
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (message.notification != null) {
    LocalNotificationService.instance.showNotification(
      id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title: message.notification!.title ?? '',
      body: message.notification!.body ?? '',
    );
  }
}
