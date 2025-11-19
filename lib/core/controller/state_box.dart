import 'package:equatable/equatable.dart';

enum StateType { intial, loading, success, failure }

class StateBox<T> extends Equatable {
  final StateType type;
  final String? errMessage;
  final T? data;

  const StateBox({
    required this.type,
    this.errMessage,
    this.data,
  });
  bool get isIntial => type == StateType.intial;
  bool get isLoading => type == StateType.loading;
  bool get isSuccess => type == StateType.success;
  bool get isFailure => type == StateType.failure;
  const StateBox.inital() : this(type: StateType.intial);
  const StateBox.loading() : this(type: StateType.loading);
  const StateBox.success({required T data})
    : this(type: StateType.success, data: data);
  const StateBox.failure({required String errMessage})
    : this(type: StateType.failure, errMessage: errMessage);

  @override
  List<Object?> get props => [type, data, errMessage];
}
