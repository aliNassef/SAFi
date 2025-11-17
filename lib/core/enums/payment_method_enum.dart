enum PaymentMethodEnum {
  cash,
  visa;

  String get value {
    switch (this) {
      case PaymentMethodEnum.cash:
        return 'Cash';
      case PaymentMethodEnum.visa:
        return 'Visa';
    }
  }
}
