enum PaymentMethodEnum {
  cash,
  wallet;

  String get value {
    switch (this) {
      case PaymentMethodEnum.cash:
        return 'Cash';
      case PaymentMethodEnum.wallet:
        return 'Wallet';
    }
  }
}
