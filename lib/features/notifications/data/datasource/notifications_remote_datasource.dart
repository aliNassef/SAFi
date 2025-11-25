import 'package:safi/core/services/firebase_firestore_service.dart';
import 'package:safi/features/notifications/data/model/notification_model.dart';

abstract class NotificationsRemoteDataSource {
  Future<List<NotificationModel>> getNotifications(String uid);
  Future<num> getUnReadCountNotifications(String uid);
  Future<void> markAsRead(String notifId);
}

class NotificationsRemoteDataSourceImpl
    implements NotificationsRemoteDataSource {
  final FirebaseStoreService _service;

  NotificationsRemoteDataSourceImpl({required FirebaseStoreService service})
    : _service = service;
  @override
  Future<List<NotificationModel>> getNotifications(String uid) async {
    final res = await _service.getUserNotifications(uid);
    return res.docs.map(
      (doc) {
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return NotificationModel.fromJson(data);
      },
    ).toList();
  }

  @override
  Future<num> getUnReadCountNotifications(String uid) async {
    final res = await _service.getUserNotifications(uid);
    final notiCount = res.docs
        .where((doc) => (doc.data() as Map)['read'] == false)
        .length;
    return notiCount;
  }

  @override
  Future<void> markAsRead(String notifId) async => _service.markAsRead(notifId);
}
