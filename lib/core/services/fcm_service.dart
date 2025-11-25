import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:safi/core/di/service_locator.dart';
import 'package:safi/core/logging/app_logger.dart';
import 'package:safi/core/services/firebase_auth_service.dart';
import 'package:safi/core/services/firebase_firestore_service.dart';

import 'local_notiffication_service.dart';

class FcmService {
  FcmService._();

  static final FcmService instance = FcmService._();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future<void> init() async {
    // Request permissions
    await _requestPermissions();

    FirebaseMessaging.onMessage.listen(_handleMessage);

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    String? token = await _messaging.getToken();
    AppLogger.info("FCM Token: $token");
  }

  Future<void> _requestPermissions() async {
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    AppLogger.info('User granted permission: ${settings.authorizationStatus}');
  }

  void _handleMessage(RemoteMessage message) {
    if (message.notification != null) {
      _saveNotification(message);

      LocalNotificationService.instance.showNotification(
        id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        title: message.notification!.title ?? '',
        body: message.notification!.body ?? '',
      );
    }
  }

  void _saveNotification(RemoteMessage message) {
    injector<FirebaseStoreService>().sendNotification(
      userId: injector<FirebaseAuthService>().currentUser()!.uid,
      title: message.notification!.title ?? '',
      body: message.notification!.body ?? '',
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
