import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utils/app_constants.dart';

abstract class ProfileLocaleDatasource {
Future<void> saveUserAddress(String address);
}


class ProfileLocaleDatasourceImpl implements ProfileLocaleDatasource {
  final SharedPreferences _sharedPreferences;

  ProfileLocaleDatasourceImpl({required SharedPreferences sharedPreferences}) : _sharedPreferences = sharedPreferences;

  @override
  Future<void> saveUserAddress(String address) async {
    await _sharedPreferences.setString(AppConstants.userAddressKey, address);
  }
}