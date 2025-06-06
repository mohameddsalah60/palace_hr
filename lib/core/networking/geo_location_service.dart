import 'package:geodesy/geodesy.dart';
import 'package:geolocator/geolocator.dart';
import 'package:palace_hr/core/errors/exceptions.dart';
import 'package:palace_hr/core/networking/location_service.dart';
import 'dart:developer' as log;
import '../helpers/is_english_locale_funcation.dart';

class GeoLocationService implements LocationService {
  bool get isEnglish => isEnglishLocale();

  @override
  Future<bool> checkLocationPermission() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw CustomException(
        message:
            isEnglish
                ? 'Location services are disabled. Please enable them from your device settings.'
                : 'خدمات الموقع غير مفعّلة. من فضلك فعّلها من إعدادات الجهاز.',
      );
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw CustomException(
          message:
              isEnglish
                  ? 'Location permission was denied. Please allow access to continue.'
                  : 'تم رفض إذن الموقع. من فضلك اسمح بالوصول علشان نكمّل.',
        );
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw CustomException(
        message:
            isEnglish
                ? 'Location permission is permanently denied. Please enable it from the app settings.'
                : 'تم رفض إذن الموقع بشكل دائم. من فضلك فعّل الإذن من إعدادات التطبيق.',
      );
    }

    return true;
  }

  @override
  Future<Location> getCurrentPosition() async {
    final hasPermission = await checkLocationPermission();

    if (!hasPermission) {
      throw CustomException(
        message:
            isEnglish
                ? 'Location access is required to register your attendance. Please enable location permissions.'
                : 'نحتاج إلى موقعك لتسجيل الحضور. من فضلك فعّل صلاحيات الموقع.',
      );
    }

    try {
      final position = await Geolocator.getCurrentPosition();
      return Location(
        latitude: position.latitude,
        longitude: position.longitude,
      );
    } catch (e) {
      throw CustomException(
        message:
            isEnglish
                ? 'Unable to fetch your location. Please try again.'
                : 'تعذّر الحصول على موقعك. حاول مرة أخرى.',
      );
    }
  }

  @override
  Future<bool> checkUserIfInsideArea({required Location location}) async {
    try {
      final userPoint = LatLng(location.latitude, location.longitude);

      const double minLat = 30.0440;
      const double maxLat = 30.0460;
      const double minLng = 31.2340;
      const double maxLng = 31.2370;

      bool isInside = isUserInsideRectangle(
        userLat: userPoint.latitude,
        userLng: userPoint.longitude,
        minLat: minLat,
        maxLat: maxLat,
        minLng: minLng,
        maxLng: maxLng,
      );

      if (isInside) {
        log.log("✅ User is inside the target area.");
      } else {
        log.log("❌ User is outside the target area.");
      }
      return isInside;
    } catch (e) {
      throw CustomException(
        message:
            isEnglish
                ? 'Error checking if inside area: ${e.toString()}'
                : 'خطأ في التحقق من الموقع: ${e.toString()}',
      );
    }
  }

  bool isUserInsideRectangle({
    required double userLat,
    required double userLng,
    required double minLat,
    required double maxLat,
    required double minLng,
    required double maxLng,
  }) {
    return userLat >= minLat &&
        userLat <= maxLat &&
        userLng >= minLng &&
        userLng <= maxLng;
  }
}
