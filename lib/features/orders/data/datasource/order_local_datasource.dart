import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utils/app_constants.dart';

abstract class OrderLocalDatasource {
  String? getUserAddress();
}

class OrderLocalDatasourceImpl implements OrderLocalDatasource {
  final SharedPreferences _preferences;

  OrderLocalDatasourceImpl({required SharedPreferences preferences})
    : _preferences = preferences;

  @override
  String? getUserAddress() {
    return _preferences.getString(AppConstants.userAddressKey);
  }
}
