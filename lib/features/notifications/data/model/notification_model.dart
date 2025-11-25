import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  final String title;
  final String body;
  final String? image;
  final bool isRead;
  final DateTime time;
  final String id;

  const NotificationModel({
    required this.title,
    required this.body,
    this.image,
    required this.isRead,
    required this.time,
    required this.id,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      title: json['title'],
      body: json['body'],
      image: json['image'],
      isRead: json['read'],
      time: (json['sentAt'] as Timestamp).toDate(),
      id: json['id'],
    );
  }
}

List<NotificationModel> dummyNotificationList = [
  NotificationModel(
    id: '1',
    title: 'Notification 1',
    body: 'This is the body of notification 1',
    image: 'https://via.placeholder.com/150',
    isRead: false,
    time: DateTime.now(),
  ),
  NotificationModel(
    id: '1',

    title: 'Notification 2',
    body: 'This is the body of notification 2',
    image: 'https://via.placeholder.com/150',
    isRead: true,
    time: DateTime.now(),
  ),
  NotificationModel(
    id: '1',

    title: 'Notification 2',
    body: 'This is the body of notification 2',
    image: 'https://via.placeholder.com/150',
    isRead: true,
    time: DateTime.now(),
  ),
  NotificationModel(
    id: '1',

    title: 'Notification 2',
    body: 'This is the body of notification 2',
    image: 'https://via.placeholder.com/150',
    isRead: true,
    time: DateTime.now(),
  ),
  NotificationModel(
    id: '1',

    title: 'Notification 2',
    body: 'This is the body of notification 2',
    image: 'https://via.placeholder.com/150',
    isRead: true,
    time: DateTime.now(),
  ),
  NotificationModel(
    id: '1',

    title: 'Notification 2',
    body: 'This is the body of notification 2',
    image: 'https://via.placeholder.com/150',
    isRead: true,
    time: DateTime.now(),
  ),
  NotificationModel(
    id: '1',

    title: 'Notification 2',
    body: 'This is the body of notification 2',
    image: 'https://via.placeholder.com/150',
    isRead: true,
    time: DateTime.now(),
  ),
  NotificationModel(
    id: '1',

    title: 'Notification 2',
    body: 'This is the body of notification 2',
    image: 'https://via.placeholder.com/150',
    isRead: true,
    time: DateTime.now(),
  ),
];
