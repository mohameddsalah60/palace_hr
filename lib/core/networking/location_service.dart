abstract class LocationService {
  Future<bool> checkLocationPermission();
  Future<Location> getCurrentPosition();
  Future<bool> checkUserIfInsideArea({required Location location});
}

class Location {
  final double latitude, longitude;

  Location({required this.latitude, required this.longitude});
}
