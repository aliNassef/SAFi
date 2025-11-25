import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:safi/core/logging/app_logger.dart';
import 'package:safi/env/env.dart';

class StripeService {
  // ⚠️ SECURITY WARNING:
  // Never store your Secret Key in the app for production.
  // In a real app, you must move the `createPaymentIntent` logic to your backend (Node.js, Firebase, etc.).
  // We use it here purely for testing/demonstration purposes.
  static final String _stripeSecretKey = Env.stripeSecretKey;
  static final String _merchantDisplayName = 'SAFI';

  StripeService._();
  static final StripeService instance = StripeService._();

  /// Call this once in your main() function before runApp()
  Future<bool> makePayment({
    required String amount,
    required String currency,
  }) async {
    try {
      // 1. Create Payment Intent (Ideally, fetch this from your backend)
      final paymentIntent = await _createPaymentIntent(amount, currency);

      if (paymentIntent == null) return false;

      // 2. Initialize the Payment Sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent['client_secret'],
          merchantDisplayName: _merchantDisplayName,
          // billingDetails: const BillingDetails(name: 'Flutter Stripe'),
          // appearance: const PaymentSheetAppearance(primaryButtonColor: Colors.blue),
        ),
      );

      // 3. Display the Payment Sheet
      await _displayPaymentSheet();

      // If we reach here, payment was successful
      return true;
    } catch (e) {
      AppLogger.error(e.toString());
      rethrow; // Rethrow to let caller handle the error
    }
  }

  /// Displays the actual sheet to the user
  Future<void> _displayPaymentSheet() async {
    try {
      // This presents the sheet and waits for the result
      await Stripe.instance.presentPaymentSheet();

      AppLogger.info("✅ Payment Successful");
    } on StripeException catch (e) {
      AppLogger.error("❌ Stripe Error: $e");
      if (e.error.code == FailureCode.Canceled) {
        AppLogger.info("Payment Canceled");
        
        throw Exception("Payment was cancelled");
      }
      rethrow;
    } catch (e) {
      AppLogger.error("❌ General Error: $e");
      rethrow;
    }
  }

  /// ⚠️ MOVE THIS TO YOUR BACKEND IN PRODUCTION ⚠️
  /// Returns the Payment Intent JSON from Stripe
  Future<Map<String, dynamic>?> _createPaymentIntent(
    String amount,
    String currency,
  ) async {
    try {
      final dio = Dio();

      final body = {
        'amount': _calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card',
      };

      final response = await dio.post(
        'https://api.stripe.com/v1/payment_intents',
        data: body,
        options: Options(
          headers: {
            'Authorization': 'Bearer $_stripeSecretKey',
            'Content-Type': 'application/x-www-form-urlencoded',
          },
          // Dio handles content-type automatically if you use FormUrlEncodedContentType,
          // but Stripe specifically requires this header + form data body.
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      // Dio automatically decodes JSON responses into a Map or List
      return response.data;
    } on DioException catch (e) {
      AppLogger.error("❌ Dio Error: ${e.response?.data ?? e.message}");
      return null;
    } catch (err) {
      AppLogger.error("❌ Error creating payment intent: $err");
      return null;
    }
  }

  /// Converts the string amount to the smallest currency unit (cents/pence)
  String _calculateAmount(String amount) {
    // Basic calculation: Multiplies by 100.
    // Note: This logic varies by currency (e.g., JPY has no decimal).
    final calculated = (double.parse(amount) * 100).toInt();
    return calculated.toString();
  }
}
