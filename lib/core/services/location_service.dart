import 'package:geolocator/geolocator.dart';

import 'geolocator_service.dart';

abstract class LocationService {
  Future<bool> isServiceEnabled();
  Future<Position> determinePosition();
  Stream<Position> getPositionStream({
    LocationSettings? locationSettings,
  });
}

class LocationServiceImpl implements LocationService {
  final GeolocatorWrapper _geolocatorWrapper;

  LocationServiceImpl({GeolocatorWrapper? geolocatorWrapper})
    : _geolocatorWrapper = geolocatorWrapper ?? GeolocatorImpl();

  @override
  Future<bool> isServiceEnabled() async {
    return _geolocatorWrapper.isLocationServiceEnabled();
  }

  @override
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await _geolocatorWrapper.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('خدمات تحديد الموقع مُعطّلة. يرجى تفعيلها للمتابعة.');
    }
    permission = await _geolocatorWrapper.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await _geolocatorWrapper.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error(
          'تم رفض أذونات تحديد الموقع. يرجى منح الإذن في الإعدادات.',
        );
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'تم رفض أذونات تحديد الموقع بشكل دائم. لا يمكن طلبها مرة أخرى تلقائيًا، يجب التغيير يدوياً من الإعدادات.',
      );
    }

    return await _geolocatorWrapper.getCurrentPosition();
  }

  @override
  Stream<Position> getPositionStream({
    LocationSettings? locationSettings,
  }) {
    return _geolocatorWrapper.getPositionStream(
      locationSettings: locationSettings,
    );
  }
}
