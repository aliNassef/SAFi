enum PaymentMethodEnum {
  cash,
  wallet,
  package;

  String get value {
    switch (this) {
      case PaymentMethodEnum.cash:
        return 'Cash';
      case PaymentMethodEnum.wallet:
        return 'Wallet';
      case PaymentMethodEnum.package:
        return 'Package';
    }
  }
}
