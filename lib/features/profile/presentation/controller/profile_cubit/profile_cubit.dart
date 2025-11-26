import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../home/data/model/pricies_service_model.dart';
import '../../../data/repo/profile_repo.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._profileRepo) : super(ProfileInitial());

  final ProfileRepo _profileRepo;

  void getAllServicePrices() async {
    emit(GetAllServicePricesLoading());
    final result = await _profileRepo.getAllServicePrices();
    result.fold(
      (failure) =>
          emit(GetAllServicePricesError(errMessage: failure.errMessage)),
      (prices) => emit(GetAllServicePricesSuccess(prices: prices)),
    );
  }
}
