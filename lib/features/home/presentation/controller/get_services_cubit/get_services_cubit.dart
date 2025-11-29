import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/model/price_args_model.dart';
import '../../../data/model/service_model.dart';
import '../../../data/repo/home_repo.dart';

part 'get_services_state.dart';

class GetServicesCubit extends Cubit<GetServicesState> {
  GetServicesCubit(this._homeRepo) : super(GetServicesInitial());

  final HomeRepo _homeRepo;
  PriceArgsModel? selectedPrice;
  List<ServiceModel> _services = [];
  String? selectedId;
  void getServices() async {
    emit(GetServicesLoading());
    final servicesOrfailure = await _homeRepo.getAllService();
    servicesOrfailure.fold(
      (failure) => emit(
        GetServicesFailure(errMessage: failure.errMessage),
      ),
      (services) {
        _services = services;
        emit(
          GetServicesSuccess(services: services),
        );
      },
    );
  }

  void selectService(String id) {
    selectedId = id;
    emit(
      GetServicesSuccess(
        services: _services,
        selectedId: selectedId,
      ),
    );
  }

  void setOrderDetails(PriceArgsModel prices) {
    selectedPrice = prices;
    emit(GetPriciesServiceSuccess(prices));
  }
}
