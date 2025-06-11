import 'package:palace_hr/core/networking/constants_database_path.dart';
import 'package:palace_hr/core/networking/database_service.dart';

class HomeUtils {
  static bool isSameDate(DateTime d1, DateTime d2) {
    return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
  }

  static bool validateShiftStart(DateTime d1) {
    DateTime now = DateTime.now();

    Duration difference = d1.difference(now);

    return difference.inMinutes <= 120;
  }

  static bool validateShiftNotExpired(DateTime shiftStart) {
    final now = DateTime.now();
    final diff = now.difference(shiftStart);
    return diff.inHours <= 9;
  }

  static String formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  static Future<Map<String, dynamic>?> getData({
    required DatabaseService databaseService,
    required String path,
    required String docId,
    required String subPath,
    required String subPathId,
  }) async {
    return await databaseService.getData(
      path: path,
      uId: docId,
      subPath: subPath,
      subPathId: subPathId,
    );
  }

  static Future<void> addData({
    required DatabaseService databaseService,
    required Map<String, dynamic> data,
    required String docId,
    required String subPath,
    required String subPathDocId,
  }) async {
    await databaseService.addData(
      data: data,
      path: ConstantsDatabasePath.getUserData,
      docId: docId,
      subPath: subPath,
      subPathDocId: subPathDocId,
    );
  }
}
