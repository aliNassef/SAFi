import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:safi/features/subscribtion/data/models/subscribtion_model.dart';
import '../../features/orders/data/model/orders_model.dart';

class FirebaseStoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ---------- USERS ----------
  Future<void> createUser({
    required String userId,
    required String name,
    required String phone,
    String? email,
  }) async {
    await _firestore.collection('users').doc(userId).set({
      'name': name,
      'phone': phone,
      'email': email,
      'walletBalance': 0,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<DocumentSnapshot> getUser(String userId) async {
    return await _firestore.collection('users').doc(userId).get();
  }

  Future<void> updateWallet(String userId, int newBalance) async {
    await _firestore.collection('users').doc(userId).update({
      'walletBalance': newBalance,
    });

    await addTransaction(
      userId: userId,
      type: 'desposite',
      amount: newBalance,
      description: '',
    );
  }

  Future<void> incrementWalletBalance(String userId, num amount) async {
    // Get current balance
    final userDoc = await _firestore.collection('users').doc(userId).get();
    if (!userDoc.exists) throw Exception("User not found");

    final currentBalance = userDoc['walletBalance'] as num;
    final newBalance = currentBalance + amount;

    // Update wallet balance
    await _firestore.collection('users').doc(userId).update({
      'walletBalance': newBalance,
    });

    // Create transaction record
    await addTransaction(
      userId: userId,
      type: 'deposit',
      amount: amount.toInt(),
      description: 'Wallet deposit via Stripe',
    );
  }

  // ---------- SUBSCRIPTIONS ----------
  Future<void> addSubscription({
    required String id,
    required String name,
    required List<String> advantages,
    required int price,
    required int washesIncluded,
    int washesUsed = 0,
  }) async {
    await _firestore.collection('subscriptions').doc(id).set({
      'name': name,
      'price': price,
      'washesIncluded': washesIncluded,
      'advantages': advantages,
      'washesUsed': washesUsed,
      'active': true,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<QuerySnapshot> getAllSubscriptions() async {
    return await _firestore.collection('subscriptions').get();
  }

  Future<SubscribtionModel?> getUserPackage(String userId) async {
    final snapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('subscriptions')
        .where('active', isEqualTo: true)
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) return null;
    return SubscribtionModel.fromJson(snapshot.docs.first.data());
  }

  Future<void> useWash({
    required String userId,
    required String subscriptionId,
  }) async {
    final docRef = _firestore
        .collection('users')
        .doc(userId)
        .collection('subscriptions')
        .doc(subscriptionId);

    final doc = await docRef.get();
    if (!doc.exists) throw Exception("Subscription not found");

    final data = doc.data()!;
    final int washesUsed = data['washesUsed'];
    final int washesIncluded = data['washesIncluded'];

    final newWashesUsed = washesUsed + 1;

    final bool isActive = newWashesUsed < washesIncluded;

    await docRef.update({
      'washesUsed': newWashesUsed,
      'active': isActive,
    });
  }

  Future<void> subscribeUser({
    required String userId,
    required String name,
    required List<String> advantages,
    required int price,
    required int washesIncluded,
  }) async {
    try {
      final userDoc = await _firestore.collection('users').doc(userId).get();
      if (!userDoc.exists) throw Exception("User not found");

      final currentBalance = userDoc['walletBalance'] as int;

      if (currentBalance < price) {
        throw Exception("رصيد المحفظة غير كافي للاشتراك");
      }

      await updateWallet(userId, currentBalance - price);

      await addTransaction(
        userId: userId,
        type: 'subscription',
        amount: price,
        description: 'خصم للاشتراك في $name',
      );

      final docRef = _firestore
          .collection('users')
          .doc(userId)
          .collection('subscriptions')
          .doc();

      await docRef.set({
        'id': docRef.id,
        'name': name,
        'price': price,
        'advantages': advantages,
        'washesIncluded': washesIncluded,
        'washesUsed': 0,
        'active': true,
        'subscribedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      rethrow;
    }
  }

  // ---------- SERVICES ----------
  Future<void> addService({
    required String id,
    required String name,
    required int price,
    required String description,
    String? imageUrl, // optional
  }) async {
    await _firestore.collection('services').doc(id).set({
      'name': name,
      'price': price,
      'description': description,
      'imageUrl': imageUrl ?? '', // store empty string if no image
    });
  }

  Future<QuerySnapshot> getAllServices() async {
    return await _firestore.collection('services').get();
  }

  Future<List<Map<String, dynamic>>> getPrices(String serviceId) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('services')
          .doc(serviceId)
          .collection('prices')
          .get();

      // Map each price document to a map
      final prices = snapshot.docs.map((doc) {
        return {
          'item': doc['item'],
          'price': doc['price'],
          'img': doc['img'],
          "qty": doc['qty'],
          "id": doc['id'],
        };
      }).toList();

      return prices;
    } catch (e) {
      throw Exception(e);
    }
  }

  // ---------- ORDERS ----------
  Future<void> createOrder({required OrdersModel order}) async {
    await _firestore
        .collection('orders')
        .add(
          order.toJson(),
        );
  }

  Future<List<OrdersModel>> getUserOrders(String userId) async {
    final snapshot = await _firestore
        .collection('orders')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .get();

    return snapshot.docs
        .map((doc) => OrdersModel.fromJson(doc.data()))
        .toList();
  }

  Future<void> updateOrderStatus(String orderId, String status) async {
    await _firestore.collection('orders').doc(orderId).update({
      'status': status,
    });
  }

  // ---------- WALLET ----------
  Future<void> addTransaction({
    required String userId,
    required String type,
    required int amount,
    required String description,
  }) async {
    await _firestore.collection('wallet_transactions').add({
      'userId': userId,
      'type': type,
      'amount': amount,
      'description': description,
      'date': FieldValue.serverTimestamp(),
    });
  }

  Future<QuerySnapshot> getUserTransactions(
    String userId, [
    int? limit,
  ]) async {
    var query = _firestore
        .collection('wallet_transactions')
        .where('userId', isEqualTo: userId)
        .orderBy('date', descending: true);

    if (limit != null) {
      query = query.limit(limit);
    }

    return query.get();
  }

  // ---------- NOTIFICATIONS ----------
  Future<void> sendNotification({
    required String userId,
    required String title,
    required String body,
  }) async {
    await _firestore.collection('notifications').add({
      'userId': userId,
      'title': title,
      'body': body,
      'read': false,
      'sentAt': FieldValue.serverTimestamp(),
    });
  }

  Future<QuerySnapshot> getUserNotifications(String userId) async {
    return await _firestore
        .collection('notifications')
        .where('userId', isEqualTo: userId)
        .orderBy('sentAt', descending: true)
        .get();
  }

  Future<void> markAsRead(String notifId) async {
    await _firestore.collection('notifications').doc(notifId).update({
      'read': true,
    });
  }

  // ---------- SETTINGS ----------
  Future<DocumentSnapshot> getAppSettings() async {
    return await _firestore.collection('settings').doc('app').get();
  }

  Future<void> updatePaymentOptions(List<String> options) async {
    await _firestore.collection('settings').doc('app').update({
      'paymentOptions': options,
    });
  }
}
