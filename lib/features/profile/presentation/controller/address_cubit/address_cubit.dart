import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:safi/features/profile/data/repo/profile_repo.dart';

part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> with HydratedMixin {
  AddressCubit(this._profileRepo) : super(AddressInitial()) {
    hydrate();
    init();
  }
  final ProfileRepo _profileRepo;

  void init() {
    if (state is! GetUserAddress) {
      getAddress();
    }
  }

  Future<void> getAddress() async {
    emit(AddressLoading());
    final positionOrfailure = await _profileRepo.determinePosition();

    positionOrfailure.fold(
      (failure) => emit(AddressFailure(errorMessage: failure.errMessage)),
      (position) => emit(AddressSuccess(position: position)),
    );
  }

  void updateAddress(String address) {
    emit(GetUserAddress(address: address));
  }

  @override
  AddressState? fromJson(Map<String, dynamic> json) {
    if (json['address'] != null) {
      return GetUserAddress(address: json['address']);
    }
    return null;
  }

  @override
  Map<String, dynamic>? toJson(AddressState state) {
    if (state is GetUserAddress) {
      return {
        'address': state.address,
      };
    }
    return null;
  }
}
