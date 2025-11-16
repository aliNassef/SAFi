import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import '../../../data/model/pricies_service_model.dart';
import '../../../data/repo/home_repo.dart';

part 'get_pricies_service_state.dart';

class GetPriciesServiceCubit extends Cubit<GetPriciesServiceState>
    with HydratedMixin {
  GetPriciesServiceCubit(this._homeRepo) : super(GetPriciesServiceInitial()) {
    hydrate();
  }

  final HomeRepo _homeRepo;

  Future<void> getPrices(
    String serviceId, {
    bool forceRefresh = false,
  }) async {
    final isSameSuccessState =
        state is GetPriciesServiceSuccess &&
        (state as GetPriciesServiceSuccess).serviceId == serviceId;

    if (!forceRefresh && isSameSuccessState) {
      return;
    }

    final previousState = isSameSuccessState
        ? state as GetPriciesServiceSuccess
        : null;

    emit(GetPriciesServiceLoading());

    final result = await _homeRepo.getPrices(serviceId);

    result.fold(
      (failure) {
        emit(GetPriciesServiceFailure(failure.errMessage));
      },
      (priciesFromApi) {
        final finalList = _mergePreviousQty(
          previousState,
          priciesFromApi,
          forceRefresh,
        );

        final total = _calcTotla(finalList);

        emit(GetPriciesServiceSuccess(finalList, total, serviceId));
      },
    );
  }

  List<PriciesServiceModel> _mergePreviousQty(
    GetPriciesServiceSuccess? previousState,
    List<PriciesServiceModel> apiList,
    bool forceRefresh,
  ) {
    if (previousState == null || forceRefresh) return apiList;

    return apiList.map((apiItem) {
      final oldItem = previousState.data.firstWhere(
        (e) => e.id == apiItem.id,
        orElse: () => apiItem,
      );

      return apiItem.copyWith(qty: oldItem.qty);
    }).toList();
  }

  num _calcTotla(List<PriciesServiceModel> pricies) {
    return pricies.fold<num>(0, (sum, item) => sum + item.totalPrice);
  }

  void increaseQty(String id) {
    if (state is! GetPriciesServiceSuccess) return;

    final currentState = state as GetPriciesServiceSuccess;

    final items = currentState.data;
    final List<PriciesServiceModel> updateItems = items.map((item) {
      if (item.id == id) {
        return item.copyWith(
          qty: item.qty + 1,
        );
      }
      return item;
    }).toList();
    final total = _calcTotla(updateItems);
    emit(GetPriciesServiceSuccess(updateItems, total, currentState.serviceId));
  }

  void decreaseQty(String id) {
    if (state is! GetPriciesServiceSuccess) return;

    final currentState = state as GetPriciesServiceSuccess;

    final items = currentState.data;
    final List<PriciesServiceModel> updateItems = items.map((item) {
      if (item.id == id && item.qty > 1) {
        return item.copyWith(qty: item.qty - 1);
      }
      return item;
    }).toList();
    final total = _calcTotla(updateItems);
    emit(GetPriciesServiceSuccess(updateItems, total, currentState.serviceId));
  }

  @override
  GetPriciesServiceState? fromJson(Map<String, dynamic> json) {
    try {
      final data = (json['data'] as List)
          .map((e) => PriciesServiceModel.fromJson(e))
          .toList();
      final total = json['totalPrice'] as num;
      final serviceId = json['serviceId'] as String;
      return GetPriciesServiceSuccess(data, total, serviceId);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(GetPriciesServiceState state) {
    if (state is GetPriciesServiceSuccess) {
      return {
        'data': state.data.map((e) => e.toJson()).toList(),
        'totalPrice': state.totalPrice,
        'serviceId': state.serviceId,
      };
    }
    return null;
  }
}
