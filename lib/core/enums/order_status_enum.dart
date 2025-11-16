enum OrderStatusEnum {
  pendding,
  accepted,
  rejected,
  onTheWay;

  String get value {
    switch (this) {
      case OrderStatusEnum.pendding:
        return 'pendding';
      case OrderStatusEnum.accepted:
        return 'accepted';
      case OrderStatusEnum.rejected:
        return 'rejected';
      case OrderStatusEnum.onTheWay:
        return 'onTheWay';
    }
  }

  static OrderStatusEnum fromJson(String status) {
    switch (status) {
      case 'pendding':
        return OrderStatusEnum.pendding;
      case 'accepted':
        return OrderStatusEnum.accepted;
      case 'rejected':
        return OrderStatusEnum.rejected;
      case 'onTheWay':
        return OrderStatusEnum.onTheWay;
      default:
        return OrderStatusEnum.pendding;
    }
  }
}
