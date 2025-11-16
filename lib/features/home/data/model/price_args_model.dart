import 'package:equatable/equatable.dart';
import 'pricies_service_model.dart';

class PriceArgsModel extends Equatable {
  final List<PriciesServiceModel>? data;
  final num? total;
  final String serviceId;

  const PriceArgsModel({
    this.data,
    this.total,
    required this.serviceId,
  });

  @override
  List<Object?> get props => [data, serviceId, total];
}
