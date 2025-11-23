import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:safi/core/logging/app_logger.dart';
import 'package:safi/core/translations/locale_keys.g.dart';
import 'package:safi/core/utils/app_dilagos.dart';

class PaypalView extends StatelessWidget {
  final double amount;
  final String currency;
  final String description;
  final String clientId;
  final String secretKey;

  const PaypalView({
    super.key,
    required this.amount,
    this.currency = "EGP",
    this.description = "Payment",
    required this.clientId,
    required this.secretKey,
  });

  static const String routeName = 'paypal_view';
  @override
  Widget build(BuildContext context) {
    return PaypalCheckoutView(
      sandboxMode: true,
      clientId: clientId,
      secretKey: secretKey,
      transactions: [
        {
          "amount": {
            "total": amount.toString(),
            "currency": currency,
            "details": {
              "subtotal": amount.toString(),
              "shipping": '0',
              "shipping_discount": 0,
            },
          },
          "description": description,
        },
      ],
      note: "Contact us for any questions on your order.",
      onSuccess: (Map params) async {
        Navigator.pop(context);
        AppLogger.debug("Payment successful: $params");
        AppDilagos.showToast(
          text: '${LocaleKeys.deposit.tr()} ${params['amount']}',
        );
      },
      onError: (error) {
        AppLogger.debug("Error: $error");
        AppLogger.debug('onError: $error');
        Navigator.pop(context);
        AppDilagos.showErrorMessage(context, errMessage: error.toString());
      },
      onCancel: () {
        Navigator.pop(context);
      },
    );
  }
}
