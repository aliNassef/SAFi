import 'package:geolocator/geolocator.dart';

abstract class GeolocatorWrapper {
  Future<bool> isLocationServiceEnabled();
  Future<LocationPermission> checkPermission();
  Future<LocationPermission> requestPermission();
  Future<Position> getCurrentPosition();
  Stream<Position> getPositionStream({
    LocationSettings? locationSettings,
  });
}

class GeolocatorImpl implements GeolocatorWrapper {
  @override
  Future<bool> isLocationServiceEnabled() {
    return Geolocator.isLocationServiceEnabled();
  }

  @override
  Future<LocationPermission> checkPermission() {
    return Geolocator.checkPermission();
  }

  @override
  Future<LocationPermission> requestPermission() {
    return Geolocator.requestPermission();
  }

  @override
  Future<Position> getCurrentPosition() {
    return Geolocator.getCurrentPosition();
  }

  @override
  Stream<Position> getPositionStream({LocationSettings? locationSettings}) {
    return Geolocator.getPositionStream(
      locationSettings: locationSettings,
    );
  }
}
 