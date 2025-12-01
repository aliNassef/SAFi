import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/helpers/image_picker_helper.dart';
import '../../../../home/data/model/pricies_service_model.dart';
import '../../../data/model/profile_request._model.dart';
import '../../../data/repo/profile_repo.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> with HydratedMixin {
  ProfileCubit(this._profileRepo, this._imagePickerHelper)
    : super(ProfileInitial()) {
    hydrate();
  }

  @override
  ProfileState? fromJson(Map<String, dynamic> json) {
    if (json['profile'] != null) {
      return UploadProfileDataSuccess(
        profile: ProfileRequestModel.fromJson(json['profile']),
      );
    }
    return null;
  }

  @override
  Map<String, dynamic>? toJson(ProfileState state) {
    if (state is UploadProfileDataSuccess) {
      return {
        'profile': state.profile.toJson(),
      };
    }
    return null;
  }

  final ImagePickerHelper _imagePickerHelper;
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

  void uploadProfileData(ProfileRequestModel profileRequestModel) async {
    emit(UploadProfileDataLoading());
    final result = await _profileRepo.uploadProfileData(profileRequestModel);
    result.fold(
      (failure) => emit(UploadProfileDataError(errMessage: failure.errMessage)),
      (success) => emit(
        UploadProfileDataSuccess(
          profile: profileRequestModel,
        ),
      ),
    );
  }

  void pickImage(ImageSource source) async {
    final image = await _imagePickerHelper.pickImage(source);
    emit(PickImageSuccess(image: image!));
  }
}
